SMODS.Joker {
    key = "emilia",
    name = "Emilia Mathews",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 6,
        y = 2
    },
    --[[
    soul_pos = {
        x = 0,
        y = 1
    },
    --]]
    rarity = 1,
    set_badges = function (self, card, badges)
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Minty"}
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
            discards = 25
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
                card.ability.extra.discards
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return (G.GAME.biblio_emilia_expired or 0) <= 0
    end,
    add_to_deck = function (self, card, from_debuff)
        SMODS.change_discard_limit(card.ability.extra.discards)
    end,
    remove_from_deck = function (self, card, from_debuff)
        SMODS.change_discard_limit(-card.ability.extra.discards)
    end,
    calculate = function(self, card, context)
        if card.destroyed then return nil end
        if context.discard then
            if #context.full_hand > (G.GAME.starting_params.discard_limit - card.ability.extra.discards) then
                local check
                for i,v in ipairs(context.full_hand) do
                    if i > (G.GAME.starting_params.discard_limit - card.ability.extra.discards) and v == context.other_card then
                        check = true
                    end
                end
                if check then return nil end

                card.ability.extra.discards = card.ability.extra.discards - 1
                SMODS.change_discard_limit(-1)

                if card.ability.extra.discards <= 0 then
                    card.destroyed = true
                    BIBLIO.event(function ()
                        SMODS.destroy_cards(card, nil, true)
                        return true
                    end)
                    G.GAME.biblio_emilia_expired = (G.GAME.biblio_emilia_expired or 0) + 1
                    return {
                        message = localize("k_biblio_gone")
                    }
                else
                    return {
                        message = "!"
                    }
                end
            end
        end
    end
}