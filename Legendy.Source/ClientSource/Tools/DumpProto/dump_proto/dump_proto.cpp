#include "dump_proto.h"

bool LoadNPrint = false;

CPythonNonPlayer::TMobTable * m_pMobTable = NULL;
int m_iMobTableSize = 0;

CItemData::TItemTable * m_pItemTable = NULL;
int m_iItemTableSize = 0;


bool Set_Proto_Mob_Table(CPythonNonPlayer::TMobTable *mobTable, cCsvTable &csvTable, std::map<int,const char*> &nameMap)
{
	int col = 0;

	mobTable->dwVnum               = atoi(csvTable.AsStringByIndex(col++));
	strncpy(mobTable->szName, csvTable.AsStringByIndex(col++), CHARACTER_NAME_MAX_LEN);
	map<int,const char*>::iterator it;
	it = nameMap.find(mobTable->dwVnum);
	if (it != nameMap.end()) {
		const char * localeName = it->second;
		strncpy(mobTable->szLocaleName, localeName, sizeof (mobTable->szLocaleName));
	} else {
		strncpy(mobTable->szLocaleName, mobTable->szName, sizeof (mobTable->szLocaleName));
	}
	//4. RANK
	int rankValue = get_Mob_Rank_Value(csvTable.AsStringByIndex(col++));
	mobTable->bRank                = rankValue;
	//5. TYPE
	int typeValue = get_Mob_Type_Value(csvTable.AsStringByIndex(col++));
	mobTable->bType                = typeValue;
	//6. BATTLE_TYPE
	int battleTypeValue = get_Mob_BattleType_Value(csvTable.AsStringByIndex(col++));
	mobTable->bBattleType          = battleTypeValue;

	mobTable->bLevel		= atoi(csvTable.AsStringByIndex(col++));
	//8. SIZE
	int sizeValue = get_Mob_Size_Value(csvTable.AsStringByIndex(col++));
	mobTable->bSize                = sizeValue;
	//9. AI_FLAG
	int aiFlagValue = get_Mob_AIFlag_Value(csvTable.AsStringByIndex(col++));
	mobTable->dwAIFlag             = aiFlagValue;

	mobTable->bMountCapacity       = atoi(csvTable.AsStringByIndex(col++));
	//10. RACE_FLAG
	int raceFlagValue = get_Mob_RaceFlag_Value(csvTable.AsStringByIndex(col++));
	mobTable->dwRaceFlag           = raceFlagValue;
	//11. IMMUNE_FLAG
	int immuneFlagValue = get_Mob_ImmuneFlag_Value(csvTable.AsStringByIndex(col++));
	mobTable->dwImmuneFlag         = immuneFlagValue;

	mobTable->bEmpire              = atoi(csvTable.AsStringByIndex(col++));

	//folder
	strncpy(mobTable->szFolder, csvTable.AsStringByIndex(col++), sizeof(mobTable->szFolder));


	mobTable->bOnClickType         = atoi(csvTable.AsStringByIndex(col++));

	mobTable->bStr                 = atoi(csvTable.AsStringByIndex(col++));
	mobTable->bDex                 = atoi(csvTable.AsStringByIndex(col++));
	mobTable->bCon                 = atoi(csvTable.AsStringByIndex(col++));
	mobTable->bInt                 = atoi(csvTable.AsStringByIndex(col++));
	mobTable->dwDamageRange[0]     = atoi(csvTable.AsStringByIndex(col++));
	mobTable->dwDamageRange[1]     = atoi(csvTable.AsStringByIndex(col++));
	mobTable->dwMaxHP              = atoi(csvTable.AsStringByIndex(col++));
	mobTable->bRegenCycle          = atoi(csvTable.AsStringByIndex(col++));
	mobTable->bRegenPercent        = atoi(csvTable.AsStringByIndex(col++));

	mobTable->dwGoldMin            = atoi(csvTable.AsStringByIndex(col++));
	mobTable->dwGoldMax            = atoi(csvTable.AsStringByIndex(col++));
	mobTable->dwExp                = atoi(csvTable.AsStringByIndex(col++));
	mobTable->wDef                 = atoi(csvTable.AsStringByIndex(col++));
	mobTable->sAttackSpeed         = atoi(csvTable.AsStringByIndex(col++));
	mobTable->sMovingSpeed         = atoi(csvTable.AsStringByIndex(col++));
	mobTable->bAggresiveHPPct      = atoi(csvTable.AsStringByIndex(col++));
	mobTable->wAggressiveSight     = atoi(csvTable.AsStringByIndex(col++));
	mobTable->wAttackRange         = atoi(csvTable.AsStringByIndex(col++));

	mobTable->dwDropItemVnum       = atoi(csvTable.AsStringByIndex(col++));
	mobTable->dwResurrectionVnum   = atoi(csvTable.AsStringByIndex(col++));


	for (int i = 0; i < CPythonNonPlayer::MOB_ENCHANTS_MAX_NUM; ++i)
		mobTable->cEnchants[i] = atoi(csvTable.AsStringByIndex(col++));

	for (int i = 0; i < CPythonNonPlayer::MOB_RESISTS_MAX_NUM; ++i)
		mobTable->cResists[i] = atoi(csvTable.AsStringByIndex(col++));

	mobTable->fDamMultiply		= atoi(csvTable.AsStringByIndex(col++));
	mobTable->dwSummonVnum		= atoi(csvTable.AsStringByIndex(col++));
	mobTable->dwDrainSP			= atoi(csvTable.AsStringByIndex(col++));
	mobTable->dwMonsterColor	= atoi(csvTable.AsStringByIndex(col++));

	return true;
}


