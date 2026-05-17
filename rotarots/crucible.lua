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
        local olddie = {}
        for k, v in pairs(SMODS.Rarities) do --Temporarily set all rarities' disable-if-empty flag to true
            olddie[k] = v.disable_if_empty   --Save the original values before changing them
            v.disable_if_empty = true
        end


        local capacity = G.jokers.config.card_limit - #G.jokers.cards
        for i = 1, math.min(capacity, card.ability.num) do
            local joker = SMODS.poll_object {
                type = "Joker",
                filter = function(pool)
                    local newpool = {}
                    for _, item in ipairs(pool) do
                        local center = G.P_CENTERS[item.key]
                        if center and (center.biblio_evolution or center.biblio_crucible_effect) then
                            newpool[#newpool + 1] = item
                        end
                    end
                    return #newpool > 0 and newpool or {{type = "Joker", key = not G.GAME.pool_flags.gros_michel_extinct and "j_gros_michel" or "j_cavendish"}} --If you're out of evolveable Jokers, have a banan instead~
                end
            }
            SMODS.add_card({
                set = "Joker",
                key = joker
            })
        end

        for k, v in pairs(SMODS.Rarities) do
            v.disable_if_empty = olddie[k] --Restore the original values
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.num } }
    end
})
