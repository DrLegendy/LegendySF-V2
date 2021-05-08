quest oxevent_manager begin
	state start begin
		when 20011.chat."OX-Yarýþmasý " begin
			say_title("Uriel:")
			say("Hey Evet Sen.")
			say("Sen gerçekten çok zeki görünüyorsun.")
			say("Yarýþmanýn ismi Ox Yarýþmasý. ") 
			say("Sorular sorulacak cevap vereceksin,")
			say("bilirsen süpriz bir hediye kazanacaksýn.")
			if game.get_event_flag("oxevent_status") == 0 then
				wait()
				say_title("Uriel:")
				say("Yarýþmaya katýlmana izin veriyorum.")
				say("Ýstersen ayrýca izleyici de olabilirsin.")
				say("Baþlama zamaný henüz kararlaþtýrýlmadý.")
				say("Zaman geldiðinde seni bilgilendireceðim.")
				say("Tetikte kal!")
			elseif game.get_event_flag("oxevent_status") == 1 then
			pc.setqf("oxkontrolone",get_time()+10)
				wait()
				say_title("Uriel:")
				say("Yarýþmaya Katýlmak Ýstiyormusun? ")
				
				local s = select("Evet ", "Hayýr ", "Ýzlemek Ýstiyorum ")
				if s == 1 then
					if get_time() > pc.getqf("oxkontrolone") then
						say_title("Uriel:")
						say("10 saniye doldu þansýný tekrar dene.")
						pc.setqf("oxkontrolone",get_time()+0)
						return
					end
					if pc.get_level() < 15 then
					say_title("Uriel:")
					say("OX-Yarýþmasýna katýlabilmen için en az")
					say("15. seviyede olmalýsýn.")
					say("")
					else
					say_title("Uriel:")
					say("Tamam þimdi seni ýþýnlýyorum.")
					wait()
					pc.warp(896500, 24600)
					end
				elseif s == 3 then
					say_title("Uriel:")
					say("Ýzleyici olarak mý katýlmak istiyorsun?")
					say("Tamam, ýþýnlýyorum seni.")

					wait()

					pc.warp(896300, 28900)
				end
			elseif game.get_event_flag("oxevent_status") == 2 then
				
				say_title("Uriel:")
				say("Yarýþma baþladý, giremezsin!")
				say("Ancak izleyici olarak katýlabilirsin.")

				local s = select("Katýl", "Katýlma")
				if s == 1 then
					say_title("Uriel:")
					say("Tamam, ýþýnlýyorum seni.")

					wait()

					pc.warp(896300, 28900)
				end
			end
		end

		when 20358.chat."OX-Yarýþmasý " with pc.is_gm() begin

			local stat = oxevent.get_status()

			if stat == 0 then
				
					say_title("OX Çiçekleri:")
					say("Yarýþmayý Baþlatmak Ýstiyormusun?")


				local s = select("Evet", "Hayýr")

				if s == 1 then
					local v = oxevent.open()

					if v == 0 then
						say_title("OX Çiçekleri:")
						say("OX-Yarýþmasý zaten etkinleþtirildi.")
					elseif v == 1 then
						say_title("OX Çiçekleri:")
						say("Tebrikler yarisma baslamistir.")

						notice_all("Ox Yarýþmasý baþladý! Uriel'den giriþ yapabilirsin.")
					else
						say_title("OX Çiçekleri:")
						say("OX-Yarýþmasý çalýþtýrýlamadý.")
					end
				end
			elseif stat == 1 then
					say_title("OX Çiçekleri:")
					say("Ox Yarýþmasýnda "..oxevent.get_attender().." Kiþi Var.")
					say("Yarýþmayý Baþlatmak Ýstiyormusun?")

					local s = select("Evet", "Hayýr")

					if s == 1 then
						oxevent.close()

						say_title("OX Çiçekleri:")
						say("Giriþler Kapatýldý..Yarýþma Baþlamasý Ýçin Ayný Ýþlemi Yapýn!")
					end
			elseif stat == 2 then

					say_title("OX Çiçekleri:")
					say("Ne Yapmak Ýstiyorsunuz?")

					local s = select("Yarýþmayý Baþlatmak", "Ýtem Vermek", "Yarýþmayý Sonlandýrmak", "Kapat")

					if s == 1 then
						local v = oxevent.quiz(1, 30)

						if v == 0 then
							say_title("OX Çiçekleri:")
							say("Yarýþma Baþlatýlamadý!")
						elseif v == 1 then
							say_title("OX Çiçekleri:")
							say("Soru Baþarýyla Gönderildi!")
						else
							say_title("OX Çiçekleri:")
							say("Zaten bir soru sordunuz!")
						end
					elseif s == 2 then
						say_title("OX Çiçekleri:")
						say("Ýtemin Kodunu Giriniz.")

						local item_vnum = input()

						say_title("OX Çiçekleri:")
						say("Ýtemin Adetini Giriniz.")

						local item_count = input()

						oxevent.give_item(item_vnum, item_count)

						say_title("OX Çiçekleri:")
						say("Ýtem "..oxevent.get_attender().." Kiþiye Verildi!")
					elseif s == 3 then
						oxevent.end_event()

						notice_all("Ox Yarýþmasý sona erdi.")

						say_title("OX Çiçekleri:")
						say("Ox-Yarýþmasý bitirildi.!")
					end
			elseif stat == 3 then
					say_title("OX Çiçekleri:")
					say("Lütfen Bekleyiniz.")
				else
					say("Bir hata oluþtu!")
				end
			end
		
		when login begin
			if game.get_event_flag("oxevent_status") == 1 then
				notice("O-X Eventi aktif, hemen yarýþmaya katýlmak için Uriel'e ulaþ!")
			end
		end
		
		when login with pc.get_map_index() == 113 and not pc.is_gm() begin
			if pc.is_mount() then
				pc.unmount()
				horse.unsummon()
			end
		end
	end
end

