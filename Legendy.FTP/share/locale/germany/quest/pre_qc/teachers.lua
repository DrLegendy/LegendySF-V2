quest skill_group begin
        state start begin
                when login or levelup with pc.level>=5 and pc.skillgroup ==0 begin
                        set_state(run)
                end
        end

        state run begin
                when login with pc.get_skill_group()!=0 begin
                        restart_quest()
                end

                when letter with pc.get_skill_group()==0 begin
                        send_letter("Beceri E�itimi")

                        local job=pc.get_job()

                        if job==0 then
                                local v=pc_find_skill_teacher_vid(1)
                                if 0!=v then target.vid("teacher1", v, "Bedensel Savas �gretmeni") end
                                local v=pc_find_skill_teacher_vid(2)
                                if 0!=v then target.vid("teacher2", v, "Zihinsel Savas �gretmeni") end
                        elseif job==1 then
                                local v=pc_find_skill_teacher_vid(1)
                                if 0!=v then target.vid("teacher3", v, "Yakin D�v�� �gretmeni") end
                                local v=pc_find_skill_teacher_vid(2)
                                if 0!=v then target.vid("teacher4", v, "Uzak D�v�� �gretmeni") end
                        elseif job==2 then
                                local v=pc_find_skill_teacher_vid(1)
                                if 0!=v then target.vid("teacher5", v, "B�y�l� Silah �gretmeni") end
                                local v=pc_find_skill_teacher_vid(2)
                                if 0!=v then target.vid("teacher6", v, "Kara B�y� �gretmeni") end
                        elseif job==3 then
                                local v=pc_find_skill_teacher_vid(1)
                                if 0!=v then target.vid("teacher7", v, "Ejderha G�c� �gretmeni") end
                                local v=pc_find_skill_teacher_vid(2)
                                if 0!=v then target.vid("teacher8", v, "iyilestirme �gretmeni") end
                        clear_letter()
                        end
                end

                when leave begin
                        target.delete("teacher1")
                        target.delete("teacher2")
                        target.delete("teacher3")
                        target.delete("teacher4")
                        target.delete("teacher5")
                        target.delete("teacher6")
                        target.delete("teacher7")
                        target.delete("teacher8")
                end

                when button or info begin
                        if pc.job == 0 then
                                say_title("Sava��� E�itimi ��retmeni:")
                                say("")
                                say_reward("E�er hayran olunan bir sava��� olmak istiyorsan, ")
                                say_reward("h�zl� ve tekrarlanan sald�r� bilgisi veren ")
                                say_reward("Bedensel Sava�� ��renmelisin. E�er t�m canavar ")
                                say_reward("gruplar�n� bir vuru�ta �ld�rmek istiyorsan, ")
                                say_reward("Zihinsel Sava� ��renmelisin. ")
                                say_reward("K�y yak�nlar�nda gelmeni bekleyece�iz.")
                                say("")
                        elseif pc.job == 1 then
                                say_title("Ninja E�itimi ��retmeni:")
                                say("")
                                say_reward("E�er iyi bir ni�anc� olarak tan�nmak istiyorsan, ")
                                say_reward("Uzak D�v�� sanat�n� ��ren. ")
                                say_reward("E�er, karanl���n korumas�nda ninja olarak ")
                                say_reward("farkl�, gizli g�revleri ba�armak istiyorsan ")
                                say_reward("Yak�n D�v�� sanat� senin i�in daha uygun.")
                                say_reward("K�y yak�nlar�nda gelmeni bekleyece�iz. ")
                                say("")
                        elseif pc.job == 2 then
                                say_title("Sura E�itimi ��retmeni:")
                                say("")
                                say_reward("�nsan �st� yetenekleri olan ger�ek bir temsilci")
                                say_reward("ve binici olmak m� istiyorsun? Sana B�y�l� Silah")
                                say_reward("��retmenini �neririm.Fakat,karanl�k b�y�c� ve")
                                say_reward("lanetler gibi korkulan olmak istiyorsan,")
                                say_reward("sana Kara B�y� ��retmenini")
                                say_reward("�neririm.")
                                say_reward("K�y yak�nlar�nda gelmeni bekleyece�iz. ")
                                say("")
                        elseif pc.job == 3 then
                                say_title("�aman E�itimi ��retmeni:")
                                say("")
                                say_reward("E�er b�y� ve kutsamalar� kontrol eden")
                                say_reward("bir �aman olmak istiyorsan ,Ejderha G�c� ")
                                say_reward("��retmenine git.E�er di�erlerinin")
                                say_reward("�z�nt�lerini ve ac�lar�n� azaltmak")
                                say_reward("istiyorsan,sana iyile�tirme ��retmenini")
                                say_reward("�neririm. ")
                                say_reward("K�y yak�nlar�nda gelmeni bekleyece�iz. ")
                                say("")
                        end
                        ---setleftimage("")

                        select("Onayla")
                        setskin(NOWINDOW)
                end

                -- Arahan Troop
                when teacher1.target.click or
                        skill_group1_1.chat."Bedensel Sava� e�itimine ba�la" or
                        skill_group2_1.chat."Bedensel Sava� e�itimine ba�la" or
                        skill_group3_1.chat."Bedensel Sava� e�itimine ba�la"
                        begin
                        target.delete("teacher1")

                        ----------------------------------------------
                        local pc_job=pc.get_job()
                        if pc_job != 0 then -- !!!
                                ---                                                   l
                                say_title("Yanl�� E�itim ")
                                say("")
                                say("�z�r dilerim.")
                                say("Sadece Sava���lar Bedensel Sava�� se�ebilir.")
                                say("")
                                say("")

                                if pc_job==0 then
                                        ---                                                   l
                                        say_reward("Bir Sava���,  Zihinsel Sava�� ")
                                        say_reward("veya Bedensel Sava�� ")
                                        say_reward("se�ebilir.")
                                elseif pc_job==1 then
                                        say_reward("Bir Ninja, Yakin D�v�� veya")
                                        say_reward("Uzak D�v�� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==2 then
                                        say_reward("Bir Sura, B�y�l� Silah")
                                        say_reward("veya Kara B�y� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==3 then
                                        say_reward("Bir �aman, Ejderha G�c� e�itimini")
                                        say_reward("veya �yile�tirme e�itimini")
                                        say_reward("se�ebilir.")
                                end
                                say("")
                                return
                        end
                        ----------------------------------------------

                        say_title("Bedensel Sava� e�itimi")
                        ---                                                   l
                        say("Bedensel sava� e�itimi h�zl� sava�ma e�itimi ve")
                        say("metodlar�n�, ayr�ca geli�mi� temel sald�r� ")
                        say("tiplerini i�erir.")
                        say_reward("Gereksinim: Seviye 5 ve �st� bir sava��� olmak")
                        say("")


                        ----------------------------------------------
                        local s=select("Ba�la", "Daha sonra")

                        if 2 == s then
                                return
                        end

                        if pc.get_job()!=0 or pc.get_skill_group()!=0 then
                                test_chat("npc_is_same_job:"..bool_to_str(npc_is_same_job()))
                                test_chat("pc.get_skill_group:"..pc.get_skill_group())
                                test_chat("pc_job:"..pc.get_job())
                                return
                        end

                        set_state("start")
                        pc.set_skill_group(1) -- !!!
                        pc.clear_skill()
                        char_log(0, "CLEAR_SKILL", "�gretmen silindikten sonraki dogal yetenek.")
                        ----------------------------------------------

                        say_title("Bedensel sava� e�itimini se�tin.")
                        ---                                                   l
                        say("Ho�geldin!")

                        if not pc.is_clear_skill_group() then
                                ---                                                   l
                                say("Ders almay� se�ti�in i�in becerilerini ")
                                say("normal olarak veriyorum")
                                say("Geli�tirmek i�in beceri kitab�na ihtiyacin olacak.")
                                say_title("Bilgi:")
                                say_reward("Becerilerin normal Olarak Verildi.")
                                say("")
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
                        else
                                say_reward("Yeni bir ders se�tiginde,")
                                say_reward("daha fazla tecr�be puani almayacaksin.")
                                say("")
                        end
                        clear_letter()
                end

                -- Byulki Troop
                when teacher2.target.click or
                        skill_group1_2.chat."Zihinsel-Sava� e�itimine ba�la" or
                        skill_group2_2.chat."Zihinsel-Sava� e�itimine ba�la" or
                        skill_group3_2.chat."Zihinsel-Sava� e�itimine ba�la"
                        begin
                        target.delete("teacher2")

                        ----------------------------------------------
                        local pc_job=pc.get_job()
                        if pc_job != 0 then
                                ---                                                   l
                                say_title("Yanl�� E�itim ")
                                say("")
                                say("�z�r Dilerim.")
                                say("Sadece Sava���lar Zihinsel Sava�� ")
                                say("se�ebilir.")
                                say("")

                                if pc_job==0 then
                                        ---                                                   l
                                        say_reward("Bir Sava��� , Zihinsel Sava�� ")
                                        say_reward("veya Bedensel Sava�� ")
                                        say_reward("se�ebilir.")
                                elseif pc_job==1 then
                                        say_reward("Bir Ninja, Yak�n D�v�� veya")
                                        say_reward("Uzak D�v�� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==2 then
                                        say_reward("Bir Sura, B�y�l� Silah")
                                        say_reward("veya Kara B�y� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==3 then
                                        say_reward("Bir saman ,Ejderha G�c� e�itimini")
                                        say_reward("veya iyilestirme e�itimini")
                                        say_reward("se�ebilir.")
                                end
                                say("")
                                return
                        end
                        ----------------------------------------------

                        say_title("Zihinsel Sava� e�itimi")
                        say("")
                        ---                                                   l
                        say("Zihinsel sava� e�itimi sana d��manlar�na nas�l")
                        say("g��l� chi-sald�r�lar� yapabilece�ini ve kendini")
                        say("d��man sald�r�lar�ndan koruyabilece�ini ��retir.")
                        say_reward("Gereksinim: Seviye 5 ve �st� bir sava��� olmak")
                        say("")

                        ----------------------------------------------
                        local s=select("Ba�la", "Daha sonra")

                        if 2 == s then
                                return
                        end

                        if pc.get_job()!=0 or pc.get_skill_group()!=0 then
                                test_chat("npc_is_same_job:"..bool_to_str(npc_is_same_job()))
                                test_chat("pc.get_skill_group:"..pc.get_skill_group())
                                test_chat("pc_job:"..pc.get_job())
                                return
                        end

                        set_state("start")
                        pc.set_skill_group(2)
                        pc.clear_skill()
                        char_log(0, "CLEAR_SKILL", "�gretmen silindikten sonraki dogal yetenek")
                        ----------------------------------------------


                        say_title("Zihinsel sava� e�itimini se�tin.")
                        ---                                                   l
                        say("Ho�geldin!")

                        if not pc.is_clear_skill_group() then
                                           ---                                                   l
								say("Ders almay� se�ti�in i�in becerilerini ")
                                say("normal olarak veriyorum")
                                say("Geli�tirmek i�in beceri kitab�na ihtiyacin olacak.")
                                say_title("Bilgi:")
                                say_reward("Becerilerin normal Olarak Verildi.")
                                say("")
								pc.set_skill_level (137,20)
                                pc.set_skill_level (138,20)
                                pc.set_skill_level (139,20)
                                pc.set_skill_level (131,20)
								pc.set_skill_level (129,40)
								pc.set_skill_level (128,20)
								pc.set_skill_level (127,20)
								pc.set_skill_level (126,20)
								pc.set_skill_level (124,40)
								pc.set_skill_level (121,40)
								pc.set_skill_level (122,2)
                        else
                                say_reward("Yeni bir ders se�tiginde,")
                                say_reward("daha fazla tecr�be puani almayacaksin.")
                                say("")
                        end
                        clear_letter()
                end


                -- Bisal Troop
                when teacher3.target.click or
                        skill_group1_3.chat."Yakin D�v�� e�itimine ba�la" or
                        skill_group2_3.chat."Yakin D�v�� e�itimine ba�la" or
                        skill_group3_3.chat."Yakin D�v�� e�itimine ba�la"
                        begin
                        target.delete("teacher3")


                        ----------------------------------------------
                        local pc_job=pc.get_job()
                        if pc_job != 1 then -- !!!
                                ---                                                   l
                                say_title("Yanl�� E�itim ")
                                say("")
                                say("�z�r Dilerim.")
                                say("Sadece Ninjalar Yak�n D�v�� e�itimini se�ebilir.")
                                say("")

                                if pc_job==0 then
                                        ---                                                   l
                                        say_reward("Bir Sava���,  Zihinsel Sava�� ")
                                        say_reward("veya Bedensel Sava�� ")
                                        say_reward("se�ebilir.")
                                elseif pc_job==1 then
                                        say_reward("Bir Ninja ,Yak�n D�v�� veya")
                                        say_reward("Uzak D�v�� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==2 then
                                        say_reward("Bir Sura, B�y�l� Silah")
                                        say_reward("veya Kara B�y� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==3 then
                                        say_reward("Bir saman, Ejderha G�c� e�itimini")
                                        say_reward("veya iyilestirme e�itimini")
                                        say_reward("se�ebilir.")
                                end
                                say("")
                                return
                        end
                        ----------------------------------------------
                        say_title("Yak�n D�v�� e�itimi")
                        say("")
                        ---                                                   l
                        say("Yakin D�v�� e�itiminde ,Ninjalara d��manlar�n�n ")
                        say("zay�f noktalar�na , nas�l h�zl� ve �l�mc�l")
                        say("vuru�lar yapabilecekleri ��retilir.")
                        say_reward("Gereksinim: Seviye 5 ve �st� bir sava��� olmak")
                        say("")

                        ----------------------------------------------
                        local s=select("Ba�la", "Daha Sonra")

                        if 2 == s then
                                return
                        end

                        if pc.get_job()!=1 or pc.get_skill_group()!=0 then
                                test_chat("npc_is_same_job:"..bool_to_str(npc_is_same_job()))
                                test_chat("pc.get_skill_group:"..pc.get_skill_group())
                                test_chat("pc_job:"..pc.get_job())
                                return
                        end

                        set_state("start")
                        pc.set_skill_group(1) -- !!!
                        pc.clear_skill()
                        char_log(0, "CLEAR_SKILL", "�gretmen silindikten sonraki dogal yetenek")
                        ----------------------------------------------

                        say_title("Yak�n D�v�� e�itimini se�tin.")
                        ---                                                   l
                        say("Ho�geldin!")

                        if not pc.is_clear_skill_group() then
                                ---                                                   l
								say("Ders almay� se�ti�in i�in becerilerini ")
                                say("normal olarak veriyorum")
                                say("Geli�tirmek i�in beceri kitab�na ihtiyacin olacak.")
                                say_title("Bilgi:")
                                say_reward("Becerilerin normal Olarak Verildi.")
                                say("")
								pc.set_skill_level (137,20)
                                pc.set_skill_level (138,20)
                                pc.set_skill_level (139,20)
								pc.set_skill_level (140,20)
                                pc.set_skill_level (131,20)
								pc.set_skill_level (129,40)
								pc.set_skill_level (128,20)
								pc.set_skill_level (127,20)
								pc.set_skill_level (126,20)
								pc.set_skill_level (124,40)
								pc.set_skill_level (121,40)
								pc.set_skill_level (122,2)
                        else
                                say_reward("Yeni bir ders se�ti�inde,")
                                say_reward("daha fazla tecr�be puan� almayacaks�n.")
                                say("")
                        end
                        clear_letter()
                end


                -- Kangno Troop
                when teacher4.target.click or
                        skill_group1_4.chat."Yak�n D�v�� e�itimine ba�la" or
                        skill_group2_4.chat."Yak�n D�v�� e�itimine ba�la" or
                        skill_group3_4.chat."Yak�n D�v�� e�itimine ba�la"
                        begin
                        target.delete("teacher4")

                        ----------------------------------------------
                        local pc_job=pc.get_job()
                        if pc_job != 1 then -- !!!
                                ---                                                   l
                                say_title("Yanl�� E�itim ")
                                say("")
                                say("�z�r Dilerim.")
                                say("Sadece Ninjalar Uzak D�v�� e�itimini se�ebilir.")
                                say("")

                                if pc_job==0 then
                                        ---                                                   l
                                        say_reward("Bir Sava���,  Zihinsel Sava�� ")
                                        say_reward("veya Bedensel Sava�� ")
                                        say_reward("se�ebilir.")
                                elseif pc_job==1 then
                                        say_reward("Bir Ninja, Yak�n D�v�� veya")
                                        say_reward("Uzak D�v�� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==2 then
                                        say_reward("Bir Sura, B�y�l� Silah")
                                        say_reward("veya Kara B�y� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==3 then
                                        say_reward("Bir saman ,Ejderha G�c� e�itimini")
                                        say_reward("veya �yile�tirme e�itimini")
                                        say_reward("se�ebilir.")
                                end
                                say("")
                                return
                        end
                        ----------------------------------------------

                        say_title("Uzak D�v�� e�itimi")
                        say("")
                        ---                                                   l
                        say("Uzak D�v�� e�itiminde ,Ninjalara nas�l ok")
                        say("kullanmalar� gerekti�i ve uzak mesafeden")
                        say("d��manlar�yla dikkatli sava�malar� ��retilir.")
                        say_reward("Gereksinim: Seviye 5 ve �st� bir sava��� olmak")
                        say("")

                        ----------------------------------------------
                        local s=select("Ba�la", "Daha sonra")

                        if 2 == s then
                                return
                        end

                        if pc.get_job()!=1 or pc.get_skill_group()!=0 then
                                test_chat("npc_is_same_job:"..bool_to_str(npc_is_same_job()))
                                test_chat("pc.get_skill_group:"..pc.get_skill_group())
                                test_chat("pc_job:"..pc.get_job())
                                return
                        end

                        set_state("start")
                        pc.set_skill_group(2) -- !!!
                        pc.clear_skill()
                        char_log(0, "CLEAR_SKILL", "�gretmen silindikten sonraki dogal yetenek")
                        ----------------------------------------------

                        say_title("Uzak D�v�� e�itimini se�tin.")
                        ---                                                   l
                        say("Ho�geldin!")

                        if not pc.is_clear_skill_group() then
                                           ---                                                   l
								say("Ders almay� se�ti�in i�in becerilerini ")
                                say("normal olarak veriyorum")
                                say("Geli�tirmek i�in beceri kitab�na ihtiyacin olacak.")
                                say_title("Bilgi:")
                                say_reward("Becerilerin normal Olarak Verildi.")
                                say("")
								pc.set_skill_level (137,20)
                                pc.set_skill_level (138,20)
                                pc.set_skill_level (139,20)
								pc.set_skill_level (140,20)
                                pc.set_skill_level (131,10)
								pc.set_skill_level (129,40)
								pc.set_skill_level (128,20)
								pc.set_skill_level (127,20)
								pc.set_skill_level (126,20)
								pc.set_skill_level (124,40)
								pc.set_skill_level (121,40)
								pc.set_skill_level (122,2)
                        else
                                say_reward("Yeni bir ders se�ti�inde,")
                                say_reward("daha fazla tecr�be puan� almayacaks�n.")
                                say("")
                        end
                        clear_letter()
                end


                -- Hwanmoo Troop
                when teacher5.target.click or
                        skill_group1_5.chat."B�y�l� Silah e�itimine ba�la" or
                        skill_group2_5.chat."B�y�l� Silah e�itimine ba�la" or
                        skill_group3_5.chat."B�y�l� Silah e�itimine ba�la"
                        begin
                        target.delete("teacher5")

                        ----------------------------------------------
                        local pc_job=pc.get_job()
                        if pc_job != 2 then -- !!!
                                ---                                                   l
                                say_title("Yanl�� E�itim ")
                                say("")
                                say("�z�r Dilerim.")
                                say("Sadece Suralar B�y�l� Silah e�itimini")
                                say("se�ebilir.")
                                say("")

                                if pc_job==0 then
                                        ---                                                   l
                                        say_reward("Bir Sava���,  Zihinsel Sava�� ")
                                        say_reward("veya Bedensel Sava�� ")
                                        say_reward("se�ebilir.")
                                elseif pc_job==1 then
                                        say_reward("Bir Ninja, Yak�n D�v�� veya")
                                        say_reward("Uzak D�v�� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==2 then
                                        say_reward("Bir Sura, B�y�l� Silah")
                                        say_reward("veya Kara B�y� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==3 then
                                        say_reward("Bir saman, Ejderha G�c� e�itimini")
                                        say_reward("veya �yile�tirme e�itimini")
                                        say_reward("se�ebilir.")
                                end
                                say("")
                                return
                        end
                        ----------------------------------------------

                        say_title("B�y�l� Silah e�itimi")
                        say("")
                        ---                                                   l
                        say("B�y� Silah e�itiminde ,zay�flat�lm�� d��manlara")
                        say("kar�� ,lanetli b��aklar� kullanarak g��l� ")
                        say("darbe vurma y�ntemleri ��retilir.")
                        say_reward("Gereksinim: Seviye 5 ve �st� bir sava��� olmak")
                        say("")

                        ----------------------------------------------
                        local s=select("Ba�la", "Daha sonra")

                        if 2 == s then
                                return
                        end

                        if pc.get_job()!=2 or pc.get_skill_group()!=0 then
                                test_chat("npc_is_same_job:"..bool_to_str(npc_is_same_job()))
                                test_chat("pc.get_skill_group:"..pc.get_skill_group())
                                test_chat("pc_job:"..pc.get_job())
                                return
                        end

                        set_state("start")
                        pc.set_skill_group(1) -- !!!
                        pc.clear_skill()
                        char_log(0, "CLEAR_SKILL", "�gretmen silindikten sonraki dogal yetenek")
                        ----------------------------------------------


                        say_title("B�y�l� Silah e�itimini se�tin.")
                        ---                                                   l
                        say("Ho�geldin!")

                        if not pc.is_clear_skill_group() then
                                           ---                                                   l
								say("Ders almay� se�ti�in i�in becerilerini ")
                                say("normal olarak veriyorum")
                                say("Geli�tirmek i�in beceri kitab�na ihtiyacin olacak.")
                                say_title("Bilgi:")
                                say_reward("Becerilerin normal Olarak Verildi.")
                                say("")
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
                        else
                                say_reward("Yeni bir ders se�tiginde,")
                                say_reward("daha fazla tecr�be puani almayacaksin.")
                                say("")
                        end
                        clear_letter()
                end


                -- Black Horse Troop
                when teacher6.target.click or
                        skill_group1_6.chat."Kara B�y� e�itimine ba�la" or
                        skill_group2_6.chat."Kara B�y� e�itimine ba�la" or
                        skill_group3_6.chat."Kara B�y� e�itimine ba�la"
                        begin
                        target.delete("teacher6")

                        ----------------------------------------------
                        local pc_job=pc.get_job()
                        if pc_job != 2 then -- !!!
                                ---                                                   l
                                say_title("Yanl�� E�itim ")
                                say("")
                                say("�z�r Dilerim.")
                                say("Sadece Suralar Kara B�y� e�itimini")
                                say("se�ebilir.")
                                say("")

                                if pc_job==0 then
                                        ---                                                   l
                                        say_reward("Bir Sava���,  Zihinsel Sava�� ")
                                        say_reward("veya Bedensel Sava�� ")
                                        say_reward("se�ebilir.")
                                elseif pc_job==1 then
                                        say_reward("Bir Ninja, Yak�n D�v�� veya")
                                        say_reward("Uzak D�v�� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==2 then
                                        say_reward("Bir Sura, B�y�l� Silah")
                                        say_reward("veya Kara B�y� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==3 then
                                        say_reward("Bir saman, Ejderha G�c� e�itimini")
                                        say_reward("veya �yile�tirme e�itimini")
                                        say_reward("se�ebilir.")
                                end
                                say("")
                                return
                        end
                        ----------------------------------------------

                        say_title("Kara B�y� e�itimi")
                        say("")
                        ---                                                   l
                        say("Kara B�y� e�itiminde, uzak mesafeden ")
                        say("d�smanlarini zayif d�s�ren  lanet y�ntemleri")
                        say("�gretilir.")
                        say_reward("Gereksinim: Seviye 5 ve �st� bir sava��� olmak")
                        say("")

                        ----------------------------------------------
                        local s=select("Ba�la", "Daha sonra")

                        if 2 == s then
                                return
                        end

                        if pc.get_job()!=2 or pc.get_skill_group()!=0 then
                                test_chat("npc_is_same_job:"..bool_to_str(npc_is_same_job()))
                                test_chat("pc.get_skill_group:"..pc.get_skill_group())
                                test_chat("pc_job:"..pc.get_job())
                                return
                        end

                        set_state("start")
                        pc.set_skill_group(2) -- !!!
                        pc.clear_skill()
                        char_log(0, "CLEAR_SKILL", "�gretmen silindikten sonraki dogal yetenek.")
                        ----------------------------------------------

                        say_title("Kara B�y� e�itimini se�tin.")
                        ---                                                   l
                        say("Ho�geldin!")

                        if not pc.is_clear_skill_group() then
                                           ---                                                   l
								say("Ders almay� se�ti�in i�in becerilerini ")
                                say("normal olarak veriyorum")
                                say("Geli�tirmek i�in beceri kitab�na ihtiyacin olacak.")
                                say_title("Bilgi:")
                                say_reward("Becerilerin normal Olarak Verildi.")
                                say("")
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
                        else
                                say_reward("Yeni bir ders se�tiginde,")
                                say_reward("daha fazla tecr�be puani almayacaksin.")
                                say("")
                        end
                        clear_letter()
                end


                -- Heavenly Dragon Troop
                when teacher7.target.click or
                        skill_group1_7.chat."Ejderha G�c� e�itimine ba�la" or
                        skill_group2_7.chat."Ejderha G�c� e�itimine ba�la" or
                        skill_group3_7.chat."Ejderha G�c� e�itimine ba�la"
                        begin
                        target.delete("teacher7")

                        ----------------------------------------------
                        local pc_job=pc.get_job()
                        if pc_job != 3 then -- !!!
                                ---                                                   l
                                say_title("Yanl�� E�itim ")
                                say("")
                                say("�z�r Dilerim.")
                                say("Sadece samanlar Ejderha G�c� e�itimini")
                                say("se�ebilir.")
                                say("")

                                if pc_job==0 then
                                        ---                                                   l
                                        say_reward("Bir Sava���, Zihinsel Sava�� ")
                                        say_reward("veya Bedensel Sava�� ")
                                        say_reward("se�ebilir.")
                                elseif pc_job==1 then
                                        say_reward("Bir Ninja, Yakin D�v�� veya")
                                        say_reward("Uzak D�v�� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==2 then
                                        say_reward("Bir Sura, B�y�l� Silah")
                                        say_reward("veya Kara B�y� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==3 then
                                        say_reward("Bir saman, Ejderha G�c� e�itimini")
                                        say_reward("veya iyilestirme e�itimini")
                                        say_reward("se�ebilir.")
                                end
                                say("")
                                return
                        end
                        ----------------------------------------------

                        say_title("Ejderha G�c� e�itimi")
                        say("")
                        ---                                                   l
                        say("Ejderha G�c� e�itiminde, Ejderha Tanr�n�n ")
                        say("g��l� ate� sald�r�lar�n� y�netmeyi ve ")
                        say("dayan�kl�l�k b�y�leriyle Ejderha Tanr�n�n ")
                        say("korumas�n� kullanmayi �grenirler.")
                        say_reward("Gereksinim: Seviye 5 ve �st� bir sava��� olmak")
                        say("")

                        ----------------------------------------------
                        local s=select("Ba�la", "Daha sonra")

                        if 2 == s then
                                return
                        end

                        if pc.get_job()!=3 or pc.get_skill_group()!=0 then
                                test_chat("npc_is_same_job:"..bool_to_str(npc_is_same_job()))
                                test_chat("pc.get_skill_group:"..pc.get_skill_group())
                                test_chat("pc_job:"..pc.get_job())
                                return
                        end

                        set_state("start")
                        pc.set_skill_group(1) -- !!!
                        pc.clear_skill()
                        char_log(0, "CLEAR_SKILL", "�gretmen silindikten sonraki dogal yetenek.")
                        ----------------------------------------------

                        say_title("Ejderha G�c� e�itimini se�tin.")
                        ---                                                   l
                        say("Ho�geldin!")

                        if not pc.is_clear_skill_group() then
                                           ---                                                   l
								say("Ders almay� se�ti�in i�in becerilerini ")
                                say("normal olarak veriyorum")
                                say("Geli�tirmek i�in beceri kitab�na ihtiyacin olacak.")
                                say_title("Bilgi:")
                                say_reward("Becerilerin normal Olarak Verildi.")
                                say("")
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
                        else
                                say_reward("Yeni bir ders se�tiginde,")
                                say_reward("daha fazla tecr�be puani almayacaksin.")
                                say("")
                        end
                        clear_letter()
                end


                -- Thunder Light Troop
                when teacher8.target.click or
                        skill_group1_8.chat."�yile�tirme e�itimine ba�la" or
                        skill_group2_8.chat."�yile�tirme e�itimine ba�la" or
                        skill_group3_8.chat."�yile�tirme e�itimine ba�la"
                        begin
                        target.delete("teacher8")

                        ----------------------------------------------
                        local pc_job=pc.get_job()
                        if pc_job != 3 then -- !!!
                                ---                                                   l
                                say_title("Yanl�� E�itim ")
                                say("")
                                say("�z�r Dilerim.")
                                say("Sadece �amanlar �yile�tirme E�itimi")
                                say("se�ebilir.")
                                say("")

                                if pc_job==0 then
                                        ---                                                   l
                                        say_reward("Bir Sava���,  Zihinsel Sava�� ")
                                        say_reward("veya Bedensel Sava�� ")
                                        say_reward("se�ebilir.")
                                elseif pc_job==1 then
                                        say_reward("Bir Ninja, Yak�n D�v�� veya")
                                        say_reward("Uzak D�v�� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==2 then
                                        say_reward("Bir Sura, B�y�l� Silah")
                                        say_reward("veya Kara B�y� e�itimini")
                                        say_reward("se�ebilir.")
                                elseif pc_job==3 then
                                        say_reward("Bir saman ,Ejderha G�c� e�itimini")
                                        say_reward("veya �yile�tirme e�itimini")
                                        say_reward("se�ebilir.")
                                end
                                say("")
                                return
                        end

                        ----------------------------------------------

                        say_title("�yile�tirme e�itimi")
                        say("")
                        ---                                                   l
                        say("�yile�tirme e�itiminde, d��manlar�n� ")
                        say("uyu�turmay�, ve kendi grup �yelerini")
                        say("iyile�tirerek g��lendirmeyi ��renirler.")
                        say_reward("Gereksinim: Seviye 5 ve �st� bir sava��� olmak")
                        say("")

                        ----------------------------------------------
                        local s=select("Ba�la", "Daha sonra")

                        if 2 == s then
                                return
                        end

                        if pc.get_job()!=3 or pc.get_skill_group()!=0 then
                                test_chat("npc_is_same_job:"..bool_to_str(npc_is_same_job()))
                                test_chat("pc.get_skill_group:"..pc.get_skill_group())
                                test_chat("pc_job:"..pc.get_job())
                                return
                        end

                        set_state("start")
                        pc.set_skill_group(2) -- !!!
                        pc.clear_skill()
                        char_log(0, "CLEAR_SKILL", "�gretmen silindikten sonraki dogal yetenek.")
                        ----------------------------------------------

                        say_title("�yile�tirme e�itimini se�tin.")
                        ---                                                   l
                        say("Ho�geldin!")

                        if not pc.is_clear_skill_group() then
                                           ---                                                   l
								say("Ders almay� se�ti�in i�in becerilerini ")
                                say("normal olarak veriyorum")
                                say("Geli�tirmek i�in beceri kitab�na ihtiyacin olacak.")
                                say_title("Bilgi:")
                                say_reward("Becerilerin normal Olarak Verildi.")
                                say("")
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
                        else
                                say_reward("Yeni bir ders se�tiginde,")
                                say_reward("daha fazla tecr�be puani almayacaksin.")
                                say("")
                        end
                        clear_letter()
                end

        end -- end_of_state: run
end -- end_of_quest
