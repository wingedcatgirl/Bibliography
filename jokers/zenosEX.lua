SMODS.Joker {
    key = "zenos_EX",
    name = "Zenos viator Galvus",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card, crucible) end,
    pronouns = "he_him",
    atlas = 'jokers',
    pos = {
        x = 21,
        y = 2
    },
    --[[
    soul_pos = {
        x = 2,
        y = 1
    },
    --]]
    rarity = 3,
    set_card_type_badge = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[1] = create_badge(localize("k_biblio_ascended", "labels"), SMODS.Gradients.biblio_ascended, nil, 1.2)
        badges[#badges+1] = BIBLIO.credit_badge{type = "Character", credit = "Final Fantasy XIV"}
    end,
    cost = 12,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        card_limit = 3,
        extra = {
            blind_size = 3,
            slot_increase = 1,
            ante_increase = 1,
            can_willful = true
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
        if card.ability.extra.can_willful then
            info_queue[#info_queue + 1] = {
                set = "Other",
                key = "biblio_willful",
                specific_vars = {
                    G.GAME.biblio_willful or 6
                }
            }
        end
        return {
            key = key,
            vars = {
                card.ability.card_limit,
                card.ability.extra.blind_size,
                card.ability.extra.slot_increase,
                card.ability.extra.slot_increase == 1 and "" or "s",
                card.ability.extra.ante_increase,
                (card.ability.extra.ante_increase > 0 and "+") or (card.ability.extra.ante_increase < 0 and "-") or ""
            }
        }
    end,
    in_pool = function (self, args)
        if next(SMODS.find_card("j_biblio_zenos")) and not SMODS.showman(self.key) then return false end
        
        return (G.GAME.zenos_banished or 0) > 0
    end,
    add_to_deck = function (self, card, from_debuff)
        if not from_debuff then
            G.GAME.zenos_banished = math.max((G.GAME.zenos_banished or 1) - 1, 0)
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.blind.boss then
            local rnd = math.random(1,11)
            return {
                message = localize("k_biblio_zenos_ex_"..rnd),
                func = function ()
                    --play_sound('minty_gunshot', 1)
                    G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    return true
                end
            }
        end

        if context.modify_ante and context.ante_end then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "card_limit",
                scalar_table = card.ability.extra,
                scalar_value = "slot_increase"
            })

            return {
                modify = modify_ante + card.ability.extra.ante_increase
            }
        end

        if context.biblio_willful and context.willful_card == card then
            card.ability.extra.can_willful = false
            return {
                message = localize("k_biblio_zenos_willful")
            }
        end
    end
}

--Was this life a gift? Or a burden?