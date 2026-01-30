SMODS.Consumable{
    set = 'Tarot',
    key = 'TAROT',
    name = "The TAROT",
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

            }
        }
    end,

    use = function(self, card, area, copier)
        
    end,

    in_pool = function (self, args)
        return true
    end
}