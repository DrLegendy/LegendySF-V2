#include "stdafx.h"
#include "config.h"
#include "constants.h"
#include "monarch.h"
#include "char.h"
#include "sectree_manager.h"
#include "desc_client.h"
#include "dev_log.h"

CMonarch::CMonarch()
{
	memset( &m_MonarchInfo, 0, sizeof(m_MonarchInfo) );

	Initialize();
}

CMonarch::~CMonarch()
{
}

bool CMonarch::Initialize()
{
	memset(m_PowerUp, 0, sizeof(m_PowerUp));
	memset(m_DefenseUp, 0, sizeof(m_DefenseUp));
	memset(m_PowerUpCT, 0, sizeof(m_PowerUpCT));
	memset(m_DefenseUpCT, 0, sizeof(m_DefenseUpCT));

	return 0;
}

struct FHealMyEmpire
{
	BYTE m_bEmpire;
	void operator () (LPENTITY ent)
	{
		if (ent->IsType(ENTITY_CHARACTER))
		{
			LPCHARACTER ch = (LPCHARACTER) ent;

			if (ch->IsPC() && m_bEmpire == ch->GetEmpire())
			{
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���ְ� ���� �ູ���� ��� �������� ���� ä�����ϴ�"));
				ch->PointChange(POINT_HP, ch->GetMaxHP() - ch->GetHP());
				ch->PointChange(POINT_SP, ch->GetMaxSP() - ch->GetSP());
				ch->EffectPacket(SE_SPUP_BLUE);
				ch->EffectPacket(SE_HPUP_RED);
			}
		}
	}
};

int CMonarch::HealMyEmpire(LPCHARACTER ch ,DWORD price)
{
	BYTE Empire = ch->GetEmpire();
	DWORD pid = ch->GetPlayerID();

	sys_log(0, "HealMyEmpire[%d] pid:%d price %d", pid, Empire, price);

	if (IsMonarch(pid, Empire) == 0)
	{
		if (!ch->IsGM())
		{
			ch->ChatPacket(CHAT_TYPE_INFO ,LC_TEXT("������ �ڰ��� ������ ���� �ʽ��ϴ�"));
			sys_err("No Monarch pid %d ", pid);
			return 0;
		}
	}

	if (!ch->IsMCOK(CHARACTER::MI_HEAL))
	{
		ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("%d �� �Ŀ� ������ �ູ�� ����� �� �ֽ��ϴ�"), ch->GetMCLTime(CHARACTER::MI_HEAL));

		return 0;
	}

	if (!IsMoneyOk(price, Empire))
	{
		ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���� ���� �����մϴ�. ���� : %u �ʿ�ݾ� : %u"), GetMoney(Empire), price);
		return 0;
	}

	int iMapIndex = ch->GetMapIndex();

	FHealMyEmpire f;
	f.m_bEmpire = Empire;
	SECTREE_MANAGER::instance().for_each(iMapIndex, f);


	SendtoDBDecMoney(price, Empire, ch);


	ch->SetMC(CHARACTER::MI_HEAL);

	if (test_server)
		ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("[TEST_ONLY]���� ���� : %d "), GetMoney(Empire) - price);
	return 1;
}

void CMonarch::SetMonarchInfo(TMonarchInfo * pInfo)
{
	memcpy(&m_MonarchInfo, pInfo, sizeof(TMonarchInfo));
}

bool CMonarch::IsMonarch(DWORD pid, BYTE bEmpire)
{
	if (bEmpire >= _countof(m_MonarchInfo.pid))
		return false;

	return (m_MonarchInfo.pid[bEmpire] == pid);
}

bool CMonarch::IsMoneyOk(int price, BYTE bEmpire)
{
	dev_log(LOG_DEB1, "GetMoney(%d), price = (%d,%d)", bEmpire, GetMoney(bEmpire), price);
	return (GetMoney(bEmpire) >= price);
}

bool CMonarch::SendtoDBAddMoney(int Money, BYTE bEmpire, LPCHARACTER ch)
{
	if (GetMoney(bEmpire) + Money > 2000000000)
		return false;

	if (GetMoney(bEmpire) + Money < 0)
		return false;

	int nEmpire = bEmpire;
	db_clientdesc->DBPacketHeader(HEADER_GD_ADD_MONARCH_MONEY, ch->GetDesc()->GetHandle(), sizeof(int) + sizeof(int));
	db_clientdesc->Packet(&nEmpire, sizeof(int));
	db_clientdesc->Packet(&Money, sizeof(int));
	return true;
}

