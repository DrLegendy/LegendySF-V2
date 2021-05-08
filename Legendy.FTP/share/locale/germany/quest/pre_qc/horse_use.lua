quest pony_buy begin
        state start begin
                when 20349.chat."Ata binmek istiyorum." with horse.get_grade()==0 begin
                        if pc.level<=24 then
                                say_title("Seyis:")
                                say("")
                                ----"12345678901234567890123456789012345678901234567890"|
                                say("Ata binmeye baslamak için 25.seviyeye ulasmis")
                                say("olman gerekiyor. Bana kalirsa daha fazla ")
                                say("olsa daha iyi olur.")
                                say("")
                        elseif pc.countitem("50050")<1 then
                                say_title("Seyis:")
                                say("")
                                say("Ata binmeye hazir olmak için, öncelikle ")
                                say("yeterlilik testini geçmelisin. Bu teste")
                                say("katilabilmen için, bir at madalyonuna ihtiyacin")
                                say("var. Buna sahip olmanin")
                                say("en kolay yolu, ikinci köydeki ")
                                say("Maymun Zindani'na gitmek.")
                                say("Maymunlar bunu sana karsiliksiz")
                                say("vermeyeceklerdir..")
                                say("")
                                setstate(need_item50050)
                        elseif pc.countitem("50050")>=1 and pc.level>=25 then
                                say_title("Seyis:")
                                say("")
                                say("Ohh..Bir at madalyonun var, harika!")
                                say("simdi binicilik için gerekli yeterlilige")
                                say("sahip oldugunu kanitlaman gerekiyor. Lütfen")
                                say("30 dakika içinde 20 okçu")
                                say("öldür. Bunu basarabilirsen")
                                say("binicilik için hazirsin demektir!")
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
                                        say("ilgini çektigi zaman geri dön.")
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
                        say("Böylece binicilik egitimine katilabilirsin.")
                        say("Bir at madalyonu almanin en kolay yolu,")
                        say("ikinci köydeki Maymun Zindani'na gitmek.")
                        setstate(start)
                        q.done()
                end
                when info begin
                        say_title("Bilgi:")
                        say("")
                        say("Seyis'e bir at madalyonu getir!")
                        say("Böylece binicilik egitimine katilabilirsin,")
                        say("Bir at madalyonu almanin en kolay yolu,")
                        say("ikinci köydeki Maymun Zindani'na gitmek.")
                        setstate(start)
                        q.done()
                end
        end
        state test begin
                when letter begin
                        q.set_counter("Öldürmen gereken:", 20-pc.getqf("kill_count"))
                end
                when 503.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Öldürmen gereken:", 20-pc.getqf("kill_count"))
                        if get_time()>=pc.getqf("limit_time") then
                                setstate(failure)
                        end
                end
                when letter begin
                        q.set_clock("Kalan süre:", pc.getqf("limit_time")-get_time())
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
                        say_reward("30 dakika içerisinde 20 okçu ")
                        say_reward("öldür ve seyise sonuç ")
                        say_reward("hakkinda bilgi ver. ")
                        say("")
                end
                when info begin
                        say_title("Binicilik Yeterliligi.")
                        say("")
                        say("30 dakika içerisinde 20 okçu ")
                        say("öldür ve seyise sonuç ")
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
                        say_reward("30 dakikada 20 Yabani okçu")
                        say_reward("öldür ve dön!")
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
                                        say("Acele et! O yabani askerleri öldür ")
                                        say("ve dön!")
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
                        makequestbutton("Seyis'in yanina dön:")
                        q.set_title("Seyis'in yanina dön:")
                        q.start()
                end
                when button begin
                        say_title("Seyis'in yanina dön:")
                        say("")
                        say("Öldürdügün yabani okçular hakkinda ")
                        say("seyise rapor ver. ")
                end
                when info begin
                        say_title("Seyis'in yanina dön:")
                        say("")
                        say("Öldürdügün yabani okçular hakkinda")
                        say("seyise rapor ver.")
                end
                when 20349.chat."STATUSVERBESSERUNG PONY-AUFTRAG" with horse.get_grade()!=0 begin
                        setstate(start)
                        q.done()
                end
                when 20349.chat."Görev Raporu" with horse.get_grade()==0 begin
                        say_title("Seyis:")
                        say("")
                        say("Görevini basariyla tamamladin.")
                        say("Ata binebilmek için bir at resmine ihtiyacin var.")
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
                        say("Onu almak için 100.000 Yang'a")
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
                                        say("Bu resim ile ati her yere çagirabilirsin.")
                                        say("Eger bu resmi kaybedersen, yeniden yapimi için")
                                        say("ücret ödersin. Bu nedenle ona dikkat et!")
                                        say("")
                                        setstate(start)
                                        q.done()
                                else
                                        say_title("Seyis:")
                                        say("")
                                        say("At resmi için yeterli Yang'in yok!")
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
                                say("Gerçekten at resmini iptal etmek istediginden")
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
                        makequestbutton("Süre doldu!")
                        q.set_title("Süre doldu!")
                        q.start()
                end
                when button begin
                        say_title("Süre doldu!")
                        say("")
                        -----------"12345678901234567890123456789012345678901234567890"|
                        say_reward("30 dakika içinde 20 yabani okçuyu")
                        say_reward("öldüremedigin için,")
                        say_reward("yeterlilik testinde basarisiz oldun.")
                        say("")
                        say_reward("Bunu basarabilmek için, bir at madalyonu")
                        say_reward("ile seyise git ve yeni bir yeterlilik")
                        say_reward("testi uygula.")
                        setstate(start)
                        q.done()
                end
                when info begin
                        say_title("Süre doldu!")
                        say("")
                        -----------"12345678901234567890123456789012345678901234567890"|
                        say_reward("30 dakika içinde 30 yabani okçuyu")
                        say_reward("öldüremedigin için,")
                        say_reward("yeterlilik testinde basarisiz oldun.")
                        say("")
                        say_reward("Bunu basarabilmek için, bir at madalyonu")
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

