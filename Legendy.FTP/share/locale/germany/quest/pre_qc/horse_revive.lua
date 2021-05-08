quest horse_revive begin
        state start begin
                when 20349.chat."Atimi canlandirmak istiyorum." with horse.get_grade()==3 and horse.is_dead() and pc.countitem("50059")<1 begin
                        say_title("Seyis:")
                        say("")
                        say("Atini sadece, (3) Joongsun zindanindan ")
                        say("bulabilecegin bitkilerle canlandirabilirsin. ")
                        say("Fakat, bunu basarmak gerçekten zor. Çünkü bitkiler ")
                        say("maymunlar tarafindan korunuyor. ")
                        say("Maymunlar çok sinirli. Bitkileri onlardan çalmak ")
                        say("isteyen, herkesi maymuna dönüstürüyorlar. ")
                        if pc.countitem("50058")>=1 then
                                say_title("Seyis: ")
                                say("")
                                say("Bilgi: 2.Maymun zindanindan toplanan ")
                                say("bitkiler sadece normal gelisimdeki atlar içindir. ")
                                say("")
                        elseif pc.countitem("50057")>=1 then
                                say_title("Seyis: ")
                                say("")
                                say("Bilgi: 1. Maymun zindanindan toplanan ")
                                say("bitkiler sadece acemi atlar içindir. ")
                        end
                end
                when 20349.chat."Atimi canlandirmak istiyorum. " with horse.get_grade()==3 and horse.is_dead() and pc.countitem("50059")>=1 begin
                        say("Bu bitkiler (3) Joongsun zindanindan toplandi. ")
                        say("Senin atini canlandiracaklar. Haydi ati çagiralim! ")
                        wait()
                        say("Bu otlari ata yedir ve bekle. ")
                        say("[DELAY value=400]. . .[/DELAY] ")
                        horse.summon()
                        wait()
                        say("Atin canlanmaya basladi. ")
                        say("Gelecekte, atini beslemeyi ihmal etme. ")
                        if pc.countitem("50059")>=1 then
                                pc.removeitem("50059", 1)
                                horse.revive()
                        end
                end
                when 20349.chat."Atimi canlandirmak istiyorum. " with horse.get_grade()==2 and horse.is_dead() and pc.countitem("50058")<1 begin
                        say("Atini sadece (2)Sangsun Zindanindan bulabilecegin ")
                        say("Baharatlarla canlandirabilirsin. ")
                        say("Bitkileri maymunlar koruduklari için, ")
                        say("bu gerçekten çok zor. Maymunlar çok öfkeli. ")
			say("Bitkileri almak isteyen herkesi ")
			say("lanetleyerek maymuna çeviriyorlar.. ")
			say("")
                        if pc.countitem("50059")>=1 then
                                say("Bilgi: (3)Joongsun zindanindan olan bitkiler sadece ileri düzeydeki atlar içindir. ")
                        elseif pc.countitem("50057")>=1 then
                                say("Bilgi: (1)Hasun zindanindan olan bitkiler sadece acemi atlar içindir. ")
                        end
                end
                when 20349.chat."Atimi canlandirmak istiyorum" with horse.get_grade()==2 and horse.is_dead() and pc.countitem("50058")>=1 begin
                        say("Bu bitkiler (2) Sangsun Zindanindan toplandi. ")
			say("Senin atini canlandiracaklar. ")
                        say("Haydi önce ati çagiralim. ")
                        wait()
                        say("Bitkileri ata yedir ve bekle! ")
                        say("[DELAY value=400]. . .[/DELAY]")
                        horse.summon()
                        wait()
                        say("Atin canlanmaya basliyor. ")
                        say("Gelecekte onu beslemeyi unutma. ")
                        if pc.countitem("50058")>=1 then
                                pc.removeitem("50058", 1)
                                horse.revive()
                        end
                end
                when 20349.chat."Atimi canlandirmak istiyorum. " with horse.get_grade()==1 and horse.is_dead() and pc.countitem("50057")<1 begin
                        say("Atini sadece (1) Hasun Zindanindan ")
			say("toplanacak bitkiler ile canlandirabilirsin. ")
                        say("Bitkiler maymunlar tarafindan ")
			say("korundugu için bu gerçekten zor bir görev. ")
                        say("gerçekten zor bir görev. ")
			say("Maymunlar öfkeli! Bitkileri toplamak ")
                        say("isteyen herkesi lanetleyerek maymuna ")
			say("dönüstürüyorlar. ")
                        if pc.countitem("50059")>=1 then
                                say("Bilgi: (3) Joongsun Zindanindan toplanan bitkiler sadece ileri düzeydeki atlar içindir. ")
                        elseif pc.countitem("50057")>=1 then
                                say("Bilgi: (1) Hasun Zindanindan toplanan bitkiler acemi atlar içindir. ")
                        end
                end
                when 20349.chat."Atimi canlandirmak istiyorum. " with horse.get_grade()==1 and horse.is_dead() and pc.countitem("50057")>=1 begin
                        say("Bu bitkiler (1) Hasun Zindanindan toplandi. ")
			say("Atini tekrar canlandiracaklar. ")
                        say("Haydi atini çagiralim! ")
                        wait()
                        say("Ata bitkileri yedir ve bekle. ")
                        say("[DELAY value=400]. . .[/DELAY]")
                        horse.summon()
                        wait()
                        say("Atin canlanmaya basladi. ")
                        say("Gelecekte atini beslemeyi unutma. ")
                        if pc.countitem("50057")>=1 then
                                pc.removeitem("50057", 1)
                                horse.revive()
                        end
                end
        end
        state __COMPLETE__ begin
                when enter begin
                        q.done()
                end
        end
end
