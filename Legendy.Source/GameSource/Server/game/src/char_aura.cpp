#include "stdafx.h"
#include "config.h"
#include "char.h"
#include "item.h"
#include "desc.h"
#include "log.h"
#include "item_manager.h"
#include "buffer_manager.h"
#include "unique_item.h"
#include "utils.h"
#include "constants.h"

#ifdef __AURA_SYSTEM__
void CHARACTER::OpenAuraRefineWindow(LPENTITY pOpener, EAuraWindowType type)
{
	if (IsAuraRefineWindowOpen())
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �ƿ�� ������ â�� ���ÿ� �ϳ��� �� �� �ֽ��ϴ�."));
		return;
	}

	int iDist = DISTANCE_APPROX(GetX() - pOpener->GetX(), GetY() - pOpener->GetY());
	if (iDist >= AURA_REFINE_MAX_DISTANCE)
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �ƿ�� â�� �� �� �����ϴ�."));
		return;
	}

	TEMP_BUFFER buf;
	TPacketGCAura pack;
	TSubPacketGCAuraOpenClose sub;
	pack.wSize = sizeof(TPacketGCAura) + sizeof(TSubPacketGCAuraOpenClose);
	pack.bSubHeader = AURA_SUBHEADER_GC_OPEN;
	switch (type)
	{
		case AURA_WINDOW_TYPE_ABSORB:
		case AURA_WINDOW_TYPE_GROWTH:
		case AURA_WINDOW_TYPE_EVOLVE:
			sub.bAuraWindowType = type;
			break;
		case AURA_WINDOW_TYPE_MAX:
			return;
	}

	LPDESC desc = GetDesc();
	if (!desc)
	{
		sys_err("User(%s)'s DESC is NULL POINT.", GetName());
		return;
	}

	buf.write(&pack, sizeof(TPacketGCAura));
	buf.write(&sub, sizeof(TSubPacketGCAuraOpenClose));

	if (NULL == m_pointsInstant.m_pAuraRefineWindowOpener)
		m_pointsInstant.m_pAuraRefineWindowOpener = pOpener;

	m_bAuraRefineWindowType = type;
	m_bAuraRefineWindowOpen = AURA_WINDOW_TYPE_MAX != m_bAuraRefineWindowType;

	desc->Packet(buf.read_peek(), buf.size());
}

void CHARACTER::AuraRefineWindowClose()
{
	LPDESC desc = GetDesc();
	if (!desc)
	{
		sys_err("User(%s)'s DESC is NULL POINT.", GetName());
		return;
	}

	m_pointsInstant.m_pAuraRefineWindowOpener = NULL;
	m_bAuraRefineWindowType = AURA_WINDOW_TYPE_MAX;
	m_bAuraRefineWindowOpen = false;
	for (BYTE i = 0; i < AURA_SLOT_MAX; ++i)
	{
		if (m_pAuraRefineWindowItemSlot[i] != NPOS)
		{
			LPITEM pItem = GetItem(m_pAuraRefineWindowItemSlot[i]);
			if (pItem)
				pItem->Lock(false);
			m_pAuraRefineWindowItemSlot[i] = NPOS;
		}
	}

	TPacketGCAura pack;
	TSubPacketGCAuraOpenClose sub;
	pack.bSubHeader = AURA_SUBHEADER_GC_CLOSE;
	pack.wSize = sizeof(TPacketGCAura) + sizeof(TSubPacketGCAuraOpenClose);

	sub.bAuraWindowType = AURA_WINDOW_TYPE_MAX;

	TEMP_BUFFER buf;
	buf.write(&pack, sizeof(TPacketGCAura));
	buf.write(&sub, sizeof(TSubPacketGCAuraOpenClose));
	desc->Packet(buf.read_peek(), buf.size());
}

bool CHARACTER::IsAuraRefineWindowCanRefine()
{
	if (!CanHandleItem())
		return false;

	if (!IsAuraRefineWindowOpen())
		return false;

	LPENTITY pOpener = GetAuraRefineWindowOpener();
	if (!pOpener)
		return false;

	int iDist = DISTANCE_APPROX(GetX() - pOpener->GetX(), GetY() - pOpener->GetY());
	if (iDist >= AURA_REFINE_MAX_DISTANCE)
		return false;

	return true;
}

BYTE CHARACTER::__GetAuraAbsorptionRate(BYTE bLevel, BYTE bBoostIndex) const
{
	BYTE bBoostValue = 0;
	if (bBoostIndex > ITEM_AURA_BOOST_ERASER && bBoostIndex < ITEM_AURA_BOOST_MAX)
	{
		DWORD dwBoosterItemVnum = ITEM_AURA_BOOST_ITEM_VNUM_BASE + bBoostIndex;
		TItemTable* pProto = ITEM_MANAGER::instance().GetTable(dwBoosterItemVnum);
		if (!pProto)
		{
			sys_err("THERE IS NO PROTO FOR AURA BOOST ITEM %lu", dwBoosterItemVnum);
		}
		else
			bBoostValue += BYTE(pProto->alValues[ITEM_AURA_BOOST_PERCENT_VALUE]);
	}

	return bBoostValue;
}

TAuraRefineInfo CHARACTER::__GetAuraRefineInfo(TItemPos Cell)
{
	TAuraRefineInfo info;

	LPITEM pItem = GetItem(Cell);
	if (!pItem)
	{
		info.bAuraRefineInfoLevel = 0;
		info.bAuraRefineInfoExpPercent = 0;
		return info;
	}

	const long c_lLevelSocket = pItem->GetSocket(ITEM_SOCKET_AURA_CURRENT_LEVEL);
	info.bAuraRefineInfoLevel = (c_lLevelSocket / 100000) - 1000;
	int* aiAuraRefineTable = GetAuraRefineInfo(info.bAuraRefineInfoLevel);
	info.bAuraRefineInfoExpPercent = BYTE((c_lLevelSocket % 100000) * 1.0f / aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP] * 100);
	return info;
}

