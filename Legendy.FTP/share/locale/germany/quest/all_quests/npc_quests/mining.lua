quest mining begin
        state start begin
                when 20015.chat."Marketi a� " begin
                        setskin(NOWINDOW)
                        npc.open_shop()
                end

                when 20015.take with item.vnum >= 29101 and item.vnum < 29200 and item.get_socket(0) != item.get_value(2) begin

                        say_title("Deokbae:")
                        say("")
                        ---                                                   l
                        say("E�itimin yetersiz oldu�u i�in,")
                        say("kazman� geli�tiremezsin.")
                        say("")
                end
                when 20015.take with item.vnum >= 29101 and item.vnum < 29200 and item.get_socket(0) == item.get_value(2) begin
                        say_title("Deokbae:")
                        say("")
                        ---                                                   l
                        say("Kazman� geli�tirmek istiyor musun?")
                        say("Haydi g�relim...")
                        say("Kazman�n seviyesi:".. item.get_level().. ".")
                        say("")

                        if item.get_value(3) == 100 then
                        say_title("Deokbae:")
                        say("")
                                say("Bunu geli�tirmek istiyor musun?")
                                say("")
                        else
                        say_title("Deokbae:")
                        say("")
                                ---                                                   l
                                say("E�er bu balta geli�tirilirse, becerin")
                                say("yetersiz oldu�u i�in, geli�im kademelerinden " .. 100-item.get_value(3))
                                say("en az 100 kayb�n olacak.")
                                say("Hala geli�tirmek istiyor musun?")
                                say("")
                        end

                        local s = select("Evet","Hay�r")
                        if s == 2 then
                        say_title("Deokbae:")
                        say("")
                                say("Daha sonra yine gel.")
                                say("")
                                return
                        end

                        local f = __refine_pick(item.get_cell())
                        if f == 2 then
                        say_title("Deokbae:")
                        say("")
                                ---                                                   l
                                say("Bir problem y�z�nden balta geli�tirilemiyor.")
                                say("Geri d�n ve")
                                say("ba�ka bir zaman dene.")
                                say("")

                        elseif f == 1 then
                        say_title("Deokbae:")
                        say("")
                                say("i�te yeni seviyesindeki baltan burada!")
                                say("")
                        else
                        say_title("Deokbae:")
                        say("")
                                ---                                                   l
                                say("Oh Hay�r, bir yanl��l�k var. ")
                                say("�zg�n�m. Ne yaz�k ki seviye d��t�.")
                                say("")
                        end
                end

                when 20047.click or
                        20048.click or
                        20049.click or
                        20050.click or
                        20051.click or
                        20052.click or
                        20053.click or
                        20054.click or
                        20055.click or
                        20056.click or
                        20057.click or
                        20058.click or
                        20059.click or
						30301.click or
						30302.click or
						30303.click or
						30304.click or
						30305.click begin

                        if pc.is_mount() != true then
                                pc.mining()
                        end
                end
        end
end
