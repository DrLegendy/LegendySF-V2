quest alter_of_power begin
        state start begin
                when 20077.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
                        ---                                                   l
                        say_title("Yaholo:")
                        say("")
                        say("Benim ad�m  Yaholo, G�� Mimberi bek�isiyim.")
                        say("G�� Mimberi bir bina, loncalara")
                        say("�yeleri i�in yer sa�l�yor.")
                        say("Loncan b�y�d�k�e")
                        say("daha b�y�k g�� mimberi kurabilirsin.")
                        say("Ve daha �ok �ye bulabilirsin.")
                        say("")

                        if pc.getqf("build_level") == 0 then
                                pc.setqf("build_level", guild.level(pc.get_guild()))
                        end

                        wait()

                        if pc.getqf("build_level") < guild.level(pc.get_guild()) or guild.level(pc.get_guild()) >= 20 then
                                ---                                                   l
                                say_title("Yaholo:")
                                say("")
                                say("Loncan son zamanlarda �ok g��lendi.")
                                say("G�� Mimberi'ni b�y�tmek istiyor musun?")
                                say("")
                                say("Gerekli malzemeler:")
                                say("")
                                say_reward("25 milyon Yang")
                                say_reward("10 Temel Ta�� ")
                                say_reward("15 Kontrplak")
                                say_reward("10 Aga� K�k� ")
                                say("")

                                local s = select("G�� Mimberi'ni b�y�t.", "G�� Mimberi'ni b�y�tme.")

                                if s == 1 then
                                        if pc.count_item(90010) >= 10 and pc.count_item(90012) >= 15 and pc.count_item(90011) >= 10 and pc.get_gold() >= 25000000 then
                                                say_title("Yaholo:")
                                                say("")
                                                say("G�� Mimberin b�y�t�l�yor.")
                                                building.reconstruct(14062)
                                                pc.setqf("build_level", guild.level(pc.get_guild()))
                                                char_log(0, "GUILD_BUILDING", "alter_of_power 14062 constructed")

                                                pc.change_gold(-25000000)
                                                pc.remove_item("90010", 10)
                                                pc.remove_item("90011", 10)
                                                pc.remove_item("90012", 15)
                                        else
                                                say_title("Yaholo:")
                                                say("")
                                                say("Yeterli malzeme yok. �u an minberi")
                                                say("b�y�temem.")
                                                say("")
                                        end
                                elseif s == 2 then
                                say_title("Yaholo:")
                                say("")
                                say("Fikrin de�i�irse tekrar gel.")
                                say("")
                                end
                        else
                                say_title("Yaholo:")
                                say("")
                                say("Bence, loncan� g��lendir.")
                                say("")
                        end
                end

                when 20078.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
                        say_title("Yaholo:")
                        say("")
                        say("Lonca derecen ne kadar y�ksek olursa,")
                        say("o kadar b�y�k g�� mimberin olabilir.")
                        say("Derecen art�nca, loncan da")
                        say("g��leniyor.")
                        say("")

                        wait()
                        say_title("Yaholo:")
                        say("")

                        if pc.getqf("build_level") < guild.level(pc.get_guild()) or guild.level(pc.get_guild()) >= 20 then
                                say("Oh, loncan �imdi �ok daha g��l�! ")
                                say("Senin g�� mimberini b�y�tece�im.")
                                say("Gereken malzemeler:")
                                say("")
                                say_reward("30 milyon Yang")
                                say_reward("15 Temel Ta�� ")
                                say_reward("20 Kontrplak")
                                say_reward("20 Aga� K�k� ")
                                say("")

                                local s = select("G�� Mimberini b�y�t.", "G�� Mimberini b�y�tme.")

                                if s == 1 then
                                        if pc.count_item(90010) >= 15 and pc.count_item(90012) >= 20 and pc.count_item(90011) >= 15 and pc.get_gold() >= 30000000 then
                                                say_title("Yaholo:")
                                                say("")
                                                say("Bu Mimberi ")
                                                say("b�y�tece�im.")
                                                say("")
                                                building.reconstruct(14063)
                                                pc.setqf("build_level", guild.level(pc.get_guild()))
                                                char_log(0, "GUILD_BUILDING", "alter_of_power 14063 constructed")

                                                pc.change_gold(-30000000)
                                                pc.remove_item("90010", 15)
                                                pc.remove_item("90011", 20)
                                                pc.remove_item("90012", 20)
                                        else
                                                say_title("Yaholo:")
                                                say("")
                                                say("Yeterli malzeme yok. �u an minberi")
                                                say("b�y�temem.")
                                                say("")
                                        end
                                elseif s == 2 then
                                        say_title("Yaholo:")
                                        say("")
                                        say("Sonra bir daha gel.")
                                        say("")
                                end
                        end
                end

                when 20079.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
                        say_title("Yaholo:")
                        say("")
                        say("")
                        say("G�� Mimberi'ni hen�z b�y�temezsin.")
                        say("")
                        say("")
                end

                when 20077.click or 20078.click or 20079.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master()!= true begin
                        say_title("Yaholo:")
                        say("G�� suna�� loncana daha �ok �ye kabul edebilmeni")
                        say("sa�lar.")
                end
        end
end
