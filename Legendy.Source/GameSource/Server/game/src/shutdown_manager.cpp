#include "stdafx.h"
#include "../../libgame/include/grid.h"
#include "locale_service.h"
#include "config.h"
#include "desc.h"
#include "shutdown_manager.h"


CShutdownManager t = CShutdownManager();

CShutdownManager::CShutdownManager() : m_pTime(NULL), m_lTime(0), m_bShutdownAlarm(false)
{
	m_lstDesc.clear();
}

CShutdownManager::~CShutdownManager()
{
	m_lstDesc.clear();
}

void CShutdownManager::AddDesc(LPDESC pDesc)
{
	if(!CheckLocale() || pDesc == NULL || SearchDesc(pDesc) != -1) return;

	UpdateTime();

	const char* szSocialID = pDesc->GetAccountTable().social_id;
	if(CheckShutdownAge(szSocialID))
	{
		m_lstDesc.push_back(pDesc);
	}
}

void CShutdownManager::RemoveDesc(LPDESC pDesc)
{
	if(!CheckLocale() || pDesc == NULL) return;

	int nIndex = SearchDesc(pDesc);
	if(nIndex < 0) return;

	std::list<LPDESC>::iterator i = m_lstDesc.begin();
	while(nIndex) { nIndex--; i++; }

	m_lstDesc.erase(i);
}

void CShutdownManager::Update()
{
	if(!CheckLocale()) return;

	UpdateTime();

	if(!m_bShutdownAlarm)
	{
		if(m_pTime->tm_hour >= 23 && m_pTime->tm_min >= 50)
		{
			for(std::list<LPDESC>::iterator i = m_lstDesc.begin(); i != m_lstDesc.end(); i++)
			{
				if((*i) != NULL)
				{
					(*i)->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("셧다운제 시행으로 10분 뒤 종료됩니다."));
				}
			}

			m_bShutdownAlarm = true;
		}
	}

	if(CheckShutdownTime())	// Check Shutdown Time
	{
		for(std::list<LPDESC>::iterator i = m_lstDesc.begin(); i != m_lstDesc.end(); i++)
		{
			if((*i) != NULL)
			{
				printf("ShutdownManager::Update() - Shutdown Account : %s\n", (*i)->GetAccountTable().login);
				(*i)->SetPhase(PHASE_CLOSE);
			}
		}

		m_bShutdownAlarm = false;
		m_lstDesc.clear();
	}
}

int CShutdownManager::SearchDesc(LPDESC pDesc)
{
	if(!CheckLocale()) return -1;

	std::list<LPDESC>::iterator iter = m_lstDesc.begin();
	for(unsigned int i = 0; i < m_lstDesc.size(); i++)
	{
		if(*(iter) == pDesc) return i;
		iter++;
	}

	return -1;
}


bool CShutdownManager::CheckShutdownAge(const char* szSocialID)
{
	if(!CheckLocale() || !CheckCorrectSocialID(szSocialID)) return false;

	UpdateTime();

	int nAge = CharToInt(szSocialID[0]) * 10 + CharToInt(szSocialID[1]);

	if(CharToInt(szSocialID[6]) < 3)
	{
		nAge = m_pTime->tm_year - nAge;
	}
	else
	{
		nAge = m_pTime->tm_year - 100 - nAge;
	}

	if(nAge < gShutdownAge)
		return true;
	else
		return false;
}


bool CShutdownManager::CheckShutdownTime()
{
	if(!CheckLocale()) return false;

	UpdateTime();

	if(m_pTime->tm_hour < 6)
		return true;
	else
		return false;
}


bool CShutdownManager::CheckCorrectSocialID(const char* szSocialID)
{
	if(!CheckLocale()) return true;

	if(szSocialID == NULL || strlen(szSocialID) != 13) return false;

	UpdateTime();

	int nMonth = CharToInt(szSocialID[2]) * 10 + CharToInt(szSocialID[3]);
	int nDay = CharToInt(szSocialID[4]) * 10 + CharToInt(szSocialID[5]);
	int nGender = CharToInt(szSocialID[6]);

	if(nMonth > 12 || nMonth == 0)	return false;
	if(nDay > 31 || nDay == 0)		return false;
	if(nGender == 0)				return false;

	int nSum =
		CharToInt(szSocialID[0]) * 2
		+ CharToInt(szSocialID[1]) * 3
		+ CharToInt(szSocialID[2]) * 4
		+ CharToInt(szSocialID[3]) * 5
		+ CharToInt(szSocialID[4]) * 6
		+ CharToInt(szSocialID[5]) * 7
		+ CharToInt(szSocialID[6]) * 8
		+ CharToInt(szSocialID[7]) * 9
		+ CharToInt(szSocialID[8]) * 2
		+ CharToInt(szSocialID[9]) * 3
		+ CharToInt(szSocialID[10]) * 4
		+ CharToInt(szSocialID[11]) * 5;

	int nResult = 11 - (nSum % 11);
	if(nResult > 9) nResult -= 10;

	if(CharToInt(szSocialID[12]) != nResult) return false;

	return true;
}
