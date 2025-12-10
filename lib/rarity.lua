SMODS.Gradient{
    key = "illustrious",
    colours = {
        HEX("F0BA24"), --glowy yellow
        HEX('CA7CA7'), --kity pink
    },
    cycle = 3
}

SMODS.Rarity{ --Legendary+1
    key = "illustrious",
    badge_colour = SMODS.Gradients.biblio_illustrious,
    default_weight = 0
}

SMODS.Gradient{
    key = "mythical",
    colours = {
        HEX("CA7CA7"), --glowy yellow
        HEX('FFFFFF'), --solid white
    },
    cycle = 3
}

SMODS.Rarity{ --Legendary+2
    key = "mythical",
    badge_colour = SMODS.Gradients.biblio_mythical,
    default_weight = 0
}

SMODS.Gradient{
    key = "nth",
    colours = {
        HEX("FFFFFF"), --solid white
        HEX('000000'), --solid black
    },
    cycle = 3
}

SMODS.Gradient{
    key = "nthreverse",
    colours = {
        HEX('000000'), --solid black
        HEX("FFFFFF"), --solid white
    },
    cycle = 3
}

SMODS.Rarity{ --Legendary+3; not supposed to exist really but we'll add one no-collection Nth Joker in case anything does unrestricted rarity upgrades
    key = "nth",
    badge_colour = SMODS.Gradients.biblio_nth,
    default_weight = 0
}

SMODS.Gradient{
    key = "evolved",
    colours = {
        HEX("F0BA24"), --glowy yellow
        HEX('009dff'), --common
    },
    cycle = 3
}

SMODS.Rarity{ --Upgraded Common/Uncommon
    key = "evolved",
    badge_colour = SMODS.Gradients.biblio_evolved,
    default_weight = 0
}

SMODS.Gradient{
    key = "ascended",
    colours = {
        HEX("F0BA24"), --glowy yellow
        HEX("4BC292"), --uncommon
    },
    cycle = 3
}

SMODS.Rarity{ --Upgraded Evolved/Rare
    key = "ascended",
    badge_colour = SMODS.Gradients.biblio_ascended,
    default_weight = 0
}

SMODS.Gradient{
    key = "exalted",
    colours = {
        HEX("F0BA24"), --glowy yellow
        HEX('fe5f55'), --rare
    },
    cycle = 3
}

SMODS.Rarity{ --Upgraded Ascended/Legendary
    key = "exalted",
    badge_colour = SMODS.Gradients.biblio_exalted,
    default_weight = 0
}

SMODS.Gradient{
    key = "sublime",
    colours = {
        HEX("F0BA24"), --glowy yellow
        HEX("b26cbb"), --legendary
    },
    cycle = 3
}

SMODS.Rarity{ --Upgraded Exalted/Illustrious/Mythical
    key = "sublime",
    badge_colour = SMODS.Gradients.biblio_sublime,
    default_weight = 0
}

SMODS.Gradient{
    key = "enoughalready",
    colours = {
        HEX("F0BA24"), --glowy yellow
        HEX('009dff'), --common
        HEX("F0BA24"),
        HEX("4BC292"), --uncommon
        HEX("F0BA24"),
        HEX('fe5f55'), --rare
        HEX("F0BA24"),
        HEX("b26cbb"), --legendary
    },
    cycle = 5
}

SMODS.Rarity{ --Upgraded Sublime/Nth
    key = "enoughalready",
    badge_colour = SMODS.Gradients.biblio_enoughalready,
    default_weight = 0
}