bool BuildMobTable()
{
	//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//

	fprintf(stderr, "sizeof(TMobTable): %u\n", sizeof(CPythonNonPlayer::TMobTable));


	//==============================================================//
	//==============================================================//
	bool isNameFile = true;
	map<int,const char*> localMap;
	cCsvTable nameData;
	if(!nameData.Load("mob_names.txt",'\t'))
	{
		fprintf(stderr, "mob_names.txt Unable to read file\n");
		isNameFile = false;
	} else {
		nameData.Next();
		while(nameData.Next()) {
			localMap[atoi(nameData.AsStringByIndex(0))] = nameData.AsStringByIndex(1);
		}
	}
	//______________________________________________________________//

	//=========================================//
	//=========================================//
	set<int> vnumSet;
	//_________________________________________//

	//==================================================//
	//==================================================//
	map<DWORD, CPythonNonPlayer::TMobTable *> test_map_mobTableByVnum;

	cCsvTable data;
	if(!data.Load("mob_proto.txt",'\t'))
	{
		fprintf(stderr, "mob_proto.txt Unable to read file\n");
		return false;
	}
	data.Next();



	if (m_pMobTable)
	{
		delete m_pMobTable;
		m_pMobTable = NULL;
	}

	int addNumber = 0;
	while(data.Next()) {
		int vnum = atoi(data.AsStringByIndex(0));
		std::map<DWORD, CPythonNonPlayer::TMobTable *>::iterator it_map_mobTable;
		it_map_mobTable = test_map_mobTableByVnum.find(vnum);
		if(it_map_mobTable != test_map_mobTableByVnum.end()) {
			addNumber++;
		}
	}


	m_iMobTableSize = data.m_File.GetRowCount()-1 + addNumber;

	m_pMobTable = new CPythonNonPlayer::TMobTable[m_iMobTableSize];
	memset(m_pMobTable, 0, sizeof(CPythonNonPlayer::TMobTable) * m_iMobTableSize);

	CPythonNonPlayer::TMobTable * mob_table = m_pMobTable;


	data.Destroy();
	if(!data.Load("mob_proto.txt",'\t'))
	{
		fprintf(stderr, "mob_proto.txt Unable to read file\n");
		return false;
	}
	data.Next();

	while (data.Next())
	{
		int col = 0;
		std::map<DWORD, CPythonNonPlayer::TMobTable *>::iterator it_map_mobTable;
		it_map_mobTable = test_map_mobTableByVnum.find(atoi(data.AsStringByIndex(col)));
		if(it_map_mobTable == test_map_mobTableByVnum.end()) {

			if (!Set_Proto_Mob_Table(mob_table, data, localMap))
			{
				fprintf(stderr, "Mob prototype table setting failed.\n");
			}

		} else {
			CPythonNonPlayer::TMobTable *tempTable = it_map_mobTable->second;

			mob_table->dwVnum               = tempTable->dwVnum;
			strncpy(mob_table->szName, tempTable->szName, CHARACTER_NAME_MAX_LEN);
			strncpy(mob_table->szLocaleName, tempTable->szLocaleName, CHARACTER_NAME_MAX_LEN);
			mob_table->bRank                = tempTable->bRank;
			mob_table->bType                = tempTable->bType;
			mob_table->bBattleType          = tempTable->bBattleType;
			mob_table->bLevel				= tempTable->bLevel;
			mob_table->bSize				= tempTable->bSize;
			mob_table->dwAIFlag				= tempTable->dwAIFlag;
			mob_table->dwRaceFlag				= tempTable->dwRaceFlag;
			mob_table->dwImmuneFlag				= tempTable->dwImmuneFlag;
			mob_table->bEmpire				= tempTable->bEmpire;
			strncpy(mob_table->szFolder, tempTable->szFolder, CHARACTER_NAME_MAX_LEN);
			mob_table->bOnClickType         = tempTable->bOnClickType;
			mob_table->bStr                 = tempTable->bStr;
			mob_table->bDex                 = tempTable->bDex;
			mob_table->bCon                 = tempTable->bCon;
			mob_table->bInt                 = tempTable->bInt;
			mob_table->dwDamageRange[0]     = tempTable->dwDamageRange[0];
			mob_table->dwDamageRange[1]     = tempTable->dwDamageRange[1];
			mob_table->dwMaxHP              = tempTable->dwMaxHP;
			mob_table->bRegenCycle          = tempTable->bRegenCycle;
			mob_table->bRegenPercent        = tempTable->bRegenPercent;
			mob_table->dwExp                = tempTable->dwExp;
			mob_table->wDef                 = tempTable->wDef;
			mob_table->sAttackSpeed         = tempTable->sAttackSpeed;
			mob_table->sMovingSpeed         = tempTable->sMovingSpeed;
			mob_table->bAggresiveHPPct      = tempTable->bAggresiveHPPct;
			mob_table->wAggressiveSight	= tempTable->wAggressiveSight;
			mob_table->wAttackRange		= tempTable->wAttackRange;
			mob_table->dwDropItemVnum	= tempTable->dwDropItemVnum;
			for (int i = 0; i < CPythonNonPlayer::MOB_ENCHANTS_MAX_NUM; ++i)
				mob_table->cEnchants[i] = tempTable->cEnchants[i];
			for (int i = 0; i < CPythonNonPlayer::MOB_RESISTS_MAX_NUM; ++i)
				mob_table->cResists[i] = tempTable->cResists[i];
			mob_table->fDamMultiply		= tempTable->fDamMultiply;
			mob_table->dwSummonVnum		= tempTable->dwSummonVnum;
			mob_table->dwDrainSP		= tempTable->dwDrainSP;
			mob_table->dwMonsterColor	= tempTable->dwMonsterColor;

		}

		fprintf(stdout, "MOB #%-5d %-16s %-16s sight: %u color %u[%s]\n", mob_table->dwVnum, mob_table->szName, mob_table->szLocaleName, mob_table->wAggressiveSight, mob_table->dwMonsterColor, 0);

		vnumSet.insert(mob_table->dwVnum);

		++mob_table;
	}

	return true;
}




