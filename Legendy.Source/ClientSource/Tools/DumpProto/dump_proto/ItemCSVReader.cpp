#include "ItemCSVReader.h"
#include <math.h>

//#define ENABLE_NUMERIC_FIELD
#ifdef ENABLE_NUMERIC_FIELD
bool _IsNumericString(const std::string& trimInputString)
{
	if (trimInputString.empty())
		return false;
	bool isNumber = true;
	for (auto& c : trimInputString)
	{
		if (!std::isdigit(c) && c != '-' && c != '+')
		{
			isNumber = false;
			break;
		}
	}
	return isNumber;
}
#endif

bool bDebugFlag = false;
void writeDebug(const char* szMsg, int iInput, int type_value)
{
	static char __buf[512];
	static FILE * f1 = NULL;
	if (NULL == f1)
		fopen_s(&f1, "debug.log", "a+");

	if (type_value)
		_snprintf(__buf, sizeof(__buf), "ERROR: (%d->%d) %s\n", type_value, iInput, szMsg);
	else
		_snprintf(__buf, sizeof(__buf), "ERROR: (%d) %s\n", iInput, szMsg);
	fwrite(__buf, sizeof(char), strlen(__buf), f1);
}

using namespace std;

inline string trim_left(const string& str)
{
    string::size_type n = str.find_first_not_of(" \t\v\n\r");
    return n == string::npos ? str : str.substr(n, str.length());
}

inline string trim_right(const string& str)
{
    string::size_type n = str.find_last_not_of(" \t\v\n\r");
    return n == string::npos ? str : str.substr(0, n + 1);
}

string trim(const string& str){return trim_left(trim_right(str));}

static string* StringSplit(string strOrigin, string strTok)
{
    int     cutAt;
    int     index     = 0;
    string* strResult = new string[30];

    while ((cutAt = strOrigin.find_first_of(strTok)) != strOrigin.npos)
    {
       if (cutAt > 0)
       {
            strResult[index++] = strOrigin.substr(0, cutAt);
       }
       strOrigin = strOrigin.substr(cutAt+1);
    }

    if(strOrigin.length() > 0)
    {
        strResult[index++] = strOrigin.substr(0, cutAt);
    }

	for( int i=0;i<index;i++)
	{
		strResult[i] = trim(strResult[i]);
	}

    return strResult;
}


string arITVType[] = {"ITEM_NONE", "ITEM_WEAPON",
	"ITEM_ARMOR", "ITEM_USE",
	"ITEM_AUTOUSE", "ITEM_MATERIAL",
	"ITEM_SPECIAL", "ITEM_TOOL",
	"ITEM_LOTTERY", "ITEM_ELK",

	"ITEM_METIN", "ITEM_CONTAINER",
	"ITEM_FISH", "ITEM_ROD",
	"ITEM_RESOURCE", "ITEM_CAMPFIRE",
	"ITEM_UNIQUE", "ITEM_SKILLBOOK",
	"ITEM_QUEST", "ITEM_POLYMORPH",

	"ITEM_TREASURE_BOX", "ITEM_TREASURE_KEY",
	"ITEM_SKILLFORGET", "ITEM_GIFTBOX",
	"ITEM_PICK", "ITEM_HAIR",
	"ITEM_TOTEM", "ITEM_BLEND",
	"ITEM_COSTUME", "ITEM_DS",

	"ITEM_SPECIAL_DS",	"ITEM_EXTRACT",
	"ITEM_SECONDARY_COIN",

	"ITEM_RING",
	"ITEM_BELT",
	"ITEM_PET", "ITEM_MEDIUM", // 36,37
 	"ITEM_GACHA" // 38
};


int get_Item_Type_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retInt = -1;
	//cout << "Type : " << typeStr << " -> ";
	for (int j=0;j<sizeof(arITVType)/sizeof(arITVType[0]);j++) {
		string tempString = arITVType[j];
		if	(inputString.find(tempString)!=string::npos && tempString.find(inputString)!=string::npos) {
			//cout << j << " ";
			retInt =  j;
			break;
		}
	}
	//cout << endl;

	return retInt;

}

