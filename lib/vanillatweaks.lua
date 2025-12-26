SMODS.Joker:take_ownership("cavendish", {
    set_card_type_badge = function (self, card, badges)
        badges[1] = create_badge(localize("k_biblio_evolved", "labels"), SMODS.Gradients.biblio_evolved, nil, 1.2)
    end
}, true)