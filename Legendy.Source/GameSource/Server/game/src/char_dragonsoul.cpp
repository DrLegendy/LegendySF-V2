#include "stdafx.h"
#include "char.h"
#include "item.h"
#include "desc.h"
#include "DragonSoul.h"
#include "log.h"

void CHARACTER::DragonSoul_Initialize()
{
	for (int i = INVENTORY_MAX_NUM + WEAR_MAX_NUM; i < DRAGON_SOUL_EQUIP_SLOT_END; i++)
	{
		LPITEM pItem = GetItem(TItemPos(INVENTORY, i));
		if (NULL != pItem)
			pItem->SetSocket(ITEM_SOCKET_DRAGON_SOUL_ACTIVE_IDX, 0);
	}

	if (FindAffect(AFFECT_DRAGON_SOUL_DECK_0))
	{
		DragonSoul_ActivateDeck(DRAGON_SOUL_DECK_0);
	}
	else if (FindAffect(AFFECT_DRAGON_SOUL_DECK_1))
	{
		DragonSoul_ActivateDeck(DRAGON_SOUL_DECK_1);
	}
}

int CHARACTER::DragonSoul_GetActiveDeck() const
{
	return m_pointsInstant.iDragonSoulActiveDeck;
}

bool CHARACTER::DragonSoul_IsDeckActivated() const
{
	return m_pointsInstant.iDragonSoulActiveDeck >= 0;
}

bool CHARACTER::DragonSoul_IsQualified() const
{
	return true;//@DsProject43
	//return FindAffect(AFFECT_DRAGON_SOUL_QUALIFIED) != NULL;
}

void CHARACTER::DragonSoul_GiveQualification()
{
	if(NULL == FindAffect(AFFECT_DRAGON_SOUL_QUALIFIED))
	{
		LogManager::instance().CharLog(this, 0, "DS_QUALIFIED", "");
	}
	AddAffect(AFFECT_DRAGON_SOUL_QUALIFIED, APPLY_NONE, 0, AFF_NONE, INFINITE_AFFECT_DURATION, 0, false, false);
	//SetQuestFlag("dragon_soul.is_qualified", 1);
	//PointChange(POINT_DRAGON_SOUL_IS_QUALIFIED, 1 - GetPoint(POINT_DRAGON_SOUL_IS_QUALIFIED));
}

bool CHARACTER::DragonSoul_ActivateDeck(int deck_idx)
{
	if (deck_idx < DRAGON_SOUL_DECK_0 || deck_idx >= DRAGON_SOUL_DECK_MAX_NUM)
	{
		return false;
	}

	if (DragonSoul_GetActiveDeck() == deck_idx)
		return true;

	DragonSoul_DeactivateAll();

	if (!DragonSoul_IsQualified())
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("용혼석 상자가 활성화되지 않았습니다."));
		return false;
	}

	AddAffect(AFFECT_DRAGON_SOUL_DECK_0 + deck_idx, APPLY_NONE, 0, 0, INFINITE_AFFECT_DURATION, 0, false);

	m_pointsInstant.iDragonSoulActiveDeck = deck_idx;

#ifdef ENABLE_DS_SET
	DragonSoul_SetRefresh();
#endif

	for (int i = DRAGON_SOUL_EQUIP_SLOT_START + DS_SLOT_MAX * deck_idx;
		i < DRAGON_SOUL_EQUIP_SLOT_START + DS_SLOT_MAX * (deck_idx + 1); i++)
	{
		LPITEM pItem = GetInventoryItem(i);
		if (NULL != pItem)
			DSManager::instance().ActivateDragonSoul(pItem);
	}

	return true;
}

void CHARACTER::DragonSoul_DeactivateAll()
{
	for (int i = DRAGON_SOUL_EQUIP_SLOT_START; i < DRAGON_SOUL_EQUIP_SLOT_END; i++)
	{
		DSManager::instance().DeactivateDragonSoul(GetInventoryItem(i), true);
	}

	m_pointsInstant.iDragonSoulActiveDeck = -1;
	RemoveAffect(AFFECT_DRAGON_SOUL_DECK_0);
	RemoveAffect(AFFECT_DRAGON_SOUL_DECK_1);
#ifdef ENABLE_DS_SET
	RemoveAffect(AFFECT_DS_SET);
#endif
}

