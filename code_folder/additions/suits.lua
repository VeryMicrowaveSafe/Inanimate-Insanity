SMODS.Suit {
    key = 'Painted_Suit',
    card_key = 'P',
    lc_colour = G.C.BLACK,
    hc_colour = G.C.BLACK,
    pos = { y = 0 },
    ui_pos = { x = 0, y = 1 },
    keep_base_colours = false,

    -- None at start
    in_pool = function(self, args)
        return false
    end,

}