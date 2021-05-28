import uiScriptLocale
import item
import app

COSTUME_START_INDEX = item.COSTUME_SLOT_START

if app.ENABLE_WEAPON_COSTUME_SYSTEM:
	window = {
		"name" : "CostumeWindow",

		"x" : SCREEN_WIDTH - 175 - 140 + 4,
		"y" : SCREEN_HEIGHT - 37 - 565 + 9,

		"style" : ("movable", "float",),

		"width" : 140,
		"height" : (180 + 47 + 36), #±âÁ¸º¸´Ù 47 ±æ¾îÁü

		"children" :
		(
			{
				"name" : "board",
				"type" : "board",
				"style" : ("attach",),

				"x" : 0,
				"y" : 0,

				"width" : 140,
				"height" : (180 + 47 + 36),
			
				"children" :
				(
					## Title
					{
						"name" : "TitleBar",
						"type" : "titlebar",
						"style" : ("attach",),

						"x" : 6,
						"y" : 6,

						"width" : 130,
						"color" : "yellow",

						"children" :
						(
							{ "name":"TitleName", "type":"text", "x":60, "y":3, "text":uiScriptLocale.COSTUME_WINDOW_TITLE, "text_horizontal_align":"center" },
						),
					},

					## Equipment Slot
					{
						"name" : "Costume_Base",
						"type" : "image",

						"x" : 13,
						"y" : 38,

						"image" : uiScriptLocale.LOCALE_UISCRIPT_PATH + "costume/new_costume_bg.jpg",

						"children" :
						(

							{
								"name" : "CostumeSlot",
								"type" : "slot",

								"x" : 3,
								"y" : 3,

								"width" : 127,
								"height" : 188,

								"slot" : (
											{"index":COSTUME_START_INDEX+0, "x":62, "y":45, "width":32, "height":64},
											{"index":COSTUME_START_INDEX+1, "x":62, "y": 9, "width":32, "height":32},
											{"index":COSTUME_START_INDEX+2, "x":5, "y":126, "width":32, "height":32},
											{"index":COSTUME_START_INDEX+3, "x":70, "y":126, "width":32, "height":32},
											{"index":COSTUME_START_INDEX+4, "x":13, "y":13, "width":32, "height":96},
											{"index":COSTUME_START_INDEX+5, "x":37, "y":126, "width":32, "height":32},#aura
											{"index":item.EQUIPMENT_RING1, 	"x":12,	"y":167, "width":32, "height":32},
											{"index":item.EQUIPMENT_RING2, 	"x":63,	"y":167, "width":32, "height":32},
										),
							},
						),
					},
				),
			},
		),
	}
