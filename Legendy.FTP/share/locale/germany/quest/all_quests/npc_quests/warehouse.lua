quest warehouse begin
        state start begin --Status when nothing is open
			when warehouse_keeper.chat."Depoyu kullanmak istiyor musun?"  begin
				say_title("Depo G�revlisi:")
				say("")
				say("Depoyu kullanmak istiyor musun?")
				say("Depoyu kullanmak i�in biraz Yang �demelisin.")
				say("Bu g�n iyi g�n�mdeyim.")
				say("500 Yang a yapabilirsin.")
				say("Gel ,ucuz, hu? Hehe.")
				say("")
				wait()
				if pc.gold < 500 then
					say_title("Depocu:")
					say("")
					say("Ne? Yeterli Yang yok mu?")
					say("O zaman yeterli Yang'�n oldu�unda ")
					say("tekrar gel.")
					say("")
				else
					local s = select("�de.", "�deme.")
					if s == 1 then
						pc.changegold(-500)
						game.set_safebox_level(1)
						set_state(use)
						say_title("Depocu:")
						say("")
						say("�zel depon �u anda a��ld�. ")
						say("E�er onu kullanmak istiyorsan,sadece benimle")
						say("konu�. ")
						say("Depo �ifresi: ")
						say_reward("000000")
						say("Onu g�venli�inden dolay� ")
						say("de�i�tirmelisin.")
						say("")
						say("Belki 15 kutu yeterli olmaz. ")
						say("Ama kim bilir e�er birbirimizi seversek")
						say("belki sana daha fazla bo� alan veririm. Hehe!")
						say("")
					else
						say_title("Depocu:")
						say("")
						say("Oh g�zel..Mayor istemezse ")
						say("bunu yapmak zorunda de�il..")
						say("")
					end
				end
			end
        end
        state use begin
			when warehouse_keeper.chat."Depoyu a� " begin
				if pc.getqf("open_count") < 3 then
					say_title("Depocu:")
					say("")
					say("Ho�geldin !")
					say("Alt�n k�l�eler ne i�in biliyor musun?")
					say("")
					say("E�er �st�nde Yang ta��rsan ")
					say("bu l�tfen beni �ld�r ")
					say("demek gibi olur. ")
					say("")
					say("Bu y�zden insanlardaki Yanglar� k�l�e alt�na")
					say("d�n��t�rd�m. Sizin i�in sakl�yorum.")
					say("")
					wait()
					say_title("Depocu:")
					say("")
					say("H�m..")
					say("Peki,Bir k�l�e alt�n�n de�erinden daha ")
					say("fazlas�n� istiyorum. Ama bu hala adaletli,")
					say("de�il mi? K�t� d���nmek i�in bir neden yok.")
					say("Biliyorsun d��ar�s� �ok ")
					say("tehlikeli.")
					say("")
					wait()
					pc.setqf("open_count", pc.getqf("open_count") + 1)
				end
				setskin(NOWINDOW)
				game.open_safebox()
			end
			when warehouse_keeper.chat."Nesne market deposunu a� " begin
				setskin(NOWINDOW)
				game.open_mall()
			end
		end
	end	
