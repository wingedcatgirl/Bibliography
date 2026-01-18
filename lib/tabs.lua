local entry = function (text, args)
    args = args or {}
    return {
        n = G.UIT.R,
        config = {
        padding = 0,
        align = "cl"
        },
        nodes = {
        {
          n = G.UIT.T,
          config = {
          text = text,
          shadow = false,
          scale = args.scale or 0.4,
          colour = args.color or G.C.GREEN
          }
        }
        }
      }
end

SMODS.current_mod.extra_tabs = function()
  return {
    label = "Credits",
    tab_definition_function = function()
    return {
      n = G.UIT.ROOT,
      config = {
      align = "cm",
      padding = 0.05,
      colour = G.C.CLEAR,
      },
      nodes = {
      entry("OC Havers:"),
      entry("(Further credits on the particular Jokers)", {scale = 0.3}),
      entry(" ",{scale = 0.3}),
      entry("Minty, of course :p"),
      entry("Kira"),
      entry("MP"),
      entry("Ozbourne"),
      }
    }
    end
  }
end