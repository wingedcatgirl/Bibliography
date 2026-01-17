SMODS.Joker {
    key = "peri_EX",
    name = "Peri, Abstract Heaven",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 13,
        y = 2
    },
    --[[
    soul_pos = {
        x = 7,
        y = 1
    },
    --]]
    rarity = "biblio_ascended",
    set_badges = function (self, card, badges)
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "MP", bcol=G.C.BLACK }
    end,
    cost = 13,
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
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
            for i=1,card.ability.extra.number do
                SMODS.add_card{
                    key = "c_wheel_of_fortune",
                    area = G.consumeables,
                    edition = "e_negative"
                }
            end
        end

        if context.end_of_round and context.main_eval then
            local areas = {
                "jokers",
                "consumeables",
                "hand",
            }
            local triggered

            for _,area in ipairs(areas) do
                local consume = {}
                for __,vv in ipairs(G[area].cards) do
                    if (vv.edition or {}).negative and not SMODS.is_eternal(vv, card) then
                        consume[#consume+1] = vv
                    end
                end
                local num = #consume
                if num > 0 then
                    print(tostring(num))
                    G[area]:change_size(num)
                    SMODS.destroy_cards(consume)
                    triggered = true
                end
            end

            if triggered then
                return {
                    sound = "biblio_cronch",
                    message = localize("k_biblio_consumed")
                }
            end
        end
    end
}