string set_Item_Type_Value(int iInput) // enum -1=None
{
	if (iInput==(BYTE)-1)
		return "NONE";
		// return "";

	string inputString("");
	int tmpFlag;
	for(int i =0;i<sizeof(arITVType)/sizeof(arITVType[0]);i++)
	{
		tmpFlag = i;
		if (iInput == tmpFlag)
		{
			if (bDebugFlag)
				iInput = -1;
			inputString = arITVType[i];
			break;
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput != -1)
		return std::to_string(iInput);
#endif
	if (bDebugFlag && iInput!=-1)
		writeDebug("Item Type not found", iInput);

	return inputString;
}


string arIAFVSub1[] = { "WEAPON_SWORD", "WEAPON_DAGGER", "WEAPON_BOW", "WEAPON_TWO_HANDED",
			"WEAPON_BELL", "WEAPON_FAN", "WEAPON_ARROW", "WEAPON_MOUNT_SPEAR", "WEAPON_CLAW", "WEAPON_QUIVER", "WEAPON_BOUQUET"};
string arIAFVSub2[] = { "ARMOR_BODY", "ARMOR_HEAD", "ARMOR_SHIELD", "ARMOR_WRIST", "ARMOR_FOOTS",
			"ARMOR_NECK", "ARMOR_EAR", "ARMOR_NUM_TYPES"};
string arIAFVSub3[] = { "USE_POTION", "USE_TALISMAN", "USE_TUNING", "USE_MOVE", "USE_TREASURE_BOX", "USE_MONEYBAG", "USE_BAIT",
			"USE_ABILITY_UP", "USE_AFFECT", "USE_CREATE_STONE", "USE_SPECIAL", "USE_POTION_NODELAY", "USE_CLEAR",
			"USE_INVISIBILITY", "USE_DETACHMENT", "USE_BUCKET", "USE_POTION_CONTINUE", "USE_CLEAN_SOCKET",
			"USE_CHANGE_ATTRIBUTE", "USE_ADD_ATTRIBUTE", "USE_ADD_ACCESSORY_SOCKET", "USE_PUT_INTO_ACCESSORY_SOCKET",
			"USE_ADD_ATTRIBUTE2", "USE_RECIPE", "USE_CHANGE_ATTRIBUTE2", "USE_BIND", "USE_UNBIND", "USE_TIME_CHARGE_PER", "USE_TIME_CHARGE_FIX", "USE_PUT_INTO_BELT_SOCKET", "USE_PUT_INTO_RING_SOCKET",
			"USE_CHANGE_COSTUME_ATTR", "USE_RESET_COSTUME_ATTR",
#ifdef ENABLE_AURA_SYSTEM
				"USE_PUT_INTO_AURA_SOCKET",
#endif
	"USE_UNK33", "USE_CHANGE_ATTRIBUTE_PLUS"};
string arIAFVSub4[] = { "AUTOUSE_POTION", "AUTOUSE_ABILITY_UP", "AUTOUSE_BOMB", "AUTOUSE_GOLD", "AUTOUSE_MONEYBAG", "AUTOUSE_TREASURE_BOX"};
string arIAFVSub5[] = { "MATERIAL_LEATHER", "MATERIAL_BLOOD", "MATERIAL_ROOT", "MATERIAL_NEEDLE", "MATERIAL_JEWEL",
	"MATERIAL_DS_REFINE_NORMAL", "MATERIAL_DS_REFINE_BLESSED", "MATERIAL_DS_REFINE_HOLLY"};
string arIAFVSub6[] = { "SPECIAL_MAP", "SPECIAL_KEY", "SPECIAL_DOC", "SPECIAL_SPIRIT"};
string arIAFVSub7[] = { "TOOL_FISHING_ROD" };
string arIAFVSub8[] = { "LOTTERY_TICKET", "LOTTERY_INSTANT" };
string arIAFVSub10[] = { "METIN_NORMAL", "METIN_GOLD" };
string arIAFVSub12[] = { "FISH_ALIVE", "FISH_DEAD"};
string arIAFVSub14[] = { "RESOURCE_FISHBONE", "RESOURCE_WATERSTONEPIECE", "RESOURCE_WATERSTONE", "RESOURCE_BLOOD_PEARL",
					"RESOURCE_BLUE_PEARL", "RESOURCE_WHITE_PEARL", "RESOURCE_BUCKET", "RESOURCE_CRYSTAL", "RESOURCE_GEM",
					"RESOURCE_STONE", "RESOURCE_METIN", "RESOURCE_ORE"
#ifdef ENABLE_AURA_SYSTEM
						, "RESOURCE_AURA"
#endif
};
string arIAFVSub16[] = { "UNIQUE_NONE", "UNIQUE_BOOK", "UNIQUE_SPECIAL_RIDE", "UNIQUE_3", "UNIQUE_4", "UNIQUE_5",
				"UNIQUE_6", "UNIQUE_7", "UNIQUE_8", "UNIQUE_9", "USE_SPECIAL"};
string arIAFVSub28[] = { "COSTUME_BODY", "COSTUME_HAIR", "COSTUME_MOUNT", "COSTUME_ACCE", "COSTUME_WEAPON"
#ifdef ENABLE_AURA_SYSTEM
		, "COSTUME_AURA"
#endif
};
string arIAFVSub29[] = { "DS_SLOT1", "DS_SLOT2", "DS_SLOT3", "DS_SLOT4", "DS_SLOT5", "DS_SLOT6" };
string arIAFVSub31[] = { "EXTRACT_DRAGON_SOUL", "EXTRACT_DRAGON_HEART" };

string* arIAFVSubType[] = {0,	//0
	arIAFVSub1,		//1
	arIAFVSub2,	//2
	arIAFVSub3,	//3
	arIAFVSub4,	//4
	arIAFVSub5,	//5
	arIAFVSub6,	//6
	arIAFVSub7,	//7
	arIAFVSub8,	//8
	0,			//9
	arIAFVSub10,	//10
	0,			//11
	arIAFVSub12,	//12
	0,			//13
	arIAFVSub14,	//14
	0,			//15
	arIAFVSub16,	//16
	0,			//17
	0,			//18
	0,			//19
	0,			//20
	0,			//21
	0,			//22
	0,			//23
	0,			//24
	0,			//25
	0,			//26
	0,			//27
	arIAFVSub28,	//28
	arIAFVSub29,		//29
	arIAFVSub29,	//30
	arIAFVSub31,	//31
	0, // 32
	0,
	0,
	0, // 35
	0, // 36
	0, // 37
	0, // 38
	0, // 39
};

int arNumberOfSubtype[] =
{
	0,
	sizeof(arIAFVSub1)/sizeof(arIAFVSub1[0]),
	sizeof(arIAFVSub2)/sizeof(arIAFVSub2[0]),
	sizeof(arIAFVSub3)/sizeof(arIAFVSub3[0]),
	sizeof(arIAFVSub4)/sizeof(arIAFVSub4[0]),
	sizeof(arIAFVSub5)/sizeof(arIAFVSub5[0]),
	sizeof(arIAFVSub6)/sizeof(arIAFVSub6[0]),
	sizeof(arIAFVSub7)/sizeof(arIAFVSub7[0]),
	sizeof(arIAFVSub8)/sizeof(arIAFVSub8[0]),
	0,
	sizeof(arIAFVSub10)/sizeof(arIAFVSub10[0]),
	0,
	sizeof(arIAFVSub12)/sizeof(arIAFVSub12[0]),
	0,
	sizeof(arIAFVSub14)/sizeof(arIAFVSub14[0]),
	0,
	sizeof(arIAFVSub16)/sizeof(arIAFVSub16[0]),
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	sizeof(arIAFVSub28)/sizeof(arIAFVSub28[0]),
	sizeof(arIAFVSub29)/sizeof(arIAFVSub29[0]),
	sizeof(arIAFVSub29)/sizeof(arIAFVSub29[0]),
	sizeof(arIAFVSub31)/sizeof(arIAFVSub31[0]),
	0,
	0,
	0, //34
	0, //35
	0, //36
	0, //37
	0, //38
	0, //39
};

int get_Item_SubType_Value(int type_value, string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	if (arIAFVSubType[type_value]==0) {
		return 0;
	}
	//

	int retInt = -1;
	//cout << "SubType : " << subTypeStr << " -> ";
	for (int j=0;j<arNumberOfSubtype[type_value];j++) {
		string tempString = arIAFVSubType[type_value][j];
		string tempInputString = trim(inputString);
		if	(tempInputString.compare(tempString)==0)
		{
			//cout << j << " ";
			retInt =  j;
			break;
		}
	}
	//cout << endl;

	return retInt;
}

string set_Item_SubType_Value(int type_value, int iInput) // enum -1=None
{
	// if (type_value==-1 || arIAFVSubType[type_value]==0 || iInput==-1)
	if (type_value==(BYTE)-1 || arIAFVSubType[type_value]==0 || iInput==(BYTE)-1)
		return "0";
		// return "";

	string inputString("");
	int tmpFlag;
	for(int i =0;i<arNumberOfSubtype[type_value];i++)
	{
		tmpFlag = i;
		if (iInput == tmpFlag)
		{
			if (bDebugFlag)
				iInput = -1;
			inputString = arIAFVSubType[type_value][i];
			break;
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput != -1)
		return std::to_string(iInput);
#endif
	if (bDebugFlag && iInput!=-1)
		writeDebug("Item SubType not found", iInput, type_value);
	return inputString;
}


string arIAFVAntiFlag[] = {"ANTI_FEMALE", "ANTI_MALE", "ANTI_MUSA", "ANTI_ASSASSIN", "ANTI_SURA", "ANTI_MUDANG",
						"ANTI_GET", "ANTI_DROP", "ANTI_SELL", "ANTI_EMPIRE_A", "ANTI_EMPIRE_B", "ANTI_EMPIRE_C",
						"ANTI_SAVE", "ANTI_GIVE", "ANTI_PKDROP", "ANTI_STACK", "ANTI_MYSHOP", "ANTI_SAFEBOX", "ANTI_WOLFMAN",
						"ANTI_PET20", "ANTI_PET21"};

int get_Item_AntiFlag_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retValue = 0;
	string* arInputString = StringSplit(inputString, "|");
	for(int i =0;i<sizeof(arIAFVAntiFlag)/sizeof(arIAFVAntiFlag[0]);i++) {
		string tempString = arIAFVAntiFlag[i];
		for (int j=0; j<30 ; j++)
		{
			string tempString2 = arInputString[j];
			if (tempString2.compare(tempString)==0) {
				retValue = retValue + static_cast<int>(pow(2.0, static_cast<double>(i)));
			}

			if(tempString2.compare("") == 0)
				break;
		}
	}
	delete []arInputString;
	//cout << "AntiFlag : " << antiFlagStr << " -> " << retValue << endl;

	return retValue;
}

string set_Item_AntiFlag_Value(int iInput) // set
{
	if (iInput==0)
		return "NONE";
		// return "";

	string inputString("");
	int tmpFlag;
	auto iOldInput = iInput;
	for(int i =0;i<sizeof(arIAFVAntiFlag)/sizeof(arIAFVAntiFlag[0]);i++)
	{
		tmpFlag = static_cast<int>(pow(2.0, static_cast<double>(i)));
		if (iInput & tmpFlag)
		{
			if (bDebugFlag)
				iInput -= tmpFlag;
			if (!!inputString.compare(""))
				inputString += " | ";
			inputString += arIAFVAntiFlag[i];
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput)
		return std::to_string(iOldInput);
#endif
	if (bDebugFlag && iInput)
		writeDebug("Item AntiFlag not found", iInput);
	return inputString;
}


string arIFVFlag[] = {"ITEM_TUNABLE", "ITEM_SAVE", "ITEM_STACKABLE", "COUNT_PER_1GOLD", "ITEM_SLOW_QUERY", "ITEM_UNIQUE",
		"ITEM_MAKECOUNT", "ITEM_IRREMOVABLE", "CONFIRM_WHEN_USE", "QUEST_USE", "QUEST_USE_MULTIPLE",
		"QUEST_GIVE", "ITEM_QUEST", "LOG", "STACKABLE", "SLOW_QUERY", "REFINEABLE", "IRREMOVABLE", "ITEM_APPLICABLE"};

int get_Item_Flag_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retValue = 0;
	string* arInputString = StringSplit(inputString, "|");
	for(int i =0;i<sizeof(arIFVFlag)/sizeof(arIFVFlag[0]);i++) {
		string tempString = arIFVFlag[i];
		for (int j=0; j<30 ; j++)
		{
			string tempString2 = arInputString[j];
			if (tempString2.compare(tempString)==0) {
				retValue = retValue + static_cast<int>(pow(2.0, static_cast<double>(i)));
			}

			if(tempString2.compare("") == 0)
				break;
		}
	}
	delete []arInputString;
	//cout << "Flag : " << flagStr << " -> " << retValue << endl;

	return retValue;
}

string set_Item_Flag_Value(int iInput) // set
{
	if (iInput==0)
		return "NONE";
		// return "";

	string inputString("");
	int tmpFlag;
	auto iOldInput = iInput;
	for(int i =0;i<sizeof(arIFVFlag)/sizeof(arIFVFlag[0]);i++)
	{
		tmpFlag = static_cast<int>(pow(2.0, static_cast<double>(i)));
		if (iInput & tmpFlag)
		{
			if (bDebugFlag)
				iInput -= tmpFlag;
			if (!!inputString.compare(""))
				inputString += " | ";
			inputString += arIFVFlag[i];
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput)
		return std::to_string(iOldInput);
#endif
	if (bDebugFlag && iInput)
		writeDebug("Item Flag not found", iInput);
	return inputString;
}


string arIWFVWearrFlag[] = {"WEAR_BODY", "WEAR_HEAD", "WEAR_FOOTS", "WEAR_WRIST", "WEAR_WEAPON", "WEAR_NECK", "WEAR_EAR", "WEAR_SHIELD", "WEAR_UNIQUE",
				"WEAR_ARROW", "WEAR_HAIR", "WEAR_ABILITY"};

int get_Item_WearFlag_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retValue = 0;
	string* arInputString = StringSplit(inputString, "|");
	for(int i =0;i<sizeof(arIWFVWearrFlag)/sizeof(arIWFVWearrFlag[0]);i++) {
		string tempString = arIWFVWearrFlag[i];
		for (int j=0; j<30 ; j++)
		{
			string tempString2 = arInputString[j];
			if (tempString2.compare(tempString)==0) {
				retValue = retValue + static_cast<int>(pow(2.0, static_cast<double>(i)));
			}

			if(tempString2.compare("") == 0)
				break;
		}
	}
	delete []arInputString;
	//cout << "WearFlag : " << wearFlagStr << " -> " << retValue << endl;

	return retValue;
}

string set_Item_WearFlag_Value(int iInput) // set
{
	if (iInput==0)
		return "NONE";
		// return "";

	string inputString("");
	int tmpFlag;
	auto iOldInput = iInput;
	for(int i =0;i<sizeof(arIWFVWearrFlag)/sizeof(arIWFVWearrFlag[0]);i++)
	{
		tmpFlag = static_cast<int>(pow(2.0, static_cast<double>(i)));
		if (iInput & tmpFlag)
		{
			if (bDebugFlag)
				iInput -= tmpFlag;
			if (!!inputString.compare(""))
				inputString += " | ";
			inputString += arIWFVWearrFlag[i];
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput)
		return std::to_string(iOldInput);
#endif
	if (bDebugFlag && iInput)
		writeDebug("Item WearFlag not found", iInput);
	return inputString;
}


string arIIVImmune[] = {"PARA","CURSE","STUN","SLEEP","SLOW","POISON","TERROR","REFLECT"};

int get_Item_Immune_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retValue = 0;
	string* arInputString = StringSplit(inputString, "|");
	for(int i =0;i<sizeof(arIIVImmune)/sizeof(arIIVImmune[0]);i++) {
		string tempString = arIIVImmune[i];
		for (int j=0; j<30 ; j++)
		{
			string tempString2 = arInputString[j];
			if (tempString2.compare(tempString)==0) {
				retValue = retValue + static_cast<int>(pow(2.0, static_cast<double>(i)));
			}

			if(tempString2.compare("") == 0)
				break;
		}
	}
	delete []arInputString;
	//cout << "Immune : " << immuneStr << " -> " << retValue << endl;

	return retValue;
}

string set_Item_Immune_Value(int iInput) // set
{
	if (iInput==0)
		return "NONE";
		// return "";

	string inputString("");
	int tmpFlag;
	auto iOldInput = iInput;
	for(int i =0;i<sizeof(arIIVImmune)/sizeof(arIIVImmune[0]);i++)
	{
		tmpFlag = static_cast<int>(pow(2.0, static_cast<double>(i)));
		if (iInput & tmpFlag)
		{
			if (bDebugFlag)
				iInput -= tmpFlag;
			if (!!inputString.compare(""))
				inputString += " | ";
			inputString += arIIVImmune[i];
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput)
		return std::to_string(iOldInput);
#endif
	if (bDebugFlag && iInput)
		writeDebug("Item ImmuneFlag not found", iInput);
	return inputString;
}


string arILTVLimitType[] = {"LIMIT_NONE", "LEVEL", "STR", "DEX", "INT", "CON", "PC_BANG", "REAL_TIME", "REAL_TIME_FIRST_USE", "TIMER_BASED_ON_WEAR"};

int get_Item_LimitType_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retInt = -1;
	//cout << "LimitType : " << limitTypeStr << " -> ";
	for (int j=0;j<sizeof(arILTVLimitType)/sizeof(arILTVLimitType[0]);j++) {
		string tempString = arILTVLimitType[j];
		string tempInputString = trim(inputString);
		if	(tempInputString.compare(tempString)==0)
		{
			//cout << j << " ";
			retInt =  j;
			break;
		}
	}
	//cout << endl;

	return retInt;
}

string set_Item_LimitType_Value(int iInput) // enum -1=None
{
	if (iInput==(BYTE)-1)
		return "NONE";
		// return "";

	string inputString("");
	int tmpFlag;
	for(int i =0;i<sizeof(arILTVLimitType)/sizeof(arILTVLimitType[0]);i++)
	{
		tmpFlag = i;
		if (iInput == tmpFlag)
		{
			if (bDebugFlag)
				iInput = -1;
			inputString = arILTVLimitType[i];
			break;
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput != -1)
		return std::to_string(iInput);
#endif
	if (bDebugFlag && iInput!=-1)
		writeDebug("Item LimitType not found", iInput);
	return inputString;
}


string arIATVApplyType[] = {"APPLY_NONE", "APPLY_MAX_HP", "APPLY_MAX_SP", "APPLY_CON", "APPLY_INT", "APPLY_STR", "APPLY_DEX", "APPLY_ATT_SPEED",
		"APPLY_MOV_SPEED", "APPLY_CAST_SPEED", "APPLY_HP_REGEN", "APPLY_SP_REGEN", "APPLY_POISON_PCT", "APPLY_STUN_PCT",
		"APPLY_SLOW_PCT", "APPLY_CRITICAL_PCT", "APPLY_PENETRATE_PCT", "APPLY_ATTBONUS_HUMAN", "APPLY_ATTBONUS_ANIMAL",
		"APPLY_ATTBONUS_ORC", "APPLY_ATTBONUS_MILGYO", "APPLY_ATTBONUS_UNDEAD", "APPLY_ATTBONUS_DEVIL", "APPLY_STEAL_HP",
		"APPLY_STEAL_SP", "APPLY_MANA_BURN_PCT", "APPLY_DAMAGE_SP_RECOVER", "APPLY_BLOCK", "APPLY_DODGE", "APPLY_RESIST_SWORD",
		"APPLY_RESIST_TWOHAND", "APPLY_RESIST_DAGGER", "APPLY_RESIST_BELL", "APPLY_RESIST_FAN", "APPLY_RESIST_BOW", "APPLY_RESIST_FIRE",
		"APPLY_RESIST_ELEC", "APPLY_RESIST_MAGIC", "APPLY_RESIST_WIND", "APPLY_REFLECT_MELEE", "APPLY_REFLECT_CURSE", "APPLY_POISON_REDUCE",
		"APPLY_KILL_SP_RECOVER", "APPLY_EXP_DOUBLE_BONUS", "APPLY_GOLD_DOUBLE_BONUS", "APPLY_ITEM_DROP_BONUS", "APPLY_POTION_BONUS",
		"APPLY_KILL_HP_RECOVER", "APPLY_IMMUNE_STUN", "APPLY_IMMUNE_SLOW", "APPLY_IMMUNE_FALL", "APPLY_SKILL", "APPLY_BOW_DISTANCE",
		"APPLY_ATT_GRADE_BONUS", "APPLY_DEF_GRADE_BONUS", "APPLY_MAGIC_ATT_GRADE", "APPLY_MAGIC_DEF_GRADE", "APPLY_CURSE_PCT",
		"APPLY_MAX_STAMINA", "APPLY_ATTBONUS_WARRIOR", "APPLY_ATTBONUS_ASSASSIN", "APPLY_ATTBONUS_SURA", "APPLY_ATTBONUS_SHAMAN",
		"APPLY_ATTBONUS_MONSTER", "APPLY_MALL_ATTBONUS", "APPLY_MALL_DEFBONUS", "APPLY_MALL_EXPBONUS", "APPLY_MALL_ITEMBONUS",
		"APPLY_MALL_GOLDBONUS", "APPLY_MAX_HP_PCT", "APPLY_MAX_SP_PCT", "APPLY_SKILL_DAMAGE_BONUS", "APPLY_NORMAL_HIT_DAMAGE_BONUS",
		"APPLY_SKILL_DEFEND_BONUS", "APPLY_NORMAL_HIT_DEFEND_BONUS", "APPLY_PC_BANG_EXP_BONUS", "APPLY_PC_BANG_DROP_BONUS",
		"APPLY_EXTRACT_HP_PCT", "APPLY_RESIST_WARRIOR", "APPLY_RESIST_ASSASSIN", "APPLY_RESIST_SURA", "APPLY_RESIST_SHAMAN",
		"APPLY_ENERGY",	"APPLY_DEF_GRADE", "APPLY_COSTUME_ATTR_BONUS", "APPLY_MAGIC_ATTBONUS_PER", "APPLY_MELEE_MAGIC_ATTBONUS_PER",
		"APPLY_RESIST_ICE", "APPLY_RESIST_EARTH", "APPLY_RESIST_DARK", "APPLY_ANTI_CRITICAL_PCT", "APPLY_ANTI_PENETRATE_PCT",
		"APPLY_BLEEDING_REDUCE", "APPLY_BLEEDING_PCT", "APPLY_ATTBONUS_WOLFMAN", "APPLY_RESIST_WOLFMAN", "APPLY_RESIST_CLAW",
		"APPLY_ACCEDRAIN_RATE", "APPLY_RESIST_MAGIC_REDUCTION",
			"APPLY_FREEZE_PCT",
			"APPLY_LASTING_FIRE_PCT",
			"APPLY_MOUNT",
	#ifdef ENABLE_EXTRA_APPLY_BONUS
			"APPLY_ATTBONUS_STONE",
			"APPLY_ATTBONUS_BOSS",
			"APPLY_ATTBONUS_DUNGEON",
			"APPLY_RESIST_HUMAN",
			"APPLY_ATTBONUS_INSECT",
	#endif
	#ifdef ENABLE_ELEMENTAL_APPLY_BONUS
			"APPLY_ATTBONUS_ELEC",
			"APPLY_ATTBONUS_FIRE",
			"APPLY_ATTBONUS_ICE",
			"APPLY_ATTBONUS_WIND",
			"APPLY_ATTBONUS_EARTH",
			"APPLY_ATTBONUS_DARK",
			"APPLY_ATTBONUS_ZODIAC",
	#endif
};

int get_Item_ApplyType_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retInt = -1;
	//cout << "ApplyType : " << applyTypeStr << " -> ";
	for (int j=0;j<sizeof(arIATVApplyType)/sizeof(arIATVApplyType[0]);j++) {
		string tempString = arIATVApplyType[j];
		string tempInputString = trim(inputString);
		if	(tempInputString.compare(tempString)==0)
		{
			//cout << j << " ";
			retInt =  j;
			break;
		}
	}
	//cout << endl;

	return retInt;
}

string set_Item_ApplyType_Value(int iInput) // enum -1=None
{
	// if (iInput==-1)
	if (iInput==(BYTE)-1)
		return "NONE";
		// return "";

	string inputString("");
	int tmpFlag;
	for(int i =0;i<sizeof(arIATVApplyType)/sizeof(arIATVApplyType[0]);i++)
	{
		tmpFlag = i;
		if (iInput == tmpFlag)
		{
			if (bDebugFlag)
				iInput = -1;
			inputString = arIATVApplyType[i];
			break;
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput != -1)
		return std::to_string(iInput);
#endif
	if (bDebugFlag && iInput!=-1)
		writeDebug("Item ApplyType not found", iInput);
	return inputString;
}




string arMRVRank[] = {"PAWN", "S_PAWN", "KNIGHT", "S_KNIGHT", "BOSS", "KING"};

int get_Mob_Rank_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retInt = -1;
	//cout << "Rank : " << rankStr << " -> ";
	for (int j=0;j<sizeof(arMRVRank)/sizeof(arMRVRank[0]);j++) {
		string tempString = arMRVRank[j];
		string tempInputString = trim(inputString);
		if	(tempInputString.compare(tempString)==0)
		{
			//cout << j << " ";
			retInt =  j;
			break;
		}
	}
	//cout << endl;

	return retInt;
}

string set_Mob_Rank_Value(int iInput) // enum -1=None
{
	if (iInput==(BYTE)-1)
		return "";

	string inputString("");
	int tmpFlag;
	for(int i =0;i<sizeof(arMRVRank)/sizeof(arMRVRank[0]);i++)
	{
		tmpFlag = i;
		if (iInput == tmpFlag)
		{
			if (bDebugFlag)
				iInput = -1;
			inputString = arMRVRank[i];
			break;
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput != -1)
		return std::to_string(iInput);
#endif
	if (bDebugFlag && iInput!=-1)
		writeDebug("Mob Rank not found", iInput);
	return inputString;
}


string arMTVType[] = { "MONSTER", "NPC", "STONE", "WARP", "DOOR", "BUILDING", "PC", "POLYMORPH_PC", "HORSE", "GOTO", "PET"};

int get_Mob_Type_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retInt = -1;
	//cout << "Type : " << typeStr << " -> ";
	for (int j=0;j<sizeof(arMTVType)/sizeof(arMTVType[0]);j++) {
		string tempString = arMTVType[j];
		string tempInputString = trim(inputString);
		if	(tempInputString.compare(tempString)==0)
		{
			//cout << j << " ";
			retInt =  j;
			break;
		}
	}
	//cout << endl;

	return retInt;
}

string set_Mob_Type_Value(int iInput) // enum -1=None
{
	if (iInput==(BYTE)-1)
		return "";

	string inputString("");
	int tmpFlag;
	for(int i =0;i<sizeof(arMTVType)/sizeof(arMTVType[0]);i++)
	{
		tmpFlag = i;
		if (iInput == tmpFlag)
		{
			if (bDebugFlag)
				iInput = -1;
			inputString = arMTVType[i];
			break;
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput != -1)
		return std::to_string(iInput);
#endif
	if (bDebugFlag && iInput!=-1)
		writeDebug("Mob Type not found", iInput);
	return inputString;
}


string arMBTVBattleType[] = { "MELEE", "RANGE", "MAGIC", "SPECIAL", "POWER", "TANKER", "SUPER_POWER", "SUPER_TANKER"};

int get_Mob_BattleType_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retInt = -1;
	//cout << "Battle Type : " << battleTypeStr << " -> ";
	for (int j=0;j<sizeof(arMBTVBattleType)/sizeof(arMBTVBattleType[0]);j++) {
		string tempString = arMBTVBattleType[j];
		string tempInputString = trim(inputString);
		if	(tempInputString.compare(tempString)==0)
		{
			//cout << j << " ";
			retInt =  j;
			break;
		}
	}
	//cout << endl;

	return retInt;
}

string set_Mob_BattleType_Value(int iInput) // enum -1=None
{
	if (iInput==(BYTE)-1)
		return "";

	string inputString("");
	int tmpFlag;
	for(int i =0;i<sizeof(arMBTVBattleType)/sizeof(arMBTVBattleType[0]);i++)
	{
		tmpFlag = i;
		if (iInput == tmpFlag)
		{
			if (bDebugFlag)
				iInput = -1;
			inputString = arMBTVBattleType[i];
			break;
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput != -1)
		return std::to_string(iInput);
#endif
	if (bDebugFlag && iInput!=-1)
		writeDebug("Mob BattleType not found", iInput);
	return inputString;
}


string arMSVSize[] = { "SMALL", "MEDIUM", "BIG"};

int get_Mob_Size_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retInt = 0;
	//cout << "Size : " << sizeStr << " -> ";
	for (int j=0;j<sizeof(arMSVSize)/sizeof(arMSVSize[0]);j++) {
		string tempString = arMSVSize[j];
		string tempInputString = trim(inputString);
		if	(tempInputString.compare(tempString)==0)
		{
			//cout << j << " ";
			retInt =  j + 1;
			break;
		}
	}
	//cout << endl;

	return retInt;
}

string set_Mob_Size_Value(int iInput) // enum 0=None
{
	if (iInput==0)
		return "";

	string inputString("");
	int tmpFlag;
	auto iOldInput = iInput;
	for(int i =0;i<sizeof(arMSVSize)/sizeof(arMSVSize[0]);i++)
	{
		tmpFlag = i+1;
		if (iInput == tmpFlag)
		{
			if (bDebugFlag)
				iInput = 0;
			inputString = arMSVSize[i];
			break;
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput)
		return std::to_string(iOldInput);
#endif
	if (bDebugFlag && iInput)
		writeDebug("Mob Size not found", iInput);
	return inputString;
}


string arMOBAIFVAIFlag[] = {"AGGR","NOMOVE","COWARD","NOATTSHINSU","NOATTCHUNJO","NOATTJINNO","ATTMOB","BERSERK","STONESKIN","GODSPEED","DEATHBLOW","REVIVE","HEALER",
	"UNK13","UNK14"
};

int get_Mob_AIFlag_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retValue = 0;
	string* arInputString = StringSplit(inputString, ",");
	for(int i =0;i<sizeof(arMOBAIFVAIFlag)/sizeof(arMOBAIFVAIFlag[0]);i++) {
		string tempString = arMOBAIFVAIFlag[i];
		for (int j=0; j<30 ; j++)
		{
			string tempString2 = arInputString[j];
			if (tempString2.compare(tempString)==0) {
				retValue = retValue + static_cast<int>(pow(2.0, static_cast<double>(i)));
			}

			if(tempString2.compare("") == 0)
				break;
		}
	}
	delete []arInputString;
	//cout << "AIFlag : " << aiFlagStr << " -> " << retValue << endl;

	return retValue;
}

string set_Mob_AIFlag_Value(int iInput) // set
{
	if (iInput==0)
		return "";

	string inputString("");
	int tmpFlag;
	auto iOldInput = iInput;
	for(int i =0;i<sizeof(arMOBAIFVAIFlag)/sizeof(arMOBAIFVAIFlag[0]);i++)
	{
		tmpFlag = static_cast<int>(pow(2.0, static_cast<double>(i)));
		if (iInput & tmpFlag)
		{
			if (bDebugFlag)
				iInput -= tmpFlag;
			if (!!inputString.compare(""))
				inputString += ",";
			inputString += arMOBAIFVAIFlag[i];
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput)
		return std::to_string(iOldInput);
#endif
	if (bDebugFlag && iInput)
		writeDebug("Mob AIFlag not found", iInput);
	return inputString;
}


string arMRFVRaceFlag[] = {"ANIMAL","UNDEAD","DEVIL","HUMAN","ORC","MILGYO","INSECT","FIRE","ICE","DESERT","TREE",
	"ATT_ELEC","ATT_FIRE","ATT_ICE","ATT_WIND","ATT_EARTH","ATT_DARK"};

int get_Mob_RaceFlag_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retValue = 0;
	string* arInputString = StringSplit(inputString, ","); // @fixme201
	for(int i =0;i<sizeof(arMRFVRaceFlag)/sizeof(arMRFVRaceFlag[0]);i++) {
		string tempString = arMRFVRaceFlag[i];
		for (int j=0; j<30 ; j++)
		{
			string tempString2 = arInputString[j];
			if (tempString2.compare(tempString)==0) {
				retValue = retValue + static_cast<int>(pow(2.0, static_cast<double>(i)));
			}

			if(tempString2.compare("") == 0)
				break;
		}
	}
	delete []arInputString;
	//cout << "Race Flag : " << raceFlagStr << " -> " << retValue << endl;

	return retValue;
}

string set_Mob_RaceFlag_Value(int iInput) // set
{
	if (iInput==0)
		return "";

	string inputString("");
	int tmpFlag;
	auto iOldInput = iInput;
	for(int i =0;i<sizeof(arMRFVRaceFlag)/sizeof(arMRFVRaceFlag[0]);i++)
	{
		tmpFlag = static_cast<int>(pow(2.0, static_cast<double>(i)));
		if (iInput & tmpFlag)
		{
			if (bDebugFlag)
				iInput -= tmpFlag;
			if (!!inputString.compare(""))
				inputString += ",";
			inputString += arMRFVRaceFlag[i];
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput)
		return std::to_string(iOldInput);
#endif
	if (bDebugFlag && iInput)
		writeDebug("Mob RaceFlag not found", iInput);
	return inputString;
}


string arMIFVImmuneFlag[] = {"STUN","SLOW","FALL","CURSE","POISON","TERROR", "REFLECT"};

int get_Mob_ImmuneFlag_Value(string inputString)
{
#ifdef ENABLE_NUMERIC_FIELD
	if (_IsNumericString(inputString))
		return std::stoi(inputString);
#endif
	int retValue = 0;
	string* arInputString = StringSplit(inputString, ",");
	for(int i =0;i<sizeof(arMIFVImmuneFlag)/sizeof(arMIFVImmuneFlag[0]);i++) {
		string tempString = arMIFVImmuneFlag[i];
		for (int j=0; j<30 ; j++)
		{
			string tempString2 = arInputString[j];
			if (tempString2.compare(tempString)==0) {
				retValue = retValue + static_cast<int>(pow(2.0, static_cast<double>(i)));
			}

			if(tempString2.compare("") == 0)
				break;
		}
	}
	delete []arInputString;
	//cout << "Immune Flag : " << immuneFlagStr << " -> " << retValue << endl;

	return retValue;
}

string set_Mob_ImmuneFlag_Value(int iInput) // set
{
	if (iInput==0)
		return "";

	string inputString("");
	int tmpFlag;
	auto iOldInput = iInput;
	for(int i =0;i<sizeof(arMIFVImmuneFlag)/sizeof(arMIFVImmuneFlag[0]);i++)
	{
		tmpFlag = static_cast<int>(pow(2.0, static_cast<double>(i)));
		if (iInput & tmpFlag)
		{
			if (bDebugFlag)
				iInput -= tmpFlag;
			if (!!inputString.compare(""))
				inputString += ",";
			inputString += arMIFVImmuneFlag[i];
		}
	}
#ifdef ENABLE_NUMERIC_FIELD
	if (iInput)
		return std::to_string(iOldInput);
#endif
	if (bDebugFlag && iInput)
		writeDebug("Mob ImmuneFlag not found", iInput);
	return inputString;
}





