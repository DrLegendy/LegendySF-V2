quest horse_levelup begin
        state training1 begin
                when letter begin
                        q.set_counter("Kalan Bo:", 5-pc.getqf("kill_count"))
                end
                when 492.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan Bo:", 5-pc.getqf("kill_count"))
                end
                when enter begin
                        pc.setqf("kill_count", 0)
                end
                when leave begin
                        q.done()
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Bo �ld�r!")
                        q.set_title("Bo �ld�r!")
                        q.start()
                end
                when button begin
                        say_title("Bo'yu �ld�r!")
                        say("")
                        say("Bo'yu at �zerinden �ld�r.")
                        say("Attan inersen kaybedersin.")
                        say("")
                end
                when info begin
                        say_title("Bo'yu �ld�r!")
                        say("")
                        say("Bo'yu at �zerinden �ld�r.")
                        say("Attan inersen kaybedersin.")
                        say("")
                end
                when 492.kill with pc.getf("horse_levelup","kill_count") >= 5 begin
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training2 begin
                when letter begin
                        q.set_counter("Kalan Chuong:", 5-pc.getqf("kill_count"))
                end
                when 494.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan Chuong:", 5-pc.getqf("kill_count"))
                end
                when enter begin
                        pc.setqf("kill_count", 0)
                end
                when leave begin
                        q.done()
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Chuong �ld�r!")
                        q.set_title("Chuong �ld�r!")
                        q.start()
                end
                when button begin
                        say_title("Chuong'i �ld�r!")
                        say("")
                        say(" Chuong'i  at �zerinden �ld�r.")
                        say("Attan inersen kaybedersin.")
                        say("")
                end
                when info begin
                        say_title("Chuong'i �ld�r!")
                        say("")
                        say("Chuong'i at �zerinden �ld�r.")
                        say("Attan inersen kaybedersin.")
                        say("")
                end
                when 494.kill with pc.getf("horse_levelup","kill_count") >= 5 begin
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training3 begin
                when letter begin
                        q.set_counter("Kalan Gururlu Ork Generali:", 10-pc.getqf("kill_count"))
                end
                when 635.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan Gururlu Ork Generali:", 10-pc.getqf("kill_count"))
                end
                when enter begin
                        pc.setqf("kill_count", 0)
                end
                when leave begin
                        q.done()
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Gururlu Ork Generali �ld�r!")
                        q.set_title("Gururlu Ork Generali �ld�r!")
                        q.start()
                end
                when button begin
                        say_title("Gururlu Ork Generalini �ld�r!")
                        say("")
                        say("Gururlu Ork Generalini at �zerinden �ld�r!")
                        say("Attan inersen kaybedersin.")
                        say("")
                end
                when info begin
                        say("Gururlu Ork Generalini �ld�r!")
                        say("")
                        say("Gururlu Ork Generalini at �zerinden �ld�r!")
                        say("Attan inersen kaybedersin.")
                        say("")
                end
                when 635.kill with pc.getf("horse_levelup","kill_count") >= 10 begin
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training4 begin
                when letter begin
                        q.set_counter("Kalan Siyah Ork:", 10-pc.getqf("kill_count"))
                end
                when 636.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan Siyah Ork:", 10-pc.getqf("kill_count"))
                end
                when enter begin
                        pc.setqf("kill_count", 0)
                end
                when leave begin
                        q.done()
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Siyah Ork �ld�r!")
                        q.set_title("Siyah Ork �ld�r!")
                        q.start()
                end
                when button begin
                        say_title("Siyah Ork'u �ld�r!")
                        say("")
                        say("Siyah Ork'u at �zerinden �ld�r!")
                        say("Attan inersen kaybedersin.")
                        say("")
                end
                when info begin
                        say_title("Siyah Ork'u �ld�r!")
                        say("")
                        say("Siyah Ork'u at �zerinden �ld�r!")
                        say("Attan inersen kaybedersin.")
                        say("")
                end
                when 636.kill with pc.getf("horse_levelup","kill_count") >= 10 begin
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training5 begin
                when letter begin
                        q.set_counter("Kalan Mistik iskenceci:", 10-pc.getqf("kill_count"))
                end
                when 706.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan Mistik iskenceci:", 10-pc.getqf("kill_count"))
                end
                when enter begin
                        pc.setqf("kill_count", 0)
                end
                when leave begin
                        q.done()
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Mistik iskenceci �ld�r!")
                        q.set_title("Mistik iskenceci �ld�r!")
                        q.start()
                end
                when button begin
                        say_title("Mistik iskenceci'yi �ld�r!")
                        say("")
                        say("Mistik iskenceci'yi at �zerinden �ld�r!")
                        say("Attan inersen kaybedersin.")
                        say("")
                end
                when info begin
                        say_title("Mistik iskenceci'yi �ld�r!")
                        say("")
                        say("Mistik iskenceci'yi at �zerinden �ld�r!")
                        say("Attan inersen kaybedersin.")
                        say("")
                end
                when 706.kill with pc.getf("horse_levelup","kill_count") >= 10 begin
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training6 begin
                when letter begin
                        q.set_counter("Kalan Zehirli Pen�e �r�mcegi:", 10-pc.getqf("kill_count"))
                end
                when 2034.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan Zehirli Pen�e �r�mcegi:", 10-pc.getqf("kill_count"))
                end
                when enter begin
                        pc.setqf("kill_count", 0)
                end
                when leave begin
                        q.done()
                end
                when letter begin

                        setskin(NOWINDOW)
                        makequestbutton("Zerihli Pen�e �r�mcegi �ld�r!")
                        q.set_title("Zerihli Pen�e �r�mcegi �ld�r!")
                        q.start()
                end
                when button begin
                        say_title("Zerihli Pen�e �r�mcegi'ni �ld�r!")
                        say("")
                        say("Zerihli Pen�e �r�mcegi'ni at �zerinden �ld�r!")
                        say("inersen isin bitti!")
                        say("")
                end
                when info begin
                        say_title("Zerihli Pen�e �r�mcegi'ni �ld�r!")
                        say("")
                        say("Zerihli Pen�e �r�mcegi'ni at �zerinden �ld�r!")
                        say("inersen isin bitti!")
                        say("")
                end
                when 2034.kill with pc.getf("horse_levelup","kill_count") >= 10 begin
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training7 begin
                when letter begin
                        q.set_counter("Kalan ��l Haydutu:", 20-pc.getqf("kill_count"))
                end
                when 2108.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan ��l Haydutu:", 20-pc.getqf("kill_count"))
                end
                when enter begin
                        pc.setqf("kill_count", 0)
                end
                when leave begin
                        q.done()
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("��l Haydutu �ld�r!")
                        q.set_title("��l Haydutu �ld�r!")
                        q.start()
                end
                when button begin
                        say_title("��l Haydutu'nu �ld�r!")
                        say("")
                        say("��l Haydutu'nu at �zerinden �ld�r!")
                        say("inersen isin bitti!")
                        say("")
                end
                when info begin
                        say_title("��l Haydutu'nu �ld�r!")
                        say("")
                        say("��l Haydutu'nu at �zerinden �ld�r!")
                        say("inersen isin bitti!")
                        say("")
                end
                when 2108.kill with pc.getf("horse_levelup","kill_count") >= 20 begin
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training8 begin
                when letter begin
                        q.set_counter("Kalan Buz Golemi:", 10-pc.getqf("kill_count"))
                end
                when 1107.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan Buz Golemi:", 10-pc.getqf("kill_count"))
                end
                when enter begin
                        pc.setqf("kill_count", 0)
                end
                when leave begin
                        q.done()
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Buz Golemi �ld�r!")
                        q.set_title("Buz Golemi �ld�r!")
                        q.start()
                end
                when button begin
                        say_title("Buz Golemi'ni �ld�r!")
                        say("")
                        say("Buz Golemi'ni at �zerinden �ld�r!")
                        say("inersen isin bitti!")
                        say("")
                end
                when info begin
                        say_title("Buz Golemi'ni �ld�r!")
                        say("Buz Golemi'ni at �zerinden �ld�r!")
                        say("inersen isin bitti!")
                        say("")
                end
                when 1107.kill with pc.getf("horse_levelup","kill_count") >= 10 begin
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training9 begin
                when letter begin
                        q.set_counter("Kalan Savas Kaplani:", 20-pc.getqf("kill_count"))
                end
                when 2203.kill begin
                        pc.setqf("kill_count", pc.getqf("kill_count")+1)
                        q.set_counter("Kalan Savas Kaplani:", 20-pc.getqf("kill_count"))
                end
                when enter begin
                        pc.setqf("kill_count", 0)
                end
                when leave begin
                        q.done()
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Savas Kaplanini vurarak �ld�r!")
                        q.set_title("Savas Kaplanini vurarak �ld�r!")
                        q.start()
                end
                when button begin
                        say_title("Savas Kaplanini vurarak �ld�r!")
                        say("")
                        say("Savas Kaplanini at �zerinden vurarak �ld�r!")
                        say("inersen kaybedersin.")
                        say("")
                end
                when info begin
                        say_title("Savas Kaplanini vurarak �ld�r!")
                        say("")
                        say("Savas Kaplanini at �zerinden vurarak �ld�r!")
                        say("inersen kaybedersin.")
                        say("")
                end
                when 2203.kill with pc.getf("horse_levelup","kill_count") >= 20 begin
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state start begin
                when 20349.chat."At ile nasil savasilir?" with horse.get_grade()==2 begin
                        if horse.get_level()==20 then
                                say_title("Seyis:")
                                say("")
                                say("Atin herseyi �grendi.")
                                say("Atini g��lendirmen lazim.")
                                say("")
                        elseif pc.countitem("50050")<1 then
                                say_title("Seyis:")
                                say("")
                                say("At antremani i�in madalyon lazim")
                                say("Sonular ")
                                say("ona yazilacak.")
                                say("")
                                setstate(need_item50050)
                        elseif get_time()<pc.getqf("next_time") then
                                say_title("Seyis:")
                                say("")
                                say("Atlarin dinlenmeye ihtiyaci var .")
                                say("Yarin dene.")
                                say("")
                        elseif horse.get_stamina_pct()<=10 then
                                say_title("Seyis:")
                                say("")
                                say("Atin yorgun.")
                                say("Onlara paydos ver.")
                                say("")
                        elseif horse.get_health_pct()<=10 then
                                say_title("Seyis:")
                                say("")
                                say("Atin �ok a�.")
                                say("Ona yem ver.")
                                say("")
                        elseif horse.is_riding()==0 then
                                say_title("Seyis:")
                                say("")
                                say("Atinla bana gel.")
                        elseif (horse.get_level()>=11 and horse.get_level()<=19) then
                                say_title("Seyis:")
                                say("")
                                say("At sirtinda saldiri yapmak")
                                say("ona binmekten �ok daha zor. Yanliz yaparak")
                                say("�grene bilirsin.")
                                say("Canavarlarla �gren.")
                                say("D�sersen kaybedersin.")
                                say("Kendine dikkat et ve dikatli ol!")
                                say("Sonu�lar madalyonlara")
                                say("islenecek.")
                                if is_test_server() then
                                        pc.setqf("next_time", get_time()+10)
                                else
                                        pc.setqf("next_time", get_time()+number(16, 32)*60*60)
                                end
                                if horse.get_level()==11 then
                                        setstate(training1)
                                elseif horse.get_level()==12 then
                                        setstate(training2)
                                elseif horse.get_level()==13 then
                                        setstate(training3)
                                elseif horse.get_level()==14 then
                                        setstate(training4)
                                elseif horse.get_level()==15 then
                                        setstate(training5)
                                elseif horse.get_level()==16 then
                                        setstate(training6)
                                elseif horse.get_level()==17 then
                                        setstate(training7)
                                elseif horse.get_level()==18 then
                                        setstate(training8)
                                elseif horse.get_level()==19 then
                                        setstate(training9)
                                end
                        end
                end
        end
        state need_item50050 begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("At madalyonu ara!")
                        q.set_title("At madalyonu ara!")
                        q.start()
                end
                when button begin
                        say_title("At madalyonu ara!")
                        say("")
                        say("At madalyonu savasmayi �grenmek i�in")
                        say("gerekli.")
                        say("Onu maymun zindanindan alabilirsin.")
                        setstate(start)
                        q.done()
                end
                when info begin
                        say_title("At madalyonu ara!")
                        say("")
                        say("At madalyonu savasmayi �grenmek i�in")
                        say("gerekli.")
                        say("Onu maymun zindanindan alabilirsin.")
                        setstate(start)
                        q.done()
                end
        end
        state failure begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("At �zerinden saldiri olmadi.")
                        q.set_title("At �zerinden saldiri olmadi.")
                        q.start()
                end
                when button begin
                        say_title("At �zerinden saldiri olmadi.")
                        say("")
                        say("D�st�n veya indin.")
                        say("G�rev basarisiz.")
                        say("")
                        setstate(start)
                        q.done()
                end
                when info begin
                        say_title("At �zerinden saldiri olmadi.")
                        say("")
                        say("D�st�n veya indin.")
                        say("G�rev basarisiz.")
                        say("")
                        setstate(start)
                        q.done()
                end
        end
        state report begin
                when letter begin
                        local v=find_npc_by_vnum(20349)
                        if 0==v then
                        else
                                target.vid("__TARGET__", v, "")
                        end
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Seyis'in yanina d�n")
                        q.set_title("Seyis'in yanina d�n.")
                        q.start()
                end
                when button begin
                        say_title("Seyis'in yanina d�n.")
                        say("")
                        say("Ona d�nersen ")
                        say("kazancini �grenebilirsin.")
                        say("")
                end
                when info begin
                        say_title("Seyis'in yanina d�n.")
                        say("")
                        say("Ona d�nersen")
                        say("kazancini �grenebilirsin.")
                        say("")
                end
                when __TARGET__.target.click begin
                        target.delete("__TARGET__")
                        say_title("Seyis:")
                        say("")
                        say("Her seyi yapabildin mi?")
                        say("Antremanin yarin devam ediyor.")
                        say("Bug�nk� sonu�larin  ")
                        say("madalyonda yaziyor. istersen bak.")
                        setstate(reward)
                        q.done()
                end
        end
        state reward begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Antreman sonu�lari.")
                        q.set_title("Antreman sonu�lari.")
                        q.start()
                end
                when button begin
                        say_title("Antreman sonu�lari.")
                        if horse.get_level()<=10 then
                                say("Atin antremeni yeterli degil.")
                        elseif horse.get_level()>=20 then
                                say("Atin seviyesi artabilir. ")
                        elseif (horse.get_level()>=11 and horse.get_level()<=19) then
                                local s=number(1, 2)
                                if 1>=s then -- 50.00% (1/2)
                                        say("At �zerinden saldiri olmadi.")
                                        say("")
                                        say("Seyis'in yanina d�n�s,")
                                        say("yeniden deneme")
                                        pc.setqf("next_time", 0)
                                elseif 2>=s then -- 50.00% (1/2)
                                        say("At antremanin fayda sagladi.")
                                        if pc.countitem("50050")>=1 then
                                                char_log(0, "HORSE_ADVANCE", "BEGIN")
                                                pc.removeitem("50050", 1)
                                                char_log(0, "HORSE_ADVANCE", "DEC 50050 1")
                                                horse.unride()
                                                horse.advance()
                                                horse.ride()
                                                char_log(0, "HORSE_ADVANCE", "INC horse_advance 1")
                                                char_log(0, "HORSE_ADVANCE", "END")
                                                say(" At seviyen"..(horse.get_level()).."")
                                                say("")
                                                if horse.get_level()==20 then
                                                        say("Atini gelistirmek ")
                                                        say("i�in Seyis'in")
                                                        say("yanina d�n.")
                                                        pc.setqf("next_time", 0)
                                                else
                                                        say("Usta at almak i�in ")
                                                        say("onunla 20.seviyeye kadar antreman yapman lazim.")
                                                        say("")
                                                end
                                        else
                                                say("Madalyonsuz atin �grendiklerini,")
                                                say("yazamasin.")
                                        end
                                end
                        end
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
