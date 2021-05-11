#pragma once

#ifdef ENABLE_DS_SET
#include "ItemData.h"

#define DRAGON_SOUL_STRENGTH_MAX 7

const std::string g_astGradeName[] =
{
	"grade_normal",
	"grade_brilliant",
	"grade_rare",
	"grade_ancient",
	"grade_legendary",
#ifdef ENABLE_DS_GRADE_MYTH
	"grade_myth",
#endif
};

const std::string g_astStepName[] =
{
	"step_lowest",
	"step_low",
	"step_mid",
	"step_high",
	"step_highest",
};

class CDragonSoulTable
{
	enum EDragonSoulGradeTypes
	{
		DRAGON_SOUL_GRADE_NORMAL,
		DRAGON_SOUL_GRADE_BRILLIANT,
		DRAGON_SOUL_GRADE_RARE,
		DRAGON_SOUL_GRADE_ANCIENT,
		DRAGON_SOUL_GRADE_LEGENDARY,
#ifdef ENABLE_DS_GRADE_MYTH
		DRAGON_SOUL_GRADE_MYTH,
#endif
		DRAGON_SOUL_GRADE_MAX,

	};

	enum EDragonSoulStepTypes
	{
		DRAGON_SOUL_STEP_LOWEST,
		DRAGON_SOUL_STEP_LOW,
		DRAGON_SOUL_STEP_MID,
		DRAGON_SOUL_STEP_HIGH,
		DRAGON_SOUL_STEP_HIGHEST,
		DRAGON_SOUL_STEP_MAX,
	};

protected:
	CTextFileLoader TextFileLoader;

	struct DragonSoulBasicApply
	{
		std::string stApplyName;
		WORD iApplyType;
		WORD iApplyValue;
	};

	struct DragonSoulAdditionalApply
	{
		std::string stApplyName;
		WORD iApplyType;
		WORD iApplyValue;
		BYTE iProb;
	};

	struct DragonSoulItem
	{
		BYTE iType;
		std::vector<DragonSoulBasicApply> vec_BasicApplys;
		std::vector<DragonSoulAdditionalApply> vec_AdditionalApplys;
	};

	std::map<BYTE, std::string> m_map_VnumMapper;
	std::map<std::string, DragonSoulItem> m_map_DragonSoulTable;
	BYTE WeightTable[DRAGON_SOUL_GRADE_MAX][DRAGON_SOUL_STEP_MAX][DRAGON_SOUL_STRENGTH_MAX];

public:
	CDragonSoulTable();
	~CDragonSoulTable();

	bool Load(const char* szDragonSoulTable);
	BYTE GetDSSetWeight(BYTE iSetGrade);
	BYTE GetDSBasicApplyCount(BYTE iDSType);
	WORD GetDSBasicApplyValue(BYTE iDSType, BYTE iApplyType);
	WORD GetDSAdditionalApplyValue(BYTE iDSType, BYTE iApplyType);
	WORD GetApplyType(std::string stApplyName);

private:
	bool LoadVnumMapper();
	bool LoadBasicApplys();
	bool LoadAdditionalApplys();
	bool LoadWeightTable();
};

#endif
