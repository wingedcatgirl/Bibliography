return {
	["misc"] = {
		["dictionary"] = {
            k_biblio_jump = "Jumped!",
            k_biblio_land = "Landed!",
			k_biblio_lb = "Limit Break!",
			k_biblio_disbelief = "Don't believe you!",
			k_biblio_betteridea = "Better idea!",
			k_biblio_enhanced = "Enhanced!",
			k_biblio_healed = "Healed!",
			k_biblio_revived = "Revived!",
			k_biblio_banished = "Banished!",
			k_biblio_consumed = "C O N S U M E D",
			k_biblio_active_desc = "Active",
			k_biblio_inactive_desc = "Inactive",

			--Zenos taunts
			k_biblio_zenos_1 = "Rend!",
			k_biblio_zenos_2 = "Kill...",
			k_biblio_zenos_3 = "Let this moment last forever...",
			k_biblio_zenos_4 = "Ahahahahahaha!",
			k_biblio_zenos_5 = "This is the end...",
			k_biblio_zenos_6 = "Show me your all!",
			k_biblio_zenos_7 = "Yes, yes! Just so!",
			k_biblio_zenos_8 = "Have you the strength?",
			k_biblio_zenos_9 = "The power... to transcend...",
			k_biblio_zenos_10 = "Give me something to remember!",
			k_biblio_zenos_11 = "Don't stop now...",
			k_biblio_zenos_ex_1 = "Mine for the taking!",
			k_biblio_zenos_ex_2 = "A test of your reflexes!",
			k_biblio_zenos_ex_3 = "Show me your vaunted fortitude!",
			k_biblio_zenos_ex_4 = "Soon you will know...",
			k_biblio_zenos_ex_5 = "Ah, my soul, how it burns...",
			k_biblio_zenos_ex_6 = "I know you feel it too...",
			k_biblio_zenos_ex_7 = "Come! Let all creation be consumed!",
			k_biblio_zenos_ex_8 = "I have you!",
			k_biblio_zenos_ex_9 = "Burn, burn!",
			k_biblio_zenos_ex_10 = "Now, fall!",
			k_biblio_zenos_ex_11 = "This is my moment! Our moment!",
			k_biblio_zenos_willful = "Rise once more! It mustn't end yet!",

            --Rarities
            k_biblio_illustrious = "Illustrious",
            k_biblio_mythical = "Mythical",
            k_biblio_nth = "Nth",
            k_biblio_evolved = "Evolved",
            k_biblio_ascended = "Ascended",
            k_biblio_exalted = "Exalted",
            k_biblio_sublime = "Sublime",
            k_biblio_enoughalready = "Enough already!!!",

			--Config options
			option_biblio_lorepop = "Show lore popups",
			option_biblio_nocred = "Disable credit badges",
		},
		["v_dictionary"] = {
            v_biblio_savedby = "Saved by #1#",
			v_biblio_credit = "#1#: #2#"
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
            k_biblio_enoughalready = "Enough already!!!",
			biblio_multienhance = "Multi-enhanced",
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
			["j_biblio_scarlex"] = {
				["name"] = "Scarlex Aiello",
				["text"] = {
					"If a hand would {C:blue}level up{},",
					"{C:green}#1# in #2#{} chance to gain {C:gold}$#3#{} instead"
				},
			},
			["j_biblio_scarlex_EX"] = {
				["name"] = "Scarlex, SOUL Reaper",
				["text"] = {
					"If a hand would {C:blue}level up{}, randomly chooses one:",
					"- redirect it to {C:attention}most played hand{}",
					"{C:inactive, s:0.8}(Currently #1#)",
					"- {C:blue}double it{}",
					"- or level a {C:attention}random{} additional hand"
				},
			},
			["j_biblio_vivi"] = {
				["name"] = "Vivi Elakha",
				["text"] = {
					{
						"Gains 1 MP per scored card",
						"{C:inactive}(Currently #1#/#2#){}"
					},
					{
						"After second played hand each round,",
						"{C:chips}Cure{}: Restores #4# hand#5#",
						"{C:inactive}(Costs #3# MP){}"
					},
					{
						"{C:attention}Once per Ante{C:inactive} (#7#)",
						"If Blind not defeated by final hand,",
						"{C:mult}Raise{}: Restores all hands",
						"{C:inactive}(Costs #6# MP){}"
					}
				},
			},
			["j_biblio_vivi_EX"] = {
				["name"] = "Vivi Elakha, the Fae-Touched",
				["text"] = {
					{
						"Gains 1 MP per scored card",
						"{C:inactive}(Currently #1#/#2#){}",
						--"{C:inactive}(Further Crucibles grant #12# Max MP)"
					},
					{
						"After every {C:attention}#11#{C:inactive}(#10#){} played hands,",
						"{C:chips}Cura{}: Restores #4# hand#5#",
						"{C:inactive}(Costs #3# MP){}"
					},
					{
						"{C:attention}Once per round{C:inactive} (#7#)",
						"If Blind not defeated by final hand,",
						"{C:mult}Raise{}: Restores all hands",
						"{C:inactive}(Costs #6# MP){}"
					},
					{
						"If all else fails, {C:gold}Pulse of Life{}:",
						"Prevents death and reduces Ante by #8#",
						"{C:inactive}(Costs #9# MP or self-destructs)"
					}
				},
			},
			["j_biblio_zenos"] = {
				["name"] = "Zenos yae Galvus",
				["text"] = {
					"{X:attention,C:white}X#2#{} Boss Blind size,",
					"{C:attention}+#1#{} Joker Slot#3#"
				},
			},
			["j_biblio_zenos_EX"] = {
				["name"] = "Zenos viator Galvus",
				["text"] = {
					{
						"{X:attention,C:white}X#2#{} Boss Blind size",
					},
					{
						"At end of Ante,",
						"{C:attention}+#3#{} Joker Slot#4#",
						"{C:inactive}(currently #1#)",
						"and {C:attention}#6##5#{} Ante"
					}
				},
			},
			["j_biblio_peri"] = {
				["name"] = "Peri Nagato",
				["text"] = {
					{
						"Turns {C:attention}#1#{} held",
						"consumeable#2# {C:dark_edition}Negative{}",
						"when blind is selected"
					},
					{
						"The {C:attention}Wheel of Fortune{}",
						"can appear multiple times"
					},
					{
						"Negative {C:attention}Wheels of Fortune",
						"can apply Negative",
						"edition to Jokers"
					},
				},
			},
			["j_biblio_peri_EX"] = {
				["name"] = "Peri, Abstract Heaven",
				["text"] = {
					{
						"Creates {C:attention}#1#{} {C:dark_edition}Negative{}",
						"{C:attention}Wheel of Fortune#2#{}",
						"when blind is selected"
					},
					{
						"Negative {C:attention}Wheels of Fortune",
						"can apply Negative",
						"edition to Jokers"
					},
					{
						"The {C:attention}Wheel of Fortune{}",
						"retriggers on failure,",
						"and can appear multiple times"
					},
					{
						"{C:mult}Consumes{} Negative cards at",
						"end of round to grant +1",
						"permanent area slot"
					}
				},
			},
			["j_biblio_hallie"] = {
				["name"] = "Hallie Mathews",
				["text"] = {
					{
						"On discard, {C:green}#1# in #2#{} chance",
						"to level up discarded poker hand",
						"{C:inactive}(Base denominator = remaining discards)",
					},
					{
						"If chance is {C:green}100%{}, also",
						"{C:attention}destroy{} discarded cards"
					},
					{
						"Can activate once per round",
						"{C:inactive}(Currently: #3#)"
					}
				},
			},
			["j_biblio_hallie_EX"] = {
				["name"] = "Hallie, Heart of Ember",
				["text"] = {
					{
						"On second discard of round,",
						"{C:attention}destroy{} and level up",
						"discarded poker hand",
						"{C:inactive}(Currently: #2#){}"
					},
					{
						"Gains destroyed cards' chips as Mult",
						"{C:inactive}(Currently: {C:mult}+#1#{C:inactive})"
					},
				},
			},
			["j_biblio_yuu"] = {
				["name"] = "Yuu Akimoto",
				["text"] = {
					{
						"Cards can have additional enhancements",
					},
					{
						"When a card with a base enhancement scores",
						"a random card in deck gains that enhancement",
					},
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
            },
            c_wheel_of_fortune={
                name="The Wheel of Fortune",
                text={
                    "{C:green}#1# in #2#{} chance to add",
                    "a random edition",
                    "to a random {C:attention}Joker",
                },
            },
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
		Other = {
			biblio_willful = {
				name = "Willful",
				label = "Willful",
				text = {
					"Burning for battle",
					"{C:red}Prevents death",
					"{C:inactive}({C:attention}#1#{C:inactive} global charges)"
				}
			},
			biblio_multienhance = {
				name = "Multi-enhanced",
				text = {
					"Possesses multiple",
					"enhancements"
				}
			}
		},
        ["Lore"] = { --NOTE TO FUTURE PEOPLE TAKING INSPIRATION: adding new categories for infoqueues isn't automatic; we had to patch it in, see lore.toml
            ["j_biblio_leaf"] = {
                name = "Leaf Saito",
                text = {
                    "A girl who found an interdimensional",
                    "travel machine and instantly",
                    "used it for escapism."
                }
            },
            ["j_biblio_leafX"] = {
                name = "Leaf, Stellar Dragoon",
                text = {
                    "The girl who wields",
                    "the pitch-dark power",
                    "of deep space."
                }
            },
			j_biblio_scarlex = {
				name = "Scarlex Aiello",
				text = {
					"A girl who pursues",
					"her ideals with",
					"obstinate determination."
				}
			},
			j_biblio_peri = {
				name = "Peri Nagato",
				text = {
					'"Let\'s go gambling~"'
				}
			},
			j_biblio_peri_EX = {
				name = "Peri, Abstract Heaven",
				text = {
					'"Hav{C:dark_edition}e{} you {C:chips}m{}et my new f{C:mult}r{}iend{C:biblio_enoughalready}?{}"'
				}
			}
        },
	},
}