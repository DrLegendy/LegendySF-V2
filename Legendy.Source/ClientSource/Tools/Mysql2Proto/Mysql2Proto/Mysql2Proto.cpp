#include "Mysql2Proto.h"

static bool s_bDebugFlag = false;

static const char* s_szdatabase = NULL;
static const char* s_szhostname = NULL;
static const char* s_szuser = NULL;
static const char* s_szpassword = NULL;
static unsigned int s_szport = 0;

static const char* s_szlocale_name = "locale_name";
static const char* s_szpostfix = "";

static CPythonNonPlayer::TMobTable * s_pMobTable = NULL;
static int s_iMobTableSize = 0;

static CItemData::TItemTable * s_pItemTable = NULL;
static int s_iItemTableSize = 0;

static DWORD g_adwMobProtoKey[4] =
{
	4813894,
	18955,
	552631,
	6822045
};

static DWORD g_adwItemProtoKey[4] =
{
	173217,
	72619434,
	408587239,
	27973291
};

MysqlWrapper zMWObj;
#pragma comment(lib, "libmysql.lib")

static int retrieveAddonType(DWORD dwVnum)
{
	int addon_type = 0;
#ifdef ENABLE_ADDONTYPE_AUTODETECT
	static DWORD vnumlist[] = {180, 190, 290, 1130, 1170, 2150, 2170, 3160, 3210, 5110, 5120, 7160, 6010, 6060, 6070};
	for (DWORD i = 0; i < (sizeof(vnumlist)/sizeof(DWORD)); i++)
	{
		if ((dwVnum >= vnumlist[i]) && (dwVnum <= vnumlist[i]+9))
		{
			addon_type = -1;
		}
	}
#endif
	return addon_type;
}

