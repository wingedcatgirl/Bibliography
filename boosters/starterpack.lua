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
    create_card = BIBLIO.create_booster_clown
}