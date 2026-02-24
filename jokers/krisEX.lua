SMODS.Joker {
    key = "kris_EX",
    name = "Kris Dreemurr, the Cage",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_check = function (self, card, crucible) end,
    biblio_crucible_effect = function (self, card, crucible)
        card.ability.extra.soul_mod = card.ability.extra.soul_mod + 0.5
        card.ability.extra.edition_mod = card.ability.extra.edition_mod + 1
    end,
    pronouns = "they_them",
    atlas = 'jokers',
    pos = {
        x = 7,
        y = 4
    },
    soul_pos = {
        x = 7,
        y = 5
    },
    rarity = "biblio_evolved",
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "Character", credit = "Deltarune", bcol = HEX("75fbed"), tcol = G.C.WHITE}
    end,
    cost = 12,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            soul_mod = 3,
            edition_mod = 8,
            soul_odds = 25
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local luck,odds = SMODS.get_probability_vars(card, 1, card.ability.extra.soul_odds, "biblio_kris_ex_soul_creat", false)
        info_queue[#info_queue+1] = G.P_CENTERS.c_soul
        local title = math.random(15)

        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                card.ability.extra.soul_mod,
                card.ability.extra.edition_mod,
                luck, odds,
                localize("k_biblio_kris_"..title)
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card:is_suit("Hearts") then
            if SMODS.pseudorandom_probability(card, "biblio_kris_ex_soul_creat", 1, card.ability.extra.soul_odds) then
                BIBLIO.event(function ()
                    SMODS.add_card{
                        set = "Spectral",
                        key = "c_soul",
                        area = G.consumeables
                    }
                    return true
                end)
            end
        end
    end
}