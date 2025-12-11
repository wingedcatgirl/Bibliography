return {
	["misc"] = {
		["dictionary"] = {
            k_biblio_jump = "Jumped!",
            k_biblio_land = "Landed!",
            --Rarities
            k_biblio_illustrious = "Illustrious",
            k_biblio_mythical = "Mythical",
            k_biblio_nth = "Nth",
            k_biblio_evolved = "Evolved",
            k_biblio_ascended = "Ascended",
            k_biblio_exalted = "Exalted",
            k_biblio_sublime = "Sublime",
            k_biblio_enoughalready = "Enough already!!!"
		},
		["v_dictionary"] = {
            
		},
		["v_text"] = {
            
		},
		["suits_plural"] = {
            
		},
		["suits_singular"] = {
            
		},
		["ranks"] = {
            
		},
		["labels"] = {
            k_biblio_illustrious = "Illustrious",
            k_biblio_mythical = "Mythical",
            k_biblio_nth = "Nth",
            k_biblio_evolved = "Evolved",
            k_biblio_ascended = "Ascended",
            k_biblio_exalted = "Exalted",
            k_biblio_sublime = "Sublime",
            k_biblio_enoughalready = "Enough already!!!"
		},
		["challenge_names"] = {
            
		},
		["poker_hands"] = {
            
		},
		["poker_hand_descriptions"] = {
            
		},
		["quips"] = {
			
		},
	},
	["descriptions"] = {
		--[[ For now, this is only for translations; leave it commented in US English. and/or if it's not done yet
		["Mod"] = {
			["Bibliography"] = {
				["name"] = "Bibliography",
				["text"] = {
					"Adds various blorbos as Jokers, and invents gratuitous power-creep."
				},
			},
		},
		--]]
		["Joker"] = {
			["j_biblio_leaf"] = {
				["name"] = "Leaf Saito",
				["text"] = {
					{
                        "If {C:attention}grounded{} when hand played,",
                        "{C:mult}jump{} at end of hand"
                    },
                    {
                        "If {C:attention}airborne{} when hand played,",
                        "{C:mult}land{} on last scoring card and",
                        "{C:attention}retrigger{} it for each card",
                        "in poker hand"
                    },
				},
			},
			["j_biblio_leafX"] = {
				["name"] = "Leaf, Stellar Dragoon",
				["text"] = {
					{
                        "If {C:attention}grounded{} when hand played,",
                        "{C:mult}jump{} at end of hand"
                    },
                    {
                        "If {C:attention}airborne{} when hand played,",
                        "{C:attention}retrigger{} all scoring cards {C:blue}#1#{} times",
                    },
                    {
                        "{C:inactive,s:0.8}Further Crucibles add more retriggers",
                        "{C:inactive,s:0.8}Progress: #2#/#1#",
                    }
				},
			},
			--HEY FUTURE MINTY, PUT NEW JOKERS ⬆️HERE⬆️ :P 
			["j_biblio_template"] = {
				["name"] = "Joker Template",
				["text"] = {
					"Does something",
				},
			},
		},
		["Back"] = {
            
        },
		["Blind"] = {
            
		},
		["Tarot"] = {
            c_biblio_crucible = {
                name = "The Crucible",
                text = {
                    "Evolve {C:attention}#1#{} eligible",
                    "card#2# to a new level"
                }
            }
		},
		["Spectral"] = {
            
		},
		["Planet"] = {
            
		},
		["Tag"] = {
            
		},
		["Sleeve"] = {
            
		},
		["Enhanced"] = {
            
		},
		["Voucher"] = {
            
		},
		["Stake"] = {
            
		},
		["Rotarot"] = {
            c_biblio_rot_crucible = {
                name = "The Crucible!",
                text = {
                    "Create {C:attention}#1#{} card",
                    "capable of evolution"
                }
            }
		},
        ["Lore"] = { --NOTE TO FUTURE PEOPLE, adding new categories for infoqueues isn't automatic; we had to patch it in, see lore.toml
            ["j_biblio_leaf"] = {
                label = "Leaf Saito",
                name = "Leaf Saito",
                text = {
                    "A girl who found an interdimensional",
                    "travel machine and instantly",
                    "used it for escapism."
                }
            },
            ["j_biblio_leafX"] = {
                label = "Leaf, Stellar Dragoon",
                name = "Leaf, Stellar Dragoon",
                text = {
                    "The girl who wields",
                    "the pitch-dark power",
                    "of deep space."
                }
            },
        },
	},
}