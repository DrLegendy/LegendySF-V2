#include "StdAfx.h"
#include "../eterLib/GrpMath.h"

#include "ActorInstance.h"

void CActorInstance::__InitializeCollisionData()
{
	m_canSkipCollision=false;
}

void CActorInstance::EnableSkipCollision()
{
	m_canSkipCollision=true;
}

void CActorInstance::DisableSkipCollision()
{
	m_canSkipCollision=false;
}

bool CActorInstance::CanSkipCollision()
{
	return m_canSkipCollision;
}

void CActorInstance::UpdatePointInstance()
{
	TCollisionPointInstanceListIterator itor;
	for (itor = m_DefendingPointInstanceList.begin(); itor != m_DefendingPointInstanceList.end(); ++itor)
		UpdatePointInstance(&(*itor));
}

void CActorInstance::UpdatePointInstance(TCollisionPointInstance * pPointInstance)
{
	if (!pPointInstance)
	{
		assert(!"CActorInstance::UpdatePointInstance - pPointInstance is NULL");
		return;
	}

	D3DXMATRIX matBone;

	if (pPointInstance->isAttached)
	{
		if (pPointInstance->dwModelIndex>=m_LODControllerVector.size())
		{
			//Tracenf("CActorInstance::UpdatePointInstance - rInstance.dwModelIndex=%d >= m_LODControllerVector.size()=%d",
			//		pPointInstance->dwModelIndex>m_LODControllerVector.size());
			return;
		}

		CGrannyLODController* pGrnLODController=m_LODControllerVector[pPointInstance->dwModelIndex];
		if (!pGrnLODController)
		{
			//Tracenf("CActorInstance::UpdatePointInstance - m_LODControllerVector[pPointInstance->dwModelIndex=%d] is NULL", pPointInstance->dwModelIndex);
			return;
		}

		CGrannyModelInstance * pModelInstance = pGrnLODController->GetModelInstance();
		if (!pModelInstance)
		{
			//Tracenf("CActorInstance::UpdatePointInstance - pGrnLODController->GetModelInstance() is NULL");
			return;
		}

		D3DXMATRIX * pmatBone = (D3DXMATRIX *)pModelInstance->GetBoneMatrixPointer(pPointInstance->dwBoneIndex);
		matBone = *(D3DXMATRIX *)pModelInstance->GetCompositeBoneMatrixPointer(pPointInstance->dwBoneIndex);
		matBone._41 = pmatBone->_41;
		matBone._42 = pmatBone->_42;
		matBone._43 = pmatBone->_43;
		matBone *= m_worldMatrix;
	}
	else
	{
		matBone = m_worldMatrix;
	}

	// Update Collsion Sphere
	CSphereCollisionInstanceVector::const_iterator sit = pPointInstance->c_pCollisionData->SphereDataVector.begin();
	CDynamicSphereInstanceVector::iterator dit=pPointInstance->SphereInstanceVector.begin();
	for (;sit!=pPointInstance->c_pCollisionData->SphereDataVector.end();++sit,++dit)
	{
		const TSphereData & c = sit->GetAttribute();//c_pCollisionData->SphereDataVector[j].GetAttribute();

		D3DXMATRIX matPoint;
		D3DXMatrixTranslation(&matPoint, c.v3Position.x, c.v3Position.y, c.v3Position.z);
		matPoint = matPoint * matBone;

		dit->v3LastPosition = dit->v3Position;
		dit->v3Position.x = matPoint._41;
		dit->v3Position.y = matPoint._42;
		dit->v3Position.z = matPoint._43;
	}
}

