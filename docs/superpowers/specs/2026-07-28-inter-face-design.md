# inter.face — design

**Date:** 2026-07-28
**Status:** approved for planning

A cross-agent design plugin: intent in, art direction out. It stops before code.

---

## Why it exists

Three PIIIX pipelines each grew their own design system, and they have drifted apart:

| Doc | portfolio.me | webcrab | systemcicy |
|---|---|---|---|
| `STYLES.md` | 388 lines | 255 lines | — |
| `CRAFT.md` | 418 lines | 240 lines | — |
| `loops/02-design.md` | 188 lines | 258 lines | — |
| `INTERFACE.md` | — | — | 229 lines |

Only 65 of 388 `STYLES.md` lines are identical between portfolio.me and webcrab. The
drift is not decay — each fork grew material the others lack. webcrab has a style
*selection procedure* and a category-cliché fence that portfolio.me never got.
portfolio.me has a deeper technique arsenal than webcrab. systemcicy is the only one
of the three that knows how to design a tool rather than a page.

Extracting the union into one plugin makes that material available to all three, and
to work that is none of them.

The second reason is reach. Every pipeline in the family is markdown with a thin
adapter layer, so it already runs in seven agents. The design system is the part
people would want on its own, and it is currently only reachable by running a whole
portfolio or a whole marketing-site pipeline.

## What it is

A design-only pipeline. Input is a filled translation table. Output is:

- `DIRECTION.md` — the concept, the collision, the palette with sampled sources, the
  type system, the technique assignment per surface, the motion spec, both budget
  tiers, and what this run invented
- one design image per surface
- one runnable prototype per technique, with a measured frame rate and a verdict

It does not write the site. Handing `DIRECTION.md` plus the images plus the
prototypes to a build step — a sibling pipeline's Loop 4, or a human, or another
agent — is the deliverable.

## The spine: surfaces have a class

The first question the pipeline asks, because everything downstream forks on it.

| | **Page-shaped** | **Tool-shaped** |
|---|---|---|
| Read for | seconds, once | hours, daily |
| Unit of design | section | screen |
| Density | whitespace is the luxury | rows-per-screen is the luxury |
| Delight is | the opening move | keystrokes removed |
| Input | pointer, scroll | keyboard first |
| States per surface | 3 | 9 |
| Failure mode | the category reflex | the generic admin template |
| Inherited from | portfolio.me, webcrab | systemcicy |

`STYLES.md`, `CRAFT.md`, `TRANSLATE.md`, and both gates serve both classes. Only the
loop body forks.

A product with a marketing site and an application is **two runs sharing a palette
and a type system**, not one run pretending both surfaces want the same thing. Say so
rather than averaging them — an averaged design is how a marketing site ends up with
unusable data tables and an app ends up with a hero.

Mixed surfaces exist (a pricing page inside an app, a dashboard embedded in a
marketing page). The class is set per surface, not per project.

## Files

```
AGENTS.md                        universal entry point — the markdown is the product
PRINCIPLES.md                    14 rules, 2 hard
TRANSLATE.md                     input contract: intent → design constraint
STYLES.md                        what it looks like
CRAFT.md                         how it renders
TOOLS.md                         tool-shaped surfaces
loops/01-direction.md            palette, type, concepts, images        → Gate A
loops/02-craft.md                technique, prototypes, motion, budget  → Gate B
agents/surface-designer.md
agents/technique-prototyper.md
skills/inter.face/SKILL.md
commands/interface.md
.claude-plugin/plugin.json
.claude-plugin/marketplace.json
.codex-plugin/plugin.json
.cursor/rules/inter.face.mdc
.clinerules
.windsurfrules
gemini-extension.json
opencode.json
README.md
LICENSE
```

Eighteen files. `TOOLS.md` rather than `INTERFACE.md` so the doc does not collide with
the plugin's own name.

## The merge, decided

### `STYLES.md`

portfolio.me's taxonomy is the base — seven families (surface and material,
structural, atmospheric, motion-native, technical and data, textural, reductive)
against webcrab's six, and the seven cut finer.

Three things merge in from webcrab, none of which portfolio.me has:

1. **"Picking one."** portfolio.me lists styles and trusts taste. webcrab supplies a
   five-input procedure: category cluster, the empty position, anti-positioning, the
   viewer's risk appetite, what the brand already owns. Generalize "buyer" to
   "viewer" and "client" to "subject" and it applies to any interface. This becomes
   the section that makes the file usable rather than browsable.
