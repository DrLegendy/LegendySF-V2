quest dropac begin
	state start begin
	
		when letter with pc.is_gm() begin
			send_letter(" Drop A� ")
		end
		
		when info or button with pc.is_gm() begin	
			local sec = select ("Drop A� ","Drop Kapat ","Kapat ") 
				if sec == 1 then
					say_yesil("Merhaba "..pc.get_name().." ")
					say_sari("Bu b�l�mden drop a�abilirsin. ")
					say_kirmizi("Drop oranlar� ka� olarak a��ls�n? ")
					local dropdeger = input()
					command("priv 0 1 "..dropdeger.." 1000") -- �tem Drop oran� %200 - 1000 Saat aktif.
					command("priv 0 2 "..dropdeger.." 1000") -- Gold Drop oran� %200 - 1000 Saat aktif.
					command("priv 0 4 "..dropdeger.." 1000") -- Exp Drop oran� %250 - 1000 Saat aktif.
					chat("Droplar aktifle�ti. ")
				elseif sec == 2 then 
					command("priv 0 1 0 1000") -- �tem Drop oran� %100 - 0 Saat aktif.
					command("priv 0 2 0 1000") -- Gold Drop oran� %100 - 0 Saat aktif.
					command("priv 0 4 0 1000") -- Exp Drop oran� %100 - 0 Saat aktif.
					chat("Droplar kapat�ld�. ")
				elseif sec == 3 then 
				end
			send_letter(" Drop A� ")
		end
	end
end