static bool BuildMobTable()
{
	fprintf(stdout, "sizeof(CPythonNonPlayer::TMobTable): %u\n", sizeof(CPythonNonPlayer::TMobTable));

	if (s_pMobTable)
	{
		delete s_pMobTable;
		s_pMobTable = NULL;
	}

	char query[2048];
	fprintf(stdout, "Loading mob_proto from MySQL\n");
	sprintf_s(query, sizeof(query),
		"SELECT vnum, name, %s, type, rank, battle_type, level, size+0,"
		" ai_flag+0, setRaceFlag+0, setImmuneFlag+0, on_click, empire, drop_item,"
		" resurrection_vnum, folder, st, dx, ht, iq, damage_min, damage_max, max_hp,"
		" regen_cycle, regen_percent, exp, gold_min, gold_max, def,"
		" attack_speed, move_speed, aggressive_hp_pct, aggressive_sight, attack_range, polymorph_item,"
		" enchant_curse, enchant_slow, enchant_poison, enchant_stun, enchant_critical, enchant_penetrate,"
		" resist_sword, resist_twohand, resist_dagger, resist_bell, resist_fan, resist_bow,"
		" resist_fire, resist_elect, resist_magic, resist_wind, resist_poison, dam_multiply, summon, drain_sp,"
		" mob_color,"
		" skill_vnum0, skill_level0, skill_vnum1, skill_level1, skill_vnum2, skill_level2, skill_vnum3, skill_level3,"
		" skill_vnum4, skill_level4, sp_berserk, sp_stoneskin, sp_godspeed, sp_deathblow, sp_revive"
		" FROM mob_proto%s ORDER BY vnum;",
		s_szlocale_name,
		s_szpostfix
	);

	MysqlResSP pMsg(MysqlWrapper::instance().ResultQuery(query));
	MYSQL_RES * res = pMsg.Get();
	s_iMobTableSize = MysqlWrapper::instance().CountRows(res);

	s_pMobTable = new CPythonNonPlayer::TMobTable[s_iMobTableSize];
	memset(s_pMobTable, 0, sizeof(CPythonNonPlayer::TMobTable) * s_iMobTableSize);

	CPythonNonPlayer::TMobTable* mob_table = s_pMobTable;

	MYSQL_ROW data = NULL;
	while ((data = MysqlWrapper::instance().FetchRow(res)))
	{
		// check whether or not the field is NULL or that contains an empty string
		// ## GENERAL
		VERIFY_IFIELD(MProto::vnum,				mob_table->dwVnum);
		VERIFY_SFIELD(MProto::name,				mob_table->szName);
		VERIFY_SFIELD(MProto::locale_name,		mob_table->szLocaleName);
		VERIFY_IFIELD(MProto::rank,				mob_table->bRank);
		VERIFY_IFIELD(MProto::type,				mob_table->bType);
		VERIFY_IFIELD(MProto::battle_type,		mob_table->bBattleType);
		VERIFY_IFIELD(MProto::level,			mob_table->bLevel);
		VERIFY_IFIELD(MProto::size,				mob_table->bSize);

		// ## FLAG
		VERIFY_IFIELD(MProto::ai_flag,			mob_table->dwAIFlag);
		VERIFY_IFIELD(MProto::setRaceFlag,		mob_table->dwRaceFlag);
		VERIFY_IFIELD(MProto::setImmuneFlag,	mob_table->dwImmuneFlag);

		// ## OTHERS
		VERIFY_IFIELD(MProto::empire,			mob_table->bEmpire);
		VERIFY_SFIELD(MProto::folder,			mob_table->szFolder);
		VERIFY_IFIELD(MProto::on_click,			mob_table->bOnClickType);
		VERIFY_IFIELD(MProto::st,				mob_table->bStr);
		VERIFY_IFIELD(MProto::dx,				mob_table->bDex);
		VERIFY_IFIELD(MProto::ht,				mob_table->bCon);
		VERIFY_IFIELD(MProto::iq,				mob_table->bInt);
		VERIFY_IFIELD(MProto::damage_min,		mob_table->dwDamageRange[0]);
		VERIFY_IFIELD(MProto::damage_max,		mob_table->dwDamageRange[1]);
		VERIFY_IFIELD(MProto::max_hp,			mob_table->dwMaxHP);
		VERIFY_IFIELD(MProto::regen_cycle,		mob_table->bRegenCycle);
		VERIFY_IFIELD(MProto::regen_percent,	mob_table->bRegenPercent);
		VERIFY_IFIELD(MProto::gold_min,			mob_table->dwGoldMin);
		VERIFY_IFIELD(MProto::gold_max,			mob_table->dwGoldMax);
		VERIFY_IFIELD(MProto::exp,				mob_table->dwExp);
		VERIFY_IFIELD(MProto::def,				mob_table->wDef);
		VERIFY_IFIELD(MProto::attack_speed,		mob_table->sAttackSpeed);
		VERIFY_IFIELD(MProto::move_speed,		mob_table->sMovingSpeed);
		VERIFY_IFIELD(MProto::aggressive_hp_pct,mob_table->bAggresiveHPPct);
		VERIFY_IFIELD(MProto::aggressive_sight,	mob_table->wAggressiveSight);
		VERIFY_IFIELD(MProto::attack_range,		mob_table->wAttackRange);
		VERIFY_IFIELD(MProto::drop_item,		mob_table->dwDropItemVnum);
		VERIFY_IFIELD(MProto::resurrection_vnum,mob_table->dwResurrectionVnum);

		// ## ENCHANT 6
		VERIFY_IFIELD(MProto::enchant_curse,	mob_table->cEnchants[CPythonNonPlayer::MOB_ENCHANT_CURSE]);
		VERIFY_IFIELD(MProto::enchant_slow,		mob_table->cEnchants[CPythonNonPlayer::MOB_ENCHANT_SLOW]);
		VERIFY_IFIELD(MProto::enchant_poison,	mob_table->cEnchants[CPythonNonPlayer::MOB_ENCHANT_POISON]);
		VERIFY_IFIELD(MProto::enchant_stun,		mob_table->cEnchants[CPythonNonPlayer::MOB_ENCHANT_STUN]);
		VERIFY_IFIELD(MProto::enchant_critical,	mob_table->cEnchants[CPythonNonPlayer::MOB_ENCHANT_CRITICAL]);
		VERIFY_IFIELD(MProto::enchant_penetrate,mob_table->cEnchants[CPythonNonPlayer::MOB_ENCHANT_PENETRATE]);

		// ## RESIST 11
		VERIFY_IFIELD(MProto::resist_sword,		mob_table->cResists[CPythonNonPlayer::MOB_RESIST_SWORD]);
		VERIFY_IFIELD(MProto::resist_twohand,	mob_table->cResists[CPythonNonPlayer::MOB_RESIST_TWOHAND]);
		VERIFY_IFIELD(MProto::resist_dagger,	mob_table->cResists[CPythonNonPlayer::MOB_RESIST_DAGGER]);
		VERIFY_IFIELD(MProto::resist_bell,		mob_table->cResists[CPythonNonPlayer::MOB_RESIST_BELL]);
		VERIFY_IFIELD(MProto::resist_fan,		mob_table->cResists[CPythonNonPlayer::MOB_RESIST_FAN]);
		VERIFY_IFIELD(MProto::resist_bow,		mob_table->cResists[CPythonNonPlayer::MOB_RESIST_BOW]);
		VERIFY_IFIELD(MProto::resist_fire,		mob_table->cResists[CPythonNonPlayer::MOB_RESIST_FIRE]);
		VERIFY_IFIELD(MProto::resist_elect,		mob_table->cResists[CPythonNonPlayer::MOB_RESIST_ELECT]);
		VERIFY_IFIELD(MProto::resist_magic,		mob_table->cResists[CPythonNonPlayer::MOB_RESIST_MAGIC]);
		VERIFY_IFIELD(MProto::resist_wind,		mob_table->cResists[CPythonNonPlayer::MOB_RESIST_WIND]);
		VERIFY_IFIELD(MProto::resist_poison,	mob_table->cResists[CPythonNonPlayer::MOB_RESIST_POISON]);

		// ## OTHERS #2
		VERIFY_IFIELD(MProto::dam_multiply,		mob_table->fDamMultiply);
		VERIFY_IFIELD(MProto::summon,			mob_table->dwSummonVnum);
		VERIFY_IFIELD(MProto::drain_sp,			mob_table->dwDrainSP);

		VERIFY_IFIELD(MProto::polymorph_item,	mob_table->dwPolymorphItemVnum);
		VERIFY_IFIELD(MProto::mob_color,		mob_table->dwMonsterColor);

		VERIFY_IFIELD(MProto::skill_vnum0,		mob_table->Skills[0].dwVnum);
		VERIFY_IFIELD(MProto::skill_level0,		mob_table->Skills[0].bLevel);
		VERIFY_IFIELD(MProto::skill_vnum1,		mob_table->Skills[1].dwVnum);
		VERIFY_IFIELD(MProto::skill_level1,		mob_table->Skills[1].bLevel);
		VERIFY_IFIELD(MProto::skill_vnum2,		mob_table->Skills[2].dwVnum);
		VERIFY_IFIELD(MProto::skill_level2,		mob_table->Skills[2].bLevel);
		VERIFY_IFIELD(MProto::skill_vnum3,		mob_table->Skills[3].dwVnum);
		VERIFY_IFIELD(MProto::skill_level3,		mob_table->Skills[3].bLevel);
		VERIFY_IFIELD(MProto::skill_vnum4,		mob_table->Skills[4].dwVnum);
		VERIFY_IFIELD(MProto::skill_level4,		mob_table->Skills[4].bLevel);

		// ## SPECIAL
		VERIFY_IFIELD(MProto::sp_berserk,		mob_table->bBerserkPoint);
		VERIFY_IFIELD(MProto::sp_stoneskin,		mob_table->bStoneSkinPoint);
		VERIFY_IFIELD(MProto::sp_godspeed,		mob_table->bGodSpeedPoint);
		VERIFY_IFIELD(MProto::sp_deathblow,		mob_table->bDeathBlowPoint);
		VERIFY_IFIELD(MProto::sp_revive,		mob_table->bRevivePoint);

		if (s_bDebugFlag)
			fprintf(stdout, "MOB #%-5d %-16s %-16s sight: %u color %u\n", mob_table->dwVnum, mob_table->szName, mob_table->szLocaleName, mob_table->wAggressiveSight, mob_table->dwMonsterColor);
		++mob_table;
	}

	fprintf(stdout, "Complete! %i Mobs loaded.\n", s_iMobTableSize);

	return true;
}

