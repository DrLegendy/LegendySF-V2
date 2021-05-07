
#include "stdafx.h"
#include "questmanager.h"
#include "BattleArena.h"

namespace quest
{
	ALUA(ba_start)
	{
		if ( lua_isnumber(L, 1) )
		{
			CBattleArena::instance().Start((int)lua_tonumber(L, 1));
		}

		return 0;
	}

	void RegisterBattleArenaFunctionTable()
	{
		luaL_reg ba_functions[] =
		{
			{	"start",	ba_start	},

			{	NULL,		NULL		}
		};

		CQuestManager::instance(). AddLuaFunctionTable("ba", ba_functions);
	}
}

