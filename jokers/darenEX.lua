local alphaplaceholder_base = {
    x = math.random(0, 8),
    y = 0
}
local alphaplaceholder_soul = {
    x = math.random(0, 21),
    y = 1
}

SMODS.Joker {
    key = "daren_EX",
    name = "Daren Mathews, Sorrow's Silence",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    --pronouns = "",
    atlas = 'jokers',
    pos = alphaplaceholder_base,
    soul_pos = alphaplaceholder_soul,
    rarity = "biblio_evolved",
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Minty", bcol = HEX("CA7CA7"), tcol = G.C.WHITE}
    end,
    cost = 11,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            debt_limit = 10,
            debt_mod = 5,
            multrate = 1,
            target = -100
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local mult = card.ability.extra.multrate * (math.min(G.GAME.dollars or 0,0))
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
                card.ability.extra.debt_mod,
                card.ability.extra.multrate,
                mult,
                -card.ability.extra.target
            }
        }
    end,
    in_pool = function (self, args)
        return false
    end,
    add_to_deck = function (self, card, from_debuff)
        G.GAME.bankrupt_at = (G.GAME.bankrupt_at or 0) - card.ability.extra.debt_limit
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.GAME.bankrupt_at = (G.GAME.bankrupt_at or 0) + card.ability.extra.debt_limit
    end,
    calculate = function(self, card, context)
        if context.money_altered then
            if G.GAME.dollars + (G.GAME.dollar_buffer or 0) + context.amount <= card.ability.extra.target then
                return {
                    func = function ()
                        BIBLIO.event(function ()
                            if G.GAME.dollars + (G.GAME.dollar_buffer or 0) > card.ability.extra.target then return true end --Daren's ability has an “intervening ‘if’ clause.” That means (1) the ability won’t trigger at all unless you are going to be at least $100 in debt after money changes, and (2) the ability will do nothing unless you are still at least $100 in debt at the time the ability resolves.
                            --... haha, funny TCG reference. And never mind that it'd better suit his kid.

                            ease_ante(-1)
                            ease_dollars(-G.GAME.dollars, true)
                            SMODS.calculate_effect({message = localize("k_biblio_gone")}, card)
                            SMODS.destroy_cards(card, true, false, true)
                            return true
                        end)
                    end
                }
            end
        end

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