SMODS.Joker {
    key = "yuu",
    name = "Yuu Akimoto",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "he_him",
    atlas = 'jokers',
    pos = {
        x = 18,
        y = 2
    },
    --[[
    soul_pos = {
        x = 0,
        y = 1
    },
    --]]
    rarity = 3,
    set_badges = function (self, card, badges)
        if not self.discovered then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Kira", bcol = HEX("F51F95") }
    end,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
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
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.config.center.set == "Enhanced" then
            local enh = context.other_card.config.center.key
            local cards = {}
            for i,v in ipairs(G.playing_cards) do
                if v ~= context.other_card and not (v.config.center.key == enh or (v.ability.biblio_multienhance and v.ability.biblio_multienhance[enh])) then
                    cards[#cards+1] = v
                end
            end

            if #cards > 0 then
                local target = pseudorandom_element(cards, "biblio_yuu_enhance")

                return {
                    message = localize("k_biblio_enhanced"),
                    message_card = target,
                    extra = {
                        func = function ()
                            if target.config.center.set == "Default" then
                                target:set_ability(enh, nil, true)
                            else
                                BIBLIO.event(function ()
                                    target:add_sticker("biblio_multienhance", true)
                                    target.ability.biblio_multienhance[enh] = true
                                    return true
                                end)
                            end
                        end
                    }
                }
            end
        end

        if context.biblio_enable_multienhance then
            return {
                enable = true
            }
        end
    end
}