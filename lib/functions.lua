---Debug messages
---@param message string Message to send
---@param level? string Log level, DEBUG by default, TRACE won't send unless dev mode is active since DebugPlus doesn't have that filter fsr
BIBLIO.say = function(message, level)
    message = message or "???"
    level = level or "DEBUG"
    while #level < 5 do
        level = level.." "
    end
    if level == "TRACE" and not (BIBLIO.config.dev_mode and not BIBLIO.config.suppress_trace) then
        return
    end
    sendMessageToConsole(level, "Bibliography", message)
end

---Checks whether a card is in the collection (as opposed to e.g. the hand or Jokers tray)
---@param card Card|table Card to check
---@return boolean
BIBLIO.in_collection = function (card)
    return card.area and card.area.config.collection
end

---Converts a map of enhancements into an info-queue tip
---@param table table A map (list of `key = true`) of the relevant enhancements
---@param name string The name of the enhancement list
---@return table
BIBLIO.enhancement_list = function(table, name)
  local key = 'biblio_'..name..'_enhancements'
    local text = {}
    local text_parsed = {}

    for k,_ in pairs(table) do
        if G.P_CENTERS[k] then
            text[#text+1] = localize{type = 'name_text', set = 'Enhanced', key = k}
        end
    end

    for _, v in ipairs(text) do
      text_parsed[#text_parsed + 1] = loc_parse_string(v)
    end

    G.localization.descriptions.Other[key] = G.localization.descriptions.Other[key] or {}
    G.localization.descriptions.Other[key].text = text
    G.localization.descriptions.Other[key].text_parsed = text_parsed

  return {
    set = 'Other',
    key = key,
  }
end

---Check whether the Wheel of Fortune can add the Negative edition.
---@param card? Card|table Specific WoF card object doing the check
---@return boolean|nil
function BIBLIO.wof_can_negative(card)
    if next(SMODS.find_card("j_biblio_peri_EX")) then return true end
    if next(SMODS.find_card("j_biblio_peri")) and card.edition and card.edition.negative then return true end
end

---Get the editions the Wheel can apply
---@param card? Card|table Specific WoF card object doing the check
---@return table ret Bag of eligible editions
BIBLIO.get_wof_editions = function (card)
    local ret = {}
    if not G.GAME.biblio_wof_editions then return { 'e_polychrome', 'e_holo', 'e_foil', BIBLIO.wof_can_negative() and "e_negative" or nil } end
    G.GAME.biblio_wof_editions["e_negative"] = BIBLIO.wof_can_negative(card)
    for k,v in pairs(G.GAME.biblio_wof_editions) do
        if v == true then ret[#ret+1] = k end
    end
    return ret
end

---Add or remove editions from the Wheel's list
---@param key string Key of the edition
---@param remove boolean|nil If true, removes edition from the list
BIBLIO.set_wof_editions = function (key, remove)
    if not G.GAME then return end
    G.GAME.biblio_wof_editions = G.GAME.biblio_wof_editions or {}
    if not G.P_CENTERS[key] then
        BIBLIO.say("No such edition as "..key.."!", "ERROR")
    end
    if not remove then
        G.GAME.biblio_wof_editions[key] = true
    else
        G.GAME.biblio_wof_editions[key] = nil
    end
end

---... from target areas, excluding self
---@param card Card|table The object that's looking at highlighted things (it won't see itself)
---@param areas table List of keys of `CardArea`s in `G`
---@return table cards List of highlighted cards
function BIBLIO.get_all_highlighted(card, areas)
    local cards = {}

    for _,area in ipairs(areas) do
        for _,v in ipairs(G[area].highlighted or {}) do
            if v~=card then cards[#cards+1] = v end
        end
    end

    return cards
end

---Can we use the Crucible on this card?
---@param card Card|table
---@return boolean
function BIBLIO.can_crucible(card)
    --if #SMODS.find_card("c_biblio_crucible") == 1 and card == #SMODS.find_card("c_biblio_crucible")[1] then return false end --Can't use a Crucible on itself... if we ever make an evolved Crucible at all, anyway.

    BIBLIO.marblecheck = BIBLIO.marblecheck or {}

    local _,res = pcall(function ()
        return card.config.center.biblio_evolution or (type(card.config.center.biblio_crucible_effect) == "function")
    end)

    local key = card.config.center.key
    if type(G.P_CENTERS[key].biblio_crucible_check) == "function" then
        res = res and G.P_CENTERS[key]:biblio_crucible_check(card)
    end

    if BIBLIO.marblecheck[key] then return true end

    if Jen and Jen.fusions and string.find(key, "j_jen") and key ~= "j_jen_godsmarble" then --boldly assuming Jen doesn't do crossmod
        for k,v in pairs(Jen.fusions) do
            local this, marble
            for kk,vv in pairs(v.ingredients) do
                if vv == key then this = true end
                if vv == "j_jen_godsmarble" then marble = true end
                if this and marble then
                    BIBLIO.marblecheck[key] = true
                    return true
                end
            end
        end
    end

    return not not (_ and res)
end

---Do the tarot flip thing to all of G.hand.highlighted
---@param card Card|table
---@param args table|{rank:string?, suit:string?, enh:string?, edi:string?, random_ranks:table?, random_suits:table?, random_enhs:table?, random_edis:table?, seed:string?, sound:string?} Keys of the appropriate target modifications. `random_` tables are lists of same keys to pick one at random, in which case you need `seed` to seed the seed. Note: To clear an edition, pass the string "base", "none", "false", or "remove" as the edition key.
BIBLIO.tarotflip = function (card, args)
    if not args then
        BIBLIO.say("hey you forgor to say anything when trying to change these cards", "ERROR")
        return
    end
    local rank = args.rank
    local ranks = args.random_ranks
    local suit = args.suit
    local suits = args.random_suits
    local enh = args.enh
    local enhs = args.random_enhs
    local edi = args.edi
    local edis = args.random_edis
    local seed = args.seed or "biblio_tarotflip_seedless_probably_shouldn't_happen_tbh"
    local sound = args.sound
    if not (rank or ranks or suit or suits or enh or enhs or edi or edis) or (rank and ranks) or (suit and suits) or (enh and enhs) or (edi and edis) or ((ranks or suits or enhs or edis) and not args.seed) then
        BIBLIO.say("hey you didn't type the right arguments?", "ERROR")
        tprint(args or {})
    end

    if card then
        G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true
        end }))
    end

    if (rank or ranks or suit or suits or enh or enhs) then
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.highlighted[i]:flip()
                play_sound('card1', percent)
                G.hand.highlighted[i]:juice_up(0.3, 0.3)
                return true
            end
            }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                if ranks then rank = pseudorandom_element(ranks, pseudoseed(seed)) end
                if suits then suit = pseudorandom_element(suits, pseudoseed(seed)) end
                if enhs then enh = SMODS.poll_enhancement({options = enhs, key = seed, guaranteed = true}) end
                if rank or suit then
                    assert(SMODS.change_base(G.hand.highlighted[i], suit, rank))
                end
                if enh then
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[enh])
                end
                return true
            end
            }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + ( i - 0.999 ) / ( #G.hand.highlighted - 0.998 ) * 0.3
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.highlighted[i]:flip()
                play_sound(sound or 'tarot2', percent, 0.6)
                G.hand.highlighted[i]:juice_up(0.3, 0.3)
                return true
            end
            }))
        end
    end

    if (edi or edis) then
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                if edis then edi = SMODS.poll_edition({options = enhs, key = seed, guaranteed = true}) end
                if edi then
                    if edi == "base" or edi == "none" or edi == "false" or edi == "remove" then edi = nil end
                    G.hand.highlighted[i]:set_edition(edi)
                    G.hand.highlighted[i]:juice_up(0.3,0.3)
                end
                return true
            end
            }))
        end
    end

    G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.15,
    func = function()
        G.hand:unhighlight_all()
        return true
    end
    }))
    delay(0.5)
