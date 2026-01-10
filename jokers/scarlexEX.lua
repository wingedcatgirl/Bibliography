SMODS.Joker {
    key = "scarlex_EX", --Shoulda known this naming scheme would get me, Scar is like my top 2 blorbos from my brain rn :v
    name = "Scarlex, SOUL Reaper",
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 5,
        y = 0
    },
    soul_pos = {
        x = 2,
        y = 1
    },
    rarity = "biblio_evolved",
    cost = 12,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            norecurse = false
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local _handname, _played, _order = 'High Card', -1, 100
        for k, v in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(k) and (v.played > _played or (v.played == _played and _order > v.order)) then 
                _played = v.played
                _handname = k
                _order = v.order
            end
        end
        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                _handname
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.pre_level_up and not card.ability.extra.norecurse then
            --[[ yk what i just can't be bothered making it emit exactly one message after a black hole
            if context.pre_level_up.card.config.center.key == "c_black_hole" and not card.ability.extra.one then
                card.ability.extra.one = true
                BIBLIO.event(function ()
                    SMODS.calculate_effect({message = "Need a hand?" }, card)
                    return true
                end)
            end
            if context.pre_level_up.card.config.center.key ~= "c_black_hole" then
                card.ability.extra.one = false
            end
            ]]
            --BIBLIO.say("intervening in level up yay")
            --G.GAME.immutable_level = (G.GAME.immutable_level or 0) + 1
            local effect = pseudorandom_element({"double", "redirect", "additional"}, "biblio_scar_EX_effect")
            if effect == "double" then
                --BIBLIO.say("doublin ur hand")
                return {
                    multiply = 2,
                    message = localize("k_upgrade_ex"),
                }
            elseif effect == "redirect" then
                --BIBLIO.say("redirecting ur hand")
                local _handname, _played, _order = 'High Card', -1, 100
                for k, v in pairs(G.GAME.hands) do
                    if SMODS.is_poker_hand_visible(k) and (v.played > _played or (v.played == _played and _order > v.order)) then 
                        _played = v.played
                        _handname = k
                        _order = v.order
                    end
                end
                return {
                    message = localize("k_biblio_betteridea"),
                    redirect = _handname,
                }
            elseif effect == "additional" then
                --BIBLIO.say("leveling another hand")
                local hands = {}
                for k, v in pairs(G.GAME.hands) do
                    if SMODS.is_poker_hand_visible(k) then 
                        hands[#hands+1] = k
                    end
                end
                local hand = pseudorandom_element(hands, "biblio_scar_EX_rando")
                return {
                    additional = {
                        hand = hand,
                        amount = context.pre_level_up.amount or 1,
                        message = localize("k_again_ex"),
                    },
                }
            end
        end
    end
}