SMODS.Joker {
    key = "minty_EX",
    name = "Mintleaf Sylvanis",
    pronouns = "it_she",
    atlas = 'jokers',
    pos = {
        x=11, y=4
    },
    soul_pos = {
        x=11, y=5
    },
    rarity = "biblio_evolved",
    set_badges = function (self, card, badges)
        if not (self.discovered or card.bypass_discovery_ui) then return end
        badges[#badges+1] = BIBLIO.credit_badge{type = "Sona", credit = "Minty", bcol = HEX("CA7CA7"), tcol = G.C.WHITE}
    end,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    demicoloncompat = false,
    use = function (self, card)
        local targets = BIBLIO.get_all_highlighted(card, {"jokers", "consumeables", "hand", "shop_jokers", "pack_cards"})
        local domain = card.ability.extra.domain
        for _,v in ipairs(targets) do
            local area
            if SMODS.is_playing_card(v) then
                area = cards
            end
        end
    end,
    can_use = function (self, card)
        if not card.ability.extra.can_warp then return false end
        local targets = BIBLIO.get_all_highlighted(card, {"jokers", "consumeables", "hand", "shop_jokers", "pack_cards"})
        for _,v in ipairs(targets) do
            if v.config.center.set == "Voucher" then return false end
        end
        return #targets > 0 and #targets <= card.ability.extra.max_target
    end,
    alt_use = function (self, card)
        
    end,
    can_alt_use = function (self, card)
        if not card.ability.extra.can_distort then return false end
        
    end,
    buttons = {
        {get_button_args = function (self, card)
            local args = {
                card = card,
                id = "use",
                can = "biblio_can_alt_use_joker",
                effect = "biblio_alt_use_joker",
                handy_insta = "use",
                text = localize("b_use")
            }

            return args
        end}
    },
    config = {
        extra = {
            max_target = 3,
            domain = nil,
            can_warp = true,
            can_distort = true,
        }
    },
    attributes = {

    },
    add_to_deck = function (self, card, from_debuff)
        local domain = tostring(card.unique_val)
        card.ability.extra.domain = domain
        local areas = {
            "jokers", "consumeables", "cards"
        }
        for _,area in ipairs(areas) do
            G["mintleaf_"..area.."_"..domain] = G["mintleaf_"..area.."_"..domain] or CardArea(
                -100, -100, 0, 0,
                {card_limit = 1e100,
                type = "domain"}
            )
        end
    end,
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
    in_pool = function (self, args)
        if self.biblio_evolution and next(SMODS.find_card(self.biblio_evolution)) and not SMODS.showman(self.key) then return false end
        --insert any additional conditions
        return true
    end,
    calculate = function(self, card, context)
        -- Calculation goes here
    end
}