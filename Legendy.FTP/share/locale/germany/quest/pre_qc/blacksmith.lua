quest upgrade_refine_scroll begin
	state start begin
		when 20016.chat."Sava� ka��d� �ret." begin
            say_title("Demirci:")
            say("Sava� Tanr�lar� taraf�ndan kutsanm�� gizemli bir")
            say("ka��t var, bu ka��t e�yalar�n +0'dan +3'e")
            say("kadar y�kseltmesinin ba�ar� oran�n� %100'e")
            say("��kar�yor. Ancak bu ka��t +4 ve �st� i�in")
            say("�al��m�yor.")
            say("")
            wait()
            if pc.count_item(70035) == 0 then
                say_title("Demirci:")
                say("Bunu �retmek i�in, b�y�l� metale ihtiyac�n")
                say("var.")
                say("")
                say_item("B�y�l� metal", 70035, "")
                say("")
                wait()
				end
            if pc.count_item(25040) == 0 then
                say_title("Demirci:")
                say("Ayr�ca kutsama ka��d�na da ihtiyac�n ")
                say("var.")
                say("")
                say_item("Kutsama ka��d� ", 25040, "")
                say("")
                wait()
            end
            say_title("Demirci:")
            say("T�m gereken e�yalara sahip misin?")
            say("Bir tane �retmek istiyor musun?")
            say("Yan�s�ra 200.000 Yang'a ihtiyac�n olacak.")
            say("E�er b�y�l� metal ve kutsama ka��d�n varsa,")
            say("sava� ka��d� �retebilirsin. Bu ka��d� �retmek")
            say("istiyor musun?")
            say("")
            local s = select("Evet", "Hay�r")
            if 1 == s then
                if pc.get_gold() < 200000 then
                    say_title("Bilgi:")
                    say_reward("Yeterli Yang'�n yok.")
                    say("")
                elseif pc.count_item(70035)>0 and pc.count_item(25040)>0 then
                    pc.remove_item(70035)
                    pc.remove_item(25040)
                    pc.changegold(-200000)
                    pc.give_item2(71021)
                    say_title("Demirci:")
                    say("Bir sava� ka��d� �rettin!")
                    say("B�y�l� metalin oldu�unda sava� ")
                    say("ka��d� �retmek ger�ekten kolay.")
                    say("")
                    say_item("Sava� ka��d� ", 71021,"")
                else
                    say_title("Demirci:")
					say("�htiyac�n olan t�m nesnelere")
                    say("sahip de�ilsin.")
                    say("")
                end
            end
        end
        when 20016.chat."Ejderha Tanr�s� Ka��d� �retmek" begin
            say_title("Demirci:")
            say("Ejderha Tanr�s� ka��d� geli�tirmelerinde ba�ar� ")
            say("y�zdeni art�r�r. E�er ba�ar�s�z olursan, sadece")
            say("1 seviye d��er. Bu gizemli e�ya bir t�r kutsama")
            say("ka��d� olarak g�r�lebilir.")
            say("")
            wait()
            if pc.count_item(71026)==0 then
                say_title("Demirci:")
                say("")
                say("Bunu yapmak i�in b�y�l� metale")
                say("ihtiyac�n var.")
				say("")
                say_item("B�y�l� Metal", 71026, "")
                say("")
                wait()
            end
            if pc.count_item(25040)==0 then
                say_title("Demirci:")
                say("Bunu �retebilmen i�in, kutsama ka��d� gerekli.")
                say("")
                say_item("Kutsama ka��d� ", 25040,"")
                say("")
                wait()
            end
            say_title("Demirci:")
            say("T�m gereken e�yalara sahip misin? Bunlardan")
            say("birini �retmek istiyor musun? E�er kutsama ka��d� ")
            say("ve b�y�l� demir madeni kullan�rsan, Ejderha")
            say("Tanr�s� ka��d� yapabilirsin.")
            say("")
            local ss = select("Evet", "Hay�r")
            if 1 == ss then
                if pc.count_item(71026)>0 and pc.count_item(25040)>0 then
                    pc.remove_item(71026)
                    pc.remove_item(25040)
                    pc.give_item2(71032)
                    say_title("Demirci:")
                    say("Bir Ejderha Tanr�s� ka��d� �rettin! ")
                    say("B�y�l� metal kulland���n zaman,")
                    say("�ok kolay bir Ejderha Tanr�s� ka��d� ")
                    say("yapars�n.")
                    say("")
                    say_item("Ejderha Tanr�s� ka��d� ", 71032, "")
                else
                    say_title("Demirci:")
                    say("Ejderha Tanr�s� ka��d� �retme i�lemi ba�ar�s�z")
                    say("oldu, ��nk� gereken t�m e�yalara sahip de�ilsin. ")
                    say("")
                end
            end
        end

        when 20016.chat."Demircinin El Kitab� �ret" begin
                say_title("Demirci:")
                say("Hi� Demirci Ta�� diye bir �ey duymu� muydun? Bu")
                say("ta� demircinin kan� ve al�n terinden yap�l�r.")
                say("E�er bana demircinin ta��n� ve Kutsama Ka��d� ")
                say("getirirsen sana ailemin ge�mi�inden bug�ne gelmi� ")
                say("olan bir el kitab� yapar�m. Bu el kitab�, ejderha")
                say("tanr�s� ka��d� ile ayn� i�e yarar fakat ba�ar� ")
                say("y�zdesi daha y�ksektir.")
                say("")
                wait()
                if pc.count_item(71025) == 0 then
                        say_title("Demirci:")

                        say("Bundan �retebilmen i�in, Demircinin ta��na")
                        say("ihtiyacin var.")
                        say("")
                        say_item("Demircinin Ta�� ", 71025, "")
                        say("")
                        wait()
                end
                if pc.count_item(25040) == 0 then
                        say_title("Demirci:")
                        say("Bunu �retebilmek i�in kutsama ka��d�na")
                        say("ihtiya� var.")
                        say("")
                        say_item("Kutsama ka��d� ", 25040, "")
                        say("")
                        wait()
                end
                say_title("Demirci:")
                say("")
                say("Gereken t�m e�yalara sahip misin? Peki,")
                say("demircinin el kitab�n� yapmak istiyor musun?")
                say("")
                local sss = select("Evet", "Hay�r")
                if 1 == sss then
                        if pc.count_item(71025) > 0 and pc.count_item(25040) > 0 then
                                pc.remove_item(71025)
                                pc.remove_item(25040)
                                pc.give_item2(70039)
                                say_title("Demirci:")
                                say("Ba�ar�yla bir demircilik el kitab� ")
                                say("yapt�n! Ailemin El Kitab�n� ka��da ")
                                say("yazaca��m. ")
                                say("")
                                say_item("Demircinin El Kitab� ", 70039, "")
                        else
                                say_title("Demirci:")
                                say("Demircinin el kitab�n� �retemiyorum ��nk� gereken")
                                say("malzemelere sahip de�ilsin.")
                                say("")
                        end
                end
        end
    end
end
