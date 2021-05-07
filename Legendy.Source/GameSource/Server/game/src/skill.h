#ifndef __INC_METIN_II_GAME_CSkillManager_H__
#define __INC_METIN_II_GAME_CSkillManager_H__

#include "../../libpoly/Poly.h"
#include "../../common/CommonDefines.h"

enum ESkillFlags
{
	SKILL_FLAG_ATTACK			= (1 << 0),
	SKILL_FLAG_USE_MELEE_DAMAGE		= (1 << 1),
	SKILL_FLAG_COMPUTE_ATTGRADE		= (1 << 2),
	SKILL_FLAG_SELFONLY			= (1 << 3),
	SKILL_FLAG_USE_MAGIC_DAMAGE		= (1 << 4),
	SKILL_FLAG_USE_HP_AS_COST		= (1 << 5),
	SKILL_FLAG_COMPUTE_MAGIC_DAMAGE	= (1 << 6),
	SKILL_FLAG_SPLASH			= (1 << 7),
	SKILL_FLAG_GIVE_PENALTY		= (1 << 8),
	SKILL_FLAG_USE_ARROW_DAMAGE		= (1 << 9),
	SKILL_FLAG_PENETRATE		= (1 << 10),
	SKILL_FLAG_IGNORE_TARGET_RATING	= (1 << 11),
	SKILL_FLAG_SLOW			= (1 << 12),
	SKILL_FLAG_STUN			= (1 << 13),
	SKILL_FLAG_HP_ABSORB		= (1 << 14),
	SKILL_FLAG_SP_ABSORB		= (1 << 15),
	SKILL_FLAG_FIRE_CONT		= (1 << 16),
	SKILL_FLAG_REMOVE_BAD_AFFECT	= (1 << 17),
	SKILL_FLAG_REMOVE_GOOD_AFFECT	= (1 << 18),
	SKILL_FLAG_CRUSH			= (1 << 19),
	SKILL_FLAG_POISON			= (1 << 20),
	SKILL_FLAG_TOGGLE			= (1 << 21),
	SKILL_FLAG_DISABLE_BY_POINT_UP	= (1 << 22),
	SKILL_FLAG_CRUSH_LONG		= (1 << 23),
	SKILL_FLAG_WIND		= (1 << 24),
	SKILL_FLAG_ELEC		= (1 << 25),
	SKILL_FLAG_FIRE		= (1 << 26),
#ifdef ENABLE_WOLFMAN_CHARACTER
	SKILL_FLAG_BLEEDING	= (1 << 27),
	SKILL_FLAG_PARTY	= (1 << 28),
#endif
};

enum
{
	SKILL_PENALTY_DURATION = 3,
	SKILL_TYPE_HORSE = 5,
};

enum ESkillIndexes
{
	SKILL_RESERVED = 0,


	// A
	SKILL_SAMYEON = 1,
	SKILL_PALBANG,
	// S
	SKILL_JEONGWI,
	SKILL_GEOMKYUNG,
	SKILL_TANHWAN,


	// A
	SKILL_GIGONGCHAM = 16,
	SKILL_GYOKSAN,
	SKILL_DAEJINGAK,
	// S
	SKILL_CHUNKEON,
	SKILL_GEOMPUNG,


	// A
	SKILL_AMSEOP = 31,
	SKILL_GUNGSIN,
	SKILL_CHARYUN,
	// S
	SKILL_EUNHYUNG,
	SKILL_SANGONG,


	// A
	SKILL_YEONSA = 46,
	SKILL_KWANKYEOK,
	SKILL_HWAJO,
	// S
	SKILL_GYEONGGONG,
	SKILL_GIGUNG,


	// A
	SKILL_SWAERYUNG = 61,
	SKILL_YONGKWON,
	// S
	SKILL_GWIGEOM,
	SKILL_TERROR,
	SKILL_JUMAGAP,
	SKILL_PABEOB,


	// A
	SKILL_MARYUNG = 76,
	SKILL_HWAYEOMPOK,
	SKILL_MUYEONG,
	// S
	SKILL_MANASHILED,
	SKILL_TUSOK,
	SKILL_MAHWAN,


	// A
	SKILL_BIPABU = 91,
	SKILL_YONGBI,
	SKILL_PAERYONG,
	// S
	SKILL_HOSIN,
	SKILL_REFLECT,
	SKILL_GICHEON,


