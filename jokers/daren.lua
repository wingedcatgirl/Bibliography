SMODS.Joker {
    key = "daren",
    name = "Daren Mathews",
    biblio_evolution = "j_biblio_daren_EX",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "he_him",
    atlas = 'jokers',
    pos = {
        x = 8,
        y = 2
    },
    --[[
    soul_pos = {
        x = 0,
        y = 1
    },
    --]]
    rarity = 1,
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Minty"}
    end,
    cost = 1,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            debt_limit = 10,
            debt_mod = 5,
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
                card.ability.extra.debt_limit,
                card.ability.extra.debt_mod
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return (G.GAME.biblio_emilia_expired or 0) > 0
    end,
    add_to_deck = function (self, card, from_debuff)
        G.GAME.bankrupt_at = (G.GAME.bankrupt_at or 0) - card.ability.extra.debt_limit
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.GAME.bankrupt_at = (G.GAME.bankrupt_at or 0) + card.ability.extra.debt_limit
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            if G.GAME.dollars + (G.GAME.dollar_buffer or 0) < 0 then
                return {
                    func = function ()
                        G.GAME.bankrupt_at = (G.GAME.bankrupt_at or 0) + card.ability.extra.debt_limit
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "debt_limit",
                            scalar_value = "debt_mod",
                            scaling_message = {
                                message_key = "k_biblio_dotdotdot"
                            }
                        })
                        G.GAME.bankrupt_at = (G.GAME.bankrupt_at or 0) - card.ability.extra.debt_limit
                    end,
                    dollars = -1,
                }
            end
        end
    end
}