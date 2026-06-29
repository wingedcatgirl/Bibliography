if next(SMODS.find_mod("SpectrumFramework"))
    or next(SMODS.find_mod("paperback"))
    or next(SMODS.find_mod("Bunco"))
    or next(SMODS.find_mod("SixSuits"))
then
    return
end

local function get_virtual_suits()
    if SMODS.get_virtual_suits then return SMODS.get_virtual_suits() end

    local ret = {}
    for i, v in ipairs(SMODS.Suit.obj_buffer) do
        ret[i] = v
    end

    if (next(SMODS.find_card("j_biblio_minty")) or next(SMODS.find_card("j_biblio_minty_EX"))) then
        ret[#ret + 1] = "biblio_3s"
    end

    return ret
end

--Cloned in its entirety from Spectrum Framework, minus the Specflushes and some things that won't be needed if this file ends up loading at all.
SMODS.PokerHandPart { -- Spectrum base
    key = 'spectrum',
    func = function(hand)
        if not (next(SMODS.find_card("j_biblio_minty")) or next(SMODS.find_card("j_biblio_minty_EX"))) then return {} end

        local suit_buffer = get_virtual_suits()

        local wild_cards = {}
        local locked_cards = {}
        local locked_suits = {}
        local flex_cards = {}

        for _, card in ipairs(hand) do
            if not SMODS.has_no_suit(card) then
                if SMODS.has_any_suit(card) then
                    table.insert(wild_cards, card)
                else
                    local suits = {}
                    for _, suit in ipairs(suit_buffer) do
                        if card:is_suit(suit, nil, true) then
                            table.insert(suits, suit)
                        end
                    end

                    if #suits == 1 then
                        local s = suits[1]
                        locked_suits[s] = true
                        table.insert(locked_cards, card)
                    else
                        table.insert(flex_cards, { card = card, suits = suits })
                    end
                end
            end
        end

        local function count_keys(tbl)
            local n = 0
            for _ in pairs(tbl) do n = n + 1 end
            return n
        end

        local total_possible = count_keys(locked_suits) + #flex_cards + #wild_cards
        if total_possible < 5 then
            return {}
        end

        local initial_suit_count = count_keys(locked_suits)
        local needed = 5 - initial_suit_count

        if needed <= #wild_cards then
            -- wilds can fill remaining suit slots
            local all_cards = {}
            for _, c in ipairs(locked_cards) do table.insert(all_cards, c) end
            for _, f in ipairs(flex_cards) do table.insert(all_cards, f.card) end
            for _, w in ipairs(wild_cards) do table.insert(all_cards, w) end
            return { all_cards }
        end

        -- need to find (needed) more unique suits from flex cards
        local all_suits = {}
        for _, suit in ipairs(suit_buffer) do
            if not locked_suits[suit] then
                table.insert(all_suits, suit)
            end
        end

        local function assign(i, used_cards, assigned_suits)
            if i > needed then return true end
            local suit = all_suits[i]

            for j, flex in ipairs(flex_cards) do
                if not used_cards[j] then
                    for _, s in ipairs(flex.suits) do
                        if s == suit then
                            used_cards[j] = true
                            assigned_suits[suit] = true
                            if assign(i + 1, used_cards, assigned_suits) then
                                return true
                            end
                            used_cards[j] = false
                            assigned_suits[suit] = nil
                            break
                        end
                    end
                end
            end

            return false
        end

        if needed <= #flex_cards and assign(1, {}, {}) then
            local all_cards = {}
            for _, c in ipairs(locked_cards) do table.insert(all_cards, c) end
            for _, f in ipairs(flex_cards) do table.insert(all_cards, f.card) end
            for _, w in ipairs(wild_cards) do table.insert(all_cards, w) end
            return { all_cards }
        else
            return {}
        end
    end
}

SMODS.PokerHand { -- Spectrum
    key = 'Spectrum',
    visible = function(self)
        if not (next(SMODS.find_card("j_biblio_minty")) or next(SMODS.find_card("j_biblio_minty_EX"))) then return false end
        return true
    end,
    chips = 50,
    mult = 6,
    l_chips = 25,
    l_mult = 3,
    example = {
        { 'S_2', true },
        { 'D_7', true },
        { 'C_5', true },
        { 'C_3', true },
        { 'H_K', true },
    },
    evaluate = function(parts)
        return parts.biblio_spectrum
    end
}

SMODS.PokerHand { -- Straight Spectrum
    key = 'Straight Spectrum',
    visible = function(self)
        if not (next(SMODS.find_card("j_biblio_minty")) or next(SMODS.find_card("j_biblio_minty_EX"))) then return false end
        return G.GAME.hands[self.key].played > 0
    end,
    chips = 120,
    mult = 10,
    l_chips = 35,
    l_mult = 5,
    example = {
        { 'S_2', true },
        { 'H_3', true },
        { 'C_4', true },
        { 'D_5', true },
        { 'H_6', true }
    },
    process_loc_text = function(self)
        SMODS.PokerHand.process_loc_text(self)
        SMODS.process_loc_text(G.localization.misc.poker_hands, self.key .. '_2', self.loc_txt, 'extra')
    end,
    evaluate = function(parts)
        if not next(parts.biblio_spectrum) or not next(parts._straight) then return {} end
        return { SMODS.merge_lists(parts.biblio_spectrum, parts._straight) }
    end,
    modify_display_text = function(self, _cards, scoring_hand)
        local royal = true
        for j = 1, #scoring_hand do
            local rank = SMODS.Ranks[scoring_hand[j].base.value]
            royal = royal and (rank.key == 'Ace' or rank.key == '10' or rank.face)
        end
        if royal then
            return self.key .. '_2'
        end
    end
}

SMODS.PokerHand { -- Spectrum House
    key = 'Spectrum House',
    above_hand = 'Flush House',
    visible = function(self)
        if not (next(SMODS.find_card("j_biblio_minty")) or next(SMODS.find_card("j_biblio_minty_EX"))) then return false end
        return G.GAME.hands[self.key].played > 0
    end,
    chips = 150,
    mult = 15,
    l_chips = 50,
    l_mult = 5,
    example = {
        { 'S_3', true },
        { 'C_3', true },
        { 'C_3', true },
        { 'D_8', true },
        { 'H_8', true }
    },
    evaluate = function(parts)
        if #parts._3 < 1 or #parts._2 < 2 or not next(parts.biblio_spectrum) then return {} end
        return { SMODS.merge_lists(parts._all_pairs, parts.biblio_spectrum) }
    end
}

SMODS.PokerHand { -- Spectrum Five
    key = 'Spectrum Five',
    above_hand = 'Flush Five',
    visible = function(self)
        if not (next(SMODS.find_card("j_biblio_minty")) or next(SMODS.find_card("j_biblio_minty_EX"))) then return false end
        return G.GAME.hands[self.key].played > 0
    end,
    chips = 180,
    mult = 18,
    l_chips = 60,
    l_mult = 5,
    example = {
        { 'S_3', true },
        { 'D_3', true },
        { 'D_3', true, enhancement = "m_wild" },
        { 'H_3', true },
        { 'C_3', true }
    },
    evaluate = function(parts)
        if not next(parts._5) or not next(parts.biblio_spectrum) then return {} end
        return { SMODS.merge_lists(parts._5, parts.biblio_spectrum) }
    end
}

local pokerhandinforef = G.FUNCS.get_poker_hand_info --Spectrum Six and so forth, copied from Cryptid
function G.FUNCS.get_poker_hand_info(_cards)
    local text, loc_disp_text, poker_hands, scoring_hand, disp_text = pokerhandinforef(_cards)
    if #scoring_hand > 5 and (loc_disp_text == "Spectrum Five" or loc_disp_text == "Specflush Five") then
        loc_disp_text = (loc_disp_text == "Spectrum Five" and "Spectrum ") or
        (loc_disp_text == "Specflush Five" and "Specflush ") or loc_disp_text
        local rank_array = {}
        local county = 0
        for i = 1, #scoring_hand do
            local val = scoring_hand[i]:get_id()
            rank_array[val] = (rank_array[val] or 0) + 1
            if rank_array[val] > county then
                county = rank_array[val]
            end
        end
        local function create_num_chunk(int)
            if int >= 1000 then
                int = 999
            end
            local ones = {
                ["1"] = "One",
                ["2"] = "Two",
                ["3"] = "Three",
                ["4"] = "Four",
                ["5"] = "Five",
                ["6"] = "Six",
                ["7"] = "Seven",
                ["8"] = "Eight",
                ["9"] = "Nine",
            }
            local tens = {
                ["1"] = "Ten",
                ["2"] = "Twenty",
                ["3"] = "Thirty",
                ["4"] = "Forty",
                ["5"] = "Fifty",
                ["6"] = "Sixty",
                ["7"] = "Seventy",
                ["8"] = "Eighty",
                ["9"] = "Ninety",
            }
            local str_int = string.reverse(int .. "")
            local str_ret = ""
            for i = 1, string.len(str_int) do
                local place = str_int:sub(i, i)
                if place ~= "0" then
                    if i == 1 then
                        str_ret = ones[place]
                    elseif i == 2 then
                        if place == "1" and str_ret ~= "" then
                            if str_ret == "One" then
                                str_ret = "Eleven"
                            elseif str_ret == "Two" then
                                str_ret = "Twelve"
                            elseif str_ret == "Three" then
                                str_ret = "Thirteen"
                            elseif str_ret == "Five" then
                                str_ret = "Fifteen"
                            elseif str_ret == "Eight" then
                                str_ret = "Eighteen"
                            else
                                str_ret = str_ret .. "teen"
                            end
                        else
                            str_ret = tens[place] .. ((string.len(str_ret) > 0 and " " or "") .. str_ret)
                        end
                    elseif i == 3 then
                        str_ret = ones[place]
                            .. (" Hundred" .. ((string.len(str_ret) > 0 and " and " or "") .. str_ret))
                    end
                end
            end
            return str_ret
        end
        loc_disp_text = loc_disp_text
            .. (
                (county < 1000 and create_num_chunk(county) or "Thousand")
            )
    end
    return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end