TAuraRefineInfo CHARACTER::__CalcAuraRefineInfo(TItemPos Cell, TItemPos MaterialCell)
{
	TAuraRefineInfo info;
	LPITEM pItem = GetItem(Cell);
	LPITEM pMaterial = GetItem(MaterialCell);
	if (!pItem || !pMaterial)
	{
		info.bAuraRefineInfoLevel = 0;
		info.bAuraRefineInfoExpPercent = 0;
		return info;
	}

	const long c_lLevelSocket = pItem->GetSocket(ITEM_SOCKET_AURA_CURRENT_LEVEL);
	BYTE bNextLevel = (c_lLevelSocket / 100000) - 1000;
	int* aiAuraRefineTable = GetAuraRefineInfo(bNextLevel);
	WORD wCurExp = c_lLevelSocket % 100000;
	int iAdditionalExp = pMaterial->GetCount() * pMaterial->GetValue(ITEM_AURA_MATERIAL_EXP_VALUE);
	WORD wUsedItemCount = 0;
	while (true)
	{
		wUsedItemCount += 1;
		int iNeedExp = aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP] - wCurExp;

		if (wCurExp + iAdditionalExp < aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP])
		{
			wCurExp += iAdditionalExp;
			iAdditionalExp = 0;
			wUsedItemCount = pMaterial->GetCount();
			break;
		}

		if (bNextLevel >= aiAuraRefineTable[AURA_REFINE_INFO_LEVEL_MAX])
		{
			if (wCurExp + pMaterial->GetValue(ITEM_AURA_MATERIAL_EXP_VALUE) >= aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP])
			{
				wCurExp += iNeedExp;
				iAdditionalExp -= iNeedExp;
				break;
			}
		}

		if (wCurExp + pMaterial->GetValue(ITEM_AURA_MATERIAL_EXP_VALUE) >= aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP])
		{
			wCurExp = 0;
			iAdditionalExp -= iNeedExp;
			bNextLevel += 1;
			continue;
		}

		wCurExp += pMaterial->GetValue(ITEM_AURA_MATERIAL_EXP_VALUE);
		iAdditionalExp -= pMaterial->GetValue(ITEM_AURA_MATERIAL_EXP_VALUE);
	}

	info.bAuraRefineInfoLevel = bNextLevel;
	info.bAuraRefineInfoExpPercent = BYTE(wCurExp * 1.0f / aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP] * 100);
	return info;
}

TAuraRefineInfo CHARACTER::__GetAuraEvolvedRefineInfo(TItemPos Cell)
{
	TAuraRefineInfo info;
	info.bAuraRefineInfoLevel = 0;
	info.bAuraRefineInfoExpPercent = 0;

	LPITEM pItem = GetItem(Cell);
	if (!pItem)
		return info;

	const long c_lLevelSocket = pItem->GetSocket(ITEM_SOCKET_AURA_CURRENT_LEVEL);
	BYTE bCurLevel = (c_lLevelSocket / 100000) - 1000;
	int* aiAuraRefineTable = GetAuraRefineInfo(bCurLevel);
	WORD wCurExp = c_lLevelSocket % 100000;

	if (bCurLevel < aiAuraRefineTable[AURA_REFINE_INFO_LEVEL_MAX] || wCurExp < aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP])
		return info;

	if (aiAuraRefineTable[AURA_REFINE_INFO_STEP] == AURA_GRADE_RADIANT)
		return info;

	info.bAuraRefineInfoLevel = bCurLevel + 1;
	return info;
}

void CHARACTER::AuraRefineWindowCheckIn(BYTE bAuraRefineWindowType, TItemPos AuraCell, TItemPos ItemCell)
{
	if (AuraCell.window_type != AURA_REFINE || AuraCell.cell >= AURA_SLOT_RESULT)
		return;

	LPDESC desc = GetDesc();
	if (!desc)
	{
		sys_err("User(%s)'s DESC is NULL POINT.", GetName());
		return;
	}

	if (!IsAuraRefineWindowOpen())
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���� Ư�� ���� ���� â�� ������մϴ�."));
		return;
	}

	if (!IsAuraRefineWindowCanRefine())
	{
		if (IsAuraRefineWindowOpen() && NULL != GetAuraRefineWindowOpener())
		{
#if _WIN32
			__asm {
				nop;
			}
#endif
		}
		else
		{
			ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���μ����� ����Ϸ��� ��� â�� �����ʽÿ�."));
			return;
		}
	}

	if (m_bAuraRefineWindowType != bAuraRefineWindowType)
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �ƿ�� ���� ���μ����� ������ �߻��Ͽ� ����� �� �����ϴ�."));
		return;
	}

	switch (bAuraRefineWindowType)
	{
		case AURA_WINDOW_TYPE_ABSORB:
		{
			if (!ItemCell.IsValidItemPosition())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �׸��� ��� �� �� �����ϴ�."));
				return;
			}

			if (ItemCell.IsEquipPosition())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ����� ���� ���� �� �������� ���� �� �� �����ϴ�."));
				return;
			}

			LPITEM pItem = GetItem(ItemCell);
			if (!pItem)
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���ǵ��� ���� ������ �߻��߽��ϴ�."));
				return;
			}

			/*
				New antiflag for special items which cannot be absorbed
			*/
			//if (IS_SET(pItem->GetAntiFlag(), ITEM_ANTIFLAG_ABSORB))
			//{
			//	ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �������� ����� ���� ���� �� �� �����ϴ�."));
			//	return;
			//}

			if (pItem->IsExchanging())
				return;

			if (pItem->isLocked())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �������� ���Ǹ� ����� ���� ���� �� �� �����ϴ�."));
				return;
			}

