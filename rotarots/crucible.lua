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

        local olddie = {}
        for k,v in pairs(SMODS.Rarities) do --Temporarily set all rarities' disable-if-empty flag to true
            olddie[k] = v.disable_if_empty --Save the original values before changing them
            v.disable_if_empty = true
        end

        for k,v in pairs(G.P_CENTERS) do
            if not (v.biblio_evolution or v.biblio_crucible_effect) then
                G.GAME.banned_keys[k] = true
            end
        end


        local capacity = G.jokers.config.card_limit - #G.jokers.cards
        for _=1, math.min(capacity, card.ability.num) do
            local rarity = SMODS.poll_rarity("Joker", "biblio_rot_crucible_rarity".._)
            local vrarities = {
                [1] = "Common",
                [2] = "Uncommon",
                [3] = "Rare"
            }
            rarity = vrarities[rarity] or rarity
            local pool = SMODS.get_clean_pool("Joker", rarity, nil, "biblio_rot_crucible")
            local tries = 0
            while (#pool == 1 and pool[1] == "j_joker") and tries < 100 do
                BIBLIO.say("Rarity "..rarity.." has no jokers, rerolling...")
                rarity = SMODS.poll_rarity("Joker", "biblio_rot_crucible_rarity".._..tries)
                pool = SMODS.get_clean_pool("Joker", rarity, nil, "biblio_rot_crucible")
                tries = tries + 1
            end
            local joker = pseudorandom_element(pool, "biblio_rot_crucible_joker")
            SMODS.add_card({
                set = "Joker",
                key = joker
            })
        end

        for k,v in pairs(SMODS.Rarities) do
            v.disable_if_empty = olddie[k] --Restore the original values
        end
        G.GAME.banned_keys = oldban
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.num} }
    end
})