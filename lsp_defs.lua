---@meta

---@class ColorRGBA
---@field [1] number Red   (0–1)
---@field [2] number Green (0–1)
---@field [3] number Blue  (0–1)
---@field [4] number? Alpha (0–1)

---@param hex string Don't prepend the hash!!! No hash!!!!!
---@return ColorRGBA
function HEX(hex) end

---@class BibCreditBadge
---@field type string What the credit is for
---@field credit string Who's being credited
---@field bcol? ColorRGBA Background color as formatted by `HEX()`; default #ca7ca7
---@field tcol? ColorRGBA Text color; default #fff
---@field scale? number Scale (default 0.7 to standard badges' 1)

---@class SMODS.Center
---@field biblio_evolution? (string | string[] | fun(self:SMODS.Joker|table, card:Card|table, crucible:Card|table):string) Key of center to evolve into, or table of such keys to be selected randomly, or function which returns such a key
---@field biblio_evol_effect? fun(self:SMODS.Joker|table, newcard:Card|table, oldextra:table):nil Effect to be applied after evolution
---@field biblio_crucible_effect? fun(self:SMODS.Joker|table, card:Card|table):nil Alternative effect of a Crucible, instead of changing center