2. **"Category clichés — the fence, not the field."** Nine categories, each with the
   cliché, why it persists, and the opening. This is what makes `§1` (creativity is
   the baseline) enforceable instead of aspirational — an agent can check its concept
   against a named list. Extend with tool-shaped rows: internal tool, admin panel,
   analytics dashboard, developer console. systemcicy names the first of those
   ("the generic admin template is the failure mode") but never tabulates it.
3. **"Style and conversion"** → generalized to **"Style and the decision"**, since a
   tool surface has a task rather than a conversion.

Kept from portfolio.me unchanged: collision, subversion, the guardrails, style and
accessibility, light and dark as two designs.

New, from neither: **style under density**. Every family gets a line on what it does
when it has to hold forty rows. Some collapse — that is worth knowing at Gate A rather
than at build.

### `CRAFT.md`

portfolio.me's arsenal is the base and is materially deeper: rendering and GPU,
post-processing and treatment, CSS and SVG native, information design, motion and
input, whole-page, typographic craft.

Merges in from webcrab:

1. **"Showing the product."** Eight techniques — live embedded product, scripted
   demo, annotated UI crop, sequenced reveal, before/after scrubber, live data,
   synthetic-data replica, video of the real thing. Nothing in portfolio.me covers
   this and it is the highest-value group for anything with a product behind it.
   Carries its own hard rule: never fake a screen that implies a feature that does
   not exist.
2. **"The cheap wins."** Ten moves ranked by return per byte. This is what a run
   under time pressure should reach for, and it is the difference between express
   mode producing something decent and producing something generic.
3. **"The commercial test"** folds into portfolio.me's `§7` check rather than
   sitting beside it. portfolio.me asks one question (name what this makes the viewer
   understand about the subject); webcrab asks three (understand / which objection or
   proof / what it costs in bytes and main-thread time). The three-question version
   supersedes the one-question version — it is the same test with the cost column
   filled in.

Kept from portfolio.me: prototype before you design around it, the two-tier
performance budget, libraries and the hard rule, when the technique is wrong,
invention.

**States become class-dependent.** Page-shaped keeps portfolio.me's three (full,
designed reduced-motion, no-WebGL fallback). Tool-shaped ships nine, from systemcicy.
The nine are not a longer version of the three — they are a different axis, and a
tool surface with heavy motion owes both sets.

### `TOOLS.md`

systemcicy's `INTERFACE.md`, near-verbatim. It is already written universally; the
work is renumbering its `§` references to this plugin's principles and cutting the
three places it reaches into systemcicy-specific docs (`DOMAIN.md §2`,
`ARCHITECTURE.md §7`, `ARCHITECTURE.md §9`).

Its thirteen sections stand as written: design the day not the screen, density is a
feature, keyboard completeness, the nine states, forms, tables and lists, navigation
and IA, feedback/confirmation/undo, the system's words, mobile and field use,
performance as felt, the design system, and the deliverable.

The one addition: a pointer back to `STYLES.md`, because systemcicy's version assumes
a plain system and never asks what a tool should *look* like. A tool having a
deliberate style is the thing this merge makes possible and neither parent could do
alone.

### `TRANSLATE.md`

All three pipelines independently converged on a translation table — `BRAND.md §"The
translation table"`, `POSITIONING.md §13`, and systemcicy's domain-to-interface step.
That convergence is the real interface between strategy and design, and it is what
this plugin takes as input.

Six rows, and they are the union of what the three tables actually drive:

| Row | Drives |
|---|---|
| **Surface class** | which half of the loop runs |
| **Who is looking, and what decision or task they are doing** | section or screen list, density, what earns space |
| **The three-second feel** | the opening move, the palette temperature, motion character |
| **Archetype + shadow** | the style shortlist, and the collision between them |
| **Anti-positioning** | styles banned outright, honored absolutely |
| **What is already owned** | logo, color sampled from reality, existing type, load-bearing brand elements |

A blank row is a design decision downstream with no derivation — the same rule
portfolio.me's `BRAND.md` states. The plugin refuses to enter Loop 1 with an empty
row; it asks.

Whatever calls the plugin fills the table: a sibling pipeline passes it through, or a
human answers six questions. This is the only input contract, which is what keeps the
plugin independent of any one pipeline.

### `PRINCIPLES.md`

Sixteen rules, from portfolio.me's twenty-five:

