#include "stdafx.h"

#include "questlua.h"
#include "questmanager.h"
#include "monarch.h"
#include "desc_client.h"
#include "start_position.h"
#include "config.h"
#include "mob_manager.h"
#include "castle.h"
#include "dev_log.h"
#include "char.h"
#include "char_manager.h"
#include "utils.h"
#include "p2p.h"
#include "guild.h"
#include "sectree_manager.h"

#undef sys_err
#ifndef __WIN32__
#define sys_err(fmt, args...) quest::CQuestManager::instance().QuestError(__FUNCTION__, __LINE__, fmt, ##args)
#else
#define sys_err(fmt, ...) quest::CQuestManager::instance().QuestError(__FUNCTION__, __LINE__, fmt, __VA_ARGS__)
#endif

ACMD(do_monarch_mob);

namespace quest
{
	EVENTINFO(monarch_powerup_event_info)
	{
		int EmpireIndex;

		monarch_powerup_event_info()
		: EmpireIndex( 0 )
		{
		}
	};

	// NOTE: Copied from SPacketGGMonarchTransfer for event data
	EVENTINFO(monarch_transfer2_event_info)
	{
		BYTE	bHeader;
		DWORD	dwTargetPID;
		long	x;
		long	y;

		monarch_transfer2_event_info()
		: bHeader( 0 )
		, dwTargetPID( 0 )
		, x( 0 )
		, y( 0 )
		{
		}
	};

	EVENTFUNC(monarch_powerup_event)
	{
		monarch_powerup_event_info * info =  dynamic_cast<monarch_powerup_event_info*>(event->info);

		if ( info == NULL )
		{
			sys_err( "monarch_powerup_event> <Factor> Null pointer" );
			return 0;
		}

		CMonarch::instance().PowerUp(info->EmpireIndex, false);
		return 0;
	}

	EVENTINFO(monarch_defenseup_event_info)
	{
		int EmpireIndex;

		monarch_defenseup_event_info()
		: EmpireIndex( 0 )
		{
		}
	};

	EVENTFUNC(monarch_defenseup_event)
	{
		monarch_powerup_event_info * info =  dynamic_cast<monarch_powerup_event_info*>(event->info);

		if ( info == NULL )
		{
			sys_err( "monarch_defenseup_event> <Factor> Null pointer" );
			return 0;
		}

		CMonarch::instance().DefenseUp(info->EmpireIndex, false);
		return 0;
	}

	//
	// "monarch_" lua functions
	//
	ALUA(takemonarchmoney)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		int nMoney = (int)lua_tonumber(L,1);
		int nPID = ch->GetPlayerID();
		int nEmpire = ch->GetEmpire();
		nMoney = nMoney * 10000;

		sys_log(0 ,"[MONARCH] Take Money Empire(%d) pid(%d) Money(%d)", ch->GetEmpire(), ch->GetPlayerID(), nMoney);


