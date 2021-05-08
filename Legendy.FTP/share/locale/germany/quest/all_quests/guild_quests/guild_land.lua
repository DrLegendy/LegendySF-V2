quest guild_building begin
    state start begin
        when 20040.click begin
            say_title("Emlak��:")
                say("")
                say("Ben bu arsan�n sat�� temsilcisiyim. �stilac� ")
                say("yarat�klar, orta k�tay� talan etmeden �nce arsa")
                say("parselleme yoktu, herkesin topra�� vard� ve")
                say("insanlar mutluydu... Her neyse, arsay� lonca")
                say("b�lgesi olarak kullanabilmeleri i�in sadece lonca")
                say("liderlerine sat�yorum. Arsa almak ister misin?")
                say("")

            local s = select(locale.yes, locale.no)

            if s == 1 then
                if not pc.is_guild_master() then
                    say_title("Emlak��:")
                        say("")
                        say("Sana zaten s�ylemi�tim; arsalar� herkese")
                        say("satm�yorum. Umar�m bu defa beni anlam��s�nd�r.")
						say("")
                elseif building.has_land(pc.get_guild()) then
                    say_title("Emlak��:")
                        say("")
                        say("Her Loncan�n en fazla bir arazisi olabilir.")
                        say("")
                else
                    local land_id = building.get_land_id(pc.get_map_index(), pc.get_x()*100, pc.get_y()*100)

                    if land_id == 0 then
                        say_title("Emlak��:")
                        say("")
                        say("Sipari� hatas� oldu.")
                    else
                        local price, owner, guild_level_limit = building.get_land_info(land_id)
                        say_title("Emlak��:")
                        say("")
                        say("Bu araziyi almak i�in ")
                        say("lonca derecesinin "..guild_level_limit.." olmas� ")
                        say("gerekiyor. Arazinin fiyat� "..price..locale.gold..".")

                        if guild.level(pc.get_guild()) < guild_level_limit then
                            say("")
                                say("Senin loncan daha bu dereceye gelmedi.")
                                say("�z�r dilerim.")
                        else
                            say("")
                                say("Arazi bedelini Yang olarak m� �demek istiyorsun?")

                            s = select(locale.yes, locale.no)

                            if s == 1 then
                                local price, owner, guild_level_limit = building.get_land_info(land_id)

                                if owner!= 0 then
                                    say_title("Emlak��:")
                                say("")
                                        say("Bu arazi ba�ka loncaya sat�ld�. ")
                                        say("�z�r dilerim.")
                                elseif pc.gold < price then
                                    say_title("Emlak��:")
                                say("")
                                        say("Ben Emlak��y�m, fiyat� ben belirlemiyorum.")
                                        say("Bana daha �ok Yang getir.")
                                else
                                    pc.changegold(-price)
                                    building.set_land_owner(land_id, pc.get_guild())
                                    notice(guild.name(pc.get_guild()).." Loncas� araziyi ald�!")
                                end
                            else
                                say_title("Emlak��:")
                            say("")
                                say("Ne yapaca��na karar verdi�inde tekrar gel. �nce")
                    say("sen gel, �nce sen al, ka��rma.")
                            end
                        end
                    end
                end
            else
            say_title("Emlak��:")
                    say("")
                    say("Ne yapaca��na karar verdi�inde tekrar gel �nce")
                    say("sen gel, �nce sen al, ka��rma.")
            end
        end
    end
end
