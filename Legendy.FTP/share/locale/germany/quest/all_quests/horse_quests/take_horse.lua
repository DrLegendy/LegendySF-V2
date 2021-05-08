quest horse_summon begin
        state start begin

				function get_horse_summon_prob_pct()
						local skill_level=pc.get_skill_level(131)
						if skill_level==1 then
								return 15
						elseif skill_level==2 then
								return 20
						elseif skill_level==3 then
								return 30
						elseif skill_level==4 then
								return 40
						elseif skill_level==5 then
								return 50
						elseif skill_level==6 then
								return 60
						elseif skill_level==7 then
								return 70
						elseif skill_level==8 then
								return 80
						elseif skill_level==9 then
								return 90
						elseif skill_level>=10 then
								return 100
						end
						return 10
				end


                when 20349.chat."Yeni At Resmi" with horse.get_grade()==1 and pc.countitem("50051")<1 begin
                        say_title("Seyis:")
                        say("")
                        ----"12345678901234567890123456789012345678901234567890"|
                        say("Binici resmini kaybettin.")
                        say("Bana 10.000 Yang verirsen sana ")
                        say("yenisini verebilirim.")
                        say("")
                        local b=select("Al", "Alma")
                        if 1==b then
                                if pc.money>=10000 then
                                        pc.changemoney(-10000)
                                        say_title("Seyis:")
                                        say("")
                                        ----"12345678901234567890123456789012345678901234567890"|
                                        say("Bu yeni binici resmin.")
                                        say("Tekrar kaybetme!")
                                        pc.give_item2("50051", 1)
                                else
                                        say_title("Seyis:")
                                        say("")
                                        ----"12345678901234567890123456789012345678901234567890"|
                                        say("Yeterli Yang'�n yok.")
                                        say("")
                                end
                        elseif 2==b then
                        else
                                say("UNBEKANNTE TASTE ["..b.."]")
                        end
                end
                when 20349.chat."Yeni Z�rhl� At Kitab� " with horse.get_grade()==2 and pc.countitem("50052")<1 begin
                        say_title("Seyis:")
                        say("")
                        ----"12345678901234567890123456789012345678901234567890"|
                        say("Z�rhl� At Kitab�n� kaybettin!")
                        say("50.000 Yang'a sana yenisini ")
                        say("verebilirim.")
                        say("")
                        local b=select("Kabul", "Vazge� ")
                        if 1==b then
                                if pc.money>=50000 then
                                        pc.changemoney(-50000)
                                        say_title("Ah�r G�revlisi:")
                                        say("")
                                        -----------"12345678901234567890123456789012345678901234567890"|
                                        say("Bu Yeni Z�rhl� At Kitab�n.")
                                        say("Tekrar kaybetme!")
                                        pc.give_item2("50052", 1)
                                else
                                        say("Yeterli Yang'�n yok.")
                                end
                        elseif 2==b then
                        else
                                say("UNBEKANNTE TASTE ["..b.."]")
                        end
                end
                when 20349.chat."Yeni Asker At Kitab� " with horse.get_grade()==3 and pc.countitem("50053")<1 begin
                        say_title("Seyis:")
                        say("")
                        ----"12345678901234567890123456789012345678901234567890"|
                        say("Asker At Kitab�n� kaybettin!")
                        say("100.000 Yang'a sana yenisini verebilirim.")
                        say("")
                        local b=select("Kabul", "Vazge� ")
                        if 1==b then
                                if pc.money>=100000 then
                                        pc.changemoney(-100000)
                                        say_title("Bilgi:")
                                        say("")
                                        ----"12345678901234567890123456789012345678901234567890"|
                                        say("Bu yeni Asker At Kitab�n.")
                                        say("Onu yine kaybetme!")
                                        say("")
                                        pc.give_item2("50053", 1)
                                else
                                        say_title("Seyis:")
                                        say("")
                                        ----"12345678901234567890123456789012345678901234567890"|
                                        say("Yeterli Yang'�n yok.")
                                end
                        elseif 2==b then
                        else
                                say("UNBEKANNTE TASTE ["..b.."]")
                        end
                end
                when 50051.use with horse.get_grade()==0 begin
					syschat("Acemi at�n� �a��rabilmek i�in acemi at g�revini yapman gerek.")
                end
                when 50051.use with horse.get_grade()==1 begin
					if horse.is_summon() == true then
						syschat("Zaten acemi at� �a��rm��s�n.")
						return
					end
					if number(1, 100)<=horse_summon.get_horse_summon_prob_pct() then
						horse.summon()
						syschat("Acemi at �a��r�ld�.")
					else
						syschat("Acemi at �a��r�lamad�.")
					end
				end
                when 50051.use with horse.get_grade()==2 begin
					syschat("Z�rhl� at�n� �a��rabilmek i�in Z�rhl� At Kitab� laz�m.")
                end
                when 50051.use with horse.get_grade()==3 begin
					syschat("Uzman seviyedeki atlar� �a��rmak i�in Asker At Kitab� laz�m.")
                end
                when 50052.use with horse.get_grade()==0 begin
					syschat("Orta seviyedeki at� �a��rman i�in acemi at g�revini yapman laz�m.")
                end
                when 50052.use with horse.get_grade()==1 begin
					syschat("Acemi at� �a��rman i�in at resmi laz�m.")
                end
                when 50052.use with horse.get_grade()==2 begin
					if horse.is_summon() == true then
						syschat("Zaten z�rhl� at� �a��rm��s�n.")
						return
					end
					if number(1, 100)<=horse_summon.get_horse_summon_prob_pct() then
						horse.summon()
						syschat("Z�rhl� at �a��r�ld�.")
					else
						syschat("Z�rhl� at �a��r�lamad�.")
					end
				end
                when 50052.use with horse.get_grade()==3 begin
					syschat("Asker at� �a��rman i�in Asker At Kitab� laz�m.")
                end
                when 50053.use with horse.get_grade()==0 begin
					syschat("�leri seviyedeki at� �a��rman i�in acemi at g�revini yapman laz�m.")
                end
                when 50053.use with horse.get_grade()==1 begin
					syschat("Acemi at� �a��rman i�in at resmi laz�m.")
                end
                when 50053.use with horse.get_grade()==2 begin
					syschat("Orta seviyedeki at� �a��rman i�in Z�rhl� At Kitab� laz�m.")
                end
                when 50053.use with horse.get_grade()==3 begin
					if horse.is_summon() == true then
						syschat("Zaten asker at� �a��rm��s�n.")
						return
					end
					if number(1, 100)<=horse_summon.get_horse_summon_prob_pct() then
						horse.summon()
						syschat("Asker at �a��r�ld�.")
					else
						syschat("Asker at �a��r�lamad�.")
					end
				end
	end
        state __COMPLETE__ begin
                when enter begin
                        q.done()
                end
        end
end
