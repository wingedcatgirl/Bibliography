BIBLIO = {}

local files = {
    lib = {
        "functions",
        "rarity",
        "atli",
    },
    jokers = {
        "leaf",
        "leafX",
    },
    tarots = {
        "crucible"
    },
    rotarots = {
        "crucible"
    }
}

local oldhex = HEX
---make hex work even if you accidentally leave in the #
---@param str string
---@return table
HEX = function (str)
    str = str:gsub("#", "")
    return oldhex(str)
end

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