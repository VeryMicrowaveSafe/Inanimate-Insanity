local main_config = SMODS.current_mod.config

SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK },
    nodes = {
        {
            n = G.UIT.R,
            config = { padding = 0.2 },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { r = 0.1, align = "cm", colour = G.C.BLACK },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.01 },
                            nodes = {
                                create_slider({
                                    label = "Quip Volume",
                                    ref_table = main_config,
                                    ref_value = "quip_volume",
                                    w = 6,
                                    min = 0,
                                    max = 100
                                })
                            }
                        }
                    }
                }
            }
        }
    }}
end