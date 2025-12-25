SMODS.Joker {
    key = "zenos",
    name = "Zenos yae Galvus",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    biblio_crucible_effect = function (self, card)
        G.GAME.zenos_banished = (G.GAME.zenos_banished or 0) + 1
        SMODS.calculate_effect({message = localize("k_biblio_banished") }, card)
        SMODS.destroy_cards(card)
    end,
    --pronouns = "",
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
    cost = 9,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        card_limit = 3,
        extra = {
            blind_size = 3,
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
                card.ability.card_limit,
                card.ability.extra.blind_size,
                card.ability.card_limit == 1 and "" or "s",
            }
        }
    end,
    in_pool = function (self, args)
        if (G.GAME.zenos_banished or 0) > 0 then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.blind.boss then
            local rnd = math.random(1,11)
            return {
                message = localize("k_biblio_zenos_"..rnd),
                func = function ()
                    --play_sound('minty_gunshot', 1)
                    G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    return true
                end
            }
        end
    end
}

--Better... but lacking nevertheless...