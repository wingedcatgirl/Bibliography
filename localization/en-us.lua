return {
	["misc"] = {
		["dictionary"] = {
            k_biblio_jump = "Jumped!",
            k_biblio_land = "Landed!",
			k_biblio_lb = "Limit Break!",
			k_biblio_disbelief = "Don't believe you!",
			k_biblio_betteridea = "Better idea!",
			k_biblio_another_ex = "Another!",
			k_biblio_keepgoing_ex = "Keep going!",
			k_biblio_enhanced = "Enhanced!",
			k_biblio_healed = "Healed!",
			k_biblio_revived = "Revived!",
			k_biblio_banished = "Banished!",
			k_biblio_consumed = "C O N S U M E D",
			k_biblio_active_desc = "Active",
			k_biblio_inactive_desc = "Inactive",
			k_biblio_gone = "Gone!",
			k_biblio_baka = "Baka!",
			k_biblio_fellforit = "Fell for it!",
			k_biblio_failed_maybelie = "Didn't work...?",
			k_biblio_dotdotdot = "...", --Used as both placeholder for messages TBA and actual message for particularly taciturn cahracters

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
			k_biblio_unavailable = "UNAVAILABLE",

			--Boosters
			biblio_catcher = "Clown Catcher",
			biblio_starter = "Starter Pack",

			--Config options
			option_biblio_lorepop = "Show lore popups",
			option_biblio_nocred = "Disable credit badges",
			option_biblio_copysafe = "Silence unlicensed music",
			info_biblio_copysafe = {
				"Currently all unlicensed music",
				"is from video games, so it's",
				"*probably* safe, but streamers can",
				"click this to be extra cautious",
				"and/or if they've had bad experiences"
			},

			--Title chatter
			chatter_biblio_default = "It's Bibliography time!",
			chatter_j_biblio_emilia = "I'm dead! :D",
			chatter_j_biblio_scarlex = "I know what you're doing..."
		},
		["v_dictionary"] = {
            v_biblio_savedby = "Saved by #1#",
			v_biblio_credit = "#1#: #2#"
		},
		["v_text"] = {

		},
		achievement_names = {
			ach_biblio_cannibalism = "Can't escape the cannibal memes",
			ach_biblio_sparkling_elation = "Sparkling Elation",
			ach_biblio_baka = "Baka!",
			ach_biblio_negativity = "Unshakable Negativity",
		},
		achievement_descriptions = {
			ach_biblio_cannibalism = "Emilia expired like a bowl of Ramen",
			ach_biblio_sparkling_elation = "Peri became Negative and consumed herself",
			ach_biblio_baka = "Eiko met Cirno. Namecalling ensued.",
			ach_biblio_negativity = "As far as the eye can see.",
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
            k_biblio_unavailable = "UNAVAILABLE",
			biblio_multienhance = "Multi-enhanced",
			biblio_bound = "Bound",
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
				["name"] = {
					"Leaf",
					"{s:0.7}Stellar Dragoon"
				},
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
				["name"] = {
					"Scarlex Aiello",
					"{s:0.7}SOUL Reaper"
				},
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
				["name"] = {
					"Vivi Elakha",
					"{s:0.7}the Fae-Touched"
				},
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
				["name"] = {
					"Peri Nagato",
					"{s:0.7}Abstract Heaven"
				},
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
				["name"] = {
					"Hallie Mathews",
					"{s:0.7}Heart of Ember"
				},
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
			["j_biblio_daren"] = {
				["name"] = "Daren Mathews",
				["text"] = {
					"Go up to {C:red}-$#1#{} in debt",
					"If in debt at end of round",
					"lose {C:gold}$1{} and increase",
					"debt limit by {C:red}$#2#{}"
				},
			},
			["j_biblio_daren_EX"] = {
				["name"] = {
					"Daren Mathews",
					"{s:0.7}Sorrow's Silence"
				},
				["text"] = {
					{
						"Go up to {C:red}-$#1#{} in debt",
						"If in debt at end of round",
						"lose {C:gold}$1{} and increase",
						"debt limit by {C:red}$#2#{}"
					},
					{
						"{C:mult}+#3#{} Mult per dollar of debt",
						"{C:inactive}(Currently {C:mult}+#4#{C:inactive})"
					},
					{
						"Upon accumulating {C:mult}-$#5#{} of debt,",
						"{C:attention}-1{} Ante and set money to {C:gold}$0{}",
						"{C:red}self-destructs{}"
					}
				},
			},
			["j_biblio_emilia"] = {
				["name"] = "Emilia Mathews",
				["text"] = {
					"Ignore discard limits",
					"Expires after",
					"{C:attention}#1#{} extra discards"
				},
			},
			["j_biblio_emilia_EX"] = {
				["name"] = {
					"Emilia Mathews",
					"{s:0.7}Kindred Severed Neverwhere"
				},
				["text"] = {
					{
						"Ignore discard limits",
						"Expires after",
						"{C:attention}#1#{} extra discards"
					},
					{
						"If {C:mult}full discarding{},",
						"discarded cards gain",
						"{C:mult}+#2#{} Mult, {X:mult,C:white}X#3#{} Mult, or {C:gold}$#4#{}"
					},
					{
						"{C:inactive,s:0.8}Further Crucibles restore #5# discards"
					}
				},
			},
			["j_biblio_eiko"] = {
				["name"] = "Eiko",
				["text"] = {
					"Gains {X:mult,C:white}X#2#{} Mult for each",
					"consecutive hand played with",
					"{C:attention}High Card{} as most played hand",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})"
				},
			},
			["j_biblio_neo"] = {
				["name"] = "Aws. Neo Riptide",
				["text"] = {
					"Blinds {C:attention}always{}",
					"count as triggered"
				},
			},
			["j_biblio_ryan"] = {
				["name"] = "Ryan Akimoto",
				["text"] = {
					"{C:attention}Once per round {C:inactive}(currently: #1#)",
					"retrigger all scored cards",
					"if all played cards have",
					"Fibonacci values",
					"{C:inactive}(Ace, 2, 3, 5, 8){}"
				},
			},
			["j_biblio_amanda"] = {
				["name"] = "Amanda Murphy",
				["text"] = {
					"{C:green}Triples{} chance of",
					"{C:attention}#1#s{} breaking"
				},
			},
			["j_biblio_amanda_alt"] = {
				["name"] = "Amanda Murphy",
				["text"] = {
					"{C:green}Triples{} chance of",
					"{C:attention}#1#s{} breaking",
					"and {C:attention}#2#s{} going off"
				},
			},
			["j_biblio_amy"] = {
				["name"] = "Amy",
				["text"] = {
					"{C:inactive}(Does nothing...?)",
				},
			},
			["j_biblio_cirno"] = {
				["name"] = "Cirno",
				["text"] = {
					"{C:green}1 in #1#{} chance to",
					"retrigger played {C:attention}9s{}",
					"#2# times"
				},
			},
			["j_biblio_catkids"] = {
				["name"] = "Yui & Eiri",
				["text"] = {
					"{X:dark_edition,C:white}^#1#{} Mult if played",
					"hand contains a {C:attention}#2#{}"
				},
			},
			["j_biblio_wildfiresys"] = {
				["name"] = "Wildfire system",
				["text"] = {
					"{X:dark_edition,C:white}^#1#{} Mult if played",
					"hand contains a {C:attention}#2#{}"
				},
			},
			["j_biblio_hotelsora"] = {
				["name"] = "Hotel Sora",
				["text"] = {
					{
						"{X:dark_edition,C:white}^#1#{} Mult if played",
						"hand contains a {C:attention}#2#{}"
					},
					{
						"{X:dark_edition,C:white}^#3#{} Mult if played",
						"hand contains a {C:attention}#4#{}"
					},
				},
			},
			["j_biblio_rubysquad"] = {
				["name"] = "Ruby Squad",
				["text"] = {
					"{X:dark_edition,C:white}^#1#{} Mult if played",
					"hand contains a {C:attention}#2#{}"
				},
			},
			["j_biblio_straightemult"] = {
				["name"] = "?????",
				["text"] = {
					"{X:dark_edition,C:white}^#1#{} Mult if played",
					"hand contains a {C:attention}#2#{}"
				},
			},
            j_biblio_cedar = {
                name = "Cedar",
                text = {
                    {
						"{C:attention}-#2#{} Ante after skipping {C:attention}#1#{} {C:inactive}[#3#]{} {C:attention}Blinds{}",
                    	"{C:inactive}(Required skips increase each time)",
					},
                    {
						"{X:mult,C:white}X#6#{} more Mult for each Blind skipped",
                    	"{C:inactive}(Currently {X:mult,C:white}X#4#{} per round, {X:mult,C:white}X#5#{C:inactive} total){}"
					},
                }
            },
            j_biblio_cedar_ready = {
                name = "Cedar",
                text = {
                    {
						"{C:attention}-#2#{} Ante after skipping {C:attention}#1#{} {C:inactive}[#3#]{} {C:attention}Blinds{}",
                    	"{C:inactive}(Required skips increase each time)",
					},
                    {
						"{X:mult,C:white}X#6#{} more Mult for each Blind skipped",
                    	"{C:inactive}(Currently {X:mult,C:white}X#4#{} per round, {X:mult,C:white}X#5#{C:inactive} total){}"
					},
					{
						"Prevents Death, then",
						"sets Ante to {C:chips}#8#{} and {C:attention}reverts{} to Celebi"
					}
                }
            },
			j_biblio_micha = {
				name = "Micha",
				text = {
					{
						"At the end of the {C:attention}shop{},",
						"create a {C:dark_edition}Negative{} {C:tarot}Tarot{},",
						"{C:spectral}Spectral{} or {C:item}Item{} card",
					},
					{
						"{C:green}#1#%{} chance to create a",
						"{C:dark_edition}Negative{} Joker {C:attention}instead{}",
						"{C:inactive,s:0.8}(Odds can't be increased){}",
					},
					{
						"Whenever Ante {C:attention}decreases{}, add",
						"{C:dark_edition}Negative{} to a random playing card"
					}
				}
			},
			--HEY FUTURE MINTY, PUT NEW JOKERS ⬆️HERE⬆️ :P 
			j_biblio_template = {
				name = "Joker Template",
				text = {
					"Does something",
				},
			},
		},
		["Back"] = {
			b_biblio_party = {
				name = "Catcher Party",
				text = {
					"All Boosters are Catchers",
					"{C:attention}+2{} Booster size"
				}
			},
			b_biblio_library = {
				name = "Library Deck",
				text = {
					"Start with a free",
					"{C:attention,T:p_biblio_starter}Starter Pack{}"
				}
			}
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
			c_biblio_calmer = {
				name = "Catcher Calmer",
				text = {
					"The next {C:attention}#1#{} Catcher",
					"pack#2# will act like",
					"normal Booster packs"
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
			tag_biblio_starter = {
				name = "Starter Tag",
				text = {
                    "Gives a free",
                    "{C:attention}Starter Pack",
				}
			}
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
			},
			biblio_bound = {
				name = "Bound",
				label = "Bound",
				text = {
					"Takes {C:attention}no{} space",
					"Vanishes in {C:chips}#1#{} round#2#",
					"{C:mult}Indestructible{} otherwise"
				}
			},
			p_biblio_catcher_1 = {
				name = "Clown Catcher",
				text = {
					"Try your luck",
					"and/or skill! Grab",
					"{C:attention}#1#{} Bibliography Joker#3#",
					"from a selection of {C:attention}#2#{}!"
				}
			},
			p_biblio_starter = {
				name = "Starter Pack",
				text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:joker} Joker{} cards",
					"from {C:attention}Bibliography"
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
                name = "Stellar Dragoon",
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
			j_biblio_scarlex_EX = {
				name = "SOUL Reaper",
				text = {
					"The girl who will",
					"destroy anything to",
					"save her friends"
				}
			},
			j_biblio_peri = {
				name = "Peri Nagato",
				text = {
					'"Let\'s go gambling~"'
				}
			},
			j_biblio_peri_EX = {
				name = "Abstract Heaven",
				text = {
					'"Hav{C:dark_edition}e{} you {C:chips}m{}et my new f{C:mult}r{}iend{C:biblio_enoughalready}?{}"'
				}
			},
			j_biblio_vivi = {
				name = "Vivi Elakha",
				text = {
					"A wandering adventurer",
					"skilled in conjury",
					"and crafting."
				}
			},
			j_biblio_vivi_EX = {
				name = "the Fae-Touched",
				text = {
					"Savior of all existence,",
					"favorite of the fae King,",
					"champion of the Arcadion,",
					"...and stealer of pants, if",
					"the more outlandish tales",
					"can be believed."
				}
			},
			j_biblio_amanda = {
				name = "Amanda Murphy",
				text = {
					"A girl with supernaturally",
					"terrible luck. Just",
					"absolutely godawful.",
					"She refuses to handle",
					"firearms anymore."
				}
			},
			j_biblio_amy = {
				name = "Amy",
				text = {
					"She would probably",
					"be very upset that",
					"she has no image."
				}
			},
			j_biblio_hallie = {
				name = "Hallie Mathews",
				text = {
					"Anxious wreck of a",
					"kitten, and not for no",
					"reason. Burns things~"
				}
			},
			j_biblio_hallie_EX = {
				name = "Heart of Ember",
				text = {
					"Cooling swiftly, bleeding light",
					"Smold'ring softly, biding time",
					"Marching forward, left behind"
				}
			},
			j_biblio_daren = {
				name = "Daren Mathews",
				text = {
					"What happens when",
					"you have an impossible",
					"goal and zero sense"
				}
			},
			j_biblio_daren_EX = {
				name = "Sorrow's Silence",
				text = {
					"Desperate to reclaim",
					"his lost family",
					"he freely discards",
					"what he has now"
				}
			},
			j_biblio_emilia = {
				name = "Emilia Mathews",
				text = {
					"A life cut tragically",
					"short by nothing else",
					"but happenstance"
				}
			},
			j_biblio_emilia_EX = {
				name = "Kindred Severed Neverwhere",
				text = {
					"Forgotten footfalls,",
					"engraved in ash"
				}
			}
        },
	},
}