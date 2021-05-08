quest oxevent_manager begin
	state start begin
		when 20011.chat."OX-Yar��mas� " begin
			say_title("Uriel:")
			say("Hey Evet Sen.")
			say("Sen ger�ekten �ok zeki g�r�n�yorsun.")
			say("Yar��man�n ismi Ox Yar��mas�. ") 
			say("Sorular sorulacak cevap vereceksin,")
			say("bilirsen s�priz bir hediye kazanacaks�n.")
			if game.get_event_flag("oxevent_status") == 0 then
				wait()
				say_title("Uriel:")
				say("Yar��maya kat�lmana izin veriyorum.")
				say("�stersen ayr�ca izleyici de olabilirsin.")
				say("Ba�lama zaman� hen�z kararla�t�r�lmad�.")
				say("Zaman geldi�inde seni bilgilendirece�im.")
				say("Tetikte kal!")
			elseif game.get_event_flag("oxevent_status") == 1 then
			pc.setqf("oxkontrolone",get_time()+10)
				wait()
				say_title("Uriel:")
				say("Yar��maya Kat�lmak �stiyormusun? ")
				
				local s = select("Evet ", "Hay�r ", "�zlemek �stiyorum ")
				if s == 1 then
					if get_time() > pc.getqf("oxkontrolone") then
						say_title("Uriel:")
						say("10 saniye doldu �ans�n� tekrar dene.")
						pc.setqf("oxkontrolone",get_time()+0)
						return
					end
					if pc.get_level() < 15 then
					say_title("Uriel:")
					say("OX-Yar��mas�na kat�labilmen i�in en az")
					say("15. seviyede olmal�s�n.")
					say("")
					else
					say_title("Uriel:")
					say("Tamam �imdi seni ���nl�yorum.")
					wait()
					pc.warp(896500, 24600)
					end
				elseif s == 3 then
					say_title("Uriel:")
					say("�zleyici olarak m� kat�lmak istiyorsun?")
					say("Tamam, ���nl�yorum seni.")

					wait()

					pc.warp(896300, 28900)
				end
			elseif game.get_event_flag("oxevent_status") == 2 then
				
				say_title("Uriel:")
				say("Yar��ma ba�lad�, giremezsin!")
				say("Ancak izleyici olarak kat�labilirsin.")

				local s = select("Kat�l", "Kat�lma")
				if s == 1 then
					say_title("Uriel:")
					say("Tamam, ���nl�yorum seni.")

					wait()

					pc.warp(896300, 28900)
				end
			end
		end

		when 20358.chat."OX-Yar��mas� " with pc.is_gm() begin

			local stat = oxevent.get_status()

			if stat == 0 then
				
					say_title("OX �i�ekleri:")
					say("Yar��may� Ba�latmak �stiyormusun?")


				local s = select("Evet", "Hay�r")

				if s == 1 then
					local v = oxevent.open()

					if v == 0 then
						say_title("OX �i�ekleri:")
						say("OX-Yar��mas� zaten etkinle�tirildi.")
					elseif v == 1 then
						say_title("OX �i�ekleri:")
						say("Tebrikler yarisma baslamistir.")

						notice_all("Ox Yar��mas� ba�lad�! Uriel'den giri� yapabilirsin.")
					else
						say_title("OX �i�ekleri:")
						say("OX-Yar��mas� �al��t�r�lamad�.")
					end
				end
			elseif stat == 1 then
					say_title("OX �i�ekleri:")
					say("Ox Yar��mas�nda "..oxevent.get_attender().." Ki�i Var.")
					say("Yar��may� Ba�latmak �stiyormusun?")

					local s = select("Evet", "Hay�r")

					if s == 1 then
						oxevent.close()

						say_title("OX �i�ekleri:")
						say("Giri�ler Kapat�ld�..Yar��ma Ba�lamas� ��in Ayn� ��lemi Yap�n!")
					end
			elseif stat == 2 then

					say_title("OX �i�ekleri:")
					say("Ne Yapmak �stiyorsunuz?")

					local s = select("Yar��may� Ba�latmak", "�tem Vermek", "Yar��may� Sonland�rmak", "Kapat")

					if s == 1 then
						local v = oxevent.quiz(1, 30)

						if v == 0 then
							say_title("OX �i�ekleri:")
							say("Yar��ma Ba�lat�lamad�!")
						elseif v == 1 then
							say_title("OX �i�ekleri:")
							say("Soru Ba�ar�yla G�nderildi!")
						else
							say_title("OX �i�ekleri:")
							say("Zaten bir soru sordunuz!")
						end
					elseif s == 2 then
						say_title("OX �i�ekleri:")
						say("�temin Kodunu Giriniz.")

						local item_vnum = input()

						say_title("OX �i�ekleri:")
						say("�temin Adetini Giriniz.")

						local item_count = input()

						oxevent.give_item(item_vnum, item_count)

						say_title("OX �i�ekleri:")
						say("�tem "..oxevent.get_attender().." Ki�iye Verildi!")
					elseif s == 3 then
						oxevent.end_event()

						notice_all("Ox Yar��mas� sona erdi.")

						say_title("OX �i�ekleri:")
						say("Ox-Yar��mas� bitirildi.!")
					end
			elseif stat == 3 then
					say_title("OX �i�ekleri:")
					say("L�tfen Bekleyiniz.")
				else
					say("Bir hata olu�tu!")
				end
			end
		
		when login begin
			if game.get_event_flag("oxevent_status") == 1 then
				notice("O-X Eventi aktif, hemen yar��maya kat�lmak i�in Uriel'e ula�!")
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