end

---Checks whether any of the specified rank exist in the player's entire deck
---@param rank string Key of the rank to find
---@return boolean
BIBLIO.find_rank = function(rank)
    if not G.playing_cards then return true end
    for k, v in ipairs(G.playing_cards) do
        if v:get_id() == SMODS.Ranks[rank].id then
            return true
        end
    end
    return false
end

---Checks if you own an enhancement
---@param enh string Key of the enhancement
---@param quantum? boolean Include quantum enhancements (default false)
---@param count? boolean Return the number of found enhancements instead of a boolean
BIBLIO.find_enhancement = function(enh, quantum, count)
    if not G.playing_cards then return count and 0 or true end
    local num = 0
    for k, v in ipairs(G.playing_cards) do
        if (v.config.center.key == enh) or quantum and SMODS.has_enhancement(v, enh) then
            num = num + 1
            if not count then return true end
        end
    end
    return count and num or num > 0
end

---Counts how many things in a given mod have been discovered
---@param mod? string ID of the mod to check for; Bibliography by default
---@param set? string Type of thing to check for; Jokers by default
---@return integer
BIBLIO.discover_count = function(set, mod, debug)
    mod = (mod or "Bibliography")
    if mod:lower() == "vanilla" then mod = "vanilla" end
    set = set or "Joker"
    local found = 0

    if debug then
        BIBLIO.say("Counting discovered items of set "..set.." from mod with id "..mod)
    end

    for k, v in pairs(G.P_CENTERS) do
        if v.discovered then
            if ((mod == "all") or (mod == "vanilla" and not v.mod) or (v.mod and v.mod.id == mod))
            and ((v.set == set) or (set == "all")) then
                if debug then
                    BIBLIO.say("Discovered center found with key "..k)
                end
                found = found + 1
            end
        end
    end

    if set:lower() == "blind" then
        for k, v in pairs(G.P_BLINDS) do
            if v.discovered then
                if ((mod == "all") or (mod == "vanilla" and not v.mod) or (v.mod and v.mod.id == mod)) then
                    if debug then
                        BIBLIO.say("Discovered blind found with key "..k)
                    end
                    found = found + 1
                end
            end
        end
    end

    if set:lower() == "tag" then
        for k, v in pairs(G.P_TAGS) do
            if v.discovered then
                if ((mod == "all") or (mod == "vanilla" and not v.mod) or (v.mod and v.mod.id == mod)) then
                    if debug then
                        BIBLIO.say("Discovered tag found with key "..k)
                    end
                    found = found + 1
                end
            end
        end
    end

    return found
