quest ds_cor begin
	state start begin
		when kill or login or logout or levelup begin
			if pc.count_item(30270) >= 10 then
				pc.remove_item(30270, 10)
				pc.give_item2(50255)
				end
			end
		end
	end