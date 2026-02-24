SMODS.Consumable{
    set = 'Tarot',
    key = 'calmer',
    name = "The Catcher Calmer",
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
        count = 1
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
                card.ability.count,
                card.ability.count == 1 and "" or "s",
                card.ability.count == 1 and "a " or ""
            }
        }
    end,
    select_card = "consumeables",

    calculate = function (self, card, context)
        if context.biblio_catcher_started then
            if not G.GAME.biblio_catcher_calmed then
                G.GAME.biblio_catcher_calmed = true
                SMODS.calculate_effect({message = localize("k_biblio_calmed")}, card, false)
                card.ability.count = card.ability.count - 1
                if card.ability.count <= 0 then
                    SMODS.destroy_cards(card, true, true, true)
                end
            end
        end
    end,

    in_pool = function (self, args)
        return true
    end
}