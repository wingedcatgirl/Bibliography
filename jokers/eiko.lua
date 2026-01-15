SMODS.Joker {
    key = "eiko",
    name = "Eiko",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
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
    rarity = 3,
    cost = 9, --baka baka, baka baka
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            xmult = 1.1,
            xmult_gain = 0.1
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
                card.ability.extra.xmult,
                card.ability.extra.xmult_gain
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end

        for k,v in pairs(G.GAME.hands) do
            if k ~= "High Card" and v.played > G.GAME.hands["High Card"].played then return false end
        end

        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_gain"
            })
            return {
                xmult = card.ability.extra.xmult,
                extra = {
                    func = function ()
                        card.ability.extra.xmult = 1
                    end,
                    message = localize("k_biblio_baka")
                }
            }
        end

        if context.before then
            local baka
            for k,v in pairs(G.GAME.hands) do
                if k ~= "High Card" and v.played > G.GAME.hands["High Card"].played then baka = true break end
            end

            if baka then
                card.ability.extra.xmult = 1
                return {
                    message = localize("k_biblio_baka")
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "xmult_gain"
                })
                return nil, true
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}