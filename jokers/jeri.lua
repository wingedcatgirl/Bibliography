local alphaplaceholder_base = {
    x = math.random(0, 8),
    y = 0
}
local alphaplaceholder_soul = {
    x = math.random(0, 21),
    y = 1
}

SMODS.Joker {
    key = "jeri",
    name = "Jeri Marsh, Chosen of Prophecy",
    --biblio_evolution = "j_biblio_jeri_EX",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_check = function (self, card, crucible) end,
    --biblio_crucible_effect = function (self, card, crucible) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = alphaplaceholder_base,
    soul_pos = alphaplaceholder_soul,
    rarity = 1,
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Minty", bcol = HEX("CA7CA7"), tcol = G.C.WHITE}
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
            percent = 2,
            amount = 0
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
                card.ability.extra.percent
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.amount = G.GAME.blind.chips * (card.ability.extra.percent/100)
        end

        if context.individual and context.cardarea == G.play and not context.end_of_round then
            local dec =  math.max(G.GAME.blind.chips * (card.ability.extra.percent/100), card.ability.extra.amount)
            card.ability.extra.amount = dec
            
            return {
                --message = localize("k_minty_shaked"),
                message_card = G.GAME.blind,
                func = function ()
                    local final_chips = G.GAME.blind.chips - dec
                    G.GAME.blind.chips = final_chips
                    G.E_MANAGER:add_event(Event({blocking = true, func = function()
                        G.GAME.blind:juice_up()
                        G.GAME.blind.chip_text = number_format(final_chips)
                        return true
                    end}))
                end
            }
        end
    end
}