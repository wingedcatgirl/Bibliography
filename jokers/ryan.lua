SMODS.Joker {
    key = "ryan",
    name = "Ryan Akimoto",
    --biblio_evolution = "j_biblio_KEY",
    --biblio_evol_effect = function (self, newcard, oldextra) end,
    --biblio_crucible_effect = function (self, card) end,
    pronouns = "he_him",
    atlas = 'jokers',
    pos = {
        x = 4,
        y = 4
    },
    --[[
    soul_pos = {
        x = 0,
        y = 1
    },
    --]]
    rarity = 1,
    set_badges = function (self, card, badges)
        badges[#badges+1] = BIBLIO.credit_badge{type = "OC", credit = "Kira", bcol = HEX("F51F95") }
    end,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            active = true,
            triggered = false
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
                card.ability.extra.active and localize("k_biblio_active_desc") or localize("k_biblio_inactive_desc")
            }
        }
    end,
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        if context.before and card.ability.extra.active then
            card.ability.extra.triggered = true
            for i,v in ipairs(context.full_hand) do
                if not (v:get_id() == 2 or v:get_id() == 3 or v:get_id() == 5 or v:get_id() == 8 or v:get_id() == 14 or (SMODS.find_mod("MintysSillyMod" and v:is_3()))) then
                    card.ability.extra.triggered = false
                    break
                end
            end
        end

        if context.cardarea == G.play and context.repetition and card.ability.extra.triggered then
            card.ability.extra.active = false
            return {
                repetitions = 1
            }
        end

        if context.after and card.ability.extra.triggered then
            card.ability.extra.active = false
        end

        if context.end_of_round and context.main_eval and not card.ability.extra.active then
            card.ability.extra.active = true
            return {
                message = localize("k_reset")
            }
        end
    end
}