DWORD g_adwMobProtoKey[4] =
{
	4813894,
	18955,
	552631,
	6822045
};


void SaveMobProto()
{
	FILE * fp;
	fopen_s(&fp, "mob_proto", "wb");
	if (!fp)
	{
		printf("cannot open %s for writing\n", "mob_proto");
		return;
	}

	DWORD fourcc = MAKEFOURCC('M', 'M', 'P', 'T');
	fwrite(&fourcc, sizeof(DWORD), 1, fp);

	DWORD dwElements = m_iMobTableSize;
	fwrite(&dwElements, sizeof(DWORD), 1, fp);

	CLZObject zObj;

	printf("sizeof(TMobTable) %d\n", sizeof(CPythonNonPlayer::TMobTable));

	if (!CLZO::instance().CompressEncryptedMemory(zObj, m_pMobTable, sizeof(CPythonNonPlayer::TMobTable) * m_iMobTableSize, g_adwMobProtoKey))
	{
		printf("cannot compress\n");
		fclose(fp);
		return;
	}

	const CLZObject::THeader & r = zObj.GetHeader();

	printf("MobProto count %u\n%u --Compress--> %u --Encrypt--> %u, GetSize %u\n",
			m_iMobTableSize, r.dwRealSize, r.dwCompressedSize, r.dwEncryptSize, zObj.GetSize());

	DWORD dwDataSize = zObj.GetSize();
	fwrite(&dwDataSize, sizeof(DWORD), 1, fp);
	fwrite(zObj.GetBuffer(), dwDataSize, 1, fp);

	fclose(fp);
}

