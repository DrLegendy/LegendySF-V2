quest horse_upgrade begin
        state start begin
                when 20349.chat."Atimi gelistirmek istiyorum." with horse.get_grade()==1 and horse.get_level()==10 begin
                        if horse.is_dead() then
                                say_title("Seyis:")
                                say("�l� bir ati gelistiremezsin!")
                                say("Git ve Maymun Zindanindan")
                                say("atini canlandirmam i�in gerekli")
                                say("olan sifali otlari getir. Ondan sonra atini")
                                say("gelistirmen hakkinda konusabiliriz.")
                                say("")
                        elseif pc.level<=34 then
                                say_title("Seyis:")
                                say("")
                                say("Seviyen bir at gelistirmek i�in �ok d�s�k. Sadece")
                                say("35.seviyeye ulasmis oyuncular atlarini")
                                say("gelistirebilirler.")
                                say("Yeterli seviyeye ulastiginda tekrar gel.")
                        elseif horse.get_level()<=9 then
                                say_title("Seyis:")
                                say("")
                                say("Atinin seviyesi gelistirilebilmesi i�in �ok d�s�k")
                                say("Git ve biniciligini ilerletmek i�in �alis. Eger")
                                say("atin 10.seviyeye ulasirsa, tekrar gelebilirsin.")
                                say("")
                        elseif pc.countitem("50050")<1 then
                                say_title("Seyis:")
                                say("Eger atini y�kseltmek istiyorsan,")
                                say("yeterlilik testini")
                                say("ge�melisin. Son olarak,bu teste katilabilmen i�in")
                                say("bir at madalyonuna ihtiyacin var. Bunu (1)Maymun")
                                say("Zindanindan temin edebilirsin. Tabii ki maymunlar")
                                say("sana kolayca izin vermeyecekler...")
                                say("ikinci k�y�n yakinlarindaki Maymun Zindanina git.")
                                say("")
                                say("")
                                say("")
                                setstate(need_item50050)
                        elseif pc.countitem("50051")<1 then
                                say_title("Seyis:")
                                say("")
                                say("Bunu sana ikinci kez s�ylemek istemiyorum:")
                                say("Eger ata binmek istiyorsan, binicilik lisansini")
                                say("yaninda tasimalisin!")
                        elseif horse.get_level()==10 and not horse.is_dead() and pc.countitem("50050")>=1 and pc.level>=35 then
                                say_title("Seyis:")
                                say("")
                                say("Eger bir silah-at kitabin olursa, rakiplerine at")
                                say("�zerinden saldirabilirsin. Senin savas tecr�beni")
                                say("ve binicilik becerini test edecegim..")
                                say("��le git ve bir ka� Akrep Ok�usu �ld�r..")
                                say("Oraya grubunla gidebilirsin, fakat sen")
                                say("grup lideri olmak zorundasin.")
                                say("")
                                say("")
                                say("")
                                local b=select("Kabul et.", "Reddet.")
                                if 1==b then
                                        if pc.countitem("50050")>=1 then
                                                pc.removeitem("50050", 1)
                                                setstate(test)
                                        end
                                elseif 2==b then
                                        say("Ok, daha sonra tekrar gel.")
                                else
                                        say("UNBEKANNTER KNOPF ["..b.."]")
                                end
                        else
                                say_title("Seyis:")
                                say("")
                                say("Sanirim silah-at kitabi alamazsin.")
                                say("Bu garip.. Ne i�in oldugunu bilmiyorum..")
                                say("Ne oldugunu Game Master'a sormalisin.")
                                say("")
                        end
                end
        end
        state need_item50050 begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Bir at madalyonu al!")
                        q.set_title("Bir at madalyonu al!")
                        q.start()
                end
                when button begin
                        say_title("Bir at madalyonu al!")
                        say("")
                        say_reward("Silah-at Kitabi i�in gerekli egitime")
                        say_reward("katilabilmen i�in, bir at madalyonuna ihtiyacin var.")
                        say_reward("At madalyonunu (1)")
			say_reward("Maymun Zindanindan temin edebilirsin.")
                        say("")
                        setstate(start)
                        q.done()
                end
                when info begin
                        say_title("Bir at madalyonu al!")
                        say("")
                        say_reward("Silah-at kitabi i�in gerekli egitime katilabilmen")
                        say_reward("i�in, bir at madalyonuna ihtiyacin var.")
                        say_reward("At madalyonunu (1)")
			say_reward("Maymun Zindanindan temin edebilirsin")
                        say("")
                        setstate(start)
                        q.done()
                end
        end
        state test begin
                when letter begin
                        q.set_counter("Kalan Akrep Ok�usu:", 50-pc.getqf("kill_count"))
                end
                when 2105.party_kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan Akrep Ok�usu:", 50-pc.getqf("kill_count"))
                        if get_time()>=pc.getqf("limit_time") then
                                setstate(failure)
                        end
                end
                when 2107.party_kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan Yilan Ok�usu:", 50-pc.getqf("kill_count"))
                        if get_time()>=pc.getqf("limit_time") then
                                setstate(failure)
                                q.done()
                        end
                end
                when letter begin
                        q.set_clock("Kalan s�re:", pc.getqf("limit_time")-get_time())
                end
                when enter begin
                        pc.setqf("limit_time", get_time()+30*60)
                        pc.setqf("kill_count", 0)
                end
                when leave begin
                        q.done()
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Silah-at Kitabi Sinavi")
                        q.set_title("Silah-at Kitabi Sinavi")
                        q.start()
                end
                when button begin
                        say_title("Silah-at Kitabi Sinavi")
                        say("")
                        say_reward("30 dakika i�erisinde, 50 tane")
                        say_reward("akrep ok�usu veya yilan ok�usu �ld�r")
                        say_reward("ve sonucu seyis'e rapor et.")
                        say("")
                        say_reward("Bu g�revi bir grup ile yapabilirsin, fakat sadece")
                        say_reward("grup lideri �ld�r�lenlerden dolayi puan alacak.")
                        say("")
                end
                when info begin
                        say_title("Silah-at Kitabi Sinavi")
                        say("")
                        say_reward("30 dakika i�erisinde, 50 tane")
                        say_reward("akrep ok�usu veya yilan ok�usu �ld�r")
                        say_reward("ve sonucu seyis'e rapor et.")
                        say("")
                        say_reward("Bu g�revi bir grup ile yapabilirsin, fakat sadece")
                        say_reward("grup lideri �ld�r�len")
			say_reward("hedeflerden dolayi puan alacak.")
                        say("")
                end
                when 2105.party_kill with pc.getqf("kill_count") >= 50 and pc.getqf("kill_count") >= 50 and pc.getqf("limit_time")>=get_time() begin
                        setstate(report)
                end
                when 2107.party_kill with pc.getqf("kill_count") >= 50 and pc.getqf("kill_count") >= 50 and pc.getqf("limit_time")>=get_time() begin
                        setstate(report)
                end
                when 20349.chat."Silah-at Kitabi Sinavi basladi." begin
                        say_title("Seyis:")
                        say("")
                        say("30 dakika i�erisinde, 50 tane")
                        say("akrep ok�usu veya yilan ok�usu �ld�r")
                        say("")
                        say("Bu g�revi bir grup ile yapabilirsin, fakat sadece")
                        say("grup lideri �ld�r�len")
                        say("hedeflerden dolayi puan alacak.")
                        local b=select("Devam", "iptal")
                        if 1==b then
                        elseif 2==b then
                                say_title("Seyis:")
                                say("")
                                say("G�revi iptal etmek istediginden emin misin?")
                                local b=select("Evet.", "Sadece bir sakaydi!")
                                if 1==b then
                                        say_title("Seyis:")
                                        say("")
                                        say("Ok, bir dahaki sefere bol sans!.")
                                        setstate(start)
                                        q.done()
                                elseif 2==b then
                                        say_title("Seyis:")
                                        say("")
                                        say("Bunun i�in zamanin yok!")
                                        say("Git ve m�mk�n olan en kisa zamanda")
                                        say("50 ok�u �ld�r!")
                                else
                                        say("Bilinmeyen Buton ["..b.."]")
                                end
                        else
                                say("Bilinmeyen Buton ["..b.."]")
                        end
                end
        end
        state report begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Seyis'in yanina d�n.")
                        q.set_title("Seyis'in yanina d�n.")
                        q.start()
                end
                when button begin
                        say_title("Seyis'in yanina d�n.")
                        say("")
                        say_reward("Sinav sonucu hakkinda ")
                        say_reward("seyis'e rapor ver.")
                        say("")
                end
                when info begin
                        say_title("Seyis'in yanina d�n.")
                        say("")
                        say_reward("Sinav sonucu hakkinda")
                        say_reward("seyis'e rapor ver.")
                        say("")
                end
                when 20349.chat."Durum Raporu" with horse.get_grade()!=1 begin
                        setstate(start)
                        q.done()
                end
                when 20349.chat."Seyis'e sinav sonu�larini s�yle." with horse.get_grade()==1 begin
                        say_title("Seyis:")
                        say("")
                        say("iyi sonu�!")
                        say("Eger atini simdi gelistirmek istiyorsan,")
                        say("at madalyonunu, silah-at kitabi ile ")
                        say("degistirmelisin. Bu olduk�a uzun s�r�yor,")
                        say("yarin tekrar gelsen daha iyi olur.")
                        say("Neyse, ayrica silah-at kitabi satin almak i�in")
                        say("500.000 Yang getirmen gerekiyor.")
                        if is_test_server() then
                                pc.setqf("make_time", get_time()+10)
                        else
                                pc.setqf("make_time", get_time()+number(8, 16)*60*60)
                        end
                        setstate(wait)
                end
        end
        state wait begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Silah-at kitabini bekle")
                        q.set_title("Silah-at kitabini bekle")
                        q.start()
                end
                when button begin
                        say_title("Silah-at kitabini bekle")
                        say("")
                        say_reward("Seyis Silah-at kitabini hazirlayana")
                        say_reward("kadar bekle.")
                        say("")
                end
                when info begin
                        say_title("Silah-at kitabini bekle")
                        say("")
                        say_reward("Seyis silah-at kitabini hazirlayana")
                        say_reward("kadar bekle.")
                        say("")
                end
                when login with get_time()>=pc.getf("horse_upgrade","make_time") begin
                        setstate(buy)
                end
                when 20349.chat."Atinin durumunu gelistir." with horse.get_grade()!=1 begin
                        setstate(start)
                        q.done()
                end
                when 20349.chat."Lisans hazir mi?" with horse.get_grade()==1 begin
                        say_title("Seyis:")
                        say("")
                        say("�zg�n�m, fakat biraz daha uzun beklemen gerekiyor.")
                        say("Oh, ve unutma:")
                        say("silah-at kitabi bedeli olarak")
                        say("500.000 Yang gerekiyor.")
                end
        end
        state buy begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Seyis'in yanina git.")
                        q.set_title("Seyis'in yanina git.")
                        q.start()
                end
                when button begin
                        say_title("Seyis'in yanina git.")
                        say("")
                        say_reward("Seyis'in yanina git ve silah-at")
                        say_reward("kitabini al.")
                        say_reward("Silah-at kitabi i�in")
                        say_reward("500.000 Yang ve at madalyonuna ihtiyacin var.")
                        say("")
                end
                when info begin
                        say_title("Seyis'in yanina git.")
                        say("")
                        say_reward("Seyis'in yanina git ve silah-at")
                        say_reward("kitabini al.")
                        say_reward("Silah-at kitabi i�in")
                        say_reward("500.000 Yang ve at madalyonuna ihtiyacin var.")
                        say("")
                end
                when 20349.chat."Atinin durumunu y�kselt" with horse.get_grade()!=1 begin
                        setstate(start)
                        q.done()
                end
                when 20349.chat."Atinin durumunu y�kselt" with horse.get_grade()==1 and horse.get_level()!=10 begin
                        setstate(start)
                        q.done()
                end
                when 20349.chat."Lisans hazir!" with horse.get_grade()==1 and horse.get_level()==10 begin
                        say_title("Seyis:")
                        say("")
                        say("Silah-at kitabini aldigin zaman,")
                        say("daha hizli ata binebileceksin ve ")
                        say("at �zerinden saldiri yapabileceksin.")
                        say("")
                        say("Bundan hoslanmayacagini biliyorum..")
                        say("Fakat bu Asker at kitabi ")
                        say("i�in bir hazirlik..")
                        say("")
                        say("Bununla birlikte atinin durumunu")
                        say("y�kseltmek i�in de 500.000 Yang gerekiyor.")
                        local b=select("Ati gelistir", "Durumunu gelistirme.", "Tamam.. unuttum!")
                        if 1==b then
                                if pc.money>=500000 then
                                        if pc.countitem("50051")>=1 then
                                                char_log(0, "HORSE_UPGRADE", "BEGIN")
                                                pc.changemoney(-500000)
                                                char_log(0, "HORSE_UPGRADE", "DEC money 500000")
                                                pc.removeitem("50051", 1)
                                                char_log(0, "HORSE_UPGRADE", "DEC 50051 1")
                                                horse.unride()
                                                horse.advance()
                                                horse.ride()
                                                char_log(0, "HORSE_UPGRADE", "INC horse_advance 1")
                                                pc.give_item2("50052", 1)
                                                char_log(0, "HORSE_UPGRADE", "INC 50052 1")
                                                char_log(0, "HORSE_UPGRADE", "END")
                                                say_title("Seyis:")
                                                say("")
                                                say("�nceden oldugu gibi..")
                                                say("Silah-at kitabina sahip oldugunda,")
                                                say("atini her yere �agirabilirsin.")
                                                say("eger onu kaybedersen, yenisini satin alman gerekir.")
                                                say("Bu nedenle g�venligini saglamalisin.")
                                                say("")
                                                setstate(start)
                                                q.done()
                                        else
                                                say_title("Seyis:")
                                                say("")
                                                say("Silah-at kitabini alabilmek i�in,")
                                                say("bir at resmine ihtiyacin var.")
                                        end
                                else
                                        say_title("Seyis:")
                                        say("")
                                        say("500.000 Yang'a ihtiyacin var.")
                                end
                        elseif 2==b then
                                say_title("Seyis:")
                                say("")
                                say("Eger lisansini almak istersen, tekrar gel.")
                        elseif 3==b then
                                say_title("Seyis:")
                                say("")
                                say("Emin misin?")
                                say("Eger bu g�revi simdi iptal edersen, bunlarin")
                                say("hepsini yeniden yapman gerekecek.")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                        q.done()
                                elseif 2==b then
                                else
                                        say("Bilinmeyen Buton ["..b.."]")
                                end
                        else
                                say("Bilinmeyen Buton ["..b.."]")
                        end
                end
        end
        state failure begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("S�re bitti!")
                        q.set_title("S�re bitti!")
                        q.start()
                end
                when button begin
                        say_title("S�re bitti!")
                        say("")
                        say_reward("50 tane akrep ok�usu veya yilan")
                        say_reward("ok�usu �ld�remedin. Bu durumuda basarisiz oldun.")
                        say_reward("")
                        say("")
                        say_reward("Eger tekrar denemek istersen,")
                        say_reward("yeni bir at madalyonu alip,")
                        say_reward("seyis'in yanina gitmelisin.")
                        say("")
                        setstate(start)
                        q.done()
                end
                when info begin
                        say_title("S�re bitti!")
                        say("")
                        say_reward("50 tane akrep ok�usu")
                        say_reward("veya yilan ok�usu �ld�remedin.")
                        say_reward("Bu durumuda basarisiz oldun.")
                        say("")
                        say_reward("Eger tekrar denemek istersen,")
                        say_reward("yeni bir at madalyonu alip,")
                        say_reward("seyis'in yanina gitmelisin.")
                        say("")
                        setstate(start)
                        q.done()
                end
        end
        state __COMPLETE__ begin
                when enter begin
                        q.done()
                end
        end
end