void CActorInstance::UpdateAdvancingPointInstance()
{
	D3DXVECTOR3 v3Movement = m_v3Movement;
	if (m_pkHorse)
		v3Movement = m_pkHorse->m_v3Movement;

	if (m_pkHorse)
		m_pkHorse->UpdateAdvancingPointInstance();

	D3DXMATRIX matPoint;
	D3DXMATRIX matCenter;

	TCollisionPointInstanceListIterator itor = m_BodyPointInstanceList.begin();
	for (; itor != m_BodyPointInstanceList.end(); ++itor)
	{
		TCollisionPointInstance & rInstance = *itor;

		if (rInstance.isAttached)
		{
			if (rInstance.dwModelIndex>=m_LODControllerVector.size())
			{
				Tracenf("CActorInstance::UpdateAdvancingPointInstance - rInstance.dwModelIndex=%d >= m_LODControllerVector.size()=%d",
					rInstance.dwModelIndex, m_LODControllerVector.size());
				continue;
			}

			CGrannyLODController* pGrnLODController=m_LODControllerVector[rInstance.dwModelIndex];
			if (!pGrnLODController)
			{
				Tracenf("CActorInstance::UpdateAdvancingPointInstance - m_LODControllerVector[rInstance.dwModelIndex=%d] is NULL", rInstance.dwModelIndex);
				continue;
			}

			CGrannyModelInstance * pModelInstance = pGrnLODController->GetModelInstance();
			if (!pModelInstance)
			{
				//Tracenf("CActorInstance::UpdateAdvancingPointInstance - pGrnLODController->GetModelInstance() is NULL");
				continue;
			}

			matCenter = *(D3DXMATRIX *)pModelInstance->GetBoneMatrixPointer(rInstance.dwBoneIndex);
			matCenter *= m_worldMatrix;
		}
		else
		{
			matCenter = m_worldMatrix;
		}

		// Update Collision Sphere
		const NRaceData::TCollisionData * c_pCollisionData = rInstance.c_pCollisionData;
		if (c_pCollisionData)
		{
			for (DWORD j = 0; j < c_pCollisionData->SphereDataVector.size(); ++j)
			{
				const TSphereData & c = c_pCollisionData->SphereDataVector[j].GetAttribute();
				CDynamicSphereInstance & rSphereInstance = rInstance.SphereInstanceVector[j];

				D3DXMatrixTranslation(&matPoint, c.v3Position.x, c.v3Position.y, c.v3Position.z);
				matPoint = matPoint * matCenter;

				rSphereInstance.v3LastPosition.x = matPoint._41;
				rSphereInstance.v3LastPosition.y = matPoint._42;
				rSphereInstance.v3LastPosition.z = matPoint._43;
				rSphereInstance.v3Position = rSphereInstance.v3LastPosition;
				rSphereInstance.v3Position += v3Movement;
			}
		}
	}
}

bool CActorInstance::CheckCollisionDetection(const CDynamicSphereInstanceVector * c_pAttackingSphereVector, D3DXVECTOR3 * pv3Position)
{
	if (!c_pAttackingSphereVector)
	{
		assert(!"CActorInstance::CheckCollisionDetection - c_pAttackingSphereVector is NULL");
		return false;
	}

	TCollisionPointInstanceListIterator itor;
	for (itor = m_DefendingPointInstanceList.begin(); itor != m_DefendingPointInstanceList.end(); ++itor)
	{
		const CDynamicSphereInstanceVector * c_pDefendingSphereVector = &(*itor).SphereInstanceVector;

		for (DWORD i = 0; i < c_pAttackingSphereVector->size(); ++i)
		for (DWORD j = 0; j < c_pDefendingSphereVector->size(); ++j)
		{
			const CDynamicSphereInstance & c_rAttackingSphere = c_pAttackingSphereVector->at(i);
			const CDynamicSphereInstance & c_rDefendingSphere = c_pDefendingSphereVector->at(j);

			if (DetectCollisionDynamicSphereVSDynamicSphere(c_rAttackingSphere, c_rDefendingSphere))
			{
				*pv3Position = (c_rAttackingSphere.v3Position + c_rDefendingSphere.v3Position) / 2.0f;
				return true;
			}
		}
	}

	return false;
}

