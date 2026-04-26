--UFO RESCUE--
--------------
--UFO RESCUE--

InanimateInsanity.inin_ElimChallenge {
    key = 'ufo_rescue',
    pos = { x = 0, y = 0 },
    config = { extra = { eliminations = 2, randchoice = true } },
    
    -- When used
    use = function(self, card, area, copier)

        -- Give shimmer to a random Joker (TODO - Add events)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        local eligible_card = pseudorandom_element(editionless_jokers, 'UFO')
        eligible_card:set_edition('e_inin_shimmer')

        local pool = {}
        for _, add_pool in pairs(G.P_CENTER_POOLS.Joker) do
            pool[#pool+1] = add_pool.key
        end

        -- Eliminate cards
        card.config.center.eliminate(self, card, area, copier, pool)
    end,

    -- Check if can be used
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
}