		db_clientdesc->DBPacketHeader(HEADER_GD_TAKE_MONARCH_MONEY, ch->GetDesc()->GetHandle(), sizeof(int) * 3);
		db_clientdesc->Packet(&nEmpire, sizeof(int));
		db_clientdesc->Packet(&nPID, sizeof(int));
		db_clientdesc->Packet(&nMoney, sizeof(int));
		return 1;
	}

	ALUA(is_guild_master)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if (ch->GetGuild()	)
		{
			TGuildMember * pMember = ch->GetGuild()->GetMember(ch->GetPlayerID());

			if (pMember)
			{
				if (pMember->grade <= 4)
				{
					lua_pushnumber(L ,1);
					return 1;
				}
			}

		}
		lua_pushnumber(L ,0);

		return 1;
	}

	ALUA(monarch_bless)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if (false==ch->IsMonarch())
		{
			if (!ch->IsGM())
			{
				ch->ChatPacket(CHAT_TYPE_INFO ,LC_TEXT("������ �ڰ��� ������ ���� �ʽ��ϴ�"));
				sys_err("No Monarch pid %d ", ch->GetPlayerID());
				return 0;
			}
		}

		int HealPrice = quest::CQuestManager::instance().GetEventFlag("MonarchHealGold");
		if (HealPrice == 0)
			HealPrice = 2000000;

		if (CMonarch::instance().HealMyEmpire(ch, HealPrice))
		{
			char szNotice[256];
			snprintf(szNotice, sizeof(szNotice),
					LC_TEXT("������ �ູ���� ������ %s ������ HP,SP�� ��� ä�����ϴ�."), EMPIRE_NAME(ch->GetEmpire()));
			SendNoticeMap(szNotice, ch->GetMapIndex(), false);

			ch->ChatPacket(CHAT_TYPE_INFO ,LC_TEXT("������ �ູ�� ����Ͽ����ϴ�."));
		}

		return 1;
	}


	ALUA(monarch_powerup)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if (!ch)
			return 0;


		if (false==ch->IsMonarch())
		{
			if (!ch->IsGM())
			{
				ch->ChatPacket(CHAT_TYPE_INFO ,LC_TEXT("������ �ڰ��� ������ ���� �ʽ��ϴ�"));
				sys_err("No Monarch pid %d ", ch->GetPlayerID());
				return 0;
			}
		}


		int	money_need = 5000000;
		if (!CMonarch::instance().IsMoneyOk(money_need, ch->GetEmpire()))
		{
			int NationMoney = CMonarch::instance().GetMoney(ch->GetEmpire());
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���� ���� �����մϴ�. ���� : %u �ʿ�ݾ� : %u"), NationMoney, money_need);
			return 0;
		}

		if (!CMonarch::instance().CheckPowerUpCT(ch->GetEmpire()))
		{
			int	next_sec = CMonarch::instance().GetPowerUpCT(ch->GetEmpire()) / passes_per_sec;
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("��Ÿ�� ������  %d �� ��밡��"), next_sec);
			return 0;
		}


		CMonarch::instance().PowerUp(ch->GetEmpire(), true);


		int g_nMonarchPowerUpCT = 60 * 3;

		monarch_powerup_event_info* info = AllocEventInfo<monarch_powerup_event_info>();

		info->EmpireIndex = ch->GetEmpire();

		event_create(quest::monarch_powerup_event, info, PASSES_PER_SEC(g_nMonarchPowerUpCT));

		CMonarch::instance().SendtoDBDecMoney(5000000, ch->GetEmpire(), ch);

		char szNotice[256];
		snprintf(szNotice, sizeof(szNotice), LC_TEXT("������ ������ �������� ������ %s ������ 3�а� 10 %% �� ���ݷ���  �����˴ϴ�"), EMPIRE_NAME(ch->GetEmpire()));

		SendNoticeMap(szNotice, ch->GetMapIndex(), false);

		return 1;
	}

	ALUA(monarch_defenseup)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if (!ch)
			return 0;




		if (false==ch->IsMonarch())
		{
			if (!ch->IsGM())
			{
				ch->ChatPacket(CHAT_TYPE_INFO ,LC_TEXT("������ �ڰ��� ������ ���� �ʽ��ϴ�"));
				sys_err("No Monarch pid %d ", ch->GetPlayerID());
				return 0;
			}
		}

		int	money_need = 5000000;
		if (!CMonarch::instance().IsMoneyOk(money_need, ch->GetEmpire()))
		{
			int NationMoney = CMonarch::instance().GetMoney(ch->GetEmpire());
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���� ���� �����մϴ�. ���� : %u �ʿ�ݾ� : %u"), NationMoney, money_need);
			return 0;
		}

		if (!CMonarch::instance().CheckDefenseUpCT(ch->GetEmpire()))
		{
			int	next_sec = CMonarch::instance().GetDefenseUpCT(ch->GetEmpire()) / passes_per_sec;
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("��Ÿ�� ������  %d �� ��밡��"), next_sec);
			return 0;
		}


		CMonarch::instance().DefenseUp(ch->GetEmpire(), true);


		int g_nMonarchDefenseUpCT = 60 * 3;

		monarch_defenseup_event_info* info = AllocEventInfo<monarch_defenseup_event_info>();

		info->EmpireIndex = ch->GetEmpire();

		event_create(quest::monarch_defenseup_event, info, PASSES_PER_SEC(g_nMonarchDefenseUpCT));

		CMonarch::instance().SendtoDBDecMoney(5000000, ch->GetEmpire(), ch);

		char szNotice[256];
		snprintf(szNotice, sizeof(szNotice), LC_TEXT("������ �ݰ��� �������� ������ %s ������ 3�а� 10 %% �� ������  �����˴ϴ�"), EMPIRE_NAME(ch->GetEmpire()));

		SendNoticeMap(szNotice, ch->GetMapIndex(), false);

		return 1;
	}

	ALUA(is_monarch)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();
		if (!ch)
			return 0;
		lua_pushnumber(L, ch->IsMonarch());
		return 1;
	}

	ALUA(spawn_mob)
	{
		if (!lua_isnumber(L, 1))
		{
			sys_err("invalid argument");
			return 0;
		}

		DWORD mob_vnum = (DWORD)lua_tonumber(L, 1);

		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if (!ch)
			return 0;

		const CMob * pkMob = NULL;

		if (!(pkMob = CMobManager::Instance().Get(mob_vnum)))
			if (pkMob == NULL)
			{
				ch->ChatPacket(CHAT_TYPE_INFO, "No such mob by that vnum");
				return 0;
			}

		if (false == ch->IsMonarch())
		{
			if (!ch->IsGM())
			{
				ch->ChatPacket(CHAT_TYPE_INFO ,LC_TEXT("������ �ڰ��� ������ ���� �ʽ��ϴ�"));
				sys_err("No Monarch pid %d ", ch->GetPlayerID());
				return 0;
			}
		}

		DWORD dwQuestIdx = CQuestManager::instance().GetCurrentPC()->GetCurrentQuestIndex();

		bool ret = false;
		LPCHARACTER mob = NULL;

		{
			long x = ch->GetX();
			long y = ch->GetY();
#if 0
			if (11505 == mob_vnum)
			{

				if (!CMonarch::instance().IsMoneyOk(CASTLE_FROG_PRICE, ch->GetEmpire()))
				{
					int NationMoney = CMonarch::instance().GetMoney(ch->GetEmpire());
					ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���� ���� �����մϴ�. ���� : %u �ʿ�ݾ� : %u"), NationMoney, CASTLE_FROG_PRICE);
					return 0;
				}

				mob = castle_spawn_frog(ch->GetEmpire());

				if (mob)
				{

					CMonarch::instance().SendtoDBDecMoney(CASTLE_FROG_PRICE, ch->GetEmpire(), ch);
					castle_save();
				}
			}
			else
#endif
			{
				mob = CHARACTER_MANAGER::instance().SpawnMob(mob_vnum, ch->GetMapIndex(), x, y, 0, pkMob->m_table.bType == CHAR_TYPE_STONE, -1);
			}

			if (mob)
			{
				//if (bAggressive)
				//	mob->SetAggressive();

				mob->SetQuestBy(dwQuestIdx);

				if (!ret)
				{
					ret = true;
					lua_pushnumber(L, (DWORD) mob->GetVID());
				}
			}
		}

		return 1;
	}

	ALUA(spawn_guard)
	{
		// mob_level(0-2), region(0~3)
		if (!lua_isnumber(L, 1) || !lua_isnumber(L, 2))
		{
			sys_err("invalid argument");
			return 0;
		}

		DWORD	group_vnum		= (DWORD)lua_tonumber(L,1);
		int		region_index	= (int)lua_tonumber(L, 2);
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();
		if (!ch)
			return 0;

		/*-----
		const CMob * pkMob = NULL;
		if (!(pkMob = CMobManager::Instance().Get(mob_vnum)))

		if (pkMob == NULL)
		{
			ch->ChatPacket(CHAT_TYPE_INFO, "No such mob by that vnum");
			return 0;
		}
		-----*/

		if (false==ch->IsMonarch())
		{
			if (!ch->IsGM())
			{
				ch->ChatPacket(CHAT_TYPE_INFO ,LC_TEXT("������ �ڰ��� ������ ���� �ʽ��ϴ�"));
				sys_err("No Monarch pid %d ", ch->GetPlayerID());
				return 0;
			}
		}

		if (false==castle_is_my_castle(ch->GetEmpire(), ch->GetMapIndex()))
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("�������� ����� �� �ִ� ����Դϴ�."));
			return 0;
		}

		//DWORD 			dwQuestIdx 	= CQuestManager::instance().GetCurrentPC()->GetCurrentQuestIndex();

		LPCHARACTER		guard_leader = NULL;
		{
			int	money_need = castle_cost_of_hiring_guard(group_vnum);


			if (!CMonarch::instance().IsMoneyOk(money_need, ch->GetEmpire()))
			{
				int NationMoney = CMonarch::instance().GetMoney(ch->GetEmpire());
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���� ���� �����մϴ�. ���� : %u �ʿ�ݾ� : %u"), NationMoney, money_need);
				return 0;
			}
			guard_leader = castle_spawn_guard(ch->GetEmpire(), group_vnum, region_index);

			if (guard_leader)
			{

				CMonarch::instance().SendtoDBDecMoney(money_need, ch->GetEmpire(), ch);
				castle_save();
			}
		}

		return 1;
	}

	ALUA(frog_to_empire_money)
	{
		LPCHARACTER ch	= CQuestManager::instance().GetCurrentCharacterPtr();

		if (NULL==ch)
			return false;

		if (!ch->IsMonarch())
		{
			if (!ch->IsGM())
			{
				ch->ChatPacket(CHAT_TYPE_INFO ,LC_TEXT("������ �ڰ��� ������ ���� �ʽ��ϴ�"));
				sys_err("No Monarch pid %d ", ch->GetPlayerID());
				return 0;
			}
		}

		if (castle_frog_to_empire_money(ch))
		{
			int empire_money = CMonarch::instance().GetMoney(ch->GetEmpire());
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("TEST : Ȳ�ݵβ��� ����� ȯ���Ǿ����ϴ�."));
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("TEST : ���� ���� : %d"), empire_money);
			castle_save();
			return 1;
		}
		else
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("TEST : Ȳ�ݵβ��� ����� ȯ���� �� �����ϴ�."));
			return 0;
		}
	}

	ALUA(monarch_warp)
	{
		if (!lua_isstring(L, 1))
		{
			sys_err("invalid argument");
			return 0;
		}

		std::string name = lua_tostring(L, 1);

		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();
		if (!ch)
			return 0;



		if (!CMonarch::instance().IsMonarch(ch->GetPlayerID(), ch->GetEmpire()))
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���ָ��� ��� ������ ����Դϴ�"));
			return 0;
		}


		if (!ch->IsMCOK(CHARACTER::MI_WARP))
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("%d �ʰ� ��Ÿ���� �������Դϴ�."), ch->GetMCLTime(CHARACTER::MI_WARP));
			return 0;
		}



		const int WarpPrice = 10000;


		if (!CMonarch::instance().IsMoneyOk(WarpPrice, ch->GetEmpire()))
		{
			int NationMoney = CMonarch::instance().GetMoney(ch->GetEmpire());
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���� ���� �����մϴ�. ���� : %u �ʿ�ݾ� : %u"), NationMoney, WarpPrice);
			return 0;
		}

		int x, y;

		LPCHARACTER tch = CHARACTER_MANAGER::instance().FindPC(name.c_str());

		if (!tch)
		{
			CCI * pkCCI = P2P_MANAGER::instance().Find(name.c_str());

			if (pkCCI)
			{
				if (pkCCI->bEmpire != ch->GetEmpire())
				{
					ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Ÿ���� �������Դ� �̵��Ҽ� �����ϴ�"));
					return 0;
				}
				if (pkCCI->bChannel != g_bChannel)
				{
					ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("�ش� ������ %d ä�ο� �ֽ��ϴ�. (���� ä�� %d)"), pkCCI->bChannel, g_bChannel);
					return 0;
				}

				if (!IsMonarchWarpZone(pkCCI->lMapIndex))
				{
					ch->ChatPacket (CHAT_TYPE_INFO, LC_TEXT("�ش� �������� �̵��� �� �����ϴ�."));
					return 0;
				}

				PIXEL_POSITION pos;

				if (!SECTREE_MANAGER::instance().GetCenterPositionOfMap(pkCCI->lMapIndex, pos))
					ch->ChatPacket(CHAT_TYPE_INFO, "Cannot find map (index %d)", pkCCI->lMapIndex);
				else
				{
					//ch->ChatPacket(CHAT_TYPE_INFO, "You warp to (%d, %d)", pos.x, pos.y);
					ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("%s ���Է� �̵��մϴ�"), name.c_str());
					ch->WarpSet(pos.x, pos.y);


					CMonarch::instance().SendtoDBDecMoney(WarpPrice, ch->GetEmpire(), ch);


					ch->SetMC(CHARACTER::MI_WARP);
				}

			}
			else if (NULL == CHARACTER_MANAGER::instance().FindPC(name.c_str()))
			{
				ch->ChatPacket(CHAT_TYPE_INFO, "There is no one by that name");
			}

			return 0;
		}
		else
		{
			if (tch->GetEmpire() != ch->GetEmpire())
			{
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("Ÿ���� �������Դ� �̵��Ҽ� �����ϴ�"));
				return 0;
			}

			if (!IsMonarchWarpZone(tch->GetMapIndex()))
			{
				ch->ChatPacket (CHAT_TYPE_INFO, LC_TEXT("�ش� �������� �̵��� �� �����ϴ�."));
				return 0;
			}

			x = tch->GetX();
			y = tch->GetY();
		}

		ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("%s ���Է� �̵��մϴ�"), name.c_str());
		ch->WarpSet(x,y);
		ch->Stop();


		CMonarch::instance().SendtoDBDecMoney(WarpPrice, ch->GetEmpire(), ch);


		ch->SetMC(CHARACTER::MI_WARP);

		return 0;
	}

	ALUA(empire_info)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if (NULL == ch)
			return false;

		TMonarchInfo * p = CMonarch::instance().GetMonarch();

		if (CMonarch::instance().IsMonarch(ch->GetPlayerID(), ch->GetEmpire()))
		{
			ch->ChatPacket(CHAT_TYPE_INFO,LC_TEXT("���� ���� ����"));

			for (int n = 1; n < 4; ++n)
			{
				if (n == ch->GetEmpire())
					ch->ChatPacket(CHAT_TYPE_INFO,LC_TEXT("[%s����] : %s  �����ݾ� %lld "), EMPIRE_NAME(n), p->name[n], p->money[n]);
				else
					ch->ChatPacket(CHAT_TYPE_INFO,LC_TEXT("[%s����] : %s  "), EMPIRE_NAME(n), p->name[n]);
			}
		}
		else
		{
			ch->ChatPacket(CHAT_TYPE_INFO,LC_TEXT("���� ����"));

			for (int n = 1; n < 4; ++n)
				ch->ChatPacket(CHAT_TYPE_INFO,LC_TEXT("[%s����] : %s  "), EMPIRE_NAME(n), p->name[n]);
		}

		return 0;
	}

	ALUA(monarch_transfer)
	{
		if (!lua_isstring(L, 1))
		{
			sys_err("invalid argument");
			return 0;
		}

		std::string name = lua_tostring(L, 1);

		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if (!ch)
			return 0;

		if (!CMonarch::instance().IsMonarch(ch->GetPlayerID(), ch->GetEmpire()))
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���ָ��� ��� ������ ����Դϴ�"));
			return 0;
		}


		if (!ch->IsMCOK(CHARACTER::MI_TRANSFER))
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("%d �ʰ� ��Ÿ���� �������Դϴ�."), ch->GetMCLTime(CHARACTER::MI_TRANSFER));
			return 0;
		}


		const int WarpPrice = 10000;


		if (!CMonarch::instance().IsMoneyOk(WarpPrice, ch->GetEmpire()))
		{
			int NationMoney = CMonarch::instance().GetMoney(ch->GetEmpire());
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���� ���� �����մϴ�. ���� : %u �ʿ�ݾ� : %u"), NationMoney, WarpPrice);
			return 0;
		}

		LPCHARACTER tch = CHARACTER_MANAGER::instance().FindPC(name.c_str());

		if (!tch)
		{
			CCI * pkCCI = P2P_MANAGER::instance().Find(name.c_str());

			if (pkCCI)
			{
				if (pkCCI->bEmpire != ch->GetEmpire())
				{
					ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("�ٸ� ���� ������ ��ȯ�� �� �����ϴ�."));
					return 0;
				}

				if (pkCCI->bChannel != g_bChannel)
				{
					ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("%s ���� %d ä�ο� ���� �� �Դϴ�. (���� ä��: %d)"), name.c_str(), pkCCI->bChannel, g_bChannel);
					return 0;
				}

				if (!IsMonarchWarpZone(pkCCI->lMapIndex))
				{
					ch->ChatPacket (CHAT_TYPE_INFO, LC_TEXT("�ش� �������� �̵��� �� �����ϴ�."));
					return 0;
				}
				if (!IsMonarchWarpZone(ch->GetMapIndex()))
				{
					ch->ChatPacket (CHAT_TYPE_INFO, LC_TEXT("�ش� �������� ��ȯ�� �� �����ϴ�."));
					return 0;
				}

				TPacketGGTransfer pgg;

				pgg.bHeader = HEADER_GG_TRANSFER;
				strlcpy(pgg.szName, name.c_str(), sizeof(pgg.szName));
				pgg.lX = ch->GetX();
				pgg.lY = ch->GetY();

				P2P_MANAGER::instance().Send(&pgg, sizeof(TPacketGGTransfer));
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("%s ���� ��ȯ�Ͽ����ϴ�."), name.c_str());


				CMonarch::instance().SendtoDBDecMoney(WarpPrice, ch->GetEmpire(), ch);


				ch->SetMC(CHARACTER::MI_TRANSFER);
			}
			else
			{
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("�Է��Ͻ� �̸��� ���� ����ڰ� �����ϴ�."));
			}

			return 0;
		}

		if (ch == tch)
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("�ڽ��� ��ȯ�� �� �����ϴ�."));
			return 0;
		}

		if (tch->GetEmpire() != ch->GetEmpire())
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("�ٸ� ���� ������ ��ȯ�� �� �����ϴ�."));
			return 0;
		}

		if (!IsMonarchWarpZone(tch->GetMapIndex()))
		{
			ch->ChatPacket (CHAT_TYPE_INFO, LC_TEXT("�ش� �������� �̵��� �� �����ϴ�."));
			return 0;
		}
		if (!IsMonarchWarpZone(ch->GetMapIndex()))
		{
			ch->ChatPacket (CHAT_TYPE_INFO, LC_TEXT("�ش� �������� ��ȯ�� �� �����ϴ�."));
			return 0;
		}
		tch->WarpSet(ch->GetX(), ch->GetY(), ch->GetMapIndex());


		CMonarch::instance().SendtoDBDecMoney(WarpPrice, ch->GetEmpire(), ch);

		ch->SetMC(CHARACTER::MI_TRANSFER);
		return 0;
	}

	ALUA(monarch_notice)
	{
		if (!lua_isstring(L, 1))
			return 0;

		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if (ch == NULL)
			return 0;

		if (ch->IsMonarch() == false)
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���ָ��� ��� ������ ����Դϴ�"));
			return 0;
		}

		std::string strNotice = lua_tostring(L, 1);

		if (strNotice.length() > 0)
			SendMonarchNotice(ch->GetEmpire(), strNotice.c_str());

		return 0;
	}

	ALUA(monarch_mob)
	{
		if (!lua_isstring(L, 1))
			return 0;

		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if (ch == NULL)
			return 0;

		char vnum[256];
		strlcpy(vnum, lua_tostring(L, 1), sizeof(vnum));
		do_monarch_mob(ch, vnum, 0, 0);
		return 0;
	}

	EVENTFUNC(monarch_transfer2_event)
	{
		monarch_transfer2_event_info* info = dynamic_cast<monarch_transfer2_event_info*>(event->info);

		if ( info == NULL )
		{
			sys_err( "monarch_transfer2_event> <Factor> Null pointer" );
			return 0;
		}

		LPCHARACTER pTargetChar = CHARACTER_MANAGER::instance().FindByPID(info->dwTargetPID);

		if (pTargetChar != NULL)
		{
			unsigned int qIndex = quest::CQuestManager::instance().GetQuestIndexByName("monarch_transfer");

			if (qIndex != 0)
			{
				pTargetChar->SetQuestFlag("monarch_transfer.x", info->x);
				pTargetChar->SetQuestFlag("monarch_transfer.y", info->y);
				quest::CQuestManager::instance().Letter(pTargetChar->GetPlayerID(), qIndex, 0);
			}
		}

		return 0;
	}

	ALUA(monarch_transfer2)
	{
		if (lua_isstring(L, 1) == false) return 0;

		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();
		if (ch == NULL) return false;

		if (CMonarch::instance().IsMonarch(ch->GetPlayerID(), ch->GetEmpire()) == false)
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���ָ��� ��� ������ ����Դϴ�"));
			return 0;
		}

		if (ch->IsMCOK(CHARACTER::MI_TRANSFER) == false)
		{
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("%d �ʰ� ��Ÿ���� �������Դϴ�."), ch->GetMCLTime(CHARACTER::MI_TRANSFER));
			return 0;
		}

		const int ciTransferCost = 10000;

		if (CMonarch::instance().IsMoneyOk(ciTransferCost, ch->GetEmpire()) == false)
		{
			int NationMoney = CMonarch::instance().GetMoney(ch->GetEmpire());
			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("���� ���� �����մϴ�. ���� : %u �ʿ�ݾ� : %u"), NationMoney, ciTransferCost);
			return 0;
		}

		std::string strTargetName = lua_tostring(L, 1);

		LPCHARACTER pTargetChar = CHARACTER_MANAGER::instance().FindPC(strTargetName.c_str());

		if (pTargetChar == NULL)
		{
			CCI* pCCI = P2P_MANAGER::instance().Find(strTargetName.c_str());

			if (pCCI != NULL)
			{
				if (pCCI->bEmpire != ch->GetEmpire())
				{
					ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("�ٸ� ���� ������ ��ȯ�� �� �����ϴ�."));
					return 0;
				}

				if (pCCI->bChannel != g_bChannel)
				{
					ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("%s ���� %d ä�ο� �������Դϴ�. (���� ä��: %d)"),
						   strTargetName.c_str(), pCCI->bChannel, g_bChannel);
					return 0;
				}

				if (!IsMonarchWarpZone(pCCI->lMapIndex))
				{
					ch->ChatPacket (CHAT_TYPE_INFO, LC_TEXT("�ش� �������� �̵��� �� �����ϴ�."));
					return 0;
				}
				if (!IsMonarchWarpZone(ch->GetMapIndex()))
				{
					ch->ChatPacket (CHAT_TYPE_INFO, LC_TEXT("�ش� �������� ��ȯ�� �� �����ϴ�."));
					return 0;
				}

				TPacketMonarchGGTransfer packet;
				packet.bHeader = HEADER_GG_MONARCH_TRANSFER;
				packet.dwTargetPID = pCCI->dwPID;
				packet.x = ch->GetX();
				packet.y = ch->GetY();

				P2P_MANAGER::instance().Send(&packet, sizeof(TPacketMonarchGGTransfer));
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("��ȯ ��û�� ���½��ϴ�"));

				CMonarch::instance().SendtoDBDecMoney(ciTransferCost, ch->GetEmpire(), ch);
				ch->SetMC(CHARACTER::MI_TRANSFER);
			}
			else
			{
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("�Է��Ͻ� �̸��� ���� ����ڰ� �����ϴ�."));
				return 0;
			}
		}
		else
		{
			if (pTargetChar == ch)
			{
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("�ڽ��� ��ȯ�� �� �����ϴ�."));
				return 0;
			}

			if (pTargetChar->GetEmpire() != ch->GetEmpire())
			{
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("�ٸ� ���� ������ ��ȯ�� �� �����ϴ�."));
				return 0;
			}

			if (DISTANCE_APPROX(pTargetChar->GetX() - ch->GetX(), pTargetChar->GetY() - ch->GetY()) <= 5000)
			{
				ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("%s ���� ��ó�� �ֽ��ϴ�"), pTargetChar->GetName());
				return 0;
			}

			if (!IsMonarchWarpZone(pTargetChar->GetMapIndex()))
			{
				ch->ChatPacket (CHAT_TYPE_INFO, LC_TEXT("�ش� �������� �̵��� �� �����ϴ�."));
				return 0;
			}
			if (!IsMonarchWarpZone(ch->GetMapIndex()))
			{
				ch->ChatPacket (CHAT_TYPE_INFO, LC_TEXT("�ش� �������� ��ȯ�� �� �����ϴ�."));
				return 0;
			}

			monarch_transfer2_event_info* info = AllocEventInfo<monarch_transfer2_event_info>();

			info->bHeader = HEADER_GG_MONARCH_TRANSFER;
			info->dwTargetPID = pTargetChar->GetPlayerID();
			info->x = ch->GetX();
			info->y = ch->GetY();

			event_create(monarch_transfer2_event, info, 1);

			ch->ChatPacket(CHAT_TYPE_INFO, LC_TEXT("��ȯ ��û�� ���½��ϴ�"));

			CMonarch::instance().SendtoDBDecMoney(ciTransferCost, ch->GetEmpire(), ch);
			ch->SetMC(CHARACTER::MI_TRANSFER);
			return 0;
		}

		return 0;
	}

	void RegisterMonarchFunctionTable()
	{
		luaL_reg Monarch_functions[] =
		{
			{ "takemonarchmoney",		takemonarchmoney	},
			{ "isguildmaster",			is_guild_master		},
			{ "ismonarch",				is_monarch 			},
			{ "monarchbless",			monarch_bless		},
			{ "monarchpowerup",			monarch_powerup		},
			{ "monarchdefenseup",		monarch_defenseup	},
			{ "spawnmob",				spawn_mob			},
			{ "spawnguard",				spawn_guard			},
//			{ "frog_to_empire_money",	frog_to_empire_money		},
			{ "warp",					monarch_warp 		},
			{ "transfer",				monarch_transfer	},
			{ "transfer2",				monarch_transfer2	},
			{ "info",					empire_info 		},
			{ "notice",					monarch_notice		},
			{ "monarch_mob",			monarch_mob			},

			{ NULL,						NULL				}
		};

		CQuestManager::instance().AddLuaFunctionTable("oh", Monarch_functions);
	}

}

