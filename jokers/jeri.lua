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
    biblio_evolution = function (self, card, crucible)
        if card.ability.extra.stronger and false then --*hussie voice* ALT ISN'T DONE YET
            return "j_biblio_jeri_doomed"
        else
            return "j_biblio_jeri_EX"
        end
    end,
    biblio_evol_effect = function (self, newcard, oldextra)
        newcard.ability.extra.percent = oldextra.percent
    end,
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
            amount = 0,
            stronger = false
        },
        immutable = {
            percent = 2
        }
    },
    attributes = {
        "xblindsize"
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
            local dec = math.max(G.GAME.blind.chips * (card.ability.extra.percent/100), card.ability.extra.amount)
            card.ability.extra.amount = dec
            
            return {
                x_blind_size = math.max(1-card.ability.extra.percent, 1-(dec/G.GAME.blind.chips)),
                sound = "xblindsize",
                message = localize{type = 'variable', key = 'a_blind_size', vars = {"-"..card.ability.extra.percent.."%"}},
                remove_default_message = true,
            }
        end

        if not card.ability.extra.stronger then
            if card.ability.extra.percent > card.ability.immutable.percent then
                card.ability.extra.stronger = true
                BIBLIO.event(function ()
                    play_sound("biblio_dr_ominous")
                    --SMODS.calculate_effect({message = localize("k_biblio_stronger")}, card)
                    return true
                end)
            end
        end
    end
}