quest guild_building begin
        state start begin
                when guild_man1.chat."Loncadan ��k " or
                        guild_man2.chat."Loncadan ��k " or
                        guild_man3.chat."Loncadan ��k "
                        with pc.hasguild() and not pc.isguildmaster() and (pc.is_gm() or npc.empire == pc.empire) begin
                        -- ??
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Oldu�un loncadan ��kmak m� istiyorsun?")
                        say("Herhalde orada arkada� bulamad�n. ")
                        say("Nas�l istersen.")
                        say("Loncadan �ikmak istedi�ine emin misin?")
                        say("")
                        local s = select("Evet", "Hay�r")
                        if s==1 then
                                say_title("K�y Gardiyan�:")
                                say("")
                                say("Tamam.")
                                say("Art�k loncada de�ilsin. ")
                                say("")
                                say("")
                                pc.remove_from_guild()
                                pc.setqf("new_withdraw_time",get_global_time())
                        end
                end

                when guild_man1.chat."Loncay� kapat" or
                        guild_man2.chat."Loncay� kapat" or
                        guild_man3.chat."Loncay� kapat"
                        with pc.hasguild() and pc.isguildmaster() and (pc.is_gm() or npc.empire == pc.empire) begin
                        -- ??
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Ne?")
                        say("[DELAY value;150]        [/DELAY]")
                        say("O kadar zahmetle bu loncay� ")
                        say("kurdum ve sen onu �imdi kapatmak m� istiyorsun?")
                        say("B�t�n hat�ralar�n ve dostlar�n ")
                        say("sonsuza kadar kaybolacak!")
                        say("")
                        say("Loncay� kapatmak istedi�ine emin misin?")
                        say("")
                        local s = select("Evet", "Hay�r")
                        if s==1 then
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Tamam.")
                        say("Loncay� kapatt�m.")
                        say("")
                        say("")
                        pc.destroy_guild()
                        pc.setqf("new_disband_time", get_global_time())
                        pc.setqf("new_withdraw_time", get_global_time())
                        end
                end

                when guild_man1.chat."Yeni Lonca kur" or
                        guild_man2.chat."Yeni Lonca kur" or
                        guild_man3.chat."Yeni Lonca kur" with not pc.hasguild() or not pc.isguildmaster() begin
                        ----with (pc.is_gm() or npc.empire == pc.empire)
                        --------------------------------------------------------------
                        local level_limit;
                        local guild_create_item

                        level_limit = 40
                        guild_create_item = false
                        -----------------------------------------------------------------------

                        if pc.hasguild() then
							 say_title("K�y Gardiyan�: ")
                        say("Lonca kurman i�in ilk �nce oldu�un loncadan ")
						say("��kman gereklidir. ")
                                return
                        end
                        -- if game.get_event_flag("guild_withdraw_delay")*86400 >
                                -- get_global_time() - pc.getqf("new_withdraw_time") then
                        -- say_title("K�y Gardiyan�:")
                        -- say("")
                        -- say("Bir loncadan ayr�ld�ktan sonra, 1 g�n beklemelisin.")
                        -- return
                        -- end

                        if game.get_event_flag("guild_disband_delay")*86400 >
                                get_global_time() - pc.getqf("new_withdraw_time") then
                        say_title("K�y Gardiyan�: ")
                        say("")
                        say("Bir lonca kapatt�n! ")
                        say("Bu y�zden 1 g�n beklemelisin.")
                        say_reward("Loncay� kapatt���n tarih: ")
						say_reward(string.format("%s", time_to_str(pc.getqf("new_withdraw_time"))))
                        return
                        end
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Yeni lonca kurmak istiyor musun?")
                        say("")
                        say("Yeni lonca kurmak i�in ")
                        say("en az 40.seviyede olmal�s�n. Ayr�ca")
                        say(" 200.000 Yang gerekiyor.")
                        say("")
                        say("Lonca kurmak istiyor musun?")
                        say("")
                        local s = select("Evet", "Hay�r")
                        if s == 2 then
                                return
                        end

                        if pc.level >= 40 then
                        if pc.gold >= 200000 then

				if not guild_create_item or pc.countitem(guild_create_item)>0 then
                                        game.request_make_guild()
                                end

                                else
                                say_title("K�y Gardiyan�:")
                                say("")
                                say("Yeterli yang yok!")
                                say("")
                                return
                                end
                        else
                        say_title("K�y Gardiyan�:")
                        say("")
                        say("Seviyen lonca kurmak i�in ")
                        say("yeterli de�il. ")

                        end
                end
        end
end
