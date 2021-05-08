quest check_trans_ticket begin
	state start begin
		when login or levelup with pc.level >0 begin
			set_state(zone_enter)
		end
	end
		
	state zone_enter begin

		-- Entrance to "Spinnendungeon"

		when 20088.chat.gameforge.check_trans_ticket._10_npcChat begin
			say_title(gameforge.check_trans_ticket._15_sayTitle)
			say(gameforge.check_trans_ticket._20_say)
			wait()
			if pc.count_item(71095) + pc.count_item(71130) > 0 then
				say_title(gameforge.check_trans_ticket._15_sayTitle)
				say(gameforge.check_trans_ticket._30_say)
				wait()
				if false == pc.can_warp() then
					say(gameforge.check_trans_ticket._160_say)
					return
				end
				if pc.count_item(71095) + pc.count_item(71130) > 0 then
					if pc.count_item(71130) >= 1 then -- player get item from mystery box
						pc.remove_item(71130, 1) -- remove this one
					elseif pc.count_item(71095) >= 1 then
						pc.remove_item(71095, 1) -- remove the ItemShop item
					else
						return -- This can only happen as a result of cheating
					end
					pc.warp(704100, 464100)
				else
					return
				end
			else
				say_title(gameforge.check_trans_ticket._15_sayTitle)
				say(gameforge.check_trans_ticket._40_say)
				wait()
			end	
		end

		-- Entrance to "Grotte der Verbannung"

		when 20093.chat.gameforge.check_trans_ticket._50_npcChat begin
			say(gameforge.check_trans_ticket._55_sayTitle)
			-- inhalt f�r Schl�ssel "gameforge.check_trans_ticket._60_say":
			say(gameforge.check_trans_ticket._60_say) 
			if pc.get_level() < 75 then
				-- inhalt f�r Schl�ssel "gameforge.check_trans_ticket._70_say":
				say_reward(gameforge.check_trans_ticket._70_say)
				return 
			elseif pc.count_item(30190) + pc.count_item(30191) == 0 then
				local get_bloodstone = select(gameforge.check_trans_ticket._75_1_select, gameforge.check_trans_ticket._75_2_select)
				if get_bloodstone == 1 then
					-- inhalt f�r Schl�ssel "gameforge.check_trans_ticket._80_say":
					say_title(gameforge.check_trans_ticket._55_sayTitle)
					say(gameforge.check_trans_ticket._80_say)
					say(gameforge.check_trans_ticket._90_say_reward)
					say_reward(gameforge.check_trans_ticket._100_say)
				else
					say_title(gameforge.check_trans_ticket._55_sayTitle)
					say(gameforge.check_trans_ticket._110_say)
					say(gameforge.check_trans_ticket._90_say_reward)
					say_reward(gameforge.check_trans_ticket._120_say)
				end
			elseif pc.count_item(30190) + pc.count_item(30191) > 0 then
				local get_bloodstone = select(gameforge.check_trans_ticket._130_1_select, gameforge.check_trans_ticket._130_2_select)
									
				if false == pc.can_warp() then
					say(gameforge.check_trans_ticket._160_say)
					return
				end

				if get_bloodstone == 1 then
					say_pc_name()
					say(string.format(gameforge.check_trans_ticket._140_say, pc.get_name()))
					if pc.count_item(30190) >= 1 then -- when character has Bloodstones from ItemShop and some from keyquest remove the ones from the keyquest first
						pc.remove_item(30190, 1) -- remove keyquest bloodstone first
					elseif pc.count_item(30191) >= 1 then
						pc.remove_item(30191, 1) -- remove ItemShop bloodstone
					else
						return -- This can only happen as a result of cheating
					end
					wait()
					say_title(gameforge.check_trans_ticket._55_sayTitle)
					say(gameforge.check_trans_ticket._150_say)
					wait()
					pc.warp(900,1207800)
				end
			else
				--notice("This shouldn't happen!") -- debug message 
			end
		end
	end --state
end  --quest
