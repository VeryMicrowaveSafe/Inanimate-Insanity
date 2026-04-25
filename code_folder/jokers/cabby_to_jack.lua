--CABBY--
---------
--CABBY--

InanimateInsanity.inin_Joker {
	
    -- General Info
    key = 'cabby',
    pos = { x = 3, y = 0 },
    rarity = 3,
    cost = 10,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    attributes = { "copying" },
    config = { extra = { resetting = false } },





    -- Find copied joker
    find_copy = function()
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.inin_copycard then
                return G.jokers.cards[i]
            end
        end
        return false
    end,





    -- GUI Compatability Check
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then

            -- Set compatible
            local compatible = false

            -- Check if there's a compatible edition
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    local edition_check = G.jokers.cards[i + 1]
                    if not edition_check or not edition_check.edition or edition_check.edition.key == "e_negative" or edition_check.edition.key == "e_inin_ghost" then
                        compatible = false
                    else
                        compatible = true
                    end
                end
            end

            -- Set up GUI thingy
            local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }

            -- Return after end
            if card.config.center.find_copy() then
                local joker_name = localize { type = 'name_text', set = "Joker", key = card.config.center.find_copy().config.center.key }
                return { main_end = main_end , vars = { joker_name } }
            else
                return { main_end = main_end , vars = { nil } }
            end
        end
    end,





    -- Calculations
    calculate = function(self, card, context)
        if not context.blueprint then
            
            -- Edition Compatability
            local edition_joker

            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    local edition_check = G.jokers.cards[i + 1]
                    if not edition_check or not edition_check.edition or edition_check.edition.key == "e_negative" or edition_check.edition.key == "e_inin_ghost" then
                        edition_joker = nil
                    else
                        edition_joker = edition_check
                    end
                end
            end
            
            -- Joker Compatability
            if (context.end_of_round and context.main_eval) or ((context.selling_card or context.joker_type_destroyed) and context.card == card.config.center.find_copy()) or not card.config.center.find_copy() then

                -- Reset resetting
                card.ability.extra.resetting = true
                
                -- Clear compatability list
                local compat_list = {}

                -- Get compatible jokers
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] and G.jokers.cards[i] ~= card and G.jokers.cards[i].config.center.blueprint_compat and not (context.selling_card and context.card == G.jokers.cards[i]) then
                        table.insert(compat_list, G.jokers.cards[i])
                    end
                end

                -- Select random thingy
                if compat_list ~= {} then
                    if card.config.center.find_copy() then card.config.center.find_copy().ability.inin_copycard = false end
                    local joker_copy = pseudorandom_element(compat_list, "inin_seed")
                    if joker_copy then
                        joker_copy.ability.inin_copycard = true
                        return {
                            message = localize('k_reset'),
                            colour = G.C.RED
                        }
                    end
                end
            
            end

            -- Set up return table
            local return_table = {}
            local return_last = false
            
            -- Edition copy
            if context.joker_main and edition_joker then
                if edition_joker.edition.key == "e_holo" then
                    -- Holographic (+10 Mult)
                    return_table = { mult = edition_joker.edition.mult }
                elseif edition_joker.edition.key == "e_foil" then
                    -- Foil (+50 Chips)
                    return_table = { chips = edition_joker.edition.chips }
                elseif edition_joker.edition.key == "e_polychrome" or edition_joker.edition.key == "e_inin_fiery" then
                    -- Polychrome (X1.5 Mult) or Fiery (X4 Mult)
                    return_table = { x_mult = edition_joker.edition.x_mult }
                    return_last = true
                end
            elseif context.retrigger_joker_check and context.other_card == card and edition_joker then
                if edition_joker.edition.key == "e_inin_shimmer" and SMODS.pseudorandom_probability(card, 'inin_cabby', 1, edition_joker.edition.extra.odds) then
                    -- Shimmer (1 Retrigger)
                    return_table = { repetitions = edition_joker.edition.extra.retriggers }
                    return_last = true
                elseif edition_joker.edition.key == "e_inin_stressed" and edition_joker.edition.extra.retriggers > 0 then
                    -- Stressed (Multiple Retriggers)
                    return_table = { repetitions = edition_joker.edition.extra.retriggers }
                    return_last = true
                end
            elseif context.post_trigger and context.other_card == card and edition_joker and  edition_joker.edition.key == "e_inin_golden" and not card.ability.extra.resetting then
                -- Golden (+3 Dollars)
                return_table = { dollars = edition_joker.edition.extra.dollars }
                return_last = true
            end
            
            -- Reset resetting
            if context.post_trigger and context.other_card == card then
                card.ability.extra.resetting = false
            end

            -- Trigger!
            local ret = {}
            if card.config.center.find_copy() then
                ret = SMODS.blueprint_effect(card, card.config.center.find_copy(), context)
                if ret then ret.colour = G.C.JOKER_GREY end
            end

            -- Return
            if return_last then
                return SMODS.merge_effects{ ret or {}, return_table or {} }
            else
                return SMODS.merge_effects{ return_table or {}, ret or {} }
            end
        end
    end
}










--GOO--
-------
--GOO--

InanimateInsanity.inin_Joker {
	
    -- General Info
    key = 'goo',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    attributes = { "economy" },
    config = { extra = { dollars = 2 , multiplier = 1 , max = 14 } },

    -- Update Localization
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.max } }
    end,

    -- Money pay
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars * card.ability.extra.multiplier
    end,

    -- Calculations
    calculate = function(self, card, context)

        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.multiplier = math.min(math.floor(G.GAME.chips / G.GAME.blind.chips), card.ability.extra.max / card.ability.extra.dollars)
        end

    end,

}










--JACK--
--------
--JACK--

InanimateInsanity.inin_Joker {
	
    -- General Info
    key = 'jack',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    attributes = { "mult", "scaling", "reset", "jack" },
    config = { extra = { mult = 0, increment = 3 } },

    -- Update Localization
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increment, card.ability.extra.mult } }
    end,

    -- Calculations
    calculate = function(self, card, context)

        if context.before and not context.blueprint then
            -- Check for Jacks
            local present_jack = false
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card.base.value == "Jack" then
                    present_jack = true
                    break
                end
            end

            -- Reset if there isn't a Jack
            if present_jack then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.increment
            else
                local prev_mult = card.ability.extra.mult
                card.ability.extra.mult = 0
                if prev_mult > 0 then
                    return {
                        message = localize('k_reset')
                    }
                end
            end

        elseif context.joker_main then
            return { mult = card.ability.extra.mult }
        end

    end,

}