SMODS.Joker {
    key = "hallie_EX",
    name = "Hallie, Heart of Ember",
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "any_all",
    atlas = 'jokers',
    pos = {
        x = 11,
        y = 2
    },
    --[[
    soul_pos = {
        x = 4,
        y = 1
    },
    --]]
    rarity = 3,
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Minty"}
    end,
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
            burning = false,
            mult = 0
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
                card.ability.extra.mult,
                G.GAME.current_round.discards_used == 1 and localize("k_biblio_active_desc") or localize("k_biblio_inactive_desc")
            }
        }
    end,
    calculate = function(self, card, context)
        if card.ability.extra.active and context.pre_discard and not context.hook then
            if G.GAME.current_round.discards_used == 1 then
                card.ability.extra.active = false
                card.ability.extra.burning = true
                local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
                SMODS.smart_level_up_hand(card, text, false, 1)
                return nil, true
            end
        end

        if context.discard and card.ability.extra.burning then
            card.ability.extra.mult = card.ability.extra.mult + context.other_card:get_chip_bonus() --Not SMODS.scale_card'ing this one, can't be assed
            return {
                remove = true
            }
        end

        if context.joker_main and card.ability.extra.mult ~= 0 then
            return {
                mult = card.ability.extra.mult
            }
        end

        if context.biblio_post_discard then card.ability.extra.burning = false end

        if context.end_of_round and not card.ability.extra.active then
            card.ability.extra.active = true
            return {
                message = localize("k_reset")
            }
        end
    end
}