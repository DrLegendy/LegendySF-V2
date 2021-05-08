quest exp_helper begin
    state start begin
        when levelup begin
			-- Lycan Skill
			if pc.job == 4 and pc.get_level() == 5 then
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
				pc.clear_skill()
				end
			-- 1-9 Lv Arasi	
            if pc.get_level() == 2 then
				notice("Tebrikler "..pc.get_name().." "..pc.get_level()..".seviyeye ulaþtýnýz.")
                notice("1-10 seviye aralýðýnda en iyi kasýlabileceðiniz alan 1.Köyünüzdür.")
				end
			-- 9-24 Lv Arasi 	
            if pc.get_level() > 9 and pc.get_level () <= 24 then
                notice("Tebrikler "..pc.get_name().." "..pc.get_level()..".seviyeye ulaþtýnýz.")
                notice("10-24 seviye aralýðýnda en iyi kasýlabileceðiniz alan 2.Köyünüzdür.")
				end
			-- 24-39 Lv Arasi	
            if pc.get_level() > 24 and pc.get_level () <= 39 then
				notice("Tebrikler "..pc.get_name().." "..pc.get_level()..".seviyeye ulaþtýnýz.")
                notice("25-39 seviye aralýðýnda en iyi kasýlabileceðiniz alan Seungryong Vadisidir.")
				end
			-- 39-54 Lv Arasi	
            if pc.get_level() > 39 and pc.get_level () <= 54 then
				notice("Tebrikler "..pc.get_name().." "..pc.get_level()..".seviyeye ulaþtýnýz.")
                notice("40-54 seviye aralýðýnda en iyi kasýlabileceðiniz alan Örümcek Zindaný 1.katdýr.")
				end
			-- 54-66 Lv Arasi	
            if pc.get_level() > 54 and pc.get_level () <= 66 then
				notice("Tebrikler "..pc.get_name().." "..pc.get_level()..".seviyeye ulaþtýnýz.")
                notice("55-66 seviye aralýðýnda en iyi kasýlabileceðiniz alan Örümcek Zindaný 2.katdýr.")
				end
			-- 66-74 Lv Arasi	
            if pc.get_level() > 66 and pc.get_level () <= 74 then
				notice("Tebrikler "..pc.get_name().." "..pc.get_level()..".seviyeye ulaþtýnýz.")
                notice("67-74 seviye aralýðýnda en iyi kasýlabileceðiniz alan Örümcek Zindaný 3.katdýr.")
				end
			-- 74-79 Lv Arasi	
            if pc.get_level() > 74 and pc.get_level () <= 79 then
				notice("Tebrikler "..pc.get_name().." "..pc.get_level()..".seviyeye ulaþtýnýz.")
                notice("75-79 seviye aralýðýnda en iyi kasýlabileceðiniz alan Sürgün Maðarasý 1.katdýr.")
				end
			-- 79-84 Lv Arasi	
            if pc.get_level() > 79 and pc.get_level () <= 84 then
				notice("Tebrikler "..pc.get_name().." "..pc.get_level()..".seviyeye ulaþtýnýz.")
                notice("80-84 seviye aralýðýnda en iyi kasýlabileceðiniz alan Sürgün Maðarasý 2.katdýr.")
				end
			-- 84-99 Lv Arasi	
            if pc.get_level() > 84 and pc.get_level () <= 98 then
				notice("Tebrikler "..pc.get_name().." "..pc.get_level()..".seviyeye ulaþtýnýz.")
                notice("85-98 seviye aralýðýnda en iyi kasýlabileceðiniz alan Sürgün Maðarasý 2.katdýr.")
				end
			-- 99-105 Lv Arasi	
            if pc.get_level() > 99 and pc.get_level () <= 104 then
               notice("Tebrikler "..pc.get_name().." "..pc.get_level()..".seviyeye ulaþtýnýz.")
               notice("100-104 seviye aralýðýnda en iyi kasýlabileceðiniz alan Beta Haritalardýr..")
			   end
			-- Biyolog Gorevleri 30 
			if pc.get_level() == 30 then			
			   notice("Biyolog'un 30.seviye görevini yapmayý unutmayýn!")
			   notice("Biyolog görevleri karakterinizi geliþtirir!")
			   end
			-- Biyolog Gorevleri 40  
			if pc.get_level() == 40 then			
			   notice("Biyolog'un 40.seviye görevini yapmayý unutmayýn!")
			   notice("Biyolog görevleri karakterinizi geliþtirir!")
			   end
			-- Biyolog Gorevleri 50  
			if pc.get_level() == 50 then			
			   notice("Biyolog'un 50.seviye görevini yapmayý unutmayýn!")
			   notice("Biyolog görevleri karakterinizi geliþtirir!")
			   end	
			-- Biyolog Gorevleri 60  
			if pc.get_level() == 60 then			
			   notice("Biyolog'un 60.seviye görevini yapmayý unutmayýn!")
			   notice("Biyolog görevleri karakterinizi geliþtirir!")
			   end	
			-- Biyolog Gorevleri 70  
			if pc.get_level() == 70 then			
			   notice("Biyolog'un 70.seviye görevini yapmayý unutmayýn!")
			   notice("Biyolog görevleri karakterinizi geliþtirir!")
			   end	
			-- Biyolog Gorevleri 80  
			if pc.get_level() == 80 then			
			   notice("Biyolog'un 80.seviye görevini yapmayý unutmayýn!")
			   notice("Biyolog görevleri karakterinizi geliþtirir!") 
			   end		
			-- Biyolog Gorevleri 85  
			if pc.get_level() == 85 then			
			   notice("Biyolog'un 85.seviye görevini yapmayý unutmayýn!")
			   notice("Biyolog görevleri karakterinizi geliþtirir!")
			   end	
			-- Biyolog Gorevleri 90  
			if pc.get_level() == 90 then			
			   notice("Biyolog'un 90.seviye görevini yapmayý unutmayýn!")
			   notice("Biyolog görevleri karakterinizi geliþtirir!")
			   end	
			-- Biyolog Gorevleri 92  
		    if pc.get_level() == 92 then			
			   notice("Biyolog'un 92.seviye görevini yapmayý unutmayýn!")
			   notice("Biyolog görevleri karakterinizi geliþtirir!")
			   end		
			-- Biyolog Gorevleri 94  
			if pc.get_level() == 94 then			
			   notice("Biyolog'un 94.seviye görevini yapmayý unutmayýn!")
			   notice("Biyolog görevleri karakterinizi geliþtirir!")
			   end	
			   end
		 end   
	end
	-- Finish Quest
	