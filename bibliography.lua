BIBLIO = {}
BIBLIO.config = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
	quantum_enhancements = true
}

local files = {
    --[[
    { name = "", content = {
    } },
    --]]
    { name = "lib", content = {
        "hooks",
        "functions",
        "configui",
        --"tabs",
        "attributes",
        "rarity",
        "atli",
        "sounds",
        "bluehair",
        "vanillatweaks",
        "achievements",
    } },
    { name = "backs", content = {
        "party",
        "library",
        "akimoto",
        "intense",
        "test",
    } },
    { name = "boosters", content = {
        "catcher",
        "starterpack",
    } },
    { name = "tags", content = {
        "starter"
    } },
    { name = "jokers", content = {
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
        "jeri",
        "jeriEX",
        --"jeri_doomed",
        "micha",
        "cedar",
        "catkids",
        "wildfiresys",

        --others' chars
        "amanda",
        "amy",
        "amyEX",
        "peri",
        "periEX",
        "eiko",
        "neo",
        "neoEX",
        "ryan",
        "yuu",
        "yuuEX",
        "loano",

        --canon chars
        "cirno",
        "zenos",
        "zenosEX",
        "kris",
        "krisEX",
        "hugh",
        "shizuku",
        "hotelsora",
        "rubysquad",

        --Other?
        "straightemult"
    } },
    { name = "stickers", content = {
        "bound",
        "multienhance"
    } },
    { name = "tarots", content = {
        "crucible",
        "calmer"
    } },
    { name = "rotarots", content = {
        "crucible"
    } },
}

for _, folder in ipairs(files) do
    for _, name in ipairs(folder.content) do
        sendTraceMessage("Loading file: "..folder.name..'/'..name..'.lua', "Bibliography")
        local loaded,errormessage = pcall(SMODS.load_file(folder.name..'/'..name..'.lua'))
        if not loaded then
            sendErrorMessage("File '"..folder.name.."/"..name..".lua' failed to load!", "Bibliography")
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