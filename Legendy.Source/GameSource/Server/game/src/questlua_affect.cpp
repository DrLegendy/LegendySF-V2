#include "stdafx.h"
#include "config.h"
#include "questmanager.h"
#include "sectree_manager.h"
#include "char.h"
#include "affect.h"
#include "db.h"

namespace quest
{
	//
	// "affect" Lua functions
	//
	ALUA(affect_add)
	{
		if (!lua_isnumber(L, 1) || !lua_isnumber(L, 2) || !lua_isnumber(L, 3))
		{
			sys_err("invalid argument");
			return 0;
		}

		CQuestManager & q = CQuestManager::instance();

		BYTE applyOn = (BYTE) lua_tonumber(L, 1);

		LPCHARACTER ch = q.GetCurrentCharacterPtr();

		if (applyOn >= MAX_APPLY_NUM || applyOn < 1)
		{
			sys_err("apply is out of range : %d", applyOn);
			return 0;
		}

		if (ch->FindAffect(AFFECT_QUEST_START_IDX, applyOn))
			return 0;

		long value = (long) lua_tonumber(L, 2);
		long duration = (long) lua_tonumber(L, 3);

		ch->AddAffect(AFFECT_QUEST_START_IDX, aApplyInfo[applyOn].bPointType, value, 0, duration, 0, false);

		return 0;
	}

	ALUA(affect_remove)
	{
		CQuestManager & q = CQuestManager::instance();
		int iType;

		if (lua_isnumber(L, 1))
		{
			iType = (int) lua_tonumber(L, 1);

			if (iType == 0)
				iType = q.GetCurrentPC()->GetCurrentQuestIndex() + AFFECT_QUEST_START_IDX;
		}
		else
			iType = q.GetCurrentPC()->GetCurrentQuestIndex() + AFFECT_QUEST_START_IDX;

		q.GetCurrentCharacterPtr()->RemoveAffect(iType);

		return 0;
	}

	ALUA(affect_remove_bad)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();
		ch->RemoveBadAffect();
		return 0;
	}

	ALUA(affect_remove_good)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();
		ch->RemoveGoodAffect();
		return 0;
	}

	ALUA(affect_add_hair)
	{
		if (!lua_isnumber(L, 1) || !lua_isnumber(L, 2) || !lua_isnumber(L, 3))
		{
			sys_err("invalid argument");
			return 0;
		}

		CQuestManager & q = CQuestManager::instance();

		BYTE applyOn = (BYTE) lua_tonumber(L, 1);

		LPCHARACTER ch = q.GetCurrentCharacterPtr();

		if (applyOn >= MAX_APPLY_NUM || applyOn < 1)
		{
			sys_err("apply is out of range : %d", applyOn);
			return 0;
		}

		long value = (long) lua_tonumber(L, 2);
		long duration = (long) lua_tonumber(L, 3);

		ch->AddAffect(AFFECT_HAIR, aApplyInfo[applyOn].bPointType, value, 0, duration, 0, false);

		return 0;
	}

	ALUA(affect_remove_hair)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		CAffect* pkAff = ch->FindAffect( AFFECT_HAIR );

		if ( pkAff != NULL )
		{
			lua_pushnumber(L, pkAff->lDuration);
			ch->RemoveAffect( pkAff );
		}
		else
		{
			lua_pushnumber(L, 0);
		}

		return 1;
	}


	// usage :	applyOn = affect.get_apply(AFFECT_TYPE)
	ALUA(affect_get_apply_on)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if (!lua_isnumber(L, 1))
		{
			sys_err("invalid argument");
			return 0;
		}

		DWORD affectType = lua_tonumber(L, 1);

		CAffect* pkAff = ch->FindAffect(affectType);

		if ( pkAff != NULL )
			lua_pushnumber(L, pkAff->bApplyOn);
		else
			lua_pushnil(L);

		return 1;

	}

	ALUA(affect_add_collect)
	{
		if (!lua_isnumber(L, 1) || !lua_isnumber(L, 2) || !lua_isnumber(L, 3))
		{
			sys_err("invalid argument");
			return 0;
		}

		CQuestManager & q = CQuestManager::instance();

		BYTE applyOn = (BYTE) lua_tonumber(L, 1);

		LPCHARACTER ch = q.GetCurrentCharacterPtr();

		if (applyOn >= MAX_APPLY_NUM || applyOn < 1)
		{
			sys_err("apply is out of range : %d", applyOn);
			return 0;
		}

		long value = (long) lua_tonumber(L, 2);
		long duration = (long) lua_tonumber(L, 3);

		ch->AddAffect(AFFECT_COLLECT, aApplyInfo[applyOn].bPointType, value, 0, duration, 0, false);

		return 0;
	}

	ALUA(affect_add_collect_point)
	{
		if (!lua_isnumber(L, 1) || !lua_isnumber(L, 2) || !lua_isnumber(L, 3))
		{
			sys_err("invalid argument");
			return 0;
		}

		CQuestManager & q = CQuestManager::instance();

		BYTE point_type = (BYTE) lua_tonumber(L, 1);

		LPCHARACTER ch = q.GetCurrentCharacterPtr();

		if (point_type >= POINT_MAX_NUM || point_type < 1)
		{
			sys_err("point is out of range : %d", point_type);
			return 0;
		}

		long value = (long) lua_tonumber(L, 2);
		long duration = (long) lua_tonumber(L, 3);

		ch->AddAffect(AFFECT_COLLECT, point_type, value, 0, duration, 0, false);

		return 0;
	}

	ALUA(affect_remove_collect)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if ( ch != NULL )
		{
			BYTE bApply = (BYTE)lua_tonumber(L, 1);

			if ( bApply >= MAX_APPLY_NUM ) return 0;

			bApply = aApplyInfo[bApply].bPointType;
			long value = (long)lua_tonumber(L, 2);

			const std::list<CAffect*>& rList = ch->GetAffectContainer();
			const CAffect* pAffect = NULL;

			for ( std::list<CAffect*>::const_iterator iter = rList.begin(); iter != rList.end(); ++iter )
			{
				pAffect = *iter;

				if ( pAffect->dwType == AFFECT_COLLECT )
				{
					if ( pAffect->bApplyOn == bApply && pAffect->lApplyValue == value )
					{
						break;
					}
				}

				pAffect = NULL;
			}

			if ( pAffect != NULL )
			{
				ch->RemoveAffect( const_cast<CAffect*>(pAffect) );
			}
		}

		return 0;
	}

	ALUA(affect_remove_all_collect)
	{
		LPCHARACTER ch = CQuestManager::instance().GetCurrentCharacterPtr();

		if ( ch != NULL )
		{
			ch->RemoveAffect(AFFECT_COLLECT);
		}

		return 0;
	}

	void RegisterAffectFunctionTable()
	{
		luaL_reg affect_functions[] =
		{
			{ "add",		affect_add		},
			{ "remove",		affect_remove		},
			{ "remove_bad",	affect_remove_bad	},
			{ "remove_good",	affect_remove_good	},
			{ "add_hair",		affect_add_hair		},
			{ "remove_hair",	affect_remove_hair		},
			{ "add_collect",		affect_add_collect		},
			{ "add_collect_point",		affect_add_collect_point		},
			{ "remove_collect",		affect_remove_collect	},
			{ "remove_all_collect",	affect_remove_all_collect	},
			{ "get_apply_on",	affect_get_apply_on },

			{ NULL,		NULL			}
		};

		CQuestManager::instance().AddLuaFunctionTable("affect", affect_functions);
	}
};
