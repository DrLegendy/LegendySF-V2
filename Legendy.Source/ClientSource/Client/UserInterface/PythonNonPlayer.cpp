#include "stdafx.h"
#include "../eterPack/EterPackManager.h"
#include "pythonnonplayer.h"
#include "InstanceBase.h"
#include "PythonCharacterManager.h"

bool CPythonNonPlayer::LoadNonPlayerData(const char * c_szFileName)
{
	static DWORD s_adwMobProtoKey[4] =
	{
		4813894,
		18955,
		552631,
		6822045
	};

	CMappedFile file;
	LPCVOID pvData;

	Tracef("CPythonNonPlayer::LoadNonPlayerData: %s, sizeof(TMobTable)=%u\n", c_szFileName, sizeof(TMobTable));

	if (!CEterPackManager::Instance().Get(file, c_szFileName, &pvData))
		return false;

	DWORD dwFourCC, dwElements, dwDataSize;

	file.Read(&dwFourCC, sizeof(DWORD));

	if (dwFourCC != MAKEFOURCC('M', 'M', 'P', 'T'))
	{
		TraceError("CPythonNonPlayer::LoadNonPlayerData: invalid Mob proto type %s", c_szFileName);
		return false;
	}

	file.Read(&dwElements, sizeof(DWORD));
	file.Read(&dwDataSize, sizeof(DWORD));

	BYTE * pbData = new BYTE[dwDataSize];
	file.Read(pbData, dwDataSize);
	/////

	CLZObject zObj;

	if (!CLZO::Instance().Decompress(zObj, pbData, s_adwMobProtoKey))
	{
		delete [] pbData;
		return false;
	}

	DWORD structSize = zObj.GetSize() / dwElements;
	DWORD structDiff = zObj.GetSize() % dwElements;
#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
	if (structDiff!=0 && !CPythonNonPlayer::TMobTableAll::IsValidStruct(structSize))
#else
	if ((zObj.GetSize() % sizeof(TMobTable)) != 0)
#endif
	{
		TraceError("CPythonNonPlayer::LoadNonPlayerData: invalid size %u check data format. structSize %u, structDiff %u", zObj.GetSize(), structSize, structDiff);
		return false;
	}

    for (DWORD i = 0; i < dwElements; ++i)
	{
#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
		CPythonNonPlayer::TMobTable t = {0};
		CPythonNonPlayer::TMobTableAll::Process(zObj.GetBuffer(), structSize, i, t);
#else
		CPythonNonPlayer::TMobTable & t = *((CPythonNonPlayer::TMobTable *) zObj.GetBuffer() + i);
#endif
		TMobTable * pTable = &t;

		TMobTable * pNonPlayerData = new TMobTable;
		memcpy(pNonPlayerData, pTable, sizeof(TMobTable));

		//TraceError("%d : %s type[%d] color[%d]", pNonPlayerData->dwVnum, pNonPlayerData->szLocaleName, pNonPlayerData->bType, pNonPlayerData->dwMonsterColor);
		m_NonPlayerDataMap.insert(TNonPlayerDataMap::value_type(pNonPlayerData->dwVnum, pNonPlayerData));
	}

	delete [] pbData;
	return true;
}

bool CPythonNonPlayer::GetName(DWORD dwVnum, const char ** c_pszName)
{
	const TMobTable * p = GetTable(dwVnum);

	if (!p)
		return false;

	*c_pszName = p->szLocaleName;

	return true;
}

bool CPythonNonPlayer::GetInstanceType(DWORD dwVnum, BYTE* pbType)
{
	const TMobTable * p = GetTable(dwVnum);

	if (!p)
		return false;

	*pbType=p->bType;

	return true;
}

const CPythonNonPlayer::TMobTable * CPythonNonPlayer::GetTable(DWORD dwVnum)
{
	TNonPlayerDataMap::iterator itor = m_NonPlayerDataMap.find(dwVnum);

	if (itor == m_NonPlayerDataMap.end())
		return NULL;

	return itor->second;
}

