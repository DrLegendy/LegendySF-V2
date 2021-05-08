import uiScriptLocale
import localeInfo
ROOT_PATH = "d:/ymir work/ui/public/"
LOCALE_PATH = uiScriptLocale.SELECT_PATH

BOARD_X = SCREEN_WIDTH * (25) / 800
BOARD_Y = SCREEN_HEIGHT * (156) / 600

PLUS_BUTTON_WIDTH = 20
TEMPORARY_HEIGHT = 30
BOARD_ITEM_ADD_POSITION = -40

## Default Value ##
X_GAP = 11
Y_GAP = 12

NAME_X = 18
NAME_Y = 84
NAME_SCALE_X = 0.65
NAME_SCALE_Y = 0.65

FLAG_SCALE_X = 0.45
FLAG_SCALE_Y = 0.45

SHADOW_SCALE_X = 3.0 * SCREEN_WIDTH  / 800.0
SHADOW_SCALE_Y = 2.0 * SCREEN_HEIGHT / 600.0

STAT_GAUGE_X = X_GAP + 3
STAT_GAUGE_Y = 286
STAT_GAUGE_BAR_X = 40
STAT_GAUGE_BAR_WIDTH = 105
STAT_GAUGE_GAP = 18
STAT_GAUGE_TEXT_WIDTH = 21
STAT_GAUGE_TEXT_HEIGHT = 13

#THINBOARD_GOLD_WIDTH = 197
THINBOARD_GOLD_HEIGHT = 364

THINBOARD_CIRCLE_LEFT_WIDTH = 175

THINBOARD_CIRCLE_RIGHT_WIDTH = 180
THINBOARD_CIRCLE_RIGHT_HEIGHT = 270

DESC_FACE_X = 4
DESC_FACE_Y = -23

FACE_X = 7
FACE_Y = 4
SELECT_BTN_X = X_GAP + 4#12
SELECT_BTN_Y = 10
SELECT_BTN_GAP = 44#49

###################

