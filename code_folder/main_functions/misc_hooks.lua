
-- Do things when cards are added to the deck
local card_add_to_deck_ref = Card.add_to_deck

function Card:add_to_deck(from_debuff)

    -- Trigger original function
    local ret = card_add_to_deck_ref(self, from_debuff)

    -- Ensure that card is a joker from the II mod
    if not from_debuff and self.ability.set == "Joker" and (self.config.center.pools or {}).inin_joker_additions then
        play_sound('inin_quip_cabby1')
    end

    -- End
    return ret
end