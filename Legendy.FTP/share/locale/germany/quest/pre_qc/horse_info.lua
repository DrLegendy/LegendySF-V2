quest horse_guard begin
        state start begin
                when 20349.chat."Atlar hakkinda bilgi" begin
                        local s=number(1, 7)
                        if 1>=s then -- 14.29% (1/7)
                                ---                                                   l
                                say("At �zerine g�rev yapmak i�in,")
                                say("At madalyonu gerekli. Onu")
                                say("Maymun zindanindan alabilirsin .")
                                say(" ")
                        elseif 2>=s then -- 14.29% (1/7)
                                say("Atlar �� boy: K���k, orta")
                                say("ve b�y�k. Bir sira �ikman i�in,")
                                say("seviye atlama g�revini yapman lazim.")
                                say("")
                        elseif 3>=s then -- 14.29% (1/7)
                                say("Atin boyuna g�re onlara")
                                say("degisik yem lazim.")
                                say("K���k atlar kuru ot yiyor, orta boy atlar havu� ")
                                say("ve b�y�k atlar yanliz kirmizi ")
                                say("sinseng.")
                                say("Agizlarinin tadini iyi ")
                                say("biliyorlar.")
                        elseif 4>=s then -- 14.29% (1/7)
                                say("Atin saglikliysa, g�sterge yesil ")
                                say("g�r�n�yor, a� olursa sari,")
                                say("beslenemiyorsa kirmizi.")
                                say("Kirmizi veya saridan")
                                say("yesile �ikmasi i�in onu beslemelisin.")
                                say("Bu ciddi bir konu, ya atin ")
                                say("�l�rse!")
                                say("")
                        elseif 5>=s then -- 14.29% (1/7)
                                say("Ata bindigin zaman, yorgunlugu")
                                say("artiyor ve sagligi da eksiliyor .")
                                say("Sagliksiz ata binemeyecegin i�in,")
                                say("arada onu dinlendirmelisin.")
                                say("")
                        elseif 6>=s then -- 14.29% (1/7)
                                say("Bir rivayete g�re, �l� atlar")
                                say("tekrar canlandirilabiliyor. Ama")
                                say("Maymunlar bunun i�in gerekli bitkileri")
                                say("koruyor ve onu almak �ok zor. ")
                                say("Maymunlar seni yakalarsa,")
                                say("seni de lanetleyip ve maymuna")
                                say("d�n�st�r�yorlar.")
                                say("")
                        elseif 7>=s then -- 14.29% (1/7)
                                say("Degisik binicilik seviyeleri var")
                                say("ve atinin seviyesini de y�kseltebilirsin")
                                say("Ama bir ati sadece")
                                say("bir kisi")
                                say("at resmiyle kulanabilir.")
                        end
                end
        end
        state __COMPLETE__ begin
                when enter begin
                        q.done()
                end
        end
end
