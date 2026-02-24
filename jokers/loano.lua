local alphaplaceholder_base = {
    x = math.random(0, 8),
    y = 0
}
local alphaplaceholder_soul = {
    x = math.random(0, 21),
    y = 1
}

SMODS.Joker {
    key = "loano",
    name = "Loaño Ishida",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_check = function (self, card, crucible) end,
    --biblio_crucible_effect = function (self, card, crucible) end,
    --pronouns = "",
    atlas = 'jokers',
    pos = alphaplaceholder_base,
    soul_pos = alphaplaceholder_soul,
    rarity = 1,
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Twilidramon", bcol = HEX("25DB5B"), tcol = G.C.WHITE}
    end,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = true,
    config = {
        extra = {
            
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key

        info_queue[#info_queue+1] = G.P_CENTERS.c_fool
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative

        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                
            }
        }
    end,
    in_pool = function (self, args)
        if (next(SMODS.find_card("j_biblio_loano_light")) or next(SMODS.find_card("j_biblio_loano_dark"))) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local light, dark
            for i,v in ipairs(context.scoring_hand) do
                local shade = v:biblio_suit_shade()
                if shade == "light" or shade == "mixed" then light = (light or 0) + 1 end
                if shade == "dark" or shade == "mixed" then dark = (dark or 0) + 1 end
            end
            if light and dark then
                if light ~= dark and #G.consumeables.cards == G.consumeables.config.card_limit then return nil end
                BIBLIO.event(function ()
                    SMODS.add_card{
                        set = "Tarot",
                        key = "c_fool",
                        edition = light == dark and "e_negative" or nil
                    }
                    return true
                end)
                return {
                    message = "!"
                }
            end
        end

        if context.forcetrigger then
            BIBLIO.event(function ()
                SMODS.add_card{
                    set = "Tarot",
                    key = "c_fool",
                    edition = light == dark and "e_negative" or nil
                }
                return true
            end)
        end
    end
}