end

---Faster than typing out all this crap :v 
---Remember to return `true` to resolve the event!
---@param func function The function to queue
---@param args? table Other arguments
BIBLIO.event = function(func, args)
    args = args or {}
    args.func = args.func or func
    G.E_MANAGER:add_event(Event(args))
end

BIBLIO.safe_copy_table = function(tbl, depth)
    local newtbl = {}
    depth = depth or 30
    for k,v in pairs(tbl) do
        if type(v) ~= "table" or (type(v.is) == "function" and v:is(Card)) or depth <= 0 then
            newtbl[k] = v
        else
            newtbl[k] = BIBLIO.safe_copy_table(v, depth-1)
        end
    end
    return newtbl
end

---Create a credit badge (unless credits are disabled)
---@param args BibCreditBadge
---@return table|nil
BIBLIO.credit_badge = function (args)
    if BIBLIO.config.no_credit_badges and not args.example then return nil end

    local string, bcol, tcol, scale

    local calced_text_width = 0
    local size = 0.9
    local font = G.LANG.font

    -- Math reproduced from DynaText:update_text
    string = localize{type = "variable", key = "v_biblio_credit", vars = {args.type or "?", args.credit or "??"}}
    if string then
        for _, c in utf8.chars(string) do
            local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
                + 2.7 * 1 * G.TILESCALE * font.FONTSCALE
            calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
        end
    end

    if type(args.credits) == "table" then
        local ct = {}
        calced_text_width = 0

        for i,v in ipairs(args.credits) do
            local item = localize{type = "variable", key = "v_biblio_credit", vars = {v.type or "?", v.credit or "??"}}
            local item_text_width = 0
            for _, c in utf8.chars(string) do
                local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
                    + 2.7 * 1 * G.TILESCALE * font.FONTSCALE
                item_text_width = item_text_width + tx / (G.TILESIZE * G.TILESCALE)
            end
            calced_text_width = math.max(calced_text_width, item_text_width)
            ct[i] = {
                string = item,
            }
        end
        string = ct
    end
    bcol = args.bcol or HEX("CA7CA7")
    tcol = args.tcol or HEX("FFFFFF")
    scale = args.scale or 0.7

    --copied a bunch of this from creditlib
    local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
    local marquee = calced_text_width > max_text_width
    local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1

    local min_scale_fac = scale_fac

    local badge = {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            colour = bcol,
                            r = 0.1,
                            minw = 2,
                            w = 2,
                            minh = 0.36,
                            emboss = 0.05,
                            padding = 0.03 * 0.9,
                        },
                        nodes = {
                            { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                            {
                                n = G.UIT.O,
                                config = {
                                    object = DynaText({
                                        string = string,
                                        colours = { tcol },
                                        silent = true,
                                        float = true,
                                        shadow = true,
                                        marquee = marquee,
                                        maxw = max_text_width,
                                        offset_y = -0.03,
                                        spacing = 1,
                                        scale = 0.33 * 0.9,
                                    }), maxw = max_text_width, align = "cr"
                                },
                            },
                            { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                        },
                    },
                },
            }


    return badge
