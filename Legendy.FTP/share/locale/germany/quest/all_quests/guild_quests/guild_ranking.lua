quest guild_ranking begin
        state start begin
                when
                        guild_man1.chat."Lonca sýralamamý göster" or
                        guild_man2.chat."Lonca sýralamamý göster" or
                        guild_man3.chat."Lonca sýralamamý göster"
                        with pc.hasguild() begin
                        say_title("Köy Gardiyaný:")
						say("Burada loncaný, sýralamada loncana yakýn olan")
                        say("diðer loncalarý görebilirsin: [DELAY value;0]")
                        ---                                                                l
                        say("|Lonca adý |Puaný |Zaferleri |Beraberlikleri |Yenilgileri")
                        say(guild.around_ranking_string().."[/DELAY]")
                end
                when
                        guild_man1.chat."En iyi lonca sýralamasýný göster(1-8)" or
                        guild_man2.chat."En iyi lonca sýralamasýný göster(1-8)" or
                        guild_man3.chat."En iyi lonca sýralamasýný göster(1-8)"
                        with pc.hasguild() begin
                        say_title("Köy Gardiyaný:")
			say("")
                        say("Burada sýralamasý en yüksek sekiz loncayý ve")
                        say("istatistiklerini görebilirsin: [DELAY value;0]")
                        say("|Lonca adý |Puaný |Zaferleri |Beraberlikleri |Yenilgileri")
                        say(guild.high_ranking_string().."[/DELAY]")
                        say("")
                end
                when
                        guild_man1.chat."Lonca puanýmý göster" or
                        guild_man2.chat."Lonca puanýmý göster" or
                        guild_man3.chat."Lonca puanýmý göster"
                        with pc.hasguild() begin
                        say_title("Köy Gardiyaný:")
                        say("")
                        say("Lonca sýralaman "..guild.get_rank()..".")
                        say("Puan miktarý :"..guild.get_ladder_point()..".")
                        say("")
                end
        end
end