static bool LoadMobProto()
{
	FILE * fp;
	DWORD fourcc, tableSize, dataSize;

	fopen_s(&fp, "mob_proto", "rb");
	if (fp==NULL)
	{
		printf("mob_proto not found\n");
		return false;
	}

	fread(&fourcc, sizeof(DWORD), 1, fp);
	fread(&tableSize, sizeof(DWORD), 1, fp);
	fread(&dataSize, sizeof(DWORD), 1, fp);
	BYTE * data = (BYTE *) malloc(dataSize);

	printf("fourcc %u\n", fourcc);
	printf("tableSize %u\n", tableSize);
	printf("dataSize %u\n", dataSize);

	if (data)
	{
		fread(data, dataSize, 1, fp);

		CLZObject zObj;

		if (CLZO::instance().Decompress(zObj, data, g_adwMobProtoKey))
		{
			printf("real_size %u\n", zObj.GetSize());
			DWORD structSize = zObj.GetSize() / tableSize;
			DWORD structDiff = zObj.GetSize() % tableSize;
			printf("struct_size %u\n", structSize);
			printf("struct_diff %u\n", structDiff);

#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
			if (structDiff!=0 && !CPythonNonPlayer::TMobTableAll::IsValidStruct(structSize))
#else
			if ((zObj.GetSize() % sizeof(TMobTable)) != 0)
#endif
			{
				printf("LoadMobProto: invalid size %u check data format. structSize %u, structDiff %u\n", zObj.GetSize(), structSize, structDiff);
				return false;
			}

			FILE * fdump = NULL;
			if (s_bDebugFlag)
			{
				fopen_s(&fdump, "mob_proto.sql", "w");
			}

			static const char* sqlModeFix = "SET sql_mode=(SELECT REPLACE(@@sql_mode,'STRICT_TRANS_TABLES',''));";
			if (s_bDebugFlag && fdump)
			{
				fwrite(sqlModeFix, strlen(sqlModeFix), 1, fdump);
				fwrite("\n", 1, 1, fdump);
			}
			else
				MysqlWrapper::instance().DirectQuery(sqlModeFix);

			for (DWORD i = 0; i < tableSize; ++i)
			{
#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
				CPythonNonPlayer::TMobTable t = {0};
				CPythonNonPlayer::TMobTableAll::Process(zObj.GetBuffer(), structSize, i, t);
#else
				CPythonNonPlayer::TMobTable & t = *((CItemData::TItemTable *) zObj.GetBuffer() + i);
#endif
				char query[4096];
				char szNameEscaped[sizeof(t.szName)*2+1];
				char szLocaleNameEscaped[sizeof(t.szLocaleName)*2+1];
				mysql_escape_string(szNameEscaped, t.szName, strnlen_s(t.szName, sizeof(t.szName)));
				mysql_escape_string(szLocaleNameEscaped, t.szLocaleName, strnlen_s(t.szLocaleName, sizeof(t.szLocaleName)));
				size_t query_length = sprintf_s(query, sizeof(query),
					"replace into mob_proto%s ("
					"vnum, name, %s, type, rank, battle_type, level, size, ai_flag, setRaceFlag, setImmuneFlag, "
					"on_click, empire, drop_item, resurrection_vnum, folder, "
					"st, dx, ht, iq, damage_min, damage_max, max_hp, regen_cycle, regen_percent, exp, "
					"gold_min, gold_max, def, attack_speed, move_speed, aggressive_hp_pct, aggressive_sight, attack_range, polymorph_item, "

					"enchant_curse, enchant_slow, enchant_poison, enchant_stun, enchant_critical, enchant_penetrate, "
					"resist_sword, resist_twohand, resist_dagger, resist_bell, resist_fan, resist_bow, "
					"resist_fire, resist_elect, resist_magic, resist_wind, resist_poison, "
					"dam_multiply, summon, drain_sp, "

					"skill_vnum0, skill_level0, skill_vnum1, skill_level1, skill_vnum2, skill_level2, "
					"skill_vnum3, skill_level3, skill_vnum4, skill_level4, "
					"sp_berserk, sp_stoneskin, sp_godspeed, sp_deathblow, sp_revive, "
					"mount_capacity, mob_color "
					") "
					"values ("

					"%u, \"%s\", \"%s\", %u, %u, %u, %u, %u, %u, %u, %u, "
					"%u, %u, %u, %u, '%s', "
					"%u, %u, %u, %u, %u, %u, %u, %u, %u, %u, "
					"%u, %u, %d, %d, %d, %u, %d, %d, %u, "

					"%d, %d, %d, %d, %d, %d, "
					"%d, %d, %d, %d, %d, %d, "
					"%d, %d, %d, %d, %d, "
					"%f, %u, %u, "

					"%u, %u, %u, %u, %u, %u, "
					"%u, %u, %u, %u, "
					"%u, %u, %u, %u, %u, "
					"%u, %u "
					");",
					s_szpostfix, s_szlocale_name,

					t.dwVnum, szNameEscaped, szLocaleNameEscaped, t.bType, t.bRank, t.bBattleType, t.bLevel, t.bSize, t.dwAIFlag, t.dwRaceFlag, t.dwImmuneFlag,
					t.bOnClickType, t.bEmpire, t.dwDropItemVnum, t.dwResurrectionVnum, t.szFolder,
					t.bStr, t.bDex, t.bCon, t.bInt, t.dwDamageRange[0], t.dwDamageRange[1], t.dwMaxHP, t.bRegenCycle, t.bRegenPercent, t.dwExp,

					t.dwGoldMin, t.dwGoldMax, t.wDef, t.sAttackSpeed, t.sMovingSpeed, t.bAggresiveHPPct, t.wAggressiveSight, t.wAttackRange, t.dwPolymorphItemVnum,
					t.cEnchants[0], t.cEnchants[1], t.cEnchants[2], t.cEnchants[3], t.cEnchants[4], t.cEnchants[5],
					t.cResists[0], t.cResists[1], t.cResists[2], t.cResists[3], t.cResists[4], t.cResists[5],
					t.cResists[6], t.cResists[7], t.cResists[8], t.cResists[9], t.cResists[10],
					t.fDamMultiply, t.dwSummonVnum, t.dwDrainSP,

					t.Skills[0].dwVnum, t.Skills[0].bLevel, t.Skills[1].dwVnum, t.Skills[1].bLevel, t.Skills[2].dwVnum, t.Skills[2].bLevel,
					t.Skills[3].dwVnum, t.Skills[3].bLevel, t.Skills[4].dwVnum, t.Skills[4].bLevel,
					t.bBerserkPoint, t.bStoneSkinPoint, t.bGodSpeedPoint, t.bDeathBlowPoint, t.bRevivePoint,
					t.bMountCapacity, t.dwMonsterColor
				);

				if (s_bDebugFlag && fdump)
				{
					fwrite(query, query_length, 1, fdump);
					fwrite("\n", 1, 1, fdump);
				}
				else
				{
					fprintf(stdout, "\rProcessed Query: %u/%u", i, tableSize);
					MysqlWrapper::instance().DirectQuery(query);
				}
			}

			if (s_bDebugFlag && fdump)
				fclose(fdump);

			fprintf(stdout, "\nComplete! %u Mobs saved.\n", tableSize);
		}
		free(data);
	}
	return true;
}

