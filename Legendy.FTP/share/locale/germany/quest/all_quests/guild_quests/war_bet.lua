quest guild_war_bet begin
        state start begin
                when
                        guild_war_observer1.chat."Lonca sava�� bahsi " or
                        guild_war_observer2.chat."Lonca sava�� bahsi " or
                        guild_war_observer3.chat."Lonca sava�� bahsi " begin

                        local info_counter = pc.getqf("Info")

                        if info_counter < 3 then
                                say_title("Lonca sava�� bahsi")
                                say("")
                                say("Kendi devletine piyango bileti al.")
                                say("1.Her Lonca Sava��nda, Loncalar�n kazanmas� ")
                                say("halindeki kar miktarlar� �nceden ilan edilir.")
                                say("2. Bir piyango bileti al�p, tahmin sonu�lar�n� ")
                                say("ve oyun farklar�n� s�yleyerek, istedi�in loncaya")
                                say("oynayabilirsin.")
                                say("3. Se�im i�lemi piyango stand�nda yap�l�r.")
                                say("Kazan�p kaybetti�in konusundaki haberi, lonca")
                                say("sava��ndan sonra alacaks�n.")
                                say("* Kazanc�n %10'u devletine gidecek.")
				say("")
                                wait()
                        end

                        local g = guild.get_reserve_war_table()
                        local gname_table = {}

                        table.foreachi(g,
                        function(n, p)
                                gname_table[n] = guild.get_name(p[2]).." vs "..guild.get_name(p[3])
                        end)

                        if table.getn(g) == 0 then
                                -- no currently war
                                say_title("Sava� Sorumlusu:")
                                say("�u an bahis yapabilece�in bir lonca sava�� yok.")
                        else
                                gname_table[table.getn(g)+1] = "Bitir "
                                say_title("Bahis Kurulu:")
                                say("")
                                say("Hangi lonca i�in bilet almak istiyorsun?")

                                local s = select_table(gname_table)

                                if s != table.getn(gname_table) then
                                        if guild.is_bet(g[s][1]) then
                                                say_title("Bahis Kurulu:")
                                                say("")
                                                say("Listeye g�re piyango bileti ald�n bile.")
                                                say("Her lonca i�in yaln�z bir bilet ")
                                                say("alabilirsin.")
                                        else
                                                local name1 = guild.get_name(g[s][2])
                                                local name2 = guild.get_name(g[s][3])

                                                say_title("Bahis Kurulu:")
                                                say("")
                                                say("G�r�n��e g�re ")
                                                say(name1.." ile"..name2.." ,"..g[s][4].."puanla kaybediyor.")
                                                say("Hangi loncaya bahis oyanayacaks�n?")
                                                local guild_s = select(name1, name2, "Bitir ")

                                                if guild_s != 3 then
                                                        local bet_guild = g[s][guild_s+1]

                                                        say_title("Bahis Kurulu:")
                                                        say("")
                                                        say("Hmm ... �yi karar! Cevab�n ne?")

                                                        local price_button_table = {}

							table.foreachi(guild_war_bet_price_table,
							function(n, p) 
								price_button_table[n] = p.."Yang"
							end)

                                                        price_button_table[table.getn(price_button_table)+1] =  "Bitir"

                                                        local price_idx = select_table(price_button_table)

                                                        if price_idx != table.getn(price_button_table) then -- ? ??? ?? ??? ???
                                                                if pc.gold < guild_war_bet_price_table[price_idx] then
                                                                        say_title("Bahis Kurulu:")
                                                                        say("")
                                                                        say("Yeterli Yang yok!")
                                                                        say("")
                                                                else
                                                                        say_title("Bahis Kurulu:")
                                                                        say("")
                                                                        pc.changegold(-guild_war_bet_price_table[price_idx])
                                                                        guild.war_bet(g[s][1], bet_guild, guild_war_bet_price_table[price_idx])
                                                                        say("Her �ey haz�r. Kazanan loncay� bildiysen,")
                                                                        say("kazand���n yanglar� deponda bulacaks�n.")
                                                                        say("Bol �anslar!")
                                                                end
                                                        end
                                                end -- if guild_s != 3
                                        end -- if guild.is_bet(g[s][1])
                                end -- if s != table.getn(gname_table)
                        end
                end
        end
end
