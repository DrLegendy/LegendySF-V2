quest pet_system begin
    state start begin
        function get_pet_info(itemVnum)
            pet_info_map = {
            --  [ITEM VNUM] MOB_VNUM, DEFAULT NAME, buff_idx, spawn_effect_idx
                [53001]     = { 34077, " - Ateþ Kuþu Ankasý ", 1},
                [53002]     = { 34002, " - Yavru Ren Geyiði ", 1},
                [53003]     = { 34003, " - Buz Ankasý ", 1},
                [53005]     = { 34004, " - Yavru Azrail ", 1},
				[53006]		= { 34009, " - Altýn Yavru Azrail ", 1},
                [53007]     = { 34010, " - Bambi ", 1},
				[53008]		= { 34011, " - Knuud ", 1},
				[53009]		= { 34012, " - Bao Bao ", 1},
                [53010]     = { 34008, " - Leonidas ", 1},
                [53011]     = { 34007, " - Khan ", 1},
                [53012]     = { 34005, " - Porki ", 1},
                [53013]     = { 34006, " - Rufus ", 1},
				[53014]     = { 34013, " - Þiþko Cellatcýk ", 1},
				[53015]     = { 34014, " - Altýn Þiþko Cellatcýk ", 1},
				[53016]     = { 34015, " - Boney ", 1},
				[53017]     = { 34016, " - Yeþim Ankasý ", 1},
				[53018]     = { 34020, " - Kar Leonidas ", 1},
				[53019]     = { 34019, " - Arktis Khan ", 1},
				[53020]     = { 34017, " - Kutup Porki ", 1},
				[53021]     = { 34018, " - Ayaz Rufus ", 1},
				[53022]     = { 34021, " - Sheldon ", 1},
				[53023]     = { 34022, " - Cooper ", 1},
				[53024]     = { 34023, " - Yavru Panter ", 1},
				[53025]     = { 34024, " - Yavru Leopar ", 1},
				[53026]     = { 34025, " - Pepita ", 1},
				[53222]     = { 34026, " - Balkabaðý Kafasý ", 1},
				[53223]     = { 34027, " - Cadý Süpürgesi ", 1},
				[53224]     = { 34028, " - Kar Tanesi ", 1},
				[53225]     = { 34029, " - Çancýk ", 1},	
				[53226]     = { 34030, " - Cupido ", 1},
				[53227]     = { 34031, " - Öfkeli Kalp ", 1},
				[53228]     = { 34032, " - Mavi Ay ", 1},
				[53229]     = { 34033, " - Kýzýl Ay ", 1},
				[53230]     = { 34034, " - Mavi Koç ", 1},
				[53231]     = { 34035, " - Beyaz Kuzucuk ", 1},
				[53232]     = { 34036, " - Yavru Huashin ", 1},
				[53233]		= { 34100, " - Bruce ", 0},
				[53234]		= { 34101, " - Wayne ", 0},
				[53235]		= { 34102, " - Robin ", 0},
				[53236]		= { 34103, " - Valentino ", 0},
				[53237]		= { 34104, " - Valentinia ", 0},
				[53238]		= { 34105, " - Valentino ", 0},
				[53239]		= { 34106, " - Valentinia ", 0},
				[53240]		= { 34107, " - Ay Feneri ", 0},
				[53241]		= { 34108, " - Ay Feneri ", 0},
				[53242]		= { 34111, " - Bonsa+ ", 0},
				[53243]		= { 34111, " - Bonsa ", 0},
				[53244]		= { 34112, " - Bayan Jiangshi ", 0},
				[53245]		= { 34113, " - Bay Jiangshi ", 0},
				[53246]		= { 34114, " - Genç Jiangshi ", 0},
				[53247]		= { 34115, " - Kýrmýzý Elf ", 0},
				[53248]		= { 34116, " - Yeþil Elf ", 0},
				[53249]		= { 34117, " - Kýrmýzý Elf ", 0},
				[53258]		= { 34090, " - Bunte Laterne ", 0},
				[53259]		= { 34091, " - Grüne Laterne ", 0},
				[53268]		= { 34087, " - Lycan Maddäus ", 0},
				[53269]		= { 34088, " - Lycaninho ", 0},
				[53260]		= { 34092, " - Osvald Bey ", 0},
				[53261]		= { 34093, " - Cobblepot Bey ", 0},
				[53263]		= { 34095, " - Griffy ", 0},
				[53264]		= { 34096, " - Nogaj ", 0},
				[53253]		= { 34086, " - Hui ", 0},
				[53254]		= { 34089, " - Buh ", 0},
            }

            itemVnum = tonumber(itemVnum)

            return pet_info_map[itemVnum]
        end
		function get_spawn_effect_file(idx)
			effect_table = {
				[0] = nil,
				[1] = "d:\\\\ymir work\\\\effect\\\\etc\\\\appear_die\\\\monster_die.mse",
			}
			return effect_table [idx]
		end
		when 53001.use or 53002.use or 53003.use or 53015.use or 53005.use or 53006.use or 53007.use or 53008.use or 53026.use or 53009.use or 53010.use or 53011.use or 53012.use or 53016.use or 53014.use or 53013.use or 53017.use or 53018.use or 53019.use or 53020.use or 53021.use or 53022.use or 53023.use or 53024.use or 53025.use or 53222.use or 53223.use or 53224.use or 53225.use or 53226.use or 53227.use or 53228.use or 53229.use or 53230.use or 53231.use or 53232.use or
			53233.use or 53234.use or 53235.use or 53236.use or 53237.use or 53238.use or 53239.use or 53240.use or 53241.use or 53242.use or 53243.use or 53244.use or 53245.use or 53246.use or 53247.use or 53248.use or 53249.use or 53250.use or 53251.use or 53256.use or 53258.use or 53259.use or 53268.use or 53269.use or 53260.use or 53261.use or 53263.use or 53264.use or 53253.use or 53254.use begin
            local pet_info = pet_system.get_pet_info(item.vnum)

            if null != pet_info then

                local mobVnum = pet_info[1]
                local petName = pet_info[2]
				local spawn_effect_file_name = pet_system.get_spawn_effect_file(pet_info[3])

                if true == pet.is_summon(mobVnum) then
					if spawn_effect_file_name != nil then
						pet.spawn_effect (mobVnum, spawn_effect_file_name)
					end
                    pet.unsummon(mobVnum)
                else
                    if pet.count_summoned() < 1 then
                        pet.summon(mobVnum, petName, false)
                    else
                        syschat("Evcil hayvan muhru yok")
                    end
					if spawn_effect_file_name != nil then
						pet.spawn_effect(mobVnum, spawn_effect_file_name)
					end
                end -- if pet.is_summon
            end  -- if null != pet_info
        end -- when
    end -- state
end -- quest
