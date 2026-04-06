--BLUEBERRY--
-------------
--BLUEBERRY--

SMODS.Atlas {
    key = 'blueberry',
    path = 'j_blueberry.png',
    px = 71,
    py = 95
}

SMODS.Joker {
	
    -- General Info
    key = 'blueberry',
    atlas = 'blueberry',
	unlocked = true,
    discovered = true,
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { hands = 2 , hands_remaining = 2 , boss = false } },

    -- Update Variables
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands , card.ability.extra.hands_remaining }}
    end,

    -- Calculations
    calculate = function(self, card, context)

        -- Check if blind is a Boss Blind
        if context.setting_blind and context.blind.boss then
            card.ability.extra.boss = true
        end

        -- Ensure you're in a boss blind before doing anything
        if card.ability.extra.boss then

            -- Hand logic
            if context.after and not context.blueprint and card.ability.extra.hands_remaining > 0 then
                
                -- Reduce hands by 1
                card.ability.extra.hands_remaining = card.ability.extra.hands_remaining - 1

                -- Check if it's time to disable the boss blind !
                if card.ability.extra.hands_remaining == 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.blind:disable()
                                    play_sound('timpani')
                                    delay(0.4)
                                    return true
                                end
                            }))
                            SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                            return true
                        end
                    }))
                else
                    return {
                        message = card.ability.extra.hands_remaining .. ' left!',
                        colour = G.C.RED
                    }
                end
            end

            -- Reset hands
            if context.end_of_round and not context.blueprint then
                card.ability.extra.hands_remaining = card.ability.extra.hands
                card.ability.extra.boss = false
                return {
                    message = localize('k_reset'),
                    color = G.C.RED
                }
            end
        end
    end
}










--BOMB--
--------
--BOMB--

SMODS.Atlas {
    key = 'bomb',
    path = 'j_bomb.png',
    px = 71,
    py = 95
}

SMODS.Joker {
	
    -- General Info
    key = 'bomb',
    atlas = 'bomb',
	unlocked = true,
    discovered = true,
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    -- Calculations
    calculate = function(self, card, context)
        
        if context.before and not context.blueprint then
            -- Destroy card if most played hand is played
            
            -- Define how many times hand has been played
            local reset = true
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)

            -- Check if any other hands have been played more
            for handname, values in pairs(G.GAME.hands) do
                if handname ~= context.scoring_name and values.played >= play_more_than and SMODS.is_poker_hand_visible(handname) then
                    reset = false
                    break
                end
            end

            -- Break card
            if reset then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = '!! BOOM !!',
                    colour = G.C.RED
                }
            end

        elseif context.repetition and context.cardarea == G.play then
            -- Retrigger time!
            return {
                repetitions = 1
            }
        end
    end
}










--BOOKCASEY--
-------------
--BOOKCASEY--

SMODS.Atlas {
    key = 'bookcasey',
    path = 'j_bookcasey.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    
    -- General Info
    key = 'bookcasey',
    atlas = 'bookcasey',
    unlocked = true,
    discovered = true,
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { Xmult = 10 , deletion_flag = false } },

    -- Update variables
    loc_vars = function(self, info_queue, card)

        local rightmost_check = false

        if G.jokers then rightmost_check = G.jokers.cards[#G.jokers.cards] == card end
        
        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", minh = 0.4 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { ref_table = card, align = "m", colour = rightmost_check and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' ..  (rightmost_check and "active" or "inactive") .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } }
                        }
                    }
                }
            }
        }

        return { main_end = main_end, vars = { card.ability.extra.Xmult } }
    end,

    -- Calculations
    calculate = function(self, card, context)
        if context.joker_main and G.jokers.cards[#G.jokers.cards] == card then
            -- Do mult n stuff
            card.ability.extra.deletion_flag = true
            return {
                xmult = card.ability.extra.Xmult
            }
        elseif context.after and card.ability.extra.deletion_flag and not context.blueprint then
            -- Destroy !!!!
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = 'Gone!',
                colour = G.C.RED
            }
        end
    end
}










--BOW--
-------
--BOW--

SMODS.Atlas {
    key = 'bow',
    path = 'j_bow.png',
    px = 71,
    py = 95
}

SMODS.Joker {

    -- General Info
    key = 'bow',
    atlas = 'bow',
    unlocked = true,
    discovered = true,
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = { extra = { chips = 0 , ghost_odds = 4 } },

    -- Update Variables
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    -- Calculations
    calculate = function(self, card, context)
        
        -- No blueprint here! :D
        if not context.blueprint then
            
            -- Higher chance to add Ghost
            if context.buying_self and not card.edition and SMODS.pseudorandom_probability(card, 'inin_bow', 1, card.ability.extra.ghost_odds) then
                card:set_edition('e_inin_ghost')
            end

            -- Add chips
            if context.reroll_shop then
                card.ability.extra.chips = card.ability.extra.chips + context.cost
                return {
                    message = '+' .. card.ability.extra.chips .. ' Chips',
                    colour = G.C.CHIPS
                }
            end
        end

        -- Add chips in run
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}










--BOX 1--
---------
--BOX 1--

SMODS.Atlas {
    key = 'box',
    path = 'j_box.png',
    px = 71,
    py = 95
}

SMODS.Joker {
	
    -- General Info
    key = 'box',
    atlas = 'box',
	unlocked = true,
    discovered = true,
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = { odds = 3 } },

    -- Update Variables
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'inin_box')
        return { vars = { numerator, denominator }}
    end,

    -- Calculations
    calculate = function(self, card, context)
        
        -- DIE !!!
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'inin_box', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'Gone!',
                    colour = G.C.JOKER_GREY
                }
            else
                return {
                    message = 'Safe..?',
                    colour = G.C.JOKER_GREY
                }
            end
        end
    end
}