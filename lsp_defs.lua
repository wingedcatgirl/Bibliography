---@meta

---@class ColorRGBA
---@field [1] number Red   (0–1)
---@field [2] number Green (0–1)
---@field [3] number Blue  (0–1)
---@field [4] number? Alpha (0–1)

---@param hex string Don't prepend the hash!!! No hash!!!!!
---@return ColorRGBA
function HEX(hex) end

---@class BibCredit
---@field type string What the credit is for
---@field credit string Who's being credited

---@class BibCreditBadgeSingle
---@field type string What the credit is for
---@field credit string Who's being credited
---@field bcol? ColorRGBA Background color as formatted by `HEX()`; default #ca7ca7
---@field tcol? ColorRGBA Text color; default #fff
---@field scale? number Scale (default 0.7 to standard badges' 1)

---@class BibCreditBadgeMulti
---@field credits BibCredit[] List of credits for a multi-credit badge
---@field bcol? ColorRGBA Background color as formatted by `HEX()`; default #ca7ca7
---@field tcol? ColorRGBA Text color; default #fff
---@field scale? number Scale (default 0.7 to standard badges' 1)

---@alias BibCreditBadge BibCreditBadgeSingle | BibCreditBadgeMulti

---@class SMODS.Center
---@field biblio_evolution? (string | string[] | fun(self:SMODS.Joker|table, card:Card|table, crucible:Card|table):string) Key of center to evolve into, or table of such keys to be selected randomly, or function which returns such a key
---@field biblio_evol_effect? fun(self:SMODS.Joker|table, newcard:Card|table, oldextra:table):nil Effect to be applied after evolution, by base card to new card
---@field biblio_crucible_check? fun(self:SMODS.Joker|table, card:Card|table, crucible:Card|table):boolean Must return `true` for this card to be Crucible-eligible
---@field biblio_crucible_effect? fun(self:SMODS.Joker|table, card:Card|table, crucible:Card|table):nil Alternative effect of a Crucible, instead of changing center
---@field biblio_bound_compat? boolean Compatibility flag for the Bound sticker; inherits Perishable compatibility by default