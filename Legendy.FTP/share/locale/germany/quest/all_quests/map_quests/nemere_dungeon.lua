quest snow_dungeon begin
state start begin
    when 9010.chat."Tasi indir" with snow_dungeon.is_nemeres_dungeon() == true begin
        d.purge()
        d.spawn_mob_dir(20397, 173,262,1)
        setskin(NOWINDOW)
    end
    when 9010.chat."TESTSERVER: SnowDungeon 9.seviye'ye git" with snow_dungeon.is_nemeres_dungeon() == true  begin
        local set = snow_dungeon.get_settings()
  ---      notice_in_map("Der Richtige Schlussel wurde gefunden, in wenigen Sekunden geht es in den nächsten Stock.")
        server_timer("Jp_9",6,d.get_map_index())
        d.clear_regen()
        d.kill_all()
        d.regen_file("data/dungeon/ice_dungeon/zone_9.txt")
        setskin(NOWINDOW)
    end
    when 9010.chat."TESTSERVER: SnowDungeon 10.seviye'ye git" with snow_dungeon.is_nemeres_dungeon() == true  begin
        local set = snow_dungeon.get_settings()
        server_timer("Jp_Boss",3,d.get_map_index())
        d.clear_regen()
        d.kill_all()
        d.regen_file("data/dungeon/ice_dungeon/zone_boss.txt")
        local v = set.BossVnumGroup
        d.spawn_group(v, 928, 335, 5 ,1, 1) --    (Input from SRC: argument: vnum,x,y,radius,aggressive,count)
        setskin(NOWINDOW)
    end
    when 9010.chat."TESTSERVER: SnowDungeon boss at" with snow_dungeon.is_nemeres_dungeon() == true  begin
        local set = snow_dungeon.get_settings()
        local v = set.BossVnumGroup
        d.spawn_group(v, 928, 335, 5 ,1, 1) --    (INFO from SRC: argument: vnum,x,y,radius,aggressive,count)
    end
    when 9010.chat."TESTSERVER: SnowDungeon'u bitir" with snow_dungeon.is_nemeres_dungeon() == true  begin
        server_timer("Jp_OutAll",5,d.get_map_index())
        say("done")
    end
    -- when 30331.use begin --key_level_2
        -- LIB_writelog("{"..pc.get_local_x()..","..pc.get_local_y().."}",3,"snowcordis.txt")
        -- d.spawn_mob(20399, pc.get_local_x(), pc.get_local_y())
        -- chat("write Nordstern Kordinaten")
    -- end
    when 9010.chat."TESTSERVER: SnowDungeon test 5.kat" with snow_dungeon.is_nemeres_dungeon() == true  begin
        snow_dungeon._Create_Stones_level5()
        setskin(NOWINDOW)
    end
    when 9010.chat."TESTSERVER: SnowDungeon 5.kat" with snow_dungeon.is_nemeres_dungeon() == true  begin
        snow_dungeon._DropKeyOnLevel5()
        setskin(NOWINDOW)
    end
    when 9010.chat."TESTSERVER: SnowDungeon pozisyonlarým" with snow_dungeon.is_nemeres_dungeon() == true begin
        local set = snow_dungeon.get_settings()
        local warp_to_level = set.Position_level_1
        local level = 2
        say("Eski: x: "..warp_to_level[1].." y:"..warp_to_level[2].."")
        local warp_to_level = set. _G[ "Position_level_"..level ]
        say("Yeni: x: "..warp_to_level[1].." y:"..warp_to_level[2].."")
        --DONT WORKS!
    end
    function get_settings()
        local snow_dungeon_settings = {}
        snow_dungeon_settings.map_index = 352                        --Mapindex
        snow_dungeon_settings.base_cord = {5120, 1536 }             --Base Kordinaten 
        snow_dungeon_settings.outside_entry_pos = {61,4321,1667}     --Mapindex, Exit Position (Eisland)
        snow_dungeon_settings.need_level = 90                        --Ab wann ist der Dungeon betretbar.
        snow_dungeon_settings.need_level_group = 90                 --Benotigte Level fur Gruppenmitglieder
        snow_dungeon_settings.WaitBeforOutAllOnExit = 60            --Wartezeit bevor alle alle herausteleportiert werden bei einem erfolgreichen Run. (Empfohlen 60)
        snow_dungeon_settings.NextJumpTime = 5                        --Wann man zur nächsten ebene Gejumpt wird (timer) (Empfohlen 5)
        snow_dungeon_settings.DurationLoopTimer = 45                --Welchen intervall die Level und Missionen gepruft werden sollen. (Empfohlen 45)
        snow_dungeon_settings.wait_duration = 60*60*4                --Ab wann der Dungeon wieder betretbar ist (PartyLeader)
        snow_dungeon_settings.maxlife_time_on_dungeon = 60*60*1    --Maximale Zeit fur den Dungeon.
        snow_dungeon_settings.DurationMaxOnReJoinGroup = 60*5        --Maximale Zeit innerhalb wann man wieder in die Gruppe joinen kann.
        snow_dungeon_settings.key_level_2 = 30331                    --KeyVnum fur die 2.Ebene    --Frostschlussel
        snow_dungeon_settings.NpcVnum_level_5 = 20398                --MobVnum von 5.Ebene    --Wurfel des Arktos
        snow_dungeon_settings.StoneCount_level_5 = 6                --Wie viele Wurfel des Arktos sollen erscheinen? 
        snow_dungeon_settings.Key_on_level_5 = 30332                --KeyVnum von 5.Ebene    --Nordstern
        snow_dungeon_settings.StoneCords_level_5 = {
        {432,508},{437,493},{448,492},{448,476},{467,475},{466,464},
        {462,450},{458,428},{446,439},{431,431},{415,416},{402,427},
        {397,438},{375,434},{374,456},{390,468},{385,492},{402,505},
        {404,489},{386,482}
        }    --Positionen von Wurfel des Arktos
        snow_dungeon_settings.MobVnum_level_6 = 8058                --MobVnum von 6.Ebene    --Metin der Kälte
        snow_dungeon_settings.MobVnum_level_7 = 6151                --MobVnum von 7.Ebene    --Szel
        snow_dungeon_settings.SzelCords_level_7 = {
        {752,499},{758,479},{772,452},{763,444},{750,451},{728,441},
        {726,455},{718,482},{715,491},{731,473},{748,429}
        } --Positionen von Szel
        snow_dungeon_settings.Key_on_level_8 = 30333                --KeyVnum von 8.Ebene    --Eisblumenschlussel
        snow_dungeon_settings.NpcVnum_level_9 = 20399                --MobVnum von 9.Ebene    --Säule des Norddrachen
        snow_dungeon_settings.BossVnumGroup = 6062                    --GroupMobVnum vom Boss --(Group.txt)
        snow_dungeon_settings.BossVnum = 6191                        --MobVnum von 10.Ebene    --Nemere(6191)
        
        snow_dungeon_settings.Position_level_1 = { 171,271 }         --Position ebene 1    --Startposition        --Tote alle Monster auf dieser Ebene.
        snow_dungeon_settings.Position_level_2 = { 761,270 }         --Position ebene 2                        --Finde den richtigen Frostschlussel, nur ein Schamane kann ihn benutzen.
        snow_dungeon_settings.Position_level_3 = { 187,491 }         --Position ebene 3                        --Tote alle Monster auf dieser Ebene.
        snow_dungeon_settings.Position_level_4 = { 421,259 }         --Position ebene 4                        --Tote alle Monster auf dieser Ebene.
        snow_dungeon_settings.Position_level_5 = { 419,530 }         --Position ebene 5                        --offnet die Siegel an den Wurfel des Arktos in der richtigen Reihenfolge. (Zieht Nordstern auf die Wurfel)
        snow_dungeon_settings.Position_level_6 = { 571,706 }         --Position ebene 6                        --Tote alle Monster auf dieser Ebene. Danach Zersore den Metin der Kälte (Nur ein Schamane kann ihn Schaden)
        snow_dungeon_settings.Position_level_7 = { 746,534 }         --Position ebene 7                        --Tote alle Monster auf dieser Ebene und Szel
        snow_dungeon_settings.Position_level_8 = { 303,710 }         --Position ebene 8                        --Der Eisblumenschlussel muss gedroppt werden, jedoch kann dieser nur von Schamanen und Ninja benutzt werden.
        snow_dungeon_settings.Position_level_9 = { 848,693  }         --Position ebene 9                        --Zerstort die Säule des Norddrachen. Nur Ninjas und Schamanen konnen ihm Schaden zufugen.
        snow_dungeon_settings.Position_level_10 = { 927,391 }         --Position ebene 10 (BossZone)            --Besiege Nemere, den Konig uber Frost und Eis.    
        snow_dungeon_settings.Enable_TestServerMode = false            --Ob TestServer mode aktiviert ist. Wenn ja werden die Aufgaben schneller beendet.
        snow_dungeon_settings.IsNewga_me_re_vi_sion = true                --Need ga_me_re_vi_sion 40301
        return snow_dungeon_settings
    end
    function is_TestServerMode()
        local set = snow_dungeon.get_settings()
        return set.Enable_TestServerMode
    end
    function is_nemeres_dungeon()
        local set = snow_dungeon.get_settings()
        local map = pc.get_map_index()
        if map >= (set.map_index * 10000) and map < (set.map_index * 10000 + 9000) then
            return true
        else
            return false
        end
    end
    when 20395.chat."Gruba tekrar katýl" with (party.is_party() and d.find(party.getf("ice_dungeon_map_index"))) begin
        local set = snow_dungeon.get_settings()
        local n = party.getf("ice_dungeon_map_index")
        local cord = set.base_cord
        local level = d.getf_from_map_index("level", n)
        --say("Aktuelles Dungeon Level deiner Gruppe: "..level.."")
        if level == 0 then
            say_npc_name()
            say("Grubunuz zaten Buzdaði'ni fethetti.")
            return
        end
        if pc.getqf("out_party_time") < get_global_time() then
            say_npc()
            say("")
            say("Du hast länger als  "..math.ceil(set.DurationMaxOnReJoinGroup  /60) .." Minute(n) vor dem")
            say("Eisberg verweilt und kannst jetzt nicht")
            say("mehr eintreten.")
            return
        end
        if n == 0 then
            setskin(NOWINDOW)
            return
        else
            say_npc()
            say("")
            say("Tekrar grubuna katýlmak istiyor musun?")
            if select("Evet","Hayýr") == 1 then
                local warp_to_level = set.Position_level_1
                local level = d.getf_from_map_index("level", n)
                if level >= 1 and level <= 10 then
                    if level == 1 then         warp_to_level = set.Position_level_1
                    elseif level == 2 then    warp_to_level = set.Position_level_2
                    elseif level == 3 then    warp_to_level = set.Position_level_3
                    elseif level == 4 then    warp_to_level = set.Position_level_4
                    elseif level == 5 then    warp_to_level = set.Position_level_5
                    elseif level == 6 then    warp_to_level = set.Position_level_6
                    elseif level == 7 then    warp_to_level = set.Position_level_7
                    elseif level == 8 then    warp_to_level = set.Position_level_8
                    elseif level == 9 then    warp_to_level = set.Position_level_9
                    elseif level == 10 then    warp_to_level = set.Position_level_10
                    end
                    pc.warp((cord[1] + warp_to_level[1])*100,(cord[2] + warp_to_level[2])*100,n)
                else
                    return
                end
            end
        end
    end
    
    when 20395.chat."Nemere'nin Gözetleme Kulesi" begin
        local set = snow_dungeon.get_settings()
        local need_level = 35
        say_npc()
        say("")
        say("Grubunuz ile gerçekten Nemere'nin")
        say("Gözetleme Kulesi'ne girmek istiyor musunuz?")
        if select("Evet, girmek istiyoruz.","Hayýr, orasý çok soðuk.") == 2 then
            return
        end
        if (pc.is_gm() and pc.getf("snow_dungeon","duration") >= get_global_time()) then
            say("Game Master; süreyi sýfýrlamak mý istiyorsun?")
            if select("Evet","Hayýr") == 1 then
                pc.setf("snow_dungeon","duration",0)
                return
            end
        end
        if (is_test_server() and snow_dungeon.is_TestServerMode() == true ) then
            say("Test server modu etkinleþtirildi.")
            say(" Þimdi ýþýnlanacksýnýz.")
            timer("make_dungeon",3)
            return
        end
        if not party.is_leader() then
            say_npc()
            say("Cesaretini takdir ediyorum ama")
            say("yalnýzca grup lideri giriþ talebi yapabilir.")
            return
        end
        if pc.get_level() < need_level then
            say("Zindan'a girmek için en az "..need_level..".")
            say("seviyede olmalisin.")
            return
        end
        if pc.getf("snow_dungeon","duration") >= get_global_time() then
            say_npc()
            say("Nemeres Gözetleme Kulesi'ne yeniden giriþ ")
            say("için bekleme süresi henüz dolmamýþ.")
            say("Kalan süre: "..LIB_duration(pc.getf("snow_dungeon","duration") - get_global_time()).."")
            return
        end
        if snow_dungeon._CheckMembersLevel() == false then    
            return
        else
            timer("make_dungeon",2)
        end
    end
    when 20397.chat."Savaþý baþlat" begin --Eisiger Lowe
        say_npc()
        say("")
        say("Savaþ'ý baþlatmak istiyor musun?")
        if select("Evet","Hayýr, korkuyorum. ") == 1 then
            local set = snow_dungeon.get_settings()
            local loop_durr = set.DurationLoopTimer
            local wait_durations = set.wait_duration
            local t = get_global_time()
            d.setf("LastTimeGetOutPut",0)    
            server_loop_timer("CheckLevelAndCountKillOnMobs",loop_durr,d.get_map_index())
            d.regen_file("data/dungeon/ice_dungeon/zone_1.txt")
            d.setf("Start_Time",t + set.maxlife_time_on_dungeon)
            server_timer("Jp_OutAllFailNotice",(t + set.maxlife_time_on_dungeon) -  t,d.get_map_index())
            --pc.setqf("duration",t + wait_durations)
            d.setqf2("snow_dungeon","duration",t + wait_durations)
            d.setf("level",1)
            notice_in_map("Bir sonraki kata çýkmak için Tüm yaratýklarý öldürmelisiniz.") 
            npc.purge()
            snow_dungeon._GetLastTime()
        end
        setskin(NOWINDOW)
    end
    when make_dungeon.timer begin
        local set = snow_dungeon.get_settings()
        local cord = set.base_cord
        local start_pos = set.Position_level_1
        local t = get_global_time()
        d.new_jump_party(set.map_index,(cord[1] + start_pos[1]), (cord[2] + start_pos[2]))
        --d.new_jump_all(set.map_index,(cord[1] + start_pos[1]), (cord[2] + start_pos[2]))
        snow_dungeon._ClearAlls()
        d.setf("party_leader_pid",party.get_leader_pid())
        party.setf("ice_dungeon_map_index",d.get_map_index())
        d.spawn_mob_dir(20397, 173,262,1) --Eisiger Lowe
    end
    function _ClearAlls()
        local d_index = d.get_map_index()
        clear_server_timer("CheckLevelAndCountKillOnMobs",d_index)
        clear_server_timer("Jp_1",d_index)
        clear_server_timer("Jp_2",d_index)
        clear_server_timer("Jp_3",d_index)
        clear_server_timer("Jp_4",d_index)
        clear_server_timer("Jp_5",d_index)
        clear_server_timer("Jp_6",d_index)
        clear_server_timer("Jp_7",d_index)
        clear_server_timer("Jp_8",d_index)
        clear_server_timer("Jp_9",d_index)
        clear_server_timer("Jp_10",d_index)
        clear_server_timer("Jp_OutAll",d_index)
        clear_server_timer("Jp_OutAllFail",d_index)
        clear_server_timer("Jp_OutAllFailNotice",d_index)
        d.setf("level",0)    
        d.setf("party_leader_pid",0)
        d.setf("Start_Time",0)
        d.setf("LastTimeGetOutPut",0)
        d.setf("Stone_5_count",0)
        d.setf("Stone_5_item_fail",0)
        d.clear_regen()
        d.kill_all()
    end
    
    function _CheckMembersLevel()
        local set = snow_dungeon.get_settings()
        local user_fail_level = {}
        local pids = {party.get_member_pids()}
        local need_level = set.need_level_group
        local have_ninja = false
        local have_shaman = false
        for i = 1, table.getn(pids), 1 do
            q.begin_other_pc_block(pids[i])
            if pc.get_level() < need_level then
                table.insert(user_fail_level, table.getn(user_fail_level) +1, pc.get_name())
            end
            local job = pc.get_job()
            if job == 1 -- Ninja weiblich
            or job == 5 --Ninja männlich
            then
                have_ninja = true
            end
            if job == 3 -- Schamane weiblich
            or job == 7 --Schamane männlich
            then
                have_shaman = true
            end
            q.end_other_pc_block()
        end
        if (is_test_server() and snow_dungeon.is_TestServerMode() == true ) then
            --dchat("TEST modu aktif.")
            return true
        end
        if have_ninja == false then
            say("Grubunuzda Ninja olmadan yukarý çýkamazsýnýz.")
            return false
        end
        if have_shaman == false then
            say("Grubunuzda Þaman olmadan yukarý çýkamazsýnýz.")
            return false
        end
        if table.getn(user_fail_level) >= 1 then
            say_npc()
            say("")
            say("Grubun baðzý üyeleri")
            say("henüz "..need_level..". seviyeye ulaþmamýþ:")
            for x = 1, table.getn(user_fail_level), 1 do
                say(color(1,1,0), "    "..user_fail_level[x])
            end
            return false
        end
        if table.getn(user_fail_level) == 0 then
            return true
        end
    end
    when logout begin
        if snow_dungeon.is_nemeres_dungeon() == true then
        local set = snow_dungeon.get_settings()
        pc.setqf("out_party_time",get_global_time() + set.DurationMaxOnReJoinGroup)
        --snow_dungeon.unregister_name()
        end
    end
    
    when login begin
        if snow_dungeon.is_nemeres_dungeon() == true then
            local set = snow_dungeon.get_settings()
            local backk = set.outside_entry_pos
            pc.set_warp_location(backk[1], backk[2],backk[3])
            if d.getf("party_leader_pid") != party.get_leader_pid() then
                chat("nemeres_wait_dungeon #RAUS:# Sizin grubunuz içeride deðil.")
                chat("nemeres_wait_dungeon #RAUS:#debug -> "..d.getf("party_leader_pid").." != "..party.get_leader_pid().."")
                d.exit()
                return
            end
            if pc.get_level() < set.need_level_group then
                chat("nemeres_wait_dungeon #RAUS:# Benim seviyem düþük.")
                d.exit()
                return
            end
            --chat("Hos geldiniz. Burada "..math.ceil((d.getf("Start_Time")  - get_global_time()) /60) .." dakikalik sureniz var.")
            --notice("Sonraki kata cikmak icin Tum yaratiklari oldurun.")
            --snow_dungeon._GetLastTime()
        end
    end
    
    function _GetLastTime()
        local c = get_global_time()
        local t = d.getf("Start_Time") - c
        local o = d.getf("LastTimeGetOutPut")
        --notice_in_map("CurrentTime: "..c.." Last: "..o.."")
        if c >= o then
            if t >= 60 then
                notice_in_map("Yaklaþýk "..math.ceil(t / 60).." dakikanýz kaldý...")
            else
                notice_in_map("Yaklaþýk "..t .." saniyeniz kaldý...")
            end
            if t >= (60*10) then
                d.setf("LastTimeGetOutPut",c + 60*5)
            elseif t >= (60*5) then
                d.setf("LastTimeGetOutPut",c + 60*2)
            else
                d.setf("LastTimeGetOutPut",c + 10)
            end
            --d.setf("LastTimeGetOutPut",c + 60*number(3,5)) -- Random
        end
    end
    
    when Jp_OutAllFailNotice.server_timer begin
        if d.select(get_server_timer_arg()) then
            notice_in_map("Zaman doldu.")
            server_timer("Jp_OutAll",1,d.get_map_index())
        end
    end
    
    when CheckLevelAndCountKillOnMobs.server_timer begin
        if d.select(get_server_timer_arg()) then
            local set = snow_dungeon.get_settings()
            local level = d.getf("level")
            local mob_count = d.count_monster()
            local next_jump_time = set.NextJumpTime
            --notice_in_map("level: "..level.." mob_count: "..mob_count.."")
            if level == 1 and mob_count <= 0 then
                notice_in_map("Tüm yaratýklarý maðlup ettin. Bir kaç dakika içerisinde bir sonraki kata ýþýnlanacaksýn.")
                
                server_timer("Jp_2",next_jump_time,d.get_map_index())
                d.clear_regen()
                d.kill_all()
                d.set_regen_file("data/dungeon/ice_dungeon/zone_2.txt")
            elseif level == 3 and mob_count <= 0 then
                notice_in_map("Tüm yaratýklarý maðlup ettin. Bir kaç dakika içerisinde bir sonraki kata ýþýnlanacaksýn.")
                
                server_timer("Jp_4",next_jump_time,d.get_map_index())
                d.clear_regen()
                d.kill_all()
                d.regen_file("data/dungeon/ice_dungeon/zone_4.txt")
            elseif level == 4 and mob_count <= 0 then
                notice_in_map("Tüm yaratýklarý maðlup ettin. Bir kaç dakika içerisinde bir sonraki kata ýþýnlanacaksýn.")
                
                server_timer("Jp_5",next_jump_time,d.get_map_index())
                d.clear_regen()
                d.kill_all()
                d.set_regen_file("data/dungeon/ice_dungeon/zone_5.txt")
            elseif level == 6 and mob_count <= 0 then
                local MobStonelvl6 = set.MobVnum_level_6
                notice_in_map("Tüm canavarlarý yok ettiniz. "..mob_name(MobStonelvl6).."'i öldürün.")
                
                d.clear_regen()
                d.kill_all()
                d.regen_file("data/dungeon/ice_dungeon/zone_6.txt")
                d.spawn_mob(MobStonelvl6,570,649)
            elseif level == 7 and mob_count <= 0 then
                notice_in_map("Tüm yaratýklarý maðlup ettin. Bir kaç dakika içerisinde bir sonraki kata ýþýnlanacaksýn.")
                
                server_timer("Jp_8",next_jump_time,d.get_map_index())
                d.clear_regen()
                d.kill_all()
                d.set_regen_file("data/dungeon/ice_dungeon/zone_8.txt")                
            end
            snow_dungeon._GetLastTime()
        end
    end

    when Jp_2.server_timer begin --Jump Level 2
        if d.select(get_server_timer_arg()) then
            local set = snow_dungeon.get_settings()
            local v = set.key_level_2
            d.setf("level",2)
            local cord = set.base_cord
            local pos = set.Position_level_2
            d.jump_all((cord[1] + pos[1]), (cord[2] + pos[2]))
            notice_in_map("Yukarý çýkmak için "..item_name(v).."'i bulun.")
            
        end
    end
    when 30331.use with snow_dungeon.is_nemeres_dungeon() == true begin --key_level_2
        local set = snow_dungeon.get_settings()
        local next_jump_time = set.NextJumpTime
        local job = pc.get_job()
        local level = d.getf("level")
        if level == 2 then
            if (is_test_server() and snow_dungeon.is_TestServerMode() == true ) then
                --dchat("SET VARIABLE JOB 3")
                job = 3
            end
            if job == 3 -- Schamane weiblich
            or job == 7 --Schamane männlich
            then
                if number(1,3) == 1 then --or d.count_monster() < 10 then
                    notice_in_map("Doðru anahtarý buldunuz! Bir kaç saniye sonra ýþýnlanacaksýnýz.")
                    server_timer("Jp_3",next_jump_time,d.get_map_index())
                    d.clear_regen()
                    d.kill_all()
                    d.regen_file("data/dungeon/ice_dungeon/zone_3.txt")
                    item.remove()
                else
                    notice_in_map("Bu yanlýþ anahtar.")
                    item.remove()
                end
            else
                notice_in_map("Bunu sadece Þamanlar kullanabilir.")
                return
            end
        end
    end
    
    when Jp_3.server_timer begin --Jump Level 3
        if d.select(get_server_timer_arg()) then
            local set = snow_dungeon.get_settings()
            d.setf("level",3)
            local cord_MQ = set.base_cord
            local pos = set.Position_level_3
            d.jump_all((cord_MQ[1] + pos[1]), (cord_MQ[2] + pos[2]))
            notice_in_map("Sonraki seviyeye ulaþmak için bütün yaratýklarý öldürün!")
        end
    end
    
    when Jp_4.server_timer begin --Jump Level 4
        if d.select(get_server_timer_arg()) then
            local set = snow_dungeon.get_settings()
            d.setf("level",4)
            local cord = set.base_cord
            local pos = set.Position_level_4
            d.jump_all((cord[1] + pos[1]), (cord[2] + pos[2]))
            notice_in_map("Sonraki seviyeye ulaþmak için bütün yaratýklarý öldürün!")
        end
    end
    
    when Jp_5.server_timer begin --Jump Level 5
        if d.select(get_server_timer_arg()) then
            local set = snow_dungeon.get_settings()
            local v = set.NpcVnum_level_5
            d.setf("level",5)
            local cord = set.base_cord
            local pos = set.Position_level_5
            d.jump_all((cord[1] + pos[1]), (cord[2] + pos[2]))
            notice_in_map("Anahtar düþürerek "..mob_name(v).." isimli buz küpünden mühürü açýn. ")
            if set.IsNewga_me_re_vi_sion == true then
                notice_in_map("Anahtarý canavarlardan düþürebilirsiniz.")
            else
                notice_in_map("Anahtarlar otomatikman envanterinize gelecek.")
            end
            snow_dungeon._Create_Stones_level5()
        end
    end
    
    function _DropKeyOnLevel5()
        if number(1,1000) >= 666 then --Abbruch der weiteren funtion -> Damit es spannend bleibt bei den wurfeln... :P
            return
        end
        local set = snow_dungeon.get_settings()
        local count = set.StoneCount_level_5
        local vnum = set.Key_on_level_5
        local get_random_unique = d.get_unique_vid("stone5_"..number(1,count).."")
        local fail_count = d.getf("Stone_5_item_fail") +1
        local search = d.getf("Stone_5_count")
        local search2 = d.get_unique_vid("stone5_"..search.."")
        if search2 < 0 or search2 > 1999999999 then
			search2 = 1
		end
		if get_random_unique < 0 or get_random_unique > 1999999999 then
			get_random_unique = 1
		end
        --
        if set.IsNewga_me_re_vi_sion == true then
            --New function
            game.drop_item(vnum,1)
        else
            pc.give_item2_select(vnum,1)
        end
    end
    
    function _Create_Stones_level5()
        local set = snow_dungeon.get_settings()
        local stone_level5_count_MQ = set.StoneCount_level_5
        local c = set.StoneCords_level_5 --{ {432,508},{437,493},{448,492},{448,476},{467,475},{466,464}}
        local v = set.NpcVnum_level_5
        for i = 1, stone_level5_count_MQ, 1 do
            local n = number(1,table.getn(c))
            --d.spawn_mob(20398, c[n][1], c[n][2])
            d.set_unique("stone5_"..i.."", d.spawn_mob(v, c[n][1], c[n][2]))
            --d.set_unique("stone5_"..i.."", mob.spawn(20398, c[n][1], c[n][2],1,1,1)) --GEHT
            --d.set_unique("stone5_"..i.."", d.spawn_mob_ac_dir(20398, c[n][1], c[n][2],i)) --GEHT
            table.remove(c,n)
            if i == 1 then
                d.setf("Stone_5_count",1)
                d.setf("Stone_5_item_fail",0)
            end
        end
    end
    
    when 20398.take begin --NpcVnum_level_5
        if snow_dungeon.is_nemeres_dungeon() == true then
            local set = snow_dungeon.get_settings()
            local stone_level5_count = 6
            local next_jump_time = 5
            local vnum = item.get_vnum()
            local key_level_5 = 30332
            local search = d.getf("Stone_5_count")
            if vnum == key_level_5 then
                        local new = search +1 
                        if new > stone_level5_count then
                            notice_in_map("Son taþý açtýnýz, biraz sonra çýkacaksýnýz.")
                            npc.purge()
                            item.remove()
                            server_timer("Jp_6",next_jump_time,d.get_map_index())
                            d.clear_regen()
                            d.kill_all()
                            d.regen_file("data/dungeon/ice_dungeon/zone_6.txt")
                       else
                            notice_in_map(""..search..". Taþý açtýnýz, biraz daha ilerlemeniz gerekmekte. ".. stone_level5_count - search .." Adet taþýnýz kaldý.")
                            npc.purge()
                            item.remove()
                        end
                        d.setf("Stone_5_count",new)
        end    --if is dungeon end
    end    --when end
	end
	end
    
	state start begin
    when Jp_6.server_timer begin --Jump Level 6
        if d.select(get_server_timer_arg()) then
            local set = snow_dungeon.get_settings()
            local v = set.MobVnum_level_6
            d.setf("level",6)
            local cord = set.base_cord
            local pos = set.Position_level_6
            d.jump_all((cord[1] + pos[1]), (cord[2] + pos[2]))
            
            notice_in_map("Tüm canavarlarý öldürdünüz. Þimdi bütün canavarlarý yok edin ve "..mob_name(v).."'i maðlup edin.")
         ---   notice_in_map("Nur Schamanen konnen ihm Schaden hinzufugen.")
            --d.spawn_mob(v,570,649)
            
        end
    end
    
    when Jp_7.server_timer begin --Jump Level 7
        if d.select(get_server_timer_arg()) then
            local set = snow_dungeon.get_settings()
            local v = set.MobVnum_level_7
            d.setf("level",7)
            local cord = set.base_cord
            local pos = set.Position_level_7
            d.jump_all((cord[1] + pos[1]), (cord[2] + pos[2]))
            notice_in_map("Metin taþarýný baþarýyla yok ettiniz. Þimdi "..mob_name(v).."'i maðlup edin!")
        end
    end
    
    when Jp_8.server_timer begin --Jump Level 8
        if d.select(get_server_timer_arg()) then
            local set = snow_dungeon.get_settings()
            local v = set.Key_on_level_8
            d.setf("level",8)
            local cord = set.base_cord
            local pos = set.Position_level_8
            d.jump_all((cord[1] + pos[1]), (cord[2] + pos[2]))
            notice_in_map("Yaratýklarý keserek "..item_name(v).." düþürün.")
            notice_in_map("Bu nesnenin dilinden sadece Þaman ve Ninjalar anlayabiliyor...")
        end
    end
    
    when 30333.use with snow_dungeon.is_nemeres_dungeon() == true begin --Key_on_level_8
        local set = snow_dungeon.get_settings()
        local next_jump_time = set.NextJumpTime
        local level = d.getf("level")
        local job = pc.get_job()
        if level == 8 then
            if (is_test_server() and snow_dungeon.is_TestServerMode() == true ) then
                --dchat("SET VARIABLE JOB 3")
                job = 3
            end
            if job == 1 -- Ninja weiblich
            or job == 5 --Ninja männlich
            or job == 3 -- Schamane weiblich
            or job == 7 --Schamane männlich
            then
                if number(1,3) == 1 then
                    notice_in_map("Doðru anahtarý buldunuz.Bir kaç saniye içinde ýþýnlanacaksýnýz.")
                    server_timer("Jp_9",next_jump_time,d.get_map_index())
                    d.clear_regen()
                    d.kill_all()
                    d.regen_file("data/dungeon/ice_dungeon/zone_9.txt")
                    item.remove()
                else
                    notice_in_map("Bu anahtar yanlýþ.")
                    item.remove()
                end
            else
                notice_in_map("Bunu sadece Þaman ve Ninja karakterleri kullanabilir.")
                return
            end
        end
    end

    when Jp_9.server_timer begin --Jump Level 9
        if d.select(get_server_timer_arg()) then
            local set = snow_dungeon.get_settings()
            local v = set.NpcVnum_level_9
            d.setf("level",9)
            local cord = set.base_cord
            local pos = set.Position_level_9
            d.jump_all((cord[1] + pos[1]), (cord[2] + pos[2]))
            notice_in_map(""..mob_name(v).."'yi maðlup edin!")
            notice_in_map("Fakat ona sadece Þaman'ýn tecrübesi ve Ninja'nýn kuvveti karþý koyabilir.")
            
            d.spawn_mob(v,849,655)
        end
    end
    
    when Jp_Boss.server_timer begin --Jump Level BossZone
        if d.select(get_server_timer_arg()) then
            local set = snow_dungeon.get_settings()
            local v = set.BossVnum
            d.setf("level",10)
            local cord = set.base_cord
            local pos = set.Position_level_10
            d.jump_all((cord[1] + pos[1]), (cord[2] + pos[2]))
            notice_in_map(""..mob_name(v).."'yi dondurun ve maðlup edin!")
        end
    end
    
    when kill begin
        if snow_dungeon.is_nemeres_dungeon() == true then
            local set = snow_dungeon.get_settings()
            local next_jump_time = set.NextJumpTime
            local level = d.getf("level")
            local stone_level_6 = set.MobVnum_level_6
            local stone_level_9 = set.NpcVnum_level_9
            local boss_vnum = set.BossVnum
            local wait_time = set.WaitBeforOutAllOnExit
            local mobvnum = npc.get_race()
            --dchat("nemeres_wait_dungeon MobVnum = "..mobvnum.."")
            if level == 2 and mobvnum >= 6101 and mobvnum <= 6108 and 1 == number(1,10) then
                local v = set.key_level_2
				game.drop_item(v,1)
            elseif level == 5 and mobvnum >= 6101 and mobvnum <= 6108 and 1 == number(1,15) then
                snow_dungeon._DropKeyOnLevel5()
            elseif level == 6 and mobvnum == stone_level_6 then
                notice_in_map(""..mob_name(stone_level_6).." maðlup edildi ve bir sonraki seviyeye geçiyorsunuz.")
                
                server_timer("Jp_7",next_jump_time,d.get_map_index())
                d.clear_regen()
                d.kill_all()
                d.regen_file("data/dungeon/ice_dungeon/zone_7.txt") --Szel
                local v_MQv = set.MobVnum_level_7
                local c = set.SzelCords_level_7
                local n = number(1,table.getn(c))
                d.spawn_mob(v_MQv, c[n][1], c[n][2])
            elseif level == 8 and mobvnum >= 6101 and mobvnum <= 6108 and 1 == number(1,10) then
                local v = set.Key_on_level_8
                game.drop_item(v,1)    
            elseif level == 9 and mobvnum == stone_level_9 then
				notice_in_map(""..mob_name(stone_level_9).." maðlup edildi ve bir sonraki seviyeye geçiyorsunuz.")
                server_timer("Jp_Boss",next_jump_time,d.get_map_index())
                d.clear_regen()
                d.kill_all()
                d.regen_file("data/dungeon/ice_dungeon/zone_boss.txt")
                local v = set.BossVnumGroup
                d.spawn_group(v, 928, 335, 5 ,1, 1) --    (Input from SRC: argument: vnum,x,y,radius,aggressive,count)
            elseif level == 10 and mobvnum == boss_vnum then
                d.clear_regen()
                d.kill_all()
                notice_in_map("Tebrikler cesur savaþçýlar! "..mob_name(boss_vnum).."'yu maðlup ettiniz!.. Grup olarak "..wait_time.." saniye sonra ýþýnlanacaksýnýz.")
				notice_all(""..pc.get_name().." ve grup arkadaþlarý Nemeres'i maðlup etti!")
                server_timer("Jp_OutAll",wait_time,d.get_map_index())
            end
        end
    end
    when Jp_OutAll.server_timer begin --Jump Out Bye bye ;D
        if d.select(get_server_timer_arg()) then
            snow_dungeon._ExitAll()
        end
    end
    function _ExitAll()
        d.exit_all()
    end
	end
end  