local soulpos = {x = 0, y = 3}
SMODS.Joker {
    key = "leaf",
    name = "Leaf Saito",
    biblio_evolution = "j_biblio_leafX",
    pronouns = "she_her",
    atlas = 'jokers',
    pos = {
        x = 0,
        y = 2
    },
    soul_pos = soulpos,
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    config = {
        extra = {
            midair = false
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
    in_pool = function (self, args)
        if next(SMODS.find_card(self.biblio_evolution)) then return false end
        
        return true
    end,
    calculate = function(self, card, context)
        local jokerref = card.config.center
        if not context.blueprint and context.final_scoring_step and not card.ability.extra.midair then
            BIBLIO.event(function ()
                jokerref.soul_pos = nil
                card:set_sprites(jokerref)
                card.ability.extra.midair = true
                return true
            end)
            return {
                message = localize("k_biblio_jump")
            }
        end

        if card.ability.extra.midair and context.cardarea == G.play and context.repetition and context.other_card == context.scoring_hand[#context.scoring_hand] then
            local num = (#context.scoring_hand) - 1
            return {
                repetitions = 1,
                message = localize("k_again_ex"),
                func = not context.blueprint and function ()
                    BIBLIO.event(function ()
                        jokerref.soul_pos = soulpos
                        card:set_sprites(jokerref)
                        card.ability.extra.midair = false
                        return true
                    end)
                end or nil,
                extra = {
                    repetitions = num,
                    remove_default_message = true
                }
            }
        end
    end
}