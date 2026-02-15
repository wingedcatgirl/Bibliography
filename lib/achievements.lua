local dev = not not string.find(SMODS.current_mod.version, "~")

SMODS.Achievement{
    key = "cannibalism",
    bypass_all_unlocked = true,
    hidden_text = true,
    reset_on_startup = dev,
    unlock_condition = function (self, args)
        if args and args.type == "joker_expired" then
            if args.key == "j_biblio_emilia" or args.key == "j_biblio_emilia_EX" then
                return true
            end
        end
    end
}

SMODS.Achievement{
    key = "sparkling_elation",
    bypass_all_unlocked = true,
    hidden_text = true,
    reset_on_startup = dev,
    unlock_condition = function (self, args)
        if args and args.type == "self_destruct" then
            if args.key == "j_biblio_peri_EX" then
                return true
            end
        end
    end
}

SMODS.Achievement{
    key = "baka",
    bypass_all_unlocked = true,
    hidden_text = true,
    reset_on_startup = dev,
    unlock_condition = function (self, args)
        if args and args.type == "joker_set" then
            if args.set == "ach_biblio_baka" then
                return true
            end
        end
    end
}

SMODS.Achievement{
    key = "negativity",
    bypass_all_unlocked = true,
    hidden_text = true,
    reset_on_startup = dev,
    unlock_condition = function (self, args)
        local deckkey = G.GAME.selected_back.effect.center.key or "deck not found oopsie"
        local forceedition = G.GAME.modifiers.cry_force_edition or "not found"
        if deckkey == "b_cry_e_deck" and forceedition == "e_negative" then return end

        if args and args.type == "biblio_modify_any_card" then
            local areas = {
                "jokers", "consumeables", "deck", "hand", "discard"
            }
            local check = true

            for _,area in ipairs(areas) do
                for __,card in ipairs(G[area].cards) do
                    if not card.edition.negative then
                        check = false
                        break
                    end
                end
                if not check then break end
            end
            return check
        end
    end
}