// YMIR WON'T SAVE THE FOLLOWING FIELDS, SO YOU WILL GET 0 FROM THEM WHEN YOU UNPACK THE MOB_PROTO:
// gold min, gold max, polymorph item, mount capacity
// skill_*
// sp_*
// NB: damage multiply is truncated, so you will get 1 instead of 1.4 and so on
// NB2: due to a bug, all the mob_protos packed with an unfixed/default dump_proto tool will get the race flag set to 0 if it contains more than 1 value (the bug is about the splitting feature)
void LoadMobProto()
{
	FILE * fp;
	DWORD fourcc, tableSize, dataSize;

	fopen_s(&fp, "mob_proto", "rb");
	if (fp==NULL)
	{
		printf("mob_proto not found\n");
		return;
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
				return;
			}


			if (LoadNPrint)
			{
				for (DWORD i = 0; i < tableSize; ++i)
				{
#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
					CPythonNonPlayer::TMobTable rTable = {0};
					CPythonNonPlayer::TMobTableAll::Process(zObj.GetBuffer(), structSize, i, rTable);
#else
					CPythonNonPlayer::TMobTable & rTable = *((CItemData::TItemTable *) zObj.GetBuffer() + i);
#endif
					printf("%u %s\n", rTable.dwVnum, rTable.szLocaleName);
				}
			}
			else
			{
				FILE * mf1; fopen_s(&mf1, "mob_names.txt", "w");
				FILE * mf2; fopen_s(&mf2, "mob_proto.txt", "w");
				if (mf1==NULL)
				{
					printf("mob_names.txt not writable");
					return;
				}
				if (mf2==NULL)
				{
					printf("mob_proto.txt not writable");
					return;
				}
				fprintf(mf1, "VNUM\tLOCALE_NAME\n");
				fprintf(mf2, "VNUM\tNAME\tRANK\tTYPE\tBATTLE_TYPE\tLEVEL\tSIZE\tAI_FLAG\tMOUNT_CAPACITY\tRACE_FLAG\tIMMUNE_FLAG\tEMPIRE\tFOLDER\tON_CLICK\tST\tDX\tHT\tIQ\tDAMAGE_MIN\tDAMAGE_MAX\tMAX_HP\tREGEN_CYCLE\tREGEN_PERCENT\tGOLD_MIN\tGOLD_MAX\tEXP\tDEF\tATTACK_SPEED\tMOVE_SPEED\tAGGRESSIVE_HP_PCT\tAGGRESSIVE_SIGHT\tATTACK_RANGE\tDROP_ITEM\tRESURRECTION_VNUM\tENCHANT_CURSE\tENCHANT_SLOW\tENCHANT_POISON\tENCHANT_STUN\tENCHANT_CRITICAL\tENCHANT_PENETRATE\tRESIST_SWORD\tRESIST_TWOHAND\tRESIST_DAGGER\tRESIST_BELL\tRESIST_FAN\tRESIST_BOW\tRESIST_FIRE\tRESIST_ELECT\tRESIST_MAGIC\tRESIST_WIND\tRESIST_POISON\tDAM_MULTIPLY\tSUMMON\tDRAIN_SP\tMOB_COLOR\tPOLYMORPH_ITEM\tSKILL_LEVEL0\tSKILL_VNUM0\tSKILL_LEVEL1\tSKILL_VNUM1\tSKILL_LEVEL2\tSKILL_VNUM2\tSKILL_LEVEL3\tSKILL_VNUM3\tSKILL_LEVEL4\tSKILL_VNUM4\tSP_BERSERK\tSP_STONESKIN\tSP_GODSPEED\tSP_DEATHBLOW\tSP_REVIVE\n");
				for (DWORD i = 0; i < tableSize; ++i)
				{
#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
					CPythonNonPlayer::TMobTable rTable = {0};
					CPythonNonPlayer::TMobTableAll::Process(zObj.GetBuffer(), structSize, i, rTable);
#else
					CPythonNonPlayer::TMobTable & rTable = *((CItemData::TItemTable *) zObj.GetBuffer() + i);
#endif
					fprintf(mf1, "%u	%s\n", rTable.dwVnum, rTable.szLocaleName);
					fprintf(mf2,
						"%u	%s"
						"	%s	%s	%s	%u"
						"	%s	%s	%u	%s"
						"	%s	%u	%s	%u	%u	%u	%u	%u"
						"	%u	%u	%u	%u	%u	%u	%u	%u	%u"
						"	%d	%d	%u	%u	%u	%u	%u"
						"	%d	%d	%d"
						"	%d	%d	%d"
						"	%d	%d	%d	%d"
						"	%d	%d"
						"	%d	%d"
						"	%d	%d	%d"
						"	%.1f	%u	%u	%u	%u"
						"	%u	%u	%u	%u	%u	%u"
						"	%u	%u	%u	%u"
						"	%u	%u	%u	%u	%u"
						"\n",
						rTable.dwVnum, rTable.szName,
						set_Mob_Rank_Value(rTable.bRank).c_str(), set_Mob_Type_Value(rTable.bType).c_str(), set_Mob_BattleType_Value(rTable.bBattleType).c_str(), rTable.bLevel,
						set_Mob_Size_Value(rTable.bSize).c_str(), set_Mob_AIFlag_Value(rTable.dwAIFlag).c_str(), rTable.bMountCapacity, set_Mob_RaceFlag_Value(rTable.dwRaceFlag).c_str(),
						set_Mob_ImmuneFlag_Value(rTable.dwImmuneFlag).c_str(), rTable.bEmpire, rTable.szFolder, rTable.bOnClickType, rTable.bStr, rTable.bDex, rTable.bCon, rTable.bInt,
						rTable.dwDamageRange[0], rTable.dwDamageRange[1], rTable.dwMaxHP, rTable.bRegenCycle, rTable.bRegenPercent, rTable.dwGoldMin, rTable.dwGoldMax, rTable.dwExp, rTable.wDef,
						rTable.sAttackSpeed, rTable.sMovingSpeed, rTable.bAggresiveHPPct, rTable.wAggressiveSight, rTable.wAttackRange, rTable.dwDropItemVnum, rTable.dwResurrectionVnum,
						rTable.cEnchants[CPythonNonPlayer::MOB_ENCHANT_CURSE], rTable.cEnchants[CPythonNonPlayer::MOB_ENCHANT_SLOW], rTable.cEnchants[CPythonNonPlayer::MOB_ENCHANT_POISON],
						rTable.cEnchants[CPythonNonPlayer::MOB_ENCHANT_STUN], rTable.cEnchants[CPythonNonPlayer::MOB_ENCHANT_CRITICAL], rTable.cEnchants[CPythonNonPlayer::MOB_ENCHANT_PENETRATE],
						rTable.cResists[CPythonNonPlayer::MOB_RESIST_SWORD], rTable.cResists[CPythonNonPlayer::MOB_RESIST_TWOHAND], rTable.cResists[CPythonNonPlayer::MOB_RESIST_DAGGER], rTable.cResists[CPythonNonPlayer::MOB_RESIST_BELL],
						rTable.cResists[CPythonNonPlayer::MOB_RESIST_FAN], rTable.cResists[CPythonNonPlayer::MOB_RESIST_BOW],
						rTable.cResists[CPythonNonPlayer::MOB_RESIST_FIRE], rTable.cResists[CPythonNonPlayer::MOB_RESIST_ELECT],
						rTable.cResists[CPythonNonPlayer::MOB_RESIST_MAGIC], rTable.cResists[CPythonNonPlayer::MOB_RESIST_WIND], rTable.cResists[CPythonNonPlayer::MOB_RESIST_POISON],
						rTable.fDamMultiply, rTable.dwSummonVnum, rTable.dwDrainSP, rTable.dwMonsterColor, rTable.dwPolymorphItemVnum,
						rTable.Skills[0].bLevel, rTable.Skills[0].dwVnum, rTable.Skills[1].bLevel, rTable.Skills[1].dwVnum, rTable.Skills[2].bLevel, rTable.Skills[2].dwVnum,
						rTable.Skills[3].bLevel, rTable.Skills[3].dwVnum, rTable.Skills[4].bLevel, rTable.Skills[4].dwVnum,
						rTable.bBerserkPoint, rTable.bStoneSkinPoint, rTable.bGodSpeedPoint, rTable.bDeathBlowPoint, rTable.bRevivePoint
					);
				}
				;
			}
		}

		free(data);
	}

	fclose(fp);
}