void CHARACTER::DragonSoul_CleanUp()
{
	for (int i = DRAGON_SOUL_EQUIP_SLOT_START; i < DRAGON_SOUL_EQUIP_SLOT_END; i++)
	{
		DSManager::instance().DeactivateDragonSoul(GetInventoryItem(i), true);
	}
}

#ifdef ENABLE_DS_SET
void CHARACTER::DragonSoul_SetRefresh()
{
	RemoveAffect(AFFECT_DS_SET);
	
	int idx = DragonSoul_GetActiveDeck();
	if (idx < DRAGON_SOUL_DECK_0 || idx >= DRAGON_SOUL_DECK_MAX_NUM)
		return;
	
	std::vector<int> gradeList;
	bool bExpired = false;
	for (int i = 0; i < DS_SLOT_MAX; i++)
		gradeList.push_back(0);
	
	int j = 0;
	for (int i = DRAGON_SOUL_EQUIP_SLOT_START + DS_SLOT_MAX * idx; i < DRAGON_SOUL_EQUIP_SLOT_START + DS_SLOT_MAX * (idx + 1); i++)
	{
		LPITEM pItem = GetInventoryItem(i);
		if (!pItem)
			return;
		
		if (!DSManager::instance().IsTimeLeftDragonSoul(pItem))
			bExpired = true;
		
		gradeList[j] = (pItem->GetVnum() / 1000) % 10;
		j += 1;
	}
	
	if ((!bExpired) && ((gradeList[0] == DRAGON_SOUL_GRADE_LEGENDARY)
#ifdef ENABLE_DS_GRADE_MYTH
		|| (gradeList[0] == DRAGON_SOUL_GRADE_MYTH)
#endif
	)) {
		if (std::equal(gradeList.begin() + 1, gradeList.end(), gradeList.begin())) {
			AddAffect(AFFECT_DS_SET, APPLY_NONE, gradeList[0], 0, INFINITE_AFFECT_DURATION, 0, false);
			
			TPacketDSTable p;
			p.bHeader = HEADER_GC_DS_TABLE;
			for (int i = DRAGON_SOUL_EQUIP_SLOT_START + DS_SLOT_MAX * idx; i < DRAGON_SOUL_EQUIP_SLOT_START + DS_SLOT_MAX * (idx + 1); i++) {
				LPITEM pItem = GetInventoryItem(i);
				if (NULL != pItem) {
					p.iType = pItem->GetVnum() / 10000;
					p.fWeight = DSManager::instance().GetWeight(pItem->GetVnum());
					p.iApplyCount = DSManager::instance().GetApplyCount(pItem->GetVnum());
					
					for (int q = 0; q < 255; q++) {
						p.iBasicApplyValue[q] = 0;
						p.iAditionalApplyValue[q] = 0;
					}
					
					for (int q = 0; q < p.iApplyCount; q++)
						p.iBasicApplyValue[pItem->GetAttributeType(q)] = DSManager::instance().GetBasicApplyValue(pItem->GetVnum(), pItem->GetAttributeType(q));
					
					for (int q = p.iApplyCount; q < ITEM_ATTRIBUTE_MAX_NUM; q++)
						p.iAditionalApplyValue[pItem->GetAttributeType(q)] = DSManager::instance().GetAdditionalApplyValue(pItem->GetVnum(), pItem->GetAttributeType(q));
					
					GetDesc()->Packet(&p, sizeof(p));
				}
			}
		}
	}
}
#endif

bool CHARACTER::DragonSoul_RefineWindow_Open(LPENTITY pEntity)
{
	if (NULL == m_pointsInstant.m_pDragonSoulRefineWindowOpener)
	{
		m_pointsInstant.m_pDragonSoulRefineWindowOpener = pEntity;
	}

	TPacketGCDragonSoulRefine PDS;
	PDS.header = HEADER_GC_DRAGON_SOUL_REFINE;
	PDS.bSubType = DS_SUB_HEADER_OPEN;
	LPDESC d = GetDesc();

	if (NULL == d)
	{
		sys_err ("User(%s)'s DESC is NULL POINT.", GetName());
		return false;
	}

	d->Packet(&PDS, sizeof(PDS));
	return true;
}

bool CHARACTER::DragonSoul_RefineWindow_Close()
{
	m_pointsInstant.m_pDragonSoulRefineWindowOpener = NULL;
	return true;
}

bool CHARACTER::DragonSoul_RefineWindow_CanRefine()
{
	return NULL != m_pointsInstant.m_pDragonSoulRefineWindowOpener;
}
