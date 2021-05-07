#pragma once

#include "../milesLib/Type.h"

#include "ParticleSystemData.h"
#include "EffectMesh.h"
#include "SimpleLightData.h"

class CEffectData
{
	public:
		typedef std::vector<CParticleSystemData*>	TParticleVector;
		typedef std::vector<CEffectMeshScript*>		TMeshVector;
		typedef std::vector<CLightData*>			TLightVector;

	public:
		CEffectData();
		virtual ~CEffectData();

		void							Clear();
		bool							LoadScript(const char * c_szFileName);
		bool							LoadSoundScriptData(const char * c_szFileName);

		DWORD							GetParticleCount();
		CParticleSystemData *			GetParticlePointer(DWORD dwPosition);

		DWORD							GetMeshCount();
		CEffectMeshScript *				GetMeshPointer(DWORD dwPosition);

		DWORD							GetLightCount();
		CLightData *					GetLightPointer(DWORD dwPosition);

		NSound::TSoundInstanceVector *	GetSoundInstanceVector();

		float							GetBoundingSphereRadius();
		D3DXVECTOR3						GetBoundingSpherePosition();

		const char *					GetFileName() const;

	protected:
		void __ClearParticleDataVector();
		void __ClearLightDataVector();
		void __ClearMeshDataVector();

		virtual CParticleSystemData *	AllocParticle();
		virtual CEffectMeshScript *		AllocMesh();
		virtual CLightData *			AllocLight();

	protected:
		TParticleVector					m_ParticleVector;
		TMeshVector						m_MeshVector;
		TLightVector					m_LightVector;
		NSound::TSoundInstanceVector	m_SoundInstanceVector;

		float							m_fBoundingSphereRadius;
		D3DXVECTOR3						m_v3BoundingSpherePosition;

		std::string						m_strFileName;

	public:
		static void DestroySystem();

		static CEffectData* New();
		static void Delete(CEffectData* pkData);

		static CDynamicPool<CEffectData> ms_kPool;
};