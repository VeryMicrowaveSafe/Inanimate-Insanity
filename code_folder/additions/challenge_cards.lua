SMODS.ConsumableType {
    key = 'inin_Compete',
    default = 'c_inin_ufo_rescue',
    primary_colour = G.C.ININ.SET.Challenge,
    secondary_colour = G.C.ININ.SECONDARY_SET.Challenge,
    collection_rows = { 6, 6 },
    shop_rate = 2
}










--UFO RESCUE--
--------------
--UFO RESCUE--

SMODS.Atlas {
    key = 'ufo_rescue',
    path = 'c_ufo_rescue.png',
    px = 71,
    py = 95
}

SMODS.Consumable {
    key = 'ufo_rescue',
    atlas = 'ufo_rescue',
    set = 'inin_Compete',
    unlocked = true,
    discovered = true,
    config = { extra = { eliminations = 2, randchoice = true, qualifier = false, qualifier_c = false } },

    -- Return elimination amount n stuff
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
    
    -- When used
    use = function(self, card, area, copier)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        local eligible_card = pseudorandom_element(editionless_jokers, 'UFO')
        eligible_card:set_edition('e_inin_shimmer')
    end,

    -- Check if can be used
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
}