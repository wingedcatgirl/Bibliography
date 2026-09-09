local alphaplaceholder_base = {
    x = math.random(0, 8),
    y = 0
}
local alphaplaceholder_soul = {
    x = math.random(0, 21),
    y = 1
}

local function date_mod()
    local mod = 1
    local time = os.date("*t")
    time.hour, time.min, time.sec, time.yday = nil,nil,nil,nil
    for k,v in pairs(time) do
        if tostring(v):find("9") then mod = mod * 3 end
    end

    return math.min(mod, 9)
end

SMODS.Joker {
    key = "cirno",
    name = "Cirno",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card, crucible) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = alphaplaceholder_base,
    soul_pos = alphaplaceholder_soul,
    rarity = 1,
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "Character", credit = "Touhou", bcol = HEX("50ffe8"), tcol = G.C.WHITE}
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
            count = 9,
            odds = 9,
        }
    },
    attributes = {
        "retrigger", "rank", "chance", "nine", "meta"
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "cirno_retrigger", false)
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
                card.ability.extra.count
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    add_to_deck = function (self, card, from_debuff)
        if next(SMODS.find_card("j_biblio_eiko")) or next(SMODS.find_card("j_biblio_eiko_EX")) then
            check_for_unlock{type = "joker_set", set = "ach_biblio_baka"}
        end
    end,
    calculate = function(self, card, context)
        if context.repetition and context.other_card:get_id() == SMODS.Ranks["9"].id then --Remember to update this when quantum ranks get invented
            if SMODS.pseudorandom_probability(card, "cirno_retrigger", 1, card.ability.extra.odds) then
                return {
                    repetitions = 1,
                    extra = {
                        repetitions = card.ability.extra.count-1,
                        remove_default_message = true
                    }
                }
            end
        end

        if context.mod_probability and context.trigger_obj == card then
            return {
                numerator = context.numerator * date_mod()
            }
        end
    end
}