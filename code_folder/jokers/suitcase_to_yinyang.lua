--TACO--
--------
--TACO--

SMODS.Atlas {
    key = 'taco',
    path = 'j_taco.png',
    px = 71,
    py = 95
}

SMODS.Joker {
	
    -- General Info
    key = 'taco',
    atlas = 'taco',
	unlocked = true,
    discovered = true,
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { Xmult = 5, chips = 50, odds = 2 } },

    -- Vars
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'inin_taco')
        return { vars = { card.ability.extra.Xmult, card.ability.extra.chips, numerator, denominator }}
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