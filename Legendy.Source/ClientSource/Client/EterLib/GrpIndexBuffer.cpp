#include "StdAfx.h"
#include "../eterBase/Stl.h"
#include "GrpIndexBuffer.h"
#include "StateManager.h"

LPDIRECT3DINDEXBUFFER8 CGraphicIndexBuffer::GetD3DIndexBuffer() const
{
	assert(m_lpd3dIdxBuf!=NULL);
	return m_lpd3dIdxBuf;
}

void CGraphicIndexBuffer::SetIndices(int startIndex) const
{
	assert(ms_lpd3dDevice!=NULL);
	STATEMANAGER.SetIndices(m_lpd3dIdxBuf, startIndex);
}


bool CGraphicIndexBuffer::Lock(void** pretIndices) const
{
	assert(m_lpd3dIdxBuf!=NULL);

	if (FAILED(m_lpd3dIdxBuf->Lock(0, 0, (BYTE**)pretIndices, 0)))
		return false;

	return true;
}

void CGraphicIndexBuffer::Unlock() const
{
	assert(m_lpd3dIdxBuf!=NULL);

	m_lpd3dIdxBuf->Unlock();
}

bool CGraphicIndexBuffer::Lock(void** pretIndices)
{
	assert(m_lpd3dIdxBuf!=NULL);

	if (FAILED(m_lpd3dIdxBuf->Lock(0, 0, (BYTE**)pretIndices, 0)))
		return false;

	return true;
}

void CGraphicIndexBuffer::Unlock()
{
	assert(m_lpd3dIdxBuf!=NULL);

	m_lpd3dIdxBuf->Unlock();
}

bool CGraphicIndexBuffer::Copy(int bufSize, const void* srcIndices)
{
	assert(m_lpd3dIdxBuf!=NULL);

	BYTE* dstIndices;
	if (FAILED(m_lpd3dIdxBuf->Lock(0, 0, &dstIndices, 0)))
		return false;

	memcpy(dstIndices, srcIndices, bufSize);

	m_lpd3dIdxBuf->Unlock();

	return true;
}

bool CGraphicIndexBuffer::Create(int faceCount, TFace* faces)
{
	int idxCount = faceCount * 3;
	m_iidxCount = idxCount;
	if (!Create(idxCount, D3DFMT_INDEX16))
		return false;

	WORD* dstIndices;
	if (FAILED(m_lpd3dIdxBuf->Lock(0, 0, (BYTE**)&dstIndices, 0)))
		return false;

	for (int i = 0; i<faceCount; ++i, dstIndices+=3)
	{
		TFace * curFace=faces+i;
		dstIndices[0]=curFace->indices[0];
		dstIndices[1]=curFace->indices[1];
		dstIndices[2]=curFace->indices[2];
	}

	m_lpd3dIdxBuf->Unlock();
	return true;
}

bool CGraphicIndexBuffer::CreateDeviceObjects()
{
	if (FAILED(ms_lpd3dDevice->CreateIndexBuffer(
		m_dwBufferSize,
		D3DUSAGE_WRITEONLY,
		m_d3dFmt,
		D3DPOOL_MANAGED,
		&m_lpd3dIdxBuf)
		))
		return false;

	return true;
}

void CGraphicIndexBuffer::DestroyDeviceObjects()
{
	safe_release(m_lpd3dIdxBuf);
}

bool CGraphicIndexBuffer::Create(int idxCount, D3DFORMAT d3dFmt)
{
	Destroy();

	m_iidxCount = idxCount;
	m_dwBufferSize = sizeof(WORD) * idxCount;
	m_d3dFmt = d3dFmt;

	return CreateDeviceObjects();
}

void CGraphicIndexBuffer::Destroy()
{
	DestroyDeviceObjects();
}

void CGraphicIndexBuffer::Initialize()
{
	m_lpd3dIdxBuf=NULL;
}

CGraphicIndexBuffer::CGraphicIndexBuffer()
{
	Initialize();
}

CGraphicIndexBuffer::~CGraphicIndexBuffer()
{
	Destroy();
}