bool CActorInstance::CreateCollisionInstancePiece(DWORD dwAttachingModelIndex, const NRaceData::TAttachingData * c_pAttachingData, TCollisionPointInstance * pPointInstance)
{
	if (!c_pAttachingData)
	{
		assert(!"CActorInstance::CreateCollisionInstancePiece - c_pAttachingData is NULL");
		return false;
	}

	if (!c_pAttachingData->pCollisionData)
	{
		assert(!"CActorInstance::CreateCollisionInstancePiece - c_pAttachingData->pCollisionData is NULL");
		return false;
	}

	if (!pPointInstance)
	{
		assert(!"CActorInstance::CreateCollisionInstancePiece - pPointInstance is NULL");
		return false;
	}

	pPointInstance->dwModelIndex = dwAttachingModelIndex;
	pPointInstance->isAttached = FALSE;
	pPointInstance->dwBoneIndex = 0;
	pPointInstance->c_pCollisionData = c_pAttachingData->pCollisionData;

	if (c_pAttachingData->isAttaching)
	{
		int iAttachingBoneIndex;

		CGrannyModelInstance * pModelInstance = m_LODControllerVector[dwAttachingModelIndex]->GetModelInstance();

		if (pModelInstance && pModelInstance->GetBoneIndexByName(c_pAttachingData->strAttachingBoneName.c_str(),
												&iAttachingBoneIndex))
		{
			pPointInstance->isAttached = TRUE;
			pPointInstance->dwBoneIndex = iAttachingBoneIndex;
		}
		else
		{
			//TraceError("CActorInstance::CreateCollisionInstancePiece: Cannot get matrix of bone %s ModelInstance 0x%p",	c_pAttachingData->strAttachingBoneName.c_str(), pModelInstance);
			pPointInstance->isAttached = TRUE;
			pPointInstance->dwBoneIndex = 0;
		}
	}


	const CSphereCollisionInstanceVector & c_rSphereDataVector = c_pAttachingData->pCollisionData->SphereDataVector;

	pPointInstance->SphereInstanceVector.clear();
	pPointInstance->SphereInstanceVector.reserve(c_rSphereDataVector.size());

	CSphereCollisionInstanceVector::const_iterator it;
	CDynamicSphereInstance dsi;

	dsi.v3LastPosition = D3DXVECTOR3(0.0f,0.0f,0.0f);
	dsi.v3Position = D3DXVECTOR3(0.0f,0.0f,0.0f);
	for (it = c_rSphereDataVector.begin(); it!=c_rSphereDataVector.end(); ++it)
	{
		const TSphereData & c_rSphereData = it->GetAttribute();
		dsi.fRadius = c_rSphereData.fRadius;
		pPointInstance->SphereInstanceVector.push_back(dsi);
	}

	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

BOOL CActorInstance::__SplashAttackProcess(CActorInstance & rVictim)
{
	D3DXVECTOR3 v3Distance(rVictim.m_x - m_x, rVictim.m_z - m_z, rVictim.m_z - m_z);
	float fDistance = D3DXVec3LengthSq(&v3Distance);
	if (fDistance >= 1000.0f*1000.0f)
		return FALSE;

	// Check Distance
	if (!__IsInSplashTime())
		return FALSE;

	const CRaceMotionData::TMotionAttackingEventData * c_pAttackingEvent = m_kSplashArea.c_pAttackingEvent;
	const NRaceData::TAttackData & c_rAttackData = c_pAttackingEvent->AttackData;
	THittedInstanceMap & rHittedInstanceMap = m_kSplashArea.HittedInstanceMap;

	if (rHittedInstanceMap.end() != rHittedInstanceMap.find(&rVictim))
	{
		return FALSE;
	}

	if (NRaceData::ATTACK_TYPE_SNIPE == c_rAttackData.iAttackType)
	{
		if (__IsFlyTargetPC())
			if (!__IsSameFlyTarget(&rVictim))
				return FALSE;


	}

	D3DXVECTOR3 v3HitPosition;
	if (rVictim.CheckCollisionDetection(&m_kSplashArea.SphereInstanceVector, &v3HitPosition))
	{
		rHittedInstanceMap.insert(make_pair(&rVictim, GetLocalTime()+c_rAttackData.fInvisibleTime));

		int iCurrentHitCount = rHittedInstanceMap.size();
		int iMaxHitCount = (0 == c_rAttackData.iHitLimitCount ? 16 : c_rAttackData.iHitLimitCount);
		//Tracef(" ------------------- Splash Hit : %d\n", iCurrentHitCount);

		if (iCurrentHitCount > iMaxHitCount)
		{
			//Tracef(" ------------------- OVER FLOW :: Splash Hit Count : %d\n", iCurrentHitCount);
			return FALSE;
		}

		NEW_SetAtkPixelPosition(NEW_GetCurPixelPositionRef());
		__ProcessDataAttackSuccess(c_rAttackData, rVictim, v3HitPosition, m_kSplashArea.uSkill, m_kSplashArea.isEnableHitProcess);
		return TRUE;
	}

	return FALSE;
}

BOOL CActorInstance::__NormalAttackProcess(CActorInstance & rVictim)
{
	// Check Distance
	D3DXVECTOR3 v3Distance(rVictim.m_x - m_x, rVictim.m_z - m_z, rVictim.m_z - m_z);
	float fDistance = D3DXVec3LengthSq(&v3Distance);

	extern bool IS_HUGE_RACE(unsigned int vnum);
	if (IS_HUGE_RACE(rVictim.GetRace()))
	{
		if (fDistance >= 500.0f*500.0f)
			return FALSE;
	}
	else
	{
		if (fDistance >= 300.0f*300.0f)
			return FALSE;
	}

	if (!isValidAttacking())
		return FALSE;

	const float c_fAttackRadius = 20.0f;
	const NRaceData::TMotionAttackData * pad = m_pkCurRaceMotionData->GetMotionAttackDataPointer();

	const float motiontime = GetAttackingElapsedTime();

	NRaceData::THitDataContainer::const_iterator itorHitData = pad->HitDataContainer.begin();
	for (; itorHitData != pad->HitDataContainer.end(); ++itorHitData)
	{
		const NRaceData::THitData & c_rHitData = *itorHitData;

		THitDataMap::iterator itHitData = m_HitDataMap.find(&c_rHitData);
		if (itHitData != m_HitDataMap.end())
		{
			THittedInstanceMap & rHittedInstanceMap = itHitData->second;

			THittedInstanceMap::iterator itInstance;
			if ((itInstance=rHittedInstanceMap.find(&rVictim)) != rHittedInstanceMap.end())
			{
				if (pad->iMotionType==NRaceData::MOTION_TYPE_COMBO || itInstance->second > GetLocalTime())
					continue;
			}
		}

		NRaceData::THitTimePositionMap::const_iterator range_start, range_end;
		range_start = c_rHitData.mapHitPosition.lower_bound(motiontime-CTimer::Instance().GetElapsedSecond());
		range_end = c_rHitData.mapHitPosition.upper_bound(motiontime);
		float c = cosf(D3DXToRadian(GetRotation()));
		float s = sinf(D3DXToRadian(GetRotation()));

		for(;range_start!=range_end;++range_start)
		{
			const CDynamicSphereInstance& dsiSrc=range_start->second;

			CDynamicSphereInstance dsi;
			dsi = dsiSrc;
			dsi.fRadius = c_fAttackRadius;
			{
				D3DXVECTOR3 v3SrcDir=dsiSrc.v3Position-dsiSrc.v3LastPosition;
				v3SrcDir*=__GetReachScale();

				const D3DXVECTOR3& v3Src = dsiSrc.v3LastPosition+v3SrcDir;
				D3DXVECTOR3& v3Dst = dsi.v3Position;
				v3Dst.x = v3Src.x * c - v3Src.y * s;
				v3Dst.y = v3Src.x * s + v3Src.y * c;
				v3Dst += GetPosition();
			}
			{
				const D3DXVECTOR3& v3Src = dsiSrc.v3LastPosition;
				D3DXVECTOR3& v3Dst = dsi.v3LastPosition;
				v3Dst.x = v3Src.x * c - v3Src.y * s;
				v3Dst.y = v3Src.x * s + v3Src.y * c;
				v3Dst += GetPosition();
			}


			TCollisionPointInstanceList::iterator cpit;
			for(cpit = rVictim.m_DefendingPointInstanceList.begin(); cpit!=rVictim.m_DefendingPointInstanceList.end();++cpit)
			{
				int index = 0;
				const CDynamicSphereInstanceVector & c_DefendingSphereVector = cpit->SphereInstanceVector;
				CDynamicSphereInstanceVector::const_iterator dsit;
				for(dsit = c_DefendingSphereVector.begin(); dsit!= c_DefendingSphereVector.end();++dsit, ++index)
				{
					const CDynamicSphereInstance& sub = *dsit;
					if (DetectCollisionDynamicZCylinderVSDynamicZCylinder(dsi, sub))
					{
						THitDataMap::iterator itHitData = m_HitDataMap.find(&c_rHitData);
						if (itHitData == m_HitDataMap.end())
						{
							THittedInstanceMap HittedInstanceMap;
							HittedInstanceMap.insert(make_pair(&rVictim, GetLocalTime()+pad->fInvisibleTime));
							//HittedInstanceMap.insert(make_pair(&rVictim, GetLocalTime()+HIT_COOL_TIME));
							m_HitDataMap.insert(make_pair(&c_rHitData, HittedInstanceMap));

							//Tracef(" ----------- First Hit\n");
						}
						else
						{
							itHitData->second.insert(make_pair(&rVictim, GetLocalTime()+pad->fInvisibleTime));
							//itHitData->second.insert(make_pair(&rVictim, GetLocalTime()+HIT_COOL_TIME));

							//Tracef(" ----------- Next Hit : %d\n", itHitData->second.size());

							int iCurrentHitCount = itHitData->second.size();
							if (NRaceData::MOTION_TYPE_COMBO == pad->iMotionType || NRaceData::MOTION_TYPE_NORMAL == pad->iMotionType)
							{
								if (iCurrentHitCount > 16)
								{
									//Tracef(" Type NORMAL :: Overflow - Can't process, skip\n");
									return FALSE;
								}
							}
							else
							{
								if (iCurrentHitCount > pad->iHitLimitCount)
								{
									//Tracef(" Type SKILL :: Overflow - Can't process, skip\n");
									return FALSE;
								}
							}
						}

						D3DXVECTOR3 v3HitPosition = (GetPosition() + rVictim.GetPosition()) *0.5f;

						extern bool IS_HUGE_RACE(unsigned int vnum);
						if (IS_HUGE_RACE(rVictim.GetRace()))
						{
							v3HitPosition = (GetPosition() + sub.v3Position) * 0.5f;
						}

						__ProcessDataAttackSuccess(*pad, rVictim, v3HitPosition, m_kCurMotNode.uSkill);
						return TRUE;
					}
				}
			}
		}
	}

	return FALSE;
}

BOOL CActorInstance::AttackingProcess(CActorInstance & rVictim)
{
	if (rVictim.__isInvisible())
		return FALSE;

	if (__SplashAttackProcess(rVictim))
		return TRUE;

	if (__NormalAttackProcess(rVictim))
		return TRUE;

	return FALSE;
}

BOOL CActorInstance::TestPhysicsBlendingCollision(CActorInstance & rVictim)
{
	if (rVictim.IsDead())
		return FALSE;

	TPixelPosition kPPosLast;
	GetBlendingPosition( &kPPosLast );

	D3DXVECTOR3 v3Distance = D3DXVECTOR3(rVictim.m_x - kPPosLast.x, rVictim.m_y - kPPosLast.y, rVictim.m_z - kPPosLast.z);
	float fDistance = D3DXVec3LengthSq(&v3Distance);
	if (fDistance > 800.0f*800.0f)
		return FALSE;

	TCollisionPointInstanceList * pMainList;
	TCollisionPointInstanceList * pVictimList;
	if (isAttacking() || IsWaiting())
	{
		pMainList = &m_DefendingPointInstanceList;
		pVictimList = &rVictim.m_DefendingPointInstanceList;
	}
	else
	{
		pMainList = &m_BodyPointInstanceList;
		pVictimList = &rVictim.m_BodyPointInstanceList;
	}

	TPixelPosition kPDelta;
	m_PhysicsObject.GetLastPosition(&kPDelta);

	D3DXVECTOR3 prevLastPosition, prevPosition;
	const int nSubCheckCount = 50;

	TCollisionPointInstanceListIterator itorMain = pMainList->begin();
	TCollisionPointInstanceListIterator itorVictim = pVictimList->begin();
	for (; itorMain != pMainList->end(); ++itorMain)
	{
		for (; itorVictim != pVictimList->end(); ++itorVictim)
		{
			CDynamicSphereInstanceVector & c_rMainSphereVector = (*itorMain).SphereInstanceVector;
			CDynamicSphereInstanceVector & c_rVictimSphereVector = (*itorVictim).SphereInstanceVector;

			for (DWORD i = 0; i < c_rMainSphereVector.size(); ++i)
			{
				CDynamicSphereInstance & c_rMainSphere = c_rMainSphereVector[i];
				//adjust main sphere center
				prevLastPosition = c_rMainSphere.v3LastPosition;
				prevPosition	 = c_rMainSphere.v3Position;

				c_rMainSphere.v3LastPosition = prevPosition;

				for( int i = 1; i <= nSubCheckCount; ++ i )
				{
					c_rMainSphere.v3Position = prevPosition + (float)(i/(float)nSubCheckCount) * kPDelta;

					for (DWORD j = 0; j < c_rVictimSphereVector.size(); ++j)
					{
						CDynamicSphereInstance & c_rVictimSphere = c_rVictimSphereVector[j];

						if (DetectCollisionDynamicSphereVSDynamicSphere(c_rMainSphere, c_rVictimSphere))
						{
							BOOL bResult = GetVector3Distance(c_rMainSphere.v3Position, c_rVictimSphere.v3Position) <= GetVector3Distance(c_rMainSphere.v3LastPosition, c_rVictimSphere.v3Position);

							c_rMainSphere.v3LastPosition = prevLastPosition;
							c_rMainSphere.v3Position	 = prevPosition;

							return bResult;
						}
					}
				}

				//restore
				c_rMainSphere.v3LastPosition = prevLastPosition;
				c_rMainSphere.v3Position	 = prevPosition;
			}
		}
	}

	return FALSE;
}

#define ENABLE_PETS_WITHOUT_COLLISIONS
#define ENABLE_SHOPS_WITHOUT_COLLISIONS
#define ENABLE_MOUNTS_WITHOUT_COLLISIONS
BOOL CActorInstance::TestActorCollision(CActorInstance & rVictim)
{
/*
	if (m_pkHorse)
	{
		if (m_pkHorse->TestActorCollision(rVictim))
			return TRUE;

		return FALSE;
	}
*/

	if (rVictim.IsDead())
		return FALSE;

#ifdef ENABLE_PETS_WITHOUT_COLLISIONS
	if (rVictim.GetRace()>=34001 && rVictim.GetRace()<=34099)
		return FALSE;
#endif

#ifdef ENABLE_SHOPS_WITHOUT_COLLISIONS
	if (rVictim.GetRace()>=30000 && rVictim.GetRace()<=30001)
		return FALSE;
#endif

#ifdef ENABLE_MOUNTS_WITHOUT_COLLISIONS
	if (rVictim.GetRace()>=20101 && rVictim.GetRace()<=20299)
		return FALSE;
#endif

	// Check Distance
	D3DXVECTOR3 v3Distance = D3DXVECTOR3(rVictim.m_x - m_x, rVictim.m_y - m_y, rVictim.m_z - m_z);
	float fDistance = D3DXVec3LengthSq(&v3Distance);
	if (fDistance > 800.0f*800.0f)
		return FALSE;

	TCollisionPointInstanceList * pMainList;
	TCollisionPointInstanceList * pVictimList;
	if (isAttacking() || IsWaiting())
	{
		pMainList = &m_DefendingPointInstanceList;
		pVictimList = &rVictim.m_DefendingPointInstanceList;
	}
	else
	{
		pMainList = &m_BodyPointInstanceList;
		pVictimList = &rVictim.m_BodyPointInstanceList;
	}

	TCollisionPointInstanceListIterator itorMain = pMainList->begin();
	TCollisionPointInstanceListIterator itorVictim = pVictimList->begin();
	for (; itorMain != pMainList->end(); ++itorMain)
	for (; itorVictim != pVictimList->end(); ++itorVictim)
	{
		const CDynamicSphereInstanceVector & c_rMainSphereVector = (*itorMain).SphereInstanceVector;
		const CDynamicSphereInstanceVector & c_rVictimSphereVector = (*itorVictim).SphereInstanceVector;

		for (DWORD i = 0; i < c_rMainSphereVector.size(); ++i)
		for (DWORD j = 0; j < c_rVictimSphereVector.size(); ++j)
		{
			const CDynamicSphereInstance & c_rMainSphere = c_rMainSphereVector[i];
			const CDynamicSphereInstance & c_rVictimSphere = c_rVictimSphereVector[j];

			if (DetectCollisionDynamicSphereVSDynamicSphere(c_rMainSphere, c_rVictimSphere))
			{
				if (GetVector3Distance(c_rMainSphere.v3Position, c_rVictimSphere.v3Position) <=
					GetVector3Distance(c_rMainSphere.v3LastPosition, c_rVictimSphere.v3Position))
				{
					return TRUE;
				}
				return FALSE;
			}
		}
	}

	return FALSE;
}

bool CActorInstance::AvoidObject(const CGraphicObjectInstance& c_rkBGObj)
{
#ifdef __MOVIE_MODE__
	if (IsMovieMode())
		return false;
#endif

	if (this==&c_rkBGObj)
		return false;

	if (!__TestObjectCollision(&c_rkBGObj))
		return false;

	__AdjustCollisionMovement(&c_rkBGObj);
	return true;
}

bool CActorInstance::IsBlockObject(const CGraphicObjectInstance& c_rkBGObj)
{
	if (this==&c_rkBGObj)
		return false;

	if (!__TestObjectCollision(&c_rkBGObj))
		return false;

	return true;
}

void CActorInstance::BlockMovement()
{
	if (m_pkHorse)
	{
		m_pkHorse->__InitializeMovement();
		return;
	}

	__InitializeMovement();
}

BOOL CActorInstance::__TestObjectCollision(const CGraphicObjectInstance * c_pObjectInstance)
{
	if (m_pkHorse)
	{
		if (m_pkHorse->__TestObjectCollision(c_pObjectInstance))
			return TRUE;

		return FALSE;
	}

	if (m_canSkipCollision)
		return FALSE;

	if (m_v3Movement.x == 0.0f && m_v3Movement.y == 0.0f && m_v3Movement.z == 0.0f)
		return FALSE;

	TCollisionPointInstanceListIterator itorMain = m_BodyPointInstanceList.begin();
	for (; itorMain != m_BodyPointInstanceList.end(); ++itorMain)
	{
		const CDynamicSphereInstanceVector & c_rMainSphereVector = (*itorMain).SphereInstanceVector;
		for (DWORD i = 0; i < c_rMainSphereVector.size(); ++i)
		{
			const CDynamicSphereInstance & c_rMainSphere = c_rMainSphereVector[i];

			if (c_pObjectInstance->MovementCollisionDynamicSphere(c_rMainSphere))
			{
				//const D3DXVECTOR3 & c_rv3Position = c_pObjectInstance->GetPosition();
				//if (GetVector3Distance(c_rMainSphere.v3Position, c_rv3Position) <
				//	GetVector3Distance(c_rMainSphere.v3LastPosition, c_rv3Position))
				{
					return TRUE;
				}

				//return FALSE;
			}
		}
	}

	return FALSE;
}


bool CActorInstance::TestCollisionWithDynamicSphere(const CDynamicSphereInstance & dsi)
{
	TCollisionPointInstanceListIterator itorMain = m_BodyPointInstanceList.begin();
	for (; itorMain != m_BodyPointInstanceList.end(); ++itorMain)
	{
		const CDynamicSphereInstanceVector & c_rMainSphereVector = (*itorMain).SphereInstanceVector;
		for (DWORD i = 0; i < c_rMainSphereVector.size(); ++i)
		{
			const CDynamicSphereInstance & c_rMainSphere = c_rMainSphereVector[i];

			if (DetectCollisionDynamicSphereVSDynamicSphere(c_rMainSphere, dsi))
			{
				return true;
			}
		}
	}

	return false;
}