static void SaveMobProto()
{
	if (!s_pMobTable)
		return;

	FILE * fp;
	fopen_s(&fp, "mob_proto", "wb");
	if (!fp)
	{
		printf("cannot open %s for writing\n", "mob_proto");
		return;
	}

	DWORD fourcc = MAKEFOURCC('M', 'M', 'P', 'T');
	fwrite(&fourcc, sizeof(DWORD), 1, fp);

	DWORD dwElements = s_iMobTableSize;
	fwrite(&dwElements, sizeof(DWORD), 1, fp);

	CLZObject zObj;

	if (!CLZO::instance().CompressEncryptedMemory(zObj, s_pMobTable, sizeof(CPythonNonPlayer::TMobTable) * s_iMobTableSize, g_adwMobProtoKey))
	{
		printf("cannot compress\n");
		fclose(fp);
		return;
	}

	const CLZObject::THeader & r = zObj.GetHeader();

	printf("MobProto count %u\n%u --Compress--> %u --Encrypt--> %u, GetSize %u\n",
			s_iMobTableSize, r.dwRealSize, r.dwCompressedSize, r.dwEncryptSize, zObj.GetSize());

	DWORD dwDataSize = zObj.GetSize();
	fwrite(&dwDataSize, sizeof(DWORD), 1, fp);
	fwrite(zObj.GetBuffer(), dwDataSize, 1, fp);

	fclose(fp);
}

