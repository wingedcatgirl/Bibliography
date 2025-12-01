BIBLIO = {}

local files = {
    lib = {
        "functions"
    },
    jokers = {
        
    },
}

for folder, list in pairs(files) do
    for _, name in ipairs(list) do
        local load = true
        if load then
            sendTraceMessage("Loading file: "..folder..'/'..name..'.lua', "Bibliography")
            local loaded,errormessage = pcall(SMODS.load_file(folder..'/'..name..'.lua'))
            if not loaded then
                sendErrorMessage("File '"..folder.."/"..name..".lua' failed to load!", "Bibliography")
                sendErrorMessage(errormessage, "Bibliography")
            end
        else
            sendTraceMessage("Skipping file: "..folder..'/'..name..'.lua', "Bibliography")
        end
    end
end