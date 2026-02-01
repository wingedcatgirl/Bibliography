G.FUNCS.biblio_optcycle = function(args)
    local refval = args.cycle_config.ref_value
    BIBLIO.config[refval].current_option = args.cycle_config.current_option
    BIBLIO.config[refval].option_value = args.to_val
end

SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tl", padding = 0.2, colour = G.C.BLACK}, nodes = {
        {n = G.UIT.C, config = {minw=1, minh=1, align = "tl", colour = G.C.CLEAR, padding = 0.15}, nodes = {
        create_toggle({
            label = localize("option_biblio_lorepop"),
            ref_table = BIBLIO.config,
            ref_value = 'lore_popups',
        }),
        create_toggle({
            label = localize("option_biblio_nocred"),
            ref_table = BIBLIO.config,
            ref_value = 'no_credit_badges',
        }),
        BIBLIO.credit_badge{credits = {
            {type = "Example Badge", credit = "Jane"},
            {type = "Example 2", credit = "Alice"}
        }, bcol = G.C.MULT, example = true},
        create_toggle({
            label = localize("option_biblio_copysafe"),
            ref_table = BIBLIO.config,
            ref_value = 'no_unlicensed_tunes',
            info = localize("info_biblio_copysafe")
        }),
        }}
    }}
end