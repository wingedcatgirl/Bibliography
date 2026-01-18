SMODS.Joker {
    key = "amy",
    name = "Amy",
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
    rarity = 1,
    set_badges = function (self, card, badges)
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Ozbourne", bcol = HEX("FF0000"), tcol = G.C.WHITE}
    end,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    demicoloncompat = false,
    config = {
        extra = {
            
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
                
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    add_to_deck = function (self, card, from_debuff)
        if from_debuff then return end

        --lightly modified from Cryptid's Trade spectral
        local area
        if G.STATE == G.STATES.HAND_PLAYED then
            if not G.redeemed_vouchers_during_hand then
                G.redeemed_vouchers_during_hand =
                    CardArea(G.play.T.x, G.play.T.y, G.play.T.w, G.play.T.h, { type = "play", card_limit = 5 })
            end
            area = G.redeemed_vouchers_during_hand
        else
            area = G.play
        end
        local blank = create_card("Voucher", area, nil, nil, nil, nil, "v_blank")
        blank:start_materialize()
        area:emplace(blank)
        blank.cost = 0
        blank.shop_voucher = false
        local current_round_voucher = G.GAME.current_round.voucher
        blank:redeem()
        G.GAME.current_round.voucher = current_round_voucher
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0,
            func = function()
                blank:start_dissolve()
                return true
            end,
        }))
    end,
    calculate = function(self, card, context)
        -- Calculation goes here
    end
}