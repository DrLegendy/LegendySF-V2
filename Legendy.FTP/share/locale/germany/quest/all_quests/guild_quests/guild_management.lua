quest guild_building begin
        state start begin
                when guild_man1.chat."Loncadan çık " or
                        guild_man2.chat."Loncadan çık " or
                        guild_man3.chat."Loncadan çık "
                        with pc.hasguild() and not pc.isguildmaster() and (pc.is_gm() or npc.empire == pc.empire) begin
                        -- ??
                        say_title("Köy Gardiyanı:")
                        say("")
                        say("Olduğun loncadan çıkmak mı istiyorsun?")
                        say("Herhalde orada arkadaş bulamadın. ")
                        say("Nasıl istersen.")
                        say("Loncadan çikmak istediğine emin misin?")
                        say("")
                        local s = select("Evet", "Hayır")
                        if s==1 then
                                say_title("Köy Gardiyanı:")
                                say("")
                                say("Tamam.")
                                say("Artık loncada değilsin. ")
                                say("")
                                say("")
                                pc.remove_from_guild()
                                pc.setqf("new_withdraw_time",get_global_time())
                        end
                end

                when guild_man1.chat."Loncayı kapat" or
                        guild_man2.chat."Loncayı kapat" or
                        guild_man3.chat."Loncayı kapat"
                        with pc.hasguild() and pc.isguildmaster() and (pc.is_gm() or npc.empire == pc.empire) begin
                        -- ??
                        say_title("Köy Gardiyanı:")
                        say("")
                        say("Ne?")
                        say("[DELAY value;150]        [/DELAY]")
                        say("O kadar zahmetle bu loncayı ")
                        say("kurdum ve sen onu şimdi kapatmak mı istiyorsun?")
                        say("Bütün hatıraların ve dostların ")
                        say("sonsuza kadar kaybolacak!")
                        say("")
                        say("Loncayı kapatmak istediğine emin misin?")
                        say("")
                        local s = select("Evet", "Hayır")
                        if s==1 then
                        say_title("Köy Gardiyanı:")
                        say("")
                        say("Tamam.")
                        say("Loncayı kapattım.")
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
							 say_title("Köy Gardiyanı: ")
                        say("Lonca kurman için ilk önce olduğun loncadan ")
						say("çıkman gereklidir. ")
                                return
                        end
                        -- if game.get_event_flag("guild_withdraw_delay")*86400 >
                                -- get_global_time() - pc.getqf("new_withdraw_time") then
                        -- say_title("Köy Gardiyanı:")
                        -- say("")
                        -- say("Bir loncadan ayrıldıktan sonra, 1 gün beklemelisin.")
                        -- return
                        -- end

                        if game.get_event_flag("guild_disband_delay")*86400 >
                                get_global_time() - pc.getqf("new_withdraw_time") then
                        say_title("Köy Gardiyanı: ")
                        say("")
                        say("Bir lonca kapattın! ")
                        say("Bu yüzden 1 gün beklemelisin.")
                        say_reward("Loncayı kapattığın tarih: ")
						say_reward(string.format("%s", time_to_str(pc.getqf("new_withdraw_time"))))
                        return
                        end
                        say_title("Köy Gardiyanı:")
                        say("")
                        say("Yeni lonca kurmak istiyor musun?")
                        say("")
                        say("Yeni lonca kurmak için ")
                        say("en az 40.seviyede olmalısın. Ayrıca")
                        say(" 200.000 Yang gerekiyor.")
                        say("")
                        say("Lonca kurmak istiyor musun?")
                        say("")
                        local s = select("Evet", "Hayır")
                        if s == 2 then
                                return
                        end

                        if pc.level >= 40 then
                        if pc.gold >= 200000 then

				if not guild_create_item or pc.countitem(guild_create_item)>0 then
                                        game.request_make_guild()
                                end

                                else
                                say_title("Köy Gardiyanı:")
                                say("")
                                say("Yeterli yang yok!")
                                say("")
                                return
                                end
                        else
                        say_title("Köy Gardiyanı:")
                        say("")
                        say("Seviyen lonca kurmak için ")
                        say("yeterli değil. ")

                        end
                end
        end
end
