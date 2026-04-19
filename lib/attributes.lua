if not SMODS.Attribute then return nil end

SMODS.Attribute{ --Cards which distinctly don't act like normal cards
    key = "nonstandard"
}

SMODS.Attribute{ --Cards which modify ante
    key = "ante"
}

SMODS.Attribute{ --Cards which may do something when the ante changes
    key = "ante_change"
}

SMODS.Attribute{ --Cards which care about unscored cards
    key = "unscored"
}

SMODS.Attribute{ --Cards which grant exponential mult, or cause other cards to do so
    key = "emult",
    alias = {
        "e_mult", "exp_mult", "expmult", "powmult", "pow_mult"
    }
}

SMODS.Attribute{ --Cards which care about something outside what would normally be recognized as the "game"
    key = "meta"
}

SMODS.Attribute{ --Cards which ban cards, preventing them from appearing again
    key = "ban_card",
    alias = {
        "banish_card", "banning", "banishing"
    }
}

SMODS.Attribute{ --Cards which interact with hand levels
    key = "hand_level",
    alias = {
        "level_up"
    }
}

SMODS.Attribute{ --Cards which care about consumeable slots
    key = "consumeable_slot",
    alias = {
        "consumable_slot", "consumeable_slots", "consumable_slots"
    }
}

SMODS.Attribute{ --Cards which care about the shades of suits (red, black, etc)
    key = "suit_shade",
    alias = {
        "suit_color", "suit_colour"
    }
}

SMODS.Attribute{ --Cards which interact with debt
    key = "debt",
    alias = {
        "bankrupt", "debt_limit"
    }
}

SMODS.Attribute{ --Cards related to vouchers
    key = "voucher",
    alias = {
        "vouchers"
    }
}