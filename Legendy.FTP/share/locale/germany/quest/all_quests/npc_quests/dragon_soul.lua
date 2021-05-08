--[[
Server Files Author : OGStudio
Skype : admin@mmovakti.com
Website : www.metin2files.com
--]]
quest dragon_soul begin
	state start begin
		when login or levelup with pc.get_level() >= 1 begin
			set_state(farming)
		end
	end
	state farming begin
		when kill with not npc.is_pc() begin
			if pc.get_level() >= npc.get_level() - 10 then
				return
			end
			if pc.get_map_index() == 3 or pc.get_map_index() == 23 or pc.get_map_index() == 43 then
				return
			end
			if npc.is_boss() == true then
				pc.setqf("ds_points",pc.getqf("ds_points")+20)
			elseif npc.is_metin() == true then
				pc.setqf("ds_points",pc.getqf("ds_points")+5)
			else
				pc.setqf("ds_points",pc.getqf("ds_points")+1)
			end
			if pc.getqf("ds_points") >= game.get_event_flag("ds_points_drop") then
				pc.give_item2("50255",1)
				syschat(string.format("<Ejderha Taþý Simyasý> Cor puanýn yükseldiði için %s adet %s kazandýn.", 1, item_name(50255)))
				pc.setqf("ds_points", pc.getqf("ds_points")-game.get_event_flag("ds_points_drop"))
			end
		end
		when 30270.pick begin
			if pc.count_item(30270) >= 10 then
				pc.remove_item(30270, 10)
				pc.give_item2(50255)
			end
		end
	end
end