quest spider_dungeon3_boss begin
	state start begin
		when 30130.chat."Yuvaya giri� " with pc.get_map_index() == 217 begin
			if pc.get_level() <= 50 then
			say_title("Mezar Ta��: ")
			say("Yuvaya girmek i�in yeterli tecr�beye sahip")
			say("de�ilsin. En az 50. seviye olmal�s�n.")
			say("")
			else
			local a = get_quest_state("spider_dungeon3")
			local a_ = string.format("%d",  a)
			local value = "1132644994"
				if party.is_party() then
					if game.get_event_flag("spider_use_time") - get_time() > 0 and pc.getqf("go_to_spider") == 0 then
					say_title("Mezar Ta��: ")
					say("�u an ba�ka bir grup yuvada Barones ile")
					say("sava��yor. Onlar�n sava�� bitirmesini bekle.")
					say("")
					else
						if pc.getqf("sen_girdin") - get_time() > 0 then
						say_title("Mezar Ta��: ")
						say("Son sava��n �zerinden en az bir saat ge�mesi")
						say("gerekiyor. Bu s�re i�erisinde tekrar Barones'in")
						say("yuvas�na giremezsin.")
						say("")
						else
							if party.is_leader() then
								if pc.countitem("30324") >= 1 or pc.countitem("30325") >= 1 then
								say_title("Mezar Ta��: ")
								say("Fetih mi ba�latmak istiyorsun? Bunu yapmaya 20")
								say("dakika zaman�n var. Bu s�re bitmeden �nce hi� ")
								say("kimse Barones'in yuvas�n� terk edemez. Yeni bir")
								say("fetih bir saat sonra ger�ekle�tirilebilir.")
								local s = select("Do�rula","Vazge� ")
									if s == 1 then
										if pc.count_item("30324") > 0 then
										pc.remove_item("30324",1)
										elseif pc.count_item("30325") > 0 then
										pc.remove_item("30325",1)
										end
									pc.warp(88100,614700)
									--d.new_jump(212,88100,614700)
									party.setqf("go_to_spider",1)
									purge_area(81200,613200,94200,628200)-- 300 500 , 430 650
									mob.spawn(2094,367,588,0,0)
									--pc.setqf("lider",1)
									game.set_event_flag("spider_use_time",get_time() + 20*60)
									else
									return
									end
								else
								say("Bu kap�y� sadece arachnida anahtar� a�ar.")
								say("")
								end
							elseif pc.getqf("go_to_spider") == 1 then
							say_title("Mezar Ta��: ")
							say("Grup liderin yuvaya girdi. Sen de i�eriye")
							say("girip Barones ile sava�mak istiyor musun?")
							local ss = select("Onayla","Vazge� ")
								if ss == 1 then
								pc.warp(88100,614700)
								else
								return
								end
							else
							say_title("Mezar Ta��: ")
							say("Bu kap�y� ancak bir grup lideri a�abilir.")
							end
						end
					end
				else
				say_title("Mezar Ta��: ")
				say("Yan�nda silah arkada�lar�n olmadan yuvaya")
				say("giremezsin.")
				end
			end
		end
		
		
		when login with pc.getqf("go_to_spider") == 1 begin

		loop_timer("barones_check",1)
		end
		

		when 2094.kill with pc.get_map_index() == 217 begin
		game.drop_item_with_ownership("30327",1)
		end
		
		when 30327.use with pc.get_map_index() == 217 begin
			pc.remove_item(30327, 1)
			i = mob.spawn(2095,400,566,0,0)
			mob.spawn(2095,400,594,0,0)
			mob.spawn(2095,362,600,0,0)
			mob.spawn(2095,337,599,0,0)
			mob.spawn(2095,335,581,0,0)
			mob.spawn(2095,344,562,0,0)
			mob.spawn(2095,364,588,0,0)
			mob.spawn(2095,379,562,0,0)
			mob.spawn(2095,368,525,0,0)
			mob.spawn(2092,367,588,0,0)
		end
		
		when 2095.kill with pc.get_map_index() == 217 begin
		notice_in_map("Dikkat: �r�mcek Barones sinirleniyor! Sald�r�s� ")
		notice_in_map("g��leniyor ama savunmas� azal�yor.")
		end
		
		when 2092.kill with pc.get_map_index() == 217 begin
			notice_in_map("�r�mcek Barones yok edildi! T�m sava���lar otuz ")
			notice_in_map("saniye i�inde yuvadan d��ar� ���nlanacak.")
			if not pc.is_gm() then
			party.setqf("sen_girdin",get_time() + 30)
			end
		party.setqf("2092",1)
		game.set_event_flag("spider_use_time",get_time() + 30)
		end
		
		when barones_check.timer begin
			if game.get_event_flag("spider_use_time") - get_time() <= 0 then
			purge_area(81200,613200,94200,628200)-- 300 500 , 430 650
			pc.warp(68900, 611000)
			pc.setqf("sen_girdin",get_time() + 30)
			pc.delqf("go_to_spider")
			cleartimer("barones_check")			
			end
		end
		
		when logout with pc.get_map_index() == 217 begin
		pc.remove_item("30327",pc.countitem("30327"))
		end
	end
end		