//==													==//
//==													==//
//==													==//
//==													==//
//==													==//
//==													==//

string retrieveVnumRange(DWORD dwVnum, DWORD dwVnumRange)
{
	static char buf[10*2+1];
	if (dwVnumRange>0)
		snprintf(buf, sizeof(buf), "%u~%u", dwVnum, dwVnum+dwVnumRange);
	else
		snprintf(buf, sizeof(buf), "%u", dwVnum);
	return buf;
}

int retrieveAddonType(DWORD dwVnum)
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

bool Set_Proto_Item_Table(CItemData::TItemTable *itemTable, cCsvTable &csvTable, std::map<int,const char*> &nameMap)
{
	{
		std::string s(csvTable.AsStringByIndex(0));
		int pos = s.find("~");
		if (std::string::npos == pos)
		{
			itemTable->dwVnum = atoi(s.c_str());
			if (0 == itemTable->dwVnum)
			{
				printf ("INVALID VNUM %s\n", s.c_str());
				return false;
			}
			itemTable->dwVnumRange = 0;
		}
		else
		{
			std::string s_start_vnum (s.substr(0, pos));
			std::string s_end_vnum (s.substr(pos +1 ));

			int start_vnum = atoi(s_start_vnum.c_str());
			int end_vnum = atoi(s_end_vnum.c_str());
			if (0 == start_vnum || (0 != end_vnum && end_vnum < start_vnum))
			{
				printf ("INVALID VNUM RANGE%s\n", s.c_str());
				return false;
			}
			itemTable->dwVnum = start_vnum;
			itemTable->dwVnumRange = end_vnum - start_vnum;
		}
	}

	int col = 1;

	strncpy(itemTable->szName, csvTable.AsStringByIndex(col++), CItemData::ITEM_NAME_MAX_LEN);
	map<int,const char*>::iterator it;
	it = nameMap.find(itemTable->dwVnum);
	if (it != nameMap.end()) {
		const char * localeName = it->second;
		strncpy(itemTable->szLocaleName, localeName, sizeof(itemTable->szLocaleName));
	} else {
		strncpy(itemTable->szLocaleName, itemTable->szName, sizeof(itemTable->szLocaleName));
	}
	itemTable->bType = get_Item_Type_Value(csvTable.AsStringByIndex(col++));
	itemTable->bSubType = get_Item_SubType_Value(itemTable->bType, csvTable.AsStringByIndex(col++));
	itemTable->bSize = atoi(csvTable.AsStringByIndex(col++));
	itemTable->dwAntiFlags = get_Item_AntiFlag_Value(csvTable.AsStringByIndex(col++));
	itemTable->dwFlags = get_Item_Flag_Value(csvTable.AsStringByIndex(col++));
	itemTable->dwWearFlags = get_Item_WearFlag_Value(csvTable.AsStringByIndex(col++));
	itemTable->dwImmuneFlag = get_Item_Immune_Value(csvTable.AsStringByIndex(col++));
	itemTable->dwIBuyItemPrice = atoi(csvTable.AsStringByIndex(col++));
	itemTable->dwISellItemPrice = atoi(csvTable.AsStringByIndex(col++));
	itemTable->dwRefinedVnum = atoi(csvTable.AsStringByIndex(col++));
	itemTable->wRefineSet = atoi(csvTable.AsStringByIndex(col++));
	itemTable->bAlterToMagicItemPct = atoi(csvTable.AsStringByIndex(col++));

	int i;

	for (i = 0; i < CItemData::ITEM_LIMIT_MAX_NUM; ++i)
	{
		itemTable->aLimits[i].bType = get_Item_LimitType_Value(csvTable.AsStringByIndex(col++));
		itemTable->aLimits[i].lValue = atoi(csvTable.AsStringByIndex(col++));
	}

	for (i = 0; i < CItemData::ITEM_APPLY_MAX_NUM; ++i)
	{
		itemTable->aApplies[i].bType = get_Item_ApplyType_Value(csvTable.AsStringByIndex(col++));
		itemTable->aApplies[i].lValue = atoi(csvTable.AsStringByIndex(col++));
	}

	for (i = 0; i < CItemData::ITEM_VALUES_MAX_NUM; ++i)
		itemTable->alValues[i] = atoi(csvTable.AsStringByIndex(col++));

	itemTable->bSpecular = atoi(csvTable.AsStringByIndex(col++));
	itemTable->bGainSocketPct = atoi(csvTable.AsStringByIndex(col++));
	col++; //AddonType

	itemTable->bWeight = 0;

	return true;
}

