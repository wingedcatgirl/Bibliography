SMODS.Sound{ --Source: Final Fantasy XIV
    key = "xivlb",
    path = "FFXIV_Limit_Break_Activated.ogg"
}

SMODS.Sound{ --clipped from https://freesound.org/people/Reenen007/sounds/538679/
    key = "cronch",
    path = "cronch.ogg"
}

SMODS.Sound{ --Source: Chaotix
    key = "ch_high_five",
    path = "chaotix high five jingle.ogg"
}

SMODS.Sound{ --Source: Chaotix
    key = "music_ch_take_off",
    pitch = 1, --You have to specify this for a music or it will slow down arbitrarily!!!!
    path = "chaotix take off.ogg",
    sync = false,
    select_music_track = function (self)
        if BIBLIO.config.no_unlicensed_tunes then return false end

        local succ,boostmusic = pcall(function ()
            return (G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and (SMODS.OPENED_BOOSTER.ability.music == "biblio_chaotix_take_off" or SMODS.OPENED_BOOSTER.ability.mod.shortname == "Bibliography")
        end)

        return succ and boostmusic or false
    end
}