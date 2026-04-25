--TACO--
--------
--TACO--

InanimateInsanity.inin_Joker {
	
    -- General Info
    key = 'taco',
    pos = { x = 6, y = 0 },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = { "xmult", "chips", "chance" },
    config = { extra = { Xmult = 5 , chips = 50 , odds = 2 } },

    -- Vars
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'inin_taco')
        return { vars = { card.ability.extra.Xmult, card.ability.extra.chips, numerator, denominator } }
    end,

    -- Calculations
    calculate = function(self, card, context)
        
        -- Rolling time!
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'inin_taco', 1, card.ability.extra.odds) then
                return {
                    xmult = card.ability.extra.Xmult
                }
            else
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}










--TEA KETTLE--
--------------
--TEA KETTLE--

InanimateInsanity.inin_Joker {
	
    -- General Info
    key = 'tea_kettle',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    attributes = { "chips", "scaling" },
    config = { extra = { increment = 6 , chips = 0 } },

    -- Return for localization
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increment , card.ability.extra.chips } }
    end,

    -- Calculations
    calculate = function(self, card, context)
        
        -- Edit Chips
        if not context.blueprint then
            if context.before and #context.full_hand % 2 == 1 and card.ability.extra.chips > 0 then
                card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.increment
                return {
                    message = "-" .. card.ability.extra.increment .. " Chips",
                    colour = G.C.CHIPS
                }
            elseif context.before and #context.full_hand % 2 ~= 1 then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.increment
                return {
                    message = "Upgrade!",
                    colour = G.C.FILTER
                }
            end
        end

        -- Return mult
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        
    end
}










--TEST TUBE--
-------------
--TEST TUBE--

InanimateInsanity.inin_Joker {
	
    -- General Info
    key = 'test_tube',
    pos = { x = 7, y = 0 },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    attributes = { "mult", "scaling" },
    config = { extra = { increment = 2 , mult = 0 , size = 1 } },

    -- Return for localization
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increment, card.ability.extra.mult, card.ability.extra.size, card.ability.extra.size == 1 and "" or "s" } }
    end,

    -- Calculations
    calculate = function(self, card, context)
        
        -- No Blueprint
        if not context.blueprint then
            -- Add to mult
            if context.before and #context.full_hand == card.ability.extra.size then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.increment
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED
                }
            end

            -- Reset hand type
            if context.end_of_round and context.main_eval then
                card.ability.extra.size = pseudorandom("inin_test_tube", 1, 5)
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end

        -- Return mult
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        
    end
}