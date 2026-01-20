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
        insta_grab = true
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                card.ability.choose ~= 1 and "s" or ""
            }
        }
    end,
    cost = 5,
    create_card = function (self, card, i)
        if i == 1 then
            G.GAME.real_banned_keys = copy_table(G.GAME.banned_keys or {})
            for k,v in pairs(G.P_CENTERS) do
                if (v.original_mod or {}).id ~= "bibliography" then
                    G.GAME.banned_keys[k] = true
                end
            end
            local frames = 0
            BIBLIO.event(function ()
                if not (G.pack_cards and G.pack_cards.cards) then
                    G.GAME.banned_keys = G.GAME.real_banned_keys or {}
                    G.GAME.real_banned_keys = nil
                    return true
                end
                if #G.pack_cards.cards < 2 then return end
                frames = frames + 1
                if frames > (150/#G.pack_cards.cards) then
                    local card1 = pseudorandom(pseudoseed("biblio_catcher_shuffle"), 1, #G.pack_cards.cards)
                    local card2 = pseudorandom(pseudoseed("biblio_catcher_shuffle"), 1, #G.pack_cards.cards-1)
                    if card2 >= card1 then card2 = card2 + 1 end
                    G.pack_cards.cards[card1], G.pack_cards.cards[card2] = G.pack_cards.cards[card2], G.pack_cards.cards[card1]
                    frames = 0
                end
            end, {blockable = false, blocking = false, delay = 0.2})
        end

        return {
            set = "Joker",
            key_append = "biblio_catcher",
            skip_materialize = true
        }
    end
}