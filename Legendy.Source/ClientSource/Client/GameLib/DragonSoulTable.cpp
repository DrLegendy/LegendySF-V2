#include "StdAfx.h"

#ifdef ENABLE_DS_SET
#include "DragonSoulTable.h"

CDragonSoulTable::CDragonSoulTable()
{
}

CDragonSoulTable::~CDragonSoulTable()
{
}

bool CDragonSoulTable::Load(const char* szDragonSoulTable)
{
	if (!TextFileLoader.Load(szDragonSoulTable))
	{
		return false;
	}

	if (!LoadVnumMapper())
	{
		TraceError("Error loading VnumMapper.");
		return false;
	}

	if (!LoadBasicApplys())
	{
		TraceError("Error loading BasicApplys.");
		return false;
	}

	if (!LoadAdditionalApplys())
	{
		TraceError("Error loading AdditionalApplys.");
		return false;
	}

	if (!LoadWeightTable())
	{
		TraceError("Error loading WeighTables.");
		return false;
	}

	return true;
}

bool CDragonSoulTable::LoadVnumMapper()
{
	m_map_DragonSoulTable.clear();
	m_map_VnumMapper.clear();
	TextFileLoader.SetTop();

	if (!TextFileLoader.SetChildNode("vnummapper"))
	{
		TraceError("VnumMapper-Group missing.");
		return false;
	}

	CTokenVector* values;
	BYTE id = 0;

	while (TextFileLoader.GetTokenVector(std::to_string(++id), &values))
	{
		std::string stName = values->at(0);
		BYTE iType = atoi(values->at(1).c_str());

		if (m_map_DragonSoulTable.find(stName) != m_map_DragonSoulTable.end())
		{
			TraceError("Duplicated name in VnumMapper-Group '%s'.", stName.c_str());
			return false;
		}

		DragonSoulItem item;
		item.iType = iType;

		m_map_DragonSoulTable.insert(std::make_pair(stName, item));
		m_map_VnumMapper.insert(std::make_pair(iType, stName));
	}

	return true;
}

bool CDragonSoulTable::LoadBasicApplys()
{
	TextFileLoader.SetTop();

	if (!TextFileLoader.SetChildNode("basicapplys"))
	{
		TraceError("BasicApplys-Group missing.");
		return false;
	}

	for (auto& dragonSoulItem : m_map_DragonSoulTable)
	{
		DragonSoulItem* item = &dragonSoulItem.second;
		const std::string stDragonSoulName = dragonSoulItem.first;
		item->vec_BasicApplys.clear();

		if (!TextFileLoader.SetChildNode(stDragonSoulName.c_str()))
		{
			TraceError("BasicApplys-ChildGroup '%s' missing.", stDragonSoulName.c_str());
			return false;
		}

		CTokenVector* values;
		BYTE id = 0;

		while (TextFileLoader.GetTokenVector(std::to_string(++id), &values))
		{
			if (values->size() != 2)
			{
				TraceError("Invalid columns size in BasicApplys-ChildGroup - %s", stDragonSoulName.c_str());
				return false;
			}

			DragonSoulBasicApply basicApply;
			basicApply.stApplyName = values->at(0);
			basicApply.iApplyType = GetApplyType(values->at(0));
			basicApply.iApplyValue = atoi(values->at(1).c_str());

			item->vec_BasicApplys.push_back(basicApply);
		}

		TextFileLoader.SetParentNode();
	}

	return true;
}

