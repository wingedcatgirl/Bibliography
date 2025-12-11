SMODS.Joker {
    key = "newjoker",
    name = "New Joker",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    --pronouns = "",
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
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            
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
                
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        -- Calculation goes here
    end
}