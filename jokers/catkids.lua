local alphaplaceholder_base = {
    x = math.random(0, 8),
    y = 0
}
local alphaplaceholder_soul = {
    x = math.random(0, 21),
    y = 1
}

local rarity = "biblio_unavailable"
if next(SMODS.find_mod("FusionJokers")) then
    rarity = "fuse_fusion"
    FusionJokers.fusions:register_fusion{
        jokers = {
            {name = "j_jolly"},
            {name = "j_sly"},
            {name = "j_duo"},
        }, cost = 8, result_joker = "j_biblio_catkids",
        requirement = function ()
            local showman = SMODS.showman("j_biblio_catkids")
            local has = not not next(SMODS.find_card("j_biblio_catkids"))
            return not has or showman
        end
    }
end

SMODS.Joker {
    key = "catkids",
    name = "Yui & Eiri",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_check = function (self, card, crucible) end,
    --biblio_crucible_effect = function (self, card, crucible) end,
    --pronouns = "",
    atlas = 'jokers',
    pos = alphaplaceholder_base,
    soul_pos = alphaplaceholder_soul,
    rarity = rarity,
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OCs", credit = "Minty", bcol = HEX("CA7CA7"), tcol = G.C.WHITE}
    end,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            hand = "Pair",
            emult = 1.2
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
                card.ability.extra.emult,
                localize(card.ability.extra.hand, "poker_hands")
            }
        }
    end,
    in_pool = function (self, args)
        return true, {allow_returning_components = true}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if next(context.poker_hands[card.ability.extra.hand]) then
                return {
                    emult = card.ability.extra.emult
                }
            end
        end
    end
}