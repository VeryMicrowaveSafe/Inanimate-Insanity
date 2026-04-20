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
        return {
            vars = {
                card.ability.extra.eliminations,
                (card.ability.extra.eliminations == 1 and "") or (card.ability.extra.eliminations ~= 1 and "s"),
                (card.ability.extra.randchoice and "random") or (not card.ability.extra.randchoice and "selected"),
                (card.ability.extra.qualifier and (card.ability.extra.qualifier_c .. card.ability.extra.qualifier .. "{} ")) or (not card.ability.extra.qualifier and "")
            }
        }
    end,

    -- Elimination function
    eliminate = function(self, card, area, copier)


        --RANDOM CHOICE--
        -----------------
        --RANDOM CHOICE--

        if card.ability.extra.randchoice then
            
            -- Set up return values
            local ret_votes = {}
            local ret_vote_types = {}
            local vote_exclusions = {}

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

            -- Assign a vote to each joker
            local get_votes = function(joker_table, tie_immunes)
                for _, joker_vote in pairs(joker_table) do
                    if check_table(joker_vote, vote_exclusions) and check_table(joker_vote, G.GAME.EliminatedJokers) then

                        -- Jokers cannot vote for immune Jokers or themselves
                        local immune = SMODS.shallow_copy(G.GAME.ImmuneJokers)
                        immune[#immune+1] = joker_vote

                        -- In a tie, only certain Jokers can be voted for. All others are immune
                        if tie_immunes ~= {} then
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

                        if #possible_votes > 0 then

                            -- Cast Joker vote
                            local vote_for = pseudorandom_element(possible_votes, "inin_" .. joker_vote .. card.config.center.key)

                            -- Print vote (Debug only)
                            print(joker_vote .. " has voted for " .. vote_for .. "!")

                            -- Add vote to Return table
                            local vote_type = find_vote_type(vote_for)
                            ret_votes[vote_type] = ret_votes[vote_type] + 1

                        end
                        
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

            -- Check if there is an attribute to use, then get votes
            if card.ability.extra.qualifier_a then
                
                -- Set up voting
                local vote_done = false
                local tie_immunity = {}

                -- Repeat until the vote is actually finished
                while not vote_done do

                    local vote_info = get_votes(SMODS.get_attribute_pool(card.ability.extra.qualifier_a), tie_immunity)
                    local max_votes = {}
                    local max_votes_keys = {}
                    local pos_exclude = {}
                    local tie_vars = {}
                    local cur_tie = 0
                    local tie = false

                    if vote_info then
                        for i = 1, card.ability.extra.eliminations do

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

                                    elseif max_votes[i] == vote then

                                        -- There is a tie, reset tie_vars if it's a new tie, and add the new key to tie_vars
                                        tie = true
                                        if vote ~= cur_tie then tie_vars = { max_votes_keys[i] } end
                                        tie_vars[#tie_vars+1] = vote_info[2][i2]
                                        cur_tie = vote

                                    end

                                end

                            end
                        end

                        -- Get total votes
                        local total_votes = 0
                        for _, vote_count in pairs(vote_info[1]) do
                            total_votes = total_votes + vote_count
                        end

                        -- Tie check
                        if tie and total_votes > math.max(card.ability.extra.eliminations, 2) then

                            print("There has been a tie! Time for a revote!")
                            print(tie_vars)
                            
                            -- Exclude Jokers included in tie from voting
                            vote_exclusions = tie_vars
                            tie_immunity = {}
                            for _, immunity_obj in pairs(SMODS.get_attribute_pool(card.ability.extra.qualifier_a)) do
                                if check_table(immunity_obj, vote_exclusions) then
                                    tie_immunity[#tie_immunity+1] = immunity_obj
                                end
                            end

                        else
                            
                            -- Eliminate Jokers
                            for i, elimination in ipairs(max_votes_keys) do
                                print(elimination .. " has been eliminated with " .. max_votes[i] .. " votes!")
                                G.GAME.EliminatedJokers[#G.GAME.EliminatedJokers+1] = elimination
                            end
                            vote_done = true

                        end

                    else
                        print("nothing to see here!")
                        vote_done = true
                    end

                end

            else

            end
        end

    end,
}










--UFO RESCUE--
--------------
--UFO RESCUE--

InanimateInsanity.inin_ElimChallenge {
    key = 'ufo_rescue',
    pos = { x = 0, y = 0 },
    config = { extra = { eliminations = 1, randchoice = true, qualifier = false, qualifier_c = false, qualifier_a = "retrigger" } },
    
    -- When used
    use = function(self, card, area, copier)

        -- Give shimmer to a random Joker (TODO - Add events)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        local eligible_card = pseudorandom_element(editionless_jokers, 'UFO')
        eligible_card:set_edition('e_inin_shimmer')

        -- Eliminate cards
        card.config.center.eliminate(self, card, area, copier)
    end,

    -- Check if can be used
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
}