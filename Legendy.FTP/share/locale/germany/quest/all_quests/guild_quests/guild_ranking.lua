quest guild_ranking begin
        state start begin
                when
                        guild_man1.chat."Lonca s�ralamam� g�ster" or
                        guild_man2.chat."Lonca s�ralamam� g�ster" or
                        guild_man3.chat."Lonca s�ralamam� g�ster"
                        with pc.hasguild() begin
                        say_title("K�y Gardiyan�:")
						say("Burada loncan�, s�ralamada loncana yak�n olan")
                        say("di�er loncalar� g�rebilirsin: [DELAY value;0]")
                        ---                                                                l
                        say("|Lonca ad� |Puan� |Zaferleri |Beraberlikleri |Yenilgileri")
                        say(guild.around_ranking_string().."[/DELAY]")
                end
                when
                        guild_man1.chat."En iyi lonca s�ralamas�n� g�ster(1-8)" or
                        guild_man2.chat."En iyi lonca s�ralamas�n� g�ster(1-8)" or
                        guild_man3.chat."En iyi lonca s�ralamas�n� g�ster(1-8)"
                        with pc.hasguild() begin
                        say_title("K�y Gardiyan�:")
			say("")
                        say("Burada s�ralamas� en y�ksek sekiz loncay� ve")
                        say("istatistiklerini g�rebilirsin: [DELAY value;0]")
                        say("|Lonca ad� |Puan� |Zaferleri |Beraberlikleri |Yenilgileri")
                        say(guild.high_ranking_string().."[/DELAY]")
                        say("")
                end
                when
                        guild_man1.chat."Lonca puan�m� g�ster" or
                        guild_man2.chat."Lonca puan�m� g�ster" or
                        guild_man3.chat."Lonca puan�m� g�ster"
                        with pc.hasguild() begin
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Lonca s�ralaman "..guild.get_rank()..".")
                        say("Puan miktar� :"..guild.get_ladder_point()..".")
                        say("")
                end
        end
end
