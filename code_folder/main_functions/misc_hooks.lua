---JOKER QUIPS---
-----------------
---JOKER QUIPS---

local card_add_to_deck_ref = Card.add_to_deck

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
            play_sound(sound_key, 1, 2)
        end
    end

    -- End
    return ret
end