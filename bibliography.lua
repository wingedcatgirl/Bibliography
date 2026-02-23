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
        "catkids",
        "wildfiresys",

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
        "hotelsora",
        "rubysquad",

        --Other?
        "straightemult"
    },
    stickers = {
        "bound",
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
    local cards = {
        "j_biblio_emilia",
        "j_biblio_scarlex",
    }
    local edition = SMODS.poll_edition() or SMODS.poll_edition() --Roll with advantage!

    local card
    local key = pseudorandom_element(cards, os.time())
    if not G.P_CENTERS[key] then
        BIBLIO.say("Key "..tostring(key).." doesn't exist?")
        return nil
    end

    local msg = localize("chatter_"..key)
    if msg == "ERROR" then msg = localize("chatter_biblio_default") end
    return {
        {
            key = key,
            edition = edition,
        },
        func = function ()
            for i,v in ipairs(G.title_top.cards) do
                if v.config.center and v.config.center.key == key then
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
                if frames >= 150 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = msg, delay = 1.5})
                    return true
                end
            end, {blocking = false, blockable = true})
        end
    }
end