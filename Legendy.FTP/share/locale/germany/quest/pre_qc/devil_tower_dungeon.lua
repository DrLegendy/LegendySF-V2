quest seytan_kulesi begin
    state start begin
        when login begin
            if pc.get_map_index() == 66 then
                if pc.get_x() < 2048+88 or pc.get_y() < 6656+577 or pc.get_x() > 2048+236 or pc.get_y() > 6656+737 then
                    pc.warp(590500, 110500)
                end
                pc.set_warp_location(65, 5905, 1105)
            elseif pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 then
                pc.set_warp_location(65, 5905, 1105)				
                seytan_kulesi.register_player(pc.get_vid())
            end
        end

	when logout begin
		if pc.count_item(30300) >= 1 then
			pc.remove_item(30300, pc.count_item(30300))
		end
		if pc.count_item(30302) >= 1 then
			pc.remove_item(30302, pc.count_item(30302))
		end				
		if pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 then
			seytan_kulesi.unregister_player(pc.get_vid())		
		end
	end
	when 20348.chat."Şeytan Kulesi Bekçisi " begin
		if pc.get_level() < 40 then
			say_title("Şeytan Kulesi Bekçisi:")
			say_kirmizi("Cesaretini takdir ediyorum fakat")
			say_kirmizi("kuleye girebilmek için en az")
			say_kirmizi("40.seviye olman gerekmektedir.")
			return
	    end
		if not party.is_party() then
			say_title("Şeytan Kulesi Bekçisi:")
			say_kirmizi("Cesaretini takdir ediyorum fakat")
            say_kirmizi("grubun olmadan giriş talebi yapamazsın.")
            return
		end
		if not party.is_leader() then
			say_title("Şeytan Kulesi Bekçisi:")
            say_kirmizi("Cesaretini takdir ediyorum fakat")
            say_kirmizi("yalnızca grup lideri giriş talebi yapabilir.")
            return
        end
			say_title("Şeytan Kulesi Bekçisi:")
			say_yesil("Grubunla Şeytan Kulesine giriş yapacaksın.")
			say_kirmizi("Unutma; girdiğiniz alan sadece grubunuza aittir.")
			say_yesil("Şeytan kulesine şimdi girmek istiyor musun?")
			local s = select("Evet ","Hayır ")
				if s == 1 then
					local idx = 66
					local x = 2165
					local y = 7270
					d.new_jump_party(idx , x, y)
					d.regen_file("data/dungeon/deviltower1_regen.txt")
				end
		end
        when kill with npc.get_race() == 8015 begin
			notice_in_map("Dayanıklılık metni yok edildi, 2.kata ışınlanıyorsunuz..")
            timer("devil_stone1_1", 5)
        end
        when devil_stone1_1.timer begin
			d.new_jump_party(66, special.devil_tower[1][1], special.devil_tower[1][2])
            d.regen_file("data/dungeon/deviltower2_regen.txt")
            d.set_warp_at_eliminate(4, d.get_map_index(), special.devil_tower[2][1], special.devil_tower[2][2], "data/dungeon/deviltower3_regen.txt")
        end
        when kill with npc.get_race() == 1091 and pc.in_dungeon() and pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 begin
			d.set_warp_at_eliminate(4, d.get_map_index(), special.devil_tower[3][1], special.devil_tower[3][2], "data/dungeon/deviltower4_regen.txt")
			d.check_eliminated()
		end
        function get_4floor_stone_pos()
	    local positions = 
			{
				{368, 629}, {419, 630}, {428, 653}, {422, 679},
				{395, 689}, {369, 679}, {361, 658},
			}
            for i = 1, 6 do
                local j = number(i, 7)
                if i != j then
                    local t = positions[i];
                    positions[i] = positions[j];
                    positions[j] = t;
                end
            end
            return positions
        end
         when kill with npc.get_race() == 8016 and pc.in_dungeon() and pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 begin
            d.setf("level", 4)
            local positions = seytan_kulesi.get_4floor_stone_pos()
            for i = 1, 6 do
                d.set_unique("fake" .. i , d.spawn_mob(8017, positions[i][1], positions[i][2]))
            end
            local vid = d.spawn_mob(8017, positions[7][1], positions[7][2])
            d.set_unique("real", vid)
	    server_loop_timer('devil_stone4_update', 10, pc.get_map_index())
	    server_timer('devil_stone4_fail1', 5*60, pc.get_map_index())

			notice_in_map("Gözlerini ve kulaklarını aldatacak bir çok sahte");
			notice_in_map("Metin Taşı mevcut. 15 dakika içerisinde");
			notice_in_map("gerçek Metin Taşı'nı bul ve yok et!");
			notice_in_map("Kapıdan geçmenin tek yolu budur.");
			notice_in_map("Bulunduğunuz bölge Şeytan Kulesi 4.Kat ")
        end

        when devil_stone4_fail1.server_timer begin
            if d.select(get_server_timer_arg()) then
               notice_in_map("10 dakika kaldı ")
		server_timer('devil_stone4_fail2', 5*60, get_server_timer_arg())
            end
        end

        when devil_stone4_fail2.server_timer begin
            if d.select(get_server_timer_arg()) then
                notice_in_map("5 dakika kaldı ")
		server_timer('devil_stone4_fail', 5*60, get_server_timer_arg())
            end
        end

        when devil_stone4_fail.server_timer begin
            if d.select(get_server_timer_arg()) and d.getf("level") == 4 then
               notice_in_map("Zaman doldu! ")
                d.exit_all()
            end
        end

        when devil_stone4_update.server_timer begin
            if d.select(get_server_timer_arg()) then
                if not d.is_unique_dead("real") then
                    for i = 1, 6 do
                        if d.getf("fakedead" .. i) == 0 then
                            if d.unique_get_hp_perc("fake" .. i) < 50 then
                                d.purge_unique("fake" .. i)
                                d.setf("fakedead" .. i, 1)
                               notice_in_map("Sahte Metin taşları yok oldu...");
                            end
                        end
                    end
                else
                    server_timer("devil_stone4_end", 5, get_server_timer_arg())
                    
                    notice_in_map("Mükemmel bir duyma yeteneğine ve iyi bir");
					notice_in_map("içgüdüye sahip olduğunu kanıtlayarak");
					notice_in_map("gerçek Metin Taşı'nı yok ettin!");
					notice_in_map("Şimdi 5.kata gireceksin.")
                    d.purge()
                end
            else
		server_timer('devil_stone4_stop_timer', 1, get_server_timer_arg())
            end
        end

        when devil_stone4_stop_timer.server_timer begin
	    clear_server_timer('devil_stone4_update', get_server_timer_arg())
        end

        when devil_stone4_end.server_timer begin
            if d.select(get_server_timer_arg()) then
			clear_server_timer('devil_stone4_update', get_server_timer_arg())
			clear_server_timer('devil_stone4_fail1', get_server_timer_arg())
			clear_server_timer('devil_stone4_fail2', get_server_timer_arg())
			clear_server_timer('devil_stone4_fail', get_server_timer_arg())

                d.setf("level", 5)
                d.setf("stone_count", 5)
                
                d.jump_all(special.devil_tower[4][1], special.devil_tower[4][2])
                notice_in_map("Bir sonraki kata")
				notice_in_map("çıkmak için beş Eski Mühür'ü açman gerek.")
				notice_in_map("2 Dakika arayla metin yenilenir.")
				notice_in_map("Metni yok ederek mühür elde edebilirsin.")
				notice_in_map("Süre: 20 dakika!")
				notice_in_map("Bulunduğunuz bölge Şeytan Kulesi 5.Kat ")
                
		server_timer('devil_stone5_fail1', 5*60, get_server_timer_arg())
		clear_server_timer('devil_stone4_update', get_server_timer_arg())

                d.set_regen_file("data/dungeon/deviltower5_regen.txt")

                d.spawn_mob(20073, 421, 452)
                d.spawn_mob(20073, 380, 460)
                d.spawn_mob(20073, 428, 414)
                d.spawn_mob(20073, 398, 392)
                d.spawn_mob(20073, 359, 426)
            end
        end
        when devil_stone5_fail1.server_timer begin
            if d.select(get_server_timer_arg()) then
                notice_in_map("15 dakika kaldı ")
		server_timer('devil_stone5_fail2', 5*60, get_server_timer_arg())
            end
        end

        when devil_stone5_fail2.server_timer begin
            if d.select(get_server_timer_arg()) then
				notice_in_map("10 dakika kaldı ")
		server_timer('devil_stone5_fail3', 5*60, get_server_timer_arg())
            end
        end

        when devil_stone5_fail3.server_timer begin
            if d.select(get_server_timer_arg()) then
                notice_in_map("5 dakika kaldı ")
		server_timer('devil_stone5_fail', 5*60, get_server_timer_arg())
            end
        end

        when devil_stone5_fail.server_timer begin
            if d.select(get_server_timer_arg()) and d.getf("level") == 5 then
		notice_in_map("Zaman doldu!")
		d.exit_all()
            end
        end

        when devil_stone5.take with item.vnum == 50084 begin
            npc.purge()
            item.remove()
            d.setf("stone_count", d.getf("stone_count") - 1)
            if d.getf("stone_count") <= 0 then
            	d.clear_regen()
            	d.kill_all()
               	notice_in_map("Tüm mühürleri açtın ve artık 5.kata")
				notice_in_map("girebilirsin. Bu katta Kibirli Şeytan Kralı da")
				notice_in_map("var. 6. kattaki tüm canavarları öldür.")
		clear_server_timer('devil_stone5_fail1', get_server_timer_arg())
		clear_server_timer('devil_stone5_fail2', get_server_timer_arg())
		clear_server_timer('devil_stone5_fail3', get_server_timer_arg())
		clear_server_timer('devil_stone5_fail', get_server_timer_arg())
		
                d.setf("level", 6)
                d.jump_all(special.devil_tower[5][1], special.devil_tower[5][2])
		d.regen_file("data/dungeon/deviltower6_regen.txt")
		

            else
                notice_in_map("Mührü açtın! "..d.getf("stone_count").." kaldı.")
            end
        end

        when devil_stone6.kill begin
			timer("devil_jump_7",6)
            d.kill_all()
            d.check_eliminated()
        end

 
		
   when devil_jump_7.timer begin
		d.clear_regen()

		d.spawn_mob(8018, 639, 658)
		d.spawn_mob(8018, 611, 637)
		d.spawn_mob(8018, 596, 674)
		d.spawn_mob(8018, 629, 670)

		d.setf("level", 7)

		d.jump_all(2048+590, 6656+638)
	end
	
	 when kill with npc.get_race() == 8018 and pc.in_dungeon() and pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 begin
		local cont = d.getf("7_stone_kill") + 1
		d.setf("7_stone_kill", cont)

		if cont >= 4 then
			d.setf("7_stone_kill", 0)
			d.set_regen_file("data/dungeon/deviltower7_regen.txt")
        end
	end

	 when kill with npc.get_race() == 8019 and pc.in_dungeon() and pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 begin
		game.drop_item(30300, 1)
	end

	when 30300.use with pc.in_dungeon() and pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 begin
		pc.remove_item("30300", 1)

		local pct = number(1,1)

		if pct == 1 then
			game.drop_item(30302, 1)
			d.clear_regen()
			
		end
	end

	when 30302.use with pc.in_dungeon() and pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 begin

			if d.getf( "level" ) != 7 then
				pc.remove_item( "30302", 1)
				return
			end
			
		say_title("Bilgi:")
		say("Haritayı buldun. Üst kata geçiyorsun.")
		say("İyi şanslar.")
		pc.remove_item("30302", 1)
	    timer("devil_jump_8", 6)
		d.clear_regen()
	end
						
	when devil_jump_8.timer begin
		d.setf("level", 8)
		d.jump_all(2048+590, 6656+403)
		d.set_regen_file("data/dungeon/deviltower8_regen.txt")
		d.spawn_mob(20366, 640, 460)
		local _count = pc.count_item(30302)
		pc.remove_item(30302,_count)
		
	end

	 when kill with npc.get_race() == 1040 and pc.in_dungeon() and pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 begin
		if d.getf("level") < 9 then
			local pct1 = number(1, 10)
			if pct1 == 1 then
				local pct2 = number(1, 4)
				if pct2 == 1 then
					-- ÁøÂ¥ ¿­¼è µå·Ó
					game.drop_item(30304, 1)
				else
					-- °¡Â¥ ¿­¼è µå·Ó
					game.drop_item(30303, 1)
				end
			else
				return
			end
		end
	end

	when 20366.take with item.vnum == 30304 begin
		-- ºÀÀÎ ÇØÃ¼ 9Ãş ¤¡¤¡
		npc.purge()
		item.remove()
		timer("devil_jump_9", 8)
	end

	---------------------------------------------
	-- 9Ãş ÁøÀÔºÎÅÍ ¿Ï·á±îÁö
	---------------------------------------------
	when devil_jump_9.timer begin
		d.setf("level", 9)
		d.jump_all(2048+590, 6656+155)
		d.regen_file("data/dungeon/deviltower9_regen.txt")
	end

	 when kill with npc.get_race() == 1093 and pc.in_dungeon() and pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 begin
		d.kill_all()
		timer("devil_end_jump", 30)
	end

	when devil_end_jump.timer begin
	    d.exit_all()
	end
	function register_player(vid)
		local player_count = d.getf("player_count")
		player_count = player_count + 1
		d.setf("player_count", tonumber(player_count))
		d.setf(string.format("player%d", player_count), tonumber(vid))
	end	
	function unregister_player(vid)
		local player_count = d.getf("player_count")
		local found = false
		for i = 1, player_count, 1 do
			if found == true then
				d.setf(string.format("player%d", tonumber(i)), d.getf(string.format("player%d", i+1)))
			end
			p = d.getf("player"..tostring(i))
			if p == vid then
				i = i -1
				found = true
			end
		end	
		if found == true then
			d.setf("player_count", tonumber(player_count - 1))
		end
	end	
	function get_players()
		local players = {}
		local player_count = d.getf("player_count")
		for i = 1, player_count, 1 do
			players[i] = d.getf("player"..tostring(i))
		end
		return players
	end
	function give_dc_access(pindex)
		local self_checked = false
		local self = pc.select(d.getf("player"..tostring(pindex)))
		--pc.setqf("dcenter", 1)
		pc.setf("seytan_kulesi", "dcenter", 1)
		pc.select(self)
	end
end
end