#ifdef ENABLE_SEALBIND_SYSTEM
			if (pItem->IsBound())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �������� ��ȥ�� ���� ������ ����� ���� ���� �� �� �����ϴ�."));
				return;
			}
#endif

			if (AuraCell.cell == AURA_SLOT_MAIN && !(pItem->GetType() == ITEM_COSTUME && pItem->GetSubType() == COSTUME_AURA))
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� ���Կ����� ���� �ǻ� �� ���� �� �� �ֽ��ϴ�."));
				return;
			}

			if (AuraCell.cell == AURA_SLOT_MAIN && pItem->GetSocket(ITEM_SOCKET_AURA_DRAIN_ITEM_VNUM))
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �ƿ�� �ǻ��� �̹� ��� ���� �ֽ��ϴ�."));
				return;
			}

			if (AuraCell.cell == AURA_SLOT_SUB && !(pItem->GetType() == ITEM_ARMOR && (pItem->GetSubType() == ARMOR_SHIELD || pItem->GetSubType() == ARMOR_WRIST || pItem->GetSubType() == ARMOR_NECK || pItem->GetSubType() == ARMOR_EAR)))
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� ���Կ����� ����, ����, ����� �� �Ͱ��� �� ���� �� �� �ֽ��ϴ�."));
				return;
			}

			if (m_pAuraRefineWindowItemSlot[AuraCell.cell] != NPOS)
				return;

			pItem->Lock(true);

			m_pAuraRefineWindowItemSlot[AuraCell.cell] = ItemCell;

			TPacketGCAura pack;
			TSubPacketGCAuraSetItem sub;
			pack.wSize = sizeof(TPacketGCAura) + sizeof(TSubPacketGCAuraSetItem);
			pack.bSubHeader = AURA_SUBHEADER_GC_SET_ITEM;

			sub.Cell = ItemCell;
			sub.AuraCell = AuraCell;
			sub.pItem.vnum = pItem->GetVnum();
			sub.pItem.count = pItem->GetCount();
			sub.pItem.flags = pItem->GetFlag();
			sub.pItem.anti_flags = pItem->GetAntiFlag();
			thecore_memcpy(sub.pItem.alSockets, pItem->GetSockets(), sizeof(sub.pItem.alSockets));
			thecore_memcpy(sub.pItem.aAttr, pItem->GetAttributes(), sizeof(sub.pItem.aAttr));

			TEMP_BUFFER buf;
			buf.write(&pack, sizeof(TPacketGCAura));
			buf.write(&sub, sizeof(TSubPacketGCAuraSetItem));
			desc->Packet(buf.read_peek(), buf.size());

			if (NPOS != m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN] && NPOS != m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN])
			{
				LPITEM srcItem = GetItem(m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN]);
				if (!srcItem || !IsValidItemPosition(m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN]) || srcItem->IsExchanging() || srcItem->IsEquipped())
					return;

				LPITEM mtrlItem = GetItem(m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB]);
				if (!mtrlItem || !IsValidItemPosition(m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB]) || mtrlItem->IsExchanging() || mtrlItem->IsEquipped())
					return;

				TPacketGCAura pack2;
				TSubPacketGCAuraSetItem sub2;
				pack2.wSize = sizeof(TPacketGCAura) + sizeof(TSubPacketGCAuraSetItem);
				pack2.bSubHeader = AURA_SUBHEADER_GC_SET_ITEM;

				sub2.Cell = TItemPos(RESERVED_WINDOW, 0);
				sub2.AuraCell = TItemPos(AURA_REFINE, AURA_SLOT_RESULT);
				sub2.pItem.vnum = srcItem->GetOriginalVnum();
				sub2.pItem.count = srcItem->GetCount();
				sub2.pItem.flags = srcItem->GetFlag();
				sub2.pItem.anti_flags = srcItem->GetAntiFlag();
				thecore_memcpy(sub2.pItem.alSockets, srcItem->GetSockets(), sizeof(sub2.pItem.alSockets));
				sub2.pItem.alSockets[ITEM_SOCKET_AURA_DRAIN_ITEM_VNUM] = mtrlItem->GetOriginalVnum();
				thecore_memcpy(sub2.pItem.aAttr, mtrlItem->GetAttributes(), sizeof(sub2.pItem.aAttr));

				TEMP_BUFFER buf;
				buf.write(&pack2, sizeof(TPacketGCAura));
				buf.write(&sub2, sizeof(TSubPacketGCAuraSetItem));
				desc->Packet(buf.read_peek(), buf.size());
			}
		}
		break;

		case AURA_WINDOW_TYPE_GROWTH:
		{
			if (!ItemCell.IsValidItemPosition())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� ���� ���׷��̵� �� �� �����ϴ�."));
				return;
			}

			if (ItemCell.IsEquipPosition())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���׷��̵带 ���� ���� �� �������� ���� �� �� �����ϴ�."));
				return;
			}

			LPITEM pItem = GetItem(ItemCell);
			if (!pItem)
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���ǵ��� ���� ������ �߻��߽��ϴ�."));
				return;
			}

			/*
				New antiflag for special items which cannot be absorbed
			*/
			//if (IS_SET(pItem->GetAntiFlag(), ITEM_ANTIFLAG_ABSORB))
			//{
			//	ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���׷��̵带 ������ �׸��� ÷�� �� �� �����ϴ�."));
			//	return;
			//}

			if (pItem->IsExchanging())
				return;

			if (pItem->isLocked())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �������� ��� ���̸� ���׷��̵带 ���� ���� �� �� �����ϴ�."));
				return;
			}

