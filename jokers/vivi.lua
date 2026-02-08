SMODS.Joker {
    key = "vivi",
    name = "Vivi Elakha",
    biblio_evolution = "j_biblio_vivi_EX",
    biblio_evol_effect = function (self, newcard, oldextra)
        newcard.ability.extra.mp = oldextra.mp
        newcard.ability.extra.mpcap = oldextra.mpcap
    end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 4,
        y = 2
    },
    --[[
    soul_pos = {
        x = 16,
        y = 1
    },
    --]]
    rarity = 2,
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Minty"}
    end,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            mp = 0,
            mpcap = 100,
            curecost = 9,
            cureval = 1,
            raisecost = 54,
            active = true
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
                card.ability.extra.mp,
                card.ability.extra.mpcap,
                card.ability.extra.curecost,
                card.ability.extra.cureval,
                card.ability.extra.cureval == 1 and "" or "s",
                card.ability.extra.raisecost,
                card.ability.extra.active and localize("k_biblio_active_desc") or localize("k_biblio_inactive_desc")
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.end_of_round and card.ability.extra.mp < card.ability.extra.mpcap then
            card.ability.extra.mp = card.ability.extra.mp + 1
        end

        if context.final_scoring_step and G.GAME.current_round.hands_played == 1 and (G.GAME.blind.chips > G.GAME.chips) and card.ability.extra.mp >= card.ability.extra.curecost then
            card.ability.extra.mp = card.ability.extra.mp - card.ability.extra.curecost
            card.ability.extra.mpcap = card.ability.extra.mpcap + 1
            return {
                message = localize("k_biblio_healed"),
                func = function ()
                    ease_hands_played(card.ability.extra.cureval)
                end
            }
        end

        if context.final_scoring_step and card.ability.extra.active and (G.GAME.current_round.hands_left < 1) and (G.GAME.blind.chips > G.GAME.chips) and card.ability.extra.mp >= card.ability.extra.raisecost then
            card.ability.extra.mp = card.ability.extra.mp - card.ability.extra.raisecost
            card.ability.extra.mpcap = card.ability.extra.mpcap + 6
            card.ability.extra.active = false
            return {
                message = localize("k_biblio_revived"),
                func = function ()
                    ease_hands_played(G.GAME.round_resets.hands)
                    --SMODS.destroy_cards(card) --Should she self-destruct, or...?
                end
            }
        end

        if (not card.ability.extra.active) and context.ante_end then
            card.ability.extra.active = true
            return {
                message = localize("k_reset")
            }
        end
    end
}