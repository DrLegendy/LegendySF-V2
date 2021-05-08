quest npc_talk2 begin
    state start begin
 		when 20091.chat.locale.epicsura1_chat begin
			say_title("Seon Pyeong:")
			say("Arkada��m, d�nya cevaplanmam�� sorunlarla dolu. Ve")
			say("ben cevap ve bilgi ar�yorum. Destans� Silahlar� ")
			say("ve Ruh Ta�lar�n� hi� duydun mu?")
			end
		when 20091.chat.locale.epicsura2_chat begin
			say_title("Seon Pyeong:")
			say("Bilinmeyeni ara�t�rd���m� zaten biliyorsundur. �u")
			say("anda iyi silahlar yapman�n ve ruh")
			say("ta�lar�n�n g�c�n� artt�rman�n yolunu ar�yorum.")
			end
		when 20091.chat.locale.epicsura3_chat begin
			say_title("Seon Pyeong:")
			say("�lgin� de�il mi? Bununla ilgili daha fazla")
			say("�eyler ��renmek istiyorsun de�il mi? �yleyse bana")
			say("�n�m�zdeki +9 silahlardan bir tane getir.")
			say("Muharebe K�l�c�+9, Sar� Ejderha Yay�+9,")
			say("Kurtulu� Yelpazesi+9, Ejderha B��a��+9, �eytan")
			say("��karma K�l�c�+9, Cennet ve D�nya �an�+9 veya")
			say("Hortlak Di�i K�l�c�+9. Bunun d���nda bir adet")
			say("Eskrim Bro��r� ve iki adet Kutsama Par��meni")
			say("laz�m. Daha sonra sana destans� bir k�l�� yapmaya")
			say("�al��aca��m.")
			say("")
			say("")
			say("��e yarayaca��n� garanti edebilirim.")
		end

          when 20354.click begin
            say_title("�ehir Bek�isi:")
            say("Sessiz ve disiplinli ol. Kendine hakim ol.")
            say("Herhangi bir sorun ba�latma. Yolda�lar�na sayg�l� ")
            say("olmay� ��renmelisin. Anlad�n m�? ")
            say("")
        end
        when 20008.chat."Mmm, buras� harika kokuyor..." begin
            say_title("Restoran sahibi Octavio:")
            say("")
            say("Ho�geldin! Restoran�m�z uluslar aras� bir zincirin")
            say("par�as�d�r. Gel ve bizi bir dene.")
            say("i�eri gelin ve bizi deneyin.")
            say("")

            if math.random(2) == 1 then
                wait()
                say_title(""..pc.get_name()..":")
                say("")
                say("B�y�k bir restoran i�in, dekor")
                say("�a��rt�c� derecede basit.")
                say("")
            end
        end
        when 20005.chat."Bana ��mlek�ilik hakk�nda bir �eyler anlat." begin
            say_title("��mlek�i Yonah:")
            say("��mlek�ili�i seviyorum. Ellerinle �amuru ")
            say("�ekillendirmek ve bir �ey yaratmak �ok tatmin")
            say("edici... Genelde basit �eyler yap�yorum.")
            say("Do�udaki da�lar�n eteklerinde y�ntemler �ok ")
            say("daha geli�mi�. Bir defas�nda, orada baz� ")
            say("��mlek�iler g�rm�� ve �ok etkilenmi�tim. ")
            say("Zaman�m oldu�unda deneyler yap�yorum. Ama hala")
			say("ustal�klar�n� ��zemedim. ")
        end
		when 20005.chat."Ya��na g�re �ok hayat dolusun..." begin
            say_title("��mlek�i Yonah:")
            say("Ben ger�ekten ya�l� bir adam�m ancak hala")
            say("sa�l�kl� ve dincim. ��nk� s�rr�m var.")
            say("Gango K�k� Suyu ve Tue Mantar�ndan yap�lan ")
            say("�m�r uzat�c� bir kar���m buldum. E�er bu")
            say("kar���mdan istersen, malzemeleri Yu-Hwan'a ")
            say("g�t�rmelisin, senin i�in o iksiri yapacakt�r. ")
            say("")
			say("")
        end
        when 20017.chat."Git, onu da�lara s�yle... " begin
            say_title("M�zisyen Yu-Hwan:")
            say("")
            say("...Tepelere ve her yere...")
            say("Sen de m�zi�i sever misin? Burada her t�r ")
            say("par�ay� s�ylerim, sava�a ")
            say("dahil olmuyorum.Ancak e�er �lkem beni")
            say("korumazsa, sevdi�im bu i�i yapmaya devam")
            say("edemem.")
        end
        when 20023.chat."Neden bu kadar �ok okuyorsun? " begin
            say_title("Soon:")
            say("")
            say("Ah, Macerac�.D�nya sorunlarla dolu ve tek")
            say("kurtulu� yolu bilgi. Her zaman kitaplar�na sayg� ")
            say("g�stermelisin. Onlar sana k�t� zamanlarda yard�m ")
            say("ederler. �nan bana!")
            say("")
            say("")
        end
		when 20023.chat."�ocuklar�n var m�? " begin
            say_title("Soon:")
            say("Asl�nda hi� �ocuk istemiyordum, ancak... Sihir")
            say("enerjimi artt�rmak i�in Kaki �i�ekleri ")
            say("toplay�p do�ru �ekilde haz�rl�yorum. Bunu")
            say("Baek-Go buldu. 100 adet iksir yapmak i�in bir")
            say("tane �i�e�e ihtiyac�n var. Ancak Kaki")
            say("�i�e�inin bir de yan etkisi var. E�er bir")
            say("kad�n bu �i�ekten yap�lm�� bir kolye")
			say("takarsa k�sa zamanda o�lu olur. Aram�zda ")
			say("kals�n, kar�m utanmazca kulland� bunu.")
		end

        when 20020.chat."Siyah R�zgar �etesi'nin bir kurban� " begin
            say_title("Hain Balso:")
            say("D�kkatli ol! �u anda Siyah R�zgar Grubu")
            say("sava���lar� g�z a�t�rm�yor. En iyisi bu g�revi")
            say("ertelemek olacak. Ho��akal...")
            say("")
                wait()
                say_title("Bilgi:")
                say_reward("Siyah R�zgar Grubu'nun S�rr� - g�revi")
                say_reward("�u anda hen�z haz�r de�il...")
                say("")
                say("")
            end
		 when 20020.chat."Neden insanlar sana hain diyor?" begin
            say_title("Hain Balso:")
            say("Bir sava�tan ka�t�m ve Siyah R�zgar �etesine")
            say("kat�ld�m. Yolda�lar�m bu y�zden beni asla")
            say("affetmiyorlar. Sonradan Siyah R�zgar �etesinin")
            say("masum insanlar� �ld�rd���n� anlad�m ve")
            say("hemen onlar� terk ettim. Korkun�tu! ")
            say("")
		if math.random(2) == 1 then
                wait()
			say_pc_name()
			say("Masum insanlar�n vebalini mi ta��yorsun?")
			say("�yleyse ismini ger�ekten hak ediyorsun. Onlar� ")
			say("g�zel bir hayattan kopartm��s�n. ")
				wait()
			say_title("Hain Balso:")
			say("Buras� adaletsiz bir d�nya. Ama art�k asla")
			say("k�t� bir �ey yapmayaca��m. ")
			say("�nsanlar�n beni hain olarak �a��rmas�n� ")
			say("istemiyorum.")
			say("Bana biraz Yang verebilir misin?")
        end
		end
		when 20020.chat."Bu kadar yara izi nas�l oldu?" begin
            say_title("Hain Balso:")
            say("�ok iyi bir sava��� de�ilim ve sava�larda")
            say("�ok s�k yaralan�r�m. D�v��lerde ")
            say("yaraland�ktan sonra Yu-Hwan'a beni yaralardan")
            say("korumas� i�in bir iksir yapmas�n� ")
			say("s�ylemi�tim. Bana �an �i�e�i ve Leylaktan")
			say("olu�an bir iksir yapt� anca pek i�e ")
			say("yaramad�. Belki de benim beceriksizli�im. Senin")
			say("i�ine yarayacakt�r.")
			say("")
			end

        when 20011.chat."Sana neden bilge diyorlar?" begin
            say_title("Bilge Uriel:")
            say("")
            say("Bu engin d�nyada ��renecek �ok �ey var. Cehalet")
            say("ve silahl� kuvvetleri birle�tirmek �ok berbat bir")
            say("kar���m. Cahil askerlerle ya�amak istemiyorsun")
			say("de�il mi? Bilgelik g��t�r!")
            say("")
        end

        when 20018.chat."Kaynaklar�m senin ila� yapt���n� s�yledi. " begin
            say_title("Baek-Go:")
            say("Elimden geleni yap�yorum. Bu tehlikeli d�nyada")
            say("bir �ok insan her g�n yaralan�yor. Bizim o")
            say("kadar ila� ve doktorumuz yok. Zaman �ok zor!")
            say("Bana daha sonra yard�m edebilir misin?")
            say("")
        end

        when 20019.chat."Av i�leri nas�l gidiyor?" begin
            say_title("Avc� Yang-Shin:")
            say("")
            say("Hmm, Metin Ta�lar�n�n d��mesiyle birlikte")
            say("hayvanlar vah�ile�ti. Bug�nlerdei tavuk")
            say("avlamak bile seni �ld�rebilir. Avc�lar�n i�i ")
            say("�ok zor. Neyse ki ben en iyilerden biriyim!")
            say("")
        end
		when 20019.chat."Bu dikkatini neye bor�lusun? " begin
            say_title("Avci Yang-Shin:")
            say("Ben ba�ar�l� bir ok�uyum ��nk� ")
            say("�an �i�e�i Suyu ve Leylak kar��t�r�rsan elde")
            say("edece�in iksir senin ni�an alma kabiliyetini")
            say("inan�lmaz art�r�r. E�er bu sayd�klar�m� ")
            say("Yu-Hwan'a g�t�r�rsen senin i�in iksiri")
            say("yapacakt�r.")
        end
		
		 when 20006.chat."Ne g�zel bir �i�ek tac�... " begin
            say_title("Mirine:")
            say("Ben karde�imle birlikte �eftali �i�e�i ")
            say("topluyorum. Ama bug�n yaln�zd�m. �ok g�zel")
            say("de�iller ama �zel etkileri var. E�er sen")
            say("de onlardan birini al�p ")
			say("Baek-Go'ya g�t�rebilirsen, seni")
			say("�evikle�tirecek bir iksir yapabilir.")
        end
        when 20006.chat."Karde�in nerede?" begin
            say_title("Mirine:")
            say("Bug�nlerde karde�im �ok seyahat ediyor, onu")
            say("art�k g�remiyorum ve endi�eleniyorum...")
            say("")
        end

        when 20012.chat."Pirin� pastas� m� sat�yorsun?" begin
            say_title("Pirin� hamuru sat�c�s� Yu-Rang:")
            say("Sava� y�z�nden, pirin� hamuru satmak �ok")
            say("zorla�t�. Haydutlara �ok te�ekk�r etmek laz�m,")
            say("sayelerinde b�t�n m��terilerimi kaybettim. Sadece")
            say("art�k hayat�m� s�rd�rebilmek i�in ne yapaca��m� ")
            say("bilmiyorum.")
        end
		
		when 20012.chat."Senden kimler al��veri� yap�yor?" begin
            say_title("Pirin� hamuru sat�c�s� Yu-Rang:")
            say("Pastalar�m�n �o�unu seyyahlara sat�yorum.")
			say("Bir g�n, gizemli bir s�vari")
			say("geldi ve benden pirin� pastas� almak")
			say("istedi�ini s�yledi. Fakat bana para yerine Zin")
			say("Suyunun re�etesini verdi. Bu iksir sald�r� g�c�n� ")
			say("artt�rabiliyormu�.")
			say("Re�eteyi Huahn-So'ya satt�m. Ona")
			say("Sim-suyu ve Alp g�l� ")
			say("g�t�r�rsen senin i�in Zin Suyu yapabilir.")
        end

        when 20021.chat."Neden bu kadar �zg�ns�n?" begin
            say_title("Ariyoung:")
            say("Yeni evli �ift olarak tatl� r�yalar�m�z�n")
            say("merhametsizce parampar�a edilece�ini bilmeliydim.")
            say("�h�, �h�...l�tfen bu cinayetin intikam�n� al.")
            say("")
        end
		when 20021.chat."Sava�ta �ok ki�i �ld�..." begin
            say_title("Ariyoung:")
            say("Sava�ta bir�ok adam kaybettik, biz kad�nlar")
            say("olarak topland�k ve Huahn-So'dan savunmam�z� ")
            say("g��lendirecek olan Dok-suyunu geli�tirmesini")
            say("istedik. Uzun ara�t�rmalardan")
			say("sonra, e�er Dok-suyuna Alp G�l� eklenirse �ok ")
			say("daha g��l� olaca��n� buldu. Kendisine git, o")
			say("Sambo-suyu yapabiliyor. Gerekli �eyleri g�t�rmeyi")
			say("de unutma.")
        end
		when 20003.chat."Ah, ne �irin bir �ocuk..." begin
            say_title("Ah-Yu:")
			say("Bir kez daha ���l�k at�yor... Ne istedi�ini")
			say("��zemiyorum. �eker falan m� acaba... Ahh hay�r!")
			say("")
			end
		when 20003.chat."Siz ikiniz kimsiniz?" begin
            say_title("Ah-Yu:")
            say("Evlad�m! Kocam sava�ta d��t�, art�k ben kendime")
            say("bakmak zorunday�m.Art�k �ocu�uma ve kendime ben")
            say("bakmaya �al���yorum. Bo-suyu ile hayat�m� ")
			say("geli�tirebilece�imi ��rendim. Yu-Hwan'a 100")
			say("Kaki �i�e�i Suyu ve Tue Mantar� g�t�rmeliyim ki")
			say("bana ondan yaps�n. ")
			say("�imdi bir �ekilde bu malzemeleri bulmal�y�m...")
			say("")
        end
        when 20002.chat."Senin kocan kim?" begin
            say_title("Aranyo:")
            say("")
            say("Benim kocam olacak adam, kitaplar�yla evli. O")
            say("art�k benimle ilgilenmiyor. Ama ben �irkin bir")
            say("kad�n de�ilim. ")
            say("")
        end
        when 20010.chat."��ler nas�l?" begin
            say_title("Seyyar Sat�c�:")
            say("")
            say("Savas ba�lad���ndan beri i�lerim")
            say("�ok k�t� gitmeye ba�lad�. ")
            say("Daha �nceleri t�ccarlar birli�i ")
            say("�ok g��l�yd�, fakat �imdi her �ey ")
            say("tersine d�nd�. Vah�i hayvanlara,")
            say("Savas��lara ve Siyah R�zgar �etesine")
            say("daha fazla ald�rmamazl�k edemiyoruz.")
            say("Sanki bizi kullan�yorlar...")
        end
        when 20014.chat."Neden moralin bozuk?" begin
            say_title("Taurean:")
            say("")
            say("Harang k�t� bir k�z! Ondan nefret ediyorum! Ben")
            say("zay�f�m ve o hep bana �at�yor!")
            say("")
        end
        when 20024.chat."�u anda ne yap�yorsun?" begin
            say_title("Harang:")
            say("Taurean'� bekliyorum.Beraber oyun oynar�z ve")
            say("�ok da kavga ederiz. Ne korkak ama! E�er kendi")
            say("iste�iyle gelmezse onu �ok fena yapaca��m! ")
            say("")
        end
		when 20024.chat."Taurean senden korkuyor." begin
            say_title("Harang:")
            say("Taurean benden daha g��l�. Bu y�zden onu")
            say("yenmek i�in bir yol d���nd�m. Beyaz bir")
            say("Ninja Y�ng Suyu ile Dutu kar��t�r�rsam")
            say("sald�r� h�z�m�n artaca��n� s�yledi.")
			say("Sonunda Taurean'� yenebilece�im! E�er sen de")
			say("h�zl� sald�rmak istiyorsan, malzemeleri")
			say("Huahn-So'ya g�t�r. Sana iksir yapacakt�r.")
        end
		when 20015.chat."�ok g��l� g�r�n�yorsun..." begin
            say_title("Oduncu Deokbae:")
            say("Y�llardan beridir, g�c�m�z�n s�rr� ailemiz i�in ")
            say("nesilden nesile ge�er. Babam bana demi�ti ki,")
            say("e�er �an �i�e�ini do�ru �ekilde kar��t�r�rsan")
            say("sana g�� verecek bir iksir yapabilirsin. Bildi�im ")
			say("kadar�yla Baek_go bu iksiri yapabiliyor. Tek")
			say("ihtiyac�m ona �an �i�e�i ")
			say("g�t�rmek.")
			say("")
        end
		when 20086.chat."Aya��na ne oldu?" begin
			say_title("Handu-Up:")
			say("")
			say("�yile�iyor. Y�r�rken bir Gango K�k�ne")
			say("tak�ld�m ve aya��m burkuldu. Neyseki doktor")
			say("Baek-Go'yu tan�yorum, beni muayene etti ve bir")
			say("tavsiye verdi: K���k yaralar� iyile�tirmek")
			say("i�in Gango K�k� suyu kullanabilirmi�im.")
			say("B�ylece su�lu k�kleri �aya kar��t�rd�m ve")
			say("yol a�t�klar� ac�y� dindirdiler...")
			say("")
			end
		when 20087.chat."Sen kimsin?" begin
			say_title("Wonda-Rim:")
			say("")
			say("Ben Wonda-Rim, Chaegirab'�n ye�eniyim. Amcam")
			say("�ok me�hur! Onu tan�yor musun? Bir �ok iksiri")
			say("ve bitkiyi ara�t�r�yor. Ara�t�rmalar� ")
			say("s�ras�nda 100 Bo suyu")
			say("ile Dutu kar��t�r�nca b�y�l� enerjilere")
			say("kar�� �ok g��l� bir savunma elde ettiren")
			say("bir iksir bulmay� ba�ard�. Bildi�im")
			say("kadar�yla bu iksiri Huahn-So yapabiliyor.")
			say("Kendisine gereken malzemeleri g�t�r.")
			say("")
			end
		end
	end
	