#ifdef ENABLE_SEALBIND_SYSTEM
			if (pItem->IsBound())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �������� ��ȥ�� ���� ������ ���׷��̵带 ���� ���� �� �� �����ϴ�."));
				return;
			}
#endif

			if (AuraCell.cell == AURA_SLOT_MAIN)
			{
				if (!(pItem->GetType() == ITEM_COSTUME && pItem->GetSubType() == COSTUME_AURA))
				{
					ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� ���Կ����� ���� �ǻ� �� ���� �� �� �ֽ��ϴ�."));
					return;
				}
				else
				{
					const long c_lLevelSocket = pItem->GetSocket(ITEM_SOCKET_AURA_CURRENT_LEVEL);
					const BYTE c_bCurrentLevel = (c_lLevelSocket / 100000) - 1000;
					const WORD c_wCurrentExp = c_lLevelSocket % 100000;
					int* aiAuraRefineTable = GetAuraRefineInfo(c_bCurrentLevel);
					if (c_bCurrentLevel == aiAuraRefineTable[AURA_REFINE_INFO_LEVEL_MAX] && c_wCurrentExp == aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP])
					{
						ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �ƿ�� �ǻ��� ���׷��̵� �� �� �����ϴ�."));
						if (aiAuraRefineTable[AURA_REFINE_INFO_STEP] == AURA_GRADE_RADIANT)
							ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �ƿ�� �ǻ��� �ִ� ������ ��޿� �����߽��ϴ�."));
						else
							ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �߰� �ܰ�� ��üȭ â�� ����Ͻʽÿ�."));
						return;
					}
				}
			}
			if (AuraCell.cell == AURA_SLOT_SUB)
			{
				if (NPOS == m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN])
				{
					ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���� �ƿ�� �ǻ��� �����ؾ��մϴ�."));
					return;
				}
				else if (!(pItem->GetType() == ITEM_RESOURCE && pItem->GetSubType() == RESOURCE_AURA))
				{
					ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� ���Կ����� ���� ��� �� ���� �� �� �ֽ��ϴ�."));
					return;
				}
			}

			if (m_pAuraRefineWindowItemSlot[AuraCell.cell] != NPOS)
				return;

			pItem->Lock(true);

			m_pAuraRefineWindowItemSlot[AuraCell.cell] = ItemCell;

			TPacketGCAura pack;
			TSubPacketGCAuraSetItem sub;
			pack.wSize = sizeof(TPacketGCAura) + sizeof(TSubPacketGCAuraSetItem);
			pack.bSubHeader = AURA_SUBHEADER_GC_SET_ITEM;

			sub.Cell = ItemCell;
			sub.AuraCell = AuraCell;
			sub.pItem.vnum = pItem->GetVnum();
			sub.pItem.count = pItem->GetCount();
			sub.pItem.flags = pItem->GetFlag();
			sub.pItem.anti_flags = pItem->GetAntiFlag();
			thecore_memcpy(sub.pItem.alSockets, pItem->GetSockets(), sizeof(sub.pItem.alSockets));
			thecore_memcpy(sub.pItem.aAttr, pItem->GetAttributes(), sizeof(sub.pItem.aAttr));

			TEMP_BUFFER buf;
			buf.write(&pack, sizeof(TPacketGCAura));
			buf.write(&sub, sizeof(TSubPacketGCAuraSetItem));
			desc->Packet(buf.read_peek(), buf.size());

			{
				LPITEM srcItem = GetItem(ItemCell);
				if (!srcItem || !ItemCell.IsValidItemPosition() || srcItem->IsExchanging() || srcItem->IsEquipped())
					return;

				TPacketGCAura pack;
				TSubPacketGCAuraRefineInfo sub;
				pack.wSize = sizeof(TPacketGCAura) + sizeof(TSubPacketGCAuraRefineInfo);
				pack.bSubHeader = AURA_SUBHEADER_GC_REFINE_INFO;

				TAuraRefineInfo info;
				if (AuraCell.cell == AURA_SLOT_MAIN)
				{
					sub.bAuraRefineInfoType = AURA_REFINE_INFO_SLOT_CURRENT;
					info = __GetAuraRefineInfo(ItemCell);
				}
				if (AuraCell.cell == AURA_SLOT_SUB)
				{
					sub.bAuraRefineInfoType = AURA_REFINE_INFO_SLOT_NEXT;
					info = __CalcAuraRefineInfo(m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN], ItemCell);
				}
				sub.bAuraRefineInfoLevel = info.bAuraRefineInfoLevel;
				sub.bAuraRefineInfoExpPercent = info.bAuraRefineInfoExpPercent;

				TEMP_BUFFER buf;
				buf.write(&pack, sizeof(TPacketGCAura));
				buf.write(&sub, sizeof(TSubPacketGCAuraRefineInfo));
				desc->Packet(buf.read_peek(), buf.size());
			}
		}
		break;

		case AURA_WINDOW_TYPE_EVOLVE:
		{
			if (!ItemCell.IsValidItemPosition())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� ����� �ٵ��� �� �����ϴ�."));
				return;
			}

			if (ItemCell.IsEquipPosition())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ��ȭ�� ���� ���� �� �������� ���� �� �� �����ϴ�."));
				return;
			}

			LPITEM pItem = GetItem(ItemCell);
			if (!pItem)
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���ǵ��� ���� ������ �߻��߽��ϴ�."));
				return;
			}

			if (pItem->IsExchanging())
				return;

			if (pItem->isLocked())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �������� ���Ǹ� ��ȭ�� ���� ���� �� �� �����ϴ�."));
				return;
			}

