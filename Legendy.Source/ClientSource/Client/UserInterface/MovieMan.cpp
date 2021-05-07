#include "stdafx.h"
#include "MovieMan.h"
#include "PythonApplication.h"

// 2007-08-19, nuclei
// add following files to the [Project Settings-Linker-Input]
// DEBUG:	../dshow/strmbasd.lib ../dshow/dmoguids.lib ddraw.lib
// RELEASE:	../dshow/strmbase.lib ../dshow/dmoguids.lib ddraw.lib

// 2007-08-09, nuclei
// if one of following header files are missing,
// please install "Microsoft Platform SDK for Windows Server 2003 R2" or later
#include "ddraw.h"
#include "mmstream.h"
#include "amstream.h"
#include "ddstream.h"
#include "uuids.h"
#include "control.h"
#include "dmodshow.h"
#include "dmoreg.h"

#define LOGO_PMANG_FILE			"ymir.mpg"
#define LOGO_NW_FILE			"logoNW.mpg"
#define LOGO_EA_FILE			"logoEA.mpg"
#define LOGO_EA_ENGLISH_FILE	"logoEA_english.mpg"
#define LOGO_GAMEON				"gameonbi.mpg"	//for japan
#define LOGO_IAH_FILE			"logoIAH.mpg"
#define INTRO_FILE				"intro.mpg"
#define LEGAL_FILE_00			"legal00.mpg"
#define LEGAL_FILE_01			"legal01.mpg"
#define TUTORIAL_0				"TutorialMovie\\Tutorial0.mpg"
#define TUTORIAL_1				"TutorialMovie\\Tutorial1.mpg"
#define TUTORIAL_2				"TutorialMovie\\Tutorial2.mpg"

void CMovieMan::ClearToBlack()
{
	PAINTSTRUCT ps;
	HDC dc;

	//
	// Get the repaint DC and then fill the window with black.
	//
	HWND window =  CPythonApplication::Instance().GetWindowHandle();//CFFClientApp::GetInstance()->GetMainWindow();
	InvalidateRect( window, NULL, FALSE );
	dc = BeginPaint( window, &ps );

	PatBlt( dc, ps.rcPaint.left, ps.rcPaint.top, ps.rcPaint.right, ps.rcPaint.bottom, BLACKNESS);

	EndPaint( window, &ps );
}

void CMovieMan::FillRect( RECT& fillRect, DWORD fillColor )
{
	assert(m_pPrimarySurface);

	if (fillRect.bottom == fillRect.top || fillRect.left == fillRect.right)
	{
		return;
	}

	DDBLTFX colorFillBltFX;
	colorFillBltFX.dwSize = sizeof(DDBLTFX);
	colorFillBltFX.dwFillColor = fillColor;
	if (!m_usingRGB32 || FAILED(m_pPrimarySurface->Blt(&fillRect, NULL, NULL, DDBLT_WAIT | DDBLT_COLORFILL, &colorFillBltFX)))
	{
		GDIFillRect(fillRect, fillColor);
		return;
	}
}

inline void CMovieMan::GDIFillRect( RECT& fillRect, DWORD fillColor )
{
	HBRUSH fillBrush = CreateSolidBrush(
		RGB((fillColor >> 16) & 255, (fillColor >> 8) & 255, fillColor & 255)
		);

	HDC desktopDC = GetDC(0);
	::FillRect(desktopDC, &fillRect, fillBrush);
	ReleaseDC(0, desktopDC);

	DeleteObject(fillBrush);
}

//----------------------------------------------------------------------------------------------------
//
inline void CMovieMan::GDIBlt(IDirectDrawSurface *pSrcSurface, RECT *pDestRect)
{
	HDC surfaceDC;
	HDC desktopDC = GetDC(0);
	if (SUCCEEDED(pSrcSurface->GetDC(&surfaceDC)))
	{
		StretchBlt(desktopDC, pDestRect->left, pDestRect->top, pDestRect->right - pDestRect->left, pDestRect->bottom - pDestRect->top,
			surfaceDC, 0, 0, m_movieWidth, m_movieHeight, SRCCOPY);
		pSrcSurface->ReleaseDC(surfaceDC);
	}
	ReleaseDC(0, desktopDC);
}

