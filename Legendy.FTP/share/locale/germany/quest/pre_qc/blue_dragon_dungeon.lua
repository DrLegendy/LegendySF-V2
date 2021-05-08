quest kristal_oda begin
	state start begin
		when logout begin
			if pc.get_map_index() == 79 then
				pc.delqf("icerdesin1")
				pc.delqf("icerdesin2")
				pc.delqf("lider")
			end
		end
		when 30121.chat."Ejderhay� �ld�rmek istiyorum!" with pc.get_map_index() == 73 and pc.get_channel_id() == 1 or pc.get_channel_id() == 2 begin
		if pc.get_channel_id() == 2 then
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 2 and game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time() > 0 then
				say_title("Sura Ruhu:")
				say("")
				say("�zg�n�m Ejderha Tap�na�� �uan dolu.")
				say("Kalan s�re: "..game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time().." saniye")
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
				say("Gerekli e�ya 3x: "..item_name(30179)..":")
				say_item_vnum(30179)
				say("3 adet anahtara ihtiyac�n var.")
				return
			end
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 1 then
				pc.setqf("ejder_bug_engel2",get_time()+5)
				say_title("Sura Ruhu:")
				say("")
				say("�zg�n�m Ejderha Tap�na�� �uan dolu.")
				say("E�er �ifreyi biliyorsan,")
				say("do�ru bir �ekilde yaz.")
				say("")
				say_reward("5 saniye s�ren var!")
				say("")
			local pin = tonumber(input(""))
				if get_time() > pc.getqf("ejder_bug_engel2") then
					say_title("Sura Ruhu:")
					say("5 saniye doldu �ans�n� tekrar dene.")
					pc.setqf("ejder_bug_engel2",get_time()+0)
					return
				end
				if string.len(pin) < 4 then
					say_title("Sura Ruhu:")
					say("")
					say("�ifre en az 4 karakterden olu�mal�.")
					return
					end
				if game.get_event_flag("ejder_sifresi"..pc.get_channel_id().."") == pin then
					say_title("Sura Ruhu:")
					say("")
						if pc.count_item(30179) < 3 then
							say("Girmene izin veremem.")
							say("Gerekli e�ya 3x: "..item_name(30179)..":")
							say_item_vnum(30179)
							say("3 tane anahtara sahip oldu�unda tekrar gel.")
							return
						end
					pc.remove_item("30179",3)
					say("�ifre do�ru tebrikler!")
					say("Seni i�eri g�nderiyorum. Onu yenmeden d�nme!")
					pc.setqf("icerdesin"..pc.get_channel_id().."",1)
					wait()
					pc.warp(843600,1066900)
				elseif pin != game.get_event_flag("ejder_sifresi"..pc.get_channel_id().."") then
					say_title("Sura Ruhu:")
					say("�zg�n�m �ifreyi hatal� girdin.")
					return
				end
			end
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 and pc.count_item(30179) >= 3 then
			say_title("Sura Ruhu:")
			say("Ejderha Tap�na��'na girmek isteyen ilk ki�i")
			say("sensin. Yeterli say�da K�vr�k Anahtara sahipsen")
			say("seni i�eri b�rakaca��m. Ama ilk �nce bir �ifre")
			say("belirleyeceksin. Bu �ifreyi, 5 dakika")
			say("i�erisinde sava� arkada�lar�na verip onlar�n")
			say("i�eri girmesini sa�layabilirsin. Bu anahtar�n")
			say("sadece 30 dakika tesir edece�ini unutma. O zamana")
			say("kadar ejderhay� �ld�rm�� olman�z gerekiyor!")
			say("")
			pc.setqf("ejder_bug_engel3",get_time()+5)
			local i = select("Haz�r�m!", "Vazge� ")
				if get_time() > pc.getqf("ejder_bug_engel3") then
					say_title("Sura Ruhu:")
					say("5 saniye doldu �ans�n� tekrar dene.")
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
						say_reward("Yazman gereken �ifre : "..pin)
						say_reward("5 saniye s�ren var!")
					local giris = tonumber ( input ( "" ) )
					if get_time() > pc.getqf("ejder_bug_engel3") then
									say_title("Sura Ruhu:")
									say("5 saniye doldu �ans�n� tekrar dene.")
									pc.setqf("ejder_bug_engel3",get_time()+0)
									return
								end
					if giris != pin then
					say_title("Sura Ruhu:")
					say("")
					say_red("Malesef, Yanl�� yazd�n.")
					return
					end

					if pin and pin <= 999999999 and pc.count_item(30179)>=3 then
					say_title("Sura Ruhu:")
					say("")
					say("Arzu edersen seni do�rudan Ejderha Ma�aras�'na")
					say("g�t�rebilirim. Bana �imdi vermen gerekenler:")
					say("3x:")
					say_item_vnum(30179)
					pc.setqf("ejder_bug_engel3",get_time()+5)
					local zaxd = select("Al ve beni i�eri b�rak!","Vazge� ")
					if get_time() > pc.getqf("ejder_bug_engel3") then
								say_title("Sura Ruhu:")
								say("5 saniye doldu �ans�n� tekrar dene.")
								pc.setqf("ejder_bug_engel3",get_time()+0)
								return
							end
						if zaxd == 2 then
						return
						elseif zaxd == 1 and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 then
							if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") != 0 then
							syschat("Ejderha odas�na ba�ka bir grup girdi.")
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
						say("Birileri senden �nce davrand�. Onlar�n")
						say("odadan ��kmalar�n� bekle ya da parolay� ")
						say("biliyorsan s�yle.")
						end
					else 
					say_title("Sura Ruhu:")
					say("")
					say("Bir hata olu�tu.")
					say("")
					end
				end
			end
			
			elseif pc.get_channel_id() == 1 then
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 2 and game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time() > 0 then
				say_title("Sura Ruhu:")
				say("")
				say("�zg�n�m Ejderha Tap�na�� �uan dolu.")
				say("Kalan s�re: "..game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time().." saniye")
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
				say("Gerekli e�ya 3x: "..item_name(30179)..":")
				say_item_vnum(30179)
				say("3 adet anahtara ihtiyac�n var.")
				return
			end
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 1 then
				pc.setqf("ejder_bug_engel2",get_time()+5)
				say_title("Sura Ruhu:")
				say("")
				say("�zg�n�m Ejderha Tap�na�� �uan dolu.")
				say("E�er �ifreyi biliyorsan,")
				say("do�ru bir �ekilde yaz.")
				say("")
				say_reward("5 saniye s�ren var!")
				say("")
			local pin = tonumber(input(""))
				if get_time() > pc.getqf("ejder_bug_engel2") then
					say_title("Sura Ruhu:")
					say("5 saniye doldu �ans�n� tekrar dene.")
					pc.setqf("ejder_bug_engel2",get_time()+0)
					return
				end
				if string.len(pin) < 4 then
					say_title("Sura Ruhu:")
					say("")
					say("�ifre en az 4 karakterden olu�mal�.")
					return
					end
				if game.get_event_flag("ejder_sifresi"..pc.get_channel_id().."") == pin then
					say_title("Sura Ruhu:")
					say("")
						if pc.count_item(30179) < 3 then
							say("Girmene izin veremem.")
							say("Gerekli e�ya 3x: "..item_name(30179)..":")
							say_item_vnum(30179)
							say("3 tane anahtara sahip oldu�unda tekrar gel.")
							return
						end
					pc.remove_item("30179",3)
					say("�ifre do�ru tebrikler!")
					say("Seni i�eri g�nderiyorum. Onu yenmeden d�nme!")
					pc.setqf("icerdesin"..pc.get_channel_id().."",1)
					wait()
					pc.warp(843600,1066900)
				elseif pin != game.get_event_flag("ejder_sifresi"..pc.get_channel_id().."") then
					say_title("Sura Ruhu:")
					say("�zg�n�m �ifreyi hatal� girdin.")
					return
				end
			end
			if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 and pc.count_item(30179) >= 3 then
			say_title("Sura Ruhu:")
			say("Ejderha Tap�na��'na girmek isteyen ilk ki�i")
			say("sensin. Yeterli say�da K�vr�k Anahtara sahipsen")
			say("seni i�eri b�rakaca��m. Ama ilk �nce bir �ifre")
			say("belirleyeceksin. Bu �ifreyi, 5 dakika")
			say("i�erisinde sava� arkada�lar�na verip onlar�n")
			say("i�eri girmesini sa�layabilirsin. Bu anahtar�n")
			say("sadece 30 dakika tesir edece�ini unutma. O zamana")
			say("kadar ejderhay� �ld�rm�� olman�z gerekiyor!")
			say("")
			pc.setqf("ejder_bug_engel3",get_time()+5)
			local i = select("Haz�r�m!", "Vazge� ")
				if get_time() > pc.getqf("ejder_bug_engel3") then
					say_title("Sura Ruhu:")
					say("5 saniye doldu �ans�n� tekrar dene.")
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
						say_reward("Se�men gereken �ifre : "..pin)
						say_reward("5 saniye s�ren var!")
						local sifre = select("Vazge� ",pin1,pin2,pin3,pin4,pin5,pin6)
						if get_time() > pc.getqf("ejder_bug_engel2") then
							say_title("Sura Ruhu:")
							say("5 saniye doldu �ans�n� tekrar dene.")
							pc.setqf("ejder_bug_engel2",get_time()+0)
							return
						end
						if sifre == gercek and pc.count_item(30179)>=3 then
							say_title("Sura Ruhu:")
							say("")
							say("Arzu edersen seni do�rudan Ejderha Ma�aras�'na")
							say("g�t�rebilirim. Bana �imdi vermen gerekenler:")
							say("3x:")
							say_item_vnum(30179)
							say_reward("5 saniye s�ren var!")
							pc.setqf("ejder_bug_engel3",get_time()+5)
							local zaxd = select("Al ve beni i�eri b�rak!","Vazge� ")
							if get_time() > pc.getqf("ejder_bug_engel3") then
								say_title("Sura Ruhu:")
								say("5 saniye doldu �ans�n� tekrar dene.")
								pc.setqf("ejder_bug_engel3",get_time()+0)
								return
							end
							if zaxd == 2 then
						return
						elseif zaxd == 1 and game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") == 0 then
							if game.get_event_flag("ejder_kullanimda"..pc.get_channel_id().."") != 0 then
							syschat("Ejderha odas�na ba�ka bir grup girdi.")
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
						say("Birileri senden �nce davrand�. Onlar�n")
						say("odadan ��kmalar�n� bekle ya da parolay� ")
						say("biliyorsan s�yle.")
						end
					else 
					say_title("Sura Ruhu:")
					say("")
					say("Bir hata olu�tu.")
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
				send_letter("Mavi Ejderha'y� ma�lup edin")
			end
		end
		when button or info begin
			q.set_clock("Kalan s�re:", game.get_event_flag("time_1"..pc.get_channel_id().."")-get_time())
			kristal_oda.ejder_odasi_kalansure()
		end
		when login with pc.get_map_index() == 79 and pc.getqf("icerdesin"..pc.get_channel_id().."") != 1 begin
			pc.warp(180100,1220400)
		end
		when login with pc.get_map_index() == 79 and pc.getqf("lider") == 1 begin
			notice_all("CH "..pc.get_channel_id()..": "..pc.get_name().." grubu, Mavi Ejderha'y� �ld�rmeye �al���yor!")
			notice(""..pc.getqf("ejder_sifre").." numaral� �ifreyi da��tmaya 5 dakika zaman�n")
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
			notice_all("CH "..pc.get_channel_id()..": "..pc.get_name().." grubu, Mavi Ejderha'y� �ld�rd�!")
			game.set_event_flag("time_1"..pc.get_channel_id().."",get_time() + 30)
			clear_server_timer("ejderi_kescen"..pc.get_channel_id().."",get_server_timer_arg())
			server_timer("disari_yolluyoz"..pc.get_channel_id().."",30, pc.get_map_index()) ---300 olcak
			forked.warp_all_in_map("79","73","180100","1220400",295)
		end
		when sifre_kapat1.server_timer begin
			game.set_event_flag("ejder_kullanimda1",2)
		end
		when disari_yolluyoz1.server_timer begin
			notice_all("CH 1: Mavi Ejderha geri d�nd�!")
			game.set_event_flag("kesilen_metin1",0)
			purge_area(829200,1059600,844200,1074600)
			clear_server_timer("ejderi_kescen1",get_server_timer_arg())
			game.set_event_flag("ejder_kullanimda1",0)
			forked.warp_all_in_map("79","73","180100","1220400",1)
		end
		when ejderi_kescen1.server_timer with game.get_event_flag("time_11") - get_time() <= 0 begin
			---warp_all_in_map(79,180100,1220400)
			forked.warp_all_in_map("79","73","180100","1220400",1)
			notice_all("CH 1: Mavi Ejderha h�l� ya��yor!")
			purge_area(829200,1059600,844200,1074600)
			game.set_event_flag("kesilen_metin1",0)
			game.set_event_flag("ejder_kullanimda1",0)
		end
		when sifre_kapat2.server_timer begin
			game.set_event_flag("ejder_kullanimda2",2)
		end
		when disari_yolluyoz2.server_timer begin
			notice_all("CH 2: Mavi Ejderha geri d�nd�!")
			game.set_event_flag("kesilen_metin2",0)
			purge_area(829200,1059600,844200,1074600)
			clear_server_timer("ejderi_kescen2",get_server_timer_arg())
			game.set_event_flag("ejder_kullanimda2",0)
			forked.warp_all_in_map("79","73","180100","1220400",1)
		end
		when ejderi_kescen2.server_timer with game.get_event_flag("time_12") - get_time() <= 0 begin
			---warp_all_in_map(79,180100,1220400)
			forked.warp_all_in_map("79","73","180100","1220400",1)
			notice_all("CH 2: Mavi Ejderha h�l� ya��yor!")
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
		when 30121.chat."S�reyi s�f�rla" with pc.is_gm() begin
			say_title("Sura Ruhu;")
			say("S�f�rlamak istedi�inden emin misin ?")
			local cyvercha = select("Evet","Hay�r")
			if cyvercha == 2 then
				return
			elseif cyvercha == 1 then
				notice_all("CH "..pc.get_channel_id()..": Kristal oda s�resi s�f�rlanm��t�r.")
				game.set_event_flag("time_1"..pc.get_channel_id().."",get_time() + 30)
				clear_server_timer("ejderi_kescen"..pc.get_channel_id().."",get_server_timer_arg())
				server_timer("disari_yolluyoz"..pc.get_channel_id().."",30, pc.get_map_index()) ---300 olcak
				forked.warp_all_in_map("79","73","180100","1220400",295)
			end
		end
		function ejder_odasi_kalansure()
			local saniyekalan = (game.get_event_flag("time_1"..pc.get_channel_id().."") - get_time())
			local dakikakalan = math.ceil(saniyekalan / 60)	
			notice("Mavi Ejderha'y� �ld�rmeye "..dakikakalan.." dakikal�k bir zaman")
			notice("kald�!")	 
		end	
		
		when 30121.chat."Ejderha Odas� Durumu" with pc.get_map_index() == 73 begin
				local saniyekalan1 = (game.get_event_flag("time_11") - get_time())
				local dakikakalan1 = math.ceil(saniyekalan1 / 60)    
				local saniyekalan2 = (game.get_event_flag("time_12") - get_time())
				local dakikakalan2 = math.ceil(saniyekalan2 / 60)    
				say_title("Sura Ruhu:")
				say("")
				say("�uan ejderha odas�na girece�in aktif kanallar:")	
				if game.get_event_flag("ejder_kullanimda1") != 0 and dakikakalan1 > 0 then
					say_green("CH1:Ejderha odas� (Dolu)")
				else
					say_yellow("CH1:Ejderha odas� (Bo�)")
				end
				if game.get_event_flag("ejder_kullanimda2") != 0 and dakikakalan2 > 0 then
					say_green("CH2:Ejderha odas� (Dolu)")
				else
					say_yellow("CH2:Ejderha odas� (Bo�)")
				end
				say_reward("CH3:Ejderha odas�na giri�ler kapal�.")		
				say_reward("CH4:Ejderha odas�na giri�ler kapal�.")				
				say("")
		end
		
		when ejderi_kontrol_et_1_1.server_timer begin
			if pc.ejder_kontrol(79) == 0 and game.get_event_flag("ejder_oldu") == 0 then
				notice_all("CH1: Ejderha odas�nda kimse kalmad��� i�in oda kapat�l�yor.")
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
				-- notice_all("Ejderha odas�nda "..pc.ejder_kontrol(79).." ki�i var.")
				server_timer("ejderi_kontrol_et_1_2",30)
			end
		end
		
		when ejderi_kontrol_et_1_2.server_timer begin
			if pc.ejder_kontrol(79) == 0 and game.get_event_flag("ejder_oldu") == 0 then
				notice_all("CH1: Ejderha odas�nda kimse kalmad��� i�in oda kapat�l�yor.")
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
				-- notice_all("Ejderha odas�nda "..pc.ejder_kontrol(79).." ki�i var.")
				server_timer("ejderi_kontrol_et_1_1",30)
			end
		end
		
		
		when ejderi_kontrol_et_2_1.server_timer begin
			if pc.ejder_kontrol(79) == 0 and game.get_event_flag("ejder_oldu") == 0 then
				notice_all("CH2: Ejderha odas�nda kimse kalmad��� i�in oda kapat�l�yor.")
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
				-- notice_all("Ejderha odas�nda "..pc.ejder_kontrol(79).." ki�i var.")
				server_timer("ejderi_kontrol_et_2_2",30)
			end
		end
		
		when ejderi_kontrol_et_2_2.server_timer begin
			if pc.ejder_kontrol(79) == 0 and game.get_event_flag("ejder_oldu") == 0 then
				notice_all("CH2: Ejderha odas�nda kimse kalmad��� i�in oda kapat�l�yor.")
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
				-- notice_all("Ejderha odas�nda "..pc.ejder_kontrol(79).." ki�i var.")
				server_timer("ejderi_kontrol_et_2_1",30)
			end
		end
		
		when 30121.chat."Ejderha Odas�n� �zle" with pc.get_map_index() == 73 begin
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
				say_orange("Herhangibi bir binegin �st�ndeyken  giremezsin.")
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
			say_orange("Peki, bu kanaldan izleme odas�na gidebilirsiniz.")
			say_orange("Bunun i�in 10 milyon yang vermeniz gerekiyor.")
			say_orange("Yang� verip i�eri girmek ister misiniz?")
			local sec = select("Ejderha Odas�n� �zlemek �stiyorum!","Vazge�tim")
			if sec == 1 then
				if pc.get_gold() > 10000000 then
					pc.warp_as_observer(843600, 1066900, 79)
					pc.change_money(-10000000)
				else
					say_title("Sura Ruhu:")
					say("")
					say_orange("Yeterli yang bulunamad�.")
				end
			end
		end
		
	end
end