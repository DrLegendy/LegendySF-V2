#pragma once

#include "EffectElementBase.h"

class CEffectElementBaseInstance
{
public:
	CEffectElementBaseInstance();
	virtual ~CEffectElementBaseInstance();

	void SetDataPointer(CEffectElementBase* pElement);

	void Initialize();
	void Destroy();

	void SetLocalMatrixPointer(const D3DXMATRIX* c_pMatrix);
	bool Update(float fElapsedTime);
	void Render();

	bool isActive();
	void SetActive();
	void SetDeactive();

protected:
	virtual void OnSetDataPointer(CEffectElementBase* pElement) = 0;

	virtual void OnInitialize() = 0;
	virtual void OnDestroy() = 0;

	virtual bool OnUpdate(float fElapsedTime) = 0;
	virtual void OnRender() = 0;

protected:
	const D3DXMATRIX* mc_pmatLocal;

	bool									m_isActive;

	float									m_fLocalTime;
	DWORD									m_dwStartTime;
	float									m_fElapsedTime;
	float									m_fRemainingTime;
	bool									m_bStart;

private:
	CEffectElementBase* m_pBase;

public:
	void SetParticleScale(float fParticleScale);
	void SetMeshScale(D3DXVECTOR3 rv3MeshScale);

protected:
	float m_fParticleScale;
	D3DXVECTOR3 m_v3MeshScale;
};