void CMovieMan::PlayLogo(const char *pcszName)
{
	PlayMovie(pcszName);
}

void CMovieMan::PlayIntro()
{
	PlayMovie( INTRO_FILE, MOVIEMAN_SKIPPABLE_YES, MOVIEMAN_POSTEFFECT_FADEOUT, 0xFFFFFF );
}

BOOL CMovieMan::PlayTutorial(LONG nIdx)
{
	BOOL bRet = FALSE;
	ClearToBlack();
	switch( nIdx ) {
		case 0:
			bRet = PlayMovie( TUTORIAL_0, MOVIEMAN_SKIPPABLE_YES, MOVIEMAN_POSTEFFECT_FADEOUT, 0xFFFFFF );
			return bRet;
		case 1:
			bRet = PlayMovie( TUTORIAL_1, MOVIEMAN_SKIPPABLE_YES, MOVIEMAN_POSTEFFECT_FADEOUT, 0xFFFFFF );
			return bRet;
		case 2:
			bRet = PlayMovie( TUTORIAL_2, MOVIEMAN_SKIPPABLE_YES, MOVIEMAN_POSTEFFECT_FADEOUT, 0xFFFFFF );
			return bRet;
	}
	return bRet;
}

BOOL CMovieMan::PlayMovie( const char *cpFileName, const bool bSkipAllowed, const int nPostEffectID, const DWORD dwPostEffectData )
{
	HWND hWnd = CPythonApplication::Instance().GetWindowHandle();

	IDirectDraw *pDD = NULL;
	DirectDrawCreate(NULL, &pDD, NULL);
	pDD->SetCooperativeLevel(hWnd, DDSCL_NORMAL);

	DDSURFACEDESC ddsd;
	ZeroMemory(&ddsd, sizeof(ddsd));
	ddsd.dwSize = sizeof(ddsd);
	ddsd.dwFlags = DDSD_CAPS;
	ddsd.ddsCaps.dwCaps = DDSCAPS_PRIMARYSURFACE;
	if (FAILED(pDD->CreateSurface(&ddsd, &m_pPrimarySurface, NULL)))
	{
		pDD->Release();
		return FALSE;
	}

	ZeroMemory(&ddsd, sizeof(ddsd));
	ddsd.dwSize = sizeof(ddsd);
	ddsd.dwFlags = DDSD_PIXELFORMAT;
	m_pPrimarySurface->GetSurfaceDesc(&ddsd);
	ddsd.ddpfPixelFormat.dwSize = sizeof(ddsd.ddpfPixelFormat);
	m_usingRGB32 = (ddsd.ddpfPixelFormat.dwRGBBitCount == 32);

	IDirectDrawClipper *pDDClipper = NULL;
	HRESULT hr = pDD->CreateClipper(0, &pDDClipper, NULL);
	if (SUCCEEDED(hr))
	{
		pDDClipper->SetHWnd(0, hWnd);
		m_pPrimarySurface->SetClipper(pDDClipper);
	}

	IMultiMediaStream *pMMStream = NULL;
	hr = RenderFileToMMStream(cpFileName, &pMMStream, pDD);
	if (SUCCEEDED(hr))
	{
		IMediaStream *pPrimaryVidStream = NULL;
		HRESULT hr = pMMStream->GetMediaStream(MSPID_PrimaryVideo, &pPrimaryVidStream);
		if (SUCCEEDED(hr))
		{
			IDirectDrawMediaStream *pDDStream = NULL;
			pPrimaryVidStream->QueryInterface(IID_IDirectDrawMediaStream, (void **) &pDDStream);
			pPrimaryVidStream->Release();

			ddsd.dwSize = sizeof(ddsd);
			hr = pDDStream->GetFormat(&ddsd, NULL, NULL, NULL);
			if (SUCCEEDED(hr))
			{
				m_movieWidth = ddsd.dwWidth;
				m_movieHeight = ddsd.dwHeight;

				DDSURFACEDESC ddsdBackSurface;
				ZeroMemory(&ddsdBackSurface, sizeof(ddsdBackSurface));
				ddsdBackSurface.ddpfPixelFormat.dwSize = sizeof(ddsdBackSurface.ddpfPixelFormat);
				ddsdBackSurface.ddpfPixelFormat.dwFlags = DDPF_RGB;
				ddsdBackSurface.ddpfPixelFormat.dwRGBBitCount = 32;
				ddsdBackSurface.ddpfPixelFormat.dwRBitMask = 255 << 16;
				ddsdBackSurface.ddpfPixelFormat.dwGBitMask = 255 << 8;
				ddsdBackSurface.ddpfPixelFormat.dwBBitMask = 255;
				ddsdBackSurface.dwSize = sizeof(ddsdBackSurface);
				ddsdBackSurface.dwFlags = DDSD_CAPS | DDSD_HEIGHT | DDSD_WIDTH | DDSD_PIXELFORMAT;
				ddsdBackSurface.ddsCaps.dwCaps = DDSCAPS_OFFSCREENPLAIN | DDSCAPS_SYSTEMMEMORY;
				ddsdBackSurface.dwHeight = m_movieHeight;
				ddsdBackSurface.dwWidth = m_movieWidth;

				IDirectDrawSurface *pSurface;
				hr = pDD->CreateSurface(&ddsdBackSurface, &pSurface, NULL);
				if (SUCCEEDED(hr))
				{
					RenderStreamToSurface(pSurface, pDDStream, pMMStream, bSkipAllowed, nPostEffectID, dwPostEffectData);
					pSurface->Release();
				}
			}
			pDDStream->Release();
		}
		pMMStream->Release();
	}

	m_pPrimarySurface->Release();
	m_pPrimarySurface = NULL;

	if (m_pBasicAudio)
	{
		m_pBasicAudio->Release();
		m_pBasicAudio = NULL;
	}

	if (pDDClipper)
	{
		pDDClipper->Release();
		pDDClipper = NULL;
	}

	pDD->Release();

	MSG msg;
	while (PeekMessage(&msg, hWnd, WM_KEYFIRST, WM_KEYLAST, PM_REMOVE));
	while (PeekMessage(&msg, hWnd, WM_MOUSEFIRST, WM_MOUSELAST, PM_REMOVE));

	return SUCCEEDED(hr);
}

