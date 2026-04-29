-- Textures

SMODS.Atlas {
    key = 'inin_blinds',
    path = 'bl_blind_sheet.png',
    px = 34,
    py = 34,
    atlas_table = "ANIMATION_ATLAS",
    frames = 21,
}










---THE PIE---
-------------
---THE PIE---

local pie_colours = { HEX("c065bc"), HEX("6e3d19") }

SMODS.Blind {
    key = "pie",
    atlas = "inin_blinds",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 0 },
    boss = { min = 2 },
    debuff = {
        h_size_ge = 2,
        h_size_le = 4
    },
    boss_colour = pie_colours[math.random(2)],
    discovered = true
}