#ifdef ENABLE_SEALBIND_SYSTEM
			if (pItem->IsBound())
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �������� ����� ��ȥ�� ���� ������ ��ȭ�� ���� ���� �� �����ϴ�."));
				return;
			}
#endif

			if (AuraCell.cell == AURA_SLOT_MAIN)
			{
				if (!(pItem->GetType() == ITEM_COSTUME && pItem->GetSubType() == COSTUME_AURA))
				{
					ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� ���Կ����� ���� �ǻ� �� ���� �� �� �ֽ��ϴ�."));
					return;
				}
				else
				{
					const long c_lLevelSocket = pItem->GetSocket(ITEM_SOCKET_AURA_CURRENT_LEVEL);
					const BYTE c_bCurrentLevel = (c_lLevelSocket / 100000) - 1000;
					const WORD c_wCurrentExp = c_lLevelSocket % 100000;
					int* aiAuraRefineTable = GetAuraRefineInfo(c_bCurrentLevel);
					if (!(c_bCurrentLevel == aiAuraRefineTable[AURA_REFINE_INFO_LEVEL_MAX] && c_wCurrentExp == aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP]))
					{
						ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �ƿ�� �ǻ��� ���� ���� �� �� �����ϴ�."));
						ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> %d ����ġ�� %d ������ �־���մϴ�."), aiAuraRefineTable[AURA_REFINE_INFO_LEVEL_MAX], aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP]);
						return;
					}
				}
			}

			if (AuraCell.cell == AURA_SLOT_SUB)
			{
				if (NPOS == m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN])
				{
					ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���� �ƿ�� �ǻ��� �����ؾ��մϴ�."));
					return;
				}
				else
				{
					const LPITEM c_pAuraItem = GetItem(m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN]);
					const long c_lLevelSocket = c_pAuraItem->GetSocket(ITEM_SOCKET_AURA_CURRENT_LEVEL);
					const BYTE c_bCurrentLevel = (c_lLevelSocket / 100000) - 1000;
					int* aiAuraRefineTable = GetAuraRefineInfo(c_bCurrentLevel);
					if (pItem->GetOriginalVnum() != aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_VNUM])
					{
						ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� ���Կ����� Ư�� ���� ��� �� ���� �� �� �ֽ��ϴ�."));
						TItemTable* pTable = ITEM_MANAGER::instance().GetTable(aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_VNUM]);
						if (pTable)
							ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ��, %s - %u"), pTable->szLocaleName, aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_COUNT]);
						return;
					}
				}
			}

			if (m_pAuraRefineWindowItemSlot[AuraCell.cell] != NPOS)
				return;

			pItem->Lock(true);

			m_pAuraRefineWindowItemSlot[AuraCell.cell] = ItemCell;

			TPacketGCAura pack;
			TSubPacketGCAuraSetItem sub;
			pack.wSize = sizeof(TPacketGCAura) + sizeof(TSubPacketGCAuraSetItem);
			pack.bSubHeader = AURA_SUBHEADER_GC_SET_ITEM;

			sub.Cell = ItemCell;
			sub.AuraCell = AuraCell;
			sub.pItem.vnum = pItem->GetVnum();
			sub.pItem.count = pItem->GetCount();
			sub.pItem.flags = pItem->GetFlag();
			sub.pItem.anti_flags = pItem->GetAntiFlag();
			thecore_memcpy(sub.pItem.alSockets, pItem->GetSockets(), sizeof(sub.pItem.alSockets));
			thecore_memcpy(sub.pItem.aAttr, pItem->GetAttributes(), sizeof(sub.pItem.aAttr));

			TEMP_BUFFER buf;
			buf.write(&pack, sizeof(TPacketGCAura));
			buf.write(&sub, sizeof(TSubPacketGCAuraSetItem));
			desc->Packet(buf.read_peek(), buf.size());

			if (AuraCell.cell == AURA_SLOT_MAIN)
			{
				LPITEM srcItem = GetItem(ItemCell);
				if (!srcItem || !ItemCell.IsValidItemPosition() || srcItem->IsExchanging() || srcItem->IsEquipped())
					return;

				TPacketGCAura pack;
				TSubPacketGCAuraRefineInfo sub;
				TSubPacketGCAuraRefineInfo sub2;
				pack.wSize = sizeof(TPacketGCAura) + 2*sizeof(TSubPacketGCAuraRefineInfo);
				pack.bSubHeader = AURA_SUBHEADER_GC_REFINE_INFO;

				TAuraRefineInfo info = __GetAuraRefineInfo(ItemCell);
				sub.bAuraRefineInfoType = AURA_REFINE_INFO_SLOT_CURRENT;
				sub.bAuraRefineInfoLevel = info.bAuraRefineInfoLevel;
				sub.bAuraRefineInfoExpPercent = info.bAuraRefineInfoExpPercent;

				info = __GetAuraEvolvedRefineInfo(ItemCell);
				sub2.bAuraRefineInfoType = AURA_REFINE_INFO_SLOT_EVOLVED;
				sub2.bAuraRefineInfoLevel = info.bAuraRefineInfoLevel;
				sub2.bAuraRefineInfoExpPercent = info.bAuraRefineInfoExpPercent;

				TEMP_BUFFER buf;
				buf.write(&pack, sizeof(TPacketGCAura));
				buf.write(&sub, sizeof(TSubPacketGCAuraRefineInfo));
				buf.write(&sub2, sizeof(TSubPacketGCAuraRefineInfo));
				desc->Packet(buf.read_peek(), buf.size());
			}
		}
		break;
	}
}

