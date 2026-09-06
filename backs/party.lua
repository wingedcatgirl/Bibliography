SMODS.Back{
    key = "party",
    atlas = "backs",
    pos = {x=1,y=0},
    apply = function (self, back)
        G.GAME.biblio_all_catchers = true
        G.GAME.modifiers = G.GAME.modifiers or {}
        G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + 2
    end
}