bool BuildItemTable()
{
	//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//

	fprintf(stderr, "sizeof(TClientItemTable): %u\n", sizeof(CItemData::TItemTable));

	//=================================================================//
	//=================================================================//
	bool isNameFile = true;
	map<int,const char*> localMap;
	cCsvTable nameData;
	if(!nameData.Load("item_names.txt",'\t'))
	{
		fprintf(stderr, "item_names.txt Unable to read file\n");
		isNameFile = false;
	} else {
		nameData.Next();
		while(nameData.Next()) {
			localMap[atoi(nameData.AsStringByIndex(0))] = nameData.AsStringByIndex(1);
		}
	}
	//_________________________________________________________________//

	//===================== =======================//
	//=============================================//
	map<DWORD, CItemData::TItemTable *> test_map_itemTableByVnum;

	//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//


	//================================================================//
	//================================================================//

	set<int> vnumSet;

	cCsvTable data;
	if(!data.Load("item_proto.txt",'\t'))
	{
		fprintf(stderr, "item_proto.txt Unable to read file\n");
		return false;
	}
	data.Next();

	if (m_pItemTable)
	{
		free(m_pItemTable);
		m_pItemTable = NULL;
	}

	int addNumber = 0;
	while(data.Next()) {
		int vnum = atoi(data.AsStringByIndex(0));
		std::map<DWORD, CItemData::TItemTable *>::iterator it_map_itemTable;
		it_map_itemTable = test_map_itemTableByVnum.find(vnum);
		if(it_map_itemTable != test_map_itemTableByVnum.end()) {
			addNumber++;
		}
	}
	data.Destroy();
	if(!data.Load("item_proto.txt",'\t'))
	{
		fprintf(stderr, "item_proto.txt Unable to read file\n");
		return false;
	}
	data.Next();

	m_iItemTableSize = data.m_File.GetRowCount()-1+addNumber;
	m_pItemTable = new CItemData::TItemTable[m_iItemTableSize];
	memset(m_pItemTable, 0, sizeof(CItemData::TItemTable) * m_iItemTableSize);

	CItemData::TItemTable * item_table = m_pItemTable;

	while (data.Next())
	{
		int col = 0;

		std::map<DWORD, CItemData::TItemTable *>::iterator it_map_itemTable;
		it_map_itemTable = test_map_itemTableByVnum.find(atoi(data.AsStringByIndex(col)));
		if(it_map_itemTable == test_map_itemTableByVnum.end()) {


			if (!Set_Proto_Item_Table(item_table, data, localMap))
			{
				fprintf(stderr, "Mob prototype table setting failed.\n");
			}
		} else {
			CItemData::TItemTable *tempTable = it_map_itemTable->second;

			item_table->dwVnum = tempTable->dwVnum;
			strncpy(item_table->szName, tempTable->szName, CItemData::ITEM_NAME_MAX_LEN);
			strncpy(item_table->szLocaleName, tempTable->szLocaleName, CItemData::ITEM_NAME_MAX_LEN);
			item_table->bType = tempTable->bType;
			item_table->bSubType = tempTable->bSubType;
			item_table->bSize = tempTable->bSize;
			item_table->dwAntiFlags = tempTable->dwAntiFlags;
			item_table->dwFlags = tempTable->dwFlags;
			item_table->dwWearFlags = tempTable->dwWearFlags;
			item_table->dwImmuneFlag = tempTable->dwImmuneFlag;
			item_table->dwIBuyItemPrice = tempTable->dwIBuyItemPrice;
			item_table->dwISellItemPrice = tempTable->dwISellItemPrice;
			item_table->dwRefinedVnum = tempTable->dwRefinedVnum;
			item_table->wRefineSet = tempTable->wRefineSet;
			item_table->bAlterToMagicItemPct = tempTable->bAlterToMagicItemPct;

			int i;
			for (i = 0; i < CItemData::ITEM_LIMIT_MAX_NUM; ++i)
			{
				item_table->aLimits[i].bType = tempTable->aLimits[i].bType;
				item_table->aLimits[i].lValue = tempTable->aLimits[i].lValue;
			}

			for (i = 0; i < CItemData::ITEM_APPLY_MAX_NUM; ++i)
			{
				item_table->aApplies[i].bType = tempTable->aApplies[i].bType;
				item_table->aApplies[i].lValue = tempTable->aApplies[i].lValue;
			}

			for (i = 0; i < CItemData::ITEM_VALUES_MAX_NUM; ++i)
				item_table->alValues[i] = tempTable->alValues[i];

			item_table->bSpecular = tempTable->bSpecular;
			item_table->bGainSocketPct = tempTable->bGainSocketPct;

			item_table->bWeight = tempTable->bWeight;
		}


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
				item_table->dwRefinedVnum);

		vnumSet.insert(item_table->dwVnum);
		++item_table;
	}

	return true;
}

