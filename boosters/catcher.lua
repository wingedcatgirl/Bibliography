SMODS.Booster{
    key = "catcher_1",
    discovered = false,
    group_key = "biblio_catcher",
    kind = "biblio_catcher",
    atlas = "boosters",
    pos = {x = 0, y = 0},
    config = {
        extra = 5,
        choose = 1,
        play_sound_on_take = "biblio_ch_high_five",
        music = "biblio_music_ch_ntmy",
        insta_grab = true,
        catcher = true
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
    cost = 5,
    create_card = BIBLIO.create_booster_clown
}