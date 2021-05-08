quest flame_dungeon_leave begin
    state start begin   
        when login or enter begin
            set_state(leave)
        end
    end
     
    state leave begin
        when letter begin
            if pc.get_map_index() == 351 then
                send_letter("Bölgeden çık")
            end
			if pc.get_map_index() > 3490000 and pc.get_map_index() < 3511000 then
				send_letter("Bölgeden çık")
            end
        end
 
        when button or info begin
            say_title("Kırmızı Ejderha Kalesi")
            say("Kırmızı Ejderha Kalesi'nden")
			say("çıkmak mı istiyorsun?")
            local warp =  select("Evet","Hayır")
            if warp == 1 then
                clear_letter()
                q.done()
                pc.warp(5980*100, 7075*100, 62)
            else
                say("İyi şanslar!")
            end
        end
         
        when logout begin
            clear_letter()
            q.done()
        end
    end
end