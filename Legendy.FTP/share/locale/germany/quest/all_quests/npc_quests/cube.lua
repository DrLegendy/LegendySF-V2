quest cubeler begin
	state start begin
		when 20017.chat."Su - �ebnem �retim Penceresi " with pc.get_level() >= 1 begin
			setskin(NOWINDOW)
			command("cube open")
		end
	end
end
