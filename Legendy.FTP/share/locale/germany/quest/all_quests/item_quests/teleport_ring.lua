quest isinlanma_yuzugu begin
	state start begin
		when 70058.use begin
		say_title("Seyahat Yüzüðü ")
		say_sari("Nereye gitmek istiyorsun?")
		local s = select("Köyler","Orman Bölgeleri","Örümcek Zindaný ","Sürgün Maðarasý ","Diðer Bölgeler","Kapat")
			if s == 1 then
			local ss = select("Kýrmýzý Bayrak 1.Köy (Shinsoo)","Kýrmýzý Bayrak 2.Köy (Shinsoo)","Sarý Bayrak 1.Köy (Chunjo)","Sarý Bayrak 2.Köy (Chunjo)","Mavi Bayrak 1.Köy (Jinno)","Mavi Bayrak 2.Köy (Jinno)","Vazgeç ")
				if ss == 1 then
				pc.warp(474200,954400)
				elseif ss == 2 then
				pc.warp(352900,882500)
				elseif ss == 3 then
				pc.warp(63200,166100)
				elseif ss == 4 then
				pc.warp(145600,239900)
				elseif ss == 5 then
				pc.warp(960100,268700)
				elseif ss == 6 then
				pc.warp(863900,245900)
				end
			elseif s == 2 then
			local sss = select("Hayalet Orman","Kýzýl Orman Baþlangýcý ","Kýzýl Orman Sonu","Vazgeç ")
				if sss == 1 then
				if pc.get_level() >= 60 then
				pc.warp(288700,5700)
				else
				syschat("Bu bölgeye ýþýnlanabilmek için 60 level olmalýsýn. ")
				end
				elseif sss == 2 then
				if pc.get_level() >= 60 then
				pc.warp(1119900,70800)
				else
				syschat("Bu bölgeye ýþýnlanabilmek için 60 level olmalýsýn. ")
				end
				elseif sss == 3 then
				if pc.get_level() >= 60 then
				pc.warp(1118100,8600)
				else
				syschat("Bu bölgeye ýþýnlanabilmek için 60 level olmalýsýn. ")
				end
				end
			elseif s == 3 then
			local zindan = select("Örümcek Zindaný 1. Kat Baþý ","Örümcek Zindaný 1. Kat Sonu","Örümcek Zindaný 2. Kat Baþý ","Örümcek Zindaný 2. Kat Sonu","Vazgeç ")
				if zindan == 1 then
				pc.warp(59800,497300)
				elseif zindan == 2 then
				pc.warp(92300,525500)	
				elseif zindan == 3 then
				if pc.get_level() >= 30 then
				pc.warp(704100,464000)
				else
				syschat("Bu bölgeye ýþýnlanabilmek için 30 level olmalýsýn. ")
				end
				elseif zindan == 4 then
				if pc.get_level() >= 30 then
				pc.warp(704100,521900)	
				else
				syschat("Bu bölgeye ýþýnlanabilmek için 30 level olmalýsýn. ")
				end
				end
			elseif s == 4 then
			say_title ("Merhaba "..pc.get_name())
		say_sari("Bu bölgeye gitmek istediðine emin misin? ")
		local secimyap = select("Evet ","Hayýr ")
		if secimyap == 1 then
		say_yesil ( "Sürgün maðarasý giriþine ýþýnlanýyorsun." ) 
		wait ( )
		pc.warp(284400,810700)
		end
			elseif s == 6 then
			local sssssss = select("Seungryong Vadisi","Sohan Daðý ","Yongbi Çölü ","Doyyumhwan","Devler Diyarý ","Þeytan Kulesi","Vazgeç ")
				if sssssss == 1  then
				if game.get_event_flag("defend_and_destroy") == 1 then
				if pc.get_empire() == 1 then
				pc.warp(402100,673900)
				elseif pc.get_empire() == 2 then
				pc.warp(270400 ,739900)
				elseif pc.get_empire() == 3 then
				pc.warp(321300,808000)
				end
				else
				pc.warp(336000,755600)
				end
				elseif sssssss == 2 then
				if game.get_event_flag("defend_and_destroy") == 1 then
				if pc.get_empire() == 1 then
				pc.warp(434200,290600)
				elseif pc.get_empire() == 2 then
				pc.warp(375200,174900)
				elseif pc.get_empire() == 3 then
				pc.warp(491800,173600)
				end
				else
				pc.warp(436400,215600)
				end
				elseif sssssss == 3 then
				if game.get_event_flag("defend_and_destroy") == 1 then
				if pc.get_empire() == 1 then
				pc.warp(217800,627200)
				elseif pc.get_empire() == 2 then
				pc.warp(221900,502700)
				elseif pc.get_empire() == 3 then
				pc.warp(344000,502500)
				end
				else
				pc.warp(296800,547400)
				end
				elseif sssssss == 4 then
				if game.get_event_flag("defend_and_destroy") == 1 then
				if pc.get_empire() == 1 then
				pc.warp(599400,756300)
				elseif pc.get_empire() == 2 then
				pc.warp(597800,622200)
				elseif pc.get_empire() == 3 then
				pc.warp(730700,689800)
				end
				else
				pc.warp(600800,687400)
				end
				elseif sssssss == 5 then
				pc.warp(829900,763300)
				elseif sssssss == 6 then
				pc.warp(590500,110500)
				elseif sssssss == 7 then
				return
				end
			elseif s == 7 then
			return
			end
		end
	end
end