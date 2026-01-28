SMODS.Joker {
    key = "neo",
    name = "Neo Riptide",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "rip_ript",
    atlas = 'jokers',
    pos = {
        x = 16,
        y = 2
    },
    --[[
    soul_pos = {
        x = 0,
        y = 1
    },
    --]]
    rarity = 2,
    set_badges = function (self, card, badges)
        if not self.discovered then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Kira", bcol = HEX("F51F95") }
    end,
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
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            G.GAME.blind.triggered = true
            return {
                message = localize("k_biblio_fellforit"),
                func = BIBLIO.event(function ()
                    G.GAME.blind:juice_up()
                    return true
                end)
            }
        end
    end
}