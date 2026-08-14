---
description: Art-direct an interface — brief and inbox to DIRECTION.md, tokens, a navigable board, measured prototypes, and a component sheet, with three human gates.
argument-hint: "<product or surface | URL to redesign | \"my dashboard\">"
---

Invoke the **inter.face** skill and run the pipeline for: `$ARGUMENTS`

Read `AGENTS.md` and `PRINCIPLES.md` first. Three of those rules are hard and
cannot be skipped: accessible by default (`§10`), keyboard completeness on
tool-shaped surfaces (`§15`), and human gates as real stops (`§16`).

Collect the inbox before filling in the brief — reference images, links with a
line each on what they like, brand assets, and the brand book if one exists, all
into `runs/<slug>/inbox/`. Ask for the book by name. An empty inbox blocks
nothing; `TRANSLATE.md`'s inbox section carries how to read what arrives, and
the rule that a reference is evidence rather than a target.

Settle the surface class before anything else — **page-shaped** or
**tool-shaped**, `TRANSLATE.md` row 1, no safe default. It decides which half of
every reference file applies, so nothing starts until it is set.

Run Loop 1 (direction) to **Gate A**, where the human picks the concept on the
board; Loop 2 (craft) to **Gate B**, where they approve or cut the technique set;
Loop 3 (system) to **Gate C**, where they sign off the component set on a sheet
built from the tokens alone. Dispatch the phase agents as subagents where the
harness supports it; read them inline where it does not. If the surface already
exists, dispatch `redesign-scout` first and let the human take the fork it
proposes.

If no subject was given, ask what surface this is for and have `TRANSLATE.md`'s
six rows filled in before dispatching anything.

Close the run through `IMPROVE.md`: ask once, show the payload in full, default
to no, and send nothing without an explicit yes.

Never publish past a gate without a human decision.
