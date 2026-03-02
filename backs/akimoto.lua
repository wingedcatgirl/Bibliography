SMODS.Back{
    key =  "akimoto",
    unlocked = false,
    check_for_unlock = function (self, args)
        if args and args.type == "biblio_secret_seed" then
            if args.seed == "akimoto" then return true end
        end
    end,
    apply = function (self, back)
        G.GAME.biblio_advantage = (G.GAME.biblio_advantage or 0) + 3
    end
}