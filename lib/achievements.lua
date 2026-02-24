local dev = not not string.find(SMODS.current_mod.version, "~")

---@param t SMODS.Achievement|table
---@return SMODS.Achievement|nil
local function cheevo (t)
    if t.req and not next(SMODS.find_mod(t.req)) then
        sendInfoMessage("Mod "..t.req.." not found, skipping achievement "..t.key, "Bibliography")
        return nil
    end

    for _,v in ipairs{"bypass_all_unlocked", "hidden_name", "hidden_text"} do
        if t[v] == nil then t[v] = true end
    end
    if t.reset_on_startup == nil then t.reset_on_startup = dev end

    return SMODS.Achievement{
        key = t.key,
        atlas = t.atlas or "cheevo",
        pos = t.pos or {x=0,y=0},
        hidden_pos = t.hidden_pos or {x=1, y=0},
        bypass_all_unlocked = t.bypass_all_unlocked,
        hidden_name = t.hidden_name,
        hidden_text = t.hidden_text,
        reset_on_startup = t.reset_on_startup,
        unlock_condition = t.unlock_condition
    }
end

cheevo{
    key = "cannibalism",
    unlock_condition = function (self, args)
        if args and args.type == "joker_expired" then
            if args.key == "j_biblio_emilia" or args.key == "j_biblio_emilia_EX" then
                return true
            end
        end
    end
}

cheevo{
    key = "sparkling_elation",
    unlock_condition = function (self, args)
        if args and args.type == "self_destruct" then
            if args.key == "j_biblio_peri_EX" then
                return true
            end
        end
    end
}

cheevo{
    key = "baka",
    unlock_condition = function (self, args)
        if args and args.type == "joker_set" then
            if args.set == "ach_biblio_baka" then
                return true
            end
        end
    end
}

local n51 = cheevo{
    key = "n51",
    req = "Pokermon",
    unlock_condition = function (self, args)
        if args and args.type == "joker_set" then
            if args.set == "ach_biblio_n51" then
                for i,v in ipairs(G.playing_cards) do
                    if not v.edition then return true end
                end
            end
        end
    end
}

cheevo{
    key = "negativity",
    unlock_condition = function (self, args)
        if G.STAGE ~= G.STAGES.RUN then return false end
        if not (args and args.card and args.card.edition and args.card.edition.negative) then return false end

        local deckkey, forceedition
        pcall(function ()
            deckkey = G.GAME.selected_back.effect.center.key or "deck not found oopsie"
            forceedition = G.GAME.modifiers.cry_force_edition or "not found"
        end)
        if deckkey == "b_cry_e_deck" and forceedition == "e_negative" then return end

        if args and args.type == "biblio_modify_any_card" then
            local areas = {
                "jokers", "consumeables", "deck", "hand", "discard"
            }
            local check = true

            for _,area in ipairs(areas) do
                if G[area] then
                    for __,card in ipairs(G[area].cards) do
                        if not (card.edition and card.edition.negative) then
                            check = false
                            break
                        end
                    end
                end

                if not check then break end
            end
            return check
        end
    end
}