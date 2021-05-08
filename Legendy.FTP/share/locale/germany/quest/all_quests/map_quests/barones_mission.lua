quest spider_dungeon3 begin
	state start begin
		when 20355.chat."Örümcek Zindaný " begin
		pc.give_item2("71095",1)
		say_title("Yüzbaþý:")
		say("")
		say("Ay iyiki buradasýn. Sana önemli haberlerim var:")
		say("Örümcek Zindaný'nda Gözcü Birliði tarafýndan")
		say("üçüncü bir kat keþfedildi. Bu yeni yuva")
		say("bildiðimiz yuvalardan daha küçük ama oldukça cani")
		say("ve sinsi örümcekler barýndýrýyormuþ. Ayrýca")
		say("adamlarým orada eski bir mezar taþý buldu ama")
		say("üzerine kazýlmýþ yazýlarý deþifre edemedi. Bu")
		say("taþý bulmak için yola koyul ve bana o yazýnýn bir")
		say("kopyasýný getir.")
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
		send_letter("Yazý ")
		end
		
		when button or info begin
		say_title("Yazý ")
		say("")
		say("Örümcek Zindaný'nýn üçüncü katýnda üzerinde")
		say("yazýlar bulunan eski bir mezar taþý var. Onun")
		say("kopyasýný al ve Yüzbaþýya götür.")
		say("")
		end
		
		when 30130.chat."Yazý " with pc.get_map_index() == 217 begin
		target.delete("__TARGET__")
		say_title(""..pc.get_name().."")
		say("")
		say("Yaþasýn, eski mezar taþýný buldun ve üzerindeki")
		say("yazýnýn kopyasýný aldýn! Yüzbaþýya göstermek için")
		say("geri dön.")
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
		say("Yazýnýn tam kopyasýný aldýn. Onu þimdi Yüzbaþýya")
		say("göster.")
		say("")
		end
		
		when 20355.chat."Yeni tehlike" begin
		say_title("Yüzbaþý:")
		say("")
		say("Aferin, baþardýn! Göster bi...")
		say("Hým, bu yazýlarý çözemiyorum, bir kelime dahi")
		say("anlamýyorum. Bilgin Uriel'e danýþ en iyisi.")
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
		say("Bilgin Uriel'in yanýna git ve yazýyý ona göster.")
		say("Yazýyý çevirmesini bilir muhakkak.")
		say("")
		end
		
		when 20011.chat."Yeni tehlike" begin
		say_title("Uriel:")
		say("")
		say("Yüzbaþý, benden bu yazýyý deþifre etmemi mi")
		say("istiyor? Hayhay. Zekamý ispatlayacak zorlu")
		say("mücadeleleri severim. Göster bakalým.")
		say("Bu...ama bu korkunç bir þey.Buyur, çeviriyi bu")
		say("kaðýdýn üzerine yazýyorum. Onu bir an önce")
		say("Yüzbaþýya götür, ardýndan benim yanýma gel.")
		say("Burada yazýlanlar doðruysa hepimiz büyük")
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
		say("Amma da dik kafalýymýþ þu yaþlý adam...Teþekkür")
		say("etseydi bir yeri mi eksilirdi? Aman neyse.")
		say("Bilgilerin çok önemli olduðunu söylediði için")
		say("hemen Yüzbaþýya ileteceðim.")
		say("")
		end
		
		when 20355.chat."Uriel'in Mektubu" begin
		say_title("Yüzbaþý:")
		say("")
		say("Amanýn! Örümcek Zindaný'nýn üçüncü katýna devasa")
		say("bir þeytani arachnida yerleþti. Yazýdan")
		say("anlaþýldýðý üzere bu gizli yuvaya özel bir")
		say("anahtarla girilebiliyor. Ýlk önce Uriel'in")
		say("yanýna git ve ona þu anahtarý sor. Sonra da")
		say("becerikli savaþçýlarýný bir araya topla ve")
		say("Örümcek Barones'in gizlendiði yere birlikte")
		say("hücum edin! Ýþte sana bir tane geçit bileti")
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
		say("Amanýn! Örümcek Zindaný'nýn üçüncü katýna devasa")
		say("bir þeytani arachnida yerleþti. Yazýdan")
		say("anlaþýldýðý üzere bu gizli yuvaya özel bir")
		say("anahtarla girilebiliyor. Ýlk önce Uriel'in")
		say("yanýna git ve ona þu anahtarý sor. Sonra da")
		say("becerikli savaþçýlarýný bir araya topla ve")
		say("Örümcek Barones'in gizlendiði yere birlikte")
		say("hücum edin! Ýþte sana bir tane geçit bileti")
		say("daha.")
		say("")
		end
		
		when 20011.chat."Uriel'in Mektubu" begin
		say_title("Uriel:")
		say("")
		say("Ah, geldin. Öyleyse Yüzbaþý sana Örümcek")
		say("Barones'i yok etme emrini verdi doðru mu? Ancak")
		say("Barones'in yuvasýna giden kapý kapalý ve sadece")
		say("arachna anahtarýyla açýlabilir. Üretimi çok zor.")
		say("Ama bana bir örümcek zehir kesesi, bir örümcek")
		say("yumurta kesesi, bir örümcek aðý, örümcek gözleri")
		say("örümcek bacaklarý ve kraliçe örümcek zehrini")
		say("getirirsen, sana bir tane arachna anahtarý ")
		say("üretebilirim.")
		say("")
		setstate(killorumcek)
		end
	end
	
	state killorumcek begin
		when 20011.chat."Arachnida Anahtarý " begin
			if pc.countitem("30025") >= 1 and pc.countitem("30058") >= 1 and pc.countitem("30056") >= 1 and pc.countitem("30057") >= 1 and pc.countitem("30059") >= 1 and pc.countitem("30326") >= 1 then
			pc.remove_item("30025",1)
			pc.remove_item("30058",1)
			pc.remove_item("30056",1)
			pc.remove_item("30057",1)
			pc.remove_item("30059",1)
			pc.remove_item("30326",1)
			say_title("Uriel:")
				say("")
				say("Harika! Arachnida anahtarý üretmek için gerekli")
				say("olan tüm malzemeler hazýr. Bir saniye bekle. Fazla")
				say("uzun sürmeyecek...")
			local sans = number(1,10)
				if sans > 5 then
				say("Ah, hayýr... Korkarým ki bu sefer baþaramadým. Bu ")
				say("anahtarýn üretimi son derece karýþýk. En küçük hata")
				say("pahalýya mal oluyor. Ne yazýk ki anahtar üretmek")
				say("için topladýðýn tüm malzemeler boþa gitti. Ama")
				say("eminim bir dahaki sefere baþaracaðýz!")
				say("")
				else
				say("Ah, evet baþardým! Arachnida anahtarý ürettim. Bu")
				say("Örümcek Barones'e inmenizi saðlayacak. Uzun ")
				say("bacaklý düþmanlarýnýza karþý sana ve silah")
				say("arkadaþlarýna iyi þanslar dilerim! Ama acele edin")
				say("anahtar çok kýrýlgan. 24 saat sonra parçalara")
				say("ayrýlacaktýr.")
				say("")
				pc.give_item2("30325",1)
				end
			else
			say_title("Uriel:")
			say("")
			say("Bir þey eksik, arachnida anahtarýný bu þekilde")
			say("üretmem mümkün deðil. Lazým olanlarý bir kez daha")
			say("hatýrlatayým: bir örümcek zehir kesesi, bir örümcek")
			say("yumurta kesesi, bir örümcek aðý, örümcek gözleri")
			say("örümcek bacaklarý ve kraliçe örümcek zehri.")
			say("")
			end
		end
	end
end
	
	
		