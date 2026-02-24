local poke = SMODS.find_mod("Pokermon")[1]
local stats = {"ptype", "curr_energy_count", "curr_c_energy_count"}

if poke then
    sendTraceMessage("Granting Mew evolution into Micha...", "Bibliography")
    SMODS.Joker:take_ownership("poke_mew", {
        biblio_evolution = "j_biblio_micha",
        biblio_evol_effect = function (self, newcard, oldextra)
            for _,v in ipairs(stats) do
                newcard.ability.extra[v] = oldextra[v] or newcard.ability.extra[v]
            end
        end,
    })
end

local alphaplaceholder_base = {
    x = math.random(0, 8),
    y = 0
}
local alphaplaceholder_soul = {
    x = math.random(0, 21),
    y = 1
}

SMODS.Joker {
    key = "micha",
    name = "Micha",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_check = function (self, card) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "they_any",
    atlas = 'jokers',
    pos = alphaplaceholder_base,
    soul_pos = alphaplaceholder_soul,
    rarity = poke and "biblio_exalted" or "biblio_unavailable",
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Minty", bcol = HEX("CA7CA7"), tcol = G.C.WHITE}
    end,
    cost = 30,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            percent = 15
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local type_tooltip = type_tooltip or function (...) end
        type_tooltip(self, info_queue, card)

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
                card.ability.extra.percent
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.ante_change and context.ante_change < 0 then
            local deck = {}
            for i,v in ipairs(G.playing_cards) do
                if not v.edition then deck[#deck+1] = v end
            end
            if next(deck) then
                local somecard = pseudorandom_element(deck, "biblio_micha_negate")
                somecard:set_edition("e_negative")
                return nil, true
            end
        end
        if poke then
            return G.P_CENTERS.j_poke_mew:calculate(card, context)
        end
    end
}