//----------------------------------------------------------------------------------------------------
//
void CMovieMan::GetWindowRect(RECT& windowRect)
{
	HWND hWnd = CPythonApplication::Instance().GetWindowHandle();
	POINT p;

	//
	// Get the position of the upper-left client coordinate (in screen space).
	//
	p.x = 0;
	p.y = 0;
	ClientToScreen( hWnd, &p );

	//
	// Get the client rectangle of the window.
	//
	GetClientRect( hWnd, &windowRect );

	OffsetRect( &windowRect, p.x, p.y );
}

//----------------------------------------------------------------------------------------------------
//
void CMovieMan::CalcMovieRect(int srcWidth, int srcHeight, RECT& movieRect)
{
	RECT windowRect;
	GetWindowRect(windowRect);

	int nMovieWidth, nMovieHeight;
	if (srcWidth >= srcHeight)
	{
		nMovieWidth = (windowRect.right - windowRect.left);
		nMovieHeight =  srcHeight * nMovieWidth / srcWidth;
		if( nMovieHeight > windowRect.bottom - windowRect.top )
			nMovieHeight = windowRect.bottom - windowRect.top;
	}
	else
	{
		nMovieHeight = (windowRect.bottom - windowRect.top);
		nMovieWidth =  srcWidth * nMovieHeight / srcHeight;
		if( nMovieWidth > windowRect.right - windowRect.left )
			nMovieWidth = windowRect.right - windowRect.left;
	}
	movieRect.left = windowRect.left + ((windowRect.right - windowRect.left) - nMovieWidth) / 2;
	movieRect.top = windowRect.top + ((windowRect.bottom - windowRect.top) - nMovieHeight) / 2;
	movieRect.right = movieRect.left + nMovieWidth;
	movieRect.bottom = movieRect.top + nMovieHeight;
}

