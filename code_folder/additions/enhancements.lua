--PAINTED--
-----------
--PAINTED--

SMODS.Atlas {
    key = 'enhance_painted',
    path = 'm_painted.png',
    px = 71,
    py = 95
}

SMODS.Enhancement {
    
    -- General Info
    key = 'painted',
    atlas = 'enhance_painted',
    replace_base_card = true,
    no_rank = true,
    config = { card_limit = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,

    calculate = function(self, card, context)
        if context.setting_ability then
            --card.ability.extra.inin_pre_suit = card.base.suit (unused, meant to store the card's old suit so that if it becomes non-painted i can give it back, not important rn)
            SMODS.change_base(card, 'inin_Painted_Suit')
        end
    end
}










--SNOTTY--
----------
--SNOTTY--

SMODS.Atlas {
    key = 'snotty',
    path = 'm_snotty.png',
    px = 71,
    py = 95
}

SMODS.Enhancement {

    -- General Info
    key = 'snotty',
    atlas = 'snotty',

    loc_vars = function(self, info_queue, card)
        return { vars = { "hi!! :D" } }
    end
}