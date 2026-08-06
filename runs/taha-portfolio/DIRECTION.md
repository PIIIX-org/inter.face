# DIRECTION — taha-portfolio

**Concept:** `as-built` · **Signed at Gate A:** 2026-08-06 · **Gate B:** pending, held by the human
**Loops:** 1 (direction) complete · 2 (craft) this file · 3–4 (copy, build) not started
**The record this replaces nothing of:** `direction-draft.md` is the Loop 1 working record and
`craft-draft.md` the Loop 2 one. **This file is the handoff.**

> **The test this file is written against:** could a build agent execute it without making a single
> aesthetic decision? Where the answer is still no, the row says so out loud rather than reading as
> if it were settled.

---

## 1 · Concept, and why it won

**`as-built`** — an issued technical drawing, with the site engineer's coral redline drawn straight
over it, showing what actually got built and where the plan was wrong.

The subject chose it at Gate A from three derived concepts, cleanly: no mixing, no rejection, no
clarifying questions. He had read the concept's riskiest element — a live paragraph of 17px body
text set in a display face — rendered in the gate artifact, and picked the concept containing it.

**Why it won, in the subject's own terms.** Row 4 of the translation table gave three archetype
words: *builds for the thrill of the problem, indifferent to applause, unafraid of risk and
mistakes* — and a shadow: *the identity-maker's own craft of self-presentation; he designs
identities and refuses to perform his own.* An as-built drawing is the least glamorous document a
project produces and the only one that admits in writing that the plan was wrong. It is the one
format where showing the mistakes is the document's function rather than a confession bolted on.

**The two concepts not chosen.**
- **`bench`** — a workbench at 2 a.m., single-key lit, nothing put away. Rendered row 4's own
  physical check most directly. Not chosen. Its cost is recorded in RISK 1: it was the direction
  that would have needed two full art directions and a generated key-light field carrying the whole
  concept.
- **`strip-board`** — a control tower's flight-progress board, every job a paper strip moving
  between bays. The safest of the three, and the only one a stranger could navigate with the sound
  off. Not chosen.

**The concept rejected before Gate A, and why — it is the more useful record.** `tear-down`: an
engine tear-down shot from overhead on a dark tray, every part laid out in the order it came off,
the two that failed set slightly apart. It derived cleanly and was the most immediately beautiful
of the four. It was **cut on translation-table row 5**, which is on `BREAKING.md`'s never-breakable
list: an arranged, evenly-lit overhead of parts in order is a **curation**, and a curation is the
work-as-exhibited framing row 5 bans absolutely. The arrangement is the tell. Rejecting it is what
forced the `as-built` derivation, which reaches the same material — evidence of what went wrong —
through a document rather than a display.

## 2 · Collision, structural parent named first

> **The issued technical drawing — title block, dimension grid, sheet numbers, revision clouds —
> carries the structure; the site engineer's coral redline drawn straight over it carries the
> surface.**

**Modification against the named parent.** `STYLES.md` lists "ink gesture across data-brutalism".
This is not that. **A redline is a correction, not a gesture:** it is legible, dimensioned and
dated, and it never sits over a table — it sits over a *drawing that a plan already made a claim
about*. The gesture version asserts that a person had a view. This version proves a person was
wrong and fixed it.

**Not a subversion.** No named rule is being broken by the collision itself. Breaks made during
execution are in §25 with their costs.

## 3 · Surface class · platform mode

| | |
|---|---|
| **Surface class** | `page-shaped` — read once, in seconds, by a cold viewer on an unknown device |
| **Platform mode** | `neutral` — **web only.** No iOS surface, no Android surface, no native app |
| **Branch** | Greenfield with owned assets. No live site to extract, no `CURRENT.md`, no redirect map |
| **Script / direction** | Latin, LTR, English. See §26 for the deferred RTL version and its cost |
| **Surfaces** | 6, plus a 404 and a failed-submission state |

**Consequence of `neutral`, stated because it changes what `tokens.json` can hold:** there are no
`pt` and no `dp` values in this run, because there is no native surface to carry them. See §22.

## 4 · Style under density

> **At forty rows it becomes a schedule, which drawings already have.**

Mechanically, and these are the numbers that make the sentence true rather than hopeful: hairline
rules at 1px (cyanotype) / 0.75px (diazo), tabular figures throughout, 40px rows on the 4px
vertical rhythm, and **the redline confined to the `REV` column** so forty rows do not become forty
corrections. This is the least density-exposed of the three concepts derived, and the reason is
structural: a drawing set already contains a door schedule, so density is the format's native state
rather than a stress on it.

## 5 · Palette

**Sampled source:** `~/Documents/madeintaha-portfolio/css/style.css`, the subject's own
shipped-but-unlaunched portfolio, custom-property block lines 14–54 — re-read at run time, not
recalled. The accent was declared there with the subject's own reasoning attached:

```css
--coral:     #e9503a;   /* accent surfaces */
--coral-ink: #c63f28;   /* accent text, large only (>=3:1 on paper) */
```

**Every ratio below was recomputed in Loop 2 from an independent implementation of the WCAG
relative-luminance formula. Twelve of thirteen reproduce Loop 1 exactly. The thirteenth — the focus
ring's flip case — did not, and is corrected in §21.**

### Dark = cyanotype

| Token | Hex | OKLCH | Legal foreground | Ratio | Used at |
|---|---|---|---|---|---|
| `field` | `#0e2e2c` | `oklch(27.7% 0.037 189.6)` | `#efe7d6` | **11.81:1** | body 17px |
| `line-primary` | `#efe7d6` | `oklch(93.0% 0.024 85.8)` | on `field` | **11.81:1** | **1.5px** stroke, body, headings |
| `line-secondary` | `#7fb5ad` | `oklch(73.3% 0.058 184.6)` | on `field` | **6.30:1** | **1px** stroke, dimension micro 12px |
| `redline` | `#f26a52` | `oklch(68.7% 0.173 31.9)` | on `field` | **4.81:1** | **2px** stroke; 16px italic where it speaks |
| `redline` on lit surface | `#f26a52` | — | on `#123230` `oklch(29.3% 0.038 189.8)` | **4.56:1** | body-legal |
| `field-ink` (on accent block) | `#0e2e2c` | — | on `#f26a52` | **4.81:1** | stamp text 40px; focus ring flip |

### Light = diazo / whiteprint

