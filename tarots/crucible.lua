

SMODS.Consumable{
    set = 'Tarot',
    key = 'crucible',
    name = "The Crucible",
    atlas = 'tarots',
    pos = {
        x = 3,
        y = 3
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Tarot?", get_type_colour(self or card.config, card), nil, 1.2)
    end,

    config = {
        max_highlighted = 1
    },

    loc_vars = function(self, info_queue, card)
		local key = self.key
        if G.localization.descriptions.Lore[key] then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                card.ability.max_highlighted,
                card.ability.max_highlighted == 1 and "" or "s"
            }
        }
    end,

    can_use = function (self,card)
        local cards = BIBLIO.get_all_highlighted(card, {"jokers", "consumeables"})
        if #cards > card.ability.max_highlighted then return false end

        for _,v in ipairs(cards) do
            if not (v.config and v.config.center and (v.config.center.biblio_evolution or type(v.config.center.biblio_crucible_effect) == "function")) then
                return false
            end
        end
        return #cards > 0
    end,

    use = function(self, card, area, copier)
        local cards = BIBLIO.get_all_highlighted(card, {"jokers", "consumeables"})

        for _,v in ipairs(cards) do
            local oldkey = v.config.center.key
            local evol = v.config.center.biblio_evolution
            local values = type(v.ability.extra) == "table" and copy_table(v.ability.extra) or {}
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.2)
            for i = 1, #G.jokers.highlighted do
                if evol then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers.highlighted[i]:juice_up(0.3, 0.5)
                            G.jokers.highlighted[i]:set_ability(evol)
                            if type(G.P_CENTERS[oldkey].biblio_evol_effect) == "function" then
                                G.P_CENTERS[oldkey]:biblio_evol_effect(v, values)
                            end
                            return true
                        end
                    }))
                elseif type(v.config.center.biblio_crucible_effect) == "function" then
                    BIBLIO.event(function ()
                        G.P_CENTERS[oldkey]:biblio_crucible_effect(v)
                        return true
                    end)
                end
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.jokers:unhighlight_all()
                return true
            end
        }))
    end,

    in_pool = function (self, args)
        return true
    end
}