---JOKER QUIPS---
-----------------
---JOKER QUIPS---

local card_add_to_deck_ref = Card.add_to_deck
local config = SMODS.current_mod.config

function Card:add_to_deck(from_debuff)

    -- Trigger original function
    local ret = card_add_to_deck_ref(self, from_debuff)

    -- Ensure that card is a joker from the II mod
    if not from_debuff and self.ability.set == "Joker" and (self.config.center.pools or {}).inin_joker_additions then
        -- Establish quipping variables
        local joker_key = self.config.center.key
        local char_name = string.gsub(joker_key, "j_inin_", "")
        local char_amount = 0

        -- Check for number of sounds for this Joker
        for i = 1, 100 do

            -- Failsafe
            if i == 99 then
                char_amount = 0
                break
            end

            -- Check for the key
            if not SMODS.Sounds["inin_quip_" .. char_name .. i] then
                break
            else
                char_amount = char_amount + 1
            end
        end

        -- Establish that sound is present and play sound if there is
        if char_amount ~= 0 then
            local sound_key = "inin_quip_" .. char_name .. pseudorandom("inin_" .. char_name, 1, char_amount)
            play_sound(sound_key, 1, config.quip_volume/10)
        end
    end

    -- End
    return ret
end









---PAINTED RESET---
-------------------
---PAINTED RESET---

local card_set_ability_ref = Card.set_ability

function Card:set_ability(initial, delay_sprites)

    -- Swap to proper suit
    if self.ability and self.ability.inin_pre_suit and initial.key ~= "m_inin_painted" then
        SMODS.change_base(self, self.ability.inin_pre_suit)
        self.ability.inin_pre_suit = nil
    end

    -- Trigger original function
    local ret = card_set_ability_ref(self, initial, delay_sprites)

    -- End
    return ret
end