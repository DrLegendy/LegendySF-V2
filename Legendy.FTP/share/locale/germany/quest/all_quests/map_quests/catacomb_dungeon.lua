quest seytan_katakombu begin 
        state start begin 
    when 1093.kill with pc.in_dungeon() and pc.get_map_index() >= 660000 and pc.get_map_index() < 670000 begin 
        notice_in_map("G�revi ba�ar�yla tamamlad�n.") 
        notice_in_map("Seni �eytan Katakombu'nda bekleyece�im!") 
        notice_in_map("Pe�imden gel, �fkem felaketin olsun!") 
		if pc.getqf("azraili_kestim") == 0 then
			pc.setqf("azraili_kestim",1)
		end
    end 
     
    when devil_end_jump.timer begin 
        d.exit_all() 
    end 
     
    when 20367.chat."�eytan Katakombu'na gider" with pc.get_map_index() == 65 begin 
        if pc.level < 75 then 
            say_title("Katakomb Bek�isi:") 
            say("75. seviyenin alt�nda oldugun i�in") 
            say("katakombu ba�aramazs�n..") 
            return 
         end 
        if pc.getqf("azraili_kestim") == 0 then
            say("Hen�z �eytan Katakombu'nu ba�aracak") 
            say("kadar g��l� de�ilsin. Azraili �eytan Kulesi'nde") 
            say("yendikten sonra tekrar gel.") 
            return 
        end 
        if pc.getqf("azraili_kestim") == 1 then
            say("�eytan�n �nine �imdi girmek istiyor musun?") 
        local s = select("Evet", "Girme") 
        if s == 1 then 
            pc.warp(315200,1209200) 
            return 
            end 
        end 
    end 
    when login with pc.get_map_index() == 216 begin 
    say("Ruh Kristal� Anahtar�'n� ele ge�irmek i�in") 
    say("yarat�klar� yok et. Bu") 
    say("sana 2. kat�n kap�s�n� a�ar.") 
    pc.set_warp_location(65 , 5913, 995) 
    end 
    when 2503.kill or 
            2504.kill or 
            2505.kill begin 
        local rka = number(1,10) 
    if rka==1 then 
    game.drop_item(30311, 1) 
    end 
    end 
    when 30101.take with item.vnum == 30311 begin 
    item.remove() 
    say("Kap� art�k a��k.") 
    say("Acele edin gidelim.") 
        wait() 
    say("�imdi ger�ek bir macera ba�l�yor.") 
    say("2. seviyeye ge�mek i�in sadece bir saatin var.")             
        wait() 
    d.new_jump_all(216, 3622, 12079) 
    d.setf("catacomb_kat2", 1) 
    game.set_event_flag("Azrail_dead",0) 
    end 
     
    when login with pc.in_dungeon() and d.getf("catacomb_kat2") == 1 begin 
    d.regen_file("data/dungeon/katakomb/catacomb_kat2.txt") 
        say("3. seviyeye ge�mek i�in kapal� kap�lar� yok et.") 
        say("") 
        say("") 
        say("60 dakika kald�!")     
    timer("catacomb_5dakika", 3300) 
    timer("catacomb_10dakika", 3000) 
    timer("catacomb_20dakika", 2400) 
    timer("catacomb_30dakika", 1800) 
    timer("catacomb_30dakika", 900) 
    timer("catacomb_bitti", 3600) 
    pc.set_warp_location(65 , 5913, 995) 
    end 
     
    when 30103.chat."�zel b�l�m" with pc.count_item(30319) > 0 begin 
    say("Kapal� kap�lar� k�rd�n ve buraya kadar geldin.") 
        wait() 
    say("Azrail'i g�rebilmen i�in K���len Kafa'ya ") 
    say("ihtiyac�n var.") 
    say("") 
    say("K���len Kafa'ya sahip de�ilsen ma�aradan") 
    say("d��ar� at�lacaks�n.") 
    pc.remove_item(30319) 
    game.set_event_flag("Azrail_dead",0) 
    wait() 
    npc.purge() 
    timer("katakomb_kat_3", 3) 
    end 
     
    when katakomb_kat_3.timer begin 
    d.jump_all(3072+1376, 12032+250) 
    d.regen_file("data/dungeon/katakomb/catacomb_kat3.txt") 
    notice_in_map("Ger�ek Misilleme Metinini bul ve yok et!") 
    d.setf("catacomb_metin", 2) 
    end 

    when 8038.kill with pc.in_dungeon() and d.getf("catacomb_metin") == 2 begin 
        notice_in_map("Bu Metin ta�� sahte, ger�e�ini bul.") 
    d.setf("catacomb_metin", 3) 
        end 
     
    when 8038.kill with pc.in_dungeon() and d.getf("catacomb_metin") == 3 begin 
        notice_in_map("Bu Metin ta�� sahte, ger�e�ini bul.") 
    d.setf("catacomb_metin", 4) 
        end 
     
    when 8038.kill with pc.in_dungeon() and d.getf("catacomb_metin") == 4 begin 
        notice_in_map("Bu Metin ta�� sahte, ger�e�ini bul.") 
    d.setf("catacomb_metin", 5) 
        end 
     
    when 8038.kill with pc.in_dungeon() and d.getf("catacomb_metin") == 5 begin 
        notice_in_map("Bu Metin ta�� sahte, ger�e�ini bul.") 
    d.setf("catacomb_metin", 6) 
        end 
     
    when 8038.kill with pc.in_dungeon() and d.getf("catacomb_metin") == 6 begin 
        notice_in_map("Bu Metin ta�� sahte, ger�e�ini bul.") 
    d.setf("catacomb_metin", 7) 
        end 
     
    when 8038.kill with pc.in_dungeon() and d.getf("catacomb_metin") == 7 begin 
        notice_in_map("Bu Metin ta�� sahte, ger�e�ini bul.") 
    d.setf("catacomb_metin", 8) 
        end 
     
    when 8038.kill with pc.in_dungeon() and d.getf("catacomb_metin") == 8 begin 
    notice_in_map("Ger�ek Metin ta�� yokedildi. 4. seviyeye h�zl� bir �ekilde devam edelim.") 
        timer("catacomb_labirent", 5) 
        end 
         
    when catacomb_labirent.timer begin 
    d.setf("level", 4) 
    d.jump_all(3072+70, 12032+585) 
    d.regen_file("data/dungeon/katakomb/catacomb_kat4.txt") 
    notice_in_map("5. seviyeye ula�mak i�in labirentte yolunuzu bulun!") 
        local lab = number(1,4) 
        if lab == 1 then 
    d.regen_file("data/dungeon/katakomb/catacomb_warps1.txt") 
        end 
        if lab == 2 then 
    d.regen_file("data/dungeon/katakomb/catacomb_warps2.txt") 
        end 
        if lab == 3 then 
    d.regen_file("data/dungeon/katakomb/catacomb_warps3.txt") 
        end 
        if lab == 4 then 
    d.regen_file("data/dungeon/katakomb/catacomb_warps4.txt") 
        end 
    end 
     
    when 30104.chat."5. seviyeye ilerle" begin 
    say("�eytan ruhlar�n� hissedebiliyor musun?") 
        wait() 
    say("Devam etmek istiyor musun?") 
    wait() 
        timer("katakomb_kat_5", 6) 
    end 
     
    when katakomb_kat_5.timer begin 
    d.setf("level", 5) 
    d.jump_all(3072+846, 12032+898) 
    d.regen_file("data/dungeon/katakomb/catacomb_kat5.txt") 
    notice_in_map("Tartoruslar� yen ve alt�nc� seviyeye ge�ebilmek i�in Surat Totemini ele ge�irin.") 
        local gar = number(1,5) 
        if gar == 1 then 
    d.regen_file("data/dungeon/katakomb/catacomb_boss1.txt") 
        end 
        if gar == 2 then 
    d.regen_file("data/dungeon/katakomb/catacomb_boss2.txt") 
        end 
        if gar == 3 then 
    d.regen_file("data/dungeon/katakomb/catacomb_boss3.txt") 
        end 
        if gar == 4 then 
    d.regen_file("data/dungeon/katakomb/catacomb_boss4.txt") 
        end 
        if gar == 5 then 
    d.regen_file("data/dungeon/katakomb/catacomb_boss5.txt") 
        end 
    end 

    when 2591.kill begin 
        local tar = number(1,1) 
    if tar==1 then 
    game.drop_item(30312, 1) 
        end 
    end 
     
    when 30102.take with item.vnum == 30312 begin 
    notice_in_map("Uzaklardan ulumalar� duyuluyor. Gaddar Azrail'i uyand�rd�n�z.") 
    item.remove() 
    npc.purge() 
        timer("catacomb_kat_6", 6) 
    end 
     
    when catacomb_kat_6.timer begin 
    d.setf("level", 6) 
    d.jump_all(3072+1358, 12032+671) 
    d.regen_file("data/dungeon/katakomb/catacomb_kat6.txt") 
    notice_in_map("Kharoon ve di�er t�m d��manlar� yenin!") 
    end 
     
    when 2597.kill begin 
    d.kill_all() 
    timer("catacomb_1kharoon", 2) 
    end 
     
    when catacomb_1kharoon.timer begin 
    say("Kharoon'u �ld�rd�n. Ma�aran�n en son") 
    say("seviyesine ���nlan�yorsunuz.") 
        timer("catacomb_kharoon", 2) 
    end 
     
    when catacomb_kharoon.timer begin 
    d.setf("level", 7) 
    d.jump_all(3072+73, 12032+1157) 
    d.regen_file("data/dungeon/katakomb/catacomb_kat7.txt") 
    notice_in_map("Azrail'i yenin!") 
    end 
     
    when 2598.kill begin 
        d.kill_all() 
        timer("catacomb_1azrail", 2) 
    end 

    when catacomb_1azrail.timer begin 
    say("Azrail yenildi. Devil's Catacomb'a nihayet") 
    say("huzur hakim. �imdi yery�z�ne ���nlanacaks�n.") 
        timer("catacomb_azrail", 30) 
    end 
     
    when catacomb_5dakika.timer begin 
    notice_in_map("Kalan s�re: 5 dakika") 
            end 
     
    when catacomb_10dakika.timer begin 
    notice_in_map("Kalan s�re: 10 dakika") 
            end 
     
    when catacomb_20dakika.timer begin 
    notice_in_map("Kalan s�re: 20 dakika") 
            end 
     
    when catacomb_30dakika.timer begin 
    notice_in_map("Kalan s�re: 30 dakika") 
            end 
     
    when catacomb_45dakika.timer begin 
    notice_in_map("Kalan s�re: 45 dakika") 
        d.exit_all() 
            end 
     
    when catacomb_bitti.timer begin 
    game.set_event_flag("kuleazrail",0) 
    notice_in_map("S�re bitti!") 
        d.exit_all() 
            end 
     
    when catacomb_azrail.timer begin 
        d.exit_all() 
            end 
        end 
    end  