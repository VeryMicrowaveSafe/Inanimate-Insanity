--OJ--
------
--OJ--

SMODS.Atlas {
    key = 'oj',
    path = 'j_oj.png',
    px = 71,
    py = 95
}

SMODS.Joker {
	
    -- General Info
    key = 'oj',
    atlas = 'oj',
	unlocked = true,
    discovered = true,
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

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