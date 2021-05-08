quest dropac begin
	state start begin
	
		when letter with pc.is_gm() begin
			send_letter(" Drop Aç ")
		end
		
		when info or button with pc.is_gm() begin	
			local sec = select ("Drop Aç ","Drop Kapat ","Kapat ") 
				if sec == 1 then
					say_yesil("Merhaba "..pc.get_name().." ")
					say_sari("Bu bölümden drop açabilirsin. ")
					say_kirmizi("Drop oranlarý kaç olarak açýlsýn? ")
					local dropdeger = input()
					command("priv 0 1 "..dropdeger.." 1000") -- Ýtem Drop oraný %200 - 1000 Saat aktif.
					command("priv 0 2 "..dropdeger.." 1000") -- Gold Drop oraný %200 - 1000 Saat aktif.
					command("priv 0 4 "..dropdeger.." 1000") -- Exp Drop oraný %250 - 1000 Saat aktif.
					chat("Droplar aktifleþti. ")
				elseif sec == 2 then 
					command("priv 0 1 0 1000") -- Ýtem Drop oraný %100 - 0 Saat aktif.
					command("priv 0 2 0 1000") -- Gold Drop oraný %100 - 0 Saat aktif.
					command("priv 0 4 0 1000") -- Exp Drop oraný %100 - 0 Saat aktif.
					chat("Droplar kapatýldý. ")
				elseif sec == 3 then 
				end
			send_letter(" Drop Aç ")
		end
	end
end
