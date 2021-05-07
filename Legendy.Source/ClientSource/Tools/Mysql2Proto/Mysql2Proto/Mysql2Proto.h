#pragma once
#define _WINSOCKAPI_
#define _USE_32BIT_TIME_T

// #include <cstdlib>
#include <cstdio>
#include <ctime>

#include <iostream>
#include <string>

#include <set>
#include <map>
#include <list>

#include "lzo.h"
#pragma comment(lib, "lzo.lib")

#include "Singleton.h"

#include "../../../Client/GameLib/StdAfx.h"
#include "../../../Client/GameLib/ItemData.h"

#include "../../../Client/UserInterface/StdAfx.h"
#include "../../../Client/UserInterface/PythonNonPlayer.h"

inline bool operator<(const CItemData::TItemTable& lhs, const CItemData::TItemTable& rhs)
{
	return lhs.dwVnum < rhs.dwVnum;
}

#include "MysqlWrapper.h"
#include "utils.h"

#define VERIFY_IFIELD(x,y) if (data[x]!=NULL && data[x][0]!='\0') str_to_number(y, data[x]);
#define VERIFY_SFIELD(x,y) if (data[x]!=NULL && data[x][0]!='\0') strncpy_s(y, sizeof(y), data[x], _TRUNCATE);

#define ENABLE_AUTODETECT_VNUMRANGE
#define ENABLE_LIMIT_TYPE_CHECK_FIX
#define ENABLE_ADDONTYPE_AUTODETECT

namespace MProto
{
enum MProtoT
{
	vnum, name, locale_name, type, rank, battle_type, level, size,
	ai_flag, setRaceFlag, setImmuneFlag, on_click, empire, drop_item,
	resurrection_vnum, folder, st, dx, ht, iq, damage_min, damage_max, max_hp,
	regen_cycle, regen_percent, exp, gold_min, gold_max, def,
	attack_speed, move_speed, aggressive_hp_pct, aggressive_sight, attack_range, polymorph_item,
	enchant_curse, enchant_slow, enchant_poison, enchant_stun, enchant_critical, enchant_penetrate,
	resist_sword, resist_twohand, resist_dagger, resist_bell, resist_fan, resist_bow,
	resist_fire, resist_elect, resist_magic, resist_wind, resist_poison, dam_multiply, summon, drain_sp,
	mob_color,
	skill_vnum0, skill_level0, skill_vnum1, skill_level1, skill_vnum2, skill_level2, skill_vnum3, skill_level3,
	skill_vnum4, skill_level4, sp_berserk, sp_stoneskin, sp_godspeed, sp_deathblow, sp_revive
};
};

namespace IProto
{
enum IProtoT
{
	vnum, type, subtype, name, locale_name, gold, shop_buy_price, weight, size,
	flag, wearflag, antiflag, immuneflag, refined_vnum, refine_set, magic_pct,
	specular,
	socket_pct, addon_type, limittype0, limitvalue0, limittype1, limitvalue1,
	applytype0, applyvalue0, applytype1, applyvalue1, applytype2, applyvalue2,
	value0, value1, value2, value3, value4, value5
#if !defined(ENABLE_AUTODETECT_VNUMRANGE)
	, vnum_range
#endif
};
}

#include <fstream>
inline std::string GetFileContent(const std::string& path)
{
	std::ifstream file(path);
	std::string content((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
	return content;
}

inline bool FileExists(const std::string& name)
{
	FILE *fp;
	fopen_s(&fp, name.c_str(), "r");
	if (fp)
	{
		fclose(fp);
		return true;
	}
	else
	{
		return false;
	}
}

#include "rapidjson/document.h"

#define NL "\n"
#include "OptionParser/OptionParser.h"