end

---Check if this booster pack wants to play a sound for the card we took
---@param card Card|table
function BIBLIO.booster_sound(card)
    if not (G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and (SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.ability and SMODS.OPENED_BOOSTER.ability.play_sound_on_take) then return end

    local args = type(SMODS.OPENED_BOOSTER.ability.play_sound_on_take) == "function" and SMODS.OPENED_BOOSTER.ability.play_sound_on_take(card) or SMODS.OPENED_BOOSTER.ability.play_sound_on_take
    if args then
        local sound, pitch, vol
        if type(args) == "string" then
            sound = args
        elseif type(args) == "table" then
            sound = args.sound
            pitch = args.pitch
            vol = args.vol or 0.6
        end
        if sound and SMODS.Sounds[sound] then
            play_sound(sound, pitch, vol)
        else
            BIBLIO.say("hey "..sound.." isn't a sound that exists. you did a typo probably.", "ERROR")
        end
    end
end

---Activates catcher mode for the current booster pack. Also handles reverting the banned keys table in case you forgot (try to avoid forgetting though)
function BIBLIO.catcher_mode()
    local frames, frames2, seconds = 0, 0, 15
    if (SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.ability and type(SMODS.OPENED_BOOSTER.ability.time) == "number") then
        seconds = SMODS.OPENED_BOOSTER.ability.time
    end
    G.GAME.biblio_catcher_mode = true
    SMODS.calculate_context{biblio_catcher_started = true}
    BIBLIO.event(function ()
        if not (G.pack_cards and G.pack_cards.cards) or G.GAME.pack_choices <= 0 then
            if G.GAME.real_banned_keys then
                G.GAME.banned_keys = G.GAME.real_banned_keys or {}
                G.GAME.real_banned_keys = nil
            end
            G.GAME.biblio_catcher_mode = nil
            G.GAME.biblio_catcher_calmed = nil
            G.GAME.biblio_catcher_timeup = nil
            if (G.pack_cards and G.pack_cards.cards) then
                if G.booster_pack then
                    G.FUNCS.end_consumeable(nil, 0.2)
                end
            end
            return true
        end
        if G.GAME.biblio_catcher_calmed then return false end
        frames2 = frames2 + 1
        if frames2 > 60 and seconds > 0 then
            seconds = seconds-1
            frames2 = 0
            attention_text({
                scale = 1.2, text = tostring(seconds), hold = 2, align = 'cm', offset = {x = (math.random()-0.75)*3,y = (math.random()-(2/3))*3},major = G.play
            })
        end
        if seconds <= 0 and G.GAME.pack_choices > 0 then
            G.GAME.biblio_catcher_timeup = true
            if frames2 > 17 then
                frames2 = 0
                local target = pseudorandom_element(G.pack_cards.cards, "biblio_catcher_timesup")
                if G.FUNCS.check_for_buy_space(target) then
                    target:click()
                else
                    G.GAME.pack_choices = G.GAME.pack_choices - 1
                end
            end
            return false
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

---Acquire a card, ignoring limits
---@param acquired_card Card|table
function BIBLIO.acquire(acquired_card) --Acquired, haha, from Bunco
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

local reset_numbers = { --Numbers stored in G.GAME.modifiers which *directly* track what reset-ante-to-0-but-less-on-repeat mechanics are resetting to right now
    "cry_astero_ante",
    "biblio_reset_ante",
    --TARGET: MORE RESET ANTE TRACKERS, SYNC 'EM ALL UP BITCHES

}

function BIBLIO.check_reset_ante()
    local max = 0

    for _,v in ipairs(reset_numbers) do
        max = math.max(max, G.GAME.modifiers[v])
    end
    for _,v in ipairs(reset_numbers) do
        G.GAME.modifiers[v] = math.max(max, G.GAME.modifiers[v])
    end
    return max
end

function BIBLIO.increment_reset_ante(mod)
    mod = mod or 1
    local max = 0
    for _,v in ipairs(reset_numbers) do
        for __=1,mod do
            G.GAME.modifiers[v] = math.max((G.GAME.modifiers[v] or 0)^1.13,(G.GAME.modifiers[v] or 0)+1)
        end
        max = math.max(max, G.GAME.modifiers[v])
    end
    for _,v in ipairs(reset_numbers) do
        G.GAME.modifiers[v] = math.max(max, G.GAME.modifiers[v])
    end
end

--Talisman compatibility compatibility
to_big = to_big or function(x)
    return x
end

to_number = to_number or function(x)
    return x
end


SMODS.current_mod.reset_game_globals = function(init)
    if init then
        G.GAME.biblio_willful = 6
        G.GAME.biblio_wof_editions = {
            e_polychrome = true,
            e_holo = true,
            e_foil = true,
        }
    end
end

SMODS.current_mod.set_debuff = function (card)

end

SMODS.current_mod.calculate = function (self, context)
    local areas = {
        "jokers"
    }

    if context.check_enhancement and (context.other_card and context.other_card.ability and context.other_card.ability.biblio_multienhance) then
        local flags = {}
        SMODS.calculate_context({biblio_enable_multienhance = true}, flags)
        local allow = false
        local suppress = false
        for i,v in ipairs(flags or {}) do
            for kk,vv in pairs(v or {}) do
                allow = allow or (vv or {}).enable
                suppress = suppress or (vv or {}).suppress
            end
        end
        if allow and not suppress then
            --BIBLIO.multienhance = true
            return copy_table(context.other_card.ability.biblio_multienhance)
        else
            --BIBLIO.multienhance = false
            return nil
        end
    end

    if context.open_booster and G.GAME.biblio_all_catchers then
        BIBLIO.event(function ()
            BIBLIO.catcher_mode()
            return true
        end)
        return nil, true
    end

    if context.game_over and G.GAME.biblio_willful > 0 then
        local saved
        for _,area in ipairs(areas) do
            for __,item in ipairs(G[area].cards or {}) do
                if (type(item.ability.extra) == "table" and item.ability.extra or {}).can_willful then
                    saved = localize{type = "name_text", set = item.set, key = item.key}
                    SMODS.calculate_context{biblio_willful = true, willful_card = item}
                    break
                end
            end
            if saved then break end
        end

        if saved then
            G.GAME.biblio_willful = G.GAME.biblio_willful - 1
            return {
                saved = localize{type = "variable", key = "v_biblio_savedby", vars = {saved}}
            }
        end
    end

    --[[
    if context.create_shop_card and G.biblio_debug_flag then
        BIBLIO.say("thing lel")
        return {
            shop_create_flags = {
                set = "Joker",
                key = "j_biblio_amy"
            }
        }
    end
    ]]
end

SMODS.current_mod.process_loc_text = function()

end
