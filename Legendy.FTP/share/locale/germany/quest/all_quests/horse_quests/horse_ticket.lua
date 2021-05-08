quest horse_ride begin
    state start begin
        when 20349.chat."Attan in" with pc.level>=10 and pc.is_mount() begin
            local msg = "Attan inmek istiyor musun?"
            say(msg)
            local s = select("in", "inme")
            if s==1 then
                pc.unmount()
            end
        end
        when 20349.chat."Ata bin.(Binici kartini kulan)" with pc.level>=10 and not pc.is_mount() begin
            --local money = 10000
            if get_global_time() - pc.getqf("Reitzeit") < 3600 then
                local no_lend_horse_yet =
                    "Saatlik at kiralayabilirsin.[ENTER]"..
                    "At kiralamak istedigin zaman geri gel."
                say(no_lend_horse_yet)
            else
                local msg =
                    say_title("Seyis:")
                    say("")
                    say("Ata binmek istiyor musun?")
                    say("þu anda yanliz binici kartiyla at")
                    say("kiralayabilirsin. simdi ata binme bilincinle")
                    say("on dakika ata binebilirsin.")
                    say("Daha ata binmeye alisik olmadigin")
                    say("için simdilik, sadece ata binebilirsin.")
                    say("Saldiri yapamazsin!")
                local no_horse_ticket = "Sana binici karti lazim."
                say("")
                --local horse_ticket_vnum = 50005
                local horse_ticket_vnum = 50083
                say(msg)
                local s=select("Bin","Binme")
                if s==1 then
                    if pc.countitem(horse_ticket_vnum)>0 then
                        pc.removeitem(horse_ticket_vnum, 1)
                        pc.mount(20030, 600)
                        pc.setqf("Reitzeit", get_global_time())
                    else
                        say(no_horse_ticket)
                    end
                end
            end
        end
    end
end
