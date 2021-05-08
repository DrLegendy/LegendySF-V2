quest energy_system begin
	state start begin
		when 20001.chat."Yeni bir teknik!" begin
		say_title("Simyac� ")
		say("Ba�ard�m!")
		say("Nihayet yepyeni bir teknik geli�tirebildim.")
		say("E�yalar� tekrar i�leyerek onlardan saf enerji")
		say("elde etmenin yolunu buldum. Ne �ahane!")
		wait()
		say_title("Simyac� ")
		say("E�ya, benim buldu�um teknikle tahrip edilir ve")
		say("enerji par�alar�na ayr�l�r. Bu par�alar�n 30")
		say("tanesi birle�tirilince de g��l� bir enerji")
		say("kristali elde edilir! Bir m�cevher i�erisinde")
		say("toplanm�� saf ve filtrelenmemi� bir enerji. Bu")
		say("g�� tam te�hizat�na i�ler.")
		say("�lgini �ekiyor mu?")
		wait()
		say_title("Simyac� ")
		say("Avlan�rken buldu�un silah, tak� ve k�yafet gibi")
		say("te�hizat malzemelerini bana getir. Onlar� i�leyip")
		say("enerji par�alar�na ay�raca��m. Krall���m�z�n")
		say("gelece�i ve umudu bu tekni�e ba�l�. Yenilmez")
		say("olaca��z!")
		set_state(energy_start)
		end
	end

	state energy_start begin
		function setting () 
			return
			{
				["prob_acc_table"] = 
				{
					["35to50"] = {30,55,70,80,90,95,97,98,99,100},
					["51to70"] = {20,40,60,75,85,91,96,98,99,100},
					["upto70"] = {10,25,45,65,80,88,94,97,99,100}
				},
				["item_num_table"] ={0,1,2,3,4,6,8,10,12,15},
				["energy_stone"] = 51001,
				["charging_stone"] = 51002,
			}
		end	
		function getItemNum ( str, r )
			local setting = energy_system.setting()
			for i = 1, 10 do
				if r < setting.prob_acc_table[str][i] then
					return setting.item_num_table[i]
				end
			end
			return 0
		end

		when 20001.chat."Enerji par�as� elde et" begin
		say_title("Simyac� ")
		say("Yapabildin mi? Enerji par�as� elde edebildin mi?")
		say("Simya yard�m�yla par�alayabilece�im daha fazla")
		say("e�ya getir bana. Tekni�im hen�z m�kemmelle�medi.")
		say("Bu y�zden ne kadar par�a elde edebilece�ine dair")
		say("bir garanti veremeyece�im.")
		wait()
		say_title("Simyac� ")
		say("Tek bir �art var: Kendi seviyen ve e�yan�n")
		say("seviyesi en az 35 olmal�. H�m, bir g�z atal�m")
		say("bakal�m...")
		wait()
			if pc.get_level() >= 35 then
			say_title("Simyac� ")
			say("Ah s�per! G��l� ve tecr�belisin. ��lenecek e�yay� ")
			say("ver bakal�m.")
			else
			say_title("Simyac� ") 
			say("Hen�z yeterince g��l� de�ilsin! En az 35.") 
			say("seviyeye ula�t���nda tekrar gel.") 
			end
		end

		when 20001.take begin
			if pc.get_level() < 35 then 
				say_title("Simyac� ") 
				say("Hen�z yeterince g��l� de�ilsin! En az 35.") 
				say("seviyeye ula�t���nda tekrar gel.") 
				return
			end
			local item_vnum = item.vnum
			local levelLimit = item.get_level_limit(item_vnum)
			local setting = energy_system.setting()
			if levelLimit == nil then
				say_title("Simyac� ")
				say("Bu e�ya benim tekni�im i�in elveri�li de�il. Bana")
				say("ba�ka bir �ey getir.")
				wait()
			elseif item.get_type() == ITEM_WEAPON and item.get_sub_type() == WEAPON_ARROW then
				say_title("Simyac� ")
				say("Bu e�ya benim tekni�im i�in elveri�li de�il. Bana")
				say("ba�ka bir �ey getir.")
				wait()
			elseif levelLimit < 35 then
				-- kind of impossible condition?
				say_title("Simyac� ")
				say("Bu e�ya benim tekni�im i�in elveri�li de�il. Bana")
				say("ba�ka bir �ey getir.")
			else
				say_title(mob_name(20001))
				say(item_name(item_vnum))
				say("Bu e�yay� tahrip edeyim mi?")
				local s = select("Evet","Hay�r, �imdi etme!")
				if s == 1 then
					item.remove()
					local r = number (1, 100)
					local n
					if levelLimit >= 40 and levelLimit <= 50 then
						n = energy_system.getItemNum ("35to50",r)
					elseif levelLimit > 50 and levelLimit <= 70 then
						n = energy_system.getItemNum ("51to70",r)
					else
						n = energy_system.getItemNum ("upto70",r)
					end
					if (n == 0) then
						say_title("Simyac� ")
						say("Ba�aramad�m. �zg�n�m bu sefer olmad�.")
					else
						pc.give_item2(setting.energy_stone, n)
						say_title("Simyac� ") 
						say("Efsanevi! "..n.." enerji par�as� buldum. ��te buyur.")
						say("")
					end
				end
			end
		end

		when 20001.chat."Enerji kristali �ret" begin
			local setting = energy_system.setting()
			local need = 30
			say_title("Simyac� ")
			say("Yapabildin mi? Enerji par�as� elde edebildin mi?")
			say("Simya yard�m�yla par�alayabilece�im daha fazla")
			say("e�ya getir bana. Tekni�im hen�z m�kemmelle�medi.")
			say("Bu y�zden ne kadar par�a elde edebilece�ine dair")
			say("bir garanti veremeyece�im.")
			wait()
			say_title("Simyac� ")
			say("Tek bir �art var: Kendi seviyen ve e�yan�n")
			say("seviyesi en az 35 olmal�. H�m, bir g�z atal�m")
			say("bakal�m...")
			wait()
			if pc.get_level() < 35 then 
				say_title("Simyac� ") 
				say("Hen�z yeterince g��l� de�ilsin! En az 35.") 
				say("seviyeye ula�t���nda tekrar gel.")
				return
			end
			
			if pc.count_item (setting.energy_stone) < need then
				say_title("Simyac� ")
				say("30 tane Enerji Par�as� gerekiyor. Yoksa")
				say("Enerji Kristalini �retemem.")
				return
			else
				say_title("Simyac� ")
				say("G�zel. Laz�m olan 30 enerji par�as�n� getirdin.")
				say("Bunlardan bir enerji kristali �retebilirim. Biraz")
				say("bekle l�tfen. Deneyece�im ama olaca��na dair")
				say("garanti veremem.")
				wait()
			end
			
			local charge = 1000
			say_title("Simyac� ")
			say("Her �ey haz�r durumda. Par�alar� birle�tirip")
			say("enerji kristali �retebiliriz. Ama ben de bir")
			say("�ekilde ekme�imi kazanmal�y�m. Tamir aletleri de")
			say("g�kten inmiyor yani. Masraflar� kar��lamak i�in")
			say("1000 yang �demeni istiyorum. �demeye")
			say("haz�r m�s�n?")
			local s = select("Elbette!","Hay�r, hen�z de�il.")
			if s == 2 then
				return
			end

			if pc.get_gold() < charge then
				say_title("Simyac� ")
				say("Yeteri kadar yang yok. Bu �artlarda kristal")
				say("�retemeyiz.")
				return
			end

			pc.change_gold (-charge)
			pc.remove_item (setting.energy_stone, need)

			if pc.getqf ("hasExperience") == 0 then
				say_title("Simyac� ")
				say("��te enerji kristalin. Sadece ilk giri�imde")
				say("ba�ar�l� olunur hep. Simya, sa�� solu belli")
				say("olmayan bir bilim. Ufak tefek farkl�l�klar")
				say("ba�ar�s�zl��a neden olabilir! Yani deneylerde")
				say("genelde k���k de olsa ba�ar�s�zl��a u�rama riski")
				say("bulunur.")
				pc.give_item2 (setting.charging_stone, 1)
				pc.setqf ("hasExperience", 1);
				return
			end

			local r = number (1, 100)
			if r > 30 then
				say_title("Simyac� ")
				say("Ba�aramad�m. �zg�n�m bu sefer olmad�.")
				return
			end
			say_title("Simyac� ")
			say("Ba�ard�m! ��te enerji kristalin.")
			pc.give_item2 (setting.charging_stone, 1)
					
--			setskin(NOWINDOW)
--			command("cube open")
		end
	end
end

