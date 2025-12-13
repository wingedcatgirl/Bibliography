local oldlvl = level_up_hand

local addlkeys = {
    "add", "subtract", "multiply", "amount", "redirect", "cancel_level", "additional"
}
for i,v in ipairs(addlkeys) do
    SMODS.other_calculation_keys[#SMODS.other_calculation_keys+1] = v
    SMODS.silent_calculation[v] = true
end

local calcieref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
    if addlkeys[key] then
        return {[key] = amount}
    end
    return calcieref(effect, scored_card, key, amount, from_edition)
end

--[[
level_up_hand = function (card, hand, instant, amount)
    local vals = {
        card = card, hand = hand, instant = instant, amount = amount or 1
    }
    local newvals = copy_table(vals)
    SMODS.calculate_context{pre_level_up = vals}

    if vals.amount > 0 then
        oldlvl(vals.card, vals.hand, vals.instant, vals.amount)
    end
end
]]
--[[]]
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
--]]