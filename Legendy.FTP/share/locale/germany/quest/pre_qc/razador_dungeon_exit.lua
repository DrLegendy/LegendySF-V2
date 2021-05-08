quest flame_dungeon_leave begin
    state start begin   
        when login or enter begin
            set_state(leave)
        end
    end
     
    state leave begin
        when letter begin
            if pc.get_map_index() == 351 then
                send_letter("B�lgeden ��k")
            end
			if pc.get_map_index() > 3490000 and pc.get_map_index() < 3511000 then
				send_letter("B�lgeden ��k")
            end
        end
 
        when button or info begin
            say_title("K�rm�z� Ejderha Kalesi")
            say("K�rm�z� Ejderha Kalesi'nden")
			say("��kmak m� istiyorsun?")
            local warp =  select("Evet","Hay�r")
            if warp == 1 then
                clear_letter()
                q.done()
                pc.warp(5980*100, 7075*100, 62)
            else
                say("�yi �anslar!")
            end
        end
         
        when logout begin
            clear_letter()
            q.done()
        end
    end
end