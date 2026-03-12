G.FUNCS.biblio_optcycle = function(args)
    local refval = args.cycle_config.ref_value
    BIBLIO.config[refval].current_option = args.cycle_config.current_option
    BIBLIO.config[refval].option_value = args.to_val
end

G.FUNCS.biblio_ao3check = function (args)
    local username = G.PROFILES[G.SETTINGS.profile].biblio_ao3_name
    if username == "No Username" or username == "" then
        play_sound("biblio_s2_buzzer")
        return false
    end
    local pseud = (G.PROFILES[G.SETTINGS.profile].biblio_pseudname ~= "No Pseud" and G.PROFILES[G.SETTINGS.profile].biblio_pseudname ~= "") and G.PROFILES[G.SETTINGS.profile].biblio_pseudname or username
    local url = "https://archiveofourown.org/users/"..username.."/pseuds/"..pseud
    local code = BIBLIO.https.request(url)
    if tostring(code) ~= "200" then
        play_sound("biblio_s2_buzzer")
        BIBLIO.say("Page did not load correctly (HTTP error "..code..")", "ERROR")
        return false
    end
    return love.system.openURL(url)
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

SMODS.current_mod.extra_tabs = function ()
    G.PROFILES[G.SETTINGS.profile].biblio_ao3_name = (G.PROFILES[G.SETTINGS.profile].biblio_ao3_name and G.PROFILES[G.SETTINGS.profile].biblio_ao3_name ~= "" and G.PROFILES[G.SETTINGS.profile].biblio_ao3_name) or "No Username"
    G.PROFILES[G.SETTINGS.profile].biblio_pseudname = (G.PROFILES[G.SETTINGS.profile].biblio_pseudname and G.PROFILES[G.SETTINGS.profile].biblio_pseudname ~= "" and G.PROFILES[G.SETTINGS.profile].biblio_pseudname) or "No Pseud"
    return {
        {
            label = localize("tab_biblio_ao3"),
            tab_definition_function = function ()
                return {n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tl", padding = 0.2, colour = G.C.BLACK}, nodes = {
                    {n = G.UIT.C, config = {minw=1, minh=1, align = "tl", colour = G.C.CLEAR, padding = 0.15}, nodes = {
                    create_text_input({
                    w = 4, max_length = 16, prompt_text = localize('option_biblio_ao3name'),
                    ref_table = G.PROFILES[G.SETTINGS.profile], ref_value = 'biblio_ao3_name',extended_corpus = true, keyboard_offset = 1,
                    callback = function()
                        G:save_settings()
                        G.FILE_HANDLER.force = true
                    end
                    }),
                    create_text_input({
                    w = 4, max_length = 16, prompt_text = localize('option_biblio_pseudname'),
                    ref_table = G.PROFILES[G.SETTINGS.profile], ref_value = 'biblio_pseudname',extended_corpus = true, keyboard_offset = 1,
                    callback = function()
                        G:save_settings()
                        G.FILE_HANDLER.force = true
                    end
                    }),
                    UIBox_button{
                        button = "biblio_ao3check",
                        label = {localize("option_biblio_ao3check")},
                        colour = G.C.GREY
                    }
                    }}
                }}
            end
        }
    }
end