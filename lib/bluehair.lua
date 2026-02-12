if not next(SMODS.find_mod("cardpronouns")) then return end

if not CardPronouns.classifications.neo then --... that's "neopronouns", not "pronouns for Neo Riptide".
    CardPronouns.PronounClassification {
        key = "neo",
        pronouns = {  }
    }
end

CardPronouns.Pronoun{
    key = "rip_ript",
    classification = "neo",
    pronoun_table = { "Rip", "Ript", "Tide" },
    colour = HEX("CA7CA7"),
    text_colour = G.C.WHITE,
    in_pool = function ()
        return false --NOBODY STEALS NEO RIPTIDE'S PRONOUNS -Neo Riptide, probably
    end
}

CardPronouns.Pronoun{
    key = "it_any",
    pronoun_table = {"It", "Any"},
    colour = HEX("CA7CA7"),
    text_colour = G.C.WHITE,
    in_pool = function ()
        return true
    end
}