window = {
	"name" : "New_SelectCharacterWindow",
	"x" : 0, "y" : 0, "width" : SCREEN_WIDTH, "height" : SCREEN_HEIGHT,
	
	"children"	:
	(
		## BackGround##
		{
			"name" : "BackGround", "type" : "expanded_image", "x" : 0, "y" : 0, "x_scale" : float(SCREEN_WIDTH) / 1024.0, "y_scale" : float(SCREEN_HEIGHT) / 768.0,
			"image" : LOCALE_PATH + "empire/background/empire_sinsu.sub",
		},
		{
			"name" : "desc_phase", "type" : "image", "x" : 0, "y" : BOARD_Y - NAME_Y - 45, "image" : ROOT_PATH + "public_intro_btn/descPhase_btn.sub",
			"children" :
			(
				#{
					#"name" : "desc_phase_text", "type" : "text",
					#"x" : 18, "y" : 7, "r" : 0.7843, "g" : 0.7843, "b" : 0.7843,
					#"text" : localeInfo.CHARACTER_SELECT_MODE,
					#"fontsize" : "LARGE",
				#},
				{
					"name" : "my_id", "type" : "text",
					"x" : 18, "y" : 7, "r" : 0.7843, "g" : 0.7843, "b" : 0.7843,
					"text" : "",
					"fontsize" : "LARGE",
				},
			),
		},
		## Name##
		{
			"name" : "name_warrior", "type" : "expanded_image", 
			"x" : BOARD_X + NAME_X, "y" : BOARD_Y - NAME_Y, "x_scale" : NAME_SCALE_X, "y_scale" : NAME_SCALE_Y,
			"image" : LOCALE_PATH + "name_warrior.sub",
		},
		{
			"name" : "name_assassin", "type" : "expanded_image",
			"x" : BOARD_X + NAME_X, "y" : BOARD_Y - NAME_Y, "x_scale" : NAME_SCALE_X, "y_scale" : NAME_SCALE_Y,
			"image" : LOCALE_PATH + "name_assassin.sub",
		},
		{
			"name" : "name_sura", "type" : "expanded_image",
			"x" : BOARD_X + NAME_X, "y" : BOARD_Y - NAME_Y, "x_scale" : NAME_SCALE_X, "y_scale" : NAME_SCALE_Y,
			"image" : LOCALE_PATH + "name_sura.sub",
		},
		{
			"name" : "name_shaman", "type" : "expanded_image",
			"x" : BOARD_X + NAME_X, "y" : BOARD_Y - NAME_Y, "x_scale" : NAME_SCALE_X, "y_scale" : NAME_SCALE_Y,
			"image" : LOCALE_PATH + "name_shaman.sub",
		},
		{
			"name" : "name_wolfman", "type" : "expanded_image",
			"x" : BOARD_X + NAME_X, "y" : BOARD_Y - NAME_Y, "x_scale" : NAME_SCALE_X, "y_scale" : NAME_SCALE_Y,
			"image" : LOCALE_PATH + "name_wolfman.sub",
		},
		
		## Shadow ##
		{
			"name" : "Shadow", "type" : "expanded_image", "x" : SCREEN_WIDTH/2 - (64)*SHADOW_SCALE_X, "y" : SCREEN_HEIGHT - SCREEN_HEIGHT*(70)/600.0 - (88)*SHADOW_SCALE_Y/2.0, 
			"x_scale" : SHADOW_SCALE_X, "y_scale" : SHADOW_SCALE_Y,
			"image" : LOCALE_PATH + "shadow/shadow.tga",#test.bmp",
		},

		##SelectCharList Board##
		{
			"name" : "character_board", "type" : "thinboard_gold",
			"x" : BOARD_X, "y" : BOARD_Y, "width" : THINBOARD_CIRCLE_LEFT_WIDTH + (X_GAP * 2) + 1, "height" : 305,#331,
			
			"children" :
			(
				## Empire Flag ##
				{
					"name" : "EmpireNameSlot", "type" : "thinboard_circle",
					"x" : X_GAP, "y" : Y_GAP, "width" : THINBOARD_CIRCLE_LEFT_WIDTH, "height" : 42,

					"children" :
					(
						{
							"name" : "EmpireFlag", "type" : "expanded_image",
							"x" : 4, "y" : 3, "x_scale" : FLAG_SCALE_X, "y_scale" : FLAG_SCALE_Y,
							"image" : LOCALE_PATH + "empire/empireflag_a.sub"
						},
						{
							"name" : "EmpireName", "type" : "text",
							"x" : 29, "y" : 0,
							"text" : uiScriptLocale.SELECT_EMPIRE_NAME,
							"fontsize" : "LARGE",
							"all_align" : "center",
						},
					),
				},
				
				## Select Character Button ##
				{
					"name" : "SelectJobSlot", "type" : "thinboard_circle",
					"x" : X_GAP, "y" : 61, "width" : THINBOARD_CIRCLE_LEFT_WIDTH, "height" : 231,#253,
					"children" :
					(
						{ "name" : "NoneButton_0", "type" : "image", "x" : SELECT_BTN_X, "y" : SELECT_BTN_Y 				  , "image" : ROOT_PATH + "public_intro_btn/emptySlot_btn.sub"},
						{ "name" : "NoneButton_1", "type" : "image", "x" : SELECT_BTN_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP  , "image" : ROOT_PATH + "public_intro_btn/emptySlot_btn.sub"},
						{ "name" : "NoneButton_2", "type" : "image", "x" : SELECT_BTN_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP*2, "image" : ROOT_PATH + "public_intro_btn/emptySlot_btn.sub"},
						{ "name" : "NoneButton_3", "type" : "image", "x" : SELECT_BTN_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP*3, "image" : ROOT_PATH + "public_intro_btn/emptySlot_btn.sub"},
						{ "name" : "NoneButton_4", "type" : "image", "x" : SELECT_BTN_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP*4, "image" : ROOT_PATH + "public_intro_btn/emptySlot_btn.sub"},
						
						{
							"name" : "CharacterSlot_0",	"type" : "radio_button", 
							"x" : SELECT_BTN_X, "y" : SELECT_BTN_Y,
							
							"default_image" : ROOT_PATH + "public_intro_btn/150x35_Selectbtn_01.sub",
							"over_image"	: ROOT_PATH + "public_intro_btn/150x35_Selectbtn_02.sub",
							"down_image"	: ROOT_PATH + "public_intro_btn/150x35_Selectbtn_03.sub",
						},
						{
							"name" : "CharacterSlot_1", "type" : "radio_button",
							"x" : SELECT_BTN_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP,

							"default_image" : ROOT_PATH + "public_intro_btn/150x35_Selectbtn_01.sub",
							"over_image"	: ROOT_PATH + "public_intro_btn/150x35_Selectbtn_02.sub",
							"down_image"	: ROOT_PATH + "public_intro_btn/150x35_Selectbtn_03.sub",
						},
						{
							"name" : "CharacterSlot_2", "type" : "radio_button",
							"x" : SELECT_BTN_X, "y" :  SELECT_BTN_Y + SELECT_BTN_GAP*2,

							"default_image" : ROOT_PATH + "public_intro_btn/150x35_Selectbtn_01.sub",
							"over_image"	: ROOT_PATH + "public_intro_btn/150x35_Selectbtn_02.sub",
							"down_image"	: ROOT_PATH + "public_intro_btn/150x35_Selectbtn_03.sub",
						},
						{
							"name" : "CharacterSlot_3", "type" : "radio_button",
							"x" : SELECT_BTN_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP*3,

							"default_image" : ROOT_PATH + "public_intro_btn/150x35_Selectbtn_01.sub",
							"over_image"	: ROOT_PATH + "public_intro_btn/150x35_Selectbtn_02.sub",
							"down_image"	: ROOT_PATH + "public_intro_btn/150x35_Selectbtn_03.sub",
						},
						{
							"name" : "CharacterSlot_4", "type" : "radio_button",
							"x" : SELECT_BTN_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP*4,

							"default_image" : ROOT_PATH + "public_intro_btn/150x35_Selectbtn_01.sub",
							"over_image"	: ROOT_PATH + "public_intro_btn/150x35_Selectbtn_02.sub",
							"down_image"	: ROOT_PATH + "public_intro_btn/150x35_Selectbtn_03.sub",
						 },
						 
						## Face Image ##
						{ "name" : "CharacterFace_0", "type" : "image", "x" : SELECT_BTN_X - FACE_X, "y" : SELECT_BTN_Y 				   - FACE_Y, "image" : "D:/ymir work/ui/intro/public_intro/face/face_warrior_m_01.sub"},
						{ "name" : "CharacterFace_1", "type" : "image", "x" : SELECT_BTN_X - FACE_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP   - FACE_Y, "image" : "D:/ymir work/ui/intro/public_intro/face/face_warrior_m_01.sub"},
						{ "name" : "CharacterFace_2", "type" : "image", "x" : SELECT_BTN_X - FACE_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP*2 - FACE_Y, "image" : "D:/ymir work/ui/intro/public_intro/face/face_warrior_m_01.sub"},
						{ "name" : "CharacterFace_3", "type" : "image", "x" : SELECT_BTN_X - FACE_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP*3 - FACE_Y, "image" : "D:/ymir work/ui/intro/public_intro/face/face_warrior_m_01.sub"},
						{ "name" : "CharacterFace_4", "type" : "image", "x" : SELECT_BTN_X - FACE_X, "y" : SELECT_BTN_Y + SELECT_BTN_GAP*4 - FACE_Y, "image" : "D:/ymir work/ui/intro/public_intro/face/face_warrior_m_01.sub"},
					),
				},
			),
		},
		## Create & Delete Button ##
		{
			"name" : "select_thinboard2", "type" : "thinboard_gold", 
			"x" : BOARD_X, "y" : BOARD_Y + 305 + 3, "width" : THINBOARD_CIRCLE_LEFT_WIDTH + (X_GAP * 2) + 1, "height" : (Y_GAP * 2) + 27,
			"children" : 
			(
				{
					"name" : "create_button", "type" : "button",
					"x" : X_GAP + 4, "y" : Y_GAP,

					"default_image" : ROOT_PATH + "public_intro_btn/plus_btn_01.sub",
					"over_image" 	: ROOT_PATH + "public_intro_btn/plus_btn_02.sub",
					"down_image" 	: ROOT_PATH + "public_intro_btn/plus_btn_03.sub",
				},
				{
					"name" : "delete_button", "type" : "button",
					"x" : THINBOARD_CIRCLE_LEFT_WIDTH + X_GAP - 58, "y" : Y_GAP,

					"default_image" : ROOT_PATH + "public_intro_btn/minus_btn_01.sub",
					"over_image" 	: ROOT_PATH + "public_intro_btn/minus_btn_02.sub",
					"down_image" 	: ROOT_PATH + "public_intro_btn/minus_btn_03.sub",
				},
			),
		},
		## Buttons - Start, Exit ##
		{
			"name" : "start_button", "type" : "button",
			"x" : SCREEN_WIDTH/2 - 107, "y" : SCREEN_HEIGHT - SCREEN_HEIGHT*(70)/600.0,

			"default_image" : ROOT_PATH + "public_intro_btn/start_btn_01.sub",
			"over_image"	: ROOT_PATH + "public_intro_btn/start_btn_02.sub",
			"down_image"	: ROOT_PATH + "public_intro_btn/start_btn_03.sub",
		},
		{
			"name" : "exit_button","type" : "button",
			"x" : SCREEN_WIDTH/2 + 32, "y" : SCREEN_HEIGHT - SCREEN_HEIGHT*(70)/600.0,

			"default_image" : ROOT_PATH + "public_intro_btn/cancel_btn_01.sub",
			"over_image"	: ROOT_PATH + "public_intro_btn/cancel_btn_02.sub",
			"down_image"	: ROOT_PATH + "public_intro_btn/cancel_btn_03.sub",
		},

		##Description Board(Right)##
		{
			"name" : "character_discriptionboard", "type" : "thinboard_gold",
			"x" : SCREEN_WIDTH - BOARD_X - (THINBOARD_CIRCLE_RIGHT_WIDTH + (X_GAP * 2)), "y" : BOARD_Y, "width" : THINBOARD_CIRCLE_RIGHT_WIDTH + (X_GAP * 2) + 1, "height" : THINBOARD_GOLD_HEIGHT,
			
			"children"	:
			(
				{ 
					"name" : "raceName_Btn", "type" : "image", "x" : 10, "y" : -17, "image" : ROOT_PATH + "public_intro_btn/raceName_btn.sub",
					"children" :
					(
						{ "name" : "DiscFace", "type" : "image", "x" : DESC_FACE_X, "y" : DESC_FACE_Y, "image" : "d:/ymir work/bin/icon/face/warrior_m.tga"},
						{ "name" : "raceName_Text",	"type" : "text", "x" : 100, "y" : 5, "r" : 0.7843, "g" : 0.7843, "b" : 0.7843, "text" : localeInfo.JOB_WARRIOR, "text_horizontal_align" : "center"}
						
					),
				},
				{
					"name" : "text_board", "type" : "thinboard_circle",
					"x" : X_GAP, "y" : Y_GAP, "width" : THINBOARD_CIRCLE_RIGHT_WIDTH, "height" : THINBOARD_CIRCLE_RIGHT_HEIGHT,
					
					"children" :
					(
						{
							"name" : "prev_button", "type" : "button",
							"x" : 122, "y" : 250,

							"default_image" : ROOT_PATH + "public_intro_btn/prev_btn_01.sub",
							"over_image" 	: ROOT_PATH + "public_intro_btn/prev_btn_02.sub",
							"down_image" 	: ROOT_PATH + "public_intro_btn/prev_btn_01.sub",
						},
						{
							"name" : "next_button", "type" : "button",
							"x" : 122 + 20 + 10, "y" : 250,

							"default_image" : ROOT_PATH + "public_intro_btn/next_btn_01.sub",
							"over_image" 	: ROOT_PATH + "public_intro_btn/next_btn_02.sub",
							"down_image" 	: ROOT_PATH + "public_intro_btn/next_btn_01.sub",
						},
					),
				},
				
				##HP##
				{
					"name" : "hth",	"type" : "text",
					"x" : STAT_GAUGE_X, "y" : STAT_GAUGE_Y,

					"text" : uiScriptLocale.CREATE_HP,

					"children" :
					(
						{
							"name" : "hth_gauge", "type" : "gauge",
							"x" : STAT_GAUGE_BAR_X, "y" : 4, "width" : STAT_GAUGE_BAR_WIDTH, "color" : "red",
						},
						{
							"name" : "hth_slot", "type" : "slotbar",
							"x" : STAT_GAUGE_BAR_WIDTH + STAT_GAUGE_BAR_X + 7, "y" : -1, "width" : STAT_GAUGE_TEXT_WIDTH, "height" : STAT_GAUGE_TEXT_HEIGHT,

							"children" :
							(
								{
									"name" : "hth_value", "type" : "text",
									"x" : 0, "y" : 1,
									"all_align" : "center",
									"text" : "0",
								},
							),
						},
					),
				},##HP END##
				##INT##
				{
					"name" : "int",	"type" : "text",
					"x" : STAT_GAUGE_X, "y" : STAT_GAUGE_Y + STAT_GAUGE_GAP,

					"text" : uiScriptLocale.CREATE_SP,

					"children" :
					(
						{
							"name" : "int_gauge", "type" : "gauge",
							"x" : STAT_GAUGE_BAR_X, "y" : 4, "width" : STAT_GAUGE_BAR_WIDTH, "color" : "pink",
						},
						{
							"name" : "int_slot", "type" : "slotbar",
							"x" : STAT_GAUGE_BAR_WIDTH + STAT_GAUGE_BAR_X + 7, "y" : -1, "width" : STAT_GAUGE_TEXT_WIDTH, "height" : STAT_GAUGE_TEXT_HEIGHT,

							"children" :
							(
								{
									"name" : "int_value", "type" : "text",
									"x" : 0, "y" : 1,
									"all_align" : "center",
									"text" : "0",
								},
							),
						},
					),
				},##INT END##
				##STR##
				{
					"name" : "str",	"type" : "text",
					"x" : STAT_GAUGE_X, "y" : STAT_GAUGE_Y + STAT_GAUGE_GAP*2,

					"text" : uiScriptLocale.CREATE_ATT_GRADE,

					"children" :
					(
						{
							"name" : "str_gauge", "type" : "gauge",
							"x" : STAT_GAUGE_BAR_X, "y" : 4, "width" : STAT_GAUGE_BAR_WIDTH, "color" : "purple",
						},
						{
							"name" : "str_slot", "type" : "slotbar",
							"x" : STAT_GAUGE_BAR_WIDTH + STAT_GAUGE_BAR_X + 7, "y" : -1, "width" : STAT_GAUGE_TEXT_WIDTH, "height" : STAT_GAUGE_TEXT_HEIGHT,

							"children" :
							(
								{
									"name" : "str_value", "type" : "text",
									"x" : 0, "y" : 1,
									"all_align" : "center",
									"text" : "0",
								},
							),
						},
					),
				},##STR END##
				##DEX##
				{
					"name" : "dex",	"type" : "text",
					"x" : STAT_GAUGE_X, "y" : STAT_GAUGE_Y + STAT_GAUGE_GAP*3,

					"text" : uiScriptLocale.CREATE_DEX_GRADE,

					"children" :
					(
						{
							"name" : "dex_gauge", "type" : "gauge",
							"x" : STAT_GAUGE_BAR_X, "y" : 4, "width" : STAT_GAUGE_BAR_WIDTH, "color" : "blue",
						},
						{
							"name" : "dex_slot", "type" : "slotbar",
							"x" : STAT_GAUGE_BAR_WIDTH + STAT_GAUGE_BAR_X + 7, "y" : -1, "width" : STAT_GAUGE_TEXT_WIDTH, "height" : STAT_GAUGE_TEXT_HEIGHT,

							"children" :
							(
								{
									"name" : "dex_value", "type" : "text",
									"x" : 0, "y" : 1,
									"all_align" : "center",
									"text" : "0",
								},
							),
						},
					),
				},##DEX END##	
			), 
		},##Description Board(Right)##
	),	
}
