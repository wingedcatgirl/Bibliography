SMODS.Booster{
    key = "starter",
    discovered = false,
    group_key = "biblio_starter",
    kind = "biblio_starter",
    atlas = "boosters",
    pos = {x = 0, y = 2},
    config = {
        extra = 7, --Increase to 9 once we have more Jokers
        choose = 1,
        music = "biblio_music_ch_take_off",
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0),
                (card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0)) ~= 1 and "s" or ""
            }
        }
    end,
    in_pool = function (self, args)
        return false
    end,
    cost = 13,
    create_card = function (self, card, i)
        if i == 1 then
            G.GAME.real_banned_keys = copy_table(G.GAME.banned_keys or {})
            for k,v in pairs(G.P_CENTERS) do
                if (v.original_mod or {}).id ~= "bibliography" then
                    G.GAME.banned_keys[k] = true
                end
            end
            BIBLIO.event(function ()
                if (G.pack_cards and G.pack_cards.cards) then return false end
                G.GAME.banned_keys = G.GAME.real_banned_keys or {}
                G.GAME.real_banned_keys = nil
                return true
            end, {blocking = false, blockable = false})
        end

        return {
            set = "Joker",
            key_append = "biblio_catcher",
            skip_materialize = true
        }
    end
}