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
        if not (self.discovered or card.bypass_discovery_ui) then return end
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

    add_to_deck = function (self, card, from_debuff)
        local found = false
        local juice_em = #SMODS.find_card(self.key) == 0
        for i,v in ipairs(G.jokers.cards) do
            if BIBLIO.can_crucible(v) then
                found = true
                if juice_em then
                    juice_card_until(v,function ()
                        return #SMODS.find_card(self.key) > 0
                    end)
                end
            end
        end
        for i,v in ipairs(G.consumeables.cards) do
            if BIBLIO.can_crucible(v) then
                found = true
                if juice_em then
                    juice_card_until(v,function ()
                        return #SMODS.find_card(self.key) > 0
                    end)
                end
            end
        end
        if found then
            juice_card_until(card, function ()
                if card.REMOVED then return false end
                for i,v in ipairs(G.jokers.cards) do
                    if BIBLIO.can_crucible(v) then
                        return true
                    end
                end
            end)
        end
    end,
    load = function (self, card, card_table, other_card)
        BIBLIO.event(function ()
            if #SMODS.find_card(self.key, true) == 0 then return false end
            local found = false
            local juice_em = (card == SMODS.find_card(self.key)[1])
            for i,v in ipairs(G.jokers.cards) do
                if BIBLIO.can_crucible(v) then
                    found = true
                    if juice_em then
                        juice_card_until(v,function ()
                            return #SMODS.find_card(self.key) > 0
                        end)
                    end
                end
            end
            for i,v in ipairs(G.consumeables.cards) do
                if BIBLIO.can_crucible(v) then
                    found = true
                    if juice_em then
                        juice_card_until(v,function ()
                            return #SMODS.find_card(self.key) > 0
                        end)
                    end
                end
            end
            if found then
                card.juiceing = true
                juice_card_until(card, function ()
                    if card.REMOVED then return false end
                    for i,v in ipairs(G.jokers.cards) do
                        if BIBLIO.can_crucible(v) then
                            return true
                        end
                    end
                    card.juiceing = false
                end)
            end
            return true
        end, {blocking = false, blockable = false})
    end,

    can_use = function (self,card)
        local cards = BIBLIO.get_all_highlighted(card, {"jokers", "consumeables"})
        if #cards > card.ability.max_highlighted then return false end

        for _,v in ipairs(cards) do
            if not BIBLIO.can_crucible(v) then
                return false
            end
        end
        return #cards > 0
    end,

    use = function(self, card, area, copier)
        local cards = BIBLIO.get_all_highlighted(card, {"jokers", "consumeables"})

        for _,v in ipairs(cards) do
            local oldkey = v.config.center.key
            local evol
            if type(v.config.center.biblio_evolution) == "function" then
                evol = v.config.center:biblio_evolution(v, card)
            elseif type(v.config.center.biblio_evolution) == "table" then
                evol = pseudorandom_element(v.config.center.biblio_evolution, "biblio_select_"..card.config.center.key)
            elseif type(v.config.center.biblio_evolution) == "string" then
                evol = v.config.center.biblio_evolution
            elseif type(v.config.center.biblio_evolution) ~= "nil" then
                error("Bibliography: Invalid configuration of evolution data on "..card.config.center.key)
            end
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
                            if G.P_CENTERS[evol].locked then unlock_card(G.P_CENTERS[evol]) end
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
                elseif Jen and BIBLIO.marblecheck[G.jokers.highlighted[i].config.center.key] then
                    SMODS.add_card{
                        key = "j_jen_godsmarble"
                    }
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
    calculate = function (self, card, context)
        if context.card_added then
            if card == SMODS.find_card(self.key)[1] then
                if BIBLIO.can_crucible(context.card) then
                    juice_card_until(context.card, function ()
                        return #SMODS.find_card(self.key) > 0
                    end)
                end
            end
            if not card.juiceing then
                card.juiceing = true
                juice_card_until(card, function ()
                    if card.REMOVED then return false end
                    for i,v in ipairs(G.jokers.cards) do
                        if BIBLIO.can_crucible(v) then
                            return true
                        end
                    end
                    card.juiceing = false
                end)
            end
        end
    end,

    in_pool = function (self, args)
        return true
    end
}