bool CMonarch::SendtoDBDecMoney(int Money, BYTE bEmpire, LPCHARACTER ch)
{
	if (bEmpire >= _countof(m_MonarchInfo.money))
		return false;

	if (GetMoney(bEmpire) - Money < 0)
		return false;


	int nEmpire = bEmpire;

	db_clientdesc->DBPacketHeader(HEADER_GD_DEC_MONARCH_MONEY, ch->GetDesc()->GetHandle(), sizeof(int) + sizeof(int));
	db_clientdesc->Packet(&nEmpire, sizeof(int));
	db_clientdesc->Packet(&Money, sizeof(int));
	return true;
}

bool CMonarch::AddMoney(int Money, BYTE bEmpire)
{
	if (bEmpire >= _countof(m_MonarchInfo.money))
		return false;


	if (GetMoney(bEmpire) + Money > 2000000000)
		return false;

	m_MonarchInfo.money[bEmpire] += Money;
	return true;
}

bool CMonarch::DecMoney(int Money, BYTE bEmpire)
{
	if (bEmpire >= _countof(m_MonarchInfo.money))
		return false;

	if (GetMoney(bEmpire) - Money < 0)
		return false;

	m_MonarchInfo.money[bEmpire] -= Money;
	return true;
}

int CMonarch::GetMoney(BYTE bEmpire)
{
	if (bEmpire >= _countof(m_MonarchInfo.money))
		return 0;

	return m_MonarchInfo.money[bEmpire];
}

TMonarchInfo* CMonarch::GetMonarch()
{
	return &m_MonarchInfo;
}

DWORD CMonarch::GetMonarchPID(BYTE Empire)
{
	return Empire < _countof(m_MonarchInfo.pid) ? m_MonarchInfo.pid[Empire] : 0;
}

bool CMonarch::IsPowerUp(BYTE Empire)
{
	return Empire < _countof(m_PowerUp) ? m_PowerUp[Empire] : false;
}

bool CMonarch::IsDefenceUp(BYTE Empire)
{
	return Empire < _countof(m_DefenseUp) ? m_DefenseUp[Empire] : false;
}

bool CMonarch::CheckPowerUpCT(BYTE Empire)
{
	if (Empire >= _countof(m_PowerUpCT))
		return false;

	if (m_PowerUpCT[Empire] > thecore_pulse())
	{
		if (test_server)
			sys_log(0, "[TEST_ONLY] : CheckPowerUpCT CT%d Now%d 60sec %d", m_PowerUpCT[Empire], thecore_pulse(), PASSES_PER_SEC(60 * 10));
		return false;
	}

	return true;
}

bool CMonarch::CheckDefenseUpCT(BYTE Empire)
{
	if (Empire >= _countof(m_DefenseUpCT))
		return false;

	if (m_DefenseUpCT[Empire] > thecore_pulse())
	{
		if (test_server)
			sys_log(0, "[TEST_ONLY] : CheckPowerUpCT CT%d Now%d 60sec %d", m_PowerUpCT[Empire], thecore_pulse(), PASSES_PER_SEC(60 * 10));
		return false;
	}

	return true;
}

void CMonarch::PowerUp(BYTE Empire, bool On)
{
	if (Empire >= _countof(m_PowerUpCT))
		return;

	m_PowerUp[Empire] = On;


	m_PowerUpCT[Empire] = thecore_pulse() + PASSES_PER_SEC(60 * 10);
}

void CMonarch::DefenseUp(BYTE Empire, bool On)
{
	if (Empire >= _countof(m_DefenseUpCT))
		return;

	m_DefenseUp[Empire] = On;


	m_DefenseUpCT[Empire] = thecore_pulse() + PASSES_PER_SEC(60 * 10);
}

bool IsMonarchWarpZone (int map_idx)
{

	if (map_idx >= 10000)
		map_idx /= 10000;

	switch (map_idx)
	{
	case 301:
	case 302:
	case 303:
	case 304:

	case 351:
	case 352:
		return false;
	}

	return (map_idx != 208 && map_idx != 216 && map_idx != 217);
}
