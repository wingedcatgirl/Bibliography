BIBLIO = {}
BIBLIO.config = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
	quantum_enhancements = true
}

local files = {
    lib = {
        "hooks",
        "functions",
        "configui",
        --"tabs",
        "rarity",
        "atli",
        "sounds",
        "bluehair",
        "vanillatweaks",
        "achievements",
    },
    backs = {
        "party",
        "library",
    },
    boosters = {
        "catcher",
        "starter"
    },
    tags = {
        "starter"
    },
    jokers = {
        --my chars
        "leaf",
        "leafX",
        "scarlex",
        "scarlexEX",
        "vivi",
        "viviEX",
        "emilia",
        "daren",
        "darenEX",
        "hallie",
        "hallieEX",

        --others' chars
        "amanda",
        "amy",
        "peri",
        "periEX",
        "eiko",
        "neo",
        "ryan",
        "yuu",

        --canon chars
        "cirno",
        "zenos",
        "zenosEX",
    },
    stickers = {
        "multienhance"
    },
    tarots = {
        "crucible",
        "calmer"
    },
    rotarots = {
        "crucible"
    }
}

for folder, list in pairs(files) do
    for _, name in ipairs(list) do
        sendTraceMessage("Loading file: "..folder..'/'..name..'.lua', "Bibliography")
        local loaded,errormessage = pcall(SMODS.load_file(folder..'/'..name..'.lua'))
        if not loaded then
            sendErrorMessage("File '"..folder.."/"..name..".lua' failed to load!", "Bibliography")
            sendErrorMessage(errormessage, "Bibliography")
        end
    end
end