if not string.find(SMODS.current_mod.version, "~") then return end

SMODS.Back{
    key = "test",
    loc_txt = {
        name = "Test Deck (Bibliography)",
        text = {
            "Tests what I'm testing"
        }
    },
    apply = function (self, back)
        BIBLIO.event(function ()
            if not next(SMODS.find_mod("Pokermon")) then return true end
            SMODS.add_card{
                key = "j_poke_celebi"
            }
            SMODS.add_card{
                key = "j_poke_mew"
            }
            SMODS.add_card{
                key = "c_biblio_crucible"
            }
            SMODS.add_card{
                key = "c_biblio_crucible"
            }
            return true
        end)
    end
}