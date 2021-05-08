import uiScriptLocale

ROOT_PATH = "d:/ymir work/ui/game/cube/"
PUBLIC_PATH = "d:/ymir work/ui/public/"
PATTERN_PATH = "d:/ymir work/ui/pattern/"

LIST_WINDOW_WIDTH = 316
LIST_WINDOW_HEIGHT = 252
LIST_WINDOW_PATTERN_X_COUNT = (LIST_WINDOW_WIDTH - 32) / 16
LIST_WINDOW_PATTERN_Y_COUNT = (LIST_WINDOW_HEIGHT - 32) / 16

window = {
	"name" : "CubeRenewalWindow",
	"style" : ("movable", "float", ),
	
	"x" : 0,
	"y" : 0,
	
	"width" : 336,
	"height" : 488,
	
	"children" :
	[
		{
			"name" : "board",
			"type" : "board_with_titlebar",
			"style" : ("ltr", "attach", ),
			
			"x" : 0,
			"y" : 0,
			
			"width" : 336,
			"height" : 488,
			"title" : uiScriptLocale.CUBE_RENEWAL_TITLE,
			
			"children" :
			(
				## ItemList
				{
					"name" : "item_list_board",
					"type" : "window",
					"style": ("ltr",),

					"x" : 10,
					"y" : 32,
							
					"width"	: LIST_WINDOW_WIDTH,
					"height" : LIST_WINDOW_HEIGHT,
					
					"children" :
					(
						## LeftTop 1
						{
							"name" : "ListWindowLeftTop",
							"type" : "image",
							"style" : ("ltr",),
							
							"x" : 0,
							"y" : 0,
							"image" : PATTERN_PATH + "border_A_left_top.tga",
						},
						## RightTop 2
						{
							"name" : "ListWindowRightTop",
							"type" : "image",
							"style" : ("ltr",),
							
							"x" : LIST_WINDOW_WIDTH - 16,
							"y" : 0,
							"image" : PATTERN_PATH + "border_A_right_top.tga",
						},
						## LeftBottom 3
						{
							"name" : "ListWindowLeftBottom",
							"type" : "image",
							"style" : ("ltr",),
							
							"x" : 0,
							"y" : LIST_WINDOW_HEIGHT - 16,
							"image" : PATTERN_PATH + "border_A_left_bottom.tga",
						},
						## RightBottom 4
						{
							"name" : "ListWindowRightBottom",
							"type" : "image",
							"style" : ("ltr",),
							
							"x" : LIST_WINDOW_WIDTH - 16,
							"y" : LIST_WINDOW_HEIGHT - 16,
							"image" : PATTERN_PATH + "border_A_right_bottom.tga",
						},
						## topcenterImg 5
						{
							"name" : "ListWindowTopCenterImg",
							"type" : "expanded_image",
							"style" : ("ltr",),
							
							"x" : 16,
							"y" : 0,
							"image" : PATTERN_PATH + "border_A_top.tga",
							"rect" : (0.0, 0.0, LIST_WINDOW_PATTERN_X_COUNT, 0),
						},
						## leftcenterImg 6
						{
							"name" : "ListWindowLeftCenterImg",
							"type" : "expanded_image",
							"style" : ("ltr",),
							
							"x" : 0,
							"y" : 16,
							"image" : PATTERN_PATH + "border_A_left.tga",
							"rect" : (0.0, 0.0, 0, LIST_WINDOW_PATTERN_Y_COUNT),
						},
						## rightcenterImg 7
						{
							"name" : "ListWindowRightCenterImg",
							"type" : "expanded_image",
							"style" : ("ltr",),
							
							"x" : LIST_WINDOW_WIDTH - 16,
							"y" : 16,
							"image" : PATTERN_PATH + "border_A_right.tga",
							"rect" : (0.0, 0.0, 0, LIST_WINDOW_PATTERN_Y_COUNT),
						},
						## bottomcenterImg 8
						{
							"name" : "ListWindowBottomCenterImg",
							"type" : "expanded_image",
							"style" : ("ltr",),
							
							"x" : 16,
							"y" : LIST_WINDOW_HEIGHT - 16,
							"image" : PATTERN_PATH + "border_A_bottom.tga",
							"rect" : (0.0, 0.0, LIST_WINDOW_PATTERN_X_COUNT, 0),
						},
						## centerImg
						{
							"name" : "ListWindowCenterImg",
							"type" : "expanded_image",
							"style" : ("ltr",),
							
							"x" : 16,
							"y" : 16,
							"image" : PATTERN_PATH + "border_A_center.tga",
							"rect" : (0.0, 0.0, LIST_WINDOW_PATTERN_X_COUNT, LIST_WINDOW_PATTERN_Y_COUNT),
						},
						## 간격 처리를 위한 안에 있는 윈도우
						{
							"name" : "item_list_window",
							"type" : "window",
							"style": ("ltr",),

							"x" : 3,
							"y" : 3,
									
							"width"	: LIST_WINDOW_WIDTH - 6,
							"height" : LIST_WINDOW_HEIGHT - 10,
						},
					)
				},
				
				{
					"name" : "cube_list_scroll_bar",
					"type" : "scrollbar",

					"x" : 25,
					"y" : 38,
					"size" : 250,
					"horizontal_align" : "right",
				},
			
				## ItemSlot
				{
					# Background img
					"name" : "item_slot",
					"type" : "image",
					"style" : ("ltr", "attach"),
					"x" : 10,
					"y" : 283,
					"image" : ROOT_PATH + "cube_slot_bg.sub",
					
					"children" :
					(
						## Result Item Qty Text
						{
							"name" : "result_qty_window",
							"type" : "window",
							
							"x" : 24,
							"y" : 115,
							
							"width"	: 36,
							"height" : 16,
							
							"children" :
							(
								{ 
									"name" : "result_qty",
									"type" : "editline",
									"x" : 3, "y" : 3,
									"width"	: 36,
									"height" : 16,
									
									"input_limit" : 4,
									"only_number" : 1,
									
									"text" : "",									
								},
							)
						},
						
						{
							"name" : "qty_sub_button",
							"type" : "button",

							"x" : 7,
							"y" : 117,

							"default_image" : ROOT_PATH + "cube_qty_sub_default.sub",
							"over_image" : ROOT_PATH + "cube_qty_sub_over.sub",
							"down_image" : ROOT_PATH + "cube_qty_sub_down.sub",
						},
						
						{
							"name" : "qty_add_button",
							"type" : "button",

							"x" : 62,
							"y" : 117,

							"default_image" : ROOT_PATH + "cube_qty_add_default.sub",
							"over_image" : ROOT_PATH + "cube_qty_add_over.sub",
							"down_image" : ROOT_PATH + "cube_qty_add_down.sub",
						},
					
						# Material Item #1 Qty Text
						{
							"name" : "material_qty_window_1",
							"type" : "window",

							"x" : 80,
							"y" : 115,
							
							"width"	: 45,
							"height" : 16,

							"children" :
							(
								{ 
									"name" : "material_qty_text_1",
									"type" : "text",
									"x" : 0, "y" : 0,
									
									"horizontal_align" : "center",
									"text_horizontal_align" : "center",
									"vertical_align" : "center",
									"text_vertical_align" : "center",
									
									"text" : "",									
								},
							)
						},
						
						# Material Item #2 Qty Text
						{
							"name" : "material_qty_window_2",
							"type" : "window",

							"x" : 126,
							"y" : 115,
							
							"width"	: 45,
							"height" : 16,

							"children" :
							(
								{ 
									"name" : "material_qty_text_2",
									"type" : "text",
									"x" : 0, "y" : 0,
									
									"horizontal_align" : "center",
									"text_horizontal_align" : "center",
									"vertical_align" : "center",
									"text_vertical_align" : "center",
									
									"text" : "",									
								},
							)
						},
						
						# Material Item #3 Qty Text
						{
							"name" : "material_qty_window_3",
							"type" : "window",

							"x" : 172,
							"y" : 115,
							
							"width"	: 45,
							"height" : 16,

							"children" :
							(
								{ 
									"name" : "material_qty_text_3",
									"type" : "text",
									"x" : 0, "y" : 0,
									
									"horizontal_align" : "center",
									"text_horizontal_align" : "center",
									"vertical_align" : "center",
									"text_vertical_align" : "center",
									
									"text" : "",									
								},
							)
						},
						
						# Material Item #4 Qty Text
						{
							"name" : "material_qty_window_4",
							"type" : "window",

							"x" : 218,
							"y" : 115,
							
							"width"	: 45,
							"height" : 16,

							"children" :
							(
								{ 
									"name" : "material_qty_text_4",
									"type" : "text",
									"x" : 0, "y" : 0,
									
									"horizontal_align" : "center",
									"text_horizontal_align" : "center",
									"vertical_align" : "center",
									"text_vertical_align" : "center",
									
									"text" : "",									
								},
							)
						},
						
						# Material Item #5 Qty Text
						{
							"name" : "material_qty_window_5",
							"type" : "window",

							"x" : 264,
							"y" : 115,
							
							"width"	: 45,
							"height" : 16,

							"children" :
							(
								{ 
									"name" : "material_qty_text_5",
									"type" : "text",
									"x" : 0, "y" : 0,
									
									"horizontal_align" : "center",
									"text_horizontal_align" : "center",
									"vertical_align" : "center",
									"text_vertical_align" : "center",
									
									"text" : "",									
								},
							)
						},
					),
				},
				
				## Yang
				{
					"name" : "yang_icon",
					"type" : "image",
					"style" : ("ltr", ),
					"x" : 216,
					"y" : 430,
					
					"image" : ROOT_PATH + "cube_yang_icon.sub",
				},
				
				{
					"name" : "yang_textbg",
					"type" : "image",
					"style" : ("ltr", ),
					"x" : 233,
					"y" : 427,
					
					"image" : ROOT_PATH + "cube_yang_textbg.sub",
					
					"children" :
					(
						{
							"name" : "yang_text",
							"type" : "text",

							"x" : 7,
							"y" : 3,

							"horizontal_align" : "right",
							"text_horizontal_align" : "right",

							"text" : "",
						},
					),
				},
				
				{
					"name" : "imporve_slot",
					"type" : "image",
					"style" : ("ltr", ),
					"x" : 29,
					"y" : 421,
					
					"image" : ROOT_PATH + "cube_improve_slot.sub",
				},
				
				{
					"name" : "impove_text_window",
					"type" : "window",
					"style" : ("ltr", ),
					"x" : 27,
					"y" : 465,
					"width" : 47,
					"height" : 13,
				
					"children" :
					(
						{
							"name" : "improve_text",
							"type" : "text",

							"x" : 0,
							"y" : 0,

							"horizontal_align" : "center",
							"text_horizontal_align" : "center",
							"vertical_align" : "center",
							"text_vertical_align" : "center",

							"text" : uiScriptLocale.CUBE_RENEWAL_BELT_IMPROVE,
						},
					),
				},
				
				{
					"name" : "button_ok",
					"type" : "button",

					"x" : 141,
					"y" : 453,

					"text" : uiScriptLocale.OK,

					"default_image" : PUBLIC_PATH + "large_button_01.sub",
					"over_image" : PUBLIC_PATH + "large_button_02.sub",
					"down_image" : PUBLIC_PATH + "large_button_03.sub",
				},
				
				{
					"name" : "button_cancel",
					"type" : "button",

					"x" : 229,
					"y" : 453,

					"text" : uiScriptLocale.CANCEL,

					"default_image" : PUBLIC_PATH + "large_button_01.sub",
					"over_image" : PUBLIC_PATH + "large_button_02.sub",
					"down_image" : PUBLIC_PATH + "large_button_03.sub",
				},
			),
		}
	],
}