return {
    descriptions = {
        
        
        
        --EDITIONS--
        --EDITIONS--
        --EDITIONS--
        
        Edition = {

            -- SHIMMER
            e_inin_shimmer = {
                name = 'Shimmer',
                text = {
                    "{C:green}#1# in #2#{} chance",
                    "to retrigger this",
                    "card {C:attention}#3#{} time"
                },
            },

            -- FIERY
            e_inin_fiery = {
                name = 'Fiery',
                text = {
                    "{X:red,C:white}X#1#{} Mult",
                    "{C:attention}Destroyed{} if round",
                    "is not won in",
                    "a single hand"
                },
            },

            -- GHOST
            e_inin_ghost = {
                name = 'Ghost',
                text = {
                    "{C:dark_edition}+#1#{} Joker slots"
                },
            },

            -- GOLDEN
            e_inin_golden = {
                name = 'Golden',
                text = {
                    "Earn {C:money}$#1#{} when this",
                    "card is triggered"
                },
            },

            -- STRESSED
            e_inin_stressed = {
                name = 'Stressed',
                text = {
                    "Retrigger this",
                    "card {C:attention}#1#{} times,",
                    "reduces by {C:attention}1{}",
                    "each round"
                },
            },
        },
        
        






        
        --JOKERS--
        --JOKERS--
        --JOKERS--
        
        Joker = {

            -- BLUEBERRY
            j_inin_blueberry = {
                name = 'Blueberry',
                text = {
                    "Disables effect of",
                    "{C:attention}Boss Blind{} after",
                    "{C:attention}#1#{} {C:inactive}[#2#]{} hands played"
                },
            },

            -- BOMB
            j_inin_bomb = {
                name = 'Bomb',
                text = {
                    "Retrigger all",
                    "cards played, {C:attention}destroyed{}",
                    "upon playing your most",
                    "played {C:attention}poker hand{}"
                },
            },

            -- BOOKCASEY
            j_inin_bookcasey = {
                name = 'Bookcasey',
                text = {
                    "{X:red,C:white}X#1#{} Mult if this is",
                    "your rightmost Joker",
                    "{C:red,E:2}self destructs{}"
                },
            },

            -- BOW
            j_inin_bow = {
                name = 'Bow',
                text = {
                    "This Joker gains {C:chips}Chips{}",
                    "equal to the cost",
                    "of each {C:attention}reroll{} in",
                    "the shop",
                    "{C:inactive}(Currently {}{C:chips}+#1#{} {C:inactive}Chips){}"
                },
            },

            -- BOX 1
            j_inin_box = {
                name = 'Box',
                text = {
                    "{C:green}#1# in #2#{} chance this",
                    "card is destroyed",
                    "at end of round",
                    "{C:inactive}Does nothing?"
                },
            },

            -- CABBY
            j_inin_cabby = {
                name = 'Cabby',
                text = {
                    "Copies {C:dark_edition}Edition{} of",
                    "{C:attention}Joker{} to the right,",
                    "also copies {C:attention}ability{} of",
                    "randomly-selected {C:attention}Joker{}",
                    "{C:inactive}Selected Joker changes{}",
                    "{C:inactive}at end of round{}",
                    "{C:inactive}Currently copying: {C:attention}#1#{}{}"
                },
            },

            -- GOO
            j_inin_goo = {
                name = 'Goo',
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "for each time your total score",
                    "reached the {C:attention}required chips{}",
                    "for the round",
                    "{C:inactive}({}{C:money}$#2#{}{C:inactive} max){}"
                },
            },

            -- JACK
            j_inin_jack = {
                name = 'Jack',
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult",
                    "per {C:attention}consecutive{} hand",
                    "played with a",
                    "scoring {C:attention}Jack{}",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                },
            },

            -- MAGNET
            j_inin_magnet = {
                name = 'Magnet',
                text = {
                    "Played {C:attention}Steel{} cards",
                    "give {X:red,C:white}X#1#{} Mult",
                    "when scored"
                },
            },

            -- OJ
            j_inin_oj = {
                name = 'OJ',
                text = {
                    "Balance {C:chips}Chips{} and {C:mult}Mult{}",
                    "before scoring"
                },
            },

            -- SILVER SPOON
            j_inin_silver_spoon = {
                name = 'Silver Spoon',
                text = {
                    "{X:red,C:white}X#1#{} Mult for",
                    "every {C:money}$#2#{} you have",
                    "{C:inactive}(Currently {}{X:red,C:white}X#3#{}{C:inactive} Mult){}"
                },
            },

            -- STARFRUIT
            j_inin_starfruit = {
                name = 'Starfruit',
                text = {
                    "Earn {C:money}$#1#{} at end of round,",
                    "increase payout by",
                    "{C:money}$#2#{} on cash out",
                    "{C:inactive}Destroyed after{}",
                    "{C:attention}#3#{}{C:inactive} payouts{}"
                },
            },

            -- TACO
            j_inin_taco = {
                name = 'Taco',
                text = {
                    "{C:green}#3# in #4#{} chance to",
                    "give {X:red,C:white}X#1#{} Mult,",
                    "otherwise gives",
                    "{C:chips}+#2#{} chips"
                },
            },

            -- TEA KETTLE
            j_inin_tea_kettle = {
                name = 'Tea Kettle',
                text = {
                    "{C:chips}+#1#{} Chips per hand played",
                    "with an {C:attention}even{} number of cards",
                    "{C:chips}-#1#{} Chips per hand played",
                    "with an {C:attention}odd{} number of cards",
                    "{C:inactive}(Currently {C:chips}+#2#{}{C:inactive} Chips){}"
                },
            },

            -- TEST TUBE
            j_inin_test_tube = {
                name = 'Test Tube',
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult",
                    "if played hand has",
                    "exactly {C:attention}#3#{} card#4#",
                    "{C:inactive}Card amount changes{}",
                    "{C:inactive}at end of round{}",
                    "{C:inactive}(Currently {}{C:mult}+#2#{}{C:inactive} Mult){}"
                },
            },
        },
        
        






        
        --ENHANCEMENTS--
        --ENHANCEMENTS--
        --ENHANCEMENTS--
        
        Enhanced = {

            -- PAINTED
            m_inin_painted = {
                name = 'Painted Card',
                text = {
                    "No rank, counts",
                    "as a unique {C:attention}suit{}"
                },
            },

            -- CARDBOARD
            m_inin_cardboard = {
                name = 'Cardboard Card',
                text = {
                    "No suit, counts",
                    "as a unique {C:attention}rank{}"
                },
            },

            -- SNOTTY
            m_inin_snotty = {
                name = 'Snotty Card',
                text = {
                    "idk lol"
                },
            },

            -- BUTTERFLY
            m_inin_butterfly = {
                name = 'Butterfly Card',
                text = {
                    "Copies {C:attention}ability{} of a",
                    "random {C:enhanced}Enhancement{}",
                    "that changes at",
                    "end of round",
                    "{C:inactive}Currently copying #1#{}"
                },
            }
        },
        
        






        
        --CHALLENGES--
        --CHALLENGES--
        --CHALLENGES--

        inin_Compete = {

            -- UFO RESCUE
            c_inin_ufo_rescue = {
                name = 'UFO Rescue',
                text = {
                    {
                        "Add {C:dark_edition}Shimmer{} to",
                        "a random {C:attention}Joker{}"
                    },
                    {
                        "{C:red,E:2}Eliminates{} #1# #3#",
                        "{C:attention}Joker#2#{}"
                    },
                },
            }
        },
        
        






        
        --TOOLTIPS--
        --TOOLTIPS--
        --TOOLTIPS--

        Other = {

            inin_elim_info = {
                name = "Elimination",
                text = {
                    "{C:red}Eliminated{} Jokers",
                    "will no longer",
                    "appear in the run"
                }
            },

            inin_rejoin_info = {
                name = "Rejoin",
                text = {
                    "{C:blue}Rejoining{} Jokers",
                    "are no longer",
                    "{C:red}Eliminated{}"
                }
            },

            inin_immune_info = {
                name = "Immunity",
                text = {
                    "{C:legendary}Immune{} Jokers",
                    "cannot be",
                    "{C:red}Eliminated{}"
                }
            }

        }
    },









    --MISC--
    --MISC--
    --MISC--

    misc = {

        -- DICTIONARY
        dictionary = {
            b_inin_compete_cards = "Challenge Cards",
            k_inin_compete = "Challenge",
        },



        -- LABELS
        labels = {
            inin_shimmer = "Shimmer",
            inin_fiery = "Fiery",
            inin_ghost = "Ghost",
            inin_golden = "Golden",
            inin_stressed = "Stressed",
        },



        -- RANKS
        ranks = {
            inin_Cardboard_Rank = "Board"
        },



        -- SUITS
        suits_plural = {
            -- PAINTED
            inin_Painted_Suit = "Painteds"
        },
        suits_singular = {
            -- PAINTED
            inin_Painted_Suit = "Painted"
        }
    },
}