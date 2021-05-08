quest marriage_manage begin
    state start begin
        when oldwoman.chat."Evlenmek istiyorum" with not pc.is_engaged_or_married() begin
            if not npc.lock() then
                say_title("Ya�l� Kad�n:")
                say("")
                say("�u anda ba�ka bir d���n var!")
                say("Biraz bekle ya da sonra tekrar gel!")
                return
            end
            if pc.level < 25 then
                say_title("Ya�l� Kad�n:")
                say("")
                say("Evlenmek i�in �ok gen�sin...")
                say("Yeterli sorumlulu�u kazanmal�s�n ve hen�z")
                say("haz�r de�ilsin. Gen� insanlar �abuk ayr�l�rlar.")
                say("Bunu tasvip etmiyorum. Git ve")
                say("biraz daha tecr�be kazan.")
                say("")
                say_title("Bilgi:")
                say("")
                say_reward("25.seviyeden sonra evlenebilirsin. ")
                say("")
                npc.unlock()
                return
            end

            local m_ring_num = pc.countitem(70301)
            local m_has_ring = m_ring_num > 0
            if not m_has_ring then
                say_title("Ya�l� Kad�n:")
                say("")
                say("Nikah y�z��� olmadan m� evlenmek istiyorsun?")
                say("")
                say_item("Nikah y�z��� ", 70302, "")
                say("�nce, s�z y�z��� almal�s�n. Ancak ondan")
                say("sonra evlenebilirsin. ")
                say("")
                npc.unlock()

                return
            end

            local m_sex = pc.get_sex()
            if not marriage_manage.is_equip_wedding_dress() then
                say_title("Ya�l� Kad�n:")
                say("")
                say("Bu sekilde evlenmek istedi�ine ger�ekten")
                say("emin misin? Hayatta sadece bir kere")
                say("evleniyorsun, en az�ndan buna uygun giyinmelisin.")
                say("")

                if m_sex==0 then
                    say_item("Smokin", marriage_manage.get_wedding_dress(pc.get_job()), "")
                    say_reward("E�er evlenmek istiyorsan bir smokin ")
                    say_reward("giymelisin.")
                else
                    say_item("Gelinlik", marriage_manage.get_wedding_dress(pc.get_job()), "")
                    say_reward("E�er evlenmek istiyorsan gelinlik")
                    say_reward("giymelisin.")
                end
                say("")
                npc.unlock()
                return
            end

            local NEED_MONEY = 1000000
            if pc.get_money() < NEED_MONEY then
                say_title("Ya�l� Kad�n:")
                say("")
                say("Biraz Yang'a ihtiyac�n var. ")
                say("Yeterli Yang'�n yok mu? Daha fazla Yang")
                say("kazan, en az 1 Milyon. ")
                say("")
                say_reward(string.format(" %d Yang'a ihtiyac�n var.", NEED_MONEY/10000))
                say("")
                npc.unlock()
                return
            end

            say_title("Ya�l� Kad�n:")
            say("")
            say("�imdi yeterince olgunsun. ")
            say("�yi g�r�n�yorsun. Kiminle evlenmek istiyorsun?")
            say("")
            say_reward("Ki�inin ad�n� yaz. ")

            local sname = input()
            if sname == "" then
                say_title("Ya�l� Kad�n:")
                say("")
                say("Heyecanl� m�s�n ismi ")
                say("yazamad�n? Tekrar dene.")
                say("")
                npc.unlock()
                return
            end

            local u_vid = find_pc_by_name(sname)
            local m_vid = pc.get_vid()
            if u_vid == 0 then
                say_title("Ya�l� Kad�n:")
                say("")
                say("Ad�n� bilmiyor musun?")
                say("Hala kararl� m�s�n? ")
                say("Evlenmek istedi�ine emin misin?")
                say("")
                say_reward(string.format("%s online de�il.", sname))
                say("")
                npc.unlock()
                return
            end

            if not npc.is_near_vid(u_vid, 10) then
                say_title("Ya�l� Kad�n:")
                say("")
                say("E�in yak�nda olmak zorunda , iste�ini ")
                say("ancak o zaman kabul edebilirim. ")
                say("E�ini buraya getir. ")
                say("")
                say_reward(string.format("%s �ok uzakta.", sname))
                say("")
                npc.unlock()
                return
            end

            local old = pc.select(u_vid)
            local u_level = pc.get_level()
            local u_job = pc.get_job()
            local u_sex = pc.get_sex()
            local u_name = pc.name
            local u_gold = pc.get_money()
            local u_married = pc.is_married()
            local u_has_ring = pc.countitem(70301) > 0
            local u_wear = marriage_manage.is_equip_wedding_dress()
            pc.select(old)
            local m_level = pc.get_level()

            if u_vid == m_vid then
                say_title("Ya�l� Kad�n:")
                say("")
                say("Senin ad�n de�il, e�inin ad�. ")
                say("")
                say_reward("E�inin ad�n� yaz.")
                say("")
                npc.unlock()
                return
            end

            if u_sex == m_sex then
                say_title("Ya�l� Kad�n:")
                say("")
                say("�z�r dilerim.")
                say("")
                say("Ayn� cinsteki bir insanla evlenemezsin.")
                say("")
                npc.unlock()
                return
            end

            if u_married then
                say_title("Ya�l� Kad�n:")
                say("")
                say("Evlenmek istedigin ki�i zaten evli ,")
                say("bunu biliyor muydun?")
                say("Yaln�z birini bul.")
                say("")
                say_reward(string.format("%s evli.", sname))
                say("")
                npc.unlock()
                return
            end

            if u_level < 25 then
                say_title("Ya�l� Kad�n:")
                say("")
                say("Ki�i yeterince olgun de�il. ")
                say("E�in de en az 25.seviyede olmal�.")
                say("")
                npc.unlock()
                return
            end

            if m_level - u_level > 15 or u_level - m_level > 15 then
                say_title("Ya�l� Kad�n:")
                say("")
                say("Siz uyumlu bir �ift de�ilsiniz.")
                say("Bu evlili�i onaylayamam.")
                say("")
                say("Seviye fark� 15'den fazla olmamal�,")
                say("bu y�zden evlenemiyorsunuz.")
                say("")
                npc.unlock()
                return
            end

            if not u_has_ring then
                if m_ring_num >= 2 then
                    say_title("Ya�l� Kad�n:")
                    say("")
                    say("�imdi y�z�kleri de�i�tirin.")
                    say("")
                else
                    say("Ya�l� Kad�n:")
                    say("")
                    say("Evlilik hayat�n�zdaki en �nemli karard�r.")
                    say("En az�ndan e�ine nikah y�z��� ")
                    say("getirmi� olmal�s�n.")
                    say("")
                end

                say_item("Nikah y�z��� ", 70302, "")
                say_title("Ya�l� Kad�n:")
                say("")
                say("E�inin de nikah y�z��� olmal�.")
                say("haz�r m�?")
                say("")
                npc.unlock()
                return
            end

            if not u_wear then
                say_title("Ya�l� Kad�n:")
                say("")
                say("E�in evlilik k�yafet� giymemi�.")
                say("Onunla burda durmaktan s�k�lm�yor musun?")
                say("Hmm?")
                say("")
                if u_sex==0 then
                    say_title("Ya�l� Kad�n:")
                    say("")
                    say_item("Smokin ", marriage_manage.get_wedding_dress(u_job), "")
                    say("E�inin Smokin giymesi")
                    say("gerekiyor.")
                else
                    say_title("Ya�l� Kad�n:")
                    say("")
                    say_item("Gelinlik", marriage_manage.get_wedding_dress(u_job), "")
                    say("E�inin Gelinlik giymesi ")
                    say("gerekiyor.")
                end
                say("")
                npc.unlock()
                return
            end


            local ok_sign = confirm(u_vid, pc.name.."Evlenmek istiyor musun?", 30)
            if ok_sign == CONFIRM_OK then
                local m_name = pc.name
                if pc.get_gold()>=NEED_MONEY then
                    pc.change_gold(-NEED_MONEY)

                    pc.removeitem(70301, 1)
                    pc.give_item2(70302, 1)
                    local old = pc.select(u_vid)
                    pc.removeitem(70301, 1)
                    pc.give_item2(70302, 1)
                    pc.select(old)

                    say_title("Ya�l� Kad�n:")
                    say("")
                    say("Peki...biz haz�r�z.")
                    say("�imdi ba�layabiliriz. Sizi A��klar")
                    say("Adas�na g�nderece�im. Umar�m uzun ve")
                    say("mutlu bir evlili�iniz olur. Tebrikler..")
                    say("")
                    say("Daha sonra otomatik olarak A��klar Adas�'na")
                    say("g�nderileceksiniz.")
                    say("")
                    wait()
                    setskin(NOWINDOW)
                    marriage.engage_to(u_vid)
                end
            else
                say_title("Ya�l� Kad�n:")
                say("")
                say("E�in seninle evlenmek istemiyor.")
                say("�ncelikle bunu a��kl��a kavu�turun. ")
                say("")
            end
            say("")
            npc.unlock()
        end

        when oldwoman.chat."Nikah salonuna geri d�n." with pc.is_engaged() begin
            say_title("Ya�l� Kad�n:")
            say("")
            say("Neden hala burdas�n? ")
            say("E�in seni ariyor. ")
            say("Seni oraya g�nderece�im. ")
            say("")
            wait()
            setskin(NOWINDOW)
            marriage.warp_to_my_marriage_map()
        end


        when 9011.chat."Evlilik i�in izin" with pc.is_engaged() and marriage.in_my_wedding() begin
            if not npc.lock() then
                say_title("Nikah Memuru:")
                say("")
                say("E�inle konu�uyorum. Biraz bekle. ")
                say("")
                return
            end
            say_title("Nikah Memuru:")
            say("")
            say("Ben bir evlilik asistan�y�m.")
            say("ilk olarak e�inin ismini")
            say("yaz.")

            local sname = input()
            local u_vid = find_pc_by_name(sname)
            local m_vid = pc.get_vid()

            if u_vid == 0 then
                say_title("Nikah Memuru:")
                say("")
                say("B�yle bir isim kay�tl� de�il, ")
                say("Yazd���n� tekrar g�zden ge�ir. ")
                say("")
                say_reward(string.format("%s online de�il.", sname))
                say("")
                npc.unlock()
                return
            end

            if not npc.is_near_vid(u_vid, 10) then
                say_title("Nikah Memuru:")
                say("")
                say("�z�r dilerim. E�ini buraya getir,")
                say("Onu bilgilendirmeli ve")
                say("incelemeliyim.")
                say("")
                say_reward(string.format("%s burada olmal�.", sname))
                say("")
                npc.unlock()
                return
            end

            if u_vid == m_vid then
                say_title("Nikah Memuru:")
                say("")
                say("L�tfen kendi ad�n� yazma. ")
                say("")
                say("E�inin ad�n� yazmal�s�n.")
                say("")
                npc.unlock()
                return
            end

            if u_vid != marriage.find_married_vid() then
                say_title("Nikah Memuru:")
                say("")
                say("Bir �eyler yanl��. Bu do�ru insan de�il.")
                say("Kontrol ettin mi?")
                say("")
                npc.unlock()
                return
            end

            local ok_sign = confirm(u_vid, pc.name.."Evlenmek istiyor musun?", 30)
            if ok_sign != CONFIRM_OK then
                say_title("Nikah Memuru:")
                say("")
                say("E�in evlilik i�in haz�r de�il.")
                say("Birbirinizle konu�un.")
                say("")
                npc.unlock()
                return
            end
            say_title("Nikah Memuru:")
            say("")
            say("�imdi her �ey uygun, ba�layabiliriz.")

            marriage.set_to_marriage()

            say("")
            say("G�zel bir d���nd�.")
            say("")
            npc.unlock()
        end

        function give_wedding_gift()
            local male_item = {71072, 71073, 71074}
            local female_item = {71069, 71070, 71071}
            if pc.get_sex() == MALE then
                pc.give_item2(male_item[number(1, 3)], 1)
            else
                pc.give_item2(female_item[number(1, 3)], 1)
            end
        end

        when 9011.chat."D���n mar��n� �al" with
                    (pc.is_engaged() or pc.is_married()) and
                marriage.in_my_wedding() and
                not marriage.wedding_is_playing_music() begin
            marriage.wedding_music(true, "wedding.mp3")
            setskin(NOWINDOW)
        end
        when 9011.chat."D���n� mar��n� durdur" with
                    (pc.is_engaged() or pc.is_married()) and
                marriage.in_my_wedding() and
                marriage.wedding_is_playing_music() begin
            marriage.wedding_music(false, "default")
            setskin(NOWINDOW)
        end
        when 9011.chat."Gece efekti" with
            pc.is_married() and
            marriage.in_my_wedding() begin
            marriage.wedding_dark(true)
            setskin(NOWINDOW)
        end

        when 9011.chat."Kar ya�d�r" with pc.is_married() and marriage.in_my_wedding() begin
            marriage.wedding_snow(true)
            setskin(NOWINDOW)
        end

        when 9011.chat."D���n� bitir" with pc.is_married() and marriage.in_my_wedding() begin
            if not npc.lock() then
                say_title("Nikah Memuru:")
                say("")
                say("Biraz bekle, E�inle konu�uyorum.")
                say("")
                return
            end

            say_title("Nikah Memuru:")
            say("")
            say("D���n� bitirmek istiyor musun?")
            say("")
            local s = select("Evet","Hay�r")
            if s == 1 then
                local u_vid = marriage.find_married_vid()
                if u_vid == 0 then
                    say_title("Nikah Memuru:")
                    say("")
                    say("E�inin d���ne devam etmeyi kabul etmesi gerekli.")
                    say("")
                    say("d���n devam edemiyor ��nk� e�in")
                    say("online de�il.")
                    say("")
                    npc.unlock()
                    return
                end
                say_title("Nikah Memuru:")
                say("")
                say("E�inin onay� i�in beklemeliyiz.")
                say("Hen�z cevab� almad�k.")
                say("")
                local ok_sign = confirm(u_vid, "d���ne devam etmek istiyor musun? ", 30)
                if ok_sign == CONFIRM_OK then
                    marriage.end_wedding()
                else
                    say_title("Nikah Memuru:")
                    say("")
                    say("E�in onaylamad�!")
                    say("")
                end

                npc.unlock()
            end
        end


        when         11000.chat."Bosanma " or
                    11002.chat."Bosanma " or
                11004.chat."Bosanma " with pc.is_married() begin

            if not marriage_manage.check_divorce_time() then
                return
            end

            local u_vid = marriage.find_married_vid()
            if u_vid == 0 or not npc.is_near_vid(u_vid, 10) then
                say_title("K�y Gardiyan�:")
                say("")
                say("Bir e�in olmadan bo�anamazs�n.")
                say("")
                return
            end

            say_title("K�y Gardiyan�:")
            say("")
            say("Yasal bir ayr�l�k i�in")
            say("500.000 Yang ve e�inin")
            say("onay� gerekli.")
            say("Ger�ekten bo�anmak istiyor musun? ")
            say("")

            local MONEY_NEED_FOR_ONE = 500000
            local s = select("Evet", "Hay�r")

            if s == 1 then
                local m_enough_money = pc.gold > MONEY_NEED_FOR_ONE
                local m_have_ring = pc.countitem(70302) > 0

                local old = pc.select(u_vid)
                local u_enough_money = pc.gold > MONEY_NEED_FOR_ONE
                local u_have_ring = pc.countitem(70302) > 0
                pc.select(old)

                if not m_have_ring then
                    say("Nikah y�z���n� getir.")
                    return;
                end
                if not u_have_ring then
                    say("E�inin nikah y�z��� yan�nda de�il.")
                    return;
                end

                if not m_enough_money then
                    say_title("K�y Gardiyan�:")
                    say("")
                    say("Bosanmak i�in yeterli Yang'a sahip de�ilsin.")
                    say("")
                    say_reward(string.format("Bo�anmak i�in %d Yang gerekli.", MONEY_NEED_FOR_ONE/10000))
                    say("")
                    return;
                end
                if not u_enough_money then
                    say_title("K�y Gardiyan�:")
                    say("")
                    say("Bo�anmak i�in yeterli Yang'a sahip de�ilsin.")
                    say("")
                    say_reward("Bo�anmak i�in 500.000 Yang'a ihtiyac�n var.")
                    say("")
                    return;
                end
                say_title("K�y Gardiyan�:")
                say("")
                say("Ger�ekten bosanmak istiyor musun? Bu �ok b�y�k")
                say("bir hata olabilir.")
                say("")
                say("Ger�ekten istiyor musun?")
                say("")

                local c=select("Evet", "Hay�r")
                if 2 == c then
                    say_pc_name()
                    say("")
                    say("Fikrimi de�i�tirdim.")
                    say("Bosanmak istemiyorum.")
                    say("")
                    wait()
                    say_title("K�y Gardiyan�:")
                    say("")
                    say("Umar�m huzurlu ve uzun bir evlili�iniz olur.")
                    say("")
                    say_reward("Bo�anma ger�ekle�medi.")
                    say("")
                    return
                end

                local ok_sign = confirm(u_vid, pc.name.."Bo�anmak istedi�ine emin misin?", 30)
                if ok_sign == CONFIRM_OK then

                    local m_enough_money = pc.gold > MONEY_NEED_FOR_ONE
                    local m_have_ring = pc.countitem(70302) > 0

                    local old = pc.select(u_vid)
                    local u_enough_money = pc.gold > MONEY_NEED_FOR_ONE
                    local u_have_ring = pc.countitem(70302) > 0
                    pc.select(old)

                    if m_have_ring and m_enough_money and u_have_ring and u_enough_money then
                        pc.removeitem(70302, 1)
                        pc.change_money(-MONEY_NEED_FOR_ONE)

                        local old = pc.select(u_vid)
                        pc.removeitem(70302, 1)
                        pc.change_money(-MONEY_NEED_FOR_ONE)
                        pc.select(old)

                        say_title("K�y Gardiyan�:")
                        say("")
                        say("E�inden ayr�ld�n. Art�k evli de�ilsin.")
                        say("Belki de do�ru olan budur. Belki de")
                        say("mutlulu�u b�yle bulursun.")
                        say("")
                        say_reward("Bo�anma ger�ekle�ti.")
                        say("")
                        marriage.remove()
                    else
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Evraklar�n�z tam de�il.")
                        say("L�tfen sonra tekrar gelin.")
                        say("")
                        say_reward("Bo�anma iptal edildi.")
                        say("")
                    end
                else
                    say_title("K�y Gardiyan�:")
                    say("")
                    say("E�iniz bosanmak istemiyor.")
                    say("�nce anla�ma sa�lay�n.")
                    say("")
                    say_reward("Bo�anma iptal edildi.")
                    say("")
                end
            end
        end

        when         11000.chat."Nikah Y�z��� Silindi" or
                    11002.chat."Nikah Y�z��� Silindi" or
                11004.chat."Nikah Y�z��� Silindi" with
                        not pc.is_married()         and
                        pc.count_item(70302)>0
                        begin
                say_title("K�y Gardiyan�:")
                say("")
                say("K�t� hat�ralar� bir an �nce ")
                say("unutmal�s�n.")
                say("")
                say_reward("Nikah y�z��� silindi.")
                pc.remove_item(70302)
        end

        when         11000.chat."Tek tarafl� bo�anma" or
                    11002.chat."Tek tarafl� bo�anma" or
                11004.chat."Tek tarafl� bo�anma" with pc.is_married() begin

            if not marriage_manage.check_divorce_time() then
                return
            end

            say_title("K�y Gardiyan�:")
            say("")
            say("Tek tarafl� bo�anma i�in 1 milyona ihtiyac�n var.")
            say("Bo�anmak istiyor musun?")
            say("")

            local s = select("Evet", "Hay�r")

            local NEED_MONEY = 1000000
            if s == 2 then
                return
            end

            if pc.money < NEED_MONEY then
                say_title("K�y Gardiyan�:")
                say("")
                say("Bo�anmak i�in yeterli Yang yok.")
                say("")
                return
            end

            say_title("K�y Gardiyan�:")
            say("Bir yuva kurmak kolay de�ildir. Ger�ekten emin")
            say("olmadan b�yle b�y�k bir karar vermemelisin.")
            say("Ger�ekten bo�anmak istiyor musun?")

            local c = select("Evet ,istiyorum.","Tekrar d���nmeliyim.")

            if c == 2 then
                say_title("K�y Gardiyan�:")
                say("")
                say("Bu daha iyi.")
                say("E�er bunu ger�ekten istersen, sonra tekrar gel.")
                say("")
                return
            end

            pc.removeitem(70302, 1)
            pc.change_gold(-NEED_MONEY)

            marriage.remove()

            say_title("K�y Gardiyan�:")
            say("")
            say("Peki tamam.")
            say("Umar�m do�ru olan� yap�yorsundur!")
            say("")
            say_reward("Tek tarafl� bo�anma ger�ekle�ti.")
            say("")
        end

        when oldwoman.chat."Evlilik t�reni listesi" with not pc.is_engaged() begin
            local t = marriage.get_wedding_list()
            if table.getn(t) == 0 then
                say_title("Ya�l� Kad�n:")
                say("")
                say("�u an devam eden nikah t�reni yok.")
                say("")
            else
                -- chat(table.getn(t))
                local wedding_names = {}
                table.foreachi(t, function(n, p) wedding_names[n] = p[3].."ile"..p[4].."evleniyor." end)
                wedding_names[table.getn(t)+1] = locale.confirm
                local s = select_table(wedding_names)

                if s != table.getn(wedding_names) then
                    marriage.join_wedding(t[s][1], t[s][2])
                end
            end
        end
        when 9011.click with not pc.is_engaged() and not pc.is_married() begin
            say_title("Nikah Memuru:")
            say("")
            say("Bu sizin d���n�n�z!")
            say("iyi e�lenceler.")
            say("")
        end

        function check_divorce_time()

            local DIVORCE_LIMIT_TIME = 86400

            if is_test_server() then
                DIVORCE_LIMIT_TIME = 60
            end

            if marriage.get_married_time() < DIVORCE_LIMIT_TIME then
                say_title("K�y Gardiyan�:")
                say("")
                say("Daha imzandaki m�rekkep yeterince kurumad�!")
                say("Kendine biraz zaman ver.")
                say("")
                return false
            end

            return true
        end

        function is_equip_wedding_dress()
            local a = pc.get_armor()
            return a >= 11901 and a <= 11904
        end
        function get_wedding_dress(pc_job)
                if 0==pc_job then
                    return 11901
                elseif 1==pc_job then
                    return 11903
                elseif 2==pc_job then
                    return 11902
                elseif 3==pc_job then
                    return 11904
                else
                    return 0;
                end
        end
    end
end
