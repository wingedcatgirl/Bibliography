local oldhex = HEX
---make hex work even if you accidentally leave in the #
---@param str string
---@return table
HEX = function (str)
    str = str:gsub("#", "")
    return oldhex(str)
end

local oldlvl = level_up_hand
level_up_hand = function (card, hand, instant, amount)
    if (G.GAME.immutable_level or 0) > 0 then return oldlvl(card, hand, instant, amount) end
    G.GAME.immutable_level = (G.GAME.immutable_level or 0) + 1

    local vals = {
        card = card, hand = hand, instant = instant, amount = amount or 1
    }
    local newvals = { --copy_table results in a stack overflow, this is the card's fault i think
        card = card, hand = hand, instant = instant, amount = amount or 1
    }

    --local flags = SMODS.calculate_context{pre_level_up = newvals} or {}
    local calc = {}
    SMODS.calculate_context({pre_level_up = newvals}, calc)
    local cancel_level
    local additionals = {}

    for i,v in ipairs(calc or {}) do
        for kk,vv in pairs(v or {}) do
            --[[
            print(tostring(kk))
            for k3,v3 in pairs(vv) do
                print(tostring(k3)..": "..tostring(v3))
            end
            --]]
            local flags = vv or {}
            if flags.add then newvals.amount = newvals.amount + flags.add end
            if flags.subtract then newvals.amount = newvals.amount - math.abs(flags.subtract) end
            if flags.multiply then newvals.amount = newvals.amount * flags.multiply end
            if flags.amount then newvals.amount = flags.amount end
            if flags.redirect then newvals.hand = flags.redirect end
            cancel_level = cancel_level or flags.cancel_level

            if flags.message and not (instant or newvals.instant) then
                card_eval_status_text(flags.card or card, "extra", nil, nil, nil, {message = flags.message})
            end

            if next(flags.additional or {}) then
                additionals[#additionals+1] = {
                    card = flags.additional.card or newvals.card or card,
                    hand = flags.additional.hand or newvals.hand or hand,
                    instant = flags.additional.instant or newvals.instant or instant,
                    amount = flags.additional.amount or newvals.amount or amount or 1,
                    message = flags.additional.message,
                    message_card = flags.additional.message_card or flags.card or card,
                    no_message = flags.additional.no_message or newvals.instant or instant
                }
            end
        end
    end

    if newvals.amount > 0 and not cancel_level then
        oldlvl(newvals.card, newvals.hand, newvals.instant, newvals.amount)
    end

    if next(additionals) then
        for i,v in ipairs(additionals) do
            if not (v.no_message or v.instant or newvals.instant or instant) then
                card_eval_status_text(v.message_card or card, "extra", nil, nil, nil, {message = v.message or localize("k_again_ex")})
            end
            oldlvl(v.card, v.hand, v.instant, v.amount)
        end
    end

    SMODS.calculate_context{post_level_up = newvals, modified = vals.amount ~= newvals.amount}
    G.GAME.immutable_level = G.GAME.immutable_level - 1
end

local showman = SMODS.showman
SMODS.showman = function (key)
    if key == "c_wheel_of_fortune" and (next(SMODS.find_card("j_biblio_peri")) or next(SMODS.find_card("j_biblio_peri_EX"))) then
        return true
    end

    return showman(key)
end

local click = Card.click
function Card:click()
    local function acquire(acquired_card) --Acquired, haha, from Bunco
        acquired_card.area:remove_card(acquired_card)
        acquired_card:add_to_deck()
        if acquired_card.children.price then acquired_card.children.price:remove() end
        acquired_card.children.price = nil
        if acquired_card.children.buy_button then acquired_card.children.buy_button:remove() end
        acquired_card.children.buy_button = nil
        remove_nils(acquired_card.children)
        if acquired_card.ability.set == 'Default' or acquired_card.ability.set == 'Enhanced' then
            inc_career_stat('c_playing_cards_bought', 1)
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            G.deck:emplace(acquired_card)
            acquired_card.playing_card = G.playing_card
            playing_card_joker_effects({acquired_card})
            table.insert(G.playing_cards, acquired_card)
        else
            if acquired_card.ability.consumeable then
                G.consumeables:emplace(acquired_card)
            else
                G.jokers:emplace(acquired_card)
            end
            BIBLIO.event(function ()
                acquired_card:calculate_joker({buying_card = true, card = acquired_card}) return true
            end)
        end
        --Tallies for unlocks
        G.GAME.round_scores.cards_purchased.amt = G.GAME.round_scores.cards_purchased.amt + 1
        if acquired_card.ability.consumeable then
            if acquired_card.config.center.set == 'Planet' then
                inc_career_stat('c_planets_bought', 1)
            elseif acquired_card.config.center.set == 'Tarot' then
                inc_career_stat('c_tarots_bought', 1)
            end
        elseif acquired_card.ability.set == 'Joker' then
            G.GAME.current_round.jokers_purchased = G.GAME.current_round.jokers_purchased + 1
        end
    end

    if G.pack_cards and self.area == G.pack_cards and (G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and (SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.ability and SMODS.OPENED_BOOSTER.ability.insta_grab) then
        acquire(self)
        G.GAME.pack_choices = G.GAME.pack_choices - 1
        BIBLIO.booster_sound(card)
        if G.GAME.pack_choices <= 0 then
            G.FUNCS.end_consumeable(nil, 0.2)
        end
        return
    else
        return click(self)
    end
end