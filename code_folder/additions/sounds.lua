-- Add all joker quips
local quips_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. 'assets/sounds/joker_quips')

for _, folder in ipairs (quips_src) do
    -- Get all sounds in the folder
    local folder_sounds = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. 'assets/sounds/joker_quips/' .. folder)

    -- Add sounds
    for _, file in ipairs(folder_sounds) do
        SMODS.Sound {
            key = "quip_" .. string.gsub(file, ".ogg", ""),
            path = "/joker_quips/" .. folder .. "/" .. file
        }
    end
end