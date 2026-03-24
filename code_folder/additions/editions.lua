--SHIMMER--
-----------
--SHIMMER--

SMODS.Shader {
    key = 'shimmer',
    path = 'shimmer.fs',
}

SMODS.Edition {
    key = 'shimmer',
    shader = 'shimmer',
    config = { extra = { retriggers = 1, odds = 2 } },
    in_shop = true,
    weight = 3,
    extra_cost = 5,
    unlocked = true,
    discovered = true,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.edition.extra.odds, 'inin_shimmer')
        return { vars = { numerator, denominator, card.edition.extra.retriggers } }
    end,
    
    calculate = function(self, card, context)
        if context.retrigger_joker_check and context.other_card == card and SMODS.pseudorandom_probability(card, 'inin_shimmer', 1, card.edition.extra.odds) then
            return { repetitions = card.edition.extra.retriggers }
        end
    end

}










--FIERY--
---------
--FIERY--

SMODS.Shader {
    key = 'fiery',
    path = 'fiery.fs',
}

SMODS.Edition {
    key = 'fiery',
    shader = 'fiery',
    config = { x_mult = 4 },
    in_shop = false,
    weight = 10,
    extra_cost = 7,
    unlocked = true,
    discovered = true,
    sound = { sound = "polychrome1", per = 1.2, vol = 0.7 },

    -- Show Xmult
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.x_mult } }
    end,
    
    -- Calculations
    calculate = function(self, card, context)
        if context.post_joker then
            -- Apply Xmult
            return {
                x_mult = card.edition.x_mult
            }
        elseif context.after and not SMODS.last_hand_oneshot then
            -- Destroy card
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = 'Burnt!',
                colour = G.C.RED
            }
        end
    end

}










--GHOST--
---------
--GHOST--

SMODS.Edition {
    key = 'ghost',
    shader = 'negative',
    prefix_config = {
        shader = false
    },
    config = { card_limit = 0.5 },
    in_shop = true,
    weight = 8,
    extra_cost = 4,
    unlocked = true,
    discovered = true,
    sound = { sound = "negative", per = 1.5, vol = 0.4 },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.card_limit } }
    end

}










--GOLDEN--
----------
--GOLDEN--

SMODS.Edition {
    key = 'golden',
    shader = 'foil',
    prefix_config = {
        shader = false
    },
    config = { extra = { dollars = 3 } },
    in_shop = true,
    weight = 10,
    extra_cost = 6,
    unlocked = true,
    discovered = true,
    sound = { sound = "negative", per = 1.5, vol = 0.4 },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.post_trigger and context.other_card == card then
            return { dollars = card.edition.extra.dollars }
        end
    end
}










--STRESSED--
------------
--STRESSED--

SMODS.Edition {
    key = 'stressed',
    shader = 'foil',
    prefix_config = {
        shader = false
    },
    config = { extra = { retriggers = 3, dontdouble = false } },
    in_shop = true,
    weight = 10,
    extra_cost = 6,
    unlocked = true,
    discovered = true,
    sound = { sound = "negative", per = 1.5, vol = 0.4 },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.extra.retriggers } }
    end,

    calculate = function(self, card, context)
        if context.retrigger_joker_check and context.other_card == card and not card.edition.extra.dontdouble then
            -- Retrigger!
            return { repetitions = card.edition.extra.retriggers }
        elseif context.retrigger_joker_check and context.other_card == card then
            -- Reset dontdouble
            card.edition.extra.dontdouble = true
        elseif context.end_of_round and context.main_eval then
            -- Reduce retriggers
            card.edition.extra.retriggers = card.edition.extra.retriggers - 1

            -- Destroy card if retriggers hits 0
            if card.edition.extra.retriggers <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_drank_ex'),
                    colour = G.C.FILTER
                }
            else
                return {
                    message = card.edition.extra.retriggers .. '',
                    colour = G.C.FILTER
                }
            end
        end
    end
}