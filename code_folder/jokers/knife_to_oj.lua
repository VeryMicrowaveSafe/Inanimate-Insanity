--MAGNET--
----------
--MAGNET--

InanimateInsanity.inin_Joker {

    -- General Info
    key = 'magnet',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = { "xmult", "enhancements" },
    config = { extra = { Xmult = 1.75 } },

    -- Update Description
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,

    -- Calculations
    calculate = function(self, card, context)
        -- Check that it's a steel card n all that
        if context.individual and context.cardarea == G.play then
            local is_enhanced = next(SMODS.get_enhancements(context.other_card))
            if is_enhanced and SMODS.has_enhancement(context.other_card, "m_steel") then
                return {
                    xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}










--OJ--
------
--OJ--

InanimateInsanity.inin_Joker {
	
    -- General Info
    key = 'oj',
    pos = { x = 4, y = 0 },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    attributes = { "balance" },

    -- Calculations
    calculate = function(self, card, context)
        
        -- Balance!
        if context.initial_scoring_step and not context.blueprint then
            return {
                balance = true
            }
        end
        
    end
}