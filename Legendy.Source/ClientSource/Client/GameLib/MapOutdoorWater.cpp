#include "StdAfx.h"
#include "../eterLib/StateManager.h"
#include "../eterLib/ResourceManager.h"

#include "MapOutdoor.h"
#include "TerrainPatch.h"

void CMapOutdoor::LoadWaterTexture()
{
	UnloadWaterTexture();
	char buf[256];
	for (int i = 0; i < 30; ++i)
	{
		sprintf(buf, "d:/ymir Work/special/water/%02d.dds", i+1);
		m_WaterInstances[i].SetImagePointer((CGraphicImage *) CResourceManager::Instance().GetResourcePointer(buf));
	}
}

void CMapOutdoor::UnloadWaterTexture()
{
	for (int i = 0; i < 30; ++i)
		m_WaterInstances[i].Destroy();
}

void CMapOutdoor::RenderWater()
{
	if (m_PatchVector.empty())
		return;

	if (!IsVisiblePart(PART_WATER))
		return;

	//////////////////////////////////////////////////////////////////////////
	// RenderState
	D3DXMATRIX matTexTransformWater;

	STATEMANAGER.SaveRenderState(D3DRS_ZWRITEENABLE, FALSE);
	STATEMANAGER.SaveRenderState(D3DRS_ALPHABLENDENABLE, TRUE);
	STATEMANAGER.SaveRenderState(D3DRS_CULLMODE, D3DCULL_NONE);
	STATEMANAGER.SaveRenderState(D3DRS_DIFFUSEMATERIALSOURCE, D3DMCS_COLOR1);
	STATEMANAGER.SaveRenderState(D3DRS_COLORVERTEX, TRUE);

	STATEMANAGER.SetTexture(0, m_WaterInstances[((ELTimer_GetMSec() / 70) % 30)].GetTexturePointer()->GetD3DTexture());

	D3DXMatrixScaling(&matTexTransformWater, m_fWaterTexCoordBase, -m_fWaterTexCoordBase, 0.0f);
	D3DXMatrixMultiply(&matTexTransformWater, &m_matViewInverse, &matTexTransformWater);

	STATEMANAGER.SaveTransform(D3DTS_TEXTURE0, &matTexTransformWater);
	STATEMANAGER.SaveVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE);

	STATEMANAGER.SaveTextureStageState(0, D3DTSS_TEXCOORDINDEX, D3DTSS_TCI_CAMERASPACEPOSITION);
	STATEMANAGER.SaveTextureStageState(0, D3DTSS_TEXTURETRANSFORMFLAGS, D3DTTFF_COUNT2);
	STATEMANAGER.SaveTextureStageState(0, D3DTSS_MINFILTER, D3DTEXF_LINEAR);
	STATEMANAGER.SaveTextureStageState(0, D3DTSS_MAGFILTER, D3DTEXF_LINEAR);
	STATEMANAGER.SaveTextureStageState(0, D3DTSS_MIPFILTER, D3DTEXF_LINEAR);
	STATEMANAGER.SaveTextureStageState(0, D3DTSS_ADDRESSU, D3DTADDRESS_WRAP);
	STATEMANAGER.SaveTextureStageState(0, D3DTSS_ADDRESSV, D3DTADDRESS_WRAP);

	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_SELECTARG1);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_DIFFUSE);
	STATEMANAGER.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1);


	STATEMANAGER.SetTexture(1,NULL);
	STATEMANAGER.SetTextureStageState(1, D3DTSS_COLOROP, D3DTOP_DISABLE);
	STATEMANAGER.SetTextureStageState(1, D3DTSS_ALPHAOP, D3DTOP_DISABLE);

	// RenderState
	//////////////////////////////////////////////////////////////////////////

	static float s_fWaterHeightCurrent = 0;
	static float s_fWaterHeightBegin = 0;
	static float s_fWaterHeightEnd = 0;
	static DWORD s_dwLastHeightChangeTime = CTimer::Instance().GetCurrentMillisecond();
	static DWORD s_dwBlendtime = 300;

	if ((CTimer::Instance().GetCurrentMillisecond() - s_dwLastHeightChangeTime) > s_dwBlendtime)
	{
		s_dwBlendtime = random_range(1000, 3000);

		if (s_fWaterHeightEnd == 0)
			s_fWaterHeightEnd = -random_range(0, 15);
		else
			s_fWaterHeightEnd = 0;

		s_fWaterHeightBegin = s_fWaterHeightCurrent;
		s_dwLastHeightChangeTime = CTimer::Instance().GetCurrentMillisecond();
	}

	s_fWaterHeightCurrent = s_fWaterHeightBegin + (s_fWaterHeightEnd - s_fWaterHeightBegin) * (float) ((CTimer::Instance().GetCurrentMillisecond() - s_dwLastHeightChangeTime) / (float) s_dwBlendtime);
	m_matWorldForCommonUse._43 = s_fWaterHeightCurrent;

	m_matWorldForCommonUse._41 = 0.0f;
	m_matWorldForCommonUse._42 = 0.0f;
	STATEMANAGER.SetTransform(D3DTS_WORLD, &m_matWorldForCommonUse);

	float fFogDistance = __GetFogDistance();

	std::vector<std::pair<float, long> >::iterator i;

	for(i = m_PatchVector.begin();i != m_PatchVector.end(); ++i)
	{
		if (i->first<fFogDistance)
			DrawWater(i->second);
	}

	STATEMANAGER.SetTexture(0, NULL);
	STATEMANAGER.SetRenderState(D3DRS_ALPHABLENDENABLE, FALSE);

	for(i = m_PatchVector.begin();i != m_PatchVector.end(); ++i)
	{
		if (i->first>=fFogDistance)
			DrawWater(i->second);
	}

	m_matWorldForCommonUse._43 = 0.0f;

	//////////////////////////////////////////////////////////////////////////
	// RenderState
	STATEMANAGER.RestoreVertexShader();
	STATEMANAGER.RestoreTransform(D3DTS_TEXTURE0);
	STATEMANAGER.RestoreTextureStageState(0, D3DTSS_MINFILTER);
	STATEMANAGER.RestoreTextureStageState(0, D3DTSS_MAGFILTER);
	STATEMANAGER.RestoreTextureStageState(0, D3DTSS_MIPFILTER);
	STATEMANAGER.RestoreTextureStageState(0, D3DTSS_ADDRESSU);
	STATEMANAGER.RestoreTextureStageState(0, D3DTSS_ADDRESSV);
	STATEMANAGER.RestoreTextureStageState(0, D3DTSS_TEXCOORDINDEX);
	STATEMANAGER.RestoreTextureStageState(0, D3DTSS_TEXTURETRANSFORMFLAGS);

	STATEMANAGER.RestoreRenderState(D3DRS_DIFFUSEMATERIALSOURCE);
	STATEMANAGER.RestoreRenderState(D3DRS_COLORVERTEX);
	STATEMANAGER.RestoreRenderState(D3DRS_ZWRITEENABLE);
	STATEMANAGER.RestoreRenderState(D3DRS_ALPHABLENDENABLE);
	STATEMANAGER.RestoreRenderState(D3DRS_CULLMODE);
}

void CMapOutdoor::DrawWater(long patchnum)
{
	assert(NULL!=m_pTerrainPatchProxyList);
	if (!m_pTerrainPatchProxyList)
		return;

	CTerrainPatchProxy& rkTerrainPatchProxy = m_pTerrainPatchProxyList[patchnum];

	if (!rkTerrainPatchProxy.isUsed())
		return;

	if (!rkTerrainPatchProxy.isWaterExists())
		return;

	CGraphicVertexBuffer* pkVB=rkTerrainPatchProxy.GetWaterVertexBufferPointer();
	if (!pkVB)
		return;

	if (!pkVB->GetD3DVertexBuffer())
		return;

	UINT uPriCount=rkTerrainPatchProxy.GetWaterFaceCount();
	if (!uPriCount)
		return;

	STATEMANAGER.SetStreamSource(0, pkVB->GetD3DVertexBuffer(), sizeof(SWaterVertex));
	STATEMANAGER.DrawPrimitive(D3DPT_TRIANGLELIST, 0, uPriCount);

	ms_faceCount += uPriCount;
}