//----------------------------------------------------------------------------------------------------
//
void CMovieMan::CalcBackgroundRect(const RECT& movieRect, RECT& upperRect, RECT& lowerRect)
{
	RECT windowRect;
	GetWindowRect(windowRect);

	if (m_movieWidth > m_movieHeight)
	{
		SetRect(&upperRect, windowRect.left, windowRect.top, windowRect.right, movieRect.top);
		SetRect(&lowerRect, windowRect.left, movieRect.bottom, windowRect.right, windowRect.bottom);
	}
	else
	{
		SetRect(&upperRect, windowRect.left, windowRect.top, movieRect.left, windowRect.bottom);
		SetRect(&lowerRect, movieRect.right, windowRect.top, windowRect.right, windowRect.bottom);
	}
}

//----------------------------------------------------------------------------------------------------
//
HRESULT CMovieMan::RenderStreamToSurface(IDirectDrawSurface *pSurface, IDirectDrawMediaStream *pDDStream, IMultiMediaStream *pMMStream, bool bSkipAllowed, int nPostEffectID, DWORD dwPostEffectData)
{
	#define KEY_DOWN(vk)	(GetAsyncKeyState(vk) & 0x8000)

	IDirectDrawStreamSample *pSample = NULL;
	HRESULT hr = pDDStream->CreateSample(pSurface, NULL, 0, &pSample);
	if (SUCCEEDED(hr))
	{
		RECT movieRect;
		RECT upperRect, lowerRect;
		CalcMovieRect(m_movieWidth, m_movieHeight, movieRect);
		CalcBackgroundRect(movieRect, upperRect, lowerRect);
		FillRect(upperRect, 0);
		FillRect(lowerRect, 0);

		pMMStream->SetState(STREAMSTATE_RUN);
		while (pSample->Update(0, NULL, NULL, NULL) == S_OK)
		{
			CalcMovieRect(m_movieWidth, m_movieHeight, movieRect);
			if (FAILED(m_pPrimarySurface->Blt(&movieRect, pSurface, NULL, DDBLT_WAIT, NULL)))
			{
				GDIBlt(pSurface, &movieRect);
			}

			if (bSkipAllowed && (KEY_DOWN(VK_LBUTTON) || KEY_DOWN(VK_ESCAPE) || KEY_DOWN(VK_SPACE)))
			{
				break;
			}
		}

		switch(nPostEffectID)
		{
		case MOVIEMAN_POSTEFFECT_FADEOUT:
			RenderPostEffectFadeOut(pSurface, MOVIEMAN_FADE_DURATION, dwPostEffectData);
			break;
		}

		pMMStream->SetState(STREAMSTATE_STOP);
		pSample->Release();
	}

	return hr;
}

