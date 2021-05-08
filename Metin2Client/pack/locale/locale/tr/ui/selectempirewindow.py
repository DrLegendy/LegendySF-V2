import uiScriptLocale
import localeInfo
import app

ROOT_PATH = "d:/ymir work/ui/public/"
LOCALE_PATH = uiScriptLocale.EMPIRE_PATH

if app.NEW_SELECT_CHARACTER :
	FLAG_SCALE_X = 0.5
	FLAG_SCALE_Y = 0.5
	ATALS_X = SCREEN_WIDTH/2 - 340
	ATALS_Y = SCREEN_HEIGHT * (180) / 600
	window = {
		"name" : "SelectCharacterWindow",

		"x" : 0,
		"y" : 0,

		"width" : SCREEN_WIDTH,
		"height" : SCREEN_HEIGHT,

		"children" :
		(
			## Board
			{
				"name" : "BackGround", "type" : "expanded_image", 
				"x" : 0, "y" : 0, "x_scale" : float(SCREEN_WIDTH) / 1024.0, "y_scale" : float(SCREEN_HEIGHT) / 768.0,

				"image" : "d:/ymir work/ui/intro/empire/background/empire_select.jpg",
			},

			## Title
			{
				"name" : "Title",
				"type" : "expanded_image",

				"x" : ATALS_X + 70,
				"y" : 40,
				"x_scale" : 1.0 + ((SCREEN_WIDTH/800.0) - 1.0)*0.5,
				"y_scale" : 1.0 + ((SCREEN_HEIGHT/600.0) - 1.0)*0.5,

				"image" : LOCALE_PATH+"title.sub"
			},
			{
				"name" : "desc_phase", "type" : "image", "x" : 0, 
				"y" : SCREEN_HEIGHT * (156) / 600 - 129, "image" : ROOT_PATH + "public_intro_btn/descPhase_btn.sub",
				"children" :
				(
					{
						"name" : "desc_phase_text", "type" : "text",
						"x" : 18, "y" : 7, "r" : 0.7843, "g" : 0.7843, "b" : 0.7843,
						"text" : localeInfo.EMPIRE_SELECT_MODE,
						"fontsize" : "LARGE",
					},
				),
			},
			## Atlas
			{
				"name" : "Atlas",
				"type" : "image",

				"x" : ATALS_X,
				"y" : ATALS_Y,

				"image" : "d:/ymir work/ui/intro/empire/atlas.sub",

				"children" :
				(
					## Empire Image
					{
						"name" : "EmpireArea_A",
						"type" : "expanded_image",

						"x" : 43,
						"y" : 201,

						"image" : "d:/ymir work/ui/intro/empire/empirearea_a.sub"
					},
					{
						"name" : "EmpireArea_B",
						"type" : "expanded_image",

						"x" : 17,
						"y" : 16,

						"image" : "d:/ymir work/ui/intro/empire/empirearea_b.sub"
					},
					{
						"name" : "EmpireArea_C",
						"type" : "expanded_image",

						"x" : 314,
						"y" : 33,

						"image" : "d:/ymir work/ui/intro/empire/empirearea_c.sub"
					},

					## Empire Flag
					{
						"name" : "EmpireAreaFlag_A",
						"type" : "expanded_image",

						"x" : 167,
						"y" : 235,

						"image" : "d:/ymir work/ui/intro/empire/empireareaflag_a.sub"
					},
					{
						"name" : "EmpireAreaFlag_B",
						"type" : "expanded_image",

						"x" : 70,
						"y" : 42,

						"image" : "d:/ymir work/ui/intro/empire/empireareaflag_b.sub"
					},
					{
						"name" : "EmpireAreaFlag_C",
						"type" : "expanded_image",

						"x" : 357,
						"y" : 78,

						"image" : "d:/ymir work/ui/intro/empire/empireareaflag_c.sub"
					},
				),
			},

			## Buttons
			{
				"name" : "left_button", "type" : "button",
				"x" : ATALS_X + 120, "y" : ATALS_Y + 340,
				
				"default_image" : "d:/ymir work/ui/intro/select/left_button_01.sub",
				"over_image" : "d:/ymir work/ui/intro/select/left_button_02.sub",
				"down_image" : "d:/ymir work/ui/intro/select/left_button_03.sub",
			},
			{
				"name" : "right_button", "type" : "button",
				"x" : ATALS_X + 120 + 130, "y" : ATALS_Y + 340,
				
				"default_image" : "d:/ymir work/ui/intro/select/right_button_01.sub",
				"over_image" : "d:/ymir work/ui/intro/select/right_button_02.sub",
				"down_image" : "d:/ymir work/ui/intro/select/right_button_03.sub",
			},

			#Information
			{
				"name" : "empire_board",
				"type" : "thinboard_gold",

				"x" : SCREEN_WIDTH - 201 - SCREEN_WIDTH * (25) / 800,
				"y" : SCREEN_HEIGHT * (156) / 600,

				"width" : 205,
				"height" : 339,

				"children" :
				(
					## Empire Flag & Name##
					{	
						"name" : "EmpireNameSlot", "type" : "thinboard_circle",
						"x" : 13, "y" : 14, "width" : 180, "height" : 40,

						"children" :
						(
							{
								"name" : "EmpireFlag_A", "type" : "expanded_image",
								"x" : 0, "y" : 0, "x_scale" : FLAG_SCALE_X, "y_scale" : FLAG_SCALE_Y,
								"image" : "d:/ymir work/ui/intro/empire/empireflag_a.sub"
							},
							{
								"name" : "EmpireFlag_B", "type" : "expanded_image",
								"x" : 0, "y" : 0, "x_scale" : FLAG_SCALE_X, "y_scale" : FLAG_SCALE_Y,
								"image" : "d:/ymir work/ui/intro/empire/empireflag_b.sub"
							},
							{
								"name" : "EmpireFlag_C", "type" : "expanded_image",
								"x" : 0, "y" : 0, "x_scale" : FLAG_SCALE_X, "y_scale" : FLAG_SCALE_Y,
								"image" : "d:/ymir work/ui/intro/empire/empireflag_c.sub"
							},
							{
								"name" : "EmpireName", "type" : "text",
								"x" : 30, "y" : 0,
								"text" : "None",
								"fontsize" : "LARGE",
								"all_align" : "center",
							},
						),
					},
					{
						"name" : "text_board",
						"type" : "thinboard_circle",

						"x" : 11,
						"y" : 57,

						"width" : 180,
						"height" : 270,

						"children" :
						(
							{
								"name" : "prev_text_button", "type" : "button",
								"x" : 122, "y" : 250,

								"default_image" : ROOT_PATH + "public_intro_btn/prev_btn_01.sub",
								"over_image" 	: ROOT_PATH + "public_intro_btn/prev_btn_02.sub",
								"down_image" 	: ROOT_PATH + "public_intro_btn/prev_btn_01.sub",
							},
							{
								"name" : "next_text_button", "type" : "button",
								"x" : 122 + 20 + 10, "y" : 250,

								"default_image" : ROOT_PATH + "public_intro_btn/next_btn_01.sub",
								"over_image" 	: ROOT_PATH + "public_intro_btn/next_btn_02.sub",
								"down_image" 	: ROOT_PATH + "public_intro_btn/next_btn_01.sub",
							},
						),
					},
				),
			},
			
			## Buttons
			{
				"name" : "select_button", "type" : "button",
				"x" : SCREEN_WIDTH - 201 - SCREEN_WIDTH * (25) / 800, "y" : SCREEN_HEIGHT * (156) / 600 + 341,

				"default_image" : ROOT_PATH + "public_intro_btn/select_btn_01.sub",
				"over_image" 	: ROOT_PATH + "public_intro_btn/select_btn_02.sub",
				"down_image" 	: ROOT_PATH + "public_intro_btn/select_btn_03.sub",
			},
			{
				"name" : "exit_button", "type" : "button",
				"x" : SCREEN_WIDTH - 201 - SCREEN_WIDTH * (25) / 800 + 130, "y" : SCREEN_HEIGHT * (156) / 600 + 341,

				"default_image" : ROOT_PATH + "public_intro_btn/cancel_btn_01.sub",
				"over_image" 	: ROOT_PATH + "public_intro_btn/cancel_btn_02.sub",
				"down_image" 	: ROOT_PATH + "public_intro_btn/cancel_btn_03.sub",
			},
		),
	}
