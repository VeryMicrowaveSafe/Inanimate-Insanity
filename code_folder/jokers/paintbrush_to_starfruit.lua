--TACO--
--------
--TACO--

SMODS.Atlas {
    key = 'silver_spoon',
    path = 'j_silver_spoon.png',
    px = 71,
    py = 95
}

SMODS.Joker {
	
    -- General Info
    key = 'silver_spoon',
    atlas = 'silver_spoon',
	unlocked = true,
    discovered = true,
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { increment = 0.25 , scale = 10 } },

    -- Vars
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increment, card.ability.extra.scale, 1 + (card.ability.extra.increment * math.floor(G.GAME.dollars / card.ability.extra.scale)) } }
    end,

    -- Calculations
    calculate = function(self, card, context)
        
        -- X-Mult!
        if context.joker_main then
            return {
                xmult = 1 + (card.ability.extra.increment * math.floor(G.GAME.dollars / card.ability.extra.scale))
            }
        end
    end
}










--STARFRUIT--
-------------
--STARFRUIT--

SMODS.Atlas {
    key = 'starfruit',
    path = 'j_starfruit.png',
    px = 71,
    py = 95
}

SMODS.Joker {
	
    -- General Info
    key = 'starfruit',
    atlas = 'starfruit',
	unlocked = true,
    discovered = true,
    rarity = 1,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = { dollars = 2 , increment = 1 , limit = 6 } },

    -- Update Variables
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.increment, card.ability.extra.limit }}
    end,

    -- Money pay
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,

    -- Calculations
    calculate = function(self, card, context)
        if context.starting_shop and not context.blueprint then

            -- Check limit
            card.ability.extra.limit = card.ability.extra.limit - 1

            if card.ability.extra.limit <= 0 then
                -- Destroy card
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'Washed!',
                    colour = G.C.FILTER
                }
            else
                -- Increase payout
                card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.increment
                return {
                    message = '$' .. card.ability.extra.dollars,
                    colour = G.C.FILTER
                }
            end
        end
    end
}