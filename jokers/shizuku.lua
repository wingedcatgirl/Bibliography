local alphaplaceholder_base = {
    x = math.random(0, 8),
    y = 0
}
local alphaplaceholder_soul = {
    x = math.random(0, 21),
    y = 1
}

SMODS.Joker {
    key = "shizuku",
    name = "Shizuku Tsukishima",
    --biblio_evolution = "j_biblio_KEY",
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
        badges[#badges+1] = BIBLIO.credit_badge{type = "Character", credit = "Whisper of the Heart", bcol = HEX("5390DF"), tcol = G.C.WHITE}
    end,
    cost = 4,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            xmult = 3
        }
    },
    attributes = {
        "xmult", "meta"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local active = BIBLIO.ao3_datecheck()
        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                card.ability.extra.xmult,
                active and localize("k_biblio_active_desc") or localize("k_biblio_inactive_desc")
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return G.GAME.biblio_ao3_found
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if BIBLIO.ao3_datecheck() then
                return {
                    xmult = card.ability.extra.xmult,
                }
            else
                return {
                    message = localize("k_nope_ex")
                }
            end
        end
    end
}