static bool BuildItemTable()
{
	fprintf(stdout, "sizeof(CItemData::TItemTable): %u\n", sizeof(CItemData::TItemTable));

	if (s_pItemTable)
	{
		free(s_pItemTable);
		s_pItemTable = NULL;
	}

	char query[2048];
	fprintf(stdout, "Loading item_proto from MySQL\n");
	sprintf_s(query, sizeof(query),
		"SELECT vnum, type, subtype, name, %s, gold, shop_buy_price, weight, size,"
		" flag, wearflag, antiflag, immuneflag+0, refined_vnum, refine_set, magic_pct,"
		" specular,"
		" socket_pct, addon_type, limittype0, limitvalue0, limittype1, limitvalue1,"
		" applytype0, applyvalue0, applytype1, applyvalue1, applytype2, applyvalue2,"
		" value0, value1, value2, value3, value4, value5"
#if !defined(ENABLE_AUTODETECT_VNUMRANGE)
		" , vnum_range"
#endif
		" FROM item_proto%s ORDER BY vnum;",
		s_szlocale_name,
		s_szpostfix
	);

	MysqlResSP pMsg(MysqlWrapper::instance().ResultQuery(query));
	MYSQL_RES * res = pMsg.Get();

	s_iItemTableSize = MysqlWrapper::instance().CountRows(res);

	s_pItemTable = new CItemData::TItemTable[s_iItemTableSize];
	memset(s_pItemTable, 0, sizeof(CItemData::TItemTable) * s_iItemTableSize);

	CItemData::TItemTable * item_table = s_pItemTable;

	MYSQL_ROW data = NULL;
	while ((data = MysqlWrapper::instance().FetchRow(res)))
	{
		// check whether or not the field is NULL or that contains an empty string
		// ## GENERAL
		VERIFY_IFIELD(IProto::vnum,				item_table->dwVnum);
		VERIFY_SFIELD(IProto::name,				item_table->szName);
		VERIFY_SFIELD(IProto::locale_name,		item_table->szLocaleName);
		VERIFY_IFIELD(IProto::type,				item_table->bType);
		VERIFY_IFIELD(IProto::subtype,			item_table->bSubType);
		VERIFY_IFIELD(IProto::weight,			item_table->bWeight);
		VERIFY_IFIELD(IProto::size,				item_table->bSize);
		VERIFY_IFIELD(IProto::antiflag,			item_table->dwAntiFlags);
		VERIFY_IFIELD(IProto::flag,				item_table->dwFlags);
		VERIFY_IFIELD(IProto::wearflag,			item_table->dwWearFlags);
		VERIFY_IFIELD(IProto::immuneflag,		item_table->dwImmuneFlag);
		VERIFY_IFIELD(IProto::gold,				item_table->dwIBuyItemPrice);
		VERIFY_IFIELD(IProto::shop_buy_price,	item_table->dwISellItemPrice);
		VERIFY_IFIELD(IProto::refined_vnum,		item_table->dwRefinedVnum);
		VERIFY_IFIELD(IProto::refine_set,		item_table->wRefineSet);
		VERIFY_IFIELD(IProto::magic_pct,		item_table->bAlterToMagicItemPct);

		VERIFY_IFIELD(IProto::specular,			item_table->bSpecular);
		VERIFY_IFIELD(IProto::socket_pct,		item_table->bGainSocketPct);
		// VERIFY_IFIELD(IProto::addon_type,		item_table->sAddonType);

		// ## LIMIT
		VERIFY_IFIELD(IProto::limittype0,		item_table->aLimits[0].bType);
		VERIFY_IFIELD(IProto::limitvalue0,		item_table->aLimits[0].lValue);

		VERIFY_IFIELD(IProto::limittype1,		item_table->aLimits[1].bType);
		VERIFY_IFIELD(IProto::limitvalue1,		item_table->aLimits[1].lValue);

#ifdef ENABLE_LIMIT_TYPE_CHECK_FIX
		if ((CItemData::LIMIT_NONE!=item_table->aLimits[0].bType) && // just checking the first limit one is enough
			(item_table->aLimits[0].bType == item_table->aLimits[1].bType))
		{
			item_table->aLimits[1].bType = 0;
			item_table->aLimits[1].lValue = 0;
			if (s_bDebugFlag)
				fprintf(stderr, "vnum(%u): limittype0(%u)==limittype1(%u)", item_table->dwVnum, item_table->aLimits[0].bType, item_table->aLimits[1].bType);
		}
#endif

		// ## APPLY
		VERIFY_IFIELD(IProto::applytype0,		item_table->aApplies[0].bType);
		VERIFY_IFIELD(IProto::applyvalue0,		item_table->aApplies[0].lValue);
		VERIFY_IFIELD(IProto::applytype1,		item_table->aApplies[1].bType);
		VERIFY_IFIELD(IProto::applyvalue1,		item_table->aApplies[1].lValue);
		VERIFY_IFIELD(IProto::applytype2,		item_table->aApplies[2].bType);
		VERIFY_IFIELD(IProto::applyvalue2,		item_table->aApplies[2].lValue);

		// ## VALUE
		VERIFY_IFIELD(IProto::value0,		item_table->alValues[0]);
		VERIFY_IFIELD(IProto::value1,		item_table->alValues[1]);
		VERIFY_IFIELD(IProto::value2,		item_table->alValues[2]);
		VERIFY_IFIELD(IProto::value3,		item_table->alValues[3]);
		VERIFY_IFIELD(IProto::value4,		item_table->alValues[4]);
		VERIFY_IFIELD(IProto::value5,		item_table->alValues[5]);

#if !defined(ENABLE_AUTODETECT_VNUMRANGE)
		VERIFY_IFIELD(IProto::vnum_range,		item_table->dwVnumRange);
#else
		if (item_table->bType==CItemData::ITEM_TYPE_DS)
			item_table->dwVnumRange = 99;
#endif

		if (s_bDebugFlag)
			fprintf(stdout, "ITEM #%-5u %-24s %-24s VAL: %ld %ld %ld %ld %ld %ld WEAR %u ANTI %u IMMUNE %u REFINE %u\n",
				item_table->dwVnum,
				item_table->szName,
				item_table->szLocaleName,
				item_table->alValues[0],
				item_table->alValues[1],
				item_table->alValues[2],
				item_table->alValues[3],
				item_table->alValues[4],
				item_table->alValues[5],
				item_table->dwWearFlags,
				item_table->dwAntiFlags,
				item_table->dwImmuneFlag,
				item_table->dwRefinedVnum
			);
		++item_table;
	}

	fprintf(stdout, "Complete! %u Items loaded.\n", s_iItemTableSize);
	return true;
}

