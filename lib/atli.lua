local super_basic_items = {
    "jokers", "tarots", "boosters", "stickers"
}

for _,v in ipairs(super_basic_items) do
    SMODS.Atlas{
        key = v,
        path = v..".png",
        px = 71,
        py = 95
    }
end

SMODS.Atlas{
    key = "tags",
    path = "tags.png",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = 'rotarot_placeholder',
    path = "rotarot_placeholder.png",
    px = 107,
    py = 107,
}

SMODS.Atlas({ --technically copyrighted (it's the google 📚️ emoji) but who cares in this context
    key = 'modicon',
    path = 'icon.png',
    px = 34,
    py = 34
})

SMODS.Atlas{
    key = "cheevo",
    path = "cheevo.png",
    px = 66,
    py = 66,
}