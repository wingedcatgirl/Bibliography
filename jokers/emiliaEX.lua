local alphaplaceholder_base = {
    x = math.random(0, 8),
    y = 0
}
local alphaplaceholder_soul = {
    x = math.random(0, 21),
    y = 1
}

SMODS.Joker {
    key = "emilia_EX",
    name = "Emilia Mathews",
    biblio_crucible_check = function (self, card)
        return card.ability.extra.regain > 0
    end,
    biblio_crucible_effect = function (self, card) 
        card.ability.extra.discards = card.ability.extra.discards + card.ability.extra.regain
        card.ability.extra.regain = card.ability.extra.regain - 1
        SMODS.calculate_effect({message = localize("k_biblio_healed") }, card)
    end,
    pronouns = "she_her",
    atlas = 'jokers',
        pos = alphaplaceholder_base,
        soul_pos = alphaplaceholder_soul,
    --[[
    pos = {
        x = 7,
        y = 2
    },
    soul_pos = {
        x = 7,
        y = 3
    },
    --]]
    rarity = "biblio_evolved",
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{credits = {
            {type = "OC", credit = "Minty"},
            --{type = "Art", credit = "GeorgeTheRat"}
        }}
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
            discards = 25,
            multmod = 2,
            xmultmod = 0.15,
            dollarmod = 1,
            regain = 10,
            upgrading = false
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
                card.ability.extra.discards,
                card.ability.extra.multmod,
                card.ability.extra.xmultmod,
                card.ability.extra.dollarmod,
                card.ability.extra.regain,
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
        if context.pre_discard and #context.full_hand == #G.hand.cards then
            card.ability.extra.upgrading = true
        end

        if context.discard then
            if #context.full_hand > (G.GAME.starting_params.discard_limit - card.ability.extra.discards) then
                local check
                for i,v in ipairs(context.full_hand) do
                    if i > (G.GAME.starting_params.discard_limit - card.ability.extra.discards) and v == context.other_card then
                        check = true
                    end
                end
                if card.ability.extra.upgrading then
                    local boost = pseudorandom_element({"mult", "xmult", "dollars"}, "biblio_emilia_ex_upgrade")
                    if boost == "mult" then
                        context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.multmod
                    elseif boost == "xmult" then
                        context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.xmultmod
                    elseif boost == "dollars" then
                        context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars + card.ability.extra.dollarmod
                    end
                    SMODS.calculate_effect({
                        message = localize("k_upgrade_ex"),
                        juice_card = card,
                        message_card = context.other_card,
                        delay = 0.2
                    }, card)
                end
                if not check then return nil end

                card.ability.extra.discards = card.ability.extra.discards - 1
                SMODS.change_discard_limit(-1)

                if card.ability.extra.discards <= 0 then
                    card.destroyed = true
                    BIBLIO.event(function ()
                        SMODS.destroy_cards(card, nil, true)
                        check_for_unlock{type = "joker_expired", key = self.key}
                        return true
                    end)
                    G.GAME.biblio_emilia_expired = (G.GAME.biblio_emilia_expired or 0) + 1
                    return {
                        message = localize("k_biblio_gone")
                    }
                else
                    return {
                        message = "!",
                        delay = 0.2,
                    }
                end
            end
        end

        if context.drawing_cards and card.ability.extra.upgrading then
            card.ability.extra.upgrading = false
        end
    end
}