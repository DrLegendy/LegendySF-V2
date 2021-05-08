quest horse_guard begin
        state start begin
                when 20349.chat."Atlar hakkinda bilgi" begin
                        local s=number(1, 7)
                        if 1>=s then -- 14.29% (1/7)
                                ---                                                   l
                                say("At üzerine görev yapmak için,")
                                say("At madalyonu gerekli. Onu")
                                say("Maymun zindanindan alabilirsin .")
                                say(" ")
                        elseif 2>=s then -- 14.29% (1/7)
                                say("Atlar üç boy: Küçük, orta")
                                say("ve büyük. Bir sira çikman için,")
                                say("seviye atlama görevini yapman lazim.")
                                say("")
                        elseif 3>=s then -- 14.29% (1/7)
                                say("Atin boyuna göre onlara")
                                say("degisik yem lazim.")
                                say("Küçük atlar kuru ot yiyor, orta boy atlar havuç ")
                                say("ve büyük atlar yanliz kirmizi ")
                                say("sinseng.")
                                say("Agizlarinin tadini iyi ")
                                say("biliyorlar.")
                        elseif 4>=s then -- 14.29% (1/7)
                                say("Atin saglikliysa, gösterge yesil ")
                                say("görünüyor, aç olursa sari,")
                                say("beslenemiyorsa kirmizi.")
                                say("Kirmizi veya saridan")
                                say("yesile çikmasi için onu beslemelisin.")
                                say("Bu ciddi bir konu, ya atin ")
                                say("ölürse!")
                                say("")
                        elseif 5>=s then -- 14.29% (1/7)
                                say("Ata bindigin zaman, yorgunlugu")
                                say("artiyor ve sagligi da eksiliyor .")
                                say("Sagliksiz ata binemeyecegin için,")
                                say("arada onu dinlendirmelisin.")
                                say("")
                        elseif 6>=s then -- 14.29% (1/7)
                                say("Bir rivayete göre, ölü atlar")
                                say("tekrar canlandirilabiliyor. Ama")
                                say("Maymunlar bunun için gerekli bitkileri")
                                say("koruyor ve onu almak çok zor. ")
                                say("Maymunlar seni yakalarsa,")
                                say("seni de lanetleyip ve maymuna")
                                say("dönüstürüyorlar.")
                                say("")
                        elseif 7>=s then -- 14.29% (1/7)
                                say("Degisik binicilik seviyeleri var")
                                say("ve atinin seviyesini de yükseltebilirsin")
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