elif app.ENABLE_MOUNT_COSTUME_SYSTEM:
	if app.ENABLE_ACCE_COSTUME_SYSTEM:
	    window = {
		    "name" : "CostumeWindow",

		    "x" : SCREEN_WIDTH - 175 - 140,
		    "y" : SCREEN_HEIGHT - 37 - 565,

		    "style" : ("movable", "float",),

		    "width" : 140,
		    "height" : (180 + 47),

		    "children" :
		    (
			    {
				    "name" : "board",
				    "type" : "board",
				    "style" : ("attach",),

				    "x" : 0,
				    "y" : 0,

				    "width" : 140,
				    "height" : (180 + 47),

				    "children" :
				    (
					    ## Title
					    {
						    "name" : "TitleBar",
						    "type" : "titlebar",
						    "style" : ("attach",),

						    "x" : 6,
						    "y" : 6,

						    "width" : 130,
						    "color" : "yellow",

						    "children" :
						    (
							    { "name":"TitleName", "type":"text", "x":60, "y":3, "text":uiScriptLocale.COSTUME_WINDOW_TITLE, "text_horizontal_align":"center" },
						    ),
					    },

					    ## Equipment Slot
					    {
						    "name" : "Costume_Base",
						    "type" : "image",

						    "x" : 13,
						    "y" : 38,

						    "image" : uiScriptLocale.LOCALE_UISCRIPT_PATH + "costume/new_costume_bg.jpg",

						    "children" :
						    (

							    {
								    "name" : "CostumeSlot",
								    "type" : "slot",

								    "x" : 3,
								    "y" : 3,

								    "width" : 127,
								    "height" : 145,

								    "slot" : (
											    {"index":COSTUME_START_INDEX+0, "x":62, "y":45, "width":32, "height":64},
											    {"index":COSTUME_START_INDEX+1, "x":62, "y": 9, "width":32, "height":32},
											    {"index":COSTUME_START_INDEX+2, "x":13, "y":126, "width":32, "height":32},
											    {"index":COSTUME_START_INDEX+3, "x":62, "y":126, "width":32, "height":32},
										    ),
							    },
						    ),
					    },

				    ),
			    },
		    ),
	    }
	else:
	    window = {
		    "name" : "CostumeWindow",

		    "x" : SCREEN_WIDTH - 175 - 140,
		    "y" : SCREEN_HEIGHT - 37 - 565,

		    "style" : ("movable", "float",),

		    "width" : 140,
		    "height" : (180 + 47),

		    "children" :
		    (
			    {
				    "name" : "board",
				    "type" : "board",
				    "style" : ("attach",),

				    "x" : 0,
				    "y" : 0,

				    "width" : 140,
				    "height" : (180 + 47),

				    "children" :
				    (
					    ## Title
					    {
						    "name" : "TitleBar",
						    "type" : "titlebar",
						    "style" : ("attach",),

						    "x" : 6,
						    "y" : 6,

						    "width" : 130,
						    "color" : "yellow",

						    "children" :
						    (
							    { "name":"TitleName", "type":"text", "x":60, "y":3, "text":uiScriptLocale.COSTUME_WINDOW_TITLE, "text_horizontal_align":"center" },
						    ),
					    },

					    ## Equipment Slot
					    {
						    "name" : "Costume_Base",
						    "type" : "image",

						    "x" : 13,
						    "y" : 38,

						    "image" : uiScriptLocale.LOCALE_UISCRIPT_PATH + "costume/new_costume_bg.jpg",

						    "children" :
						    (

							    {
								    "name" : "CostumeSlot",
								    "type" : "slot",

								    "x" : 3,
								    "y" : 3,

								    "width" : 127,
								    "height" : 145,

								    "slot" : (
											    {"index":COSTUME_START_INDEX+0, "x":62, "y":45, "width":32, "height":64},
											    {"index":COSTUME_START_INDEX+1, "x":62, "y": 9, "width":32, "height":32},
											    {"index":COSTUME_START_INDEX+2, "x":13, "y":125, "width":32, "height":32},
										    ),
							    },
						    ),
					    },

				    ),
			    },
		    ),
	    }
else:
	window = {
		"name" : "CostumeWindow",

		"x" : SCREEN_WIDTH - 175 - 140,
		"y" : SCREEN_HEIGHT - 37 - 565,

		"style" : ("movable", "float",),

		"width" : 140,
		"height" : 180,

		"children" :
		(
			{
				"name" : "board",
				"type" : "board",
				"style" : ("attach",),

				"x" : 0,
				"y" : 0,

				"width" : 140,
				"height" : 180,

				"children" :
				(
					## Title
					{
						"name" : "TitleBar",
						"type" : "titlebar",
						"style" : ("attach",),

						"x" : 6,
						"y" : 6,

						"width" : 130,
						"color" : "yellow",

						"children" :
						(
							{ "name":"TitleName", "type":"text", "x":60, "y":3, "text":uiScriptLocale.COSTUME_WINDOW_TITLE, "text_horizontal_align":"center" },
						),
					},

					## Equipment Slot
					{
						"name" : "Costume_Base",
						"type" : "image",

						"x" : 13,
						"y" : 38,

						"image" : uiScriptLocale.LOCALE_UISCRIPT_PATH + "costume/costume_bg.jpg",

						"children" :
						(

							{
								"name" : "CostumeSlot",
								"type" : "slot",

								"x" : 3,
								"y" : 3,

								"width" : 127,
								"height" : 145,

								"slot" : (
											{"index":COSTUME_START_INDEX+0, "x":61, "y":45, "width":32, "height":64},
											{"index":COSTUME_START_INDEX+1, "x":61, "y": 8, "width":32, "height":32},
											{"index":COSTUME_START_INDEX+2, "x":5, "y":145, "width":32, "height":32},
										),
							},
						),
					},

				),
			},
		),
	}
