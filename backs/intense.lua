SMODS.Back{
    key = "intense",
    config = {
        extra = {
            slots = 2
        },
    },
    calculate = function (self, back, context)
        if context.ante_change and context.ante_end then
            return {
                message = localize("k_biblio_intensify"),
                BIBLIO.event(function ()
                    G.jokers.config.card_limit = G.jokers.config.card_limit + back.effect.config.extra.slots
                    G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
                    play_sound('highlight2', 0.685, 0.2)
                    play_sound('generic1')
                    return true
                end, {trigger = "after", delay = 1.5})
            }
        end
    end
}