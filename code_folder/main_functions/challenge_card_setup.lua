--CONSUMABLE SETUP--
--------------------
--CONSUMABLE SETUP--

SMODS.ConsumableType {
    key = 'inin_Compete',
    default = 'c_inin_ufo_rescue',
    primary_colour = G.C.ININ.SET.Challenge,
    secondary_colour = G.C.ININ.SECONDARY_SET.Challenge,
    collection_rows = { 6, 6 },
    shop_rate = 2
}

SMODS.Atlas {
    key = 'inin_compete',
    path = 'c_ufo_rescue.png',
    px = 71,
    py = 95
}

InanimateInsanity.inin_ElimChallenge = SMODS.Consumable:extend{
    atlas = 'inin_compete',
    set = 'inin_Compete',
    unlocked = true,
    discovered = true,

    -- Return elimination amount
    loc_vars = function(self, info_queue, card)

        -- Elimination info tooltip
        info_queue[#info_queue+1] = { set = "Other", key = "inin_elim_info" }

        -- Return elimination variables
        return {
            vars = {
                card.ability.extra.eliminations,
                (card.ability.extra.eliminations == 1 and "") or (card.ability.extra.eliminations ~= 1 and "s"),
                (card.ability.extra.randchoice and "random") or (not card.ability.extra.randchoice and "selected"),
            }
        }
    end,

    -- Elimination function
    eliminate = function(self, card, area, copier, pool)


        --RANDOM CHOICE--
        -----------------
        --RANDOM CHOICE--

        if card.ability.extra.randchoice then

            
            -- Set up return values
            local ret_votes = {}
            local ret_vote_types = {}
            local ret_voters = {}
            local vote_exclusions = {}
            local tie_count = 0

            -- Set up post_vote_info
            local post_vote_info = { {  } }

            -- Check if first element is included in second element, returns false if it is, true if it's not
            local check_table = function(to_check, overall)
                for _, check1 in pairs(overall) do
                    if check1 == to_check then
                        return false
                    end
                end
                return true
            end

            -- Find vote type
            local find_vote_type = function(vote_for)
                for i, vote_type in ipairs(ret_vote_types) do
                    if vote_type == vote_for then
                        return i
                    end
                end
                local new_num = #ret_vote_types + 1
                ret_vote_types[new_num] = vote_for
                ret_votes[new_num] = 0
                return new_num
            end

            -- Find who voted for a specific Joker
            local find_voter = function(to_find)

                -- Set up return table
                local ret_table = {}
                
                -- Cycle through all votes
                for _, single_voter in pairs(ret_voters) do
                    if single_voter.voted_for == to_find then
                        ret_table[#ret_table+1] = single_voter.voter
                    end
                end

                -- Return
                return ret_table
            end

            -- Assign a vote to each joker
            local get_votes = function(joker_table, tie_immunes)

                -- Reset return values (Why didn't I put them here in the first place???? Well now I depend on them being outside of this and I don't feel like fixing it so. sure lol)
                ret_votes = {}
                ret_vote_types = {}
                ret_voters = {}

                -- Loop through all Jokers up for elimination
                for _, joker_vote in pairs(joker_table) do
                    if check_table(joker_vote, vote_exclusions) and check_table(joker_vote, G.GAME.EliminatedJokers) then

                        -- Jokers cannot vote for immune Jokers or themselves
                        local immune = SMODS.shallow_copy(G.GAME.ImmuneJokers)
                        immune[#immune+1] = joker_vote

                        -- In a tie, only certain Jokers can be voted for. All others are immune
                        if #tie_immunes > 0 then
                            for _, extra_immune in pairs(tie_immunes) do
                                immune[#immune+1] = extra_immune
                            end
                        end

                        -- All Jokers currently owned are immune
                        if #G.jokers.cards > 0 then
                            for i = 1, #G.jokers.cards do
                                immune[#immune+1] = G.jokers.cards[i].config.center.key
                            end
                        end
                        
                        -- Remove immune Jokers from voting table
                        local possible_votes = {}
                        for _, cur_card in pairs(joker_table) do
                            if check_table(cur_card, immune) and check_table(cur_card, G.GAME.EliminatedJokers) then
                                possible_votes[#possible_votes+1] = cur_card
                            end
                        end


                        -- Cast vote
                        local vote_for

                        if #possible_votes > 0 then
                            -- Get random Joker to vote for
                            vote_for = pseudorandom_element(possible_votes, "inin_" .. joker_vote .. card.config.center.key)
                        else
                            -- Vote for yourself if you are the only option
                            vote_for = joker_vote
                        end

                        -- Print vote (Debug only)
                        print(joker_vote .. " has voted for " .. vote_for .. "!")

                        -- Add vote to Return table
                        local vote_type = find_vote_type(vote_for)
                        ret_votes[vote_type] = ret_votes[vote_type] + 1
                        ret_voters[#ret_voters+1] = { voter = joker_vote, voted_for = vote_for }
                        
                    else
                        
                        -- Print exclusion (Debug only)
                        print(joker_vote .. " was not allowed to vote!")

                    end
                end

                -- Return vote counts
                if ret_votes then
                    return { ret_votes, ret_vote_types }
                else
                    return nil
                end

            end

            -- Check if there is a pool to use
            if pool then
                
                -- Set up voting
                local vote_done = false
                local tie_immunity = {}
                local tie_start = 1
                local pre_tie_start = 1
                local tie_mod1 = {}
                local tie_mod2 = {}
                
                -- Repeat until the vote is actually finished
                while not vote_done do

                    local vote_info = get_votes(pool, tie_immunity)
                    local max_votes = SMODS.shallow_copy(tie_mod1)
                    local max_votes_keys = SMODS.shallow_copy(tie_mod2)
                    local pos_exclude = {}
                    local tie_vars = {}
                    local cur_tie = 0
                    local tie = false

                    if vote_info then
                        for i = tie_start, card.ability.extra.eliminations do

                            -- Set max votes
                            max_votes[i] = 0

                            -- Iterate through given votes
                            for i2, vote in ipairs(vote_info[1]) do

                                -- Check that position is not used
                                if check_table(i2, pos_exclude) then

                                    -- Get vote count and do things n stuff idk lol
                                    if max_votes[i] < vote then

                                        -- Vote is greater than current max vote
                                        max_votes[i] = vote
                                        max_votes_keys[i] = vote_info[2][i2]
                                        pos_exclude[i] = i2
                                        tie = false

                                    elseif max_votes[i] == vote and check_table(vote_info[2][i2], tie_vars) then

                                        -- There is a tie, reset tie_vars if it's a new tie, and add the new key to tie_vars
                                        tie = true
                                        if vote ~= cur_tie then
                                            tie_vars = {}
                                            tie_vars[1] = max_votes_keys[i]
                                        end
                                        tie_vars[#tie_vars+1] = vote_info[2][i2]
                                        cur_tie = vote

                                    end

                                end

                            end
                        end

                        -- Tie check
                        if tie and tie_count < 3 then

                            print("There has been a tie! Time for a revote!")
                            print(tie_vars)
                            print(vote_info[1])

                            -- Cycle through max_votes_keys BACKWARDS to ensure that all tied Jokers are within tie_vars
                            local absolute_tie = max_votes[#max_votes]
                            for i = #max_votes_keys, 1, -1 do
                                if absolute_tie ~= max_votes[i] then
                                    break
                                else
                                    if check_table(max_votes_keys[i], tie_vars) then
                                        tie_vars[#tie_vars+1] = max_votes_keys[i]
                                    end
                                end
                            end

                            -- Check if tie was only in the lower portion of the eliminations
                            for i = tie_start, #max_votes do
                                if max_votes[i+1] and max_votes[i+1] < max_votes[i] then
                                    tie_start = i+1
                                    for i2 = pre_tie_start, tie_start - 1 do
                                        tie_mod1[i2] = max_votes[i2]
                                        tie_mod2[i2] = max_votes_keys[i2]

                                        post_vote_info[i2 + 1] = {
                                            eliminated = max_votes_keys[i2],
                                            vote_count = max_votes[i2],
                                            voters = find_voter(max_votes_keys[i2]),
                                            round = tie_count
                                        }

                                        print(max_votes_keys[i2] .. " has been eliminated with " .. max_votes[i2] .. " votes!")
                                        G.GAME.EliminatedJokers[#G.GAME.EliminatedJokers+1] = max_votes_keys[i2]
                                    end
                                    pre_tie_start = tie_start
                                end
                            end

                            -- Increment tie count
                            tie_count = tie_count + 1
                            
                            -- Exclude Jokers included in tie from voting if not every Joker tied
                            if #tie_vars < #ret_voters then
                                vote_exclusions = SMODS.shallow_copy(tie_vars)
                                tie_immunity = {}
                                for _, immunity_obj in pairs(pool) do
                                    if check_table(immunity_obj, vote_exclusions) then
                                        tie_immunity[#tie_immunity+1] = immunity_obj
                                    end
                                end
                            end

                        else
                            
                            -- Eliminate Jokers
                            for i = tie_start, #max_votes_keys do

                                post_vote_info[i + 1] = {
                                    eliminated = max_votes_keys[i],
                                    vote_count = max_votes[i],
                                    voters = find_voter(max_votes_keys[i]),
                                    round = tie_count
                                }
                                
                                print(max_votes_keys[i] .. " has been eliminated with " .. max_votes[i] .. " votes!")
                                G.GAME.EliminatedJokers[#G.GAME.EliminatedJokers+1] = max_votes_keys[i]
                            end
                            vote_done = true

                        end

                        -- Update post_vote_info[1]
                        post_vote_info[1][#post_vote_info[1]+1] = {
                            vote_numbers = SMODS.shallow_copy(max_votes),
                            vote_victims = SMODS.shallow_copy(max_votes_keys),
                            tie_victims = SMODS.shallow_copy(tie_vars)
                        }

                    else
                        print("nothing to see here!")
                        vote_done = true
                    end

                end

                print(post_vote_info)

            end
        end

    end,
}