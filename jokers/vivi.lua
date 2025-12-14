SMODS.Joker {
    key = "vivi",
    name = "Vivi Elakha",
    --biblio_evolution = "j_biblio_viviX",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 1,
        y = 0
    },
    soul_pos = {
        x = 0,
        y = 1
    },
    rarity = 2,
    cost = 8,
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
            curecost = 9,
            cureval = 1,
            raisecost = 54
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
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) then return false end
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

        if context.final_scoring_step and (G.GAME.current_round.hands_left < 1) and (G.GAME.blind.chips > G.GAME.chips) and card.ability.extra.mp >= card.ability.extra.raisecost then
            card.ability.extra.mp = card.ability.extra.mp - card.ability.extra.raisecost
            card.ability.extra.mpcap = card.ability.extra.mpcap + 6
            return {
                message = localize("k_biblio_revived"),
                func = function ()
                    ease_hands_played(G.GAME.round_resets.hands)
                    --SMODS.destroy_cards(card) --Should she self-destruct, or...?
                end
            }
        end
    end
}