bool CDragonSoulTable::LoadAdditionalApplys()
{
	TextFileLoader.SetTop();

	if (!TextFileLoader.SetChildNode("additionalapplys"))
	{
		TraceError("AdditionalApplys-Group missing.");
		return false;
	}

	for (auto& dragonSoulItem : m_map_DragonSoulTable)
	{
		DragonSoulItem* item = &dragonSoulItem.second;
		const std::string stDragonSoulName = dragonSoulItem.first;
		item->vec_AdditionalApplys.clear();

		if (!TextFileLoader.SetChildNode(stDragonSoulName.c_str()))
		{
			TraceError("AdditionalApplys-ChildGroup '%s' missing.", stDragonSoulName.c_str());
			return false;
		}

		CTokenVector* values;
		BYTE id = 0;

		while (TextFileLoader.GetTokenVector(std::to_string(++id), &values))
		{
			if (values->size() != 3)
			{
				TraceError("Invalid columns size in AdditionalApplys-ChildGroup - %s", stDragonSoulName.c_str());
				return false;
			}

			DragonSoulAdditionalApply additionalApply;
			additionalApply.stApplyName = values->at(0);
			additionalApply.iApplyType = GetApplyType(values->at(0));
			additionalApply.iApplyValue = atoi(values->at(1).c_str());
			additionalApply.iProb = atoi(values->at(2).c_str());

			item->vec_AdditionalApplys.push_back(additionalApply);
		}

		TextFileLoader.SetParentNode();
	}

	return true;
}

bool CDragonSoulTable::LoadWeightTable()
{
	memset(&WeightTable, 0, sizeof(WeightTable));
	TextFileLoader.SetTop();

	if (!TextFileLoader.SetChildNode("weighttables"))
	{
		TraceError("WeightTables-Group missing.");
		return false;
	}

	if (!TextFileLoader.SetChildNode("default"))
	{
		TraceError("Default-ChildGroup missing in Group WightTables.");
		return false;
	}

	for (BYTE iGrade = 0; iGrade < DRAGON_SOUL_GRADE_MAX; ++iGrade)
	{
		if (!TextFileLoader.SetChildNode(g_astGradeName[iGrade].c_str()))
		{
			TraceError("WeightTables-Default-ChildGroup '%s' missing.", g_astGradeName[iGrade].c_str());
			return false;
		}

		CTokenVector* weights;
		for (BYTE iStep = 0; iStep < DRAGON_SOUL_STEP_MAX; ++iStep)
		{
			if (!TextFileLoader.GetTokenVector(g_astStepName[iStep].c_str(), &weights))
			{
				Tracef("LoadDragonSoulTable - WeighTables:: Cannot find step '%s' for '%s'", g_astStepName[iStep].c_str(), g_astGradeName[iGrade].c_str());
				return false;
			}

			if (weights->size() != DRAGON_SOUL_STRENGTH_MAX)
			{
				Tracef("LoadDragonSoulTable - WeighTables:: Invalid weight count (%s, %s, wrong: %i, correct: %i)", g_astStepName[iStep].c_str(), g_astGradeName[iGrade].c_str(), weights->size(), DRAGON_SOUL_STRENGTH_MAX);
				return false;
			}

			for (BYTE iStrength = 0; iStrength < DRAGON_SOUL_STRENGTH_MAX; ++iStrength)
			{
				int value = atoi(weights->at(iStrength).c_str());
				WeightTable[iGrade][iStep][iStrength] = value;
			}
		}

		TextFileLoader.SetParentNode();
	}

	return true;
}
BYTE CDragonSoulTable::GetDSSetWeight(BYTE iSetGrade)
{
	if (iSetGrade < DRAGON_SOUL_GRADE_ANCIENT)
	{
		return 0;
	}

	if (iSetGrade >= DRAGON_SOUL_GRADE_MAX)
	{
		TraceError("Not supported grade %i", iSetGrade);
		return 0;
	}

	return WeightTable[iSetGrade - 1][DRAGON_SOUL_STEP_LOWEST][0];
}

BYTE CDragonSoulTable::GetDSBasicApplyCount(BYTE iDSType)
{
	const auto vnumMapperIt = m_map_VnumMapper.find(iDSType);
	if (vnumMapperIt == m_map_VnumMapper.end())
	{
		TraceError("GetDSBasicApplyCount:: Could not find DS-Type by type %i", iDSType);
		return 0;
	}

	const auto it = m_map_DragonSoulTable.find(vnumMapperIt->second);
	if (it == m_map_DragonSoulTable.end())
	{
		TraceError("GetDSBasicApplyCount:: Could not find DS-Table by vnum %i name %s", vnumMapperIt->first, vnumMapperIt->second.c_str());
		return 0;
	}

	return it->second.vec_BasicApplys.size();
}

