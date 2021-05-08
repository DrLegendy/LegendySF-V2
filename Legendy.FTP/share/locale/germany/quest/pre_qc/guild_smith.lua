quest guild_building_npc begin
    state start begin
        when 20044.click begin
            if npc.get_guild() == pc.get_guild() then
                ---                                                   l
                say_title("Silah Ustas�:")
				say("G�r�n��e g�re sen bizim loncadans�n. Bu sana %10")
				say("ba�ar� �ans� kazand�r�r.")
				say("Yan�s�ra bizim �yelerimize %5 fiyat indirimimiz")
				say("olur. Ho�geldin evlat!")
				say("Ben silahlar� geli�tirebilirim.")
				say("�imdi bana geli�tirmek istedi�in nesneyi ver.")
            else
                ---                                                   l
                say_title("Silah Ustas�:")
                say("Benim ad�m Stanley. Ben silah geli�tirme ")
                say("sorumlusuyum ve bu i�i k�ydeki demirci ustas�ndan")
                say("daya iyi yapar�m! Bana geldi�in zaman")
                say("Bana geldi�in zaman")
                say("geli�tirmedeki ba�ar� �ans�n %10 daha fazla olur.")
                say("�imdi bana geli�tirmek istedi�in silah� ver.")
            end
        end
        when 20045.click begin
            if npc.get_guild() == pc.get_guild() then
                ---                                                   l
                say_title("Z�rh Ustas�:")
				say("G�r�n��e g�re sen bizim loncadans�n. Bu sana %10")
				say("ba�ar� �ans� kazand�r�r.")
				say("Yan�s�ra bizim �yelerimize %5 fiyat indirimimiz")
				say("olur. Ho�geldin evlat!")
				say("Ben z�rhlar�, kalkanlar� ve kasklar� ")
				say("geli�tirebilirim. �imdi bana geli�tirmek istedi�in")
				say("nesneyi ver.")
            else
                ---                                                   l
                say_title("Z�rh Ustas�:")
                say("Ben Stanton. Ben z�rh geli�tirme sorumlusuyum. ")
                say("K�ydeki demirciden daha yetenekliyim: ba�ar� ")
                say("�ans�m %10 daha fazla.")
                say("�imdi bana geli�tirmek istedi�in nesneyi ver.")
            end
        end
        when 20046.click begin
            if npc.get_guild() == pc.get_guild() then
                ---                                                   l
                say_title("Kuyumcu: ")
				say("G�r�n��e g�re sen bizim loncadans�n. Bu sana %10")
				say("ba�ar� �ans� kazand�r�r.")
				say("Yan�s�ra bizim �yelerimize %5 fiyat indirimimiz")
				say("olur. Ho�geldin evlat!")
				say("Ben bilezikleri, k�peleri ve ayakkab�lar� ")
				say("geli�tirebilirim. �imdi bana geli�tirmek istedi�in")
				say("aksesuar� ver.")
            else
                ---                                                   l
                say_title("Kuyumcu:")
                say("Ad�m Starbuck. Ben aksesuarlar� geli�tirmekten")
                say("sorumluyum. �zel mineral, metal ve t�ccarlarla")
                say("�al���yorum, haliyle kaliteli oluyor. K�ydeki")
                say("demircilerden bu konuda daha iyiyimdir.")
                say("E�er onlar yerine bana gelirsen, ba�ar� �ans�n %10")
                say("artacakt�r. Ben bilezikleri, k�peleri ve")
                say("ayakkab�lar� geli�tiririm.")
				say("�imdi bana geli�tirmek istedi�in aksesuar� ver.")
            end
        end
    end
end
