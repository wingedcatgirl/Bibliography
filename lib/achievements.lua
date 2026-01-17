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