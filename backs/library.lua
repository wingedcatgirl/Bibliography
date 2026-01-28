SMODS.Back{
    key =  "library",
    apply = function (self, back)
        local starter = Tag("tag_biblio_starter")
        BIBLIO.event(function ()
            add_tag(starter)
            return true
        end)
    end
}