quest sash_mission begin
	state start begin
		when login or levelup with pc.get_level() >= 40 begin
			set_state("information")
		end
	end
	
	state information begin
		when enter begin
			pc.setqf("time_to_wait", 0)
			pc.setqf("collect_count", 0)
		end
		
		when letter begin
			local v = find_npc_by_vnum(60003)
			if v != 0 then
				target.vid("theowahdan", v, "Theowahdan")
			end
			
			send_letter("&�zel bir kuma� ")
		end
		
		when button or info begin
			say_title("�zel bir kuma� ")
			say(mob_name(60003).." seni g�rmek istiyor. Onu ziyaret et ve")
			say("hikayesini dinle.")
			say("")
			say_reward("Mini Harita'daki yan�p s�nen noktay� takip et.")
		end
		
		when theowahdan.target.click or 60003.chat."Kendi g�c�n� art�r" begin
			target.delete("theowahdan")
			
			say_title(mob_name(60003))
			say("")
			say("Ah, i�te buradas�n! S�ra d��� bir �ey ke�fettim:")
			say("Omuz ku�a�� ad�nda yeni bir ekipman.")
			say("")
			say("Omuz ku�a�� sana iki imkan sa�lar:")
			say("Kombinasyon ve emi�.")
			say("")
			say("Kombinasyon ayn� derecedeki iki ku�akla")
			say("ger�ekle�tirilebilir. Kombine edilen iki ku�ak")
			say("daha de�erli bir ku�ak meydana getirir.")
			wait()
			say_title(mob_name(60003))
			say("")
			say("Emi� i�leminde bir silah veya z�rh �zerinde")
			say("bulunan bonuslar")
			say("�e�itli oranlarla omuz ku�a��na aktar�l�r.")
			say("Emi� oran� (%) ku�a��n derecesine ba�l�d�r. Bonus")
			say("i�lemi i�in se�ilen silah ve z�rh geri")
			say("d�nd�r�lemez �ekilde yok edilir.")
			say("Ben birinci derece ku�ak yapabiliyorum.")
			say("Fakat 20x "..item_name(85000).."'a ihtiyac�m var.")
			say("")
			say("Sadece "..mob_name(20355).." bu maddeyi �retebilir.")
			say("Git ve onunla g�r��.")
			say("")
			set_state("go_to_disciple")
		end
	end
	
	state go_to_disciple begin
		when letter begin
			local v = find_npc_by_vnum(20355)
			if v != 0 then
				target.vid("captain", v, "Captain")
			end
			
			send_letter("&Kendi g�c�n� art�r")
		end
		
		when button or info begin
			say_title("Kendi g�c�n� art�r")
			say("")
			say(""..mob_name(20355).."'y� bul ve malzemeyi al.")
			say("")
		end
		
    	when captain.target.click or 20355.chat."Kendi g�c�n� art�r" begin
			target.delete("captain")
			
			say_title(mob_name(20355))
			say("")
			say("Tebrikler! "..mob_name(60003).." bana ziyarete gelece�ini")
			say("s�yledi. Son zamanlarda Sung Mahi'nin daha da")
			say("g��lendi�ini ��rendim.")
			say("En az�ndan birimiz onun g�c�ne sahip olmal�y�z.")
			say("Yoksa Sung Mahi hepimizi yok edecek.")
			say("")
			say("�zel kuma�� �retebilirim ama bu o okadar da kolay")
			say("olmayacak.")
			say("Bana bir saat ver. O s�rede sana kuma�� ")
			say("�retebilirim.")
			say("")
			wait()
			say_title(mob_name(20355))
			say("")
			say("Bir saat sonra geldi�inde malzeme haz�r olacak.")
			say("S�z veriyorum!")
				if pc.is_gm() then
				say_reward("GM'ler hemen al�r.")
				end
			say("")
			local agree = select("Kabul et", "Reddet")
			if agree == 1 then
				if not pc.is_gm() then
					pc.setqf("time_to_wait", 60 + pc.get_playtime())
				end
				set_state("time_to_wait")
			end
		end
	end
	
	state time_to_wait begin
		when letter begin
			local v = find_npc_by_vnum(20355)
			if v != 0 then
				target.vid("captain", v, "Captain")
			end
			
			send_letter("&Kendi g�c�n� art�r")
		end
		
		when button or info begin
			say_title("Kendi g�c�n� art�r")
			say("")
			say("Malzemeyi almak i�in "..mob_name(20355).."'y� bul.")
			say("")
			if pc.getqf("time_to_wait") > pc.get_playtime() then
				local time_to_wait = pc.getqf("time_to_wait") - pc.get_playtime()
				say("Kalan zaman: "..time_to_wait.." dakika.")
				say("")
			end
		end
		
    	when captain.target.click or 20355.chat."Kendi g�c�n� art�r" begin
			target.delete("captain")
			
			if pc.getqf("time_to_wait") > pc.get_playtime() and not pc.is_gm() then
				local time_to_wait = pc.getqf("time_to_wait") - pc.get_playtime()
				say("Hen�z bir saat dolmad�.")
				say("")
				say("Kalan zaman: "..time_to_wait.." dakika.")
				say("")
			else
				pc.setqf("time_to_wait", 0)
				say("D�nd�n demek. Ben de s�z�m� tuttum:")
				say("��te istedi�in kuma�.")
				say("Acilen g��lerimizi art�rmaya devam etmemiz")
				say("gerekti�ini unutma. Bu biraz vakit al�r.")
				say("E�er yard�ma ihtiya� duyarsan yine yan�ma gel.")
				say_item_vnum(85000)
				if pc.count_item("85000") >= 39 then
					--pc.setqf("collect_count", pc.getqf("collect_count") + 1)
					set_state("__complete")
				else
					--pc.setqf("collect_count", pc.getqf("collect_count") + 1)
					set_state("go_to_disciple")
				end
				
				pc.give_item2(85000, 1)
			end
		end
			
		when 60003.chat."�zel bir kuma� " with pc.count_item(85000) >= 40 begin
		say("Selam. G�r�yorum ki ihtiya� duydu�umuz b�t�n")
		say("kuma�lar� toplam��s�n. Art�k Sung Mahi'ye kar�� ")
		say("sava�ma g�c�ne sahip oldu�un i�in �ok mutluyum.")
		say("Tekrar g�r��ece�iz!")
		say_item_vnum(85005)
		pc.remove_item(85000, 40)
		pc.give_item2(85005, 1)
		--item.set_socket(1, 1)
		end
	end
	
	state __complete begin
		when enter begin
			notice("Yeterli miktarda ince kuma� toplad�n. "..mob_name(60003).."'a")
			notice("geri d�n ve ona kuma�lar� teslim et.")
			pc.delqf("time_to_wait")
			pc.delqf("collect_count")
		end
		
		when letter begin
			local v = find_npc_by_vnum(60003)
			if v != 0 then
				target.vid("theowahdan_reward", v, "Theowahdan")
			end
			
			send_letter("&�zel bir kuma� ")
		end
		
		when button or info begin
			say_title("�zel bir kuma� ")
			say("")
			say(mob_name(60003).."'� bul ve onunla konu�.")
			say("")
			say_reward("Mini Harita'daki yan�p s�nen noktay� takip et.")
		end
		
		when theowahdan_reward.target.click or 60003.chat."�zel bir kuma� " begin
			target.delete("theowahdan_reward")
			if pc.count_item(85000) < 40 then
				say("Ne? Yeterli malzeme yok!")
				say("")
				say("Tekrar Y�zba��'yla konu�!")
				say("")
				set_state("go_to_disciple")
			else
			say("Selam. G�r�yorum ki ihtiya� duydu�umuz b�t�n")
			say("kuma�lar� toplam��s�n. Art�k Sung Mahi'ye kar�� ")
			say("sava�ma g�c�ne sahip oldu�un i�in �ok mutluyum.")
			say("Tekrar g�r��ece�iz!")
			say_item_vnum(85005)
			pc.remove_item(85000, 40)
			pc.give_item2(85005, 1)
			--item.set_socket(1, 1)
			set_state("information")
			end
		end
	end
end