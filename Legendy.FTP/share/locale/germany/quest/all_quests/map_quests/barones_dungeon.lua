quest spider_dungeon3_boss begin
	state start begin
		when 30130.chat."Yuvaya giriþ " with pc.get_map_index() == 217 begin
			if pc.get_level() <= 50 then
			say_title("Mezar Taþý: ")
			say("Yuvaya girmek için yeterli tecrübeye sahip")
			say("deðilsin. En az 50. seviye olmalýsýn.")
			say("")
			else
			local a = get_quest_state("spider_dungeon3")
			local a_ = string.format("%d",  a)
			local value = "1132644994"
				if party.is_party() then
					if game.get_event_flag("spider_use_time") - get_time() > 0 and pc.getqf("go_to_spider") == 0 then
					say_title("Mezar Taþý: ")
					say("Þu an baþka bir grup yuvada Barones ile")
					say("savaþýyor. Onlarýn savaþý bitirmesini bekle.")
					say("")
					else
						if pc.getqf("sen_girdin") - get_time() > 0 then
						say_title("Mezar Taþý: ")
						say("Son savaþýn üzerinden en az bir saat geçmesi")
						say("gerekiyor. Bu süre içerisinde tekrar Barones'in")
						say("yuvasýna giremezsin.")
						say("")
						else
							if party.is_leader() then
								if pc.countitem("30324") >= 1 or pc.countitem("30325") >= 1 then
								say_title("Mezar Taþý: ")
								say("Fetih mi baþlatmak istiyorsun? Bunu yapmaya 20")
								say("dakika zamanýn var. Bu süre bitmeden önce hiç ")
								say("kimse Barones'in yuvasýný terk edemez. Yeni bir")
								say("fetih bir saat sonra gerçekleþtirilebilir.")
								local s = select("Doðrula","Vazgeç ")
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
								say("Bu kapýyý sadece arachnida anahtarý açar.")
								say("")
								end
							elseif pc.getqf("go_to_spider") == 1 then
							say_title("Mezar Taþý: ")
							say("Grup liderin yuvaya girdi. Sen de içeriye")
							say("girip Barones ile savaþmak istiyor musun?")
							local ss = select("Onayla","Vazgeç ")
								if ss == 1 then
								pc.warp(88100,614700)
								else
								return
								end
							else
							say_title("Mezar Taþý: ")
							say("Bu kapýyý ancak bir grup lideri açabilir.")
							end
						end
					end
				else
				say_title("Mezar Taþý: ")
				say("Yanýnda silah arkadaþlarýn olmadan yuvaya")
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
		notice_in_map("Dikkat: Örümcek Barones sinirleniyor! Saldýrýsý ")
		notice_in_map("güçleniyor ama savunmasý azalýyor.")
		end
		
		when 2092.kill with pc.get_map_index() == 217 begin
			notice_in_map("Örümcek Barones yok edildi! Tüm savaþçýlar otuz ")
			notice_in_map("saniye içinde yuvadan dýþarý ýþýnlanacak.")
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