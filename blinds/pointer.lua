local parent_blind = "bl_arm"

SMODS.Blind{
    key = "pointer",
    atlas = "blinds",
    pos = {y=9},
    config = {
        
    },
    boss_colour = mix_colours(G.C.CLEAR, G.P_BLINDS[parent_blind].boss_colour, 0.5),
    attributes = {
        "hand_level"
    },
    dollars = 5,
    mult = 1.5,
    big = {min = 1, allow_duplicates = true},
    weight = 2,
    in_pool = function (self)
        if not G.GAME.biblio_blinds_defeated then return false end
        return (G.GAME.biblio_blinds_defeated[parent_blind] or 0) >= 1
    end,
    --no calculate, this is handled in a hook
}