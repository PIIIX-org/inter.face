# TRANSLATE.md

The input contract. Six rows, filled in before any design work starts — by a sibling
pipeline passing them through, by a human answering six questions, or derived cold using the
derivation section at the end of this file. `loops/01-direction.md` reads this file first,
before it reads anything else.

This file, like every reference file in this plugin, means something different for a
**page-shaped** surface (read for seconds, once — a landing page, a marketing site) and a
**tool-shaped** surface (read for hours, daily — a dashboard, an internal tool, a console).
Rows 2 and 3 fork hardest on this: what a viewer decides in three seconds on a page and what a
user does across a six-hour shift in a tool are different questions with different right
answers. Set row 1 first; it decides which answer the rest of this file is looking for.

Three sibling pipelines — portfolio.me, webcrab, systemcicy — independently converged on a
structured handoff from strategy to design. That convergence is the real interface. These six
rows are it, generalized past any one of the three.

**The rule that governs every row below: if a row does not visibly change a named file and
section downstream, it is not a row, it is decoration.** A competing skill ships four
configurable dials and roughly 120 rules, of which exactly two rules are conditional on any
dial — set every dial to its lowest value and the shipped output is identical. A parameter
that changes no output is a lie about configurability. Each row below states, concretely, what
it derives.

## The six rows

### 1. Surface class

**What it is.** `page-shaped` or `tool-shaped`, set once per surface — not once per product. A
product with a marketing site and an application behind login is two runs sharing a palette
and a type system, not one run averaging them.

**Derives.** Which half of every reference file applies. `STYLES.md`, `CRAFT.md`, `TOOLS.md`,
`SURFACES.md`, and `ACCESS.md` each open with a page-shaped/tool-shaped fork before any other
content — `scripts/check.sh` enforces that every one of them does. Concretely: the state set a
surface owes (3 render states page-shaped, 9 data states tool-shaped, from `TOOLS.md`), the
aspect ratio `loops/01-direction.md` generates images at, and whether `§15` (keyboard
completeness) binds as hard or as the ordinary keyboard-reachability of `§10`.

**Blank.** There is no safe default. Every downstream file forks on this row before it does
anything else; a blank row 1 means Loop 1 cannot start, not that it starts generic.

### 2. Viewer and their decision or task

**What it is.** Who is looking, and what they need to decide or do while looking — specific
enough to picture. "A hiring manager deciding whether to book a call" (page-shaped). "A support
lead triaging forty tickets before their next meeting" (tool-shaped). Not a demographic; a
moment.

**Derives.** The section list (page-shaped) or screen list (tool-shaped) that
`loops/01-direction.md` proposes, the density call in `STYLES.md`'s style-under-density
section — whitespace as the luxury versus rows-per-screen as the luxury, the surface-class
table's own framing — and what `CRAFT.md` and `TOOLS.md` treat as earning space versus costing
it.

**Blank.** The page gets built for nobody in particular, or the tool gets built for an
imagined average user — the two least defensible outcomes this pipeline can produce. Treat a
blank row 2 as a block on Loop 1, not a prompt to guess.

### 3. The three-second feel

**What it is.** Answered with the forcing question, taken from gstack's design-consultation:

> What is the one thing you want someone to remember after they see this for the first time?

Its failure mode, named so it isn't rediscovered per run: **design that tries to be memorable
for everything is memorable for nothing.** One thing. Not a list of adjectives.

**Derives.** The opening move `STYLES.md`'s departure-mode derivation reaches for, the palette
temperature `PRINCIPLES.md` `§6` reconciles the sampled color against by name, and the motion
character `CRAFT.md` assigns and `loops/02-craft.md` writes into the motion spec.

**Blank.** The pipeline still runs, but concept generation has nothing to push against and
reverts to reflex — the obvious hero, the safe palette. That is `§1`'s failure mode, and row 3
is the row most likely to cause it if left empty.

### 4. Archetype and shadow

