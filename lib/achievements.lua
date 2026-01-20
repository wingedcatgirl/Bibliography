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