HRESULT CMovieMan::RenderFileToMMStream(const char *cpFilename, IMultiMediaStream **ppMMStream, IDirectDraw *pDD)
{
	IAMMultiMediaStream *pAMStream;
	HRESULT hr = CoCreateInstance(CLSID_AMMultiMediaStream, NULL, CLSCTX_INPROC_SERVER, IID_IAMMultiMediaStream, (void **) &pAMStream);
	if (FAILED(hr))
	{
		return hr;
	}

	WCHAR wPath[MAX_PATH + 1];
	MultiByteToWideChar(CP_ACP, 0, cpFilename, -1, wPath, MAX_PATH + 1);
	//
	WCHAR wsDir[MAX_PATH + 1];
	::memset(wsDir, 0, sizeof(wsDir));
	::GetCurrentDirectoryW( MAX_PATH, wsDir );
	::wcsncat( wsDir, L"\\", sizeof(WCHAR)*1 );
	::wcsncat( wsDir, wPath, sizeof(WCHAR)*::wcsnlen(wPath, MAX_PATH) );
	::memset(wPath, 0, sizeof(wPath));
	::wcsncpy( wPath, wsDir, sizeof(WCHAR)*::wcsnlen(wsDir, MAX_PATH) );
	//

	pAMStream->Initialize(STREAMTYPE_READ, AMMSF_NOGRAPHTHREAD, NULL);
	pAMStream->AddMediaStream(pDD, &MSPID_PrimaryVideo, 0, NULL);
	pAMStream->AddMediaStream(NULL, &MSPID_PrimaryAudio, AMMSF_ADDDEFAULTRENDERER, NULL);

	std::string ext;
	GetFileExtension(cpFilename, strlen(cpFilename), &ext);
	std::transform(ext.begin(), ext.end(), ext.begin(), ::tolower);
	if (ext == "mpg")
	{
		// 2007-08-01, nuclei
		hr = BuildFilterGraphManually(wPath, pAMStream, CLSID_MPEG1Splitter, CLSID_CMpegVideoCodec, CLSID_CMpegAudioCodec);
	}
	else if (ext == "mp43")
	{
		// 2007-08-12, nuclei
		hr = BuildFilterGraphManually(wPath, pAMStream, CLSID_AviSplitter, CLSID_MP4VideoCodec, CLSID_MP3AudioCodec);
	}
	else
	{
		hr = pAMStream->OpenFile(wPath, 0);
	}

	if (SUCCEEDED(hr))
	{
		pAMStream->QueryInterface(IID_IMultiMediaStream, (void**) ppMMStream);
	}

	pAMStream->Release();

	return hr;
}

//----------------------------------------------------------------------------------------------------
//
HRESULT CMovieMan::RenderPostEffectFadeOut(IDirectDrawSurface *pSurface, int fadeOutDuration, DWORD fadeOutColor)
{
	DDSURFACEDESC lockedSurfaceDesc;

	int *pCopiedSrcSurBuf = NULL;
	LONG fadeBegin = GetTickCount();
	float fadeProgress = 0.0;
	while ((fadeProgress = ((float)((LONG)GetTickCount()) - fadeBegin) / fadeOutDuration) < 1.0)
	{
		ZeroMemory(&lockedSurfaceDesc, sizeof(lockedSurfaceDesc));
		lockedSurfaceDesc.dwSize = sizeof(lockedSurfaceDesc);
		HRESULT hr = pSurface->Lock(NULL, &lockedSurfaceDesc, DDLOCK_WAIT | DDLOCK_NOSYSLOCK | DDLOCK_READONLY, NULL);
		if (FAILED(hr))
		{
			return hr;
		}

		if (!pCopiedSrcSurBuf)
		{
			if (!(pCopiedSrcSurBuf = (int*)malloc((LONG)lockedSurfaceDesc.lPitch * m_movieHeight)))
			{
				pSurface->Unlock(lockedSurfaceDesc.lpSurface);
				return E_OUTOFMEMORY;
			}
			CopyMemory(pCopiedSrcSurBuf, lockedSurfaceDesc.lpSurface, (LONG)lockedSurfaceDesc.lPitch * m_movieHeight);
		}

		int *pSrcSurfaceBuf = pCopiedSrcSurBuf;
		int *pDestSurfaceBuf = (int*)lockedSurfaceDesc.lpSurface;

		int fadeOutColorRed = (int)(((fadeOutColor >> 16) & 255) * fadeProgress);
		int fadeOutColorGreen = (int)(((fadeOutColor >> 8) & 255) * fadeProgress);
		int fadeOutColorBlue = (int)((fadeOutColor & 255) * fadeProgress);
		for(int y = 0; y < m_movieHeight; ++y)
		{
			for(int x = 0; x < m_movieWidth; ++x)
			{
				DWORD srcPixel = *pSrcSurfaceBuf;
				*pDestSurfaceBuf = RGB(
					(srcPixel & 255) * (1 - fadeProgress) + fadeOutColorBlue,
					((srcPixel >> 8) & 255) * (1 - fadeProgress) + fadeOutColorGreen,
					((srcPixel >> 16) & 255) * (1 - fadeProgress) + fadeOutColorRed);
				pSrcSurfaceBuf++;
				pDestSurfaceBuf++;
			}
			pSrcSurfaceBuf += (lockedSurfaceDesc.lPitch / 4) - m_movieWidth;
			pDestSurfaceBuf += (lockedSurfaceDesc.lPitch / 4) - m_movieWidth;
		}
		pSurface->Unlock(lockedSurfaceDesc.lpSurface);

		RECT movieRect;
		CalcMovieRect(m_movieWidth, m_movieHeight, movieRect);
		if (FAILED(m_pPrimarySurface->Blt(&movieRect, pSurface, NULL, DDBLT_WAIT, NULL)))
		{
			GDIBlt(pSurface, &movieRect);
		}

		RECT upperRect, lowerRect;
		CalcBackgroundRect(movieRect, upperRect, lowerRect);
		FillRect(upperRect, (fadeOutColorRed << 16) | (fadeOutColorGreen << 8) | fadeOutColorBlue);
		FillRect(lowerRect, (fadeOutColorRed << 16) | (fadeOutColorGreen << 8) | fadeOutColorBlue);

		if (m_pBasicAudio)
		{
			m_pBasicAudio->put_Volume((long)(-10000 * fadeProgress));
		}
	}

	free(pCopiedSrcSurBuf);

	RECT windowRect;
	GetWindowRect(windowRect);
	FillRect(windowRect, fadeOutColor);

	return S_OK;
}

