quest ride begin
	state start begin
		function GetRideInfo(vnum)
			if ride.ride_info==nil then
				ride.ride_info = {
					-- all seals type ITEM_UNIQUE (16), subtype UNIQUE_SPECIAL_RIDE (2) or UNIQUE_SPECIAL_MOUNT_RIDE (3), and inside the group 10030 in special_item_group.txt
					-- all seals type ITEM_COSTUME (28), and subtype COSTUME_MOUNT (2) with LimitType0 == LIMIT_REAL_TIME (7)
					[52001]= { ["mount_vnum"] = 20201,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52002]= { ["mount_vnum"] = 20201,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 0,	["req_level"] = 0,	},
					[52003]= { ["mount_vnum"] = 20201,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 0,	["req_level"] = 0,	},
					[52004]= { ["mount_vnum"] = 20201,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52005]= { ["mount_vnum"] = 20201,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52006]= { ["mount_vnum"] = 20205,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 3,	["req_level"] = 35,	},
					[52007]= { ["mount_vnum"] = 20205,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 3,	["req_level"] = 35,	},
					[52008]= { ["mount_vnum"] = 20205,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 250,	["req_level"] = 35,	},
					[52009]= { ["mount_vnum"] = 20205,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 50,	["req_level"] = 35,	},
					[52010]= { ["mount_vnum"] = 20205,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 30,	["req_level"] = 35,	},
					[52011]= { ["mount_vnum"] = 20209,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 5,	["req_level"] = 50,	},
					[52012]= { ["mount_vnum"] = 20209,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 5,	["req_level"] = 50,	},
					[52013]= { ["mount_vnum"] = 20209,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 500,	["req_level"] = 50,	},
					[52014]= { ["mount_vnum"] = 20209,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 150,	["req_level"] = 50,	},
					[52015]= { ["mount_vnum"] = 20209,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 100,	["req_level"] = 50,	},

					[52016]= { ["mount_vnum"] = 20202,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52017]= { ["mount_vnum"] = 20202,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 0,	["req_level"] = 0,	},
					[52018]= { ["mount_vnum"] = 20202,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 0,	["req_level"] = 0,	},
					[52019]= { ["mount_vnum"] = 20202,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52020]= { ["mount_vnum"] = 20202,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52021]= { ["mount_vnum"] = 20206,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 3,	["req_level"] = 35,	},
					[52022]= { ["mount_vnum"] = 20206,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 3,	["req_level"] = 35,	},
					[52023]= { ["mount_vnum"] = 20206,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 250,	["req_level"] = 35,	},
					[52024]= { ["mount_vnum"] = 20206,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 50,	["req_level"] = 35,	},
					[52025]= { ["mount_vnum"] = 20206,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 30,	["req_level"] = 35,	},
					[52026]= { ["mount_vnum"] = 20210,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52027]= { ["mount_vnum"] = 20210,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52028]= { ["mount_vnum"] = 20210,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 500,	["req_level"] = 50,	},
					[52029]= { ["mount_vnum"] = 20210,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 150,	["req_level"] = 50,	},
					[52030]= { ["mount_vnum"] = 20210,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 100,	["req_level"] = 50,	},

					[52031]= { ["mount_vnum"] = 20204,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52032]= { ["mount_vnum"] = 20204,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 0,	["req_level"] = 0,	},
					[52033]= { ["mount_vnum"] = 20204,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 0,	["req_level"] = 0,	},
					[52034]= { ["mount_vnum"] = 20204,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52035]= { ["mount_vnum"] = 20204,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52036]= { ["mount_vnum"] = 20208,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 3,	["req_level"] = 35,	},
					[52037]= { ["mount_vnum"] = 20208,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 3,	["req_level"] = 35,	},
					[52038]= { ["mount_vnum"] = 20208,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 250,	["req_level"] = 35,	},
					[52039]= { ["mount_vnum"] = 20208,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 50,	["req_level"] = 35,	},
					[52040]= { ["mount_vnum"] = 20208,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 30,	["req_level"] = 35,	},
					[52041]= { ["mount_vnum"] = 20212,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52042]= { ["mount_vnum"] = 20212,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52043]= { ["mount_vnum"] = 20212,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 500,	["req_level"] = 50,	},
					[52044]= { ["mount_vnum"] = 20212,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 150,	["req_level"] = 50,	},
					[52045]= { ["mount_vnum"] = 20212,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 100,	["req_level"] = 50,	},

					[52046]= { ["mount_vnum"] = 20203,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52047]= { ["mount_vnum"] = 20203,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 0,	["req_level"] = 0,	},
					[52048]= { ["mount_vnum"] = 20203,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 0,	["req_level"] = 0,	},
					[52049]= { ["mount_vnum"] = 20203,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52050]= { ["mount_vnum"] = 20203,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52051]= { ["mount_vnum"] = 20207,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 3,	["req_level"] = 35,	},
					[52052]= { ["mount_vnum"] = 20207,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 3,	["req_level"] = 35,	},
					[52053]= { ["mount_vnum"] = 20207,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 250,	["req_level"] = 35,	},
					[52054]= { ["mount_vnum"] = 20207,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 50,	["req_level"] = 35,	},
					[52055]= { ["mount_vnum"] = 20207,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 30,	["req_level"] = 35,	},
					[52056]= { ["mount_vnum"] = 20211,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 5,	["req_level"] = 50,	},
					[52057]= { ["mount_vnum"] = 20211,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 5,	["req_level"] = 50,	},
					[52058]= { ["mount_vnum"] = 20211,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 500,	["req_level"] = 50,	},
					[52059]= { ["mount_vnum"] = 20211,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 150,	["req_level"] = 50,	},
					[52060]= { ["mount_vnum"] = 20211,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 100,	["req_level"] = 50,	},

					[52061]= { ["mount_vnum"] = 20213,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52062]= { ["mount_vnum"] = 20213,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 0,	["req_level"] = 0,	},
					[52063]= { ["mount_vnum"] = 20213,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 0,	["req_level"] = 0,	},
					[52064]= { ["mount_vnum"] = 20213,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52065]= { ["mount_vnum"] = 20213,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52066]= { ["mount_vnum"] = 20214,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 3,	["req_level"] = 35,	},
					[52067]= { ["mount_vnum"] = 20214,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 3,	["req_level"] = 35,	},
					[52068]= { ["mount_vnum"] = 20214,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 250,	["req_level"] = 35,	},
					[52069]= { ["mount_vnum"] = 20214,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 50,	["req_level"] = 35,	},
					[52070]= { ["mount_vnum"] = 20214,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 30,	["req_level"] = 35,	},
					[52071]= { ["mount_vnum"] = 20215,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52072]= { ["mount_vnum"] = 20215,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52073]= { ["mount_vnum"] = 20215,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 500,	["req_level"] = 50,	},
					[52074]= { ["mount_vnum"] = 20215,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 150,	["req_level"] = 50,	},
					[52075]= { ["mount_vnum"] = 20215,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 100,	["req_level"] = 50,	},

					[52076]= { ["mount_vnum"] = 20216,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52077]= { ["mount_vnum"] = 20216,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 0,	["req_level"] = 0,	},
					[52078]= { ["mount_vnum"] = 20216,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 0,	["req_level"] = 0,	},
					[52079]= { ["mount_vnum"] = 20216,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52080]= { ["mount_vnum"] = 20216,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52081]= { ["mount_vnum"] = 20217,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 3,	["req_level"] = 35,	},
					[52082]= { ["mount_vnum"] = 20217,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 3,	["req_level"] = 35,	},
					[52083]= { ["mount_vnum"] = 20217,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 250,	["req_level"] = 35,	},
					[52084]= { ["mount_vnum"] = 20217,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 50,	["req_level"] = 35,	},
					[52085]= { ["mount_vnum"] = 20217,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 30,	["req_level"] = 35,	},
					[52086]= { ["mount_vnum"] = 20218,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52087]= { ["mount_vnum"] = 20218,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52088]= { ["mount_vnum"] = 20218,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 500,	["req_level"] = 50,	},
					[52089]= { ["mount_vnum"] = 20218,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 150,	["req_level"] = 50,	},
					[52090]= { ["mount_vnum"] = 20218,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 100,	["req_level"] = 50,	},

					[52091]= { ["mount_vnum"] = 20223,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52092]= { ["mount_vnum"] = 20223,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 0,	["req_level"] = 0,	},
					[52093]= { ["mount_vnum"] = 20223,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 0,	["req_level"] = 0,	},
					[52094]= { ["mount_vnum"] = 20223,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52095]= { ["mount_vnum"] = 20223,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52096]= { ["mount_vnum"] = 20224,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 3,	["req_level"] = 35,	},
					[52097]= { ["mount_vnum"] = 20224,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 3,	["req_level"] = 35,	},
					[52098]= { ["mount_vnum"] = 20224,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 250,	["req_level"] = 35,	},
					[52099]= { ["mount_vnum"] = 20224,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 50,	["req_level"] = 35,	},
					[52100]= { ["mount_vnum"] = 20224,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 30,	["req_level"] = 35,	},
					[52101]= { ["mount_vnum"] = 20225,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52102]= { ["mount_vnum"] = 20225,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52103]= { ["mount_vnum"] = 20225,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 500,	["req_level"] = 50,	},
					[52104]= { ["mount_vnum"] = 20225,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 150,	["req_level"] = 50,	},
					[52105]= { ["mount_vnum"] = 20225,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 100,	["req_level"] = 50,	},

					[52106]= { ["mount_vnum"] = 20228,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 3,	["req_level"] = 0,	},
					[52107]= { ["mount_vnum"] = 20228,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 0,	["req_level"] = 0,	},
					[52108]= { ["mount_vnum"] = 20228,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 0,	["req_level"] = 0,	},
					[52109]= { ["mount_vnum"] = 20228,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 50,	["req_level"] = 0,	},
					[52110]= { ["mount_vnum"] = 20228,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 0,	["req_level"] = 0,	},
					[52111]= { ["mount_vnum"] = 20229,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 250,	["req_level"] = 35,	},
					[52112]= { ["mount_vnum"] = 20229,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 3,	["req_level"] = 35,	},
					[52113]= { ["mount_vnum"] = 20229,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 5,	["req_level"] = 35,	},
					[52114]= { ["mount_vnum"] = 20229,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 50,	["req_level"] = 35,	},
					[52115]= { ["mount_vnum"] = 20229,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 30,	["req_level"] = 35,	},
					[52116]= { ["mount_vnum"] = 20230,	["duration"] = -1,					["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 5 ,	["req_level"] = 50,	},
					[52117]= { ["mount_vnum"] = 20230,	["duration"] = -1,					["bonus_id"] = apply.MALL_EXPBONUS,		["bonus_value"] = 5,	["req_level"] = 50,	},
					[52118]= { ["mount_vnum"] = 20230,	["duration"] = -1,					["bonus_id"] = apply.MAX_HP,			["bonus_value"] = 500,	["req_level"] = 50,	},
					[52119]= { ["mount_vnum"] = 20230,	["duration"] = -1,					["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 150,	["req_level"] = 50,	},
					[52120]= { ["mount_vnum"] = 20230,	["duration"] = -1,					["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 100,	["req_level"] = 50,	},

					-- all seals type ITEM_QUEST (18)
					[71114]= { ["mount_vnum"] = 20110,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 100,	["req_level"] = 75,	},
					[71116]= { ["mount_vnum"] = 20111,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 150,	["req_level"] = 80,	},
					[71118]= { ["mount_vnum"] = 20112,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 200,	["req_level"] = 85,	},
					[71120]= { ["mount_vnum"] = 20113,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 300,	["req_level"] = 85,	},

					-- all seals type ITEM_COSTUME (28), and subtype COSTUME_MOUNT (2) without limit type
					[71115]= { ["mount_vnum"] = 20110,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 100,	["req_level"] = 75,	},
					[71117]= { ["mount_vnum"] = 20111,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 150,	["req_level"] = 80,	},
					[71119]= { ["mount_vnum"] = 20112,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.DEF_GRADE_BONUS,	["bonus_value"] = 200,	["req_level"] = 85,	},
					[71121]= { ["mount_vnum"] = 20113,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATT_GRADE_BONUS,	["bonus_value"] = 300,	["req_level"] = 85,	},

					[71124]= { ["mount_vnum"] = 20114,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 0,	["req_level"] = 1,	},
					[71125]= { ["mount_vnum"] = 20115,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 20,	},
					[71126]= { ["mount_vnum"] = 20116,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 20,	},
					[71127]= { ["mount_vnum"] = 20117,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 20,	},
					[71128]= { ["mount_vnum"] = 20118,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 20,	},

					[71131]= { ["mount_vnum"] = 20119,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},
					[71132]= { ["mount_vnum"] = 20119,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},
					[71133]= { ["mount_vnum"] = 20119,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},
					[71134]= { ["mount_vnum"] = 20119,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},

					[71137]= { ["mount_vnum"] = 20120,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},
					[71138]= { ["mount_vnum"] = 20121,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},
					[71139]= { ["mount_vnum"] = 20122,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},
					[71140]= { ["mount_vnum"] = 20123,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},
					[71141]= { ["mount_vnum"] = 20124,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},
					[71142]= { ["mount_vnum"] = 20125,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},

					[71161]= { ["mount_vnum"] = 20219,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},
					[71164]= { ["mount_vnum"] = 20220,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},
					[71165]= { ["mount_vnum"] = 20221,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},
					[71166]= { ["mount_vnum"] = 20222,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.MOV_SPEED,			["bonus_value"] = 60,	["req_level"] = 1,	},

					[71171]= { ["mount_vnum"] = 20227,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},
					[71172]= { ["mount_vnum"] = 20226,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},

					[71176]= { ["mount_vnum"] = 20231,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},
					[71177]= { ["mount_vnum"] = 20232,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},

					-- after 2016/08/22
					[71182]= { ["mount_vnum"] = 20233,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},
					[71183]= { ["mount_vnum"] = 20234,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},
					[71184]= { ["mount_vnum"] = 20235,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},
					[71185]= { ["mount_vnum"] = 20236,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},
					[71186]= { ["mount_vnum"] = 20237,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},
					[71187]= { ["mount_vnum"] = 20238,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},

					[71192]= { ["mount_vnum"] = 20240,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},
					[71193]= { ["mount_vnum"] = 20239,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},

					[71197]= { ["mount_vnum"] = 20241,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},
					[71198]= { ["mount_vnum"] = 20242,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},

					-- pepsi mount
					[71220]= { ["mount_vnum"] = 20243,	["duration"] = 60*60*24*365,		["bonus_id"] = apply.ATTBONUS_MONSTER,	["bonus_value"] = 20,	["req_level"] = 1,	},

				}
			end
			return ride.ride_info[vnum]
		end

		function Ride(vnum, remain_time)
			local mount_info = ride.GetRideInfo(vnum)
			if mount_info==nil then return end

			if pc.level < mount_info["req_level"] then
				syschat("Level not enough")
			else
				if 112 == pc.get_map_index() then -- duel map
					return
				end

				if remain_time==0 then
					if mount_info["duration"] <= 0 then
						if item.is_available0() then
							remain_time = item.get_socket(0)
						else
							remain_time = 60
						end
					else
						remain_time = mount_info["duration"]
					end
				end

				-- syschat("duration "..remain_time)
				-- syschat("socket1 "..item.get_socket(1))
				-- syschat("socket2 "..item.get_socket(2))
				pc.mount(mount_info["mount_vnum"], remain_time)
				pc.mount_bonus(mount_info["bonus_id"], mount_info["bonus_value"], remain_time)
			end
		end

		when login begin
			local vnum, remain_time = pc.get_special_ride_vnum()
			-- syschat("remain_time "..remain_time)
			if vnum==0 then return end

			local mount_info = ride.GetRideInfo(vnum)
			if mount_info==nil then return end

			ride.Ride(vnum, remain_time)
		end

		when
			52001.use or 52002.use or 52003.use or 52004.use or 52005.use  or 52006.use or 52007.use or 52008.use or 52009.use or 52010.use  or 52011.use or 52012.use or 52013.use or 52014.use or 52015.use or
			52016.use or 52017.use or 52018.use or 52019.use or 52020.use  or 52021.use or 52022.use or 52023.use or 52024.use or 52025.use  or 52026.use or 52027.use or 52028.use or 52029.use or 52030.use or
			52031.use or 52032.use or 52033.use or 52034.use or 52035.use  or 52036.use or 52037.use or 52038.use or 52039.use or 52040.use  or 52041.use or 52042.use or 52043.use or 52044.use or 52045.use or
			52046.use or 52047.use or 52048.use or 52049.use or 52050.use  or 52051.use or 52052.use or 52053.use or 52054.use or 52055.use  or 52056.use or 52057.use or 52058.use or 52059.use or 52060.use or
			52061.use or 52062.use or 52063.use or 52064.use or 52065.use or 52066.use or 52067.use or 52068.use or 52069.use or 52070.use or 52071.use or 52072.use or 52073.use or 52074.use or 52075.use or
			52076.use or 52077.use or 52078.use or 52079.use or 52080.use or 52081.use or 52082.use or 52083.use or 52084.use or 52085.use or 52086.use or 52087.use or 52088.use or 52089.use or 52090.use or
			52091.use or 52092.use or 52093.use or 52094.use or 52095.use or 52096.use or 52097.use or 52098.use or 52099.use or 52100.use or 52101.use or 52102.use or 52103.use or 52104.use or 52105.use or
			52106.use or 52107.use or 52108.use or 52109.use or 52110.use or 52111.use or 52112.use or 52113.use or 52114.use or 52115.use or 52116.use or 52117.use or 52118.use or 52119.use or 52120.use or

			71114.use or 71116.use or 71118.use or 71120.use or

			71115.use or 71117.use or 71119.use or 71121.use or
			71124.use or 71125.use or 71126.use or 71127.use or 71128.use or
			71131.use or 71132.use or 71133.use or 71134.use or
			71137.use or 71138.use or 71139.use or 71140.use or 71141.use or 71142.use or
			71161.use or 71164.use or 71165.use or 71166.use or
			71171.use or 71172.use or
			71176.use or 71177.use or
			71182.use or 71183.use or 71184.use or 71185.use or 71186.use or 71187.use or
			71192.use or 71193.use or 71197.use or 71198.use or

			71220.use
		begin
			if pc.is_polymorphed() then
				syschat("You are transformed")
			elseif not pc.is_riding() then
				if horse.is_summon() then
					horse.unsummon()
				end
				ride.Ride(item.vnum, 0)
			else
				syschat("You are already riding")
			end
		end
	end
end
