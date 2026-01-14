SMODS.Joker {
    key = "peri",
    name = "Peri Nagato",
    biblio_evolution = "j_biblio_peri_EX",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 7,
        y = 0
    },
    soul_pos = {
        x = 8,
        y = 1
    },
    rarity = 3,
    set_badges = function (self, card, badges)
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "MP"}
    end,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            number = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        info_queue[#info_queue+1] = {
            set = "Edition",
            key = "e_negative_generic",
            config = {
                extra = 1
            }
        }
        local luck, odds = SMODS.get_probability_vars(card, 1, G.P_CENTERS.c_wheel_of_fortune.config.extra, "wheel_of_fortune")
        info_queue[#info_queue+1] = {
            set = "Tarot",
            key = "c_wheel_of_fortune",
            vars = {
                luck, odds
            }
        }
        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                card.ability.extra.number,
                card.ability.extra.number == 1 and "" or "s"
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
            for i=1,card.ability.extra.number do
                local cardbag = {}
                for _,v in ipairs(G.consumeables.cards) do
                    if not v.edition then
                        cardbag[#cardbag+1] = v
                    end
                end
                if #cardbag > 0 then
                    local target = pseudorandom_element(cardbag, "biblio_peri")
                    target:set_edition("e_negative")
                end
            end
        end
    end
}