DWORD g_adwItemProtoKey[4] =
{
	173217,
	72619434,
	408587239,
	27973291
};

// YMIR WON'T SAVE THE FOLLOWING FIELDS, SO YOU WILL GET 0 FROM THEM WHEN YOU UNPACK THE ITEM_PROTO:
// addon_type
void LoadItemProto()
{
	FILE * fp;
	DWORD fourcc, tableSize, dataSize, protoVersion, structSize;

	fopen_s(&fp, "item_proto", "rb");
	if (fp==NULL)
	{
		printf("item_proto not found\n");
		return;
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
		return;
	}

	if (data)
	{
		fread(data, dataSize, 1, fp);

		CLZObject zObj;

		if (CLZO::instance().Decompress(zObj, data, g_adwItemProtoKey))
		{
			printf("real_size %u\n", zObj.GetSize());

			if (LoadNPrint)
			{
				for (DWORD i = 0; i < tableSize; ++i)
				{
#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
					CItemData::TItemTable rTable = {0};
					CItemData::TItemTableAll::Process(zObj.GetBuffer(), structSize, i, rTable);
#else
					CItemData::TItemTable & rTable = *((CItemData::TItemTable *) zObj.GetBuffer() + i);
#endif
					printf("%u %s\n", rTable.dwVnum, rTable.szLocaleName);
				}
			}
			else
			{
				FILE * mf1; fopen_s(&mf1, "item_names.txt", "w");
				FILE * mf2; fopen_s(&mf2, "item_proto.txt", "w");
				if (mf1==NULL)
				{
					printf("item_names.txt not writable");
					return;
				}
				if (mf2==NULL)
				{
					printf("item_proto.txt not writable");
					return;
				}
				fprintf(mf1, "VNUM\tLOCALE_NAME\n");
				fprintf(mf2, "ITEM_VNUM~RANGE\tITEM_NAME(K)\tITEM_TYPE\tSUB_TYPE\tSIZE\tANTI_FLAG\tFLAG\tITEM_WEAR\tIMMUNE\tGOLD\tSHOP_BUY_PRICE\tREFINE\tREFINESET\tMAGIC_PCT\tLIMIT_TYPE0\tLIMIT_VALUE0\tLIMIT_TYPE1\tLIMIT_VALUE1\tADDON_TYPE0\tADDON_VALUE0\tADDON_TYPE1\tADDON_VALUE1\tADDON_TYPE2\tADDON_VALUE2\tVALUE0\tVALUE1\tVALUE2\tVALUE3\tVALUE4\tVALUE5\tSpecular\tSOCKET\tATTU_ADDON\n");
				for (DWORD i = 0; i < tableSize; ++i)
				{
#ifdef ENABLE_PROTOSTRUCT_AUTODETECT
					CItemData::TItemTable rTable = {0};
					CItemData::TItemTableAll::Process(zObj.GetBuffer(), structSize, i, rTable);
#else
					CItemData::TItemTable & rTable = *((CItemData::TItemTable *) zObj.GetBuffer() + i);
#endif
					fprintf(mf1, "%u	%s\n", rTable.dwVnum, rTable.szLocaleName);
					fprintf(mf2,
						"%s	%s" // 2
						"	%s	%s	%u	%s" // 6
						"	%s	%s	%s" // 9
						"	%u	%u	%u	%u	%u" // 14
						"	%s	%d	%s	%d" // 18
						"	%s	%d	%s	%d	%s	%d" // 24
						"	%d	%d	%d	%d	%d	%d" // 30
						"	%u	%u	%d" // 33
						"\n",
						retrieveVnumRange(rTable.dwVnum, rTable.dwVnumRange).c_str(), rTable.szName, // 2
						set_Item_Type_Value(rTable.bType).c_str(), set_Item_SubType_Value(rTable.bType, rTable.bSubType).c_str(), rTable.bSize, set_Item_AntiFlag_Value(rTable.dwAntiFlags).c_str(), // 6
						set_Item_Flag_Value(rTable.dwFlags).c_str(), set_Item_WearFlag_Value(rTable.dwWearFlags).c_str(), set_Item_Immune_Value(rTable.dwImmuneFlag).c_str(), // 9
						rTable.dwIBuyItemPrice, rTable.dwISellItemPrice, rTable.dwRefinedVnum, rTable.wRefineSet, rTable.bAlterToMagicItemPct, // 14
						set_Item_LimitType_Value(rTable.aLimits[0].bType).c_str(), rTable.aLimits[0].lValue, set_Item_LimitType_Value(rTable.aLimits[1].bType).c_str(), rTable.aLimits[1].lValue, // 18
						set_Item_ApplyType_Value(rTable.aApplies[0].bType).c_str(), rTable.aApplies[0].lValue, set_Item_ApplyType_Value(rTable.aApplies[1].bType).c_str(), rTable.aApplies[1].lValue,
						set_Item_ApplyType_Value(rTable.aApplies[2].bType).c_str(), rTable.aApplies[2].lValue, // 24
						rTable.alValues[0], rTable.alValues[1], rTable.alValues[2], rTable.alValues[3], rTable.alValues[4], rTable.alValues[5], // 30
						rTable.bSpecular, rTable.bGainSocketPct, retrieveAddonType(rTable.dwVnum) // 33
					);
				}
				;
			}
		}

		free(data);
	}

	fclose(fp);
}