- **Thirteen design rules carried and renumbered** — `§1–4` (creativity as baseline,
  out-of-the-box as floor, reinvent every component, propose don't execute), `§7–10`
  (the work is the hero, sample color from reality, own every asset, generate your
  visuals), `§12–14` (accessible by default, performance in two tiers, verify live),
  `§17` (respect the script and language), `§22` (never generate a real person's
  likeness)
- **Keyboard completeness**, from systemcicy — hard there, and hard here for
  tool-shaped surfaces
- **Human gates are real stops**, from `§16`, narrowed to this plugin's two
- **Skipping is allowed, silent degradation is not**, from `§18` — the mechanism that
  makes every other rule optional without letting it rot quietly

**Hard, cannot be skipped:** accessibility, and the two gates. Everything else is
skippable at a cost recorded in `SKIPS.md`.

Dropped as pipeline-specific rather than design: intake (`§0`, subsumed by
`TRANSLATE.md`), evidence tracing (`§5`), named audience (`§6`, subsumed by
`TRANSLATE.md` row 2), anti-slop prose (`§11`, this plugin writes no body copy),
deploy reversibility (`§15`), attribution (`§19`), identity safety (`§20`), NDA
handling (`§21`), third-party claims (`§23`), model tiers (`§24`). Those belong to
whatever ships the design; a design plugin that enforces deploy rules is overreaching.

`§22` is the one that looks like it should have been dropped with the safety rules and
was not, because it constrains image generation, which this plugin does directly.

## The loops

```
Loop 1 DIRECTION ──► Gate A ──► Loop 2 CRAFT ──► Gate B
  class, palette,     concept     technique per     motion +
  type, 2-3 concepts, picked      surface, motion   budget
  image per surface               spec, prototypes  locked
```

Two gates, renamed from portfolio.me's B1/B2 since there is no A or C here.

**Loop 1** — set the class. Sample the palette from reality in OKLCH. Two type
families at most. Generate 2–3 distinct concepts, each stating its collision, its
opening move (page) or its most-repeated action (tool), how the work is presented, how
navigation works, and what happens when something is missing or wrong. Run the
category-reflex check against `STYLES.md`'s cliché table. Dispatch `surface-designer`,
one agent per surface, one horizontal image each — never a compressed board.

**Loop 2** — assign a technique per surface from `CRAFT.md` that serves the approved
style. Every assignment passes the three-question commercial test. Dispatch
`technique-prototyper`, one agent per technique: standalone runnable HTML, screenshot,
measured frame rate under load, byte cost, all required states, and a verdict of ship
/ cut / ship-with-caveat. Write the motion spec and declare both budget tiers. Write
`DIRECTION.md`.

Both gates carry portfolio.me's rejection diagnosis: distinguish a rejected
*execution* from a rejected *concept* from a rejected *brief*, because they go back to
different places, and three rejections at the same gate means the translation table is
wrong rather than the work.

## Cross-agent packaging

Copied from portfolio.me, retargeted. Seven adapters, all pointing at one `AGENTS.md`:

| Agent | File |
|---|---|
| Claude Code | `.claude-plugin/plugin.json` + `marketplace.json` + `skills/` + `commands/` |
| Codex | `.codex-plugin/plugin.json` (`contextFile`) |
| Cursor | `.cursor/rules/inter.face.mdc` |
| Windsurf | `.windsurfrules` |
| Cline | `.clinerules` |
| Gemini | `gemini-extension.json` (`contextFileName`) |
| opencode | `opencode.json` (`instructions`) |

The two worker agents are markdown specs, not a Claude-Code-specific mechanism. An
agent that can spawn subagents dispatches them in parallel; one that cannot reads the
file and does the work inline. `AGENTS.md` says so explicitly.

## Out of scope

- **Any sync mechanism back to the three siblings.** Their copies stay where they are;
  this becomes canonical. Regenerate them when drift bites, not before.
- **A GitHub fork of portfolio.me.** The content is a union of three repos, and a fork
  network tangles the marketplace listing with the parent's. Fresh repo under
  PIIIX-org, README crediting all three parents.
- **Native platform craft.** `CRAFT.md`'s arsenal is web technique — WebGL, CSS, SVG,
  View Transitions. For iOS or Android the principles hold (prototype first, states,
  two-tier budget, name what it teaches) and the arsenal does not. State that limit in
  `AGENTS.md` rather than shipping a speculative native appendix.
- **Building the site.** The plugin stops at `DIRECTION.md`.

## Open question, resolved by default

Whether the three siblings should eventually delete their copies and depend on this
plugin. Not now. A markdown pipeline that has to run in Cursor and Cline cannot
resolve a cross-repo import, and coupling three working pipelines to a fourth repo
buys drift-fixing at the cost of every run needing two checkouts. Revisit only if the
same fix has to be applied in three places twice.