static bool LoadItemProto()
{
	FILE * fp;
	DWORD fourcc, tableSize, dataSize, protoVersion, structSize;

	fopen_s(&fp, "item_proto", "rb");
	if (fp==NULL)
	{
		printf("item_proto not found\n");
		return false;
	}


	fread(&fourcc, sizeof(DWORD), 1, fp);
	fread(&protoVersion, sizeof(DWORD), 1, fp);
	fread(&structSize, sizeof(DWORD), 1, fp);
	fread(&tableSize, sizeof(DWORD), 1, fp);
	fread(&dataSize, sizeof(DWORD), 1, fp);
	BYTE * data = (BYTE *) malloc(dataSize);

	printf("fourcc %u\n", fourcc);
	printf("protoVersion %u\n", protoVersion);
	printf("struct_size %u\n", structSize);
	printf("tableSize %u\n", tableSize);
	printf("dataSize %u\n", dataSize);

#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
	if (!CItemData::TItemTableAll::IsValidStruct(structSize))
#else
	if (structSize != sizeof(CItemData::TItemTable))
#endif
	{
		printf("LoadItemProto: invalid item_proto structSize[%d] != sizeof(SItemTable)\n", structSize, sizeof(CItemData::TItemTable));
		return false;
	}

	if (data)
	{
		fread(data, dataSize, 1, fp);

		CLZObject zObj;

		if (CLZO::instance().Decompress(zObj, data, g_adwItemProtoKey))
		{
			printf("real_size %u\n", zObj.GetSize());

			FILE * fdump = NULL;
			if (s_bDebugFlag)
			{
				fopen_s(&fdump, "item_proto.sql", "w");
			}

			static const char* sqlModeFix = "SET sql_mode=(SELECT REPLACE(@@sql_mode,'STRICT_TRANS_TABLES',''));";
			if (s_bDebugFlag && fdump)
			{
				fwrite(sqlModeFix, strlen(sqlModeFix), 1, fdump);
				fwrite("\n", 1, 1, fdump);
			}
			else
				MysqlWrapper::instance().DirectQuery(sqlModeFix);

			for (DWORD i = 0; i < tableSize; ++i)
			{
#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
				CItemData::TItemTable t = {0};
				CItemData::TItemTableAll::Process(zObj.GetBuffer(), structSize, i, t);
#else
				CItemData::TItemTable & t = *((CItemData::TItemTable *) zObj.GetBuffer() + i);
#endif
				char query[4096];
				char szNameEscaped[sizeof(t.szName)*2+1];
				char szLocaleNameEscaped[sizeof(t.szLocaleName)*2+1];
				mysql_escape_string(szNameEscaped, t.szName, strnlen_s(t.szName, sizeof(t.szName)));
				mysql_escape_string(szLocaleNameEscaped, t.szLocaleName, strnlen_s(t.szLocaleName, sizeof(t.szLocaleName)));
				size_t query_length = sprintf_s(query, sizeof(query),
					"replace into item_proto%s (" //1
					"vnum, type, subtype, name, %s, gold, shop_buy_price, weight, size, " //2
					"flag, wearflag, antiflag, immuneflag, "
					"refined_vnum, refine_set, magic_pct, socket_pct, addon_type, "
					"specular, "
					"limittype0, limitvalue0, limittype1, limitvalue1, "
					"applytype0, applyvalue0, applytype1, applyvalue1, applytype2, applyvalue2, "
					"value0, value1, value2, value3, value4, value5 ) "
					"values ("
					"%u, %u, %u, \"%s\", \"%s\", %u, %u, %u, %u, " //11
					"%u, %u, %u, %u, " //15
					"%u, %d, %u, %u, %d, " //20
					"%u, "
					"%u, %ld, %u, %ld, " //24
					"%u, %ld, %u, %ld, %u, %ld, " //30
					"%ld, %ld, %ld, %ld, %ld, %ld );", //36
					s_szpostfix, s_szlocale_name, //2
					t.dwVnum, t.bType, t.bSubType, szNameEscaped, szLocaleNameEscaped, t.dwIBuyItemPrice, t.dwISellItemPrice, t.bWeight, t.bSize, //11
					t.dwFlags, t.dwWearFlags, t.dwAntiFlags, t.dwImmuneFlag, //15
					t.dwRefinedVnum, t.wRefineSet, t.bAlterToMagicItemPct, t.bGainSocketPct, retrieveAddonType(t.dwVnum), //20
					t.bSpecular,
					t.aLimits[0].bType, t.aLimits[0].lValue, t.aLimits[1].bType, t.aLimits[1].lValue, //24
					t.aApplies[0].bType, t.aApplies[0].lValue, t.aApplies[1].bType, t.aApplies[1].lValue, t.aApplies[2].bType, t.aApplies[2].lValue, //30
					t.alValues[0], t.alValues[1], t.alValues[2], t.alValues[3], t.alValues[4], t.alValues[5]
				);

				if (s_bDebugFlag && fdump)
				{
					fwrite(query, query_length, 1, fdump);
					fwrite("\n", 1, 1, fdump);
				}
				else
				{
					fprintf(stdout, "\rProcessed Query: %u/%u", i, tableSize);
					MysqlWrapper::instance().DirectQuery(query);
				}
			}

			if (s_bDebugFlag && fdump)
				fclose(fdump);

			fprintf(stdout, "\nComplete! %u Items saved.\n", tableSize);
		}
		free(data);
	}
	return true;
}

