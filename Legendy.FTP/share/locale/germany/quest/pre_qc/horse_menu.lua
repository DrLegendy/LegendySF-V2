quest horse_menu begin
    state start begin
		function horse_menu()
			if horse.is_mine() then
				say_title("At Klavuzu")
				local s = 6
				if horse.is_dead() then
					s = select( "At� �a��r", "At� Yolla", "Kapat")
					if s == 1 then s = 0
					elseif s == 2 then s = 3
					elseif s == 3 then return
					end
				else
					s = select(
					"At� Besle", "Ata Bin", "At� Yolla", "Durum", 
					"Ata �sim Ver", "Kapat")
				end
				if s == 0 then
					horse.revive()
				elseif s == 1 then
					local food = horse.get_grade() + 50054 - 1
					if pc.countitem(food) > 0 then
						pc.removeitem(food, 1)
						horse.feed()
					else
						say("At� beslemek i�in "..item_name(food).." gerekli.")
						say("")
					end
				elseif s == 2 then
					horse.ride()
				elseif s == 3 then
					horse.unsummon()
				elseif s == 4 then
					say_title("At�n Durumu")
					say("At�n Sa�l�k Durumu: "..horse.get_health_pct().."%")
					say("At�n Dayan�kl�l���: "..horse.get_stamina_pct().."%")
					say("")
				elseif s == 5 then
					local old_horse_name = horse.get_name() ;
					say_title("At Ad� ")
					say("At�n�za yeni isim verebilirsiniz.")
					say("")
					if string.len(old_horse_name) == 0 then
						say_reward("At�n hen�z ad� yok.")
					else
						say_reward("At�n �uan ki ad� "..old_horse_name..".")
					end
					say("")
					say("Yeni bi at ismi giriniz.:")
					say("")
					local horse_name = input()
					if string.len(horse_name) < 2 then
						say_title("At Ad� ")
						say("At ismi �ok k�sa.")
						say("")
						return
					elseif string.len(horse_name) > 12 then
						say_title("At Ad� ")
						say("At ismi �ok uzun.")
						say("")
						return
					end
					local ret = horse.set_name(horse_name)
					say_title("At Ad� ")
					if ret == 0 then
						say_reward("Bu ismi kullanamazs�n!")
						say("")
					elseif ret == 1 then
						say_reward("Bu ismi kullanamazs�n!")
						say("")
					elseif ret == 2 then
						pc.remove_item("71110")
						say("Artik at�n�n yeni bir ismi var!")
						say("")
					end
				end
			end
		end
		when 20030.click begin horse_menu.horse_menu() end
		when 20101.click begin horse_menu.horse_menu() end
		when 20102.click begin horse_menu.horse_menu() end
		when 20103.click begin horse_menu.horse_menu() end
		when 20104.click begin horse_menu.horse_menu() end
		when 20105.click begin horse_menu.horse_menu() end
		when 20106.click begin horse_menu.horse_menu() end
		when 20107.click begin horse_menu.horse_menu() end
		when 20108.click begin horse_menu.horse_menu() end
		when 20109.click begin horse_menu.horse_menu() end
    end
end
