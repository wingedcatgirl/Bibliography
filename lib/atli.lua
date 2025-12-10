local super_basic_items = {
    "jokers", "tarots"
}

for _,v in ipairs(super_basic_items) do
    SMODS.Atlas{
        key = v,
        path = v..".png",
        px = 71,
        py = 95
    }
end

SMODS.Atlas {
    key = 'rotarot_placeholder',
    path = "rotarot_placeholder.png",
    px = 107,
    py = 107,
}