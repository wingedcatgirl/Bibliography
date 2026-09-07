local parent_blind = "bl_ox"
assert(G.C.CLEAR and G.P_BLINDS[parent_blind].boss_colour, "colors don't exist yet you're gonna have to try somethin else")

SMODS.Blind{
    key = "calf",
    atlas = "blinds",
    pos = {y=0},
    config = {
        dollars = -3
    },
    boss_colour = mix_colours(G.C.CLEAR, G.P_BLINDS[parent_blind].boss_colour, 0.5),
    attributes = {
        "hand_type", "lose_economy"
    },
    dollars = 5,
    mult = 1.5,
    big = {min = 1, allow_duplicates = true},
    weight = 2,
    in_pool = function (self)
        if not G.GAME.biblio_blinds_defeated then return false end
        return (G.GAME.biblio_blinds_defeated[parent_blind] or 0) >= 1
    end,
    loc_vars = function (self)
        return {
            vars = {
                localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands'),
                localize("$")..(G.GAME.blind and G.GAME.blind.effect and G.GAME.blind.effect.dollars or self.config.dollars)
            }
        }
    end,
    collection_loc_vars= function (self)
        return {
            vars = {
                localize('ph_most_played'),
                localize("$")..self.config.dollars
            }
        }
    end,
    calculate = function (self, blind, context)
        if context.before and context.scoring_name == G.GAME.current_round.most_played_poker_hand then
            return {
                dollars = G.GAME.blind.effect.dollars
            }
        end
    end
}