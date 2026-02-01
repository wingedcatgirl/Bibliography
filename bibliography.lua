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
        "starterpack"
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
        "emiliaEX",
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

SMODS.current_mod.menu_cards = function ()
    local words = {
        j_biblio_emilia = "I'm dead! :D" --This is a placeholder until we think of a better thing for her to say :V
    }

    local card
    local key = "j_biblio_emilia"
    return {
        {
            key = key
        },
        func = function ()
            for i,v in ipairs(G.title_top.cards) do
                if v.config.center.key == key then
                    card = v
                    card.click = function(self)
                        G.FUNCS["openModUI_" .. self.config.center.original_mod.id]()
                    end
                    break
                end
            end
            local frames = 0
            BIBLIO.event(function ()
                if not card then
                    BIBLIO.say("No title card?")
                    return true
                end
                frames = frames + 1
                if frames >= 120 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = words[key]})
                    return true
                end
            end, {blocking = false, blockable = false})
        end
    }
end