static void SaveItemProto()
{
	if (!s_pItemTable)
		return;

	FILE * fp;
	fopen_s(&fp, "item_proto", "wb");
	if (!fp)
	{
		printf("cannot open %s for writing\n", "item_proto");
		return;
	}

	DWORD fourcc = MAKEFOURCC('M', 'I', 'P', 'X');
	fwrite(&fourcc, sizeof(DWORD), 1, fp);

	DWORD dwVersion = 0x00000001;
	fwrite(&dwVersion, sizeof(DWORD), 1, fp);

	DWORD dwStride = sizeof(CItemData::TItemTable);
	fwrite(&dwStride, sizeof(DWORD), 1, fp);

	DWORD dwElements = s_iItemTableSize;
	fwrite(&dwElements, sizeof(DWORD), 1, fp);

	CLZObject zObj;

	std::vector <CItemData::TItemTable> vec_item_table (&s_pItemTable[0], &s_pItemTable[s_iItemTableSize - 1]);
	sort (&s_pItemTable[0], &s_pItemTable[0] + s_iItemTableSize);
	if (!CLZO::instance().CompressEncryptedMemory(zObj, s_pItemTable, sizeof(CItemData::TItemTable) * s_iItemTableSize, g_adwItemProtoKey))
	{
		printf("cannot compress\n");
		fclose(fp);
		return;
	}

	const CLZObject::THeader & r = zObj.GetHeader();

	printf("Elements %d\n%u --Compress--> %u --Encrypt--> %u, GetSize %u\n",
			s_iItemTableSize,
			r.dwRealSize,
			r.dwCompressedSize,
			r.dwEncryptSize,
			zObj.GetSize());

	DWORD dwDataSize = zObj.GetSize();
	fwrite(&dwDataSize, sizeof(DWORD), 1, fp);
	fwrite(zObj.GetBuffer(), dwDataSize, 1, fp);
	fclose(fp);

	fopen_s(&fp, "item_proto", "rb");
	if (!fp)
	{
		printf("Error!!\n");
		return;
	}

	fread(&fourcc, sizeof(DWORD), 1, fp);
	fread(&dwElements, sizeof(DWORD), 1, fp);

	printf("Elements Check %u fourcc match %d\n", dwElements, fourcc == MAKEFOURCC('M', 'I', 'P', 'T'));
	fclose(fp);
}

static bool LoadConfig()
{
	const char* jsonFName = "Mysql2Proto.json";
	if (!FileExists(jsonFName))
	{
		fprintf(stderr, "<ConfigFile> LOAD '%s' FAILED (NO_FILE)\n", jsonFName);
		return false;
	}

	std::string jsonData = GetFileContent(jsonFName);

	rapidjson::Document document;
	if (document.Parse(jsonData.c_str()).HasParseError())
	{
		fprintf(stderr, "<ConfigFile> LOAD '%s' FAILED (PARSE_ERROR)\n", jsonFName);
		return false;
	}

	fprintf(stdout, "<ConfigFile> LOAD '%s' BEGIN\n", jsonFName);

	if (document.HasMember("database"))
	{
		const rapidjson::Value& value = document["database"];
		assert(value.IsString());
		s_szdatabase = value.GetString();
		fprintf(stdout, "<ConfigFile> s_szdatabase changed to '%s'.\n", s_szdatabase);
	}
	else
	{
		fprintf(stderr, "<ConfigFile> LOAD '%s' FAILED (database VALUE MISSING)\n", jsonFName);
		return false;
	}

	if (document.HasMember("hostname"))
	{
		const rapidjson::Value& value = document["hostname"];
		assert(value.IsString());
		s_szhostname = value.GetString();
		fprintf(stdout, "<ConfigFile> s_szhostname changed to '%s'.\n", s_szhostname);
	}
	else
	{
		fprintf(stderr, "<ConfigFile> LOAD '%s' FAILED (hostname VALUE MISSING)\n", jsonFName);
		return false;
	}

	if (document.HasMember("user"))
	{
		const rapidjson::Value& value = document["user"];
		assert(value.IsString());
		s_szuser = value.GetString();
		fprintf(stdout, "<ConfigFile> s_szuser changed to '%s'.\n", s_szuser);
	}
	else
	{
		fprintf(stderr, "<ConfigFile> LOAD '%s' FAILED (user VALUE MISSING)\n", jsonFName);
		return false;
	}

	if (document.HasMember("password"))
	{
		const rapidjson::Value& value = document["password"];
		assert(value.IsString());
		s_szpassword = value.GetString();
		fprintf(stdout, "<ConfigFile> s_szpassword changed to '%s'.\n", s_szpassword);
	}
	else
	{
		fprintf(stderr, "<ConfigFile> LOAD '%s' FAILED (password VALUE MISSING)\n", jsonFName);
		return false;
	}

	if (document.HasMember("port"))
	{
		const rapidjson::Value& value = document["port"];
		assert(value.IsNumber());
		s_szport = value.GetInt();
		fprintf(stdout, "<ConfigFile> s_szport changed to '%u'.\n", s_szport);
	}

	fprintf(stdout, "<ConfigFile> LOAD '%s' END\n", jsonFName);
	MysqlWrapper::instance().Connect(s_szhostname, s_szuser, s_szpassword, s_szdatabase, s_szport);
	fprintf(stdout, "<ConfigFile> MYSQL SUCCESSFULLY CONNECTED\n", jsonFName);
	return true;
}

