import uiScriptLocale
import item

EQUIPMENT_START_INDEX = 180
MIDDLE_VALUE_FILE = "d:/ymir work/ui/public/Parameter_Slot_01.sub"

window = {
	"name" : "InventoryWindow",

	## 600 - (width + ¿À¸¥ÂÊÀ¸·Î ºÎÅÍ ¶ç¿ì±â 24 px)
	"x" : SCREEN_WIDTH - 317,
	"y" : SCREEN_HEIGHT - 37 - 580,

	"style" : ("movable", "float",),

	"width" : 191 + 124,
	"height" : 585,

	"children" :
	(
		## Inventory, Equipment Slots
		{
			"name" : "board",
			"type" : "board",
			"style" : ("attach",),

			"x" : 0,
			"y" : 0,

			"width" : 191 + 124,
			"height" : 585,

			"children" :
			(
				## Title
				{
					"name" : "TitleBar",
					"type" : "titlebar",
					"style" : ("attach",),

					"x" : 8,
					"y" : 7,

					"width" : 300,
					"color" : "yellow",

					"children" :
					(
						{ "name":"TitleName", "type":"text", "x":150, "y":3, "text":uiScriptLocale.INVENTORY_TITLE, "text_horizontal_align":"center" },
					),
				},

				## Equipment Slot
				{
					"name" : "Equipment_Base",
					"type" : "image",

					"x" : 18,
					"y" : 33,

					"image" : "d:/ymir work/ui/equipment_bg_without_ring.tga",

					"children" :
					(

						{
							"name" : "EquipmentSlot",
							"type" : "slot",

							"x" : 3,
							"y" : 3,

							"width" : 150,
							"height" : 182,

							"slot" : (
										{"index":EQUIPMENT_START_INDEX+0, "x":39, "y":37, "width":32, "height":64},
										{"index":EQUIPMENT_START_INDEX+1, "x":39, "y":2, "width":32, "height":32},
										{"index":EQUIPMENT_START_INDEX+2, "x":39, "y":145, "width":32, "height":32},
										{"index":EQUIPMENT_START_INDEX+3, "x":75, "y":67, "width":32, "height":32},
										{"index":EQUIPMENT_START_INDEX+4, "x":3, "y":3, "width":32, "height":96},
										{"index":EQUIPMENT_START_INDEX+5, "x":114, "y":67, "width":32, "height":32},
										{"index":EQUIPMENT_START_INDEX+6, "x":114, "y":35, "width":32, "height":32},
										{"index":EQUIPMENT_START_INDEX+7, "x":2, "y":145, "width":32, "height":32},
										{"index":EQUIPMENT_START_INDEX+8, "x":75, "y":145, "width":32, "height":32},
										{"index":EQUIPMENT_START_INDEX+9, "x":114, "y":2, "width":32, "height":32},
										{"index":EQUIPMENT_START_INDEX+10, "x":75, "y":35, "width":32, "height":32},
										## »õ ¹ÝÁö1
										##{"index":item.EQUIPMENT_RING1, "x":2, "y":106, "width":32, "height":32},
										## »õ ¹ÝÁö2
										##{"index":item.EQUIPMENT_RING2, "x":75, "y":106, "width":32, "height":32},
										## »õ º§Æ®
										{"index":item.EQUIPMENT_BELT, "x":39, "y":106, "width":32, "height":32},
									),
						},
						#Bonus Page Dialog
						{
							"name" : "Bonus_Page",
							"type" : "window",
							"x" : 160,
							"y" : 0,
							"width" : 124,
							"height" : 565-24,
							"children" :
							(
								{
									"name" : "BonusBase1",
									"type" : "horizontalbar",
									"x" : 2,
									"y" : 0,
									"width" : 120,
									"children" :
									(
										{
											"name" : "bonus_text_1",
											"type" : "text",
											"x" : 0,
											"y" : 0,
											"all_align" : "center",
											"text" : "Savunma", 
										},
									),
								},
								{
									"name" : "Sword_defence",
									"type" : "text",
									"x" : 5,
									"y" : 1*18,
									"text" : "Kýlýç:"
								},
								{
									"name" : "Sword_def",
									"type" : "window",
									"x" : 72,
									"y" : 1*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Sword_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Sword_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Twohand_defence",
									"type" : "text",
									"x" : 5,
									"y" : 2*18,
									"text" : "Çift El:"
								},
								{
									"name" : "Twohand_def",
									"type" : "window",
									"x" : 72,
									"y" : 2*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Twohand_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Twohand_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Knife_defence",
									"type" : "text",
									"x" : 5,
									"y" : 3*18,
									"text" : "Býçak:"
								},
								{
									"name" : "Knife_def",
									"type" : "window",
									"x" : 72,
									"y" : 3*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Knife_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Knife_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Bow_defence",
									"type" : "text",
									"x" : 5,
									"y" : 4*18,
									"text" : "Ok Day:"
								},
								{
									"name" : "Bow_def",
									"type" : "window",
									"x" : 72,
									"y" : 4*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Bow_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Bow_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Bow_savunma",
									"type" : "text",
									"x" : 5,
									"y" : 5*18,
									"text" : "Ok Sav:"
								},
								{
									"name" : "Bow_sav",
									"type" : "window",
									"x" : 72,
									"y" : 5*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Bow_sav_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Bow_sav_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Bell_defence",
									"type" : "text",
									"x" : 5,
									"y" : 6*18,
									"text" : "Çan:"
								},
								{
									"name" : "Bell_def",
									"type" : "window",
									"x" : 72,
									"y" : 6*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Bell_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Bell_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Fan_defence",
									"type" : "text",
									"x" : 5,
									"y" : 7*18,
									"text" : "Yelpaze:"
								},
								{
									"name" : "Fan_def",
									"type" : "window",
									"x" : 72,
									"y" : 7*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Fan_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Fan_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Magic_defence",
									"type" : "text",
									"x" : 5,
									"y" : 8*18,
									"text" : "Büyü:"
								},
								{
									"name" : "Magic_def",
									"type" : "window",
									"x" : 72,
									"y" : 8*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Magic_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Magic_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Poison_defence",
									"type" : "text",
									"x" : 5,
									"y" : 9*18,
									"text" : "Zehir:"
								},
								{
									"name" : "Poison_def",
									"type" : "window",
									"x" : 72,
									"y" : 9*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Poison_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Poison_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Warrior_defence",
									"type" : "text",
									"x" : 5,
									"y" : 10*18,
									"text" : "Savaþcý:"
								},
								{
									"name" : "Warrior_def",
									"type" : "window",
									"x" : 72,
									"y" : 10*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Warrior_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Warrior_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Assassin_defence",
									"type" : "text",
									"x" : 5,
									"y" : 11*18,
									"text" : "Ninja:"
								},
								{
									"name" : "Assassin_def",
									"type" : "window",
									"x" : 72,
									"y" : 11*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Assassin_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Assassin_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Sura_defence",
									"type" : "text",
									"x" : 5,
									"y" : 12*18,
									"text" : "Sura:"
								},
								{
									"name" : "Sura_def",
									"type" : "window",
									"x" : 72,
									"y" : 12*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Sura_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Sura_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Mage_defence",
									"type" : "text",
									"x" : 5,
									"y" : 13*18,
									"text" : "Þaman:"
								},
								{
									"name" : "Mage_def",
									"type" : "window",
									"x" : 72,
									"y" : 13*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Mage_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Mage_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Yakindovus_defence",
									"type" : "text",
									"x" : 5,
									"y" : 14*18,
									"text" : "Yakýn Dövüþ:"
								},
								{
									"name" : "Yakindovus_def",
									"type" : "window",
									"x" : 72,
									"y" : 14*18,
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Yakindovus_def_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Yakindovus_def_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "BonusBase2",
									"type" : "horizontalbar",
									"x" : 4,
									"y" : 272,
									"width" : 120,
									"children" :
									(
										{
											"name" : "bonus_text_1",
											"type" : "text",
											"x" : 0,
											"y" : 0,
											"all_align" : "center",
											"text" : "Saldýrý",
										},
									),
								},
								{
									"name" : "Critical_chance",
									"type" : "text",
									"x" : 5,
									"y" : 272+(1*18),
									"text" : "Kritik:"
								},
								{
									"name" : "Crit",
									"type" : "window",
									"x" : 72,
									"y" : 272+(1*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Crit_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Crit_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Pierce_chance",
									"type" : "text",
									"x" : 5,
									"y" : 272+(2*18),
									"text" : "Delici:"
								},
								{
									"name" : "Pierce",
									"type" : "window",
									"x" : 72,
									"y" : 272+(2*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Pierce_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Pierce_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Hit_damage",
									"type" : "text",
									"x" : 5,
									"y" : 272+(3*18),
									"text" : "Ortalama:"
								},
								{
									"name" : "Hitdmg",
									"type" : "window",
									"x" : 72,
									"y" : 272+(3*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Hitdmg_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Hitdmg_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Skill_damage",
									"type" : "text",
									"x" : 5,
									"y" : 272+(4*18),
									"text" : "Beceri:"
								},
								{
									"name" : "Skilldmg",
									"type" : "window",
									"x" : 72,
									"y" : 272+(4*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Skilldmg_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Skilldmg_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Halfhumans",
									"type" : "text",
									"x" : 5,
									"y" : 272+(5*18),
									"text" : "Yarý insan:"
								},
								{
									"name" : "Halfhuman",
									"type" : "window",
									"x" : 72,
									"y" : 272+(5*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Halfhuman_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Halfhuman_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Undeads",
									"type" : "text",
									"x" : 5,
									"y" : 272+(6*18),
									"text" : "Ölümsüz:"
								},
								{
									"name" : "Undead",
									"type" : "window",
									"x" : 72,
									"y" : 272+(6*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Undead_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Undead_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Devil_gegen",
									"type" : "text",
									"x" : 5,
									"y" : 272+(7*18),
									"text" : "Þeytan:"
								},
								{
									"name" : "Devil",
									"type" : "window",
									"x" : 72,
									"y" : 272+(7*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Devil_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Devil_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Warrior_gegen",
									"type" : "text",
									"x" : 5,
									"y" : 272+(8*18),
									"text" : "Savaþçý:"
								},
								{
									"name" : "Warrior_str",
									"type" : "window",
									"x" : 72,
									"y" : 272+(8*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Warrior_str_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Warrior_str_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Assassin_gegen",
									"type" : "text",
									"x" : 5,
									"y" : 272+(9*18),
									"text" : "Ninja:"
								},
								{
									"name" : "Assassin_str",
									"type" : "window",
									"x" : 72,
									"y" : 272+(9*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Assassin_str_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Assassin_str_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Sura_gegen",
									"type" : "text",
									"x" : 5,
									"y" : 272+(10*18),
									"text" : "Sura:"
								},
								{
									"name" : "Assassin_str",
									"type" : "window",
									"x" : 72,
									"y" : 272+(10*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Sura_str_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Sura_str_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Mage_gegen",
									"type" : "text",
									"x" : 5,
									"y" : 272+(11*18),
									"text" : "Þaman:"
								},
								{
									"name" : "Mage_str",
									"type" : "window",
									"x" : 72,
									"y" : 272+(11*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Mage_str_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Mage_str_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Zeka_gegen",
									"type" : "text",
									"x" : 5,
									"y" : 272+(12*18),
									"text" : "Zeka:"
								},
								{
									"name" : "Zeka_str",
									"type" : "window",
									"x" : 72,
									"y" : 272+(12*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Zeka_str_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Zeka_str_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Guc_gegen",
									"type" : "text",
									"x" : 5,
									"y" : 272+(13*18),
									"text" : "Güç:"
								},
								{
									"name" : "Guc_str",
									"type" : "window",
									"x" : 72,
									"y" : 272+(13*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Guc_str_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Guc_str_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								{
									"name" : "Ceviklik_gegen",
									"type" : "text",
									"x" : 5,
									"y" : 272+(14*18),
									"text" : "Çeviklik:"
								},
								{
									"name" : "Ceviklik_str",
									"type" : "window",
									"x" : 72,
									"y" : 272+(14*18),
									"width" : 53,
									"height" : 19,
									"children" :
									(
										{
											"name" : "Ceviklik_str_Slot",
											"type" : "image",
											"x" : 0,
											"y" : 0,
											"image" : MIDDLE_VALUE_FILE
										},
										{
											"name" : "Ceviklik_str_Value",
											"type" : "text",
											"x" : 26,
											"y" : 3,
											"text" : "999",
											"r" : 1.0,
											"g" : 1.0,
											"b" : 1.0,
											"a" : 1.0,
											"text_horizontal_align":"center"
										},
									),
								},
								
							),
						},
						## Dragon Soul Button
						{
							"name" : "DSSButton",
							"type" : "button",

							"x" : 114,
							"y" : 107,

							"tooltip_text" : uiScriptLocale.TASKBAR_DRAGON_SOUL,

							"default_image" : "d:/ymir work/ui/dragonsoul/dss_inventory_button_01.tga",
							"over_image" : "d:/ymir work/ui/dragonsoul/dss_inventory_button_02.tga",
							"down_image" : "d:/ymir work/ui/dragonsoul/dss_inventory_button_03.tga",
						},
						## MallButton
						{
							"name" : "MallButton",
							"type" : "button",

							"x" : 118,
							"y" : 148,

							"tooltip_text" : uiScriptLocale.MALL_TITLE,

							"default_image" : "d:/ymir work/ui/game/TaskBar/Mall_Button_01.tga",
							"over_image" : "d:/ymir work/ui/game/TaskBar/Mall_Button_02.tga",
							"down_image" : "d:/ymir work/ui/game/TaskBar/Mall_Button_03.tga",
						},
						## Safebox
						{
							"name" : "SafeboxButton",
							"type" : "button",

							"x" : 5,
							"y" : 109,

							"tooltip_text" : "Eþya Deposu",

							"default_image" : "d:/ymir work/ui/game/taskbar/mall_button_01.tga",
							"over_image" : "d:/ymir work/ui/game/taskbar/mall_button_02.tga",
							"down_image" : "d:/ymir work/ui/game/taskbar/mall_button_03.tga",
						},
						## CostumeButton
						{
							"name" : "CostumeButton",
							"type" : "button",

							"x" : 78,
							"y" : 5,

							"tooltip_text" : uiScriptLocale.COSTUME_TITLE,

							"default_image" : "d:/ymir work/ui/game/taskbar/costume_Button_01.tga",
							"over_image" : "d:/ymir work/ui/game/taskbar/costume_Button_02.tga",
							"down_image" : "d:/ymir work/ui/game/taskbar/costume_Button_03.tga",
						},						
						{
							"name" : "Equipment_Tab_01",
							"type" : "radio_button",

							"x" : 86,
							"y" : 161,

							"default_image" : "d:/ymir work/ui/game/windows/tab_button_small_01.sub",
							"over_image" : "d:/ymir work/ui/game/windows/tab_button_small_02.sub",
							"down_image" : "d:/ymir work/ui/game/windows/tab_button_small_03.sub",

							"children" :
							(
								{
									"name" : "Equipment_Tab_01_Print",
									"type" : "text",

									"x" : 0,
									"y" : 0,

									"all_align" : "center",

									"text" : "I",
								},
							),
						},
						{
							"name" : "Equipment_Tab_02",
							"type" : "radio_button",

							"x" : 86 + 32,
							"y" : 161,

							"default_image" : "d:/ymir work/ui/game/windows/tab_button_small_01.sub",
							"over_image" : "d:/ymir work/ui/game/windows/tab_button_small_02.sub",
							"down_image" : "d:/ymir work/ui/game/windows/tab_button_small_03.sub",

							"children" :
							(
								{
									"name" : "Equipment_Tab_02_Print",
									"type" : "text",

									"x" : 0,
									"y" : 0,

									"all_align" : "center",

									"text" : "II",
								},
							),
						},
					),
				},
				{
					"name" : "Inventory_Tab_01",
					"type" : "radio_button",

					"x" : 17,
					"y" : 36 + 191,

					"default_image" : "d:/ymir work/ui/game/windows/tab_button_large_01.sub",
					"over_image" : "d:/ymir work/ui/game/windows/tab_button_large_02.sub",
					"down_image" : "d:/ymir work/ui/game/windows/tab_button_large_03.sub",
					"tooltip_text" : uiScriptLocale.INVENTORY_PAGE_BUTTON_TOOLTIP_1,

					"children" :
					(
						{
							"name" : "Inventory_Tab_01_Print",
							"type" : "text",

							"x" : 0,
							"y" : 0,

							"all_align" : "center",

							"text" : "I",
						},
					),
				},
				{
					"name" : "Inventory_Tab_02",
					"type" : "radio_button",

					"x" : 17 + 78,
					"y" : 36 + 191,

					"default_image" : "d:/ymir work/ui/game/windows/tab_button_large_01.sub",
					"over_image" : "d:/ymir work/ui/game/windows/tab_button_large_02.sub",
					"down_image" : "d:/ymir work/ui/game/windows/tab_button_large_03.sub",
					"tooltip_text" : uiScriptLocale.INVENTORY_PAGE_BUTTON_TOOLTIP_2,

					"children" :
					(
						{
							"name" : "Inventory_Tab_02_Print",
							"type" : "text",

							"x" : 0,
							"y" : 0,

							"all_align" : "center",

							"text" : "II",
						},
					),
				},
				{
                    "name" : "Inventory_Tab_03",
                    "type" : "radio_button",
 
                    "x" : 17,
                    "y" : 36 + 210,
 
                    "default_image" : "d:/ymir work/ui/game/windows/tab_button_large_01.sub",
                    "over_image" : "d:/ymir work/ui/game/windows/tab_button_large_02.sub",
                    "down_image" : "d:/ymir work/ui/game/windows/tab_button_large_03.sub",
                    "tooltip_text" : "3. Envanter",
 
                    "children" :
                    (
                        {
                            "name" : "Inventory_Tab_03_Print",
                            "type" : "text",
 
                            "x" : 0,
                            "y" : 0,
 
                            "all_align" : "center",
 
                            "text" : "III",
                        },
                    ),
                },
                {
                    "name" : "Inventory_Tab_04",
                    "type" : "radio_button",
 
                    "x" : 17 + 78,
                    "y" : 36 + 210,
 
                    "default_image" : "d:/ymir work/ui/game/windows/tab_button_large_01.sub",
                    "over_image" : "d:/ymir work/ui/game/windows/tab_button_large_02.sub",
                    "down_image" : "d:/ymir work/ui/game/windows/tab_button_large_03.sub",
                    "tooltip_text" : "4. Envanter",
 
                    "children" :
                    (
                        {
                            "name" : "Inventory_Tab_04_Print",
                            "type" : "text",
 
                            "x" : 0,
                            "y" : 0,
 
                            "all_align" : "center",
 
                            "text" : "IV",
                        },
                    ),
                },        
				## Item Slot
				{
					"name" : "ItemSlot",
					"type" : "grid_table",

					"x" : 15,
					"y" : 270,

					"start_index" : 0,
					"x_count" : 5,
					"y_count" : 9,
					"x_step" : 32,
					"y_step" : 32,

					"image" : "d:/ymir work/ui/public/Slot_Base.sub"
				},

				## Print
				{
					"name":"Money_Slot",
					"type":"button",

					"x":27,
					"y":27,

					"horizontal_align":"left",
					"vertical_align":"bottom",

					"default_image" : "d:/ymir work/ui/public/parameter_slot_05_for_newyang.sub",
					"over_image" : "d:/ymir work/ui/public/parameter_slot_05_for_newyang.sub",
					"down_image" : "d:/ymir work/ui/public/parameter_slot_05_for_newyang.sub",

					"children" :
					(
						{
							"name":"Money_Icon",
							"type":"image",

							"x":-18,
							"y":2,

							"image":"d:/ymir work/ui/game/windows/money_icon.sub",
						},

						{
							"name" : "Money",
							"type" : "text",

							"x" : 3,
							"y" : 3,

							"horizontal_align" : "right",
							"text_horizontal_align" : "right",

							"text" : "123456789",
						},
					),
				},

			),
		},
	),
}
