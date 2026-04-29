---SETUP G.GAME---
------------------
---SETUP G.GAME---

local game_start_run_ref = Game.start_run

function Game:start_run(args)

    -- Default function
    local ret = game_start_run_ref(self, args)

    -- Check that it is a new run and not a continued one
    if not args.savetext then

        -- Setup G.GAME.EliminatedJokers
        G.GAME.EliminatedJokers = {}

        -- Setup G.GAME.ImmuneJokers
        G.GAME.ImmuneJokers = {
            "j_joker",
            "j_ring_master",
            "j_caino",
            "j_triboulet",
            "j_yorick",
            "j_chicot",
            "j_perkeo",
            "j_inin_mephone"
        }

    end

    -- End
    return ret
end









---GAME UPDATE---
-----------------
---GAME UPDATE---

function Game:update_inin_elim(dt)
    if self.buttons then self.buttons:remove(); self.buttons = nil end
    if self.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
    if self.blind_select then G.blind_select.alignment.offset.y = G.ROOM.T.y + 39 end

    if not G.STATE_COMPLETE then
        G.STATE_COMPLETE = true
        G.CONTROLLER.interrupt.focus = true
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.booster_pack_sparkles = Particles(1, 1, 0,0, {
                    timer = 0.015,
                    scale = 0.3,
                    initialize = true,
                    lifespan = 3,
                    speed = 0.2,
                    padding = -1,
                    attach = G.ROOM_ATTACH,
                    colours = {G.C.BLACK, G.C.RED},
                    fill = true
                })
                G.booster_pack_sparkles.fade_alpha = 1
                G.booster_pack_sparkles:fade(1, 0)
                ease_background_colour_blind(G.STATES.STANDARD_PACK)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.5,
                            func = function()
                                G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                return true
                            end}))
                        return true
                    end
                }))
                return true
            end
        }))  
    end
end









---IN POOL---
-------------
---IN POOL---

local check_eliminated = function(card_key)
    for _, elim_key in pairs(G.GAME.EliminatedJokers) do
        if card_key == elim_key then
            return true
        end
    end
    return false
end

local card_in_pool_ref = get_current_pool

function get_current_pool(type, rarity, legendary, append)

    -- Default function
    local ret, ret2, ret3 = card_in_pool_ref(type, rarity, legendary, append)

    -- Check that it is a Joker
    if type == "Joker" then
        for i, card_key in ipairs(ret) do
            if check_eliminated(card_key) then
                ret[i] = "UNAVAILABLE"
            end
        end
    end

    -- End
    return ret, ret2, ret3
end









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









---PAINTED/CARDBOARD RESET---
-----------------------------
---PAINTED/CARDBOARD RESET---

local card_set_ability_ref = Card.set_ability

function Card:set_ability(initial, delay_sprites)

    -- Swap to proper suit
    if self.ability and self.ability.inin_pre_suit and initial.key ~= "m_inin_painted" then
        assert(SMODS.change_base(self, self.ability.inin_pre_suit))
        self.ability.inin_pre_suit = nil
    end

    -- Swap to proper rank
    if self.ability and self.ability.inin_pre_rank and initial.key ~= "m_inin_cardboard" then
        assert(SMODS.change_base(self, nil, self.ability.inin_pre_rank))
        self.ability.inin_pre_rank = nil
    end

    -- Trigger original function
    local ret = card_set_ability_ref(self, initial, delay_sprites)

    -- End
    return ret
end