//----------------------------------------------------------------------------------------------------
//
HRESULT CMovieMan::BuildFilterGraphManually(
	WCHAR* wpFilename,
	IAMMultiMediaStream *pAMStream,
	const GUID FAR clsidSplitter,
	const GUID FAR clsidVideoCodec,
	const GUID FAR clsidAudioCodec)
{
	IGraphBuilder* pGraphBuilder = NULL;
	pAMStream->GetFilterGraph(&pGraphBuilder);

	assert(pGraphBuilder);

//#ifdef _DEBUG
//	DWORD dwRegister;
//	AddToRot(pGraphBuilder, &dwRegister);
//#endif

	IBaseFilter *pSourceFilter = NULL;
	IBaseFilter *pSplitterFilter = NULL;
	IBaseFilter *pVideoFilter = NULL;
	IBaseFilter *pAudioFilter = NULL;

	CoCreateInstance(clsidSplitter, NULL, CLSCTX_INPROC_SERVER, IID_IBaseFilter, (void **) &pSplitterFilter);
	CoCreateInstance(clsidVideoCodec, NULL, CLSCTX_INPROC_SERVER, IID_IBaseFilter, (void **) &pVideoFilter);
	CoCreateInstance(clsidAudioCodec, NULL, CLSCTX_INPROC_SERVER, IID_IBaseFilter, (void **) &pAudioFilter);

	if (!pVideoFilter && IsEqualGUID(clsidVideoCodec, CLSID_MP4VideoCodec))
	{
		// Create the DMO Wrapper filter.
		HRESULT hr = CoCreateInstance(CLSID_DMOWrapperFilter, NULL, CLSCTX_INPROC, IID_IBaseFilter, (void **)&pVideoFilter);
		if (SUCCEEDED(hr))
		{
			IDMOWrapperFilter *pWrap;
			hr = pVideoFilter->QueryInterface(IID_IDMOWrapperFilter, (void **)&pWrap);
			if (SUCCEEDED(hr))
			{
				hr = pWrap->Init(CLSID_MP43DMOCodec, DMOCATEGORY_VIDEO_DECODER);
				pWrap->Release();
			}
		}
	}

	pGraphBuilder->AddSourceFilter(wpFilename, L"Source Filter", &pSourceFilter);
	pGraphBuilder->AddFilter(pSplitterFilter, L"Splitter");
	pGraphBuilder->AddFilter(pVideoFilter, L"Video Decoder");
	pGraphBuilder->AddFilter(pAudioFilter, L"Audio Decoder");

	assert(m_pBasicAudio == NULL);
	pGraphBuilder->QueryInterface(IID_IBasicAudio, (void**) &m_pBasicAudio);

	// Connect "Source" -> "Splitter"
	IPin *pInPin = NULL;
	IPin *pOutPin = NULL;
	IPin *pSplitterVideoOutPin = NULL;
	IPin *pSplitterAudioOutPin = NULL;
	IEnumPins *pEnumPins = NULL;
	pSourceFilter->EnumPins(&pEnumPins);
	pEnumPins->Next(1, &pOutPin, NULL);
	pEnumPins->Release();
	pSplitterFilter->EnumPins(&pEnumPins);
	pEnumPins->Next(1, &pInPin, NULL);
	pEnumPins->Release();
	HRESULT hr = pGraphBuilder->Connect(pOutPin, pInPin);
	pInPin->Release();
	pOutPin->Release();
	if (SUCCEEDED(hr))
	{
		pSplitterFilter->EnumPins(&pEnumPins);
		PIN_INFO pinInfo;
		while( SUCCEEDED(pEnumPins->Next(1, &pInPin, NULL)) )
		{
			pInPin->QueryPinInfo(&pinInfo);
			pinInfo.pFilter->Release();
			if (pinInfo.dir == PINDIR_OUTPUT)
			{
				pSplitterVideoOutPin = pInPin;
				pEnumPins->Next(1, &pSplitterAudioOutPin, NULL);
				break;
			}
			pInPin->Release();
		}
		pEnumPins->Release();

		// Splitter -> Video/Audio codecs
		pVideoFilter->EnumPins(&pEnumPins);
		pEnumPins->Next(1, &pInPin, NULL);
		pEnumPins->Next(1, &pOutPin, NULL);
		pEnumPins->Release();
		hr = pGraphBuilder->Connect(pSplitterVideoOutPin, pInPin);
		if (SUCCEEDED(hr))
		{
			hr = pGraphBuilder->Render(pOutPin);
			pInPin->Release();
			pOutPin->Release();

			if (pSplitterAudioOutPin && pAudioFilter)
			{
				pAudioFilter->EnumPins(&pEnumPins);
				pEnumPins->Next(1, &pInPin, NULL);
				pEnumPins->Next(1, &pOutPin, NULL);
				pEnumPins->Release();
				pGraphBuilder->Connect(pSplitterAudioOutPin, pInPin);
				pGraphBuilder->Render(pOutPin);
				pInPin->Release();
				pOutPin->Release();
			}
		}
	}

//#ifdef _DEBUG
//	RemoveFromRot(dwRegister);
//#endif

	if (pSplitterVideoOutPin)
	{
		pSplitterVideoOutPin->Release();
	}
	if (pSplitterAudioOutPin)
	{
		pSplitterAudioOutPin->Release();
	}
	pVideoFilter->Release();
	if (pAudioFilter)
	{
		pAudioFilter->Release();
	}
	pSplitterFilter->Release();
	pSourceFilter->Release();
	pGraphBuilder->Release();

	return hr;
}

