SMODS.Joker {
    key = "hallie",
    name = "Hallie Mathews",
    --biblio_evolution = "j_biblio_hallie_EX",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "any_all",
    atlas = 'jokers',
    pos = {
        x = 1,
        y = 0
    },
    soul_pos = {
        x = 10,
        y = 1
    },
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            active = true,
            burning = false
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local luck,odds = SMODS.get_probability_vars(card, 1, (G.STAGE == G.STAGES.RUN) and G.GAME.current_round.discards_left or "N")
        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                luck, odds,
                card.ability.extra.active and localize("k_biblio_active_desc") or localize("k_biblio_inactive_desc")
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if card.ability.extra.active and context.pre_discard and not context.hook then
            local level
            local luck,odds = SMODS.get_probability_vars(card, 1, G.GAME.current_round.discards_left)
            if pseudorandom("biblio_hallie_level", luck, odds) == 1 or luck > odds then
                level = true
                if luck >= odds then card.ability.extra.burning = true end
            end

            if level then
                local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
                card.ability.extra.active = false
                return {
                    level_up = true,
                    level_up_hand = text
                }
            end
        end

        if context.discard and card.ability.extra.burning then
            return {
                remove = true
            }
        end

        if context.after then card.ability.extra.burning = false end

        if context.end_of_round and not card.ability.extra.active then
            card.ability.extra.active = true
            return {
                message = localize("k_reset_ex")
            }
        end
    end
}