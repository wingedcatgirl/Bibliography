## Bibliography - A~~n Indiscriminate Collection of Blorbos~~ Balatro Mod

### Instructions
1. Install [Lovely](https://github.com/ethangreen-dev/lovely-injector), [Steamodded](https://github.com/Steamodded/smods), and [Amulet](https://github.com/frostice482/amulet)
2. Install Bibliography
3. Look at all the funny characters
4. Watch number get biggerer

> [!NOTE]
> This mod is in **early development**.  
> A lot of the art is still placeholders. No idea how long this will last because I am extremely inconsistent at everything, but especially art.

### FAQ (Feasibly Askable Questions) ~~(nobody's asked me anything about this ._.)~~
**Q**: So the main gimmick is just Jokers What Am OCs?  
**A**: Mainly! There's also some canon characters.

**Q**: What power level is this mod planned to be?  
**A**: There will be potential for computer-breaking numbers, probably. Eventually. Once I implement the Jokers involved, and also a reasonable-ish way to acquire them.

**Q**: Is this trying to just be [a certain prior project] again?  
**A**: ... Not *just*, no... ~~this one's got MY ocs in it!~~ Egotism aside, as much as Bibliography is both inspired by and modeled on [that older project], it's inherently a different mod and will be its own experience. Just for starters, we're going to have different design principles. I'll probably use less xChips than they did, for example. And less recursion.  
... now that [that project] is publicly-ish available again, anyone who wants to play it can just play it, so I _gotta_ differentiate myself now :V

**Q**: How many Jokers do you plan to add?  
**A**: I plan to keep putting in Jokers until I run out of characters that I can come up with an in-game effect for. ... I'd like at least 70 before then, but I suppose that's up to my creativity. 

**Q**: How many Jokers do you _actually_ have?  
**A**: *(comically long pause for audio splicing)* 28, of which 5 are [Fusion Jokers](https://github.com/wingedcatgirl/Fusion-Jokers) exclusive *(comically long pause for audio splicing)* at the moment, unless I forgot to update this README file, which will definitely happen several times throughout the mod's lifespan.

**Q**: ... Are you accepting suggestions for characters to Jokerfy?  
**A**: Sure, if you're accepting that there's no timeline on when I get around to actually implementing a given suggestion. I should probably set up a form or something for this... I'll do it later.

### Crossmodding if you want to
- If you want your cards to evolve with the Crucible, put the evolved form's key as a string in `biblio_evolution`. (Alternately instead of a string you can do a table of strings to select randomly, or a `function(self, card, crucible) -> string` that returns the key based on any criteria you imagine up.) For rarities you can legally do what you want but canonically it goes Common/Uncommon -> Evolved, Evolved/Rare/Epic-and-equivalent -> Ascended... plus additional rarities for silliness.
    - Add a `biblio_evol_effect(self, oldcard, newextra)` function to transfer stats and/or do additional things.
    - If you want the Crucible to do a different thing other than evolution, give it a `biblio_crucible_effect(self, card)` function instead.
    - Use `biblio_crucible_check(self, card) -> boolean` to add extra requirements (e.g. money).
- Use `biblio_bound_compat` on your center if you have strong opinions about whether that sticker makes sense for it. By default it inherits Perishable compatibility.