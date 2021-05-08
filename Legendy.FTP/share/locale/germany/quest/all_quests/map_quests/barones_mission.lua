quest spider_dungeon3 begin
	state start begin
		when 20355.chat."�r�mcek Zindan� " begin
		pc.give_item2("71095",1)
		say_title("Y�zba��:")
		say("")
		say("Ay iyiki buradas�n. Sana �nemli haberlerim var:")
		say("�r�mcek Zindan�'nda G�zc� Birli�i taraf�ndan")
		say("���nc� bir kat ke�fedildi. Bu yeni yuva")
		say("bildi�imiz yuvalardan daha k���k ama olduk�a cani")
		say("ve sinsi �r�mcekler bar�nd�r�yormu�. Ayr�ca")
		say("adamlar�m orada eski bir mezar ta�� buldu ama")
		say("�zerine kaz�lm�� yaz�lar� de�ifre edemedi. Bu")
		say("ta�� bulmak i�in yola koyul ve bana o yaz�n�n bir")
		say("kopyas�n� getir.")
		say("")
		setstate(kopyagetir)
		end
	end
	
	state kopyagetir begin
		when letter begin
		local v = find_npc_by_vnum(30130)
			if v != 0 and pc.get_map_index() == 217 then
				target.vid("__TARGET__", v, "Mezar Tasi")
			end
		send_letter("Yaz� ")
		end
		
		when button or info begin
		say_title("Yaz� ")
		say("")
		say("�r�mcek Zindan�'n�n ���nc� kat�nda �zerinde")
		say("yaz�lar bulunan eski bir mezar ta�� var. Onun")
		say("kopyas�n� al ve Y�zba��ya g�t�r.")
		say("")
		end
		
		when 30130.chat."Yaz� " with pc.get_map_index() == 217 begin
		target.delete("__TARGET__")
		say_title(""..pc.get_name().."")
		say("")
		say("Ya�as�n, eski mezar ta��n� buldun ve �zerindeki")
		say("yaz�n�n kopyas�n� ald�n! Y�zba��ya g�stermek i�in")
		say("geri d�n.")
		say("")
		setstate(geribas)
		end
	end
	
	state geribas begin
		when letter begin
		send_letter("Yeni tehlike")
		end
		
		when button or info begin
		say_title("Yeni tehlike")
		say("")
		say("Yaz�n�n tam kopyas�n� ald�n. Onu �imdi Y�zba��ya")
		say("g�ster.")
		say("")
		end
		
		when 20355.chat."Yeni tehlike" begin
		say_title("Y�zba��:")
		say("")
		say("Aferin, ba�ard�n! G�ster bi...")
		say("H�m, bu yaz�lar� ��zemiyorum, bir kelime dahi")
		say("anlam�yorum. Bilgin Uriel'e dan�� en iyisi.")
		say("")
		setstate(urielego)
		end
	end
	
	state urielego begin
		when letter begin
		send_letter("Yeni tehlike")
		end
		
		when button or info begin
		say_title("Yeni tehlike")
		say("")
		say("Bilgin Uriel'in yan�na git ve yaz�y� ona g�ster.")
		say("Yaz�y� �evirmesini bilir muhakkak.")
		say("")
		end
		
		when 20011.chat."Yeni tehlike" begin
		say_title("Uriel:")
		say("")
		say("Y�zba��, benden bu yaz�y� de�ifre etmemi mi")
		say("istiyor? Hayhay. Zekam� ispatlayacak zorlu")
		say("m�cadeleleri severim. G�ster bakal�m.")
		say("Bu...ama bu korkun� bir �ey.Buyur, �eviriyi bu")
		say("ka��d�n �zerine yaz�yorum. Onu bir an �nce")
		say("Y�zba��ya g�t�r, ard�ndan benim yan�ma gel.")
		say("Burada yaz�lanlar do�ruysa hepimiz b�y�k")
		say("tehlikedeyiz! Hadi hadi!")
		say("")
		setstate(gotoyuzbasi1)
		end
	end
	
	state gotoyuzbasi1 begin
		when letter begin
		send_letter("Yeni tehlike")
		end
		
		when button or info begin
		say_title("Urielin mektubunu teslim et")
		say("")
		say("Amma da dik kafal�ym�� �u ya�l� adam...Te�ekk�r")
		say("etseydi bir yeri mi eksilirdi? Aman neyse.")
		say("Bilgilerin �ok �nemli oldu�unu s�yledi�i i�in")
		say("hemen Y�zba��ya iletece�im.")
		say("")
		end
		
		when 20355.chat."Uriel'in Mektubu" begin
		say_title("Y�zba��:")
		say("")
		say("Aman�n! �r�mcek Zindan�'n�n ���nc� kat�na devasa")
		say("bir �eytani arachnida yerle�ti. Yaz�dan")
		say("anla��ld��� �zere bu gizli yuvaya �zel bir")
		say("anahtarla girilebiliyor. �lk �nce Uriel'in")
		say("yan�na git ve ona �u anahtar� sor. Sonra da")
		say("becerikli sava���lar�n� bir araya topla ve")
		say("�r�mcek Barones'in gizlendi�i yere birlikte")
		say("h�cum edin! ��te sana bir tane ge�it bileti")
		say("daha.")
		say("")
		pc.give_item2("71095",1)
		setstate(uriele2)
		end
	end
	
	state uriele2 begin
		when letter begin
		send_letter("Uriel'in Mektubu")
		end
		
		when button or info begin
		say_title("Uriel'in Mektubu")
		say("")
		say("Aman�n! �r�mcek Zindan�'n�n ���nc� kat�na devasa")
		say("bir �eytani arachnida yerle�ti. Yaz�dan")
		say("anla��ld��� �zere bu gizli yuvaya �zel bir")
		say("anahtarla girilebiliyor. �lk �nce Uriel'in")
		say("yan�na git ve ona �u anahtar� sor. Sonra da")
		say("becerikli sava���lar�n� bir araya topla ve")
		say("�r�mcek Barones'in gizlendi�i yere birlikte")
		say("h�cum edin! ��te sana bir tane ge�it bileti")
		say("daha.")
		say("")
		end
		
		when 20011.chat."Uriel'in Mektubu" begin
		say_title("Uriel:")
		say("")
		say("Ah, geldin. �yleyse Y�zba�� sana �r�mcek")
		say("Barones'i yok etme emrini verdi do�ru mu? Ancak")
		say("Barones'in yuvas�na giden kap� kapal� ve sadece")
		say("arachna anahtar�yla a��labilir. �retimi �ok zor.")
		say("Ama bana bir �r�mcek zehir kesesi, bir �r�mcek")
		say("yumurta kesesi, bir �r�mcek a��, �r�mcek g�zleri")
		say("�r�mcek bacaklar� ve krali�e �r�mcek zehrini")
		say("getirirsen, sana bir tane arachna anahtar� ")
		say("�retebilirim.")
		say("")
		setstate(killorumcek)
		end
	end
	
	state killorumcek begin
		when 20011.chat."Arachnida Anahtar� " begin
			if pc.countitem("30025") >= 1 and pc.countitem("30058") >= 1 and pc.countitem("30056") >= 1 and pc.countitem("30057") >= 1 and pc.countitem("30059") >= 1 and pc.countitem("30326") >= 1 then
			pc.remove_item("30025",1)
			pc.remove_item("30058",1)
			pc.remove_item("30056",1)
			pc.remove_item("30057",1)
			pc.remove_item("30059",1)
			pc.remove_item("30326",1)
			say_title("Uriel:")
				say("")
				say("Harika! Arachnida anahtar� �retmek i�in gerekli")
				say("olan t�m malzemeler haz�r. Bir saniye bekle. Fazla")
				say("uzun s�rmeyecek...")
			local sans = number(1,10)
				if sans > 5 then
				say("Ah, hay�r... Korkar�m ki bu sefer ba�aramad�m. Bu ")
				say("anahtar�n �retimi son derece kar���k. En k���k hata")
				say("pahal�ya mal oluyor. Ne yaz�k ki anahtar �retmek")
				say("i�in toplad���n t�m malzemeler bo�a gitti. Ama")
				say("eminim bir dahaki sefere ba�araca��z!")
				say("")
				else
				say("Ah, evet ba�ard�m! Arachnida anahtar� �rettim. Bu")
				say("�r�mcek Barones'e inmenizi sa�layacak. Uzun ")
				say("bacakl� d��manlar�n�za kar�� sana ve silah")
				say("arkada�lar�na iyi �anslar dilerim! Ama acele edin")
				say("anahtar �ok k�r�lgan. 24 saat sonra par�alara")
				say("ayr�lacakt�r.")
				say("")
				pc.give_item2("30325",1)
				end
			else
			say_title("Uriel:")
			say("")
			say("Bir �ey eksik, arachnida anahtar�n� bu �ekilde")
			say("�retmem m�mk�n de�il. Laz�m olanlar� bir kez daha")
			say("hat�rlatay�m: bir �r�mcek zehir kesesi, bir �r�mcek")
			say("yumurta kesesi, bir �r�mcek a��, �r�mcek g�zleri")
			say("�r�mcek bacaklar� ve krali�e �r�mcek zehri.")
			say("")
			end
		end
	end
end
	
	
		