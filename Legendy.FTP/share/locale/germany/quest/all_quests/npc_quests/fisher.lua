quest fisher begin
    state start begin
                when 9009.chat."Marketi a� " begin
                    npc.open_shop(9009)
                        setskin(NOWINDOW)
                end

                when 9009.chat."Bal�k�� oltas�n� geli�tirmek" begin
                        say_title("Bal�k�� :")
                        say("")
                        ----"12345678901234567890123456789012345678901234567890"|
                        say("Sen bal�k�� oltas�n� daha iyi hale getirmenin")
                        say("s�rlar�n� biliyor musun? Yani, bu b�y�k bir s�r")
                        say("de�il. Ne kadar uzun s�re bal�k tutarsan, oltanda")
                        say("o kadar �ok puan birikir. Oltan maksimum de�ere")
                        say("ula�t���nda onu bana getir. Ben de senin i�in")
                        say("geli�tireyim.")
                        say("Pekala. �imdi geli�mesini istedi�in oltay� se� ve")
                        say("onu bana ver.")
                        say("")
                end

                when 9009.take with item.vnum < 27400 or item.vnum > 27590 begin
                        say_title("Bal�k��:")
                        say("Bunu neden yapay�m ki? Ben yaln�zca bal�k�� ")
                        say("oltalar�n� geli�tirebilirim!")
						say("")
                end

                when 9009.take with item.vnum == 27590 begin
                        say_title("Bal�k��:")
                        say("")
                        say("Oltan zaten maksimum seviyeye ula�m��.")
                        say("")
                end

                when 9009.take with item.vnum >= 27400 and item.vnum < 27590 and item.get_socket(0)!= item.get_value(2) begin
                        say_title("Bal�k��:")
                        say("")
                        say("Hen�z oltada yeterince puan toplanmam��. Bunu")
                        say("geli�tiremem. Oltanda maksimum puan topland���nda")
                        say("geri gel.")
						say("")
                end

                when 9009.take with item.vnum >= 27400 and item.vnum < 27590 and item.get_socket(0) == item.get_value(2) begin
                        say_title("Bal�k��:")
                        say("")
                        say("Bu Oltay� daha iyi yapmak istiyor musun?")
                        say("Onu bana g�ster ...")
                        say(string.format("Bal�k�� oltan�n leveli  %d.", item.get_value(0) / 10))
                        say("Mmmhhh, benim bilgim bunu daha iyi yapmak i�in, ")
                        say("yeterli de�il. Ama ")
                        say("deneyeyim mi?")
                        say(string.format("Bazen Bal�k�� oltalar� %d 100 de", 100 - item.get_value(3)))
                        say("d���yorlar.")
                        say("Yine de deneyeyim mi?")
                        say("")

                        local s = select("Evet", "Hay�r")

                        if s == 1 then
                                local f = __fish_real_refine_rod(item.get_cell())
                                if f == 2 then
                                        say_title("Bal�k��:")
                                        say("")
                                        ----"12345678901234567890123456789012345678901234567890"|
                                        say("Balik�� oltan� daha iyi yapamad�m")
                                        say("ama daha k�t� de ")
                                        say("olmad�.")
                                        say("Sana onu oldu�u gibi geri veriyorum. ")
                                        say("Belki daha sonra.")
                                        say("")
                                elseif f == 1 then
                                        say_title("Balik�i:")
                                        say("")
                                        say("Hey, harika olta daha iyi oldu!")
                                        say("Al sana daha iyi bir olta!")
                                        say("")
                                else
                                        say("Aman! �ff! Ne yaz�k ki olmad�!")
                                        say("Kusura bakma. �imdi bal�k�� oltan")
                                        say("bir derece d�st�, sana s�ylemi�tim...")
                                        say("")
                                end
                        else
                                say_title("Bal�k��:")
                                say("")
                                say("Sonra bir daha gel.")
                                say("")
                        end
                end
    end
end
