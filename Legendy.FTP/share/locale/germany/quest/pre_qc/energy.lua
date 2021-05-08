quest energy_system begin
	state start begin
		when 20001.chat."Yeni bir teknik!" begin
		say_title("Simyacý ")
		say("Baþardým!")
		say("Nihayet yepyeni bir teknik geliþtirebildim.")
		say("Eþyalarý tekrar iþleyerek onlardan saf enerji")
		say("elde etmenin yolunu buldum. Ne þahane!")
		wait()
		say_title("Simyacý ")
		say("Eþya, benim bulduðum teknikle tahrip edilir ve")
		say("enerji parçalarýna ayrýlýr. Bu parçalarýn 30")
		say("tanesi birleþtirilince de güçlü bir enerji")
		say("kristali elde edilir! Bir mücevher içerisinde")
		say("toplanmýþ saf ve filtrelenmemiþ bir enerji. Bu")
		say("güç tam teçhizatýna iþler.")
		say("Ýlgini çekiyor mu?")
		wait()
		say_title("Simyacý ")
		say("Avlanýrken bulduðun silah, taký ve kýyafet gibi")
		say("teçhizat malzemelerini bana getir. Onlarý iþleyip")
		say("enerji parçalarýna ayýracaðým. Krallýðýmýzýn")
		say("geleceði ve umudu bu tekniðe baðlý. Yenilmez")
		say("olacaðýz!")
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

		when 20001.chat."Enerji parçasý elde et" begin
		say_title("Simyacý ")
		say("Yapabildin mi? Enerji parçasý elde edebildin mi?")
		say("Simya yardýmýyla parçalayabileceðim daha fazla")
		say("eþya getir bana. Tekniðim henüz mükemmelleþmedi.")
		say("Bu yüzden ne kadar parça elde edebileceðine dair")
		say("bir garanti veremeyeceðim.")
		wait()
		say_title("Simyacý ")
		say("Tek bir þart var: Kendi seviyen ve eþyanýn")
		say("seviyesi en az 35 olmalý. Hým, bir göz atalým")
		say("bakalým...")
		wait()
			if pc.get_level() >= 35 then
			say_title("Simyacý ")
			say("Ah süper! Güçlü ve tecrübelisin. Ýþlenecek eþyayý ")
			say("ver bakalým.")
			else
			say_title("Simyacý ") 
			say("Henüz yeterince güçlü deðilsin! En az 35.") 
			say("seviyeye ulaþtýðýnda tekrar gel.") 
			end
		end

		when 20001.take begin
			if pc.get_level() < 35 then 
				say_title("Simyacý ") 
				say("Henüz yeterince güçlü deðilsin! En az 35.") 
				say("seviyeye ulaþtýðýnda tekrar gel.") 
				return
			end
			local item_vnum = item.vnum
			local levelLimit = item.get_level_limit(item_vnum)
			local setting = energy_system.setting()
			if levelLimit == nil then
				say_title("Simyacý ")
				say("Bu eþya benim tekniðim için elveriþli deðil. Bana")
				say("baþka bir þey getir.")
				wait()
			elseif item.get_type() == ITEM_WEAPON and item.get_sub_type() == WEAPON_ARROW then
				say_title("Simyacý ")
				say("Bu eþya benim tekniðim için elveriþli deðil. Bana")
				say("baþka bir þey getir.")
				wait()
			elseif levelLimit < 35 then
				-- kind of impossible condition?
				say_title("Simyacý ")
				say("Bu eþya benim tekniðim için elveriþli deðil. Bana")
				say("baþka bir þey getir.")
			else
				say_title(mob_name(20001))
				say(item_name(item_vnum))
				say("Bu eþyayý tahrip edeyim mi?")
				local s = select("Evet","Hayýr, þimdi etme!")
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
						say_title("Simyacý ")
						say("Baþaramadým. Üzgünüm bu sefer olmadý.")
					else
						pc.give_item2(setting.energy_stone, n)
						say_title("Simyacý ") 
						say("Efsanevi! "..n.." enerji parçasý buldum. Ýþte buyur.")
						say("")
					end
				end
			end
		end

		when 20001.chat."Enerji kristali üret" begin
			local setting = energy_system.setting()
			local need = 30
			say_title("Simyacý ")
			say("Yapabildin mi? Enerji parçasý elde edebildin mi?")
			say("Simya yardýmýyla parçalayabileceðim daha fazla")
			say("eþya getir bana. Tekniðim henüz mükemmelleþmedi.")
			say("Bu yüzden ne kadar parça elde edebileceðine dair")
			say("bir garanti veremeyeceðim.")
			wait()
			say_title("Simyacý ")
			say("Tek bir þart var: Kendi seviyen ve eþyanýn")
			say("seviyesi en az 35 olmalý. Hým, bir göz atalým")
			say("bakalým...")
			wait()
			if pc.get_level() < 35 then 
				say_title("Simyacý ") 
				say("Henüz yeterince güçlü deðilsin! En az 35.") 
				say("seviyeye ulaþtýðýnda tekrar gel.")
				return
			end
			
			if pc.count_item (setting.energy_stone) < need then
				say_title("Simyacý ")
				say("30 tane Enerji Parçasý gerekiyor. Yoksa")
				say("Enerji Kristalini üretemem.")
				return
			else
				say_title("Simyacý ")
				say("Güzel. Lazým olan 30 enerji parçasýný getirdin.")
				say("Bunlardan bir enerji kristali üretebilirim. Biraz")
				say("bekle lütfen. Deneyeceðim ama olacaðýna dair")
				say("garanti veremem.")
				wait()
			end
			
			local charge = 1000
			say_title("Simyacý ")
			say("Her þey hazýr durumda. Parçalarý birleþtirip")
			say("enerji kristali üretebiliriz. Ama ben de bir")
			say("þekilde ekmeðimi kazanmalýyým. Tamir aletleri de")
			say("gökten inmiyor yani. Masraflarý karþýlamak için")
			say("1000 yang ödemeni istiyorum. Ödemeye")
			say("hazýr mýsýn?")
			local s = select("Elbette!","Hayýr, henüz deðil.")
			if s == 2 then
				return
			end

			if pc.get_gold() < charge then
				say_title("Simyacý ")
				say("Yeteri kadar yang yok. Bu þartlarda kristal")
				say("üretemeyiz.")
				return
			end

			pc.change_gold (-charge)
			pc.remove_item (setting.energy_stone, need)

			if pc.getqf ("hasExperience") == 0 then
				say_title("Simyacý ")
				say("Ýþte enerji kristalin. Sadece ilk giriþimde")
				say("baþarýlý olunur hep. Simya, saðý solu belli")
				say("olmayan bir bilim. Ufak tefek farklýlýklar")
				say("baþarýsýzlýða neden olabilir! Yani deneylerde")
				say("genelde küçük de olsa baþarýsýzlýða uðrama riski")
				say("bulunur.")
				pc.give_item2 (setting.charging_stone, 1)
				pc.setqf ("hasExperience", 1);
				return
			end

			local r = number (1, 100)
			if r > 30 then
				say_title("Simyacý ")
				say("Baþaramadým. Üzgünüm bu sefer olmadý.")
				return
			end
			say_title("Simyacý ")
			say("Baþardým! Ýþte enerji kristalin.")
			pc.give_item2 (setting.charging_stone, 1)
					
--			setskin(NOWINDOW)
--			command("cube open")
		end
	end
end

