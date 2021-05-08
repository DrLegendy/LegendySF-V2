-- ########################################################################################
-- ### PASTE EVERYTHING INSIDE questlib.lua OR ONLY: (w/o --)
-- dofile(get_locale_base_path().."/quest/questlib_extra.lua")
-- ########################################################################################
if QUESTLIB_EXTRA_LUA==nil then QUESTLIB_EXTRA_LUA=2.0 -- include_guard begin

-- POINT DECLARING BEGIN
POINT_RAMADAN_CANDY_BONUS_EXP = 127
POINT_ENERGY = 128
POINT_ENERGY_END_TIME = 129

POINT_COSTUME_ATTR_BONUS = 130
POINT_MAGIC_ATT_BONUS_PER = 131
POINT_MELEE_MAGIC_ATT_BONUS_PER = 132

POINT_RESIST_ICE = 133
POINT_RESIST_EARTH = 134
POINT_RESIST_DARK = 135

POINT_RESIST_CRITICAL = 136
POINT_RESIST_PENETRATE = 137

POINT_BLEEDING_REDUCE = 138
POINT_BLEEDING_PCT = 139

POINT_ATTBONUS_WOLFMAN = 140
POINT_RESIST_WOLFMAN = 141
POINT_RESIST_CLAW = 142

POINT_ACCEDRAIN_RATE = 143
POINT_RESIST_MAGIC_REDUCTION = 144
-- POINT DECLARING END

-- RACE DECLARING BEGIN
WARRIOR_M	= 0
NINJA_W		= 1
SURA_M		= 2
SHAMAN_W	= 3
WARRIOR_W	= 4
NINJA_M		= 5
SURA_W		= 6
SHAMAN_M	= 7
WOLFMAN_M	= 8
-- RACE DECLARING END
-- ########################################################################################

-- ########################################################################################
-- AFF DECLARING BEGIN
AFF_NONE = 0

AFF_YMIR = 1
AFF_INVISIBILITY = 2
AFF_SPAWN = 3

AFF_POISON = 4
AFF_SLOW = 5
AFF_STUN = 6

AFF_DUNGEON_READY = 7
AFF_DUNGEON_UNIQUE = 8

AFF_BUILDING_CONSTRUCTION_SMALL = 9
AFF_BUILDING_CONSTRUCTION_LARGE = 10
AFF_BUILDING_UPGRADE = 11

AFF_MOV_SPEED_POTION = 12
AFF_ATT_SPEED_POTION = 13

AFF_FISH_MIND = 14

AFF_JEONGWIHON = 15
AFF_GEOMGYEONG = 16
AFF_CHEONGEUN = 17
AFF_GYEONGGONG = 18
AFF_EUNHYUNG = 19
AFF_GWIGUM = 20
AFF_TERROR = 21
AFF_JUMAGAP = 22
AFF_HOSIN = 23
AFF_BOHO = 24
AFF_KWAESOK = 25
AFF_MANASHIELD = 26
AFF_MUYEONG = 27
AFF_REVIVE_INVISIBLE = 28
AFF_FIRE = 29
AFF_GICHEON = 30
AFF_JEUNGRYEOK = 31
AFF_TANHWAN_DASH = 32
AFF_PABEOP = 33
AFF_CHEONGEUN_WITH_FALL = 34
AFF_POLYMORPH = 35
AFF_WAR_FLAG1 = 36
AFF_WAR_FLAG2 = 37
AFF_WAR_FLAG3 = 38

AFF_CHINA_FIREWORK = 39
AFF_HAIR = 40
AFF_GERMANY =  41

AFF_RAMADAN_RING =  42

AFF_BLEEDING =  43
AFF_RED_POSSESSION =  44
AFF_BLUE_POSSESSION =  45

AFF_BITS_MAX = 46
-- AFF DECLARING END
-- ########################################################################################

-- ########################################################################################
-- C3 NEMERE BEGIN
function setDFR_from_table(l_antiflag, l_vid)
	for i,v in ipairs(l_antiflag) do
		d.set_damage_from_race(v, l_vid)
	end
end

function setDFA_from_table(l_antiflag, l_vid)
	for i,v in ipairs(l_antiflag) do
		d.set_damage_from_affect(v, l_vid)
	end
end

-- 6151
Szel_4thfloor_affectlimit	= {AFF_HOSIN}
Szel_7thfloor_affectlimit	= {AFF_GICHEON}
-- 8058
IceMetin_racelimit			= {WARRIOR_M,WARRIOR_W,NINJA_W,NINJA_M,SURA_M,SURA_W}
-- 20399
IceStonePillar_racelimit	= {WARRIOR_M,WARRIOR_W,SURA_M,SURA_W}
-- C3 NEMERE END
-- ########################################################################################

-- ########################################################################################
-- AUTO CHECK EVENT FLAGS AT STARTUP BEGIN
function check_event_flags()
	local event_table = {
		{"gold_drop_limit_time", 1},
		{"item_drop_limit_time", 1},
		{"box_use_limit_time", 1},
		{"buysell_limit_time", 1},
		{"no_drop_metin_stone", 1},
		{"no_mount_at_guild_war", 1},
		{"no_potions_on_pvp", 1},
	}
	for num1,str1 in ipairs(event_table) do
		if game.get_event_flag(str1[1])~=str1[2] then
			game.set_event_flag(str1[1], str1[2])
		end
	end
end
check_event_flags()
-- AUTO CHECK EVENT FLAGS AT STARTUP END
-- ########################################################################################

end -- include_guard end

