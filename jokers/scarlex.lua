SMODS.Joker {
    key = "scarlex",
    name = "Scarlex Aiello",
    --biblio_evolution = "j_biblio_scarlex_EX",
    --biblio_evol_effect = function (self, newcard, oldvalues) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 0,
        y = 1
    },
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            luck = 1,
            odds = 3,
            dollars = 5,
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local luck, odds = SMODS.get_probability_vars(card, card.ability.extra.luck, card.ability.extra.odds, card, false)
        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                luck,
                odds,
                card.ability.extra.dollars,
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.pre_level_up and context.pre_level_up.amount > 0 then
            local oldamt, newamt = context.pre_level_up.amount, context.pre_level_up.amount
            for _=1,oldamt do
                if SMODS.pseudorandom_probability(card, "biblio_scar_lv_replace", card.ability.extra.luck, card.ability.extra.odds) then
                    newamt = newamt - 1
                    if context.pre_level_up.instant then ease_dollars(card.ability.extra.dollars) else
                        BIBLIO.event(function ()
                            ease_dollars(card.ability.extra.dollars)
                            return true
                        end)
                    end
                end
            end
            context.pre_level_up.amount = newamt
            return {
                message = (not context.pre_level_up.instant) and localize("k_biblio_disbelief") or nil
            }
        end
    end
}

local oldlvl = level_up_hand
level_up_hand = function (card, hand, instant, amount)
    local vals = {
        card = card, hand = hand, instant = instant, amount = amount or 1
    }
    SMODS.calculate_context{pre_level_up = vals}

    if vals.amount > 0 then
        oldlvl(vals.card, vals.hand, vals.instant, vals.amount)
    end
end