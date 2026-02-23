local poke = SMODS.find_mod("Pokermon")[1]
local stats = {"reward", "skip_count", "skip_target", "Xmult_mod", "xmult_mod_mod", "xmult_target", "ptype", "going_again", "curr_energy_count", "curr_c_energy_count", "rounds"}

if poke then
    sendTraceMessage("Granting Celebi evolution into Cedar...", "Bibliography")
    SMODS.Joker:take_ownership("poke_celebi", {
        biblio_evolution = "j_biblio_cedar",
        biblio_evol_effect = function (self, newcard, oldextra)
            for _,v in ipairs(stats) do
                newcard.ability.extra[v] = oldextra[v] or newcard.ability.extra[v]
            end
            if not oldextra.going_again then
                newcard.ability.extra.skip_count = 0
                newcard.ability.extra.skip_target = 1
                newcard.ability.extra.going_again = true
                newcard.ability.extra.rounds = G.GAME.round
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
    key = "cedar",
    name = "Cedar",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_crucible_check = function (self, card) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "it_any",
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
    perishable_compat = false,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            reward = 1,
            skip_count = 0,
            skip_target = 1,
            Xmult_mod = 0.05,
            xmult_mod_mod = 0.03,
            xmult_target = 10,
            going_again = false,
            ptype = "Grass"
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local type_tooltip = type_tooltip or function (...) end
        type_tooltip(self, info_queue, card)

        local xmult = 1 + (G.GAME.round * card.ability.extra.Xmult_mod)
        if xmult > card.ability.extra.xmult_target then
            key = key.."_ready"
        end
        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                card.ability.extra.skip_target,
                card.ability.extra.reward,
                card.ability.extra.skip_target - card.ability.extra.skip_count,
                card.ability.extra.Xmult_mod,
                xmult,
                card.ability.extra.xmult_mod_mod,
                card.ability.extra.xmult_target,
                BIBLIO.check_reset_ante()
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint then
            card.ability.extra.skip_count = card.ability.extra.skip_count + 1
            card.ability.extra.Xmult_mod = card.ability.extra.Xmult_mod + card.ability.extra.xmult_mod_mod
            if card.ability.extra.skip_count >= card.ability.extra.skip_target then
                ease_ante(-card.ability.extra.reward)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.reward
                card.ability.extra.skip_target = card.ability.extra.skip_target + 1
                card.ability.extra.skip_count = 0
                return {
                    message = "Rewind!"
                }
            else
                return {
                    func = function ()
                        card:juice_up()
                    end
                }
            end
        end
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                local xmult = 1 + (G.GAME.round * card.ability.extra.Xmult_mod)
                return {
                    xmult = xmult
                }
            end
        end

        if context.game_over then
            local xmult = 1 + (G.GAME.round * card.ability.extra.Xmult_mod)
            if xmult < card.ability.extra.xmult_target then return end

            return {
                message = "Rewind!",
                saved = localize{type = "variable", key = "v_biblio_savedby", vars = {localize{type = "name_text", set = self.set, key = self.key}}},
                func = function ()
                    BIBLIO.event(function ()
                        local oldextra = copy_table(card.ability.extra)
                        card:set_ability("j_poke_celebi")

                        for _,v in ipairs(stats) do
                            card.ability.extra[v] = oldextra[v]
                        end

                        BIBLIO.check_reset_ante()
                        if G.GAME.round_resets.ante <= G.GAME.modifiers.biblio_reset_ante then return true end
                        card.ability.extra.xmult_target = card.ability.extra.xmult_target^1.13
                        ease_ante(-G.GAME.round_resets.ante - G.GAME.modifiers.biblio_reset_ante)
                        BIBLIO.increment_reset_ante(1)
                        return true
                    end)
                end
            }
        end
    end
}