static enum optionIndex { UNKNOWN, HELP, DEBUG_MODE, ITEM_PROTO, MOB_PROTO, PACK, UNPACK };
static const option::Descriptor usage[] = // don't use TAB in here!
{
	{UNKNOWN,		0,	"",		"",				option::Arg::None,		"USAGE: example [options]"},
	{HELP,			0,	"h",	"help",			option::Arg::None,		"    --help, -h             Print usage and exit." },
	{DEBUG_MODE,	0,	"d",	"debug",		option::Arg::None,		"    --debug, -d            Enable debug mode" },
	{ITEM_PROTO,	0,	"i",	"iproto",		option::Arg::None,		"    --iproto, -i           Process item proto" },
	{MOB_PROTO,		0,	"m",	"mproto",		option::Arg::None,		"    --mproto, -m           Process mob proto" },
	{PACK,			0,	"p",	"pack",			option::Arg::None,		"    --pack, -p             Pack" },
	{UNPACK,		0,	"u",	"unpack",		option::Arg::None,		"    --unpack, -u           Unpack" },
	{UNKNOWN,		0,	"",		"",				option::Arg::None,		NL "Examples:"
																		NL "    Mysql2Proto.exe --help"
																		NL "    Mysql2Proto.exe -dpim"
																		NL "    Mysql2Proto.exe -duim"
																		NL "    Mysql2Proto.exe -dpm"
																		NL "    Mysql2Proto.exe -dum"
																		NL "    Mysql2Proto.exe -dpi"
																		NL "    Mysql2Proto.exe -dui"
	},
	{0,0,0,0,0,0}
};

int main(int argc, char ** argv)
{
	argc-=(argc>0); argv+=(argc>0); // skip program name argv[0] if present
	option::Stats stats(usage, argc, argv);
	std::vector<option::Option> options(stats.options_max);
	std::vector<option::Option> buffer(stats.buffer_max);
	option::Parser parse(usage, argc, argv, &options[0], &buffer[0]);

	if (parse.error())
		return 1;

	bool bAItemProto = false;
	bool bAMobProto = false;
	bool bXPhase = false;
	for (size_t idx1 = 0; idx1 < parse.optionsCount(); ++idx1)
	{
		option::Option& opt = buffer[idx1];
		switch (opt.index())
		{
			case DEBUG_MODE:
				s_bDebugFlag = true;
				break;
			case ITEM_PROTO:
				bAItemProto = true;
				break;
			case MOB_PROTO:
				bAMobProto = true;
				break;
			case PACK:
				bXPhase = false;
				break;
			case UNPACK:
				bXPhase = true;
				break;
			case HELP:
			default:
				option::printUsage(std::cout, usage);
				exit(0);
				break;
		}
	}

	if (!s_bDebugFlag && !LoadConfig())
		exit(0);

#ifdef _DEBUG
	printf("sizeof(TItemTable) %d\n", sizeof(CItemData::TItemTable));
#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
	printf("sizeof(TItemTable_r152) %d\n", sizeof(CItemData::TItemTable_r152));
	printf("sizeof(TItemTable_r156) %d\n", sizeof(CItemData::TItemTable_r156));
	printf("sizeof(TItemTable_r158) %d\n", sizeof(CItemData::TItemTable_r158));
#endif
	printf("sizeof(TMobTable) %d\n", sizeof(CPythonNonPlayer::TMobTable));
#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
	printf("sizeof(TMobTable_r235) %d\n", sizeof(CPythonNonPlayer::TMobTable_r235));
	printf("sizeof(TMobTable_r255) %d\n", sizeof(CPythonNonPlayer::TMobTable_r255));
	printf("sizeof(TMobTable_r256) %d\n", sizeof(CPythonNonPlayer::TMobTable_r256));
	printf("sizeof(TMobTable_r262) %d\n", sizeof(CPythonNonPlayer::TMobTable_r262));
	printf("sizeof(TMobTable_r263) %d\n", sizeof(CPythonNonPlayer::TMobTable_r263));
#endif
#endif

	if (bAItemProto)
	{
		if (bXPhase)
			LoadItemProto();
		else if (BuildItemTable())
			SaveItemProto();
	}
	if (bAMobProto)
	{
		if (bXPhase)
			LoadMobProto();
		else if (BuildMobTable())
			SaveMobProto();
	}

	return 0;
}

