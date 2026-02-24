SMODS.Consumable{
    set = 'Spectral',
    key = 'SPECTRAL',
    name = "The SPECTRAL",
    --[[
    atlas = 'spectrals',
    pos = {
        x = 3,
        y = 3
    },
    ]]
    config = {

    },

    loc_vars = function(self, info_queue, card)
		local key = self.key
        if G.localization.descriptions.Lore[key] then
            info_queue[#info_queue + 1] = {
                set = "Lore",
                key = key,
            }
        end
        return {
            key = key,
            vars = {

            }
        }
    end,

    use = function(self, card, area, copier)
        
    end,

    in_pool = function (self, args)
        return true
    end
}