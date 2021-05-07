#ifndef __Item_CSV_READER_H__
#define __Item_CSV_READER_H__

#include "dump_proto.h"
#include <iostream>
#include <string>
using std::string;

void putItemIntoTable();

int get_Item_Type_Value(std::string inputString);
int get_Item_SubType_Value(int type_value, std::string inputString);
int get_Item_AntiFlag_Value(std::string inputString);
int get_Item_Flag_Value(std::string inputString);
int get_Item_WearFlag_Value(std::string inputString);
int get_Item_Immune_Value(std::string inputString);
int get_Item_LimitType_Value(std::string inputString);
int get_Item_ApplyType_Value(std::string inputString);


int get_Mob_Rank_Value(std::string inputString);
int get_Mob_Type_Value(std::string inputString);
int get_Mob_BattleType_Value(std::string inputString);

int get_Mob_Size_Value(std::string inputString);
int get_Mob_AIFlag_Value(std::string inputString);
int get_Mob_RaceFlag_Value(std::string inputString);
int get_Mob_ImmuneFlag_Value(std::string inputString);


// ## DUMP
// # ITEM_PROTO
string set_Item_Type_Value(int iInput);
string set_Item_SubType_Value(int type_value, int iInput);
string set_Item_AntiFlag_Value(int iInput);
string set_Item_Flag_Value(int iInput);
string set_Item_WearFlag_Value(int iInput);
string set_Item_Immune_Value(int iInput);
string set_Item_LimitType_Value(int iInput);
string set_Item_ApplyType_Value(int iInput);
// # MOB_PROTO
string set_Mob_Rank_Value(int iInput);
string set_Mob_Type_Value(int iInput);
string set_Mob_BattleType_Value(int iInput);

string set_Mob_Size_Value(int iInput);
string set_Mob_AIFlag_Value(int iInput);
string set_Mob_RaceFlag_Value(int iInput);
string set_Mob_ImmuneFlag_Value(int iInput);

// ## DEBUG
extern bool bDebugFlag;
void writeDebug(const char* szMsg, int iInput, int type_value=0);

#endif










