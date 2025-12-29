if not ((SMODS.Mods.MoreFluff or {}).can_load and (SMODS.Mods.MoreFluff.config or {})["45 Degree Rotated Tarot Cards"]) then
    return nil
end

SMODS.Consumable({
    object_type = "Consumable",
    set = "Rotarot",
    name = "The Crucible!",
    key = "rot_crucible",
    pos = { x = 0, y = 0 },
    config = {
        num = 1,
    },
    cost = 6,
    atlas = "rotarot_placeholder",
    unlocked = true,
    discovered = false,
    display_size = { w = 107, h = 107 },
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        local oldban = copy_table(G.GAME.banned_keys or {})

        for k,v in pairs(G.P_CENTERS) do
            if not (v.biblio_evolution or v.biblio_crucible_effect) then
                G.GAME.banned_keys[k] = true
            end
        end

        local capacity = G.jokers.config.card_limit - #G.jokers.cards
        for _=1, math.min(capacity, card.ability.num) do
            SMODS.add_card({
                set = "Jokers",
                key_append = "biblio_rot_crucible",
            })
        end

        G.GAME.banned_keys = oldban
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.num} }
    end
})