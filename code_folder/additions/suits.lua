SMODS.Suit {
    key = 'Painted_Suit',
    card_key = 'P',
    pos = { y = 3 },
    lc_colour = G.C.BLACK,
    hc_colour = G.C.BLACK,
    ui_pos = { x = 3, y = 1 },
    config = { extra = { pre_suit2 = nil } },
    keep_base_colours = true,

    -- None at start
    in_pool = function(self, args)
        return false
    end,

    -- Set previous suit
    calculate = function(self, card, context)
        print("AGDFJKADLJGLFDS")
        if context.setting_ability and context.new == 'm_inin_painted' and not context.unchanged then
            card.ability.extra.pre_suit2 = card.ability.extra.pre_suit
        elseif context.setting_ability and context.old == 'm_inin_painted' and not context.unchanged then
            SMODS.change_base(card, card.ability.extra.pre_suit2)
        end
    end
}