WORD CDragonSoulTable::GetDSBasicApplyValue(BYTE iDSType, BYTE applyType)
{
	const auto vnumMapperIt = m_map_VnumMapper.find(iDSType);
	if (vnumMapperIt == m_map_VnumMapper.end())
	{
		TraceError("GetDSBasicApplyValue:: Could not find DS-Type by type &i", iDSType);
		return 0;
	}

	const auto it = m_map_DragonSoulTable.find(vnumMapperIt->second);
	if (it == m_map_DragonSoulTable.end())
	{
		TraceError("GetDSBasicApplyValue:: Could not find DS-Table by vnum %i name %s", vnumMapperIt->first, vnumMapperIt->second.c_str());
		return 0;
	}

	for (const auto& basicApply : it->second.vec_BasicApplys)
	{
		if (basicApply.iApplyType == applyType)
		{
			return basicApply.iApplyValue;
		}
	}

	return 0;
}

WORD CDragonSoulTable::GetDSAdditionalApplyValue(BYTE iDSType, BYTE applyType)
{
	const auto vnumMapperIt = m_map_VnumMapper.find(iDSType);
	if (vnumMapperIt == m_map_VnumMapper.end())
	{
		TraceError("GetDSAdditionalApplyValue:: Could not find DS-Type by type %i", iDSType);
		return 0;
	}

	const auto it = m_map_DragonSoulTable.find(vnumMapperIt->second);
	if (it == m_map_DragonSoulTable.end())
	{
		TraceError("GetDSAdditionalApplyValue:: Could not find DS-Table by vnum %i name %s", vnumMapperIt->first, vnumMapperIt->second.c_str());
		return 0;
	}

	for (const auto& additionalApply : it->second.vec_AdditionalApplys)
	{
		if (additionalApply.iApplyType == applyType)
		{
			return additionalApply.iApplyValue;
		}
	}

	return 0;
}

