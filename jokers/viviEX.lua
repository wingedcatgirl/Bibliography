SMODS.Joker {
    key = "vivi_EX",
    name = "Vivi Elakha, the Fae-Touched",
    --biblio_evolution = "j_biblio_viviX",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 5,
        y = 2
    },
    --[[
    soul_pos = {
        x = 3,
        y = 1
    },
    --]]
    rarity = "biblio_evolved",
    set_badges = function (self, card, badges)
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Minty"}
    end,
    cost = 13,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            mp = 0,
            mpcap = 100,
            curecost = 6,
            cureval = 2,
            handcount = 0,
            curefreq = 3,
            raisecost = 40,
            active = true,
            lbcost = 108,
            glyph = 1,
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
                card.ability.extra.active and localize("k_biblio_active_desc") or localize("k_biblio_inactive_desc"),
                card.ability.extra.glyph,
                card.ability.extra.lbcost,
                card.ability.extra.handcount,
                card.ability.extra.curefreq
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.end_of_round and card.ability.extra.mp < card.ability.extra.mpcap then
            card.ability.extra.mp = card.ability.extra.mp + 1
        end

        if context.final_scoring_step then
            card.ability.extra.handcount = card.ability.extra.handcount + 1
        end

        if context.final_scoring_step and (card.ability.extra.handcount >= card.ability.extra.curefreq)  and (G.GAME.blind.chips > G.GAME.chips) and card.ability.extra.mp >= card.ability.extra.curecost then
            card.ability.extra.mp = card.ability.extra.mp - card.ability.extra.curecost
            card.ability.extra.mpcap = card.ability.extra.mpcap + 1
            card.ability.extra.handcount = 0
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
                end
            }
        end

        if context.game_over then
            card.ability.extra.mp = card.ability.extra.mp - card.ability.extra.lbcost
            local overcast = card.ability.extra.mp < 0
            return {
                saved = "k_biblio_revived",
                message = localize("k_biblio_lb"),
                sound = "biblio_xivlb",
                func = function ()
                    ease_ante(-card.ability.extra.glyph)
                    if overcast then
                        SMODS.destroy_cards(card)
                    end
                end
            }
        end

        if (not card.ability.extra.active) and context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.active = true
            return {
                message = localize("k_reset_ex")
            }
        end
    end
}