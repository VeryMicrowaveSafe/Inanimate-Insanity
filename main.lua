-- Setup
InanimateInsanity = SMODS.current_mod

-- Turn on Joker retriggering
SMODS.current_mod.optional_features = function()
    return {
        post_trigger = true,
        retrigger_joker = true
    }
end

-- Assert Globals and other functions
assert(SMODS.load_file('code_folder/main_functions/globals.lua'))()
assert(SMODS.load_file('code_folder/main_functions/misc_hooks.lua'))()
assert(SMODS.load_file('code_folder/main_functions/pools.lua'))()
assert(SMODS.load_file('code_folder/main_functions/config_tab.lua'))()
assert(SMODS.load_file('code_Folder/main_functions/extend_setup.lua'))()
assert(SMODS.load_file('code_Folder/main_functions/challenge_card_setup.lua'))()

-- Assert Joker scripts
local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. 'code_folder/jokers')

for _, file in ipairs (jokers_src) do
    assert(SMODS.load_file('code_folder/jokers/' .. file))()
end

-- Assert other scripts
assert(SMODS.load_file('code_folder/additions/challenge_cards.lua'))()
assert(SMODS.load_file('code_folder/additions/editions.lua'))()
assert(SMODS.load_file('code_folder/additions/enhancements.lua'))()
assert(SMODS.load_file('code_folder/additions/suitrank.lua'))()
assert(SMODS.load_file('code_folder/additions/sounds.lua'))()