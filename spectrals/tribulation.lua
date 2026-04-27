SMODS.Consumable{
    set = 'Spectral',
    key = 'tribulation',
    name = "Tribulation",
    atlas = 'spectrals',
    pos = {
        x = 5,
        y = 3
    },
    config = {
        max_highlighted = 2
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
        return G.P_CENTERS.c_biblio_crucible.add_to_deck(self, card, from_debuff)
    end,
    load = function (self, card, card_table, other_card)
        return G.P_CENTERS.c_biblio_crucible.load(self, card, card_table, other_card)
    end,

    can_use = function (self, card)
        return G.P_CENTERS.c_biblio_crucible.can_use(self, card)
    end,
    keep_on_use = function (self, card)
        return G.P_CENTERS.c_biblio_crucible.keep_on_use(self, card)
    end,

    use = function(self, card, area, copier)
        return G.P_CENTERS.c_biblio_crucible.use(self, card, area, copier)
    end,

    in_pool = function (self, args)
        return true
    end
}