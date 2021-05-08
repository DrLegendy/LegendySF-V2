quest kristal_oda begin
	state start begin
		when logout begin
			if pc.get_map_index() == 79 then
				pc.delqf("icerdesin1")
				pc.delqf("icerdesin2")
				pc.delqf("lider")
			end
		end
		when 30121.chat."Ejderhayý öldürmek istiyorum!" with pc.get_map_index() == 73 and pc.get_channel_id() == 1 or pc.get_channel_id() == 2 begin
		if pc.get_channel_id() == 2 then
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 2 and game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time() > 0 then
				say_title("Sura Ruhu:")
				say("")
				say("Üzgünüm Ejderha Tapýnaðý þuan dolu.")
				say("Kalan süre: "..game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time().." saniye")
				say("")
				return
			end
			if game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time() < 0 and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") >= 1 then
				game.set_event_flag("ejder_kullanimda"..pc.get_channel_id().."",0)
				purge_area(829200,1059600,844200,1074600)
				---warp_all_in_map(79,180100,1220400)
				warp_all_to_village(79)
				setskin(NOWINDOW)
				return
			end
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 and pc.count_item(30179) < 3 then
				say_title("Sura Ruhu:")
				say("Gerekli eþya 3x: "..item_name(30179)..":")
				say_item_vnum(30179)
				say("3 adet anahtara ihtiyacýn var.")
				return
			end
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 1 then
				pc.setqf("ejder_bug_engel2",get_time()+5)
				say_title("Sura Ruhu:")
				say("")
				say("Üzgünüm Ejderha Tapýnaðý þuan dolu.")
				say("Eðer þifreyi biliyorsan,")
				say("doðru bir þekilde yaz.")
				say("")
				say_reward("5 saniye süren var!")
				say("")
			local pin = tonumber(input(""))
				if get_time() > pc.getqf("ejder_bug_engel2") then
					say_title("Sura Ruhu:")
					say("5 saniye doldu þansýný tekrar dene.")
					pc.setqf("ejder_bug_engel2",get_time()+0)
					return
				end
				if string.len(pin) < 4 then
					say_title("Sura Ruhu:")
					say("")
					say("Þifre en az 4 karakterden oluþmalý.")
					return
					end
				if game.get_event_flag("ejder_sifresi"..pc.get_channel_id().."") == pin then
					say_title("Sura Ruhu:")
					say("")
						if pc.count_item(30179) < 3 then
							say("Girmene izin veremem.")
							say("Gerekli eþya 3x: "..item_name(30179)..":")
							say_item_vnum(30179)
							say("3 tane anahtara sahip olduðunda tekrar gel.")
							return
						end
					pc.remove_item("30179",3)
					say("Þifre doðru tebrikler!")
					say("Seni içeri gönderiyorum. Onu yenmeden dönme!")
					pc.setqf("icerdesin"..pc.get_channel_id().."",1)
					wait()
					pc.warp(843600,1066900)
				elseif pin != game.get_event_flag("ejder_sifresi"..pc.get_channel_id().."") then
					say_title("Sura Ruhu:")
					say("Üzgünüm þifreyi hatalý girdin.")
					return
				end
			end
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 and pc.count_item(30179) >= 3 then
			say_title("Sura Ruhu:")
			say("Ejderha Tapýnaðý'na girmek isteyen ilk kiþi")
			say("sensin. Yeterli sayýda Kývrýk Anahtara sahipsen")
			say("seni içeri býrakacaðým. Ama ilk önce bir þifre")
			say("belirleyeceksin. Bu þifreyi, 5 dakika")
			say("içerisinde savaþ arkadaþlarýna verip onlarýn")
			say("içeri girmesini saðlayabilirsin. Bu anahtarýn")
			say("sadece 30 dakika tesir edeceðini unutma. O zamana")
			say("kadar ejderhayý öldürmüþ olmanýz gerekiyor!")
			say("")
			pc.setqf("ejder_bug_engel3",get_time()+5)
			local i = select("Hazýrým!", "Vazgeç ")
				if get_time() > pc.getqf("ejder_bug_engel3") then
					say_title("Sura Ruhu:")
					say("5 saniye doldu þansýný tekrar dene.")
					pc.setqf("ejder_bug_engel3",get_time()+0)
					return
				end
				if 1 == i and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 then
				say_title("Sura Ruhu:")
				pc.setqf("ejder_bug_engel3",get_time()+5)
				local pin = number(1000,9999999)
						say("")
						say("")
						say("")
						say_reward("Yazman gereken þifre : "..pin)
						say_reward("5 saniye süren var!")
					local giris = tonumber ( input ( "" ) )
					if get_time() > pc.getqf("ejder_bug_engel3") then
									say_title("Sura Ruhu:")
									say("5 saniye doldu þansýný tekrar dene.")
									pc.setqf("ejder_bug_engel3",get_time()+0)
									return
								end
					if giris != pin then
					say_title("Sura Ruhu:")
					say("")
					say_red("Malesef, Yanlýþ yazdýn.")
					return
					end

					if pin and pin <= 999999999 and pc.count_item(30179)>=3 then
					say_title("Sura Ruhu:")
					say("")
					say("Arzu edersen seni doðrudan Ejderha Maðarasý'na")
					say("götürebilirim. Bana þimdi vermen gerekenler:")
					say("3x:")
					say_item_vnum(30179)
					pc.setqf("ejder_bug_engel3",get_time()+5)
					local zaxd = select("Al ve beni içeri býrak!","Vazgeç ")
					if get_time() > pc.getqf("ejder_bug_engel3") then
								say_title("Sura Ruhu:")
								say("5 saniye doldu þansýný tekrar dene.")
								pc.setqf("ejder_bug_engel3",get_time()+0)
								return
							end
						if zaxd == 2 then
						return
						elseif zaxd == 1 and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 then
							if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") != 0 then
							syschat("Ejderha odasýna baþka bir grup girdi.")
							return
							end
						game.set_event_flag("ejder_kullanimda"..pc.get_channel_id().."",1)
						pc.setqf("ejder_sifre",pin)
						pc.setqf("icerdesin"..pc.get_channel_id().."",1)
						pc.remove_item("30179",3)
						pc.setqf("lider",1)							
						clear_server_timer("ejderi_kescen"..pc.get_channel_id().."",get_server_timer_arg())
						clear_server_timer("disari_yolluyoz"..pc.get_channel_id().."",get_server_timer_arg())		
						game.set_event_flag("ejder_sifresi"..pc.get_channel_id().."",pin)
						game.set_event_flag("time_1"..pc.get_channel_id().."", get_time()+1800)
						--timer("iceri_gir",3)
						pc.warp(843600, 1066900)
						elseif zaxd == 1 and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") != 0 then
						say_title("Sura Ruhu:")
						say("")
						say("Birileri senden önce davrandý. Onlarýn")
						say("odadan çýkmalarýný bekle ya da parolayý ")
						say("biliyorsan söyle.")
						end
					else 
					say_title("Sura Ruhu:")
					say("")
					say("Bir hata oluþtu.")
					say("")
					end
				end
			end
			
			elseif pc.get_channel_id() == 1 then
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 2 and game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time() > 0 then
				say_title("Sura Ruhu:")
				say("")
				say("Üzgünüm Ejderha Tapýnaðý þuan dolu.")
				say("Kalan süre: "..game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time().." saniye")
				say("")
				return
			end
			if game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time() < 0 and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") >= 1 then
				game.set_event_flag("ejder_kullanimda"..pc.get_channel_id().."",0)
				purge_area(829200,1059600,844200,1074600)
				---warp_all_in_map(79,180100,1220400)
				warp_all_to_village(79)
				setskin(NOWINDOW)
				return
			end
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 and pc.count_item(30179) < 3 then
				say_title("Sura Ruhu:")
				say("Gerekli eþya 3x: "..item_name(30179)..":")
				say_item_vnum(30179)
				say("3 adet anahtara ihtiyacýn var.")
				return
			end
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 1 then
				pc.setqf("ejder_bug_engel2",get_time()+5)
				say_title("Sura Ruhu:")
				say("")
				say("Üzgünüm Ejderha Tapýnaðý þuan dolu.")
				say("Eðer þifreyi biliyorsan,")
				say("doðru bir þekilde yaz.")
				say("")
				say_reward("5 saniye süren var!")
				say("")
			local pin = tonumber(input(""))
				if get_time() > pc.getqf("ejder_bug_engel2") then
					say_title("Sura Ruhu:")
					say("5 saniye doldu þansýný tekrar dene.")
					pc.setqf("ejder_bug_engel2",get_time()+0)
					return
				end
				if string.len(pin) < 4 then
					say_title("Sura Ruhu:")
					say("")
					say("Þifre en az 4 karakterden oluþmalý.")
					return
					end
				if game.get_event_flag("ejder_sifresi"..pc.get_channel_id().."") == pin then
					say_title("Sura Ruhu:")
					say("")
						if pc.count_item(30179) < 3 then
							say("Girmene izin veremem.")
							say("Gerekli eþya 3x: "..item_name(30179)..":")
							say_item_vnum(30179)
							say("3 tane anahtara sahip olduðunda tekrar gel.")
							return
						end
					pc.remove_item("30179",3)
					say("Þifre doðru tebrikler!")
					say("Seni içeri gönderiyorum. Onu yenmeden dönme!")
					pc.setqf("icerdesin"..pc.get_channel_id().."",1)
					wait()
					pc.warp(843600,1066900)
				elseif pin != game.get_event_flag("ejder_sifresi"..pc.get_channel_id().."") then
					say_title("Sura Ruhu:")
					say("Üzgünüm þifreyi hatalý girdin.")
					return
				end
			end
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 and pc.count_item(30179) >= 3 then
			say_title("Sura Ruhu:")
			say("Ejderha Tapýnaðý'na girmek isteyen ilk kiþi")
			say("sensin. Yeterli sayýda Kývrýk Anahtara sahipsen")
			say("seni içeri býrakacaðým. Ama ilk önce bir þifre")
			say("belirleyeceksin. Bu þifreyi, 5 dakika")
			say("içerisinde savaþ arkadaþlarýna verip onlarýn")
			say("içeri girmesini saðlayabilirsin. Bu anahtarýn")
			say("sadece 30 dakika tesir edeceðini unutma. O zamana")
			say("kadar ejderhayý öldürmüþ olmanýz gerekiyor!")
			say("")
			pc.setqf("ejder_bug_engel3",get_time()+5)
			local i = select("Hazýrým!", "Vazgeç ")
				if get_time() > pc.getqf("ejder_bug_engel3") then
					say_title("Sura Ruhu:")
					say("5 saniye doldu þansýný tekrar dene.")
					pc.setqf("ejder_bug_engel3",get_time()+0)
					return
				end
				if 1 == i and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 then
				pc.setqf("ejder_bug_engel2",get_time()+5)
						say_title("Sura Ruhu:")
						local pin1 = number(1000,9999999)
						local pin2 = number(1000,99999)
						local pin3 = number(1000,9999999)
						local pin4 = number(1000,99999)
						local pin5 = number(1000,9999999)
						local pin6 = number(1000,99999)
						local gercek = number(2,7)
						local pin
						if gercek == 2 then
							pin = pin1
						elseif gercek == 3 then
							pin = pin2
						elseif gercek == 4 then
							pin = pin3
						elseif gercek == 5 then
							pin = pin4
						elseif gercek == 6 then
							pin = pin5
						elseif gercek == 7 then
							pin = pin6
						end
						say_reward("Seçmen gereken þifre : "..pin)
						say_reward("5 saniye süren var!")
						local sifre = select("Vazgeç ",pin1,pin2,pin3,pin4,pin5,pin6)
						if get_time() > pc.getqf("ejder_bug_engel2") then
							say_title("Sura Ruhu:")
							say("5 saniye doldu þansýný tekrar dene.")
							pc.setqf("ejder_bug_engel2",get_time()+0)
							return
						end
						if sifre == gercek and pc.count_item(30179)>=3 then
							say_title("Sura Ruhu:")
							say("")
							say("Arzu edersen seni doðrudan Ejderha Maðarasý'na")
							say("götürebilirim. Bana þimdi vermen gerekenler:")
							say("3x:")
							say_item_vnum(30179)
							say_reward("5 saniye süren var!")
							pc.setqf("ejder_bug_engel3",get_time()+5)
							local zaxd = select("Al ve beni içeri býrak!","Vazgeç ")
							if get_time() > pc.getqf("ejder_bug_engel3") then
								say_title("Sura Ruhu:")
								say("5 saniye doldu þansýný tekrar dene.")
								pc.setqf("ejder_bug_engel3",get_time()+0)
								return
							end
							if zaxd == 2 then
						return
						elseif zaxd == 1 and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 then
							if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") != 0 then
							syschat("Ejderha odasýna baþka bir grup girdi.")
							return
							end
						game.set_event_flag("ejder_kullanimda"..pc.get_channel_id().."",1)
						pc.setqf("ejder_sifre",pin)
						pc.setqf("icerdesin"..pc.get_channel_id().."",1)
						pc.remove_item("30179",3)
						pc.setqf("lider",1)						  
						clear_server_timer("ejderi_kescen"..pc.get_channel_id().."",get_server_timer_arg())
						clear_server_timer("disari_yolluyoz"..pc.get_channel_id().."",get_server_timer_arg())		
						game.set_event_flag("ejder_sifresi"..pc.get_channel_id().."",pin)
						game.set_event_flag("time_1"..pc.get_channel_id().."", get_time()+1800)
						--timer("iceri_gir",3)
						pc.warp(843600, 1066900)
						elseif zaxd == 1 and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") != 0 then
						say_title("Sura Ruhu:")
						say("")
						say("Birileri senden önce davrandý. Onlarýn")
						say("odadan çýkmalarýný bekle ya da parolayý ")
						say("biliyorsan söyle.")
						end
					else 
					say_title("Sura Ruhu:")
					say("")
					say("Bir hata oluþtu.")
					say("")
					end
				end
			end
			
			else
				return
			end
		end
		when login begin
			if pc.getqf("icerdesin"..pc.get_channel_id().."") == 1 then
				send_letter("Mavi Ejderha'yý maðlup edin")
			end
		end
		when button or info begin
			q.set_clock("Kalan süre:", game.get_event_flag("time_1"..pc.get_channel_id().."")-get_time())
			kristal_oda.ejder_odasi_kalansure()
		end
		when login with pc.get_map_index() == 79 and pc.getqf("icerdesin"..pc.get_channel_id().."") != 1 begin
			pc.warp(180100,1220400)
		end
		when login with pc.get_map_index() == 79 and pc.getqf("lider") == 1 begin
			notice_all("CH "..pc.get_channel_id()..": "..pc.get_name().." grubu, Mavi Ejderha'yý öldürmeye çalýþýyor!")
			notice(""..pc.getqf("ejder_sifre").." numaralý þifreyi daðýtmaya 5 dakika zamanýn")
			notice("var!")
			purge_area(829200,1059600,844200,1074600)
			regen_in_map(79,"data/dungeon/skia_deliboss.txt")
			server_timer("sifre_kapat"..pc.get_channel_id().."", 300,pc.get_map_index())
			server_timer("ejderi_kescen"..pc.get_channel_id().."", 1800,pc.get_map_index())
			server_timer("ejderi_kontrol_et_"..pc.get_channel_id().."_1",30,pc.get_map_index())
			kristal_oda.ejder_odasi_kalansure()
			pc.setqf("lider",2)
			pc.set_warp_location(73 , 1801, 12204)
		end
		when login with pc.get_map_index() == 79 and pc.getqf("icerdesin"..pc.get_channel_id().."") == 1 and pc.getqf("lider") != 1 begin
			kristal_oda.ejder_odasi_kalansure()
			pc.set_warp_location(73 , 1801, 12204)
		end
		when 2493.kill with pc.get_map_index() == 79 and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") >= 1 begin
			notice_all("CH "..pc.get_channel_id()..": "..pc.get_name().." grubu, Mavi Ejderha'yý öldürdü!")
			game.set_event_flag("time_1"..pc.get_channel_id().."",get_time() + 30)
			clear_server_timer("ejderi_kescen"..pc.get_channel_id().."",get_server_timer_arg())
			server_timer("disari_yolluyoz"..pc.get_channel_id().."",30, pc.get_map_index()) ---300 olcak
			forked.warp_all_in_map("79","73","180100","1220400",295)
		end
		when sifre_kapat1.server_timer begin
			game.set_event_flag("ejder_kullanimda1",2)
		end
		when disari_yolluyoz1.server_timer begin
			notice_all("CH 1: Mavi Ejderha geri döndü!")
			game.set_event_flag("kesilen_metin1",0)
			purge_area(829200,1059600,844200,1074600)
			clear_server_timer("ejderi_kescen1",get_server_timer_arg())
			game.set_event_flag("ejder_kullanimda1",0)
			forked.warp_all_in_map("79","73","180100","1220400",1)
		end
		when ejderi_kescen1.server_timer with game.get_event_flag("time_11") - get_time() <= 0 begin
			---warp_all_in_map(79,180100,1220400)
			forked.warp_all_in_map("79","73","180100","1220400",1)
			notice_all("CH 1: Mavi Ejderha hâlâ yaþýyor!")
			purge_area(829200,1059600,844200,1074600)
			game.set_event_flag("kesilen_metin1",0)
			game.set_event_flag("ejder_kullanimda1",0)
		end
		when sifre_kapat2.server_timer begin
			game.set_event_flag("ejder_kullanimda2",2)
		end
		when disari_yolluyoz2.server_timer begin
			notice_all("CH 2: Mavi Ejderha geri döndü!")
			game.set_event_flag("kesilen_metin2",0)
			purge_area(829200,1059600,844200,1074600)
			clear_server_timer("ejderi_kescen2",get_server_timer_arg())
			game.set_event_flag("ejder_kullanimda2",0)
			forked.warp_all_in_map("79","73","180100","1220400",1)
		end
		when ejderi_kescen2.server_timer with game.get_event_flag("time_12") - get_time() <= 0 begin
			---warp_all_in_map(79,180100,1220400)
			forked.warp_all_in_map("79","73","180100","1220400",1)
			notice_all("CH 2: Mavi Ejderha hâlâ yaþýyor!")
			purge_area(829200,1059600,844200,1074600)
			game.set_event_flag("kesilen_metin2",0)
			game.set_event_flag("ejder_kullanimda2",0)
		end
		when login with pc.get_map_index() != 79 begin
			if pc.getqf("icerdesin1") == 1 or pc.getqf("icerdesin2") == 1 then
				pc.delqf("icerdesin1")
				pc.delqf("icerdesin2")
				pc.delqf("ejder_sifre")
				pc.delqf("lider")
			end
		end
		when 30121.chat."Süreyi sýfýrla" with pc.is_gm() begin
			say_title("Sura Ruhu;")
			say("Sýfýrlamak istediðinden emin misin ?")
			local cyvercha = select("Evet","Hayýr")
			if cyvercha == 2 then
				return
			elseif cyvercha == 1 then
				notice_all("CH "..pc.get_channel_id()..": Kristal oda süresi sýfýrlanmýþtýr.")
				game.set_event_flag("time_1"..pc.get_channel_id().."",get_time() + 30)
				clear_server_timer("ejderi_kescen"..pc.get_channel_id().."",get_server_timer_arg())
				server_timer("disari_yolluyoz"..pc.get_channel_id().."",30, pc.get_map_index()) ---300 olcak
				forked.warp_all_in_map("79","73","180100","1220400",295)
			end
		end
		function ejder_odasi_kalansure()
			local saniyekalan = (game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time())
			local dakikakalan = math.ceil(saniyekalan / 60)	
			notice("Mavi Ejderha'yý öldürmeye "..dakikakalan.." dakikalýk bir zaman")
			notice("kaldý!")	 
		end	
		
		when 30121.chat."Ejderha Odasý Durumu" with pc.get_map_index() == 73 begin
				local saniyekalan1 = (game.get_event_flag("time_11") - get_time())
				local dakikakalan1 = math.ceil(saniyekalan1 / 60)    
				local saniyekalan2 = (game.get_event_flag("time_12") - get_time())
				local dakikakalan2 = math.ceil(saniyekalan2 / 60)    
				say_title("Sura Ruhu:")
				say("")
				say("Þuan ejderha odasýna gireceðin aktif kanallar:")	
				if game.get_event_flag("ejder_kullanimda1") != 0 and dakikakalan1 > 0 then
					say_green("CH1:Ejderha odasý (Dolu)")
				else
					say_yellow("CH1:Ejderha odasý (Boþ)")
				end
				if game.get_event_flag("ejder_kullanimda2") != 0 and dakikakalan2 > 0 then
					say_green("CH2:Ejderha odasý (Dolu)")
				else
					say_yellow("CH2:Ejderha odasý (Boþ)")
				end
				say_reward("CH3:Ejderha odasýna giriþler kapalý.")		
				say_reward("CH4:Ejderha odasýna giriþler kapalý.")				
				say("")
		end
		
		when ejderi_kontrol_et_1_1.server_timer begin
			if pc.ejder_kontrol(79) == 0 and game.get_event_flag("ejder_oldu") == 0 then
				notice_all("CH1: Ejderha odasýnda kimse kalmadýðý için oda kapatýlýyor.")
				purge_area(829200,1059600,844200,1074600)
				kill_all_in_map(79)
				clear_server_timer("ejderi_kescen1",get_server_timer_arg())
				clear_server_timer("ejderi_kontrol_et_1_1",get_server_timer_arg())
				clear_server_timer("ejderi_kontrol_et_1_2",get_server_timer_arg())
				game.set_event_flag("ejder_kullanimda1",0)
				game.set_event_flag("ejder_sifresi",0)
				game.set_event_flag("time_11",0)
				forked.warp_all_in_map("79","73","180100","1220400",1)
			else
				-- notice_all("Ejderha odasýnda "..pc.ejder_kontrol(79).." kiþi var.")
				server_timer("ejderi_kontrol_et_1_2",30)
			end
		end
		
		when ejderi_kontrol_et_1_2.server_timer begin
			if pc.ejder_kontrol(79) == 0 and game.get_event_flag("ejder_oldu") == 0 then
				notice_all("CH1: Ejderha odasýnda kimse kalmadýðý için oda kapatýlýyor.")
				purge_area(829200,1059600,844200,1074600)
				kill_all_in_map(79)
				clear_server_timer("ejderi_kescen_1",get_server_timer_arg())
				clear_server_timer("ejderi_kontrol_et_1_1",get_server_timer_arg())
				clear_server_timer("ejderi_kontrol_et_1_2",get_server_timer_arg())
				game.set_event_flag("ejder_kullanimda_1",0)
				game.set_event_flag("ejder_sifresi",0)
				game.set_event_flag("time_11",0)
				forked.warp_all_in_map("79","73","180100","1220400",1)
			else
				-- notice_all("Ejderha odasýnda "..pc.ejder_kontrol(79).." kiþi var.")
				server_timer("ejderi_kontrol_et_1_1",30)
			end
		end
		
		
		when ejderi_kontrol_et_2_1.server_timer begin
			if pc.ejder_kontrol(79) == 0 and game.get_event_flag("ejder_oldu") == 0 then
				notice_all("CH2: Ejderha odasýnda kimse kalmadýðý için oda kapatýlýyor.")
				purge_area(829200,1059600,844200,1074600)
				kill_all_in_map(79)
				clear_server_timer("ejderi_kescen2",get_server_timer_arg())
				clear_server_timer("ejderi_kontrol_et_2_1",get_server_timer_arg())
				clear_server_timer("ejderi_kontrol_et_2_2",get_server_timer_arg())
				game.set_event_flag("ejder_kullanimda2",0)
				game.set_event_flag("ejder_sifresi",0)
				game.set_event_flag("time_12",0)
				forked.warp_all_in_map("79","73","180100","1220400",1)
			else
				-- notice_all("Ejderha odasýnda "..pc.ejder_kontrol(79).." kiþi var.")
				server_timer("ejderi_kontrol_et_2_2",30)
			end
		end
		
		when ejderi_kontrol_et_2_2.server_timer begin
			if pc.ejder_kontrol(79) == 0 and game.get_event_flag("ejder_oldu") == 0 then
				notice_all("CH2: Ejderha odasýnda kimse kalmadýðý için oda kapatýlýyor.")
				purge_area(829200,1059600,844200,1074600)
				kill_all_in_map(79)
				clear_server_timer("ejderi_kescen2",get_server_timer_arg())
				clear_server_timer("ejderi_kontrol_et_2_1",get_server_timer_arg())
				clear_server_timer("ejderi_kontrol_et_2_2",get_server_timer_arg())
				game.set_event_flag("ejder_kullanimda2",0)
				game.set_event_flag("ejder_sifresi",0)
				game.set_event_flag("time_12",0)
				forked.warp_all_in_map("79","73","180100","1220400",1)
			else
				-- notice_all("Ejderha odasýnda "..pc.ejder_kontrol(79).." kiþi var.")
				server_timer("ejderi_kontrol_et_2_1",30)
			end
		end
		
		when 30121.chat."Ejderha Odasýný Ýzle" with pc.get_map_index() == 73 begin
			local saniyekalan1 = (game.get_event_flag("time_11") - get_time())
			local dakikakalan1 = math.ceil(saniyekalan1 / 60)    
			local saniyekalan2 = (game.get_event_flag("time_12") - get_time())
			local dakikakalan2 = math.ceil(saniyekalan2 / 60) 
			if pc.get_channel_id() == 3 or  pc.get_channel_id() == 4 then
				say_title("Sura Ruhu:")
				say("")
				say_orange("Bu Kanallardan izleyici olarak girilmez.")
				return
			elseif pc.is_riding() then
				say_title("Sura Ruhu:")
				say("")
				say_orange("Herhangibi bir binegin üstündeyken  giremezsin.")
				return
			elseif game.get_event_flag("ejder_kullanimda1") == 0 and pc.get_channel_id() == 1 then
				say_title("Sura Ruhu:")
				say("")
				say_orange("Ejderha odasi bos iken izleyici olarak girilmez.")
				return		
			elseif game.get_event_flag("ejder_kullanimda2") == 0 and pc.get_channel_id() == 2 then
				say_title("Sura Ruhu:")
				say("")
				say_orange("Ejderha odasi bos iken izleyici olarak girilmez.")
				return					
			end
			say_title("Sura Ruhu:")
			say("")
			say_orange("Peki, bu kanaldan izleme odasýna gidebilirsiniz.")
			say_orange("Bunun için 10 milyon yang vermeniz gerekiyor.")
			say_orange("Yangý verip içeri girmek ister misiniz?")
			local sec = select("Ejderha Odasýný Ýzlemek Ýstiyorum!","Vazgeçtim")
			if sec == 1 then
				if pc.get_gold() > 10000000 then
					pc.warp_as_observer(843600, 1066900, 79)
					pc.change_money(-10000000)
				else
					say_title("Sura Ruhu:")
					say("")
					say_orange("Yeterli yang bulunamadý.")
				end
			end
		end
		
	end
end