void CHARACTER::AuraRefineWindowCheckOut(BYTE bAuraRefineWindowType, TItemPos AuraCell)
{
	if (AuraCell.window_type != AURA_REFINE || AuraCell.cell >= AURA_SLOT_RESULT)
		return;

	LPDESC desc = GetDesc();
	if (!desc)
	{
		sys_err("User(%s)'s DESC is NULL POINT.", GetName());
		return;
	}

	if (!IsAuraRefineWindowOpen())
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �ƿ�� â�� ���� ���� ���� ���¿������� �۾��� ���� �� �� �����ϴ�."));
		return;
	}

	if (!IsAuraRefineWindowCanRefine())
	{
		if (IsAuraRefineWindowOpen() && NULL != GetAuraRefineWindowOpener())
		{
#if _WIN32
			__asm {
				nop;
			}
#endif
		}
		else
		{
			ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���μ����� ����Ϸ��� ��� â�� �����ʽÿ�."));
			return;
		}
	}

	if (m_bAuraRefineWindowType != bAuraRefineWindowType)
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �ٸ� �ƿ�� â�� �����ִ� ���ȿ����� �۾��� ���� �� �� �����ϴ�."));
		return;
	}

	if (m_pAuraRefineWindowItemSlot[AuraCell.cell] == NPOS)
		return;

	if (AuraCell.cell == AURA_SLOT_MAIN && m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB] != NPOS)
	{
		LPITEM pItem = GetItem(m_pAuraRefineWindowItemSlot[AuraCell.cell]), pMaterial = GetItem(m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB]);
		if (!pItem || !pMaterial)
			return;

		pItem->Lock(false);
		pMaterial->Lock(false);
		m_pAuraRefineWindowItemSlot[AuraCell.cell] = NPOS;
		m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB] = NPOS;

		TPacketGCAura pack;
		pack.wSize = sizeof(TPacketGCAura);
		pack.bSubHeader = AURA_SUBHEADER_GC_CLEAR_ALL;
		desc->Packet(&pack, sizeof(TPacketGCAura));
	}
	else
	{
		LPITEM pItem = GetItem(m_pAuraRefineWindowItemSlot[AuraCell.cell]);
		if (!pItem)
			return;

		pItem->Lock(false);
		m_pAuraRefineWindowItemSlot[AuraCell.cell] = NPOS;

		TPacketGCAura pack;
		TSubPacketGCAuraClearSlot sub;
		pack.wSize = sizeof(TPacketGCAura) + sizeof(TSubPacketGCAuraClearSlot);
		pack.bSubHeader = AURA_SUBHEADER_GC_CLEAR_SLOT;

		sub.bAuraSlotPos = AuraCell.cell;

		TEMP_BUFFER buf;
		buf.write(&pack, sizeof(TPacketGCAura));
		buf.write(&sub, sizeof(TSubPacketGCAuraClearSlot));
		desc->Packet(buf.read_peek(), buf.size());
	}
}

void CHARACTER::AuraRefineWindowAccept(BYTE bAuraRefineWindowType)
{
	LPDESC desc = GetDesc();
	if (!desc)
	{
		sys_err("User(%s)'s DESC is NULL POINT.", GetName());
		return;
	}

	if (!IsAuraRefineWindowOpen())
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �ƿ�� â�� ���� ���� ���� ���¿������� �۾��� ���� �� �� �����ϴ�."));
		return;
	}

	if (!IsAuraRefineWindowCanRefine())
	{
		if (IsAuraRefineWindowOpen() && NULL != GetAuraRefineWindowOpener())
		{
#if _WIN32
			__asm {
				nop;
			}
#endif
		}
		else
		{
			ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���μ����� ����Ϸ��� ��� â�� �����ʽÿ�."));
			return;
		}
	}

	if (m_bAuraRefineWindowType != bAuraRefineWindowType)
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �ٸ� �ƿ�� â�� �����ִ� ���ȿ����� �۾��� ���� �� �� �����ϴ�."));
		return;
	}

	if (m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN] == NPOS || m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB] == NPOS)
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> â�� �׸��� ÷���Ͻʽÿ�."));
		return;
	}

	LPITEM auraItem = GetItem(m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN]);
	if (!auraItem || !m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN].IsValidItemPosition())
		return;

	LPITEM mtrlItem = GetItem(m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB]);
	if (!mtrlItem || !m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB].IsValidItemPosition())
		return;

	if (auraItem->IsExchanging() || mtrlItem->IsExchanging())
		return;

	if (auraItem->IsEquipped() || mtrlItem->IsEquipped())
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���� �� �������� ����� �� �����ϴ�."));
		return;
	}

#ifdef ENABLE_SEALBIND_SYSTEM
	if (auraItem->IsBound() || mtrlItem->IsBound())
	{
		ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ��ȥ�� ���� �������� ����� �� �����ϴ�."));
		return;
	}
