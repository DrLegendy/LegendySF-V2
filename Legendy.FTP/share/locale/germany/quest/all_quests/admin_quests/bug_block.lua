quest bug_engelle begin
    state start begin
	
	when login with pc.get_map_index() == 113 begin                   
		if not pc.is_gm() and game.get_event_flag("oxevent_status") > 1 then
			chat("Ox yarışması devam ederken içeri giriş yapamazsın.")
			warp_to_village()
		end               
	end
	
	when levelup or login begin
            if pc.get_level() == 30 then
			ds.give_qualification()
			end
	end
	when levelup begin
		if pc.get_level() == 5 and pc.get_job() == 4 then
				pc.set_skill_group(1) 
				pc.set_skill_level (137,20)
				pc.set_skill_level (138,20)
				pc.set_skill_level (139,20)
				pc.set_skill_level (131,10)
				pc.set_skill_level (129,40)
				pc.set_skill_level (128,20)
				pc.set_skill_level (127,20)
				pc.set_skill_level (126,20)
				pc.set_skill_level (124,40)
				pc.set_skill_level (121,40)
				pc.set_skill_level (122,2)
		end
	end
	
	when logout with pc.get_map_index() > 3490000 and pc.get_map_index() < 3511000 or pc.get_map_index() == 351 begin
				pc.warp(5980*100, 7075*100, 62)
		end
		
		when 6091.kill with pc.get_map_index() == 351 begin -- ?? ????
            forked.warp_all_in_map("351", "62", 5980*100, 7075*100,60)
        end

        when login begin
		if pc.get_map_index() == 68 then
		if pc.get_level() < 60 then
			warp_to_village()
		end
		end
		pc.remove_item("30303",500000)                            --- Bug engelliyoruz , ne olur ne olmaz !    Azrailde yapilan bug panpa                                                        
			   pc.remove_item("30304",500000)                            --- Bug engelliyoruz , ne olur ne olmaz !    Azrailde yapilan bug panpa             
			   pc.remove_item("30300",500000)                            --- Bug engelliyoruz , ne olur ne olmaz !    Azrailde yapilan bug panpa             
			   pc.remove_item("30302",500000)                            --- Bug engelliyoruz , ne olur ne olmaz !    Azrailde yapilan bug panpa             
			   pc.remove_item("30301",500000)                            --- Bug engelliyoruz , ne olur ne olmaz !    Azrailde yapilan bug panpa   
			   pc.remove_item("27001",500000)                            --- Potlari engelliyoruz , ne olur ne olmaz !   Maksat yer kaplamasin 
			   pc.remove_item("27001",500000)                            --- Potlari engelliyoruz , ne olur ne olmaz !   Maksat yer kaplamasin  	
			   pc.remove_item("27002",500000)                            --- Potlari engelliyoruz , ne olur ne olmaz !   Maksat yer kaplamasin  	
			   pc.remove_item("27002",500000)                            --- Potlari engelliyoruz , ne olur ne olmaz !   Maksat yer kaplamasin    		 
			   pc.remove_item("27004",500000)                            --- Potlari engelliyoruz , ne olur ne olmaz !   Maksat yer kaplamasin 	
			   pc.remove_item("27004",500000)                            --- Potlari engelliyoruz , ne olur ne olmaz !   Maksat yer kaplamasin    
		       pc.remove_item("27005",500000)                            --- Potlari engelliyoruz , ne olur ne olmaz !   Maksat yer kaplamasin 	
			   pc.remove_item("27005",500000)                            --- Potlari engelliyoruz , ne olur ne olmaz !   Maksat yer kaplamasin
		 end
    end
end  