local parent_blind = "bl_hook"

SMODS.Blind{
    key = "splinter",
    atlas = "blinds",
    pos = {y=5},
    config = {
        
    },
    boss_colour = mix_colours(G.C.CLEAR, G.P_BLINDS[parent_blind].boss_colour, 0.5),
    attributes = {
        "discard"
    },
    dollars = 5,
    mult = 1.5,
    big = {min = 1, allow_duplicates = true},
    weight = 2,
    in_pool = function (self)
        if not G.GAME.biblio_blinds_defeated then return false end
        return (G.GAME.biblio_blinds_defeated[parent_blind] or 0) >= 1
    end,
    calculate = function (self, blind, context)
        if context.press_play then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local selected_card = G.hand.cards[1]
                    if selected_card then
                        G.hand:add_to_highlighted(selected_card, true)
                        play_sound('card1', 1)
                    end
                    G.FUNCS.discard_cards_from_highlighted(nil, true)
                    return true
                end
            }))
            blind.triggered = true
            delay(0.7)
        end
    end
}