else :
	ATALS_X = SCREEN_WIDTH * (282) / 800
	ATALS_Y = SCREEN_HEIGHT * (170) / 600
	window = {
		"name" : "SelectCharacterWindow",

		"x" : 0,
		"y" : 0,

		"width" : SCREEN_WIDTH,
		"height" : SCREEN_HEIGHT,

		"children" :
		(
			## Board
			{
				"name" : "BackGround",
				"type" : "expanded_image",

				"x" : 0,
				"y" : 42,

				"image" : "d:/ymir work/ui/intro/pattern/background_pattern.tga",

				"rect" : (0.0, 0.0, float(SCREEN_WIDTH - 128) / 128.0, float(SCREEN_HEIGHT - 128 - 42*2) / 128.0),
			},

			## Alpha
			{
				"name" : "Alpha",
				"type" : "expanded_image",

				"x" : 0,
				"y" : 0,

				"image" : "d:/ymir work/ui/intro/select/background_alpha.sub",

				"x_scale" : float(SCREEN_WIDTH) / 100.0,
				"y_scale" : float(SCREEN_HEIGHT) / 69.0,
			},

			## Top & Bottom Line
			{
				"name" : "Top_Line",
				"type" : "expanded_image",

				"x" : 0,
				"y" : 0,

				"image" : "d:/ymir work/ui/intro/pattern/line_pattern.tga",

				"rect" : (0.0, 0.0, float(SCREEN_WIDTH - 50) / 50.0, 0.0),
			},
			{
				"name" : "Bottom_Line",
				"type" : "expanded_image",

				"x" : 0,
				"y" : SCREEN_HEIGHT - 42,

				"image" : "d:/ymir work/ui/intro/pattern/line_pattern.tga",

				"rect" : (0.0, 0.0, float(SCREEN_WIDTH - 50) / 50.0, 0.0),
			},

			## Title
			{
				"name" : "Title",
				"type" : "expanded_image",

				"x" : SCREEN_WIDTH * (410 - 346/2) / 800,
				"y" : SCREEN_HEIGHT * (114 - 136/2) / 600,
				"x_scale" : float(SCREEN_WIDTH) / 800.0,
				"y_scale" : float(SCREEN_HEIGHT) / 600.0,

				"image" : LOCALE_PATH+"title.sub"
			},

			## Atlas
			{
				"name" : "Atlas",
				"type" : "image",

				"x" : ATALS_X,
				"y" : ATALS_Y,

				"image" : "d:/ymir work/ui/intro/empire/atlas.sub",

				"children" :
				(
					## Empire Image
					{
						"name" : "EmpireArea_A",
						"type" : "expanded_image",

						"x" : 43,
						"y" : 201,

						"image" : "d:/ymir work/ui/intro/empire/empirearea_a.sub"
					},
					{
						"name" : "EmpireArea_B",
						"type" : "expanded_image",

						"x" : 17,
						"y" : 16,

						"image" : "d:/ymir work/ui/intro/empire/empirearea_b.sub"
					},
					{
						"name" : "EmpireArea_C",
						"type" : "expanded_image",

						"x" : 314,
						"y" : 33,

						"image" : "d:/ymir work/ui/intro/empire/empirearea_c.sub"
					},

					## Empire Flag
					{
						"name" : "EmpireAreaFlag_A",
						"type" : "expanded_image",

						"x" : 167,
						"y" : 235,

						"image" : "d:/ymir work/ui/intro/empire/empireareaflag_a.sub"
					},
					{
						"name" : "EmpireAreaFlag_B",
						"type" : "expanded_image",

						"x" : 70,
						"y" : 42,

						"image" : "d:/ymir work/ui/intro/empire/empireareaflag_b.sub"
					},
					{
						"name" : "EmpireAreaFlag_C",
						"type" : "expanded_image",

						"x" : 357,
						"y" : 78,

						"image" : "d:/ymir work/ui/intro/empire/empireareaflag_c.sub"
					},
				),
			},

			## Buttons
			{
				"name" : "left_button",
				"type" : "button",

				"x" : ATALS_X + 160,
				"y" : ATALS_Y + 340,

				"default_image" : "d:/ymir work/ui/intro/select/left_button_01.sub",
				"over_image" : "d:/ymir work/ui/intro/select/left_button_02.sub",
				"down_image" : "d:/ymir work/ui/intro/select/left_button_03.sub",
			},
			{
				"name" : "right_button",
				"type" : "button",

				"x" : ATALS_X + 160 + 130,
				"y" : ATALS_Y + 340,

				"default_image" : "d:/ymir work/ui/intro/select/right_button_01.sub",
				"over_image" : "d:/ymir work/ui/intro/select/right_button_02.sub",
				"down_image" : "d:/ymir work/ui/intro/select/right_button_03.sub",
			},

			## Character Board
			{
				"name" : "empire_board",
				"type" : "thinboard",

				"x" : SCREEN_WIDTH * (40) / 800,
				"y" : SCREEN_HEIGHT * (211) / 600,

				"width" : 208,
				"height" : 314,

				"children" :
				(
					## Bar
					{
						"name" : "flag_board",
						"type" : "bar",

						"x" : 24,
						"y" : 17,
						"width" : 159,
						"height" : 119,

						"children" :
						(
							## Empire Flag
							{
								"name" : "EmpireFlag_A",
								"type" : "expanded_image",

								"x" : 0,
								"y" : 0,
								"horizontal_align" : "center",
								"vertical_align" : "center",

								"image" : "d:/ymir work/ui/intro/empire/empireflag_a.sub"
							},
							{
								"name" : "EmpireFlag_B",
								"type" : "expanded_image",

								"x" : 0,
								"y" : 0,
								"horizontal_align" : "center",
								"vertical_align" : "center",

								"image" : "d:/ymir work/ui/intro/empire/empireflag_b.sub"
							},
							{
								"name" : "EmpireFlag_C",
								"type" : "expanded_image",

								"x" : 0,
								"y" : 0,
								"horizontal_align" : "center",
								"vertical_align" : "center",

								"image" : "d:/ymir work/ui/intro/empire/empireflag_c.sub"
							},
						),

					},
					{
						"name" : "text_board",
						"type" : "bar",

						"x" : 10,
						"y" : 146,

						"width" : 189,
						"height" : 122,

						"children" :
						(
							{
								"name" : "prev_text_button",
								"type" : "button",

								"x" : 95,
								"y" : 95,

								"text" : uiScriptLocale.EMPIRE_PREV,

								"default_image" : ROOT_PATH + "Small_Button_01.sub",
								"over_image" : ROOT_PATH + "Small_Button_02.sub",
								"down_image" : ROOT_PATH + "Small_Button_03.sub",
							},
							{
								"name" : "next_text_button",
								"type" : "button",

								"x" : 140,
								"y" : 95,

								"text" : uiScriptLocale.EMPIRE_NEXT,

								"default_image" : ROOT_PATH + "Small_Button_01.sub",
								"over_image" : ROOT_PATH + "Small_Button_02.sub",
								"down_image" : ROOT_PATH + "Small_Button_03.sub",
							},
							{
								"name" : "right_line",
								"type" : "line",

								"x" : 189-1,
								"y" : -1,

								"width" : 0,
								"height" : 122,

								"color" : 0xffAAA6A1,
							},
							{
								"name" : "bottom_line",
								"type" : "line",

								"x" : 0,
								"y" : 122-1,

								"width" : 189,
								"height" : 0,

								"color" : 0xffAAA6A1,
							},
							{
								"name" : "left_line",
								"type" : "line",

								"x" : 0,
								"y" : 0,

								"width" : 0,
								"height" : 122-1,

								"color" : 0xff2A2521,
							},
							{
								"name" : "top_line",
								"type" : "line",

								"x" : 0,
								"y" : 0,

								"width" : 189,
								"height" : 0,

								"color" : 0xff2A2521,
							},
						),
					},

					## Buttons
					{
						"name" : "select_button",
						"type" : "button",

						"x" : 14,
						"y" : 277,

						"text" : uiScriptLocale.EMPIRE_SELECT,

						"default_image" : ROOT_PATH + "Large_Button_01.sub",
						"over_image" : ROOT_PATH + "Large_Button_02.sub",
						"down_image" : ROOT_PATH + "Large_Button_03.sub",
					},
					{
						"name" : "exit_button",
						"type" : "button",

						"x" : 105,
						"y" : 277,

						"text" : uiScriptLocale.EMPIRE_EXIT,

						"default_image" : ROOT_PATH + "Large_Button_01.sub",
						"over_image" : ROOT_PATH + "Large_Button_02.sub",
						"down_image" : ROOT_PATH + "Large_Button_03.sub",
					},

				),
			},
		),
	}