//#ifdef _DEBUG
//HRESULT	CMovieMan::AddToRot(IGraphBuilder* pGraphBuilder, DWORD *pdwRegister)
//{
//	assert(pGraphBuilder);
//
//	IMoniker *pMoniker;
//	IRunningObjectTable *pROT;
//	if (FAILED(GetRunningObjectTable(0, &pROT))) {
//		return E_FAIL;
//	}
//
//	ZString monikerName;
//	monikerName.Format(_T("FilterGraph %08x pid %08x"), (DWORD_PTR)pGraphBuilder, GetCurrentProcessId());
//	HRESULT hr = CreateItemMoniker(L"!", monikerName, &pMoniker);
//	if (SUCCEEDED(hr)) {
//		hr = pROT->Register(ROTFLAGS_REGISTRATIONKEEPSALIVE, pGraphBuilder,
//			pMoniker, pdwRegister);
//		pMoniker->Release();
//	}
//	pROT->Release();
//	return hr;
//}
//
//void CMovieMan::RemoveFromRot(DWORD pdwRegister)
//{
//	IRunningObjectTable *pROT;
//	if (SUCCEEDED(GetRunningObjectTable(0, &pROT))) {
//		pROT->Revoke(pdwRegister);
//		pROT->Release();
//	}
//}
//#endif
