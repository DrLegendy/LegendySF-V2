quest skill_reset2 begin
	state start begin
		when 9006.chat."Becerileri s�f�rla " begin
			if pc.getqf("delay") - get_time() > 0 then
				say_title("Ya�l� Kad�n:")
				say("Becerilerini yeniden s�f�rlamak ")
				say("i�in 5 dakika beklemelisin. ")
				return
			end
			---
			if pc.level < 5 then
				say_title("Ya�l� Kad�n")
				say("")
				say("�nce bir �eyler ��renmelisin.")
				say("")
				return
			end
			---
			if pc.level >70 then
				say_title("Ya�l� Kad�n")
				say("")
				say("Seviyen "..""..pc.level.."")
				say("Sana yard�m edemem.")
				say("Bu seviyede  beceri de�i�tiremezsin.")
				say("Sadece seviyen 70 dan azsa baska bir")
				say("beceri se�ebilirsin.")
				say("")
				return
			end
			---
			if  pc.get_skill_group()==0 then
				say_title("Ya�l� Kad�n")
				say("")
				say("S�f�rlamaya ihtiyac�n yok.")
				say("")
				return
			end
			---
			local cost = 10000 + pc.level * 2000
			local s = 0
			if not pc.has_master_skill() then
				say_title("Ya�l� Kad�n")
				say("")
				say("Merhaba,do�ru yerdesin.")
				say("Dertli g�r�n�yorsun.")
				say("�nsanlar�n becerilerini unutmalar�na")
				say("yard�mc� oluyorum. Yeni ba�tan ba�l�yorlar.")
				say("Becerilerini unutup, ba�tan ba�lamak")
				say("istiyor musun?")
				say("Fiyati:"..cost.." Yang.")
				say("")
				s = select( "S�f�rla", "S�f�rlama")
			else
				say_title("Ya�l� Kad�n")
				say("Beceleri s�f�rlamakm� istiyorsun?.")
				say("Fakat �al��arak toplad���n ")
				say("t�m puanlar�n� ")
				say("kaybedeceksin.")
				say("Yeniden ba�lamak istedi�ine ")
				say("emin misin? ")
				say("Fiyat� "..cost.." Yang.")
				say("")
				s = select("Beceriyi S�f�rla ", "�ptal")
			end
			---
			if 2==s then
				say_title("Ya�l� Kad�n")
				say("")
				say("E�er fikrin de�i�irse beni tekrar")
				say("ziyaret et.")
				say("")
				return
			end
			---
			if pc.money < cost then
				say_title("Ya�l� Kad�n")
				say("")
				say("Yeterli Yang'a sahip de�ilsin, ")
				say("Yang olmadan sana yard�m edemem, ")
				say("Ya�amak i�in bir �eyler yapmal�y�m. ")
				say("")
				return
			end
			---
			pc.setqf("delay",get_time() + 5*60)
			pc.changegold(-cost)
			pc.clear_skill()
			pc.set_skill_group(0)
			set_quest_state("skill_group","run")
			if pc.job == 4 then
				pc.set_skill_group(1) 
				pc.set_skill_level (137,20)
				pc.set_skill_level (138,20)
				pc.set_skill_level (139,20)
				pc.set_skill_level (131,10)
				pc.set_skill_level (129,40)
				pc.set_skill_level (128,20)
				pc.set_skill_level (127,20)
				pc.set_skill_level (126,20)
				pc.set_skill_level (124,40)
				pc.set_skill_level (121,40)
				pc.set_skill_level (122,2)
				end
		end

		when 71100.use begin
			if pc.level <=31 or pc.level >=104 then
				say_title(item_name(71100))
				say("31-104 seviye aras� kullanabilir.")
				return
			end
			if  pc.get_skill_group()==0 then
				say_title(item_name(71100))
				say("S�f�rlamaya ihtiyac�n yok.")
				return
			end
			say_title(item_name(71100))
			say("Bu ��e yeni becerilere ge�i�i ve ")
			say("eski becerileri unutmay� sa�lar. ")
			say("Sadece 31. seviye'ye ula�m�� ")
			say("ki�iler kullanabilir. ")
			say("Becerilerini s�f�rlamak istiyor musun? ")
			say(" ")
			s =  select(" Evet ", " Hay�r ")
			if 2==s then
				return
			end
			pc.clear_skill()
			pc.set_skill_group(0)
			horse.set_level(horse_level)
			char_log(0, "RESET_SKILL", "RESET_SKILL_BY_71100")
			pc.remove_item(71100) ;
			set_quest_state("skill_group","run")
			if pc.job == 4 then
				pc.set_skill_group(1) 
				pc.set_skill_level (137,20)
				pc.set_skill_level (138,20)
				pc.set_skill_level (139,20)
				pc.set_skill_level (131,10)
				pc.set_skill_level (129,40)
				pc.set_skill_level (128,20)
				pc.set_skill_level (127,20)
				pc.set_skill_level (126,20)
				pc.set_skill_level (124,40)
				pc.set_skill_level (121,40)
				pc.set_skill_level (122,2)
				end
		end
	end
end