WORD CDragonSoulTable::GetApplyType(std::string applyName)
{
	struct SValueName
	{
		std::string stName;
		long lValue;
	};

	SValueName ApplyTypeNames[] =
	{
		{ "STR",							CItemData::APPLY_STR						},
		{ "DEX",							CItemData::APPLY_DEX						},
		{ "CON",							CItemData::APPLY_CON						},
		{ "INT",							CItemData::APPLY_INT						},
		{ "MAX_HP",							CItemData::APPLY_MAX_HP						},
		{ "MAX_SP",							CItemData::APPLY_MAX_SP						},
		{ "MAX_STAMINA",					CItemData::APPLY_MAX_STAMINA				},
		{ "POISON_REDUCE",					CItemData::APPLY_POISON_REDUCE				},
		{ "EXP_DOUBLE_BONUS",				CItemData::APPLY_EXP_DOUBLE_BONUS			},
		{ "GOLD_DOUBLE_BONUS",				CItemData::APPLY_GOLD_DOUBLE_BONUS			},
		{ "ITEM_DROP_BONUS",				CItemData::APPLY_ITEM_DROP_BONUS			},
		{ "HP_REGEN",						CItemData::APPLY_HP_REGEN					},
		{ "SP_REGEN",						CItemData::APPLY_SP_REGEN					},
		{ "ATTACK_SPEED",					CItemData::APPLY_ATT_SPEED					},
		{ "MOVE_SPEED",						CItemData::APPLY_MOV_SPEED					},
		{ "CAST_SPEED",						CItemData::APPLY_CAST_SPEED					},
		{ "ATT_BONUS",						CItemData::APPLY_ATT_GRADE_BONUS			},
		{ "DEF_BONUS",						CItemData::APPLY_DEF_GRADE_BONUS			},
		{ "MAGIC_ATT_GRADE",				CItemData::APPLY_MAGIC_ATT_GRADE			},
		{ "MAGIC_DEF_GRADE",				CItemData::APPLY_MAGIC_DEF_GRADE			},
		{ "SKILL",							CItemData::APPLY_SKILL						},
		{ "ATTBONUS_ANIMAL",				CItemData::APPLY_ATTBONUS_ANIMAL			},
		{ "ATTBONUS_UNDEAD",				CItemData::APPLY_ATTBONUS_UNDEAD			},
		{ "ATTBONUS_DEVIL",					CItemData::APPLY_ATTBONUS_DEVIL				},
		{ "ATTBONUS_HUMAN",					CItemData::APPLY_ATTBONUS_HUMAN				},
		{ "ADD_BOW_DISTANCE",				CItemData::APPLY_BOW_DISTANCE				},
		{ "DODGE",							CItemData::APPLY_DODGE						},
		{ "BLOCK",							CItemData::APPLY_BLOCK						},
		{ "RESIST_SWORD",					CItemData::APPLY_RESIST_SWORD				},
		{ "RESIST_TWOHAND",					CItemData::APPLY_RESIST_TWOHAND				},
		{ "RESIST_DAGGER",					CItemData::APPLY_RESIST_DAGGER				},
		{ "RESIST_BELL",					CItemData::APPLY_RESIST_BELL				},
		{ "RESIST_FAN",						CItemData::APPLY_RESIST_FAN					},
		{ "RESIST_BOW",						CItemData::APPLY_RESIST_BOW					},
		{ "RESIST_FIRE",					CItemData::APPLY_RESIST_FIRE				},
		{ "RESIST_ELEC",					CItemData::APPLY_RESIST_ELEC				},
		{ "RESIST_MAGIC",					CItemData::APPLY_RESIST_MAGIC				},
		{ "RESIST_WIND",					CItemData::APPLY_RESIST_WIND				},
		{ "REFLECT_MELEE",					CItemData::APPLY_REFLECT_MELEE				},
		{ "REFLECT_CURSE",					CItemData::APPLY_REFLECT_CURSE				},
		{ "RESIST_ICE",						CItemData::APPLY_RESIST_ICE					},
		{ "RESIST_EARTH",					CItemData::APPLY_RESIST_EARTH				},
		{ "RESIST_DARK",					CItemData::APPLY_RESIST_DARK				},
		{ "RESIST_CRITICAL",				CItemData::APPLY_ANTI_CRITICAL_PCT			},
		{ "RESIST_PENETRATE",				CItemData::APPLY_ANTI_PENETRATE_PCT			},
		{ "POISON",							CItemData::APPLY_POISON_PCT					},
		{ "SLOW",							CItemData::APPLY_SLOW_PCT					},
		{ "STUN",							CItemData::APPLY_STUN_PCT					},
		{ "STEAL_HP",						CItemData::APPLY_STEAL_HP					},
		{ "STEAL_SP",						CItemData::APPLY_STEAL_SP					},
		{ "MANA_BURN_PCT",					CItemData::APPLY_MANA_BURN_PCT				},
		{ "CRITICAL",						CItemData::APPLY_CRITICAL_PCT				},
		{ "PENETRATE",						CItemData::APPLY_PENETRATE_PCT				},
		{ "KILL_SP_RECOVER",				CItemData::APPLY_KILL_SP_RECOVER			},
		{ "KILL_HP_RECOVER",				CItemData::APPLY_KILL_HP_RECOVER			},
		{ "PENETRATE_PCT",					CItemData::APPLY_PENETRATE_PCT				},
		{ "CRITICAL_PCT",					CItemData::APPLY_CRITICAL_PCT				},
		{ "POISON_PCT",						CItemData::APPLY_POISON_PCT					},
		{ "STUN_PCT",						CItemData::APPLY_STUN_PCT					},
		{ "ATT_BONUS_TO_WARRIOR",			CItemData::APPLY_ATT_BONUS_TO_WARRIOR		},
		{ "ATT_BONUS_TO_ASSASSIN",			CItemData::APPLY_ATT_BONUS_TO_ASSASSIN		},
		{ "ATT_BONUS_TO_SURA",				CItemData::APPLY_ATT_BONUS_TO_SURA			},
		{ "ATT_BONUS_TO_SHAMAN",			CItemData::APPLY_ATT_BONUS_TO_SHAMAN		},
		{ "ATT_BONUS_TO_MONSTER",			CItemData::APPLY_ATT_BONUS_TO_MONSTER		},
		{ "ATT_BONUS_TO_MOB",				CItemData::APPLY_ATT_BONUS_TO_MONSTER		},
		{ "MALL_ATTBONUS",					CItemData::APPLY_MALL_ATTBONUS				},
		{ "MALL_EXPBONUS",					CItemData::APPLY_MALL_EXPBONUS				},
		{ "MALL_DEFBONUS",					CItemData::APPLY_MALL_DEFBONUS				},
		{ "MALL_ITEMBONUS",					CItemData::APPLY_MALL_ITEMBONUS				},
		{ "MALL_GOLDBONUS",					CItemData::APPLY_MALL_GOLDBONUS				},
		{ "MAX_HP_PCT",						CItemData::APPLY_MAX_HP_PCT					},
		{ "MAX_SP_PCT",						CItemData::APPLY_MAX_SP_PCT					},
		{ "SKILL_DAMAGE_BONUS",				CItemData::APPLY_SKILL_DAMAGE_BONUS			},
		{ "NORMAL_HIT_DAMAGE_BONUS",		CItemData::APPLY_NORMAL_HIT_DAMAGE_BONUS	},
		{ "SKILL_DEFEND_BONUS",				CItemData::APPLY_SKILL_DEFEND_BONUS			},
		{ "NORMAL_HIT_DEFEND_BONUS",		CItemData::APPLY_NORMAL_HIT_DEFEND_BONUS	},

		{ "RESIST_WARRIOR",					CItemData::APPLY_RESIST_WARRIOR				},
		{ "RESIST_ASSASSIN",				CItemData::APPLY_RESIST_ASSASSIN			},
		{ "RESIST_SURA",					CItemData::APPLY_RESIST_SURA				},
		{ "RESIST_SHAMAN",					CItemData::APPLY_RESIST_SHAMAN				},
		{ "INFINITE_AFFECT_DURATION",		0X1FFFFFFF									},
		{ "ENERGY",							CItemData::APPLY_ENERGY						},
		{ "COSTUME_ATTR_BONUS",				CItemData::APPLY_COSTUME_ATTR_BONUS			},
		{ "MAGIC_ATTBONUS_PER",				CItemData::APPLY_MAGIC_ATTBONUS_PER			},
		{ "MELEE_MAGIC_ATTBONUS_PER",		CItemData::APPLY_MELEE_MAGIC_ATTBONUS_PER	},

#ifdef ENABLE_WOLFMAN_CHARACTER
		{ "BLEEDING_REDUCE",				CItemData::APPLY_BLEEDING_REDUCE			},
		{ "BLEEDING_PCT",					CItemData::APPLY_BLEEDING_PCT				},
		{ "ATT_BONUS_TO_WOLFMAN",			CItemData::APPLY_ATT_BONUS_TO_WOLFMAN		},
		{ "RESIST_WOLFMAN",					CItemData::APPLY_RESIST_WOLFMAN				},
		{ "RESIST_CLAW",					CItemData::APPLY_RESIST_CLAW				},
#endif

#ifdef ENABLE_ELEMENT_ADD
		{ "ENCHANT_ELECT",					CItemData::APPLY_ENCHANT_ELEC				},
		{ "ENCHANT_FIRE",					CItemData::APPLY_ENCHANT_FIRE				},
		{ "ENCHANT_ICE",					CItemData::APPLY_ENCHANT_ICE				},
		{ "ENCHANT_WIND",					CItemData::APPLY_ENCHANT_WIND				},
		{ "ENCHANT_EARTH",					CItemData::APPLY_ENCHANT_EARTH				},
		{ "ENCHANT_DARK",					CItemData::APPLY_ENCHANT_DARK				},
		{ "ATT_BONUS_CZ",					CItemData::APPLY_ATTBONUS_CZ				},
		{ "ATT_BONUS_INSECT",				CItemData::APPLY_ATTBONUS_INSECT			},
		{ "ATT_BONUS_DESERT",				CItemData::APPLY_ATTBONUS_DESERT			},
#endif
	};

	for (const auto& apply : ApplyTypeNames)
	{
		if (!apply.stName.compare(applyName))
		{
			return apply.lValue;
		}
	}

	return 0;
}
#endif
