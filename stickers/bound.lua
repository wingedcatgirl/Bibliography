SMODS.Sticker{
    key = "bound",
    badge_colour = HEX("CA7CA7"),
    pos = {x=0, y=0},
    default_compat = true,
    atlas = "stickers",
    sets = {
        Joker = true,
        Default = true,
        Enhanced = true
    },
    exclude = {
        "j_luchador",
        "j_invisible",
        "j_diet_cola"
    },
    rate = 0.05,
    should_apply = function (self, card, center, area, bypass_roll)
        if area ~= G.shop and area ~= G.pack_cards then return false end
        if bypass_roll or G.GAME.modifiers.all_biblio_bound == "absolute" then return true end
        if self.sets[center.set] and not (center[self.key.."_compat"] == false or (center[self.key.."_compat"] == nil and center.perishable_compat == false)) and not self.exclude[center.key] then
            if G.GAME.modifiers.all_biblio_bound then return true end
            --if G.biblio_debug then return true end
            if pseudorandom("biblio_bound_check") < self.rate then
                return true
            end
        end

        return false
    end,
    apply = function (self, card, val)
        if val then
            card.ability.extra_slots_used = -1 --Override even the card's innate size, where applicable
            card.ability.biblio_bound_timer = 5
            card.ability.biblio_bound = true
        else
            card.ability.biblio_bound_timer = 0
            SMODS.destroy_cards(card, true)
        end
    end,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.biblio_bound_timer or 5,
                card.ability.biblio_bound_timer == 1 and "" or "s"
            }
        }
    end,
    calculate = function (self, card, context)
        if context.check_eternal and context.other_card == card and card.ability.biblio_bound_timer > 0 then
            return {
                no_destroy = {override_compat = true}
            }
        end

        if context.end_of_round and context.main_eval then
            card.ability.biblio_bound_timer = card.ability.biblio_bound_timer - 1
            if card.ability.biblio_bound_timer <= 0 then
                SMODS.destroy_cards(card, true, nil, true)
            end
        end
    end
}