#endif
	switch (bAuraRefineWindowType)
	{
		case AURA_WINDOW_TYPE_ABSORB:
		{
			ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ����� �Ϸ�Ǿ����ϴ�."));

			auraItem->Lock(false);
			auraItem->SetSocket(ITEM_SOCKET_AURA_DRAIN_ITEM_VNUM, mtrlItem->GetOriginalVnum());
			mtrlItem->CopyAttributeTo(auraItem);
			auraItem->UpdatePacket();

			sys_log(1, "%s[%d] - Aura Absorption Success [%d][%d]", GetName(), GetPlayerID(), auraItem->GetID(), mtrlItem->GetID());
			LogManager::instance().ItemLog(this, auraItem, "AURA ABSORPTION SUCCESS", auraItem->GetName());
			ITEM_MANAGER::instance().RemoveItem(mtrlItem, "AURA MATERIAL ITEM REMOVE (ABSORPTION SUCCESS)");

			m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN] = NPOS;
			m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB] = NPOS;

			TPacketGCAura pack;
			pack.wSize = sizeof(TPacketGCAura);
			pack.bSubHeader = AURA_SUBHEADER_GC_CLEAR_ALL;
			desc->Packet(&pack, sizeof(TPacketGCAura));
		}
		break;

		case AURA_WINDOW_TYPE_GROWTH:
		{
			const long c_lLevelSocket = auraItem->GetSocket(ITEM_SOCKET_AURA_CURRENT_LEVEL);
			BYTE bNextLevel = (c_lLevelSocket / 100000) - 1000;
			int* aiAuraRefineTable = GetAuraRefineInfo(bNextLevel);
			WORD wCurExp = c_lLevelSocket % 100000;
			if (bNextLevel == aiAuraRefineTable[AURA_REFINE_INFO_LEVEL_MAX] && wCurExp == aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP])
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �ƿ�� �ǻ��� ���׷��̵� �� �� �����ϴ�."));
				if (aiAuraRefineTable[AURA_REFINE_INFO_STEP] == AURA_GRADE_RADIANT)
					ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �ƿ�� �ǻ��� �ִ� ������ ��޿� �����߽��ϴ�."));
				else
					ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �߰� �ܰ�� ��üȭ â�� ����Ͻʽÿ�."));
				return;
			}
			int iAdditionalExp = mtrlItem->GetCount() * mtrlItem->GetValue(ITEM_AURA_MATERIAL_EXP_VALUE);
			WORD wUsedItemCount = 0;
			while (true)
			{
				wUsedItemCount += 1;
				int iNeedExp = aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP] - wCurExp;

				if (wCurExp + iAdditionalExp < aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP])
				{
					wCurExp += iAdditionalExp;
					iAdditionalExp = 0;
					wUsedItemCount = mtrlItem->GetCount();
					break;
				}

				if (bNextLevel >= aiAuraRefineTable[AURA_REFINE_INFO_LEVEL_MAX])
				{
					if (wCurExp + mtrlItem->GetValue(ITEM_AURA_MATERIAL_EXP_VALUE) >= aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP])
					{
						wCurExp += iNeedExp;
						iAdditionalExp -= iNeedExp;
						break;
					}
				}

				if (wCurExp + mtrlItem->GetValue(ITEM_AURA_MATERIAL_EXP_VALUE) >= aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP])
				{
					wCurExp = 0;
					iAdditionalExp -= iNeedExp;
					bNextLevel += 1;
					continue;
				}

				wCurExp += mtrlItem->GetValue(ITEM_AURA_MATERIAL_EXP_VALUE);
				iAdditionalExp -= mtrlItem->GetValue(ITEM_AURA_MATERIAL_EXP_VALUE);
			}

			ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���׷��̵尡 �Ϸ�Ǿ����ϴ�."));

			auraItem->Lock(false);
			auraItem->SetSocket(ITEM_SOCKET_AURA_CURRENT_LEVEL, (1000 + bNextLevel) * 100000 + wCurExp);
			auraItem->UpdatePacket();

			sys_log(1, "%s[%d] - Aura Upgrade Success [%d][%d]", GetName(), GetPlayerID(), auraItem->GetID(), mtrlItem->GetID());

			TPacketGCAura pack;
			m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN] = NPOS;
			m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB] = NPOS;

			pack.wSize = sizeof(TPacketGCAura);
			pack.bSubHeader = AURA_SUBHEADER_GC_CLEAR_ALL;
			desc->Packet(&pack, sizeof(TPacketGCAura));

			LogManager::instance().ItemLog(this, auraItem, "AURA UPGRADE SUCCESS", auraItem->GetName());
			if (IS_SET(mtrlItem->GetFlag(), ITEM_FLAG_STACKABLE) && !IS_SET(mtrlItem->GetAntiFlag(), ITEM_ANTIFLAG_STACK) && mtrlItem->GetCount() > wUsedItemCount)
			{

				char szHint[64];
				snprintf(szHint, sizeof(szHint), "%s %u ", mtrlItem->GetName(), wUsedItemCount);
				LogManager::instance().ItemLog(this, mtrlItem, "AURA MATERIAL ITEM REMOVE (UPGRADE SUCCESS)", szHint);

				mtrlItem->Lock(false);
				mtrlItem->SetCount(mtrlItem->GetCount() - wUsedItemCount);
			}
			else
				ITEM_MANAGER::instance().RemoveItem(mtrlItem, "AURA MATERIAL ITEM REMOVE (UPGRADE SUCCESS)");
		}
		break;

		case AURA_WINDOW_TYPE_EVOLVE:
		{
			const long c_lLevelSocket = auraItem->GetSocket(ITEM_SOCKET_AURA_CURRENT_LEVEL);
			BYTE bNextLevel = (c_lLevelSocket / 100000) - 1000;
			int* aiAuraRefineTable = GetAuraRefineInfo(bNextLevel);
			WORD wCurExp = c_lLevelSocket % 100000;
			if (bNextLevel < aiAuraRefineTable[AURA_REFINE_INFO_LEVEL_MAX] || wCurExp != aiAuraRefineTable[AURA_REFINE_INFO_NEED_EXP] || aiAuraRefineTable[AURA_REFINE_INFO_STEP] == AURA_GRADE_RADIANT)
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �ƿ�� �ǻ��� �ٵ��� �� �����ϴ�."));
				if (aiAuraRefineTable[AURA_REFINE_INFO_STEP] == AURA_GRADE_RADIANT)
					ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �� �ƿ�� �ǻ��� �ִ� ������ ��޿� �����߽��ϴ�."));
				else
					ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �߰� �ܰ�� ���׷��̵� â�� ����Ͻʽÿ�."));
				return;
			}

			long long llNeedGold = static_cast<long long>(aiAuraRefineTable[AURA_REFINE_INFO_NEED_GOLD]);
			if (GetGold() < llNeedGold)
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���� �ǻ��� �ٵ�����ŭ ���� �����մϴ�."));
				return;
			}

			if (CountSpecifyItem(aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_VNUM]) < aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_COUNT])
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> �ƿ�� �ǻ��� �ٵ�� �� �ʿ��� ��ᰡ �����ϴ�."));
				return;
			}


			const BYTE c_bRefinePct = aiAuraRefineTable[AURA_REFINE_INFO_EVOLVE_PCT];
			DWORD dwRefinedAuraVnum = auraItem->GetRefineSet() == 409 ? auraItem->GetRefinedVnum() : auraItem->GetOriginalVnum();
			if (number(1, 100) <= c_bRefinePct)
			{
				LPITEM pkNewItem = ITEM_MANAGER::instance().CreateItem(dwRefinedAuraVnum, 1, 0, false);
				if (pkNewItem)
				{
					ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���׷��̵忡 �����߽��ϴ�."));

					auraItem->Lock(false);
					auraItem->CopySocketTo(pkNewItem);
					auraItem->CopyAttributeTo(pkNewItem);

					LogManager::instance().ItemLog(this, pkNewItem, "AURA REFINE SUCCESS", pkNewItem->GetName());

					sys_log(1, "%s[%d] - Aura Refine Success [%d][%d]", GetName(), GetPlayerID(), auraItem->GetID(), mtrlItem->GetID());

					ITEM_MANAGER::instance().RemoveItem(auraItem, "AURA SRC ITEM REMOVE (REFINE SUCCESS)");

					pkNewItem->SetSocket(ITEM_SOCKET_AURA_CURRENT_LEVEL, (1000 + bNextLevel + 1) * 100000);
					pkNewItem->AddToCharacter(this, m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN]);

					ITEM_MANAGER::instance().FlushDelayedSave(pkNewItem);

					if (IS_SET(mtrlItem->GetFlag(), ITEM_FLAG_STACKABLE) && !IS_SET(mtrlItem->GetAntiFlag(), ITEM_ANTIFLAG_STACK) && mtrlItem->GetCount() > aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_COUNT])
					{
						char szHint[64];
						snprintf(szHint, sizeof(szHint), "%s %u ", mtrlItem->GetName(), aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_COUNT]);
						LogManager::instance().ItemLog(this, mtrlItem, "AURA MATERIAL ITEM REMOVE (REFINE SUCCESS)", szHint);

						mtrlItem->Lock(false);
						mtrlItem->SetCount(mtrlItem->GetCount() - aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_COUNT]);
					}
					else
						ITEM_MANAGER::instance().RemoveItem(mtrlItem, "AURA MATERIAL ITEM REMOVE (REFINE SUCCESS)");

					PointChange(POINT_GOLD, -(llNeedGold), true);

					m_pAuraRefineWindowItemSlot[AURA_SLOT_MAIN] = NPOS;
					m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB] = NPOS;

					TPacketGCAura pack;
					pack.wSize = sizeof(TPacketGCAura);
					pack.bSubHeader = AURA_SUBHEADER_GC_CLEAR_ALL;
					desc->Packet(&pack, sizeof(TPacketGCAura));
				}
				else
					sys_err("aura cannot create item %lu", dwRefinedAuraVnum);
			}
			else
			{
				ChatPacket(CHAT_TYPE_INFO, LC_TEXT("<�ƿ��> ���׷��̵����� ���߽��ϴ�."));

				sys_log(1, "%s[%d] - Aura Refine Failure [%d][%d]", GetName(), GetPlayerID(), auraItem->GetID(), mtrlItem->GetID());
				LogManager::instance().ItemLog(this, auraItem, "AURA REFINE FAILED", auraItem->GetName());

				if (IS_SET(mtrlItem->GetFlag(), ITEM_FLAG_STACKABLE) && !IS_SET(mtrlItem->GetAntiFlag(), ITEM_ANTIFLAG_STACK) && mtrlItem->GetCount() > aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_COUNT])
				{
					char szHint[64];
					snprintf(szHint, sizeof(szHint), "%s %u ", mtrlItem->GetName(), aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_COUNT]);
					LogManager::instance().ItemLog(this, mtrlItem, "AURA MATERIAL ITEM REMOVE (REFINE FAIL)", szHint);

					mtrlItem->SetCount(mtrlItem->GetCount() - aiAuraRefineTable[AURA_REFINE_INFO_MATERIAL_COUNT]);
				}
				else
					ITEM_MANAGER::instance().RemoveItem(mtrlItem, "AURA MATERIAL ITEM REMOVE (REFINE FAIL)");

				auraItem->Lock(false);
				m_pAuraRefineWindowItemSlot[AURA_SLOT_SUB] = NPOS;

				TPacketGCAura pack;
				TSubPacketGCAuraClearSlot sub;
				pack.wSize = sizeof(TPacketGCAura) + sizeof(TSubPacketGCAuraClearSlot);
				pack.bSubHeader = AURA_SUBHEADER_GC_CLEAR_SLOT;
				sub.bAuraSlotPos = AURA_SLOT_SUB;

				TEMP_BUFFER buf;
				buf.write(&pack, sizeof(TPacketGCAura));
				buf.write(&sub, sizeof(TSubPacketGCAuraClearSlot));
				desc->Packet(buf.read_peek(), buf.size());
			}
		}
		break;
	}
}
#endif
