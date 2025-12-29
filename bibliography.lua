BIBLIO = {}
BIBLIO.config = SMODS.current_mod.config

local files = {
    lib = {
        "hooks",
        "functions",
        "configui",
        "rarity",
        "atli",
        "sounds",
        "vanillatweaks",
    },
    jokers = {
        "leaf",
        "leafX",
        "scarlex",
        "scarlexEX",
        "vivi",
        "viviEX",
        "zenos",
        "zenosEX",
        "peri",
        "periEX",
    },
    tarots = {
        "crucible"
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