void SaveItemProto()
{
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

	DWORD dwElements = m_iItemTableSize;
	fwrite(&dwElements, sizeof(DWORD), 1, fp);

	CLZObject zObj;
	std::vector <CItemData::TItemTable> vec_item_table (&m_pItemTable[0], &m_pItemTable[m_iItemTableSize - 1]);
	sort (&m_pItemTable[0], &m_pItemTable[0] + m_iItemTableSize);
	if (!CLZO::instance().CompressEncryptedMemory(zObj, m_pItemTable, sizeof(CItemData::TItemTable) * m_iItemTableSize, g_adwItemProtoKey))
	{
		printf("cannot compress\n");
		fclose(fp);
		return;
	}

	const CLZObject::THeader & r = zObj.GetHeader();

	printf("Elements %d\n%u --Compress--> %u --Encrypt--> %u, GetSize %u\n",
			m_iItemTableSize,
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

#define NL "\n"
#include "OptionParser.h"
enum  optionIndex { UNKNOWN, HELP, DEBUG_MODE, ITEM_PROTO, MOB_PROTO, PACK, UNPACK };

const option::Descriptor usage[] = // don't use TAB in here!
{
	{UNKNOWN,		0,	"",		"",				option::Arg::None,		"USAGE: example [options]"},
	{HELP,			0,	"h",	"help",			option::Arg::None,		"    --help, -h             Print usage and exit." },
	{DEBUG_MODE,	0,	"d",	"debug",		option::Arg::None,		"    --debug, -d            Enable debug mode" },
	{ITEM_PROTO,	0,	"i",	"iproto",		option::Arg::None,		"    --iproto, -i           Process item proto" },
	{MOB_PROTO,		0,	"m",	"mproto",		option::Arg::None,		"    --mproto, -m           Process mob proto" },
	{PACK,			0,	"p",	"pack",			option::Arg::None,		"    --pack, -p             Pack" },
	{UNPACK,		0,	"u",	"unpack",		option::Arg::None,		"    --unpack, -u           Unpack" },
	{UNKNOWN,		0,	"",		"",				option::Arg::None,		NL "Examples:"
																		NL "    dump_proto.exe --help"
																		NL "    dump_proto.exe -dpim"
																		NL "    dump_proto.exe -duim"
																		NL "    dump_proto.exe -dpm"
																		NL "    dump_proto.exe -dum"
																		NL "    dump_proto.exe -dpi"
																		NL "    dump_proto.exe -dui"
	},
	{0,0,0,0,0,0}
};

int main(int argc, char ** argv)
{
	argc-=(argc>0); argv+=(argc>0); // skip program name argv[0] if present
	option::Stats  stats(usage, argc, argv);
	std::vector<option::Option> options(stats.options_max);
	std::vector<option::Option> buffer(stats.buffer_max);
	option::Parser parse(usage, argc, argv, &options[0], &buffer[0]);

	if (parse.error())
		return 1;

	if (argc == 0)
	{
		if (BuildMobTable())
		{
			SaveMobProto();
			cout << "BuildMobTable working normal" << endl;
		}

		if (BuildItemTable())
		{
			SaveItemProto();
			cout << "BuildItemTable working normal" << endl;
		}
		return 0;
	}

	bool bAItemProto = false;
	bool bAMobProto = false;
	bool bXPhase = false;
	for (size_t idx1 = 0; idx1 < parse.optionsCount(); ++idx1)
	{
		option::Option& opt = buffer[idx1];
		switch (opt.index())
		{
			case DEBUG_MODE:
				bDebugFlag = true;
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

