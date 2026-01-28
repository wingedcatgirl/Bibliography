SMODS.Joker:take_ownership("gros_michel", {
    biblio_crucible_effect = function (self, card)
        SMODS.destroy_cards(card, true, true, true)
        SMODS.calculate_effect({message = localize("k_extinct_ex")}, card)
        G.GAME.pool_flags.gros_michel_extinct = true
    end
}, true)

SMODS.Joker:take_ownership("cavendish", {
    set_card_type_badge = function (self, card, badges)
        if not self.discovered then return end
        badges[1] = create_badge(localize("k_biblio_evolved", "labels"), SMODS.Gradients.biblio_evolved, nil, 1.2)
    end
}, true)

SMODS.Consumable:take_ownership("wheel_of_fortune", { --This is not robust, we should think of a more robust way to do this.
    name = "Wheel of Fortune (Bibliography'd)",
    update = function (self, card, dt)
        if G.STAGE == G.STAGES.RUN then
            card.eligible_strength_jokers = EMPTY(card.eligible_strength_jokers)
            for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) then
                    table.insert(card.eligible_strength_jokers, v)
                end
            end
        end
    end,
    can_use = function (self, card)
        if next(card.eligible_strength_jokers) then return true end
    end,
    loc_vars = function (self, info_queue, card)
        local edibag = BIBLIO.get_wof_editions(card)
        for _,v in ipairs(edibag) do
            info_queue[#info_queue+1] = G.P_CENTERS[v]
        end
            local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra, "wheel_of_fortune")
        return {
            vars = {
                luck, odds
            }
        }
    end,
    use = function (self, card, area, copier)
        local used_tarot = card or copier
        local temp_pool = card.eligible_strength_jokers or {}
        local function try()
            if SMODS.pseudorandom_probability(used_tarot, "wheel_of_fortune", 1, card.ability.extra) then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    local over = false
                    local eligible_card = pseudorandom_element(temp_pool, pseudoseed('wheel_of_fortune'))
                    local edition = SMODS.poll_edition{
                        key = 'wheel_of_fortune',
                        no_negative = not BIBLIO.wof_can_negative(card),
                        guaranteed = true,
                        options = BIBLIO.get_wof_editions(card)
                    }
                    eligible_card:set_edition(edition, true)
                    check_for_unlock({type = 'have_edition'})
                    used_tarot:juice_up(0.3, 0.5)
                return true end }))
                return true
            else
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = used_tarot,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                        offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                        silent = true
                        })
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                            play_sound('tarot2', 0.76, 0.4);return true end}))
                        play_sound('tarot2', 1, 0.4)
                        used_tarot:juice_up(0.3, 0.5)
                return true end }))
                return false
            end
        end

        local count = 0
        local peris = SMODS.find_card("j_biblio_peri_EX")
        while not try() and count < #peris do
            count = count + 1
            BIBLIO.event(function ()
                peris[count]:juice_up()
                return true
            end)
            delay(0.6)
        end
    end

}, true)