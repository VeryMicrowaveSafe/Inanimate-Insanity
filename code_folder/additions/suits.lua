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

}