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
    config = { card_limit = 1 , pre_suit = nil },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.card_limit } }
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.pre_suit = card.base.suit
        SMODS.change_base(card, 'inin_Painted_Suit')
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