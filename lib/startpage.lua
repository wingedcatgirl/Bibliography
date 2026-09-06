SMODS.RunSelectPage{
    key = "starter_choice",
    automatic_preview = true,
    random_select = true,
    page = 3,
    quick_start_text = function ()
        if SMODS.RunSelect.Setup.choices.deck_choice ~= "b_biblio_library" then return nil end
        local last_key = G.PROFILES[G.SETTINGS.profile].last_choices.biblio_starter_choice
        if last_key and G.P_CENTERS[last_key] then
            return localize{
                type = "name_text",
                set = "Joker",
                key = last_key
            }
        else
            return localize("k_biblio_no_starter")
        end
    end,
    optional = function (self)
        self.pool = self:generate_pool() --Bit of a hack but
        return SMODS.RunSelect.Setup.choices.deck_choice == "b_biblio_library"
    end,
    generate_pool = function (self)
        local starters = {G.P_CENTERS.j_biblio_none}
        for _,joker in ipairs(G.P_CENTER_POOLS.Joker) do
            if (joker.rarity == 1 or joker.rarity == "Common") and (joker.biblio_crucible_effect or joker.biblio_evolution) and joker.unlocked ~= false then
                if joker.key == "j_gros_michel" and next(SMODS.find_mod("MoreFluff")) then
                    --we only have gros michel deck at home when more fluff is closed
                else
                    starters[#starters+1] = joker
                end
            end
        end
        return starters
    end,
    create_selection_card = function (self, key, index, area)
        local starter = SMODS.create_card{
            key = key,
            bypass_discovery_center = true,
            area = area,
            no_edition = true
        }
        starter.bypass_discovery_ui = true
        return starter
    end,
    selected_text = function (self, selection)
        if G.P_CENTERS[selection or ""] then
            return localize{
                type = "name_text",
                set = "Joker",
                key = selection
            }
        end
    end,
    set_default = function (self, choice)
        return G.P_CENTERS[choice or ""] and choice or 'j_biblio_none'
    end,
    start_run = function (self, choice)
        BIBLIO.event(function ()
            if choice == "j_biblio_none" or not choice then return true end
            if not G.jokers then return false end
            local starter = SMODS.add_card{
                key = choice
            }
            return true
        end, {blocking = false})
    end
}

SMODS.Joker{
    key = "none",
    atlas = "jokers", pos = {x=100, y=100},
    rarity = "biblio_unavailable",
    set_card_type_badge = function (self, card, badges) end,
    no_mod_badges = true,
    in_pool = function (self, args)
        return false
    end,
    discovered = true,
    no_collection = true,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                G.PROFILES[G.SETTINGS.profile].name or "player"
            }
        }
    end
}