| Token | Hex | OKLCH | Legal foreground | Ratio | Used at |
|---|---|---|---|---|---|
| `field` | `#fbf8f1` | `oklch(98.0% 0.010 87.5)` | `#0e2e2c` | **13.69:1** | body 17px |
| `line-primary` | `#0e2e2c` | `oklch(27.7% 0.037 189.6)` | on `field` | **13.69:1** | **1px** stroke — retuned down from 1.5 |
| `line-secondary` | `#14403d` | `oklch(34.0% 0.048 188.9)` | on `field` | **10.82:1** | **0.75px** stroke, dimension micro 12px |
| `redline` | `#c63f28` | `oklch(56.0% 0.175 32.2)` | on `field` | **4.78:1** | **1.5px** stroke; 16px italic where it speaks |
| `redline-tint` | `#e9503a` | `oklch(63.8% 0.193 31.0)` | — | **3.49:1** | **cloud outlines only — never text** |
| `field-ink` (on accent block) | `#fbf8f1` | — | on `#c63f28` | **4.78:1** | stamp text 40px; focus ring flip |

**Reference values used by the focus ring and by nothing else:** `#0c2422` `oklch(24.0% 0.030 188.1)`,
`#f2ede3` `oklch(94.7% 0.014 84.6)`.

### The constraint that is permanent — RISK 4

**The sampled accent cannot carry body text in light mode except on one substrate.** This is a
measurement, not a preference, and it does not expire:

| Accent on substrate | Ratio | Verdict |
|---|---|---|
| `#c63f28` on `#fbf8f1` | **4.78:1** | **body-legal — the only light-mode text case** |
| `#c63f28` on `#f2ede3` | 4.34:1 | large text only (≥18px) — misses 4.5 |
| `#e9503a` on `#fbf8f1` | 3.49:1 | **graphical only. Never text, at any size** |
| `#f26a52` on `#0e2e2c` | **4.81:1** | body-legal |
| `#f26a52` on `#123230` | **4.56:1** | body-legal |

**If a later build wants coral body text anywhere outside that list, the answer is no.** The only
two ways out are shifting the sampled hex — which breaks `§6`'s sample-from-reality — or changing
the substrate, which changes the direction. Both are Gate A decisions, not build decisions.

### There is no grey ramp

`direction-draft.md` §5 gave the two unchosen concepts a full neutral ramp and gave this one none.
Filled here, and the drawing settles it without a new colour: **a drawing sheet has two inks.** A
voided, parked or disabled entry is set in `line-secondary` **plus a 1px strike rule** through the
value — `#14403d` on `#fbf8f1` = 10.82:1, `#7fb5ad` on `#0e2e2c` = 6.30:1. Both stay fully legible,
which is correct for a document where a voided entry must remain readable, and colour is never the
sole signal because the strike carries it.

## 6 · Modes

**Two art directions, by print convention — declared, not implied.** White-on-blue and blue-on-white
are both real reprographic conventions, and this direction switches between them on purpose.

**The mode work is the line weights, not the hues.** The accent is the same family in both; what
changes is stroke weight, because a hairline that reads on a dark field disappears on white and the
two print processes lay ink down differently:

| | cyanotype (dark) | diazo (light) |
|---|---|---|
| primary line | 1.5px | **1px** |
| secondary line | 1px | **0.75px** |
| redline | 2px | **1.5px** |

Never `filter: invert()`. Never one lightness shift applied to one stop list.

## 7 · Type

**One family — Cabinet Grotesk — across all six roles, and the direction earns it.** A drawing sheet
is lettered in one lettering set. A second family on a sheet reads as a second draftsman, which is
the one thing an as-built must never suggest, because the document's entire authority rests on one
hand having made both the drawing and the correction. **The roles separate by case, tracking and
weight, never by a second face.**

**There is no modular ratio, and pretending there is one would be a fabrication.** The scale is
**role-indexed**, exactly as a drawing sheet's lettering set is — ISO lettering heights are a fixed
series of named sizes, not a geometric progression. The adjacent-step ratios are 1.083, 1.231,
1.063, 1.059 and then a deliberate jump of 2.22×: a drawing has lettering, and it has a sheet title,
and it has nothing in between. Every computed value is written out below, in both units.

| Role | rem | px | Weight | Line-height | Tracking | Case | Measure |
|---|---|---|---|---|---|---|---|
| sheet title (h1) | `clamp(2.5rem, 5vw, 4.5rem)` | 40 → 72 | 700 | 1.0 | 0.02em | caps | — |
| drawing lettering (h2) | 1.125rem | 18 | 500 | 1.2 | 0.16em | caps | — |
| title-block field | 0.8125rem | 13 | 600 | 1.3 | 0.08em | caps | — |
| dimension micro | 0.75rem | 12 | **500** (per Gate B ruling) | 1.1 | 0.1em | caps, **tabular** | — |
| note / body | 1.0625rem | 17 | **500** (per Gate B ruling; renders from the 500 file) | 1.65 | 0 | sentence | **60ch** |
| redline | 1rem | 16 | 500 *italic* | 1.4 | 0.01em | sentence | — |

**Variable axes:** none. Cabinet Grotesk is shipped here as static instances, so `CRAFT.md`'s
"weight alone is the amateur signal" is answered by *case and tracking*, which is what a drawing
uses, rather than by axes the font files do not carry.

**Tabular figures** on every `MARK`, `SCALE`, `REV`, dimension callout and date, via
`font-variant-numeric: tabular-nums`.

### ⚠ The weight availability problem — found in Loop 2, unresolved, and it is load-bearing

`prototypes/fonts/fonts.css` vendors **Cabinet Grotesk at weights 500, 700 and 800 only.** There is
**no 400 file, no 600 file, and no italic file.** Under CSS font matching that means:

| Spec says | Actually renders from | Consequence |
|---|---|---|
| body 17px **400** | the **500** file | body is **heavier than specified** — the wrong direction for a display face at text size, and it makes RISK 3 worse than Loop 1 assumed |
| dimension micro 12px **400** | the **500** file | 12px caps at 500 in a display face |
| title-block field **600** | the **700** file | head/value weight contrast in the title block is not what was drawn |
| redline **500 italic** | **synthesised oblique** — a sheared upright | the one voice on the sheet is set in a fake italic |

**This is a Loop 1 gap**, not a Loop 2 one: §6 assigned a weight per role without checking which
weights the owned files contain, and nothing in `loops/01-direction.md` or `STYLES.md` asks the
question. **It is priced in §26 and it is an input to the RISK 3 verdict in §18.**

## 8 · Spacing

**Base unit: 4px**, the drafting grid. **The 8px multiple binds separately** on any pair of adjacent
interactive targets, because a 16px glyph plus an 8px gap is exactly 24px centre-to-centre and
clears the spacing route; a 6px gap fails, and the visual difference between them is two pixels.

| Step | px | rem | Where it is the answer |
|---|---|---|---|
| `space.1` | 4 | 0.25 | vertical rhythm unit; cell padding in the schedule |
| `space.2` | 8 | 0.5 | minimum gap between adjacent inline affordances |
| `space.3` | 12 | 0.75 | title-block cell inset |
| `space.4` | 16 | 1 | narrow-viewport gutter and margin |
| `space.6` | 24 | 1.5 | **column gutter**, all breakpoints ≥768 |
| `space.8` | 32 | 2 | **drawn sheet border** inset, desktop |
| `space.12` | 48 | 3 | **sheet margin**, desktop |
| `space.16` | 64 | 4 | gap between schedule blocks |
| `space.24` | 96 | 6 | **title-block band height**; `scroll-padding-block-end` |
| `space.32` | 128 | 8 | section separation on the sheet |

