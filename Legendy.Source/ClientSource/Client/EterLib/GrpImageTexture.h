#pragma once

#include "GrpTexture.h"
#include "../eterImageLib/DXTCImage.h"

class CGraphicImageTexture : public CGraphicTexture
{
	public:
		CGraphicImageTexture();
		virtual ~CGraphicImageTexture();

		void		Destroy();

		bool		Create(UINT width, UINT height, D3DFORMAT d3dFmt, DWORD dwFilter = D3DX_FILTER_LINEAR);
		bool		CreateDeviceObjects();

		void		CreateFromTexturePointer(const CGraphicTexture* c_pSrcTexture);
		bool		CreateFromDiskFile(const char* c_szFileName, D3DFORMAT d3dFmt, DWORD dwFilter = D3DX_FILTER_LINEAR);
		bool		CreateFromMemoryFile(UINT bufSize, const void* c_pvBuf, D3DFORMAT d3dFmt, DWORD dwFilter = D3DX_FILTER_LINEAR);
		bool		CreateDDSTexture(CDXTCImage & image, const BYTE * c_pbBuf);

		void		SetFileName(const char * c_szFileName);

		bool		Lock(int* pRetPitch, void** ppRetPixels, int level=0);
		void		Unlock(int level=0);

	protected:
		void		Initialize();

		D3DFORMAT	m_d3dFmt;
		DWORD		m_dwFilter;

		std::string m_stFileName;
};
