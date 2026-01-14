SMODS.Sticker{
    key = "multienhance",
    badge_colour = HEX("CA7CA7"),
    --hide_badge = true, --Hiding the badge would skip the loc_vars step...
    --no_collection = true,
    default_compat = false,
    apply = function (self, card, val)
        if val then
            card.ability.biblio_multienhance = card.ability.biblio_multienhance or {}
        else
            card.ability.biblio_multienhance = nil
        end
    end,
    loc_vars = function (self, info_queue, card)
        if next(card.ability.biblio_multienhance or {}) then
            for k,_ in pairs(card.ability.biblio_multienhance) do
                info_queue[#info_queue+1] = G.P_CENTERS[k]
            end
        end
        return {
        }
    end
}