Steps are named by their multiple of the 4px base, so `space.24` is 24 × 4px = 96px. Absent numbers
in the sequence are deliberately absent — a step that has no job does not get a token.

## 9 · Radius

**0px at every step. A drawing has no radii.**

| Element | Radius |
|---|---|
| sheet border, title block, schedule cells, stamp block | `0` |
| inputs, buttons, focus ring, revision-cloud bounding box | `0` |

**The concentric rule is in use and it is worth stating rather than omitting:** inner = outer −
gap. With the outer radius at 0, every nested inner radius computes to 0 and clamps there. So the
rule is satisfied trivially, three levels deep, and a builder who reads "radius 0" and adds a 4px
radius to an input has broken the concentric rule and the direction in one move.

## 10 · Stroke and divider

| Line | cyanotype | diazo | Contrast on field |
|---|---|---|---|
| primary — object outlines, section rules, sheet border | **1.5px** | **1px** | 11.81:1 / 13.69:1 |
| secondary — grid hairlines, dimension lines, leaders, schedule rules | **1px** | **0.75px** | 6.30:1 / 10.82:1 |
| redline — corrections, revision clouds, `REV` marks | **2px** | **1.5px** | 4.81:1 / 4.78:1 |

**Where the hairlines come from `gap`, not `border`.** The drawing schedule (Surface 4) and the
title block (Surface 2) are `display: grid` with the rule colour as the container background and
each cell carrying the field colour, so the rules are **gaps in a background rather than edges on
elements**. Borders would draw every internal line at 2px and every outer line at 1px, and would
antialias against a nested corner. There is no adjacency problem to solve when the lines are gaps.

*The 0.75px diazo secondary weight is the one number in this table under test — see §18, T4.*

## 11 · Elevation

**This direction has no shadow language.** No `box-shadow` at any level, no elevation scale, no
tinted surface stack. Depth on a drawing sheet is carried by **line weight** — primary reads
forward of secondary — and by nothing else.

Derived in Loop 2, not inherited: `direction-draft.md` gave no elevation row for this concept. It
follows from radius 0, two flat inks, and a print convention that has no light source. **A shadow
anywhere on this surface is a build error, not a taste difference.**

## 12 · Background and surface treatment

**No gradient anywhere in this direction.** Both of the unchosen concepts closed on a
`tonal-gradient` contact section; this one closes on *two flat fields meeting on a hard edge*. That
is a stated divergence, not an omission — a diazo print has no gradient in it.

| Treatment | Where | Specification |
|---|---|---|
| **Generated line work** | S1 hero, S3 mesh | SVG, generated in-browser per `§8`. No raster is placed, no stock is used |
| **Hairline mesh** | S3 `textured-surface` | The drawing grid at low contrast: `line-secondary` at **12% opacity**, 24px pitch, no blend mode, no noise |
| **Duotone** | S5 detail | Exactly two palette values — field colour and primary line colour — per mode. Cyanotype `#0e2e2c`/`#efe7d6`; diazo `#fbf8f1`/`#0e2e2c`. **No third value, no photographic grey.** See §18, T5 |
| **Colour block** | S6 stamp | A solid accent field (`#c63f28` light / `#f26a52` dark) meeting the sheet field on a hard 0-radius edge |
| **Grain / noise** | nowhere | Deliberately none. The texture in this direction is drawn line work, not synthesised noise |

**Every supplied photograph** (`§14`) receives the duotone treatment before it reaches the page.
There is currently exactly one raster in the design — S5's detail — and it is the whole of tier 2.

## 13 · Icons

`direction-draft.md` specified the accessible name for every icon-only control and nothing else
about the icon system. Filled in Loop 2 from `CRAFT.md`'s icon research.

| Decision | Value |
|---|---|
| **Source** | **Custom-drawn for this run.** No library | 
| **Licence** | n/a — original work, so no attribution burden and no `SF Symbols` licence exposure |
| **Grid** | 24px canvas, **20px live area**, 2px padding, **2px stroke**, corners at **radius 0** |
| **Format** | SVG, inline, currentColor |
| **Stroke weight per mode** | **matches the drawing's own line retune**: 2px cyanotype, 1.5px diazo |
| **Icon size / target size pair** | **20px icon inside a 44 × 44 CSS px target** |

**Why custom rather than a library, and it is the same argument as the single type family:** a
borrowed icon set is a second draftsman's hand on the sheet. The glyphs are drawn on the same grid,
at the same stroke weight, as the drawing they sit next to.

**Named divergence from Material's verified grade rule.** Material's research says a light icon on
a dark background takes grade −25 to correct for visual bleed, where a dark icon on light takes 0 —
i.e. lighten-on-dark should be drawn *thinner*. **This direction does the opposite**: cyanotype
strokes are heavier (2px) than diazo strokes (1.5px), because the icons must match the adjacent
drawing line, which is itself heavier on the cyanotype by print convention. An icon at a different
weight from the line beside it reads as a second hand, which costs more than the bleed correction
buys. Recorded here so it is a decision rather than an oversight.

