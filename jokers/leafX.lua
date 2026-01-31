local soulpos = {x = 1, y = 3}
SMODS.Joker {
    key = "leafX",
    name = "Leaf Saito, Stellar Dragoon",
    biblio_crucible_effect = function (self, card)
        card.ability.extra.partial = card.ability.extra.partial + 1
        if card.ability.extra.partial >= card.ability.extra.reps then
            card.ability.extra.partial = 0
            card.ability.extra.reps = card.ability.extra.reps + 1
            SMODS.calculate_effect({message = localize("k_upgrade_ex") }, card)
        end
    end,
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 1,
        y = 2
    },
    soul_pos = soulpos,
    rarity = "biblio_evolved",
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Minty"}
    end,
    cost = 13,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            midair = false,
            reps = 1,
            partial = 0,
        }
    },
    loc_vars = function(self, info_queue, card)
        local key = self.key
        if G.localization.descriptions.Lore[key] and BIBLIO.config.lore_popups then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {
                card.ability.extra.reps,
                card.ability.extra.partial
            }
        }
    end,
    load = function (self, card, card_table, other_card)
        local jokerref = card.config.center
        BIBLIO.event(function ()
            if not (card and card.ability and card.ability.extra) then return false end
            if card.ability.extra.midair then
                jokerref.soul_pos = nil
            else
                jokerref.soul_pos = soulpos
            end
            card:set_sprites(jokerref)
            return true
        end, {blockable = false, blocking = false})
    end,
    calculate = function(self, card, context)
        local jokerref = card.config.center

        if card.ability.extra.midair and context.initial_scoring_step and not context.blueprint then
            return {
                message = localize("k_biblio_land"),
                func = function ()
                    BIBLIO.event(function ()
                        jokerref.soul_pos = soulpos
                        card:set_sprites(jokerref)
                        return true
                    end)
                end,
            }
        end

        if card.ability.extra.midair and context.cardarea == G.play and context.repetition then
            return {
                repetitions = 1,
                message = localize("k_again_ex"),
                extra = card.ability.extra.reps > 1 and {
                    repetitions = card.ability.extra.reps - 1,
                    remove_default_message = true
                } or nil
            }
        end
        
        if context.final_scoring_step and not context.blueprint then
            if not card.ability.extra.midair then
                BIBLIO.event(function ()
                    jokerref.soul_pos = nil
                    card:set_sprites(jokerref)
                    card.ability.extra.midair = true
                    return true
                end)
                return {
                    message = localize("k_biblio_jump")
                }
            else
            return {
                func = function ()
                    BIBLIO.event(function ()
                        card.ability.extra.midair = false
                        return true
                    end)
                end,
            }
            end
        end
    end
}