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
            {name = "j_mad"},
            {name = "j_clever"},
            {name = "j_family"},
        }, cost = 8, result_joker = "j_biblio_hotelsora",
        requirement = function ()
            local showman = SMODS.showman("j_biblio_hotelsora")
            local has = not not next(SMODS.find_card("j_biblio_hotelsora"))
            return not has or showman
        end
    }
end

SMODS.Joker {
    key = "hotelsora",
    name = "Hotel Sora",
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
        badges[#badges+1] = BIBLIO.credit_badge{type = "Characters", credit = "Kingdom Hearts", bcol = G.C.RED, tcol = G.C.WHITE}
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
            hand1 = "Two Pair",
            emult1 = 0.15,
            hand2 = "Four of a Kind",
            emult2 = 0.4
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
                card.ability.extra.emult1,
                localize(card.ability.extra.hand1, "poker_hands"),
                card.ability.extra.emult2,
                localize(card.ability.extra.hand2, "poker_hands"),
            }
        }
    end,
    in_pool = function (self, args)
        return true, {allow_returning_components = true}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local emult = 1
            if next(context.poker_hands[card.ability.extra.hand1]) then
                emult = emult + card.ability.extra.emult1
            end
            if next(context.poker_hands[card.ability.extra.hand2]) then
                emult = emult + card.ability.extra.emult2
            end
            if emult > 1 then
                return {
                    emult = emult
                }
            end
        end
    end
}