SMODS.Back{
    key =  "library",
    apply = function (self, back)
        BIBLIO.event(function ()
            local starter = Tag("tag_biblio_starter")
            add_tag(starter)
            starter:apply_to_run{type = "start_run"}
        end)
    end
}