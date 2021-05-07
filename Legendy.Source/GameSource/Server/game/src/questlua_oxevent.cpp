
#include "stdafx.h"
#include "questmanager.h"
#include "char.h"
#include "char_manager.h"
#include "OXEvent.h"
#include "config.h"
#include "locale_service.h"

#ifdef ENABLE_NEWSTUFF
static std::string stOxQuizFileName("");

void __SetOxQuizFileName(const char* szOxQuizFN=NULL, bool bAddLocale=true);
std::string & __GetOxQuizFileName();

void __SetOxQuizFileName(const char* szOxQuizFN, bool bAddLocale)
{
	if (szOxQuizFN==NULL)
		szOxQuizFN = "oxquiz.lua";
	char script[256];
	if (bAddLocale)
		snprintf(script, sizeof(script), "%s/%s", LocaleService_GetBasePath().c_str(), szOxQuizFN);
	else
		snprintf(script, sizeof(script), "%s", szOxQuizFN);
	stOxQuizFileName = script;
}

std::string & __GetOxQuizFileName()
{
	if (stOxQuizFileName.empty())
		__SetOxQuizFileName();
	return stOxQuizFileName;
}
#endif

namespace quest
{
	ALUA(oxevent_get_status)
	{
		OXEventStatus ret = COXEventManager::instance().GetStatus();

		lua_pushnumber(L, (int)ret);

		return 1;
	}
#ifdef ENABLE_NEWSTUFF
	ALUA(oxevent_get_oxquiz_fn)
	{
		lua_pushstring(L, __GetOxQuizFileName().c_str());
		return 1;
	}

	ALUA(oxevent_set_oxquiz_fn)
	{
		__SetOxQuizFileName(lua_tostring(L, 1));
		return 0;
	}

	ALUA(oxevent_set_oxquiz_fn0)
	{
		__SetOxQuizFileName(lua_tostring(L, 1), false);
		return 0;
	}
#endif
	ALUA(oxevent_open)
	{
		COXEventManager::instance().ClearQuiz();

#ifdef ENABLE_NEWSTUFF
		int result = lua_dofile(quest::CQuestManager::instance().GetLuaState(), __GetOxQuizFileName().c_str());
#else
		char script[256];
		snprintf(script, sizeof(script), "%s/oxquiz.lua", LocaleService_GetBasePath().c_str());
		int result = lua_dofile(quest::CQuestManager::instance().GetLuaState(), script);
#endif

		if (result != 0)
		{
			lua_pushnumber(L, 0);
			return 1;
		}
		else
		{
			lua_pushnumber(L, 1);
		}

		COXEventManager::instance().SetStatus(OXEVENT_OPEN);

		return 1;
	}

	ALUA(oxevent_close)
	{
		COXEventManager::instance().SetStatus(OXEVENT_CLOSE);

		return 0;
	}

	ALUA(oxevent_quiz)
	{
		if (lua_isnumber(L, 1) && lua_isnumber(L, 2))
		{
			bool ret = COXEventManager::instance().Quiz((int)lua_tonumber(L, 1), (int)lua_tonumber(L, 2));

			if (ret == false)
			{
				lua_pushnumber(L, 0);
			}
			else
			{
				lua_pushnumber(L, 1);
			}
		}

		return 1;
	}

	ALUA(oxevent_get_attender)
	{
		lua_pushnumber(L, (int)COXEventManager::instance().GetAttenderCount());
		return 1;
	}

	EVENTINFO(end_oxevent_info)
	{
		int empty;

		end_oxevent_info()
		: empty( 0 )
		{
		}
	};

	EVENTFUNC(end_oxevent)
	{
		COXEventManager::instance().CloseEvent();
		return 0;
	}

	ALUA(oxevent_end_event)
	{
		COXEventManager::instance().SetStatus(OXEVENT_FINISH);

		end_oxevent_info* info = AllocEventInfo<end_oxevent_info>();
		event_create(end_oxevent, info, PASSES_PER_SEC(5));

		return 0;
	}

	ALUA(oxevent_end_event_force)
	{
		COXEventManager::instance().CloseEvent();
		COXEventManager::instance().SetStatus(OXEVENT_FINISH);

		return 0;
	}

	ALUA(oxevent_give_item)
	{
		if (lua_isnumber(L, 1) && lua_isnumber(L, 2))
		{
			COXEventManager::instance().GiveItemToAttender((int)lua_tonumber(L, 1), (int)lua_tonumber(L, 2));
		}

		return 0;
	}

	void RegisterOXEventFunctionTable()
	{
		luaL_reg oxevent_functions[] =
		{
			{	"get_status",	oxevent_get_status	},
			{	"open",			oxevent_open		},
			{	"close",		oxevent_close		},
			{	"quiz",			oxevent_quiz		},
			{	"get_attender",	oxevent_get_attender},
			{	"end_event",	oxevent_end_event	},
			{	"end_event_force",	oxevent_end_event_force	},
			{	"give_item",	oxevent_give_item	},
#ifdef ENABLE_NEWSTUFF
			{	"get_oxquiz_fn",	oxevent_get_oxquiz_fn	}, // [return lua string]
			{	"set_oxquiz_fn",	oxevent_set_oxquiz_fn	}, // [return nothing]
			{	"set_oxquiz_fn0",	oxevent_set_oxquiz_fn0	}, // [return nothing]
			{	"set_oxquiz_fn_ex",	oxevent_set_oxquiz_fn0	}, // [return nothing]
#endif
			{ NULL, NULL}
		};

		CQuestManager::instance().AddLuaFunctionTable("oxevent", oxevent_functions);
	}
}

