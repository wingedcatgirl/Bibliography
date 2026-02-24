SMODS.Joker {
    key = "kris",
    name = "Kris Dreemurr",
    biblio_evolution = "j_biblio_kris_EX",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_check = function (self, card) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "they_them",
    atlas = 'jokers',
    pos = {
        x = 6,
        y = 4
    },
    soul_pos = {
        x = 6,
        y = 5
    },
    rarity = 2,
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "Character", credit = "Deltarune", bcol = HEX("b5e61d"), tcol = G.C.WHITE}
    end,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            soul_mod = 2,
            edition_mod = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
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
                card.ability.extra.edition_mod
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        -- No calculation; soul mod is in soul_increase.toml and edition mod is in hooks.lua
    end
}