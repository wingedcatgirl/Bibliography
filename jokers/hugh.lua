local alphaplaceholder_base = {
    x = math.random(0, 8),
    y = 0
}
local alphaplaceholder_soul = {
    x = math.random(0, 21),
    y = 1
}

SMODS.Joker {
    key = "hugh",
    name = "Hugh Morris",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_check = function (self, card, crucible) end,
    --biblio_crucible_effect = function (self, card, crucible) end,
    pronouns = "he_him",
    atlas = 'jokers',
    pos = alphaplaceholder_base,
    soul_pos = alphaplaceholder_soul,
    rarity = 3,
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "Character", credit = "Tomodachi Life", bcol = HEX("992121"), tcol = G.C.WHITE}
    end,
    cost = 9,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            luck = 1,
            odds = 5,
        }
    },
    attributes = {
        "chance", "hearts", "generation"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local luck, odds = SMODS.get_probability_vars(card, card.ability.extra.luck, card.ability.extra.odds, "biblio_hugh_morris", false)
        info_queue[#info_queue+1] = G.P_CENTERS.j_bloodstone
        info_queue[#info_queue+1] = {
            set = "Other",
            key = "biblio_bound",
            vars = {
                5, "s"
            }
        }
        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                luck, odds
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
            if SMODS.pseudorandom_probability(card, "biblio_hugh_morris", card.ability.extra.luck, card.ability.extra.odds) then
                return {
                    message = "!",
                    func = function ()
                        BIBLIO.event(function ()
                            SMODS.add_card{
                                area = G.jokers,
                                key = "j_bloodstone",
                                stickers = {
                                    "biblio_bound"
                                },
                                force_stickers = true,
                            }
                            return true
                        end)
                    end
                }
            else
                return nil,true
            end
        end
    end
}