**Below 20px a key-action icon owes a visible text label** (Material's rule, and it binds): the
footer social row ships **visible text labels**, not bare glyphs.

**Icon localisation** (`§13`) is deferred with the RTL version — see §26.

## 14 · Grid and layout

Desktop is Loop 1's; the breakpoint ladder below it was written in Loop 2, because
`direction-draft.md` gave one breakpoint only.

| Breakpoint | Sheet width | Columns | Gutter | Sheet margin | Drawn border | Title block |
|---|---|---|---|---|---|---|
| ≥ 1512px | 1512px, centred | **16** | 24px | 48px | 32px | persistent, 96px, bottom |
| 1024–1511px | fluid | **16** | 24px | 32px | 24px | persistent, 96px, bottom |
| 768–1023px | fluid | **8** | 16px | 24px | 16px | persistent, 96px, bottom |
| < 768px | fluid | **4** | 16px | 16px | 12px | **static footer, in flow** |

**Vertical rhythm: 4px at every breakpoint.**

### Collapse order, named per surface

| Surface | Collapse |
|---|---|
| S1 hero | The drawing field crops from the right; the h1 and the single redline note hold the upper-left corner. Height `min(90vh, 940px)` → `min(80vh, 640px)` below 768 |
| S2 title block | The 5-cell strip (cols 9–16) becomes 5 stacked labelled rows in the same serial order; the notes cell moves above it |
| S3 revision cloud | Cols 3–11 → full width. **The 4° rotation drops to 0° below 768** and the callout leader becomes a vertical drop |
| S4 schedule | Each row's 5 columns become **5 stacked labelled lines in the same order**. Column order is preserved absolutely; a schedule that reorders its columns is an unusable drawing |
| S5 detail at 1:5 | The 60/40 split stacks: detail first, written account second |
| S6 stamp | The 560px stamp block goes full-bleed minus the sheet margin; the sheet border continues around it unbroken |

## 15 · Navigation model

**The sheet index, printed in the persistent title block.** There is no nav bar in this direction —
a drawing set is navigated by its sheet index, and the title block is where it lives.

| | |
|---|---|
| **Pattern** | `nav aria-label="Sections"` inside the persistent title block; six in-page anchors, `SHEET 01`–`SHEET 06` |
| **Position** | bottom-right of the sheet, **96px band**, persistent, at ≥768px |
| **Below 768px** | becomes a **static footer in the same serial order** — `3.2.6`'s responsive exception, which permits a visual move as long as serial order holds |
| **Current sheet** | marked by **a coral box AND the printed word `CURRENT`**, plus `aria-current="true"`. **Never colour alone** |
| **Obscuring** | `scroll-padding-block-end: 96px` at ≥768px, so a jumped-to section is never hidden behind the block |
| **Keyboard contract** | Skip link "Skip to content" is **first in tab order**, visible on focus. Activating a sheet link **moves focus to that section's `h2`** (`tabindex="-1"`), never to `<body>`. A disclosure closing returns focus to its trigger |
| **Target size** | 44 × 44 CSS px per sheet link |
| **Landmarks** | one `banner`, one `main`, one `contentinfo`, one `nav`. **The page is not wrapped in a `<section>`** — that silently deletes `banner` and `contentinfo` with no visual change and no error |

## 16 · Content presentation

**The drawing schedule** — the door-schedule pattern every drawing set already contains. Not a card
grid; the concept has no card anywhere.

| Column | Width (≥1024) | Type | Alignment |
|---|---|---|---|
| `MARK` | 96px | 13px / 500 / **tabular** | left |
| `DESCRIPTION` | fluid, min 280px | 15px / 400 | left |
| `SCALE` | 120px | 13px / 400 / **tabular** | left |
| `REV` | 72px | 13px / 400 / **tabular**, **the only column carrying the redline** | right |
| `NOTES` | fluid, min 200px | 13px / 400 | left |

Row height **40px** on the 4px rhythm. Column heads 13px / 600 / 0.08em caps. Rules from grid `gap`
per §10. **Per-item attribute positions are fixed and do not reflow** — positions holding absolutely
is the whole reason the pattern is legible, and a schedule that moved its columns would be an
unusable drawing.

`SCALE` carries the honest size of the engagement. **`REV` carries how many times the thing was
reworked**, which is the concept's argument made checkable.

## 17 · Buttons and controls

Not specified in Loop 1. Written here, all seven states, per mode.

**Shape:** rectangular, **radius 0**, 1px border in `line-secondary`, no fill except the primary
action. **Padding:** 12px 24px (`space.3` / `space.6`). **Height:** 44px, meeting the target-size
route. **Label:** 16px / 600 / 0.08em caps.

| State | Light (diazo) | Dark (cyanotype) |
|---|---|---|
| **default** — primary | fill `#c63f28`, label `#fbf8f1` (**4.78:1**), no border | fill `#f26a52`, label `#0e2e2c` (**4.81:1**), no border |
| **default** — secondary | field fill, label `#0e2e2c` (13.69:1), 1px `#14403d` border (10.82:1) | field fill, label `#efe7d6` (11.81:1), 1.5px `#7fb5ad` border (6.30:1) |
| **hover** | 2px underline in the label colour appears beneath the label. **No fill change, no lift, no shadow** | same |
| **focus-visible** | 2px ring + 2px offset, per §21 — including the flip on the coral fill | same |
| **active** | label and border shift to the redline; the button's own 1px baseline rule thickens to 2px | same |
| **disabled** | label and border in `line-secondary` **plus a 1px strike rule through the label** | same |
| **error** | a **revision cloud** drawn around the control, with a redline note beside it naming the correction. `aria-invalid="true"`, note bound by `aria-describedby` | same |
| **loading** | the label is replaced by the word `ISSUING` and the control is `aria-busy="true"`. **No spinner** — a drawing has no spinner | same |

**Inputs:** 44px tall, radius 0, 1px `line-secondary` border (10.82:1 / 6.30:1 — both clear
`1.4.11`'s 3:1, which is where most systems fail), label above in title-block-field style, value in
17px body. **On a failed submission every entered value is preserved, never cleared.**

## 18 · Per-surface technique

Seven techniques assigned, seven prototyped, **six ship and one is cut.** Two surfaces were
assigned no technique at all, which is a verdict rather than an omission.

**The evidence ceiling for this whole table, stated once:** no CPU-throttling instrument was
reachable in this run, and the synthetic-load substitute was verified **not to bite** (an 8ms
per-frame burn fits inside a ~11ms frame budget, so `load=0` and `load=8` returned the same
figures). The in-page painted readouts and `window.__fps` also disagree — 59.9 versus 88.5 median
on the same page — which means headless rAF here is not pinned to a real display. **Therefore no
frame-rate number in this run is evidence of smoothness on a target device, and every performance
claim caps at PARTIAL.** It matters less than it would elsewhere: this technique set contains no
WebGL, no canvas render loop and no particle system, so the performance risk is low *by
construction* rather than low *by measurement*. Those are different claims and only the second one
would need a throttle.

| # | Surface | Technique | Verdict | Label | Bytes (raw / gzip) |
|---|---|---|---|---|---|
| T1 | S1 hero | SVG line-work drawing field | **ship** | PARTIAL | 23,229 / **6,969** |
| T2 | S1 + S3 | Redline draw-on, `stroke-dashoffset` | **ship-with-caveat** | PARTIAL | 24,820 / **7,592** |
| T3 | S3 + error state | Revision-cloud generator | **ship** | PARTIAL | 21,233 / **7,250** |
| T4 | S4 | Grid-determinist hairline schedule | **ship** | PARTIAL | 26,000 / **5,411** |
| T5 | S5 | Duotone detail | **CUT** | TESTED | — (0, cut) |
| T6 | all six | Persistent title block + sheet index | **ship** | PARTIAL | 24,844 / **7,669** |
| T7 | cross-surface | Typography — the RISK 3 verdict | **ship-with-caveat** | TESTED | 24,669 / **8,477** |

*Prototype byte figures are whole standalone demo pages carrying instrumentation, comparison
blocks and explanatory prose. They are an upper bound on the technique, not the technique's cost.*

### T1 — SVG line-work drawing field · **ship** · PARTIAL

Renders as an actual drawing sheet: sheet border, grid hairlines, plan/elevation/section views,
dimension lines with arrowheads and tabular micro-callouts, revision clouds, revision schedule and
title block. The concept is legible in three seconds — a plan and a correction to the plan, in two
inks. **All three render states built and run**, at 1440 and 390, in both modes, plus a separate
JS-disabled pass (16 screenshots). The `§8` tension was resolved toward **static SVG authored into
the HTML**, so the field paints with no JavaScript at all.
**Caveat that is not a caveat on the verdict:** frame rate is irrelevant here — the field is static
markup with no render loop.

### T2 — Redline draw-on · **ship-with-caveat** · PARTIAL

**The caveat, named exactly:** *the draw-on runs only on redlines below the fold. The hero's redline
is painted at rest, at full opacity, from first paint.* The prototype's own readout confirms it —
`DRAWN 0/6` above the fold — and its source is sectioned accordingly:
`SURFACE 1 — HERO. ABOVE THE FOLD. NOTHING ANIMATES HERE.` This resolves the hard conflict in
`loops/02-craft.md` §3 rather than papering over it.

**Second caveat, honestly reported rather than hidden:** `stroke-dashoffset` is **not** a compositor
property. It animates on the main thread, which is exactly what `CRAFT.md`'s "Compositor-only
motion" rule warns about. It is accepted here because the load is genuinely small — at most six
short paths, drawn once, gated on intersection, below the fold — and because the alternative
(a `clip-path` or `mask` wipe on `transform`) reads as a *wipe* rather than as a *pen*, which loses
the one thing the technique exists to communicate. **Recorded as a broken rule in §25 with its
cost**, not waved through.

### T3 — Revision-cloud generator · **ship** · PARTIAL

Wraps arbitrary bounding boxes — 900×160, 240×520 and a 320×44 form field — without the scallops
degenerating. The outline uses the graphic-only tint and carries no text, so RISK 4 holds.
**The failed-form-field application is real**, not a mockup: the entered value is preserved
verbatim, the redline note names the correction in words, and the cloud is never the only signal.
**The strongest result in the set:** the `nogpu` state draws the cloud with a **pure CSS
`border-image`**, so the error marker survives with JavaScript disabled, around all three aspect
ratios. A generator that could not survive JS-off would have forced a real design change.

### T4 — Grid-determinist hairline schedule · **ship** · PARTIAL

40 rows, five columns, rules rendering as **grid gaps rather than borders**, so nothing doubles at
intersections. **The 0.75px question is answered: at DPR 1 the 0.75px gap renders and is visibly
present rather than vanishing.** Tabular alignment holds down the full 40 rows. The narrow-viewport
collapse to five stacked labelled lines preserves DOM order. The worker labelled its own padding on
the sheet — *"Rows 13–40 are placeholder sheet entries; rows 1–12 are the real register"* — which
is the honesty the loop asks for.

### T5 — Duotone detail · **CUT** · TESTED

**Cut, and not on performance.** The colour measurement is clean and is the one genuinely TESTED
number in this table:

| Filter | Distinct colours | Top values |
|---|---|---|
| untreated source | 822 | — |
| `dt-cyanotype` | **exactly 2** ✓ | `#0e2e2c` 98.05% · `#efe7d6` 1.95% |
| `dt-diazo` | **3** ✗ | `#fbf8f1` 96.03% · `#0e2e2c` 3.50% · **`#000000` 0.47%** |

Three reasons, in order of seriousness:

1. **The asset is fabricated, and the page asserts that it is not.** `detail-atlas-login.webp` was
   created by the prototyper at 17:02, mid-run — it was never supplied by the subject and never
   photographed off anything. The surrounding copy states *"the plate opposite is its sign-in
   screen, photographed off the running build rather than drawn from memory"* and **"Nothing here
   is a mock."** That is a fabricated provenance claim about a real product, and `CRAFT.md` is
   explicit: *never fake a screen that implies a feature that does not exist.* The dispatch warned
   against exactly this and offered the honest alternative — a labelled stand-in capped at PARTIAL.
2. **The diazo treatment fails its own spec**, emitting pure `#000000` — a value in neither palette
   — across 0.47% of pixels.
3. **Legibility degrades under treatment.** The source UI's text goes heavy and muddy at two
   values, and the plate overflows its frame at 1440.

**What is actually cut, precisely.** The *technique* is sound — cyanotype hit exactly two values,
which is the thing that was in doubt. What is cut is **shipping S5 in this run**, because there is
no real asset to treat. **Surface 5 ships in its base state**: the written account at 60ch beside
the drawn detail, no raster. Per Gate B's own rule, cutting with nothing in its place is a valid
outcome — the surface still works and the budget improves. The technique is re-admissible the
moment the subject supplies a real screenshot, and it faces this same test again.

### T6 — Persistent title block + sheet index · **ship** · PARTIAL

Mostly an accessibility prototype, and the accessibility claims are genuinely TESTED. Verified in
the built page: `scroll-padding-block-end: 96px` present and doing work; sheet-index links at
`min-width: 44px` / `min-height: 44px`; the current sheet marked by coral box **and** the printed
word `CURRENT` **and** `aria-current`, proven by a greyscale screenshot where the state survives
without hue; the skip link screenshotted focused; and **both focus-ring cases screenshotted —
normal and the flip on a coral element** — which is the case §21 had to correct.

### T7 — Typography, the RISK 3 verdict · **ship-with-caveat** · TESTED

**The font-availability findings are measured, not asserted**, by advance-width comparison:

| Finding | Evidence | Status |
|---|---|---|
| body `font-weight: 400` resolves to the **500** file | w400 and w500 probe strings both **217.31px** | CONFIRMED |
| title-block `600` resolves to the **700** file | w600 and w700 both **221.31px** | CONFIRMED |
| the 16px redline italic is a **synthesised oblique** | italic and upright both **204.53px**; a real italic changes advances | CONFIRMED |
| `document.fonts.check()` cannot detect any of it | returns `true` for every weight — it matches by *nearest available face* | CONFIRMED |

That last row is the one worth carrying beyond this run: **the obvious detection method silently
lies.** Only advance-width comparison finds a missing weight.

**The caveat, named exactly, and it is mandatory rather than advisory:** *the single-family claim
holds only if Cabinet Grotesk 400 and a true italic are acquired and subset before build. If they
are not, body copy ships at weight 500 in a display face at 17px and RISK 3 is unmitigated rather
than accepted.* The fallback if they cannot be acquired is the stated size bump to 18px, which
reflows every column measure and the 16-column grid — a Loop 2 redraw, not a build tweak.

**And the honest limit of what a prototype can settle here.** Metrics, rendered screenshots and
advance widths can prove *what is rendering*; they cannot settle whether 300 words of it are
comfortable to read. That is a judgment, and **Gate B has a human in front of it who can make it by
reading the block.** This verdict deliberately stops short of claiming the readability question is
closed.

## 19 · Motion spec

**There is exactly one piece of narrative motion in this design: the redline draw-on.** Everything
else on all six surfaces is static. That is the whole spec, and keeping it that small is deliberate.

| Parameter | Value |
|---|---|
| **Draw — short callout** | **340ms** |
| **Draw — medium correction** | **370ms** |
| **Draw — long correction line** | **390ms** |
| **Draw — full-width sheet correction** | **900ms** |
| **Exit** | **260ms** — shorter than every enter |
| **Stagger between redlines** | **90ms**, **capped at 360ms** total (so the 5th and later redlines carry no additional delay) |
| **Easing, enter** | `cubic-bezier(0.33, 0, 0.15, 1)` — named `draw` |
| **Easing, exit** | `cubic-bezier(0.4, 0, 1, 1)` — named `lift` |
| **Trigger** | `IntersectionObserver`, `threshold: 0.4`, `rootMargin: '0px 0px -15% 0px'` |
| **Scroll listener** | **none, anywhere.** No `scroll` handler, no `resize` handler that measures |

**Two rules that do not fork, both honored and both proven:**
- **Nothing animates above the fold.** The hero's redline is painted at rest, at full opacity, from
  first paint. Verified by the prototype's own `DRAWN 0/6` readout on the above-fold frame.
- **Motion never gates information.** Every redline's text is present and readable before, during
  and after the draw; the animation reveals the *stroke*, never the words.

### The reduced-motion state, art-directed

`§10` is **[HARD]** and this is the part most often faked. The state is **not** `animation: none`:

> **Both inks at full opacity from first paint, and the redline's stroke ends rendered squared
> (`stroke-linecap: butt`) rather than round.**

The squared end is what makes it read as **drawn and finished** rather than as **caught mid-draw**.
A viewer who never saw the full version cannot tell anything is missing — which is the actual test.

Honored at **both layers**: the CSS media query, and `matchMedia('(prefers-reduced-motion: reduce)')`
in JS **with a `change` listener**, so a mid-session preference change is respected.

**Checked against Apple's five techniques:** no z-axis depth transition anywhere, and nothing
animates into or out of a blur. Those are the two nobody removes, and there was nothing to remove
because neither was ever used.

## 20 · Budgets

### Tier 1 — the shell. **Ceiling 100KB. Estimate ~79KB. Passes, with ~21KB of headroom.**

| Item | Bytes | Basis |
|---|---|---|
| Cabinet Grotesk 500 + 700 + 800, woff2 | **60,764** | **measured** — the three files actually vendored |
| HTML + critical CSS, six surfaces | ~18,000 gz | **inferred** from the prototypes' 5,411–8,477 gz, deduped |
| JS — two `IntersectionObserver`s, theme toggle | ~2,000 gz | **inferred** |
| **Total** | **~80,800 (~79KB)** | |

**Paints something real with no JS at all:** yes, and it is proven rather than asserted — T1's field,
T3's cloud and T4's schedule were each screenshotted with JavaScript disabled.

**LCP under 1.5s: NOT MEASURED.** No throttled device was reachable. Stated as an open number, not
claimed as a pass.

**⚠ The budget finding that matters.** Fixing RISK 3 means acquiring Cabinet Grotesk **400** and a
**true italic** — roughly **+40,500 bytes** at the same per-file weight, taking tier 1 to **~118KB
and over the ceiling.** The resolution is **subsetting to Latin**, which the current files have not
had. So: *the fix for the typography risk and the tier-1 budget are coupled, and subsetting is not
optional.* Priced in §26.

### Tier 2 — the heavy layer. **Declared as a number: 0 bytes.**

**This run has no tier-2 layer.** Nothing was assigned from `CRAFT.md`'s Rendering-and-GPU group and
nothing from its heavy post-processing group. The only tier-2 byte in the entire design was S5's
raster at 11,884 bytes, and **T5 was cut**, which takes it to zero.

A drawing sheet is a document, not a scene. A raymarched hero here would have been a failure with an
excellent frame rate. **Declaring zero is the result of the assignment step working**, not of the
budget being dodged.

## 21 · Accessibility

The thirteen `ACCESS.md` §13 both-classes decisions, carried from Loop 1, with one correction made
in Loop 2. Rows 14–19 (tool-shaped) and 20–23 (native) are **out of scope for this run** — recorded
as out of scope with the reason, not as silence.

**1 · Target size.** The **Size** route: **44 × 44 CSS px** for every primary control. The
**Spacing** route at **24px centre-to-centre** is admitted only for inline affordances inside a
dense field — the sheet-index links and the dimension callouts. Because the geometry is
centre-to-centre *in the plane*, the sheet-index grid is checked **on the diagonal as well as the
row**. Prose links take the **Inline** exception and are not padded; applying 24px to a link inside
a sentence is damage to the typography, not conformance.

**2 · Contrast boundary.** **The web boundary: 18px, or 14pt bold.** Apple's 17pt boundary is
explicitly not in use, because there is no native surface. Floors: body **4.5:1**, large **3:1**,
UI components and graphical objects (`1.4.11`) **3:1** — the last binds on every hairline rule,
every input border, every focus ring and every icon glyph, which is where a hairline-heavy
direction is most exposed.

**3 · Can the sampled accent carry body text?** Measured, per mode. **Yes in dark; in light only on
`#fbf8f1`.** The full table is in §5 and it is permanent (RISK 4).

**4 · Focus indicator, drawn — and corrected in Loop 2.** `:focus-visible` only, never `:focus`.
Not `outline: auto`, not a deeper shadow.

- **Standard case:** **2px ring in the accent, 2px offset**, plus a **1px inner separator** in the
  field colour so the ring survives on a mid-tone. `#c63f28` on `#fbf8f1` = 4.78:1; `#f26a52` on
  `#0e2e2c` = 4.81:1.
- **Flip case, on a coral element** — **this is the correction.** Loop 1 specified ink `#0c2422` in
  light and paper `#f2ede3` in dark, and measured four pairs that were *not those two*. Measured in
  Loop 2: light ink-on-coral is **3.21:1** (passes, 0.21 of margin); **dark paper-on-coral is
  2.59:1, which fails `1.4.11`.** Corrected: **on a coral element the ring flips to the sheet field
  colour of the current mode**, and the 1px separator flips to the redline ink.

  | Corrected flip | Ring | Separator |
  |---|---|---|
  | light, on coral | `#fbf8f1` on `#c63f28` — **4.78:1** | `#c63f28` on `#fbf8f1` — **4.78:1** |
  | dark, on coral | `#0e2e2c` on `#f26a52` — **4.81:1** | `#f26a52` on `#0e2e2c` — **4.81:1** |

  Whichever edge the ring straddles, one of the two layers carries the contrast. It also reuses the
  exact pair already measured for the Surface 6 stamp text, so the ring is the same ink as the
  lettering on the block it sits on — which is what a drawing would do anyway.

**5 · Sticky chrome geometry.** The title block is **persistent at 96px** (24 × the 4px base) on
desktop, with `scroll-padding-block-end: 96px`. **Static in flow below 768px.** The height is a
token in the spacing scale (`space.24`), not a number picked in CSS later.

**6 · Author-built drag.** **None exists.** `2.5.7` does not engage. Recorded with its consequence:
if a later loop makes anything drag-operable, it owes adjacent up/down controls per W3C's own
sortable-list example, and those controls occupy real layout space.

**7 · Authentication path.** **None exists.** No login, nothing gated — `3.3.8` does not engage.
**Recorded as N/A with the reason, not as a deferral**, because pricing a deferral here would be a
fabricated cost. The contact form is single-step, so `3.3.7` Redundant Entry has nothing to re-ask,
and on a failed submission the entered values are **preserved, never cleared**.

**8 · Help's fixed slot.** The help mechanism is the contact block. Fixed slot: **last group in the
footer, in the same relative order on every page in the set.** The set is two pages — the sheet and
the 404 — and the 404 carries the same contact block in the same serial order.

**9 · Landmark map and heading outline**, kept separate from the type scale.
- One `banner`, one `main`, one `contentinfo`, one `nav aria-label="Sections"`. If the footer
  repeats the same link set it uses **the same label** — two differently-named navs holding one link
  set tells the user there are two navigations.
- Every invented major section is `<section aria-labelledby="…">` pointing at its own heading, never
  a bare unlabeled `region`.
- **Nesting trap, an explicit build constraint:** do not wrap the page in a `<section>`. `header` and
  `footer` are landmarks only in body context; the wrapper silently deletes `banner` and
  `contentinfo` with no visual change and no error.
- Outline: one `h1` (the sheet title), `h2` per sheet in scroll order, `h3` per item, no skipped
  levels. **Headings are the outline; size is a separate system** — S3's `h2` is 18px and is
  visually among the smallest type on the sheet, and it is still an `h2`.
- **Skip link** — "Skip to content", first in tab order, visible on focus.

**10 · Accessible name for every icon-only control, as the actual string.** Name the action, not the
picture:

| Control | The string |
|---|---|
| Theme toggle | `Switch to dark theme` / `Switch to light theme` (state-dependent) |
| GitHub | `Taha Mahmoodi on GitHub` |
| LinkedIn | `Taha Mahmoodi on LinkedIn` |
| Instagram | `Taha Mahmoodi on Instagram` |
| Back-to-top arrow | `Back to top` |
| Arrow inside a schedule row that already names its project | `aria-hidden="true"` — it duplicates adjacent text, and naming both produces doubled speech |
| Detail zoom, S5 | `Enlarge sheet 04` |

**11 · Reduced-motion still frame, art-directed** (`§10`, **[HARD]**). One composed frame, not
`animation: none`: **both inks at full opacity from first paint, redline stroke-ends squared rather
than tapered**, so the sheet reads as *drawn* rather than as caught mid-draw. See §19.

**12 · Script, direction, expansion budget.** Latin, LTR, English. The subject's name is Persian in
origin and is presented as **Taha Mahmoodi**, the name he goes by — not transliterated, not
shortened to fit (`§13`). Expansion budget on the tightest string in the design: at ≤10 characters
IBM and W3C put average expansion at **200–300%**, so every title-block field name and every
schedule column head is sized to roughly **3× its English label width**, or wraps to two lines with
the value staying on line one. **No text is baked into a graphic anywhere** — every label is live
text over the drawn field, never part of it. RTL deferral and its cost are in §26.

**13 · Focus on route change and on removal.** A single-page scroll surface, so a "route change" is
an in-page jump. The specification is genuinely silent here; this is a decision, not an inheritance,
and the widely reported default — focus falling to `<body>` — resets a keyboard user to zero on
every navigation.
- Sheet-index activation → **focus moves to the target section's `h2`** (`tabindex="-1"`).
- 404 → home → **focus to the `h1`**.
- A disclosure closing → **focus returns to its trigger**.
One rule, applied to every jump, verified by navigating and then tabbing and watching where the ring
appears.

## 22 · Composition log

Carried from Loop 1's set-level check, unchanged. Anchor and background mode per surface:

| | S1 | S2 | S3 | S4 | S5 | S6 |
|---|---|---|---|---|---|---|
| **anchor** | `full-field` | `bottom-anchored` | `offset-editorial` | `dense-grid` | `split-field` | `centered-statement` |
| **background** | `full-bleed-image` | `flat-surface` | `textured-surface` | `flat-surface` | `duotone-treated` | `color-block` |

No anchor repeats consecutively. The longest background run is 1. One full-bleed treatment appears
in the set, at S1, generated in-browser per `§8` — never placed raw, never stock.

**Honesty note carried forward from Loop 1, because it does not expire:** these tokens were assigned
by the agent that wrote the specs, not logged by independent workers who could not see their
neighbours. The check passed, and a self-graded pass is worth less than an independent one. It is
weaker in a specific direction — the tokens could have been chosen *because* the anti-repeat rule
was known.

## 23 · What was invented

`§3` asks every run to state what it did that nobody else did. Two things here, both prototyped,
both surviving.

### The revision cloud as a form-error component

**What was combined:** a drafting convention (the scalloped outline marking a changed region on a
drawing) with a UI state that every site has and nobody designs (the failed form field).

**What it produces:** an error marker that is *native to the document* rather than borrowed from a
framework. The field's entered value is preserved verbatim, the redline note beside it names the
correction in words, and the cloud wraps an arbitrary bounding box at any aspect ratio.

**What it cost:** a path generator, and a second implementation as a CSS `border-image` so it
survives with JavaScript disabled. Roughly 1KB of JS in the shipping form.

**Three-question answers:** *(1)* it makes the viewer understand that on this surface a mistake is
marked and kept rather than cleared — the same claim the whole concept makes, arriving at the exact
moment a visitor has made one; *(2)* it carries the proof for the risk-and-mistakes stance by being
a **working component** rather than an illustration of one — this is what earns its bytes, and
without the error-state job it would be a decorative layer; *(3)* ~1KB of JS, tier 1, and it
degrades to pure CSS.

### The title block as the navigation model

**What was combined:** a drawing sheet's title block — an authorship and revision record — with the
job of primary navigation, replacing the nav bar entirely.

**What it produces:** a surface where "where am I in the set" is answered by the same object that
answers "who drew this and when", which is what a real drawing set does and no portfolio does.

**What it cost:** one `IntersectionObserver` for `aria-current`, and a genuine accessibility burden
that had to be met rather than assumed — `scroll-padding-block-end`, focus-moves-to-`h2`, a
never-colour-alone current state, and a static-footer collapse below 768px. All verified.

**Three-question answers:** *(1)* that the work is a *set* of sheets with an order and a revision
history, not a scroll of sections; *(2)* it answers "can I find the work?" without a nav bar, which
is the concept's structural claim — if it needed a nav bar the collision would be decoration; *(3)*
CSS positioning plus one observer, no scroll listener, tier 1.

## 24 · SAFE / RISK

Carried from Gate A, with each risk's Loop 2 outcome.

**The safe reading.** The concept is derived rather than picked, honors the anti-positioning row
absolutely, reconciles against one sampled accent, and carries measured contrast in both modes. It
is the least density-exposed of the three concepts derived, because a drawing set already contains a
schedule.

| | Status after Loop 2 |
|---|---|
| **RISK 1** — two art directions, two builds | **Moot.** Attached to the `bench` concept, which was not chosen |
| **RISK 2** — hand-annotation near the banned gig-poster register | **Moot.** Attached to `strip-board`, not chosen |
| **RISK 3** — a display face at 17px body, single-family | **OPEN, and worse than Loop 1 assumed.** Accepted by selection at Gate A; Loop 2 measured that body renders from the **500** file because no 400 exists, so it is *heavier* than the spec that was accepted. Ship-with-caveat: acquire 400 + a true italic and subset, or bump to 18px and redraw the grid. **The readability judgment itself is the human's at Gate B** |
| **RISK 4** — the accent cannot carry body text in light mode | **CLOSED as a permanent constraint.** Written into §5 as a measured table. It does not expire and it is not a taste question |
| **RISK 5** *(new, Loop 2)* — the tier-1 budget and the RISK 3 fix are coupled | Acquiring the missing weights takes tier 1 from ~79KB to ~118KB. **Subsetting to Latin is mandatory, not optional** |

## 25 · Broken rules

**The table is not empty. One row.**

| Rule broken | What it buys | What it costs | Why the trade is honest here |
|---|---|---|---|
| `CRAFT.md` — **"Compositor-only motion"** (`transform` and `opacity` only; everything else animates on the main thread) | The redline draws like a **pen laying ink**. The compositor-safe alternative — a `clip-path` or `mask` wipe on `transform` — reads as a *wipe*, which communicates "a shape is being revealed" rather than "a person is drawing a correction". That distinction is the entire argument of the concept | `stroke-dashoffset` animates on the main thread, so the draw competes with everything else on it. Unquantified on a target device, because **no throttling instrument was reachable** — the honest cost is "unmeasured on the hardware that matters", not "negligible" | The load is genuinely small and bounded by design: at most **six short paths**, drawn **once**, gated on `IntersectionObserver`, **below the fold**, with a hard stagger cap of 360ms. It is not a render loop and it never repeats. And the fallback is already built and art-directed — the reduced-motion state is a complete, composed frame, so the people most affected by main-thread contention during animation are the same people who never see the animation |

**No other rule was broken.** The four never-breakable ones — `§10`, `§15` on a tool-shaped surface,
`§16`, and translation-table row 5 — were not touched, and `§15` does not engage because this is not
a tool-shaped surface. `§10` was honored with a real art-directed still rather than `animation: none`.

## 26 · Deferred decisions

Priced, per `§16`. **Silence is not an option; each row states what happens if it is deferred.**

| Decision needed | If deferred, what happens |
|---|---|
| **Persian / RTL version** *(carried from Loop 1)* | No RTL version is in scope for this run. The two places that break when one is added are the **title-block field names** and the **dimension callouts**, because both bake short strings into tight fixed fields. Mitigation already built in: every field is sized to ~3× its English label width, and **no text is baked into a graphic anywhere**, so the strings are all live and translatable. Deferring costs a re-layout of the title block and the callout system, not a re-derivation |
| **Cabinet Grotesk 400 and a true italic** *(new, Loop 2)* | Body copy ships at **weight 500** in a display face at 17px, and the redline ships as a **synthesised oblique**. RISK 3 becomes unmitigated rather than accepted — the run loses the exact thing the brief asks for, an accurate read. **This is the single highest-cost deferral on the list** |
| **Latin subsetting of the font files** *(new, Loop 2)* | Adding the two missing faces takes tier 1 from ~79KB to **~118KB, over the 100KB ceiling**, and `§11` says if tier 1 fails, the run fails |
| **A real, subject-supplied screenshot for Surface 5** | Surface 5 ships in its base state — the written account beside the drawn detail, no raster. The surface still works and tier 2 stays at 0 bytes. The duotone technique is held, not lost, and faces the same test when an asset exists |
| **Throttled measurement on a mid-range Android** | Every performance figure in this run stays **PARTIAL**, permanently. The LCP number is discovered after launch rather than before. Low actual exposure, because the design has no tier-2 layer at all — but the number is genuinely unknown, not small |
| **Icon localisation** (`§13`) | Ships with the RTL deferral. Any glyph suggesting reading direction needs a mirrored variant when RTL arrives |

---

## What faithful means — the handoff clause

**The deliverable is this handoff.** The goal is not a build *inspired by* this direction; it is a
build **faithful to** it.

During the build: do not simplify into default templates. Do not replace a distinctive surface with
a generic row. Do not compress the stated spacing. Do not flatten the type hierarchy. Do not merge
surfaces into a repeating pattern that is not in this document. Do not reintroduce nested boxes this
design removed — and on this direction specifically, **do not add a radius, do not add a shadow, and
do not add a gradient**, because all three are stated as zero here and all three are what a default
template restores.

Where the design is genuinely ambiguous, preserve in this order: **the visible design language,
then the spacing logic, then the component family** — and **ask before filling an ambiguity with a
default.**

Three things in this file are not preferences and are not negotiable at build time: **RISK 4's
accent-placement table** (§5), **the reduced-motion still** (§19, `§10` is [HARD]), and **the
focus-ring flip correction** (§21), which failed measurement once already.

---

## GATE B — SIGNED, 2026-08-06

All four rulings by the subject, recorded verbatim in intent:

1. **Technique set approved as returned:** 6 ship / 1 cut (T5 cut on integrity — the
   fabricated asset ships nowhere). No-technique verdicts on S2/S6 stand.
2. **Weight question, ruling (a):** the 500/700 rendering IS the design. The type scale
   below is respecced to name the weights that actually render: body and micro at **500**
   (was written 400), semibold roles at **700** (was written 600), and the redline slants
   via **synthesized oblique, declared as such** — no italic file exists and none is
   sourced. What the subject approved at both gates is what ships.
3. **T2's caveat accepted:** the draw-on ships with its art-directed reduced-motion still
   and nothing animating above the fold.
4. **Latin subsetting approved** for the build. Mandatory under the budget regardless of
   the weight ruling.

This document is signed. The run's deliverable — DIRECTION.md + tokens.json + 7 prototypes
with measurements — is complete and ready for any build step.
