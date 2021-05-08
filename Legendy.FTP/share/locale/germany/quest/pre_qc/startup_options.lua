quest basic_weapon begin
	state start begin
		when login with pc.getqf("basic_weapon") == 0 begin
			local krallik = { " Shinsoo " , " Chunjo " , " Jinno " }
			local karakter = {" Savaþçý ", " Ninja ", " Sura ", " Þaman ", " Lycan "}
			if pc.getqf("hosgeldinsnck") == 0 then
				pc.setqf("hosgeldinsnck", 1)
				if pc.job == 0 then
				notice_all("Yeni oyuncumuz "..pc.get_name()..","..karakter[pc.get_job()+1].."karakteri ile"..krallik[pc.get_empire()].."imparatorluðuna katýldý!")
				end

				if pc.job == 1 then
				notice_all("Yeni oyuncumuz "..pc.get_name()..","..karakter[pc.get_job()+1].."karakteri ile"..krallik[pc.get_empire()].."imparatorluðuna katýldý!")

				end
				if pc.job == 2 then
				notice_all("Yeni oyuncumuz "..pc.get_name()..","..karakter[pc.get_job()+1].."karakteri ile"..krallik[pc.get_empire()].."imparatorluðuna katýldý!")

				end
				if pc.job == 3 then
				notice_all("Yeni oyuncumuz "..pc.get_name()..","..karakter[pc.get_job()+1].."karakteri ile"..krallik[pc.get_empire()].."imparatorluðuna katýldý!")

				end
				if pc.job == 4 then
				notice_all("Yeni oyuncumuz "..pc.get_name()..","..karakter[pc.get_job()+1].."karakteri ile"..krallik[pc.get_empire()].."imparatorluðuna katýldý!")

				end
			end
			if pc.get_job() == 0 then
				local silah = 19
				local zirh = 11209
				local kask = 12209
				local kalkan = 13009
				local bilezik = 14009
				local papuc = 15009
				local kolye = 16009
				local kupe = 17009
				local ruzgar = 72702
				pc.give_item2_select(silah)
				pc.give_item2_select(zirh)
				pc.give_item2_select(kask)
				pc.give_item2_select(kalkan)
				pc.give_item2_select(bilezik)
				pc.give_item2_select(papuc)
				pc.give_item2_select(kolye)
				pc.give_item2_select(kupe)
				pc.give_item2_select(ruzgar)
				local ruzgar = 72702
			elseif pc.get_job() == 1 then
				local silah = 1009
				local zirh = 11409
				local kask = 12349
				local kalkan = 13009
				local bilezik = 14009
				local papuc = 15009
				local kolye = 16009
				local kupe = 17009
				local ok = 79504
				local ruzgar = 72702
				pc.give_item2_select(silah)
				pc.give_item2_select(zirh)
				pc.give_item2_select(kask)
				pc.give_item2_select(kalkan)
				pc.give_item2_select(bilezik)
				pc.give_item2_select(papuc)
				pc.give_item2_select(kolye)
				pc.give_item2_select(kupe)
				pc.give_item2_select(ok)
				pc.give_item2_select(ruzgar)
			elseif pc.get_job() == 2 then
				local silah = 19
				local zirh = 11609
				local kask = 12489
				local kalkan = 13009
				local bilezik = 14009
				local papuc = 15009
				local kolye = 16009
				local kupe = 17009
				local ruzgar = 72702
				pc.give_item2_select(silah)
				pc.give_item2_select(zirh)
				pc.give_item2_select(kask)
				pc.give_item2_select(kalkan)
				pc.give_item2_select(bilezik)
				pc.give_item2_select(papuc)
				pc.give_item2_select(kolye)
				pc.give_item2_select(kupe)
				pc.give_item2_select(ruzgar)
			elseif pc.get_job() == 3 then
				local silah = 7009
				local zirh = 11809
				local kask = 12629
				local kalkan = 13009
				local bilezik = 14009
				local papuc = 15009
				local kolye = 16009
				local kupe = 17009
				local ruzgar = 72702
				pc.give_item2_select(silah)
				pc.give_item2_select(zirh)
				pc.give_item2_select(kask)
				pc.give_item2_select(kalkan)
				pc.give_item2_select(bilezik)
				pc.give_item2_select(papuc)
				pc.give_item2_select(kolye)
				pc.give_item2_select(kupe)
				pc.give_item2_select(ruzgar)
			elseif pc.get_job() == 4 then
				local silah = 6009
				local zirh = 21009
				local kask = 21509
				local kalkan = 13009
				local bilezik = 14009
				local papuc = 15009
				local kolye = 16009
				local kupe = 17009
				local ruzgar = 72702
				pc.give_item2_select(silah)
				pc.give_item2_select(zirh)
				pc.give_item2_select(kask)
				pc.give_item2_select(kalkan)
				pc.give_item2_select(bilezik)
				pc.give_item2_select(papuc)
				pc.give_item2_select(kolye)
				pc.give_item2_select(kupe)
				pc.give_item2_select(ruzgar)
			end
			local para = 120000
			pc.give_gold(para)
			pc.give_item2("50053",1)
			pc.give_item2("70038",1)
			pc.give_item2("27102",1)
			pc.give_item2("27105",1)
			pc.give_item2("72726",1)
			pc.give_item2("72730",1)
			horse.set_level(21)
			pc.set_skill_level (137,20)
			pc.set_skill_level (138,20)
			pc.set_skill_level (139,20)
			pc.set_skill_level (131,10)
			pc.set_skill_level (129,40)
			pc.set_skill_level (128,20)
			pc.set_skill_level (127,20)
			pc.set_skill_level (126,20)
			pc.set_skill_level (124,40)
			pc.set_skill_level (121,40)
			pc.set_skill_level (122,2)
			pc.setqf("basic_weapon",1)
		end
	end
end