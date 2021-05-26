#ifndef __INC_METIN2_COMMON_DEFINES_H__
#define __INC_METIN2_COMMON_DEFINES_H__

//////////////////////////////////////////////////////////////////////////
// ### General Features ###
#define ENABLE_D_NJGUILD
#define ENABLE_FULL_NOTICE
#define ENABLE_NEWSTUFF
#define ENABLE_PORT_SECURITY
#define ENABLE_BELT_INVENTORY_EX
#define ENABLE_CMD_WARP_IN_DUNGEON
// #define ENABLE_ITEM_ATTR_COSTUME
// #define ENABLE_SEQUENCE_SYSTEM

enum eCommonDefines {
	MAP_ALLOW_LIMIT = 32, // 32 default
};
// ### General Features ###
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### CommonDefines Systems ###
#define ENABLE_WOLFMAN_CHARACTER
#ifdef ENABLE_WOLFMAN_CHARACTER
#define USE_MOB_BLEEDING_AS_POISON
#define USE_MOB_CLAW_AS_DAGGER
// #define USE_ITEM_BLEEDING_AS_POISON
// #define USE_ITEM_CLAW_AS_DAGGER
#define USE_WOLFMAN_STONES
#define USE_WOLFMAN_BOOKS
#endif

#define ENABLE_PLAYER_PER_ACCOUNT5
#define ENABLE_DICE_SYSTEM
#define ENABLE_EXTEND_INVEN_SYSTEM

#define ENABLE_MOUNT_COSTUME_SYSTEM
#define ENABLE_WEAPON_COSTUME_SYSTEM

// #define ENABLE_MAGIC_REDUCTION_SYSTEM
#ifdef ENABLE_MAGIC_REDUCTION_SYSTEM
// #define USE_MAGIC_REDUCTION_STONES
#endif


/*
	###		New Defines Extended Version		###
*/
// todo : coding GLOBAL GIFT SYSTEM
// if ENABLE_GLOBAL_GIFT is defined, the GMs can use the quest global_gift_management.quest to set a global gift
//#define ENABLE_GLOBAL_GIFT


#define DISABLE_STOP_RIDING_WHEN_DIE //	if DISABLE_TOP_RIDING_WHEN_DIE is defined , the player does not lose the horse after his death
#define ENABLE_ACCE_SYSTEM //fixed version
#define ENABLE_HIGHLIGHT_NEW_ITEM //if you want to see highlighted a new item when dropped or when exchanged
#define __ENABLE_KILL_EVENT_FIX__ //if you want to fix the 0 exp problem about the when kill lua event (recommended)






/*
	***  Defines To DEBUG  ***
*/
// #define ENABLE_SYSLOG_PACKET_SENT



/////////////////////////////Bizim Eklediklerimiz
#define ENABLE_EXTRA_APPLY_BONUS																	// Yeni Bonuslar Modulu
#define ENABLE_ELEMENTAL_APPLY_BONUS																// Yeni Elemental Bonuslar Modulu
#define ENABLE_CUBE_RENEWAL_WORLDARD																// Official Cube Sistemi
#define ENABLE_CUBE_ATTR_SOCKET																		// Official Cube Sistemi Fixi
#define ENABLE_OFFICAL_CHARACTER_SCREEN																// Karakter Ekranı
#define ENABLE_DS_GRADE_MYTH																		// Mitsi Simya Sistemi
#define ENABLE_DS_SET																				// Simya Set Bonusu
#define ENABLE_QUEST_CATEGORY_SYSTEM																// Gorev Kategori Modulu
#define ENABLE_CHANNEL_SWITCH_SYSTEM																// Kanal Degistirme Modulu
#define ENABLE_EXTENDED_ITEMNAME_ON_GROUND															// Yere Dusen itemlerin isimleri goruntuleme Modulu
#define ENABLE_DROP_DIALOG_EXTENDED_SYSTEM															// Yere Sat-Sil Sistemi
#define ENABLE_GUILD_LEADER_GRADE_NAME																// Lonca Lider-General Sistemi
#define ENABLE_TARGET_INFORMATION_SYSTEM															// Mop Drop İnfo Sistemi


// ### CommonDefines Systems ###
//////////////////////////////////////////////////////////////////////////

#endif