BYTE CPythonNonPlayer::GetEventType(DWORD dwVnum)
{
	const TMobTable * p = GetTable(dwVnum);

	if (!p)
	{
		//Tracef("CPythonNonPlayer::GetEventType - Failed to find virtual number\n");
		return ON_CLICK_EVENT_NONE;
	}

	return p->bOnClickType;
}

#if defined(WJ_SHOW_MOB_INFO) && defined(ENABLE_SHOW_MOBLEVEL)
DWORD CPythonNonPlayer::GetMonsterLevel(DWORD dwVnum)
{
	const CPythonNonPlayer::TMobTable * c_pTable = GetTable(dwVnum);
	if (!c_pTable)
		return 0;

	return c_pTable->bLevel;
}
#endif

#if defined(WJ_SHOW_MOB_INFO) && defined(ENABLE_SHOW_MOBAIFLAG)
bool CPythonNonPlayer::IsAggressive(DWORD dwVnum)
{
	const CPythonNonPlayer::TMobTable * c_pTable = GetTable(dwVnum);
	if (!c_pTable)
		return 0;

	return (IS_SET(c_pTable->dwAIFlag, AIFLAG_AGGRESSIVE));
}
#endif

BYTE CPythonNonPlayer::GetEventTypeByVID(DWORD dwVID)
{
	CInstanceBase * pInstance = CPythonCharacterManager::Instance().GetInstancePtr(dwVID);

	if (NULL == pInstance)
	{
		//Tracef("CPythonNonPlayer::GetEventTypeByVID - There is no Virtual Number\n");
		return ON_CLICK_EVENT_NONE;
	}

	WORD dwVnum = pInstance->GetVirtualNumber();
	return GetEventType(dwVnum);
}

const char*	CPythonNonPlayer::GetMonsterName(DWORD dwVnum)
{
	const CPythonNonPlayer::TMobTable * c_pTable = GetTable(dwVnum);
	if (!c_pTable)
	{
		static const char* sc_szEmpty="";
		return sc_szEmpty;
	}

	return c_pTable->szLocaleName;
}

DWORD CPythonNonPlayer::GetMonsterColor(DWORD dwVnum)
{
	const CPythonNonPlayer::TMobTable * c_pTable = GetTable(dwVnum);
	if (!c_pTable)
		return 0;

	return c_pTable->dwMonsterColor;
}

void CPythonNonPlayer::GetMatchableMobList(int iLevel, int iInterval, TMobTableList * pMobTableList)
{
/*
	pMobTableList->clear();

	TNonPlayerDataMap::iterator itor = m_NonPlayerDataMap.begin();
	for (; itor != m_NonPlayerDataMap.end(); ++itor)
	{
		TMobTable * pMobTable = itor->second;

		int iLowerLevelLimit = iLevel-iInterval;
		int iUpperLevelLimit = iLevel+iInterval;

		if ((pMobTable->abLevelRange[0] >= iLowerLevelLimit && pMobTable->abLevelRange[0] <= iUpperLevelLimit) ||
			(pMobTable->abLevelRange[1] >= iLowerLevelLimit && pMobTable->abLevelRange[1] <= iUpperLevelLimit))
		{
			pMobTableList->push_back(pMobTable);
		}
	}
*/
}

void CPythonNonPlayer::Clear()
{
}

void CPythonNonPlayer::Destroy()
{
	for (TNonPlayerDataMap::iterator itor=m_NonPlayerDataMap.begin(); itor!=m_NonPlayerDataMap.end(); ++itor)
	{
		delete itor->second;
	}
	m_NonPlayerDataMap.clear();
}

CPythonNonPlayer::CPythonNonPlayer()
{
	Clear();
}

CPythonNonPlayer::~CPythonNonPlayer(void)
{
	Destroy();
}