local alphaplaceholder_base = {
    x = math.random(0, 8),
    y = 0
}
local alphaplaceholder_soul = {
    x = math.random(0, 21),
    y = 1
}

SMODS.Joker {
    key = "jeri_EX",
    name = "Jeri Marsh, Melody ♪ Fateless",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_check = function (self, card, crucible) end,
    --biblio_crucible_effect = function (self, card, crucible) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = alphaplaceholder_base,
    soul_pos = alphaplaceholder_soul,
    rarity = "biblio_evolved",
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Minty", bcol = HEX("CA7CA7"), tcol = G.C.WHITE}
    end,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            percent = 2,
            left = 50
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
                card.ability.extra.percent,
                card.ability.extra.left
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and card.ability.extra.left > 0 then
            SMODS.scale_card(context.other_card, {
                ref_table = context.other_card.ability,
                ref_value = "perma_x_blind_size",
                scalar_table = card.ability.extra,
                scalar_value = "percent",
                operation = function (ref_table, ref_value, initial, change)
                    ref_table[ref_value] = (initial or 1) - (change/100)
                end,
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "left",
                scalar_value = "percent",
                operation = "-",
                no_message = true,
                block_overrides = {
                    message = true
                }
            })
            return nil, true
        end
        if context.after and card.ability.extra.left <= 0 then
            local pct = card.ability.extra.percent
            BIBLIO.event(function ()
                card:set_ability("j_biblio_jeri")
                card.ability.extra.percent = pct
                card.ability.immutable.percent = pct
                SMODS.calculate_effect({message = localize("k_biblio_reverted_ex"), message_card = card})
                return true
            end)
            return nil
        end
    end
}