quest pony_buy begin
        state start begin
                when 20349.chat."Ata binmek istiyorum." with horse.get_grade()==0 begin
                        if pc.level<=24 then
                                say_title("Seyis:")
                                say("")
                                ----"12345678901234567890123456789012345678901234567890"|
                                say("Ata binmeye baslamak i�in 25.seviyeye ulasmis")
                                say("olman gerekiyor. Bana kalirsa daha fazla ")
                                say("olsa daha iyi olur.")
                                say("")
                        elseif pc.countitem("50050")<1 then
                                say_title("Seyis:")
                                say("")
                                say("Ata binmeye hazir olmak i�in, �ncelikle ")
                                say("yeterlilik testini ge�melisin. Bu teste")
                                say("katilabilmen i�in, bir at madalyonuna ihtiyacin")
                                say("var. Buna sahip olmanin")
                                say("en kolay yolu, ikinci k�ydeki ")
                                say("Maymun Zindani'na gitmek.")
                                say("Maymunlar bunu sana karsiliksiz")
                                say("vermeyeceklerdir..")
                                say("")
                                setstate(need_item50050)
                        elseif pc.countitem("50050")>=1 and pc.level>=25 then
                                say_title("Seyis:")
                                say("")
                                say("Ohh..Bir at madalyonun var, harika!")
                                say("simdi binicilik i�in gerekli yeterlilige")
                                say("sahip oldugunu kanitlaman gerekiyor. L�tfen")
                                say("30 dakika i�inde 20 ok�u")
                                say("�ld�r. Bunu basarabilirsen")
                                say("binicilik i�in hazirsin demektir!")
                                say("")
                                local b=select("Kabul et.", "Reddet.")
                                if 1==b then
                                        if pc.countitem("50050")>=1 then
                                                pc.removeitem("50050", 1)
                                                setstate(test)
                                        end
                                elseif 2==b then
                                        say_title("Seyis:")
                                        say("")
                                        say("ilgini �ektigi zaman geri d�n.")
                                        say("")
                                else
                                        say("UNBEKANNTE TASTE ["..b.."]")
                                end
                        else
                                say_title("Seyis:")
                                say("Belli ki, burada binicilik")
                                say("bilgileriyle ilgili bir problem var.")
                        end
                end
        end
        state need_item50050 begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Bana bir at madalyonu getir.")
                        q.set_title("Bana bir at madalyonu getir!")
                        q.start()
                end
                when button begin
                        say_title("Bilgi:")
                        say("")
                        say("Seyis'e bir at madalyonu getir!")
                        say("B�ylece binicilik egitimine katilabilirsin.")
                        say("Bir at madalyonu almanin en kolay yolu,")
                        say("ikinci k�ydeki Maymun Zindani'na gitmek.")
                        setstate(start)
                        q.done()
                end
                when info begin
                        say_title("Bilgi:")
                        say("")
                        say("Seyis'e bir at madalyonu getir!")
                        say("B�ylece binicilik egitimine katilabilirsin,")
                        say("Bir at madalyonu almanin en kolay yolu,")
                        say("ikinci k�ydeki Maymun Zindani'na gitmek.")
                        setstate(start)
                        q.done()
                end
        end
        state test begin
                when letter begin
                        q.set_counter("�ld�rmen gereken:", 20-pc.getqf("kill_count"))
                end
                when 503.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("�ld�rmen gereken:", 20-pc.getqf("kill_count"))
                        if get_time()>=pc.getqf("limit_time") then
                                setstate(failure)
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
                        makequestbutton("Binicilik yeterliligi.")
                        q.set_title("Binicilik yeterliligi.")
                        q.start()
                end
                when button begin
                        say_title("Binicilik yeterliligi.")
                        say("")
                        say_reward("30 dakika i�erisinde 20 ok�u ")
                        say_reward("�ld�r ve seyise sonu� ")
                        say_reward("hakkinda bilgi ver. ")
                        say("")
                end
                when info begin
                        say_title("Binicilik Yeterliligi.")
                        say("")
                        say("30 dakika i�erisinde 20 ok�u ")
                        say("�ld�r ve seyise sonu� ")
                        say("hakkinda bilgi ver. ")
                        say("")
                end
                when 503.kill with pc.getqf("kill_count") >= 20 and pc.getqf("limit_time")>=get_time() begin
                        setstate(report)
                end
                when 20349.chat."STATUSVERBESSERUNG PONY-AUFTRAG" with horse.get_grade()!=0 begin
                        setstate(start)
                        q.done()
                end
                when 20349.chat."Yeterlilik testi basladi." begin
                        say_title("Seyis:")
                        say("")
                        say_reward("30 dakikada 20 Yabani ok�u")
                        say_reward("�ld�r ve d�n!")
                        say("")
                        local b=select("Bir baska", "iptal")
                        if 1==b then
                        elseif 2==b then
                                say_title("Seyis:")
                                say("")
                                say("Yeterlilik testini iptal etmek istiyor musun?")
                                say("")
                                local b=select("Evet", "Hayir, sadece bir sakaydi.")
                                if 1==b then
                                        say_title("Seyis:")
                                        say("")
                                        say("Basaracagindan emin oldugunda tekrar dene.")
                                        say("")
                                        setstate(start)
                                        q.done()
                                elseif 2==b then
                                        say_title("Seyis:")
                                        say("")
                                        say("Hata yapacak kadar zamanin yok.")
                                        say("Acele et! O yabani askerleri �ld�r ")
                                        say("ve d�n!")
                                else
                                        say("UNBEKANNTE TASTE ["..b.."]")
                                end
                        else
                                say("UNBEKANNTE TASTE ["..b.."]")
                        end
                end
        end
        state report begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Seyis'in yanina d�n:")
                        q.set_title("Seyis'in yanina d�n:")
                        q.start()
                end
                when button begin
                        say_title("Seyis'in yanina d�n:")
                        say("")
                        say("�ld�rd�g�n yabani ok�ular hakkinda ")
                        say("seyise rapor ver. ")
                end
                when info begin
                        say_title("Seyis'in yanina d�n:")
                        say("")
                        say("�ld�rd�g�n yabani ok�ular hakkinda")
                        say("seyise rapor ver.")
                end
                when 20349.chat."STATUSVERBESSERUNG PONY-AUFTRAG" with horse.get_grade()!=0 begin
                        setstate(start)
                        q.done()
                end
                when 20349.chat."G�rev Raporu" with horse.get_grade()==0 begin
                        say_title("Seyis:")
                        say("")
                        say("G�revini basariyla tamamladin.")
                        say("Ata binebilmek i�in bir at resmine ihtiyacin var.")
                        say("Bunu saglayabilmem biraz zaman alacak.")
                        say("Yarin yine gel.")
                        say("At resminin fiyatinin 100.000 Yang oldugunu")
                        say("unutma!")
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
                        makequestbutton("At resminin yapimi devam ediyor.")
                        q.set_title("At resminin yapimi devam ediyor.")
                        q.start()
                end
                when button begin
                        say_title("At resminin yapimi devam ediyor")
                        say("")
                        say_reward("At resmi tamamlandigi zaman")
                        say_reward("seyisin yanina git.")
                end
                when info begin
                        say_title("At resminin yapimi devam ediyor.")
                        say("")
                        say_reward("At resmi tamamlandigi zaman")
                        say_reward("seyisin yanina git.")
                end
                when login with get_time()>=pc.getf("pony_buy","make_time") begin
                        setstate(buy)
                end
                when 20349.chat."STATUSVERBESSERUNG PONY-AUFTRAG" with horse.get_grade()!=0 begin
                        setstate(start)
                        q.done()
                end
                when 20349.chat."At resmi hazir mi?" with horse.get_grade()==0 begin
                        say_title("Seyis:")
                        say("")
                        say("Sanirim bitmesi biraz zaman alacak.")
                        say("Onu almak i�in 100.000 Yang'a")
                        say("ihtiyacin oldugunu unutma!")
                        say("")
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
                        say_reward("At resmi tamamlandi! ")
                        say_reward("Onu seyisten al.")
                end
                when info begin
                        say_title("Seyis'in yanina git.")
                        say("")
                        say_reward("At resmi tamamlandi!")
                        say_reward("Onu seyisten al.")
                end
                when 20349.chat."At resmi tamamlandi!" with horse.get_grade()==0 and get_time()>=pc.getqf("make_time") begin
                        say_title("Seyis:")
                        say("")
                        say("At resmini bitirdim,")
                        say("simdi bir acemi ata binebilirsin.")
                        say("Bir acemi at ile daha hizli hareket")
                        say("edebilirsin. Fiyati 100.000 Yang.")
                        say("Onu satin almak istiyor musun?")
                        say("")
                        local b=select("Satin al.", "Satin alma.", "iptal")
                        if 1==b then
                                if pc.money>=100000 then
                                        char_log(0, " HORSE_BUY", "BEGIN")
                                        pc.changemoney(-100000)
                                        char_log(0, " HORSE_BUY", " DEC money 100000")
                                        horse.unride()
                                        horse.advance()
                                        horse.ride()
                                        char_log(0, " HORSE_BUY", "INC horse_advance 1")
                                        pc.give_item2("50051", 1)
                                        char_log(0, " HORSE_BUY", "INC 50051 1")
                                        char_log(0, " HORSE_BUY", "END")
                                        say_title("Seyis:")
                                        say("")
                                        ----"12345678901234567890123456789012345678901234567890"|
                                        say("Bu resim ile ati her yere �agirabilirsin.")
                                        say("Eger bu resmi kaybedersen, yeniden yapimi i�in")
                                        say("�cret �dersin. Bu nedenle ona dikkat et!")
                                        say("")
                                        setstate(start)
                                        q.done()
                                else
                                        say_title("Seyis:")
                                        say("")
                                        say("At resmi i�in yeterli Yang'in yok!")
                                        say("")
                                end
                        elseif 2==b then
                                say_title("Seyis:")
                                say("")
                                say("Daha sonra yine gel.")
                                say("")

                        elseif 3==b then
                                say_title("Seyis:")
                                say("")
                                ----"12345678901234567890123456789012345678901234567890"|
                                say("Ger�ekten at resmini iptal etmek istediginden")
                                say("emin misin? Eger simdi iptal edersen,")
                                say("herseye bastan baslarsin.")
                                say("")
                                local b=select("Tabii ki.", "Hayir, elbette hayir.")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNBEKANNTE TASTE ["..b.."]")
                                end
                        else
                                say("UNBEKANNTE TASTE ["..b.."]")
                        end
                end
        end
        state failure begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("S�re doldu!")
                        q.set_title("S�re doldu!")
                        q.start()
                end
                when button begin
                        say_title("S�re doldu!")
                        say("")
                        -----------"12345678901234567890123456789012345678901234567890"|
                        say_reward("30 dakika i�inde 20 yabani ok�uyu")
                        say_reward("�ld�remedigin i�in,")
                        say_reward("yeterlilik testinde basarisiz oldun.")
                        say("")
                        say_reward("Bunu basarabilmek i�in, bir at madalyonu")
                        say_reward("ile seyise git ve yeni bir yeterlilik")
                        say_reward("testi uygula.")
                        setstate(start)
                        q.done()
                end
                when info begin
                        say_title("S�re doldu!")
                        say("")
                        -----------"12345678901234567890123456789012345678901234567890"|
                        say_reward("30 dakika i�inde 30 yabani ok�uyu")
                        say_reward("�ld�remedigin i�in,")
                        say_reward("yeterlilik testinde basarisiz oldun.")
                        say("")
                        say_reward("Bunu basarabilmek i�in, bir at madalyonu")
                        say_reward("ile seyise git ve yeni bir yeterlilik")
                        say_reward("testi uygula.")
                        setstate(start)
                        q.done()
                end
        end
        state __GIVEUP__ begin
        end

        state __COMPLETE__ begin
                when enter begin
                        q.done()
                end
        end
end