	// A
	SKILL_NOEJEON = 106,
	SKILL_BYEURAK,
	SKILL_CHAIN,
	// S
	SKILL_JEONGEOP,
	SKILL_KWAESOK,
	SKILL_JEUNGRYEOK,


	// 7
	SKILL_7_A_ANTI_TANHWAN = 112,
	SKILL_7_B_ANTI_AMSEOP,
	SKILL_7_C_ANTI_SWAERYUNG,
	SKILL_7_D_ANTI_YONGBI,

	// 8
	SKILL_8_A_ANTI_GIGONGCHAM,
	SKILL_8_B_ANTI_YEONSA,
	SKILL_8_C_ANTI_MAHWAN,
	SKILL_8_D_ANTI_BYEURAK,



	SKILL_LEADERSHIP = 121,
	SKILL_COMBO	= 122,
	SKILL_CREATE = 123,
	SKILL_MINING = 124,

	SKILL_LANGUAGE1 = 126,
	SKILL_LANGUAGE2 = 127,
	SKILL_LANGUAGE3 = 128,
	SKILL_POLYMORPH = 129,

	SKILL_HORSE			= 130,
	SKILL_HORSE_SUMMON		= 131,
	SKILL_HORSE_WILDATTACK	= 137,
	SKILL_HORSE_CHARGE		= 138,
	SKILL_HORSE_ESCAPE		= 139,
	SKILL_HORSE_WILDATTACK_RANGE = 140,

	SKILL_ADD_HP	=	141,
	SKILL_RESIST_PENETRATE	=	142,

	GUILD_SKILL_START = 151,
	GUILD_SKILL_EYE = 151,
	GUILD_SKILL_BLOOD = 152,
	GUILD_SKILL_BLESS = 153,
	GUILD_SKILL_SEONGHWI = 154,
	GUILD_SKILL_ACCEL = 155,
	GUILD_SKILL_BUNNO = 156,
	GUILD_SKILL_JUMUN = 157,
	GUILD_SKILL_TELEPORT = 158,
	GUILD_SKILL_DOOR = 159,
	GUILD_SKILL_END = 162,

	GUILD_SKILL_COUNT = GUILD_SKILL_END - GUILD_SKILL_START + 1,
#ifdef ENABLE_WOLFMAN_CHARACTER

	SKILL_CHAYEOL		= 170,
	SKILL_SALPOONG		= 171,
	SKILL_GONGDAB		= 172,
	SKILL_PASWAE		= 173,
	SKILL_JEOKRANG		= 174,
	SKILL_CHEONGRANG	= 175,
#endif
};

class CSkillProto
{
	public:
		char	szName[64];
		DWORD	dwVnum;

		DWORD	dwType;
		BYTE	bMaxLevel;
		BYTE	bLevelLimit;
		int	iSplashRange;

		BYTE	bPointOn;
		CPoly	kPointPoly;

		CPoly	kSPCostPoly;
		CPoly	kDurationPoly;
		CPoly	kDurationSPCostPoly;
		CPoly	kCooldownPoly;
		CPoly	kMasterBonusPoly;
		CPoly	kSplashAroundDamageAdjustPoly;

		DWORD	dwFlag;
		DWORD	dwAffectFlag;

		BYTE	bLevelStep;
		DWORD	preSkillVnum;
		BYTE	preSkillLevel;

		long	lMaxHit;

		BYTE	bSkillAttrType;


		BYTE	bPointOn2;
		CPoly	kPointPoly2;
		CPoly	kDurationPoly2;
		DWORD	dwFlag2;
		DWORD	dwAffectFlag2;

		DWORD   dwTargetRange;

		bool	IsChargeSkill()
		{
			return dwVnum == SKILL_TANHWAN || dwVnum == SKILL_HORSE_CHARGE;
		}


		BYTE bPointOn3;
		CPoly kPointPoly3;
		CPoly kDurationPoly3;

		CPoly kGrandMasterAddSPCostPoly;

		void SetPointVar(const std::string& strName, double dVar);
		void SetDurationVar(const std::string& strName, double dVar);
		void SetSPCostVar(const std::string& strName, double dVar);
};

class CSkillManager : public singleton<CSkillManager>
{
	public:
		CSkillManager();
		virtual ~CSkillManager();

		bool Initialize(TSkillTable * pTab, int iSize);
		CSkillProto * Get(DWORD dwVnum);
		CSkillProto * Get(const char * c_pszSkillName);

	protected:
		std::map<DWORD, CSkillProto *> m_map_pkSkillProto;
};

#endif
