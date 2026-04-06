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
    config = { card_limit = 1 , inin_pre_suit = nil },

    -- Set card to Painted
    update = function(self, card, dt)
        if G.hand or G.play and SMODS.has_enhancement(card, 'm_inin_painted') then
            -- Set pre_suit
            if not card.ability.inin_pre_suit then card.ability.inin_pre_suit = card.base.suit end
            
            -- Set to Painted suit
            local new_suit = 'inin_Painted_Suit'
            SMODS.change_base(card, new_suit)
        end
    end,
}










--CARDBOARD--
-------------
--CARDBOARD--

SMODS.Atlas {
    key = 'enhance_cardboard',
    path = 'm_painted.png',
    px = 71,
    py = 95
}

SMODS.Enhancement {
    
    -- General Info
    key = 'cardboard',
    atlas = 'enhance_cardboard',
    replace_base_card = true,
    no_suit = true,
    config = { inin_pre_rank = nil },

    -- Set card to Cardboard
    update = function(self, card, dt)
        if G.hand or G.play and SMODS.has_enhancement(card, 'm_inin_cardboard') then
            -- Set pre_suit
            if not card.ability.inin_pre_rank then card.ability.inin_pre_rank = card.base.rank end
            
            -- Set to Painted suit
            local new_rank = 'inin_Cardboard_Rank'
            SMODS.change_base(card, new_rank)
        end
    end,
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










--BUTTERFLY--
-------------
--BUTTERFLY--

SMODS.Atlas {
    key = 'butterfly',
    path = 'm_snotty.png',
    px = 71,
    py = 95
}

SMODS.Enhancement {

    -- General Info
    key = 'butterfly',
    atlas = 'butterfly',

    loc_vars = function(self, info_queue, card)
        return { vars = { "hi!! :D" } }
    end
}