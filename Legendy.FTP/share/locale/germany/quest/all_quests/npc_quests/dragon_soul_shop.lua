quest dragon_soul_shop begin
	state start begin
		when 20001.chat.gameforge.dragon_soul._100_npcChat with ds.is_qualified() begin
			npc.open_shop(13)
			setskin(NOWINDOW)
		end
	end
end
