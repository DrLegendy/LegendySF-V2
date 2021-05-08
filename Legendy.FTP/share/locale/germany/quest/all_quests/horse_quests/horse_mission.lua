quest pony_levelup begin
        state training_frame_red_step9 begin
                when letter begin
                        target.pos("__TARGET__", 200, 700, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_red_step8 begin
                when letter begin
                        target.pos("__TARGET__", 180, 520, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Noktaya ulasildi!")
                        say("")
                        setstate(training_frame_red_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_red_step7 begin
                when letter begin
                        target.pos("__TARGET__", 500, 500, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Noktaya ulasildi!")
                        say("")
                        setstate(training_frame_red_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_red_step6 begin
                when letter begin
                        target.pos("__TARGET__", 610, 400, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya varildi!")
                        say("")
                        setstate(training_frame_red_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_red_step5 begin
                when letter begin
                        target.pos("__TARGET__", 960, 545, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya varildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_red_step4 begin
                when letter begin
                        target.pos("__TARGET__", 940, 390, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_red_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_red_step3 begin
                when letter begin
                        target.pos("__TARGET__", 650, 270, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_red_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_red_step2 begin
                when letter begin
                        target.pos("__TARGET__", 380, 240, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_red_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_red_step1 begin
                when letter begin
                        target.pos("__TARGET__", 140, 270, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çikis")
                                if 1==b then
                                        pc.warp_local(62, 100, 100)
                                elseif 2==b then
                                        say("Çikmak istediginizden emin misiniz?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 100, 100)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi(1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çikis")
                                if 1==b then
                                        pc.warp_local(62, 100, 100)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 100, 100)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_red_step2)
                end
        end
        state training_frame_blue_step9 begin
                when letter begin
                        target.pos("__TARGET__", 100, 100, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_blue_step8 begin
                when letter begin
                        target.pos("__TARGET__", 1430, 135, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_blue_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_blue_step7 begin
                when letter begin
                        target.pos("__TARGET__", 1235, 310, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_blue_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_blue_step6 begin
                when letter begin
                        target.pos("__TARGET__", 390, 580, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_blue_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_blue_step5 begin
                when letter begin
                        target.pos("__TARGET__", 1100, 450, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_blue_step4 begin
                when letter begin
                        target.pos("__TARGET__", 940, 390, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_blue_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_blue_step3 begin
                when letter begin
                        target.pos("__TARGET__", 650, 270, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_blue_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_blue_step2 begin
                when letter begin
                        target.pos("__TARGET__", 380, 240, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_blue_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_blue_step1 begin
                when letter begin
                        target.pos("__TARGET__", 140, 270, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çikis")
                                if 1==b then
                                        pc.warp_local(62, 100, 100)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 100, 100)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çikis")
                                if 1==b then
                                        pc.warp_local(62, 100, 100)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 100, 100)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_blue_step2)
                end
        end
        state training_frame_yellow_step9 begin
                when letter begin
                        target.pos("__TARGET__", 200, 700, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_yellow_step8 begin
                when letter begin
                        target.pos("__TARGET__", 70, 740, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_yellow_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_yellow_step7 begin
                when letter begin
                        target.pos("__TARGET__", 110, 1200, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_yellow_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_yellow_step6 begin
                when letter begin
                        target.pos("__TARGET__", 500, 1200, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_yellow_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_yellow_step5 begin
                when letter begin
                        target.pos("__TARGET__", 500, 910, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_yellow_step4 begin
                when letter begin
                        target.pos("__TARGET__", 510, 665, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_yellow_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_yellow_step3 begin
                when letter begin
                        target.pos("__TARGET__", 690, 870, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_yellow_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_yellow_step2 begin
                when letter begin
                        target.pos("__TARGET__", 900, 840, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi(2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_yellow_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_yellow_step1 begin
                when letter begin
                        target.pos("__TARGET__", 1250, 690, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("Git", "Çik")
                                if 1==b then
                                        pc.warp_local(62, 1430, 750)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 1430, 750)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta  (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("Git", "Çik")
                                if 1==b then
                                        pc.warp_local(62, 1430, 750)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 1430, 750)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_yellow_step2)
                end
        end
        state training_frame_purple_step9 begin
                when letter begin
                        target.pos("__TARGET__", 1430, 750, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_purple_step8 begin
                when letter begin
                        target.pos("__TARGET__", 450, 700, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_purple_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_purple_step7 begin
                when letter begin
                        target.pos("__TARGET__", 420, 1030, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_purple_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_purple_step6 begin
                when letter begin
                        target.pos("__TARGET__", 100, 520, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_purple_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_purple_step5 begin
                when letter begin
                        target.pos("__TARGET__", 490, 560, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_purple_step4 begin
                when letter begin
                        target.pos("__TARGET__", 510, 665, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_purple_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_purple_step3 begin
                when letter begin
                        target.pos("__TARGET__", 690, 870 , 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_purple_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_purple_step2 begin
                when letter begin
                        target.pos("__TARGET__", 900, 840, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_purple_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_purple_step1 begin
                when letter begin
                        target.pos("__TARGET__", 1250, 690, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(62, 1430, 750)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 1430, 750)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(62, 1430, 750)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 1430, 750)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_purple_step2)
                end
        end
        state training_frame_white_step9 begin
                when letter begin
                        target.pos("__TARGET__", 200, 700, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_white_step8 begin
                when letter begin
                        target.pos("__TARGET__", 80, 950, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_white_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_white_step7 begin
                when letter begin
                        target.pos("__TARGET__", 180, 1200, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_white_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_white_step6 begin
                when letter begin
                        target.pos("__TARGET__", 500, 1000, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_white_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_white_step5 begin
                when letter begin
                        target.pos("__TARGET__", 800, 1200, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi 5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_white_step4 begin
                when letter begin
                        target.pos("__TARGET__", 1010, 1150, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_white_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_white_step3 begin
                when letter begin
                        target.pos("__TARGET__", 1000, 1300, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_white_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_white_step2 begin
                when letter begin
                        target.pos("__TARGET__", 710, 1380, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_white_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_white_step1 begin
                when letter begin
                        target.pos("__TARGET__", 515, 1455, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(62, 100, 1400)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 100, 1400)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(62, 100, 1400)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 100, 1400)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_white_step2)
                end
        end
        state training_frame_sky_step9 begin
                when letter begin
                        target.pos("__TARGET__", 100, 1400, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_sky_step8 begin
                when letter begin
                        target.pos("__TARGET__", 485, 1315, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_sky_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_sky_step7 begin
                when letter begin
                        target.pos("__TARGET__", 1430, 1400, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_sky_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_sky_step6 begin
                when letter begin
                        target.pos("__TARGET__", 1400, 1200, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_sky_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_sky_step5 begin
                when letter begin
                        target.pos("__TARGET__", 1230, 1080, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_sky_step4 begin
                when letter begin
                        target.pos("__TARGET__", 1010, 1150, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_sky_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_sky_step3 begin
                when letter begin
                        target.pos("__TARGET__", 1000, 1300, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_sky_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_sky_step2 begin
                when letter begin
                        target.pos("__TARGET__", 710, 1380, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_sky_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_frame_sky_step1 begin
                when letter begin
                        target.pos("__TARGET__", 515, 1455, 62, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(62, 100, 1400)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 100, 1400)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=62 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(62, 100, 1400)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(62, 100, 1400)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_frame_sky_step2)
                end
        end
        state training_desert_red_step4 begin
                when letter begin
                        target.pos("__TARGET__", 903, 670, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_red_step3 begin
                when letter begin
                        target.pos("__TARGET__", 680, 700, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_red_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_red_step2 begin
                when letter begin
                        target.pos("__TARGET__", 410, 690, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_red_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_red_step1 begin
                when letter begin
                        target.pos("__TARGET__", 480, 1020, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button or info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=63 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(63, 430, 1200)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(63, 430, 1200)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_red_step2)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_blue_step3 begin
                when letter begin
                        target.pos("__TARGET__", 1400, 1400, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_blue_step2 begin
                when letter begin
                        target.pos("__TARGET__", 1350, 1100, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_blue_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_blue_step1 begin
                when letter begin
                        target.pos("__TARGET__", 1200, 1200, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button or info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=63 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(63, 1200, 830)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(63, 1200, 830)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_blue_step2)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_yellow_step6 begin
                when letter begin
                        target.pos("__TARGET__", 930, 670, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_yellow_step5 begin
                when letter begin
                        target.pos("__TARGET__", 680, 700, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_yellow_step4 begin
                when letter begin
                        target.pos("__TARGET__", 680, 560, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Reitertraining(4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_yellow_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_yellow_step3 begin
                when letter begin
                        target.pos("__TARGET__", 710, 380, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_yellow_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_yellow_step2 begin
                when letter begin
                        target.pos("__TARGET__", 1140, 510, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_yellow_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_yellow_step1 begin
                when letter begin
                        target.pos("__TARGET__", 1130, 930, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button or info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=63 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(63, 950, 830)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(63, 950, 830)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_yellow_step2)
                end
        end
        state training_desert_purple_step4 begin
                when letter begin
                        target.pos("__TARGET__", 410, 690, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_purple_step3 begin
                when letter begin
                        target.pos("__TARGET__", 500, 500, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_purple_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_purple_step2 begin
                when letter begin
                        target.pos("__TARGET__", 330, 320, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_purple_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_purple_step1 begin
                when letter begin
                        target.pos("__TARGET__", 140, 420, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=63 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(63, 170, 980)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(63, 170, 980)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=63 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(63, 170, 980)
                                elseif 2==b then
                                        say("Çikmak istediginizden emin misiniz?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(63, 170, 980)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_purple_step2)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_white_step4 begin
                when letter begin
                        target.pos("__TARGET__", 930, 670, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_white_step3 begin
                when letter begin
                        target.pos("__TARGET__", 920, 440, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_white_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_white_step2 begin
                when letter begin
                        target.pos("__TARGET__", 1140, 510, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_white_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_white_step1 begin
                when letter begin
                        target.pos("__TARGET__", 1190, 900, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=63 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(63, 860, 1200)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(63, 860, 1200)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=63 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(63, 860, 1200)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(63, 860, 1200)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_white_step2)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_sky_step3 begin
                when letter begin
                        target.pos("__TARGET__", 170, 980, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_sky_step2 begin
                when letter begin
                        target.pos("__TARGET__", 410, 690, 63, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Spot (2) reached!")
                        say("")
                        setstate(training_desert_sky_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_desert_sky_step1 begin
                when letter begin
                        target.pos("__TARGET__", 480, 1020, 63, "")
                end
                when letter begin
                        send_letter("Binicilik egitimi (1)")
                end
                when button or info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=63 then
                                say("Egitim alanina git..")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(63, 430, 1200)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(63, 430, 1200)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_desert_sky_step2)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_red_step9 begin
                when letter begin
                        target.pos("__TARGET__", 150, 740, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_red_step8 begin
                when letter begin
                        target.pos("__TARGET__", 380, 820, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_red_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_red_step7 begin
                when letter begin
                        target.pos("__TARGET__", 380, 650, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")

                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_red_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_red_step6 begin
                when letter begin
                        target.pos("__TARGET__", 720, 740, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_red_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_red_step5 begin
                when letter begin
                        target.pos("__TARGET__", 800, 730, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_red_step4 begin
                when letter begin
                        target.pos("__TARGET__", 1030, 570, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_red_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_red_step3 begin
                when letter begin
                        target.pos("__TARGET__", 720, 360, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_red_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_red_step2 begin
                when letter begin
                        target.pos("__TARGET__", 380, 500, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_red_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_red_step1 begin
                when letter begin
                        target.pos("__TARGET__", 380, 820, 64, "")

                        if pc.get_map_index()!=64 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(64, 150, 740)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(64, 150, 740)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=64 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(64, 150, 740)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(64, 150, 740)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=64 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(64, 150, 740)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(64, 150, 740)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Spot (1) reached!")
                        say("")
                        setstate(training_valley_red_step2)
                end
        end
        state training_valley_blue_step9 begin
                when letter begin
                        target.pos("__TARGET__", 1460, 80, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_blue_step8 begin
                when letter begin
                        target.pos("__TARGET__", 1090, 510, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_blue_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_blue_step7 begin
                when letter begin
                        target.pos("__TARGET__", 770, 810, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_blue_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_blue_step6 begin
                when letter begin
                        target.pos("__TARGET__", 780, 1080, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_blue_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_blue_step5 begin
                when letter begin
                        target.pos("__TARGET__", 940, 1110, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_blue_step4 begin
                when letter begin
                        target.pos("__TARGET__", 1060, 930, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_blue_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_blue_step3 begin
                when letter begin
                        target.pos("__TARGET__", 1190, 700, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_blue_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_blue_step2 begin
                when letter begin
                        target.pos("__TARGET__", 1390, 570, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_blue_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_blue_step1 begin
                when letter begin
                        target.pos("__TARGET__", 1230, 500, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=64 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(64, 1460, 80)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(64, 1460, 80)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=64 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(64, 1460, 80)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(64, 1460, 80)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya varildi!")
                        say("")
                        setstate(training_valley_blue_step2)
                end
        end
        state training_valley_yellow_step9 begin
                when letter begin
                        target.pos("__TARGET__", 650, 1420, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya varildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_yellow_step8 begin
                when letter begin
                        target.pos("__TARGET__", 970, 1080, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_yellow_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_yellow_step7 begin
                when letter begin
                        target.pos("__TARGET__", 780, 1080, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                        end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_yellow_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_yellow_step6 begin
                when letter begin
                        target.pos("__TARGET__", 710, 730, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_yellow_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_yellow_step5 begin
                when letter begin
                        target.pos("__TARGET__", 1090, 510, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_yellow_step4 begin
                when letter begin
                        target.pos("__TARGET__", 1300, 500, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_yellow_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_yellow_step3 begin
                when letter begin
                        target.pos("__TARGET__", 1350, 640, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_yellow_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_yellow_step2 begin
                when letter begin
                        target.pos("__TARGET__", 1340, 1140, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_yellow_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_valley_yellow_step1 begin
                when letter begin
                        target.pos("__TARGET__", 970, 1080, 64, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=64 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(64, 650, 1420)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(64, 650, 1420)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=64 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(64, 650, 1420)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(64, 650, 1420)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_valley_yellow_step2)
                end
        end
        state training_snow_red_step9 begin
                when letter begin
                        target.pos("__TARGET__", 160, 270, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_red_step8 begin
                when letter begin
                        target.pos("__TARGET__", 170, 620, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_red_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_red_step7 begin
                when letter begin
                        target.pos("__TARGET__", 580, 350, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_red_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_red_step6 begin
                when letter begin
                        target.pos("__TARGET__", 760, 610, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_red_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_red_step5 begin
                when letter begin
                        target.pos("__TARGET__", 790, 810, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_red_step4 begin
                when letter begin
                        target.pos("__TARGET__", 670, 820, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_red_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_red_step3 begin
                when letter begin
                        target.pos("__TARGET__", 760, 610, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_red_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_red_step2 begin
                when letter begin
                        target.pos("__TARGET__", 580, 350, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_red_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_red_step1 begin
                when letter begin
                        target.pos("__TARGET__", 170, 620, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=61 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(61, 160, 270)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(61, 160, 270)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=61 then
                                say("Egitim alanina git.")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(61, 160, 270)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(61, 160, 270)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_red_step2)
                end
        end
        state training_snow_blue_step9 begin
                when letter begin
                        target.pos("__TARGET__", 1380, 160, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_blue_step8 begin
                when letter begin
                        target.pos("__TARGET__", 1240, 290, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_blue_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_blue_step7 begin
                when letter begin
                        target.pos("__TARGET__", 1330, 540, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_blue_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_blue_step6 begin
                when letter begin
                        target.pos("__TARGET__", 950, 470, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_blue_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_blue_step5 begin
                when letter begin
                        target.pos("__TARGET__", 760, 610, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_blue_step4 begin
                when letter begin
                        target.pos("__TARGET__", 810, 120, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_blue_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_blue_step3 begin
                when letter begin
                        target.pos("__TARGET__", 760, 610, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_blue_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_blue_step2 begin
                when letter begin
                        target.pos("__TARGET__", 1010, 180, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_blue_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_blue_step1 begin
                when letter begin
                        target.pos("__TARGET__", 1240, 290, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=61 then
                                say("Egitim alanina git..")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(61, 1380, 160)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(61, 1380, 160)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=61 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(61, 1380, 160)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(61, 1380, 160)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_blue_step2)
                end
        end
        state training_snow_yellow_step9 begin
                when letter begin
                        target.pos("__TARGET__", 760, 1380, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (9)")
                        q.set_title("Binicilik egitimi (9)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("Gidilecek nokta (9)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (9)")
                        say("")
                        say_reward("(9)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_yellow_step8 begin
                when letter begin
                        target.pos("__TARGET__", 390, 1160, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (8)")
                        q.set_title("Binicilik egitimi (8)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("Gidilecek nokta (8)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (8)")
                        say("")
                        say_reward("(8)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_yellow_step9)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_yellow_step7 begin
                when letter begin
                        target.pos("__TARGET__", 400, 1040, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (7)")
                        q.set_title("Binicilik egitimi (7)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("Gidilecek nokta (7)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (7)")
                        say("")
                        say_reward("(7)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_yellow_step8)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_yellow_step6 begin
                when letter begin
                        target.pos("__TARGET__", 660, 1030, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (6)")
                        q.set_title("Binicilik egitimi (6)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("Gidilecek nokta (6)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (6)")
                        say("")
                        say_reward("(6)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_yellow_step7)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_yellow_step5 begin
                when letter begin
                        target.pos("__TARGET__", 770, 640, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (5)")
                        q.set_title("Binicilik egitimi (5)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("Gidilecek nokta (5)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (5)")
                        say("")
                        say_reward("(5)Nolu noktaya ulasildi!")
                        say("")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_yellow_step4 begin
                when letter begin
                        target.pos("__TARGET__", 660, 840, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (4)")
                        q.set_title("Binicilik egitimi (4)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("Gidilecek nokta (4)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (4)")
                        say("")
                        say_reward("(4)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_yellow_step5)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_yellow_step3 begin
                when letter begin
                        target.pos("__TARGET__", 660, 1030, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (3)")
                        q.set_title("Binicilik egitimi (3)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("Gidilecek nokta (3)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (3)")
                        say("")
                        say_reward("(3)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_yellow_step4)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_yellow_step2 begin
                when letter begin
                        target.pos("__TARGET__", 1100, 1080, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (2)")
                        q.set_title("Binicilik egitimi (2)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when info begin
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("Gidilecek nokta (2)")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (2)")
                        say("")
                        say_reward("(2)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_yellow_step3)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training_snow_yellow_step1 begin
                when letter begin
                        target.pos("__TARGET__", 940, 1320, 61, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi (1)")
                        q.set_title("Binicilik egitimi (1)")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=61 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(61, 760, 1380)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(61, 760, 1380)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when info begin
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("Gidilecek nokta (1)")
                        say("")
                        if pc.get_map_index()!=61 then
                                say("Egitim alanina git.")
                                say("")
                                local b=select("LOS", "Çik")
                                if 1==b then
                                        pc.warp_local(61, 760, 1380)
                                elseif 2==b then
                                        say("Çikmak istediginden emin misin?")
                                        say("")
                                        local b=select("Evet", "Hayir")
                                        if 1==b then
                                                setstate(start)
                                                q.done()
                                        elseif 2==b then
                                                pc.warp_local(61, 760, 1380)
                                        else
                                                say("UNKNOWN BUTTON ["..b.."]")
                                        end
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        end
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say_title("Binicilik egitimi (1)")
                        say("")
                        say_reward("(1)Nolu noktaya ulasildi!")
                        say("")
                        setstate(training_snow_yellow_step2)
                end
        end
        state training1_normal1 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 586, 1139, 1, "")
                        target.pos("Hedef2", 260, 1172, 1, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya git.")
                        q.set_title("Her noktaya git.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya atini")
                        say_reward("sür. Eger attan inerseniz")
                        say_reward("egitiminiz basarisiz olur.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginizden emin misiniz?")
                                say("Çikarsaniz yarin en bastan")
                                say("tekrar baslayabilirsiniz.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya ")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training1_normal2 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 221, 821, 1, "")
                        target.pos("Hedef2", 305, 419, 1, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen ")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya ")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training1_normal3 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 215, 176, 1, "")
                        target.pos("Hedef2", 838, 248, 1, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya ")
                        say_reward("atini sür. Eger attan inersen egitimin")
                        say_reward("basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan egitimine")
                                say("tekrar baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan yarin en bastan egitimine")
                                say("tekrar baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training1_normal4 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 886, 728, 1, "")
                        target.pos("Hedef2", 601, 986, 1, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan egitimine")
                                say("tekrar baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya ")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en basindan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training2_normal1 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 287, 449, 21, "")
                        target.pos("Hedef2", 514, 209, 21, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi.")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor.")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi.")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor.")
                        end
                        say("")
                        local b=select("LOS", "Çik.")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsaniz, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training2_normal2 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 649, 377, 21, "")
                        target.pos("Hedef2", 883, 491, 21, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi.")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsaniz, yarin en bastan tekrar")
                                say("egitime baslayabilirsiniz..")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor.")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi.")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor.")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training2_normal3 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 859, 824, 21, "")
                        target.pos("Hedef2", 670, 1025, 21, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya ")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training2_normal4 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 212, 992, 21, "")
                        target.pos("Hedef2", 211, 488, 21, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en basindan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor.")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training3_normal1 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 200, 713, 41, "")
                        target.pos("Hedef2", 200, 356, 41, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsaniz, yarin en bastan tekrar")
                                say("egitime baslayabilirsiniz.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training3_normal2 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 176, 1061, 41, "")
                        target.pos("Hedef2", 422, 827, 41, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training3_normal3 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 757, 869, 41, "")
                        target.pos("Hedef2", 772, 446, 41, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor.")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor.")
                        end
                        say("")
                        local b=select("LOS", "Quit")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training3_normal4 begin
                when letter begin
                        pc.setqf("flag1", 0)
                        pc.setqf("flag2", 0)
                        target.pos("Hedef1", 808, 314, 41, "")
                        target.pos("Hedef2", 206, 191, 41, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor.")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                        if pc.getqf("flag1")==1 then
                                say("Nokta 1: Tamamlandi")
                        elseif pc.getqf("flag1")==0 then
                                say("Nokta 1: Devam ediyor")
                        end
                        if pc.getqf("flag2")==1 then
                                say("Nokta 2: Tamamlandi")
                        elseif pc.getqf("flag2")==0 then
                                say("Nokta 2: Devam ediyor")
                        end
                        say("")
                        local b=select("LOS", "Çik")
                        if 1==b then
                        elseif 2==b then
                                say("Çikmak istediginden emin misin?")
                                say("Çikarsan, yarin en bastan tekrar")
                                say("egitime baslayabilirsin.")
                                say("")
                                local b=select("Evet", "Hayir")
                                if 1==b then
                                        setstate(start)
                                elseif 2==b then
                                else
                                        say("UNKNOWN BUTTON ["..b.."]")
                                end
                        else
                                say("UNKNOWN BUTTON ["..b.."]")
                        end
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when target1.target.arrive begin
                        target.delete("Hedef1")
                        say("Nokta 1 isaretlendi.")
                        pc.setqf("flag1", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when target2.target.arrive begin
                        target.delete("Hedef2")
                        say("Nokta 2 isaretlendi.")
                        pc.setqf("flag2", 1)
                        if pc.getqf("flag1")==1 and pc.getqf("flag2")==1 then
                                setstate(report)
                        end
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training1_easy1 begin
                when letter begin
                        target.pos("__TARGET__", 84, 602, 1, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training1_easy2 begin
                when letter begin
                        target.pos("__TARGET__", 591, 1166, 1, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training1_easy3 begin
                when letter begin
                        target.pos("__TARGET__", 913, 1013, 1, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya ")
                        say_reward("atini sür. Eger attan inersen ")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training1_easy4 begin
                when letter begin
                        target.pos("__TARGET__", 405, 73, 1, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen ")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training2_easy1 begin
                when letter begin
                        target.pos("__TARGET__", 298, 638, 21, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training2_easy2 begin
                when letter begin
                        target.pos("__TARGET__", 358, 1110, 21, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training2_easy3 begin
                when letter begin
                        target.pos("__TARGET__", 876, 1025, 21, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen ")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training2_easy4 begin
                when letter begin
                        target.pos("__TARGET__", 908, 87, 21, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya ")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training3_easy1 begin
                when letter begin
                        target.pos("__TARGET__", 125, 1118, 41, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training3_easy2 begin
                when letter begin
                        target.pos("__TARGET__", 670, 1157, 41, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training3_easy3 begin
                when letter begin
                        target.pos("__TARGET__", 819, 315, 41, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Harikada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state training3_easy4 begin
                when letter begin
                        target.pos("__TARGET__", 137, 126, 41, "")
                end
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Her noktaya at sür.")
                        q.set_title("Her noktaya at sür.")
                        q.start()
                end
                when button begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when info begin
                        say_title("Her noktaya at sür.")
                        say("")
                        say_reward("Haritada isaretlenen her noktaya")
                        say_reward("atini sür. Eger attan inersen")
                        say_reward("egitimin basarisiz olacak.")
                        say("")
                end
                when 22000.use begin
                        setstate(failure)
                end
                when 22010.use begin
                        setstate(failure)
                end
                when __TARGET__.target.arrive begin
                        target.delete("__TARGET__")
                        say("Nokta isaretlendi.")
                        setstate(report)
                end
                when unmount begin
                        setstate(failure)
                end
        end
        state start begin
                when 20349.chat."Seyis:" with horse.get_grade()==1 and (horse.get_level()>=1 and horse.get_level()<=10) begin
                        if pc.countitem("50050")<1 then
                                say_title("Seyis:")
                                say("")
                                say("Eger egitim almak istiyorsan, sonucunu alabilmek")
                                say("için bir at madalyonuna ihtiyacin var.")
                                say("")
                                setstate(need_item50050)
                        elseif get_time()<pc.getqf("next_time") then
                                say_title("Seyis:")
                                say("")
                                say("Atlarin dinlenmek için zamana ihtiyaci var.")
                                say("Yarin tekrar gelmen daha iyi olur.")
                                say("")
                        elseif horse.get_stamina_pct()<=10 then
                                say_title("Seyis:")
                                say("")
                                say("Atin çok yorgun görünüyor.")
                                say("Onu dinlendirmelisin.")
                                say("")
                        elseif horse.get_health_pct()<=10 then
                                say_title("Seyis:")
                                say("")
                                say("Atin acikmis görünüyor.")
                                say("Egitimden önce onu biraz")
                                say("beslemeye ne dersin?")
                                say("")
                        elseif horse.get_level()==10 then
                                say_title("Seyis:")
                                say("")
                                say("Atinin daha fazla egitime ihtiyaci yok.")
                                say("Silah-At Kitabi almayi denemelisin.")
                                say("")
                                say("")
                        elseif horse.is_riding()==0 then
                                say_title("Seyis:")
                                say("")
                                say("Bana dogru atini sür.")
                                say("")
                                elseif (horse.get_level()>=8 and horse.get_level()<=9) then
                                ----"12345678901234567890123456789012345678901234567890"|
                                say_title("Seyis:")
                                say("")
                                say("Egitimin hemen hemen bitti!")
                                say("Hadi git! Atinla haritayi kesfe çik.")
                                say("Bu süreç çok zor olibilir,")
                                say("fakat endiselenme, sadece hazir ol")
                                say("ve kendine dikkat et. Basaracagini")
                                say("biliyorum. simdi bu uzun yolculuga")
                                say("çikma zamani. Gülegüle arkadasim, ")
                                say("kisa zamanda geri dön. Egitiminin sonuçlari")
                                say("at madalyonuna islenecek.")
                                say("Orta seviyeye yükselme için, kendini ")
                                say("simdiden hazirlamalisin.")
                                if is_test_server() then
                                        pc.setqf("next_time", get_time()+10)
                                else
                                        pc.setqf("next_time", get_time()+number(12, 24)*60*60)
                                end
                                if is_test_server() then
                                        local s=select("1 val(1) 12.50%","2 val(1) 12.50%","3 val(1) 12.50%","4 val(1) 12.50%","5 val(1) 12.50%","6 val(1) 12.50%","7 val(1) 12.50%","8 val(1) 12.50%")
                                        if 1==s then
                                                setstate(training_frame_red_step1)
                                        elseif 2==s then
                                                setstate(training_frame_blue_step1)
                                        elseif 3==s then
                                                setstate(training_frame_yellow_step1)
                                        elseif 4==s then
                                                setstate(training_frame_purple_step1)
                                        elseif 5==s then
                                                setstate(training_frame_white_step1)
                                        elseif 6==s then
                                                setstate(training_snow_red_step1)
                                        elseif 7==s then
                                                setstate(training_snow_blue_step1)
                                        elseif 8==s then
                                                setstate(training_snow_yellow_step1)
                                        end
                                else
                                        local s=number(1, 8)
                                        if 1>=s then -- 12.50% (1/8)
                                                setstate(training_frame_red_step1)
                                        elseif 2>=s then -- 12.50% (1/8)
                                                setstate(training_frame_blue_step1)
                                        elseif 3>=s then -- 12.50% (1/8)
                                                setstate(training_frame_yellow_step1)
                                        elseif 4>=s then -- 12.50% (1/8)
                                                setstate(training_frame_purple_step1)
                                        elseif 5>=s then -- 12.50% (1/8)
                                                setstate(training_frame_white_step1)
                                        elseif 6>=s then -- 12.50% (1/8)
                                                setstate(training_snow_red_step1)
                                        elseif 7>=s then -- 12.50% (1/8)
                                                setstate(training_snow_blue_step1)
                                        elseif 8>=s then -- 12.50% (1/8)
                                                setstate(training_snow_yellow_step1)
                                        end
                                end
                        elseif (horse.get_level()>=6 and horse.get_level()<=7) then
                                ----"12345678901234567890123456789012345678901234567890"|
                                say_title("Seyis:")
                                say("")
                                say("At resmin daha iyiye gidiyor")
                                say("görünüyor. Git ve atinla ")
                                say("haritayi kesfe çik..")
                                say("Bu tehlikeli olabilir, fakat")
                                say("mevcut kondüsyonun bunu basarmaya ")
                                say("yeterli. simdi bu uzun yolculuga")
                                say("çikma zamani. Gülegüle arkadasim,")
                                say("kisa sürede geri dön. Egitiminin sonuçlari")
                                say("at madalyonuna islenecek.")
                                say("simdi, atini seviye yükselmeye ")
                                say("hazirlama zamani.")
                                if is_test_server() then
                                        pc.setqf("next_time", get_time()+10)
                                else
                                        pc.setqf("next_time", get_time()+number(12, 24)*60*60)
                                end
                                if is_test_server() then
                                        local s=select("1 karar(1) 11.11%","2 karar(1) 11.11%","3 karar(1) 11.11%","4 karar(1) 11.11%","5 karar(1) 11.11%","6 karar(1) 11.11%","7 karar(1) 11.11%","8 karar(1) 11.11%","9 karar(1) 11.11%")
                                        if 1==s then
                                                setstate(training_valley_red_step1)
                                        elseif 2==s then
                                                setstate(training_valley_blue_step1)
                                        elseif 3==s then
                                                setstate(training_valley_yellow_step1)
                                        elseif 4==s then
                                                setstate(training_desert_red_step1)
                                        elseif 5==s then
                                                setstate(training_desert_blue_step1)
                                        elseif 6==s then
                                                setstate(training_desert_yellow_step1)
                                        elseif 7==s then
                                                setstate(training_desert_purple_step1)
                                        elseif 8==s then
                                                setstate(training_desert_white_step1)
                                        elseif 9==s then
                                                setstate(training_desert_sky_step1)
                                        end
                                else
                                        local s=number(1, 9)
                                        if 1>=s then -- 11.11% (1/9)
                                                setstate(training_valley_red_step1)
                                        elseif 2>=s then -- 11.11% (1/9)
                                                setstate(training_valley_blue_step1)
                                        elseif 3>=s then -- 11.11% (1/9)
                                                setstate(training_valley_yellow_step1)
                                        elseif 4>=s then -- 11.11% (1/9)
                                                setstate(training_desert_red_step1)
                                        elseif 5>=s then -- 11.11% (1/9)
                                                setstate(training_desert_blue_step1)
                                        elseif 6>=s then -- 11.11% (1/9)
                                                setstate(training_desert_yellow_step1)
                                        elseif 7>=s then -- 11.11% (1/9)
                                                setstate(training_desert_purple_step1)
                                        elseif 8>=s then -- 11.11% (1/9)
                                                setstate(training_desert_white_step1)
                                        elseif 9>=s then -- 11.11% (1/9)
                                                setstate(training_desert_sky_step1)
                                        end
                                end
                        elseif (horse.get_level()>=3 and horse.get_level()<=5) then

                                say_title("Seyis:")
                                say("")
                                say("Yeterince ögrenmis görünüyor.")
                                say("Artik sana daha zor görevler vermenin zamani geldi.")
                                say("Git ve köyün disindaki ana noktalari")
                                say("ziyaret et. At madalyonuna çok dikkat et! O senin")
                                say("egitim sonuçlarini gösterecek.")
                                say("")
                                if is_test_server() then
                                        pc.setqf("next_time", get_time()+10)
                                else
                                        pc.setqf("next_time", get_time()+number(12, 24)*60*60)
                                end
                                if pc.get_empire()==1 then
                                        if is_test_server() then
                                                local s=select("1 karar(1) 25.00%","2 karar(1) 25.00%","3 karar(1) 25.00%","4 karar(1) 25.00%")
                                                if 1==s then
                                                        setstate(training1_normal1)
                                                elseif 2==s then
                                                        setstate(training1_normal2)
                                                elseif 3==s then
                                                        setstate(training1_normal3)
                                                elseif 4==s then
                                                        setstate(training1_normal4)
                                                end
                                        else
                                                local s=number(1, 4)
                                                if 1>=s then -- 25.00% (1/4)
                                                        setstate(training1_normal1)
                                                elseif 2>=s then -- 25.00% (1/4)
                                                        setstate(training1_normal2)
                                                elseif 3>=s then -- 25.00% (1/4)
                                                        setstate(training1_normal3)
                                                elseif 4>=s then -- 25.00% (1/4)
                                                        setstate(training1_normal4)
                                                end
                                        end
                                elseif pc.get_empire()==2 then
                                        if is_test_server() then
                                                local s=select("1 karar(1) 25.00%","2 karar(1) 25.00%","3 karar(1) 25.00%","4 karar(1) 25.00%")
                                                if 1==s then
                                                        setstate(training2_normal1)
                                                elseif 2==s then
                                                        setstate(training2_normal2)
                                                elseif 3==s then
                                                        setstate(training2_normal3)
                                                elseif 4==s then
                                                        setstate(training2_normal4)
                                                end
                                        else
                                                local s=number(1, 4)
                                                if 1>=s then -- 25.00% (1/4)
                                                        setstate(training2_normal1)
                                                elseif 2>=s then -- 25.00% (1/4)
                                                        setstate(training2_normal2)
                                                elseif 3>=s then -- 25.00% (1/4)
                                                        setstate(training2_normal3)
                                                elseif 4>=s then -- 25.00% (1/4)
                                                        setstate(training2_normal4)
                                                end
                                        end
                                elseif pc.get_empire()==3 then
                                        if is_test_server() then
                                                local s=select("1 karar(1) 25.00%","2 karar(1) 25.00%","3 karar(1) 25.00%","4 karar(1) 25.00%")
                                                if 1==s then
                                                        setstate(training3_normal1)
                                                elseif 2==s then
                                                        setstate(training3_normal2)
                                                elseif 3==s then
                                                        setstate(training3_normal3)
                                                elseif 4==s then
                                                        setstate(training3_normal4)
                                                end
                                        else
                                                local s=number(1, 4)
                                                if 1>=s then -- 25.00% (1/4)
                                                        setstate(training3_normal1)
                                                elseif 2>=s then -- 25.00% (1/4)
                                                        setstate(training3_normal2)
                                                elseif 3>=s then -- 25.00% (1/4)
                                                        setstate(training3_normal3)
                                                elseif 4>=s then -- 25.00% (1/4)
                                                        setstate(training3_normal4)
                                                end
                                        end
                                end
                        elseif (horse.get_level()>=1 and horse.get_level()<=2) then
                                say_title("Seyis:")
                                say("")
                                say("Atin daha da büyümüs")
                                say("görünüyor! Fakat benim sahsi görüsüm")
                                say("ata hala bir amatör gibi bindigin.")
                                say("Çünkü binicilik becerini gelistirmelisin.")
                                say("Binicilik, atla çalismanin temelidir.")
                                say("Atina bin ve")
                                say("kendi etrafinda dön.")
                                say("At madalyonun egitiminin sonuçlarini ")
                                say("gösterecek.")
                                if is_test_server() then
                                        pc.setqf("next_time", get_time()+10)
                                else
                                        pc.setqf("next_time", get_time()+number(12, 24)*60*60)
                                end
                                if pc.get_empire()==1 then
                                        if is_test_server() then
                                                local s=select("1 val(1) 25.00%","2 val(1) 25.00%","3 val(1) 25.00%","4 val(1) 25.00%")
                                                if 1==s then
                                                        setstate(training1_easy1)
                                                elseif 2==s then
                                                        setstate(training1_easy2)
                                                elseif 3==s then
                                                        setstate(training1_easy3)
                                                elseif 4==s then
                                                        setstate(training1_easy4)
                                                end
                                        else
                                                local s=number(1, 4)
                                                if 1>=s then -- 25.00% (1/4)
                                                        setstate(training1_easy1)
                                                elseif 2>=s then -- 25.00% (1/4)
                                                        setstate(training1_easy2)
                                                elseif 3>=s then -- 25.00% (1/4)
                                                        setstate(training1_easy3)
                                                elseif 4>=s then -- 25.00% (1/4)
                                                        setstate(training1_easy4)
                                                end
                                        end
                                elseif pc.get_empire()==2 then
                                        if is_test_server() then
                                                local s=select("1 val(1) 25.00%","2 val(1) 25.00%","3 val(1) 25.00%","4 val(1) 25.00%")
                                                if 1==s then
                                                        setstate(training2_easy1)
                                                elseif 2==s then
                                                        setstate(training2_easy2)
                                                elseif 3==s then
                                                        setstate(training2_easy3)
                                                elseif 4==s then
                                                        setstate(training2_easy4)
                                                end
                                        else
                                                local s=number(1, 4)
                                                if 1>=s then -- 25.00% (1/4)
                                                        setstate(training2_easy1)
                                                elseif 2>=s then -- 25.00% (1/4)
                                                        setstate(training2_easy2)
                                                elseif 3>=s then -- 25.00% (1/4)
                                                        setstate(training2_easy3)
                                                elseif 4>=s then -- 25.00% (1/4)
                                                        setstate(training2_easy4)
                                                end
                                        end
                                elseif pc.get_empire()==3 then
                                        if is_test_server() then
                                                local s=select("1 val(1) 25.00%","2 val(1) 25.00%","3 val(1) 25.00%","4 val(1) 25.00%")
                                                if 1==s then
                                                        setstate(training3_easy1)
                                                elseif 2==s then
                                                        setstate(training3_easy2)
                                                elseif 3==s then
                                                        setstate(training3_easy3)
                                                elseif 4==s then
                                                        setstate(training3_easy4)
                                                end
                                        else
                                                local s=number(1, 4)
                                                if 1>=s then -- 25.00% (1/4)
                                                        setstate(training3_easy1)
                                                elseif 2>=s then -- 25.00% (1/4)
                                                        setstate(training3_easy2)
                                                elseif 3>=s then -- 25.00% (1/4)
                                                        setstate(training3_easy3)
                                                elseif 4>=s then -- 25.00% (1/4)
                                                        setstate(training3_easy4)
                                                end
                                        end
                                end
                        else
                                say("Görev durumu garip!")
                        end
                end
        end
        state need_item50050 begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("At madalyonu bul!")
                        q.set_title("At madalyonu bul!")
                        q.start()
                end
                when button begin
                        say_title("At madalyonu bul!")
                        say("")
                        say_reward("Binicilik egitiminden mezun olabilmek için bir ")
                        say_reward("at madalyonuna ihtiyacin var.")
                        say_reward("Bunun en kolay yolu Maymun Zindanindan almak.")
                        say("")
                        setstate(start)
                        q.done()
                end
                when info begin
                        say_title("At madalyonu bul!")
                        say("")
                        say_reward("Binicilik egitiminden mezun olabilmek için")
                        say_reward("bir at madalyonuna ihtiyacin var.")
                        say_reward("Bunun en kolay yolu, Maymun Zindani'ndan almak.")
                        say("")
                        setstate(start)
                        q.done()
                end
        end
        state failure begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Binicilik egitimi basarisiz.")
                        q.set_title("Binicilik egitimi basarisiz")
                        q.start()
                end
                when button begin
                        say_title("Binicilik egitimi basarisiz")
                        say("")
                        -----------"12345678901234567890123456789012345678901234567890"|
                        say_reward("Binicilik egitimin basarisiz oldu; ")
                        say_reward("attan indin veya")
                        say_reward("baglantin kesildi.")
                        say("")
                        setstate(start)
                end
                when info begin
                        say_title("Binicilik egitimi basarisiz")
                        say("")
                        say_reward("Binicilik egitimin basarisiz oldu;")
                        say_reward("attan indin veya ")
                        say_reward("baglantin kesildi.")
                        say("")
                        setstate(start)
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
                        makequestbutton("Seyis'in yanina dön.")
                        q.set_title("Seyis'in yanina dön.")
                        q.start()
                end
                when button begin
                        say("Seyis'in yanina dön.")
                        say("")
                        say_reward("Sonuçlarin at madalyonuna")
                        say_reward("islenebilmesi için Seyis'in")
                        say_reward("yanina dön.")
                        say("")
                        say_reward("Baglantin saglandiginda")
                        say_reward("egitiminin bitmis olacak.")
                        say("")
                end
                when info begin
                        say("Seyis'in yanina dön.")
                        say("")
                        say_reward("Sonuçlarin at madalyonuna")
                        say_reward("islenebilmesi için seyis'in")
                        say_reward("yanina dön.")
                        say("")
                        say_reward("Baglantin saglandiginda")
                        say_reward("egitimin bitmis olacak.")
                        say("")
                end
                when __TARGET__.target.click begin
                        target.delete("__TARGET__")
                        say_title("Seyis:")
                        say("")
                        say("Hepsini basardin mi?")
                        say("Egitime yarin devam edecegiz.")
                        say("Sonuçlarini at madalyonuna")
                        say("isleyecegim")
                        say("")
                        setstate(reward)
                end
        end
        state reward begin
                when letter begin
                        setskin(NOWINDOW)
                        makequestbutton("Acemi at sonuçlari")
                        q.set_title("Acemi at sonuçlari")
                        q.start()
                end
                when button begin
                        say("Acemi at sonuçlari")
                        if horse.get_level()>=11 then
                                say("simdi atini gelistirebilirsin.")
                        elseif (horse.get_level()>=1 and horse.get_level()<=10) then
                                local s=number(1, 2)
                                if 1>=s then -- 50.00% (1/2)
                                        say("Maalesef basarisiz!")
                                        say("")
                                        say("Tekrar denemek için")
                                        say("seyis'in yanina git.")
                                        pc.setqf("next_time", 0)
                                elseif 2>=s then -- 50.00% (1/2)
                                        say("Egitim Basarili!")
                                        if pc.countitem("50050")>=1 then
                                                char_log(0, "PONY_ADVANCE", "BEGIN")
                                                pc.removeitem("50050", 1)
                                                char_log(0, "PONY_ADVANCE", "DEC 50050 1")
                                                horse.unride()
                                                horse.advance()
                                                horse.ride()
                                                char_log(0, "PONY_ADVANCE", "INC horse_advance 1")
                                                char_log(0, "PONY_ADVANCE", "END")
                                                say("Atinin ulastigi seviye:"..(horse.get_level()).." ")
                                                say("")
                                                if horse.get_level()==10 then
                                                        say("Eger seyis'in yanina gidersen")
                                                        say("atini gelistirebilirsin.")
                                                        say("")
                                                        pc.setqf("next_time", 0)
                                                else
                                                        say("Atinin 10.seviyeye ulasabilmesi için")
                                                        say("daha fazla egitim almasi lazim.")
                                                        say("")
                                                end
                                        else
                                                say("Sonuçlarini göremiyorum,")
                                                say("Bir at madalyonun yok!")
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
