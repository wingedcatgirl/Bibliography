SMODS.Joker {
    key = "amanda",
    name = "Amanda Murphy",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 0,
        y = 1
    },
    rarity = 1,
    set_badges = function (self, card, badges)
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Ozbourne", bcol = HEX("FF0000"), tcol = G.C.WHITE}
    end,
    cost = 3,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key

        info_queue[#info_queue+1] = G.P_CENTERS.m_glass

        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                localize{type = "name_text", set = "Enhanced", key = "m_glass"}
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    set_ability = function (self, card, initial, delay_sprites)
        BIBLIO.event(function ()
            card:set_edition('e_polychrome', nil, BIBLIO.in_collection(card))
            return true
        end)
    end,
    calculate = function(self, card, context)
        if context.mod_probability and context.identifier == "glass" then
            return {
                numerator = context.numerator * 3
            }
        end
    end
}