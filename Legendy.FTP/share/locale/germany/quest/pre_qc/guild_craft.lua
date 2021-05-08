quest guild_building_melt begin
    state start begin
        function GetOreRefineCost(cost)
            if pc.empire != npc.empire then
                return 3 * cost
            end
            if pc.get_guild() == npc.get_guild() then
                return cost * 0.9
            end
            return cost
        end

        function GetOreRefineGoodPct()
            return 60
        end

        function GetOreRefineBadPct()
            return 30
        end

        function GetMyRefineNum(race)
            return race - 20060 + 50601
        end

        function IsRefinableRawOre(vnum)
            return vnum >= 50601 and vnum <= 50613
        end

        function DoRefineDiamond(pct)
            local from_postfix
            local from_name = item_name(item.vnum)
            local to_vnum = item.vnum + 20
            local to_name = item_name(to_vnum)
            local to_postfix

            if under_han(from_name) then
                from_postfix = ""
            else
                from_postfix = ""
            end

            if under_han(to_name) then
                to_postfix = ""
            else
                to_postfix = ""
            end

            say("100 " .. from_name .. from_postfix .. " toplaman laz�m ki ")
            say(to_name .. to_postfix .. "�retimi yapabilesin.")
            if item.count >= 100 then
                say("Ba�ar� ihtimalin "..pct.."%.")
				say(""..guild_building_melt.GetOreRefineCost(10000).." Yang gerekli.")
                say("Denemek istiyormusun?")
                local s = select("Evet", "Hay�r")
                if s == 1 then
                    if pc.get_gold() < guild_building_melt.GetOreRefineCost(10000) then
                        say("Yeterli yang yok.")
                        return
                    end

                    if pc.diamond_refine(10000, pct) then
                        say("Tebrikler! Cevherler ba�ar�yla i�lendi. �imdi senin:")
                        say_item(to_name, to_vnum, "")
                    else
                        say("Cevher i�leme ba�ar�s�z oldu.")
                    end
                end
            else
                say("100 tane topla...")
            end
        end
        function DoRefine(pct)
            local from_postfix
            local from_name = item_name(item.vnum)
            local to_vnum = item.vnum + 20
            local to_name = item_name(to_vnum)
            local to_postfix

            if under_han(from_name) then
                from_postfix = ""
            else
                from_postfix = ""
            end

            if under_han(to_name) then
                to_postfix = ""
            else
                to_postfix = ""
            end

            say("�nce 100 " .. from_name .. from_postfix .. "toplaman laz�m ki")
            say("Ruh Ta�� +0, Ruh Ta�� +1 veya Ruh Ta�� +2")
            say(to_name .. to_postfix .. "�retebilesin.")
            if item.count >= 100 then
                say("Ba�ar� ihtimalin"..pct.."%."..guild_building_melt.GetOreRefineCost(3000).." Yang �demen gerekiyor.")
                say("Denemek istiyor musun?")
                local s = select("Evet", "Hay�r")
                if s == 1 then
                    if pc.get_gold() < guild_building_melt.GetOreRefineCost(3000) then
                        say("Yeterli Yang yok.")
                        return
                    end

                    local selected_item_cell = select_item()
                    if selected_item_cell == 0 then
                        say("Bana meteoridleri g�ster.")
                        return
                    end
                    local old_item = item.get_id()

                    if not item.select_cell(selected_item_cell) then
                        say("Bu istedi�imiz malzeme de�il.")
                        return
                    end

                    -- checken, ob der meteorit ist
                    if item.vnum < 28000 or item.vnum >= 28300 then
                        say("Bu do�ru madde de�il.")
                        return
                    end

                    item.select(old_item)

                    if pc.ore_refine(3000, pct, selected_item_cell) then
                        say("Tebrik ederim, islem tamamlandi.Sonu�:")
                        say_item(to_name, to_vnum, "")
                    else
                        say("��lem ba�ar�l� olmad�.")
                    end
                end
            else
                say("100 tane topla.")
            end
        end

        when
            20060.take or
            20061.take or
            20062.take or
            20063.take or
            20064.take or
            20065.take or
            20066.take or
            20067.take or
            20068.take or
            20069.take or
            20070.take or
            20071.take or
            20072.take
            with guild_building_melt.GetMyRefineNum(npc.race) == item.vnum
        begin
            if item.vnum == 50601 then
                guild_building_melt.DoRefineDiamond(guild_building_melt.GetOreRefineGoodPct())
            else
                guild_building_melt.DoRefine(guild_building_melt.GetOreRefineGoodPct())
            end
        end

        when
            20060.take or
            20061.take or
            20062.take or
            20063.take or
            20064.take or
            20065.take or
            20066.take or
            20067.take or
            20068.take or
            20069.take or
            20070.take or
            20071.take or
            20072.take
            with guild_building_melt.IsRefinableRawOre(item.vnum) and
guild_building_melt.GetMyRefineNum(npc.race) != item.vnum
        begin
            if item.vnum == 50601 then
                guild_building_melt.DoRefineDiamond(guild_building_melt.GetOreRefineBadPct())
            else
                guild_building_melt.DoRefine(guild_building_melt.GetOreRefineBadPct())
            end
        end

        when
            20060.click or
            20061.click or
            20062.click or
            20063.click or
            20064.click or
            20065.click or
            20066.click or
            20067.click or
            20068.click or
            20069.click or
            20070.click or
            20071.click or
            20072.click
            with npc.get_guild() == pc.get_guild() and pc.isguildmaster()
        begin
            say(" 3.000.000 Yang kar��l���nda iyi bir kimyager")
			say("kullanabilirsin.")
            if pc.get_gold() < 3000000 then
                say("3.000.000 Yang getir.")
            else
                say("Hangi t�r �zerinde �al��an kimyager istiyorsun?")

                local sel = 0
                local timetable1 = {"Elmas", "Fosiller", "Bak�r", "G�m��", "Alt�n", "Ye�im", "Devam", "Kapat"}
                local valuetable1 = {14043, 14045, 14046, 14047, 14048, 14049, 0, -1}
                local timetable2 = {"Abanoz", "�nci", "Beyaz Alt�n", "Kristal", "Ametist", "Elmas", "Devam", "Kapat"}
                local valuetable2 = {14050, 10451, 14052, 14053, 14054, 14055, 0, -1}
                repeat
                        local s = select_table(timetable1)
                        sel = valuetable1[s]
                        if sel == 0 then
                                local s = select_table(timetable2)
                                sel = valuetable2[s]
                        end
                until sel != 0
                if sel != -1 then
                    npc_num = sel + 20060 - 14043
                    if npc_num == npc.get_race() then
                        say("Bu malzeme ile �al�smas� m�mk�n de�il.")
                    else
                        pc.changegold(-3000000)
                        building.reconstruct(sel)
                    end
                else
                    say("Kapat")
                end
            end
        end
    end
end
