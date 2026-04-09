SMODS.Joker {
    key = "amy_EX",
    name = "Amy, Bodyguard Unjester",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card, crucible) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 1,
        y = 4
    },
    --[[
    soul_pos = {
        x = 0,
        y = 1
    },
    --]]
    rarity = "biblio_evolved",
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Ozbourne", bcol = HEX("FF0000")}
    end,
    cost = 9,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            left = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        info_queue[#info_queue+1] = G.P_CENTERS.v_antimatter
        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                card.ability.extra.left
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.joker_type_destroyed and card.ability.extra.left > 0 then
            if context.card ~= card and context.card.config.center.set == "Joker" and not card.blocking then
                card.blocking = true
                return {
                    no_destroy = true,
                    extra = {
                        func = function ()
                            SMODS.calculate_effect({message = localize("k_biblio_blocked_ex")}, card)
                            SMODS.destroy_cards(card)
                        end
                    }
                }
            end

            if context.card == card and not card.unjested then
                card.unjested = true
                BIBLIO.event(function ()
                    if G.STATE == G.STATES.HAND_PLAYED then
                        if not G.redeemed_vouchers_during_hand then
                            G.redeemed_vouchers_during_hand =
                                CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
                        end
                        area = G.redeemed_vouchers_during_hand
                    else
                        area = G.play
                    end
                    local prev_state = G.STATE
                    
                    local antimatter = create_card("Voucher", area, nil, nil, nil, nil, "v_antimatter")
                    antimatter:start_materialize()
                    area:emplace(antimatter)
                    antimatter.cost = 0
                    antimatter.shop_voucher = false
                    local current_round_voucher = G.GAME.current_round.voucher
                    antimatter:redeem()
                    G.GAME.current_round.voucher = current_round_voucher
                    
                    G.STATE = prev_state
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0,
                        func = function()
                            antimatter:start_dissolve()
                            return true
                        end,
                    }))
                    return true
                end)
                return nil
            end
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.left = card.ability.extra.left - 1
            
            if card.ability.extra.left > 0 then
                SMODS.calculate_effect({message = localize("k_biblio_fading")}, card)
            else
                SMODS.destroy_cards(card, true, nil, true)
                G.GAME.banned_keys = G.GAME.banned_keys or {}
                G.GAME.banned_keys["j_biblio_amy"] = true
                G.GAME.banned_keys[self.key] = true
            end
        end
    end
}