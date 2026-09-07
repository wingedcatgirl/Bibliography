--this tepmlate is currently specifically for baby boss blinds, make it more general once we're done with that
local parent_blind = "some blind"

SMODS.Blind{
    key = "NAME",
    atlas = "blinds",
    pos = {y=0},
    config = {
        
    },
    boss_colour = mix_colours(G.C.CLEAR, G.P_BLINDS[parent_blind].boss_colour, 0.5),
    attributes = {
        
    },
    dollars = 5,
    mult = 1.5,
    big = {min = 1, allow_duplicates = true},
    weight = 2,
    in_pool = function (self)
        if not G.GAME.biblio_blinds_defeated then return false end --fallback cause this is apparently calculated before initializing the table -.-
        return (G.GAME.biblio_blinds_defeated[parent_blind] or 0) >= 1
    end,
    calculate = function (self, blind, context)
        
    end
}