**What it is.** The personality words for what this is (archetype), and the thing pulling
against it — the risk of overcorrecting, or the thing this must not become while chasing the
archetype (shadow). "Confident, understated" with "sterile, cold" as its shadow names both the
target and the failure mode of hitting it too hard.

**Derives.** `STYLES.md`'s departure-mode derivation reads the archetype words from this row
directly — physical, spatial, or material experiences that would embody them if design were
not involved, then three visual directions — before the family list is ever consulted. The
shadow sets the collision: the "what it did to the style that nobody else does" line `§3`
requires in `DIRECTION.md` is, in the ordinary case, the archetype pushed against its own
shadow.

**Blank.** `STYLES.md`'s derivation has nothing to read and falls back to picking straight from
the family list — the training-data reflex the departure mode exists specifically to route
around.

### 5. Anti-positioning

**What it is.** What this must not look like, stated as concretely as the archetype — a
competitor's look, the category's default cliché, an aesthetic the subject has actively
rejected. Not "nothing generic"; a named thing.

**Derives.** The styles `STYLES.md`'s five-input "picking one" procedure bans outright, and
which entries in the category-cliché fence get treated as a fence rather than a default for
this run. This is also the one row with no ordinary escape: `BREAKING.md`'s never-breakable
list holds `§10`, `§15`, `§16`, and the anti-positioning row together — not aesthetic
preferences, because breaking any of them transfers a cost onto someone who didn't consent to
pay it.

**Blank.** The cliché fence has no teeth. Style selection silently degrades to the safest, most
category-typical family — the exact outcome anti-positioning exists to rule out.

### 6. What is already owned

**What it is.** The logo, the color to sample, the type already in use, and any other
load-bearing brand element that has to survive this run. Also where an existing design system
the subject must conform to — GOV.UK, Material, a corporate DS — gets named.

**Derives.** `PRINCIPLES.md` `§6` reads this row for whether a color already exists to sample
from reality or needs a deliberate, defended invention instead. On a redesign, `REDESIGN.md`'s
reposition path reads it to answer "what is load-bearing and must survive" — the question a
greenfield run never has to ask. And it is the row the escape hatch below checks first.

**Blank.** `§6` falls to its own stated fallback — a deliberate color choice, forced by one
sentence of physical scene — not "nothing to reconcile against."

## Three rules

**Row 3 is a question, not a field.** Ask it, don't paraphrase it: "What is the one thing you
want someone to remember after they see this for the first time?" If the answer comes back as
a list, the row isn't filled in yet.

**Every row derives a named file and section, or it doesn't belong here.** See each row above.
A dial that gates two rules out of a hundred and twenty is what a row that doesn't derive
anything looks like from the outside — configurable in name, fixed in fact. If a future row
can't point at what it changes, cut the row.

**The escape hatch: an existing design system.** If row 6 names a design system the subject
must conform to — GOV.UK, Material, a corporate DS — invention is the wrong answer. Route to
conformance and say so plainly; do not run Loop 1 as if this were a greenfield style choice.
This is the one case where `§1`–`§3` are suspended: the goal stops being a distinctive
interface and becomes a correct one. `BREAKING.md` covers how to record that decision out
loud, the same way it records every other deliberately broken rule.

## Deriving the rows when nobody hands them to you

The six rows above assume someone did the strategy work — a sibling pipeline passing a
filled table through, a strategist with a brief, a founder who has answered these questions
before. A person invoking this cold has none of that, and the place they discover it is
row 4: archetype and shadow is a fast row to copy in and a paralyzing one to invent. This
section is the method, row by row, in the order the rows run. It needs nothing installed
and nobody upstream — a subject to talk to when one exists, and the floor at the end when
one doesn't.

### Deriving row 1 — surface class

Two questions, and their answers usually agree:

- Is this **read once or used daily**? A viewer arrives, decides, leaves — or the same
  person opens it every working morning?
- Is a visit **seconds or hours**?

Once-and-seconds is `page-shaped`. Daily-and-hours is `tool-shaped`. When the two answers
disagree — read daily but for seconds, the status page a lead glances at between meetings —
you are usually looking at two surfaces sharing a product, and row 1's own rule already
covers it: set the class per surface and run each separately.

### Deriving row 2 — viewer and their decision or task

Ask: **who actually sees this in the next 90 days, and what do they decide or do while
looking?** The 90-day window is what kills the demographic answer. "Developers" see nothing
in 90 days; "the two platform leads comparing this against their current vendor before the
quarter closes" do, and they arrive mid-decision. Push until the answer is a person in a
moment — deciding (page-shaped) or working (tool-shaped). Two viewers with genuinely
different decisions is the row 1 disagreement wearing a different hat: probably two
surfaces.

### Deriving row 3 — the three-second feel

The method is already in the row. Row 3 above ships as a forcing question; ask it verbatim,
wait, and refuse the list — the first of the three rules above already says a list means
the row is not filled in yet. There is nothing to derive here that the question does not
extract on its own.

### Deriving row 4 — archetype and shadow

The tempting shortcut is a twelve-archetype lookup table — Sage, Hero, Outlaw — keyed on
what kind of subject this is. Do not. A lookup keyed on subject category is a
subject-indexed catalog: the reflex `STYLES.md`'s "derive, don't pick" procedure exists to
route around, arrived at one file early. Every consultancy lands on Sage, every startup on
Explorer, and the row stops deriving anything.

Work from the subject's own words instead:

1. Ask for **five sentences they have actually said about the work** — to a customer, in a
   README, in the email that closed their last deal. Said, not would say; aspiration is
   what the lookup table produces, and this step exists to get underneath it.
2. **Pull the recurring stance.** The posture that shows up in three of the five sentences
   — precision, defiance, patience, appetite — is the archetype. Two or three words,
   quoted or near-quoted from their own phrasing, not synthesized into marketing language.
3. **The shadow is the stance they suppress** — the thing they stop themselves from
   saying, apologize for after saying, or visibly edit out of the fifth sentence. It is
   already the shape row 4 needs: the thing this must not become while chasing the
   archetype.

Then check the words against the evidence: what does the work **physically evoke** —
handled, heavy, fast, exact? Archetype words the work itself cannot back are aspiration
again, and `STYLES.md`'s derivation will build three directions on them.

### Deriving row 5 — anti-positioning

Derive it from recoil. Describe three or four named directions from different `STYLES.md`
families — say Editorial / print, Cinematic dark, Risograph, Radical minimalism — each in
the one concrete sentence that file requires, and watch the reaction. The probes are for
extracting the ban, not the shortlist; the shortlist still comes from `STYLES.md`'s
derivation, later. What they react against, written down concretely, is the row. **A
strong negative is worth more than a weak positive**: "never anything that dark and
cinematic" cuts the style space, polite interest in all four cuts nothing — and means the
row is still empty, so probe again with directions further apart.

### Deriving row 6 — what is already owned

This row is an audit, not an interview: the logo file as shipped, the colors actually in
production rather than the ones in the brand PDF, the typeface the last three real things
were set in, any design system the subject is bound to. For a surface that already exists,
`REDESIGN.md`'s extraction step does this mechanically — its queries return the fonts
really in use and the palette ranked by occurrence, which is this row measured instead of
remembered.

### The floor: no subject to interview

Sometimes there is nobody to ask — a side project designed for a future audience, a subject
who answers every probe with "you decide." Fill the row with the best available assumption
anyway, and mark it **ASSUMED** in the row itself: "archetype: exact, unhurried — ASSUMED
from the repository's commit style, no interview." An ASSUMED row arrives at Gate A (`§16`)
as a visible question the human can overturn in one sentence. A silently invented row
arrives as a fact, and the whole run builds on it.

If gstack's `/design-consultation` is installed, it runs a fuller version of this interview
and its output maps onto these rows directly — an accelerant, never a prerequisite.
Everything above runs on a bare machine.

### Whose answers win

If a strategist, a founder, or a sibling pipeline already did this work, **theirs wins** —
this section substitutes for absent strategy, it does not compete with real strategy. What
it produces is minimum viable strategy: enough to design against, and visible enough to be
corrected at the gate.
