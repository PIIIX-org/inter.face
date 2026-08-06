# DIRECTION (draft) — taha-portfolio, Loop 1

**Conductor:** direction-conductor, running as a general-purpose subagent (harness has no
registered inter.face agent types; `tools:` fences not enforced — treated as instruction).
**Gate held by:** the main session. This file is the record, not the gate.
**Run redirect, mid-loop:** images replaced by coded comp specs at the subject's request.
No `surface-designer` workers dispatched, no image MCP loaded, 0 images generated.

---

## §1 Surface class

`page-shaped`, per TRANSLATE row 1. Read once, in seconds. Concepts compete on the opening
move. Surface list is a scroll order. Web, greenfield-with-owned-assets.

## §2 Platform mode

**Skipped, and recorded as skipped.** No phone or tablet surface in this run. Web-only.
`SURFACES.md` §1 not read; `TOOLS.md` not read (row 1 is not tool-shaped).

## §0 Branch

**Greenfield with owned assets**, already settled in TRANSLATE §0. No `CURRENT.md`, no
survival list, no redirect map. Row 6's palette and type are inputs, not survivors.

---

## §3 — ACCESS.md §13 Loop 1 decisions (13 both-classes rows)

Run before any comp spec was written. Rows 14–19 (tool-shaped) and 20–23 (native) do not
apply and are recorded as out of scope, not as silence.

**1 — Target size route.** *Size*, not the spacing exception, for every primary control:
**44×44 CSS px**, which clears 2.5.8's 24×24 with room and needs no per-pair geometry proof.
The exception is admitted only for inline affordances inside a dense field (D2's strip
fields, D3's dimension callouts): there the **Spacing** route applies at **24 px
centre-to-centre**, and because the geometry is centre-to-centre *in the plane* rather than
per-axis, D3's sheet-index thumbnail grid is checked on the diagonal as well as the row.
**The spacing unit that enters the scale before the type scale: 8 px base.** 16 px glyph +
8 px gap = exactly 24 px centre-to-centre and passes; 6 px gap fails, and the visual
difference is two pixels. Prose links take the **Inline** exception and are not padded —
applying 24 px to a link inside a sentence is damage to the typography, not conformance.

**2 — Contrast boundary.** **The web boundary: 18 px, or 14 pt bold.** Stated, not assumed.
Apple's 17 pt boundary is explicitly *not* in use because there is no native surface here.
Floors: body 4.5:1, large 3:1, UI components and graphical objects (1.4.11) 3:1 — the last
one binds on every hairline rule, every input border, every focus ring and every icon glyph
in all three concepts, which is where a hairline-heavy direction like D3 is most exposed.

**3 — Can the sampled accent carry body text?** Measured, per mode, not assumed:

| Accent, on its substrate | Ratio | Verdict |
|---|---|---|
| coral `#e9503a` on paper `#f2ede3` | **3.17:1** | graphical/large only |
| coral-ink `#c63f28` on paper `#f2ede3` | **4.34:1** | **large text only** — misses 4.5 |
| coral-ink `#c63f28` on surface `#fbf8f1` | **4.78:1** | body OK, on the lightest substrate only |
| dark coral `#f26a52` on dark paper `#0d201e` | **5.60:1** | body OK |
| dark coral `#f26a52` on petrol-deep `#0e2e2c` | **4.81:1** | body OK |

**Answer: the sampled accent carries body text in dark mode, and in light mode it does not —
except on `#fbf8f1`, where `#c63f28` reaches 4.78:1.** That is a constraint on where the
accent is allowed to appear, decided now rather than repaired later. It is the reason D3 uses
coral as a **pure 3:1 graphical line weight and never as text**, and the reason D2's light-first
palette puts its accent text on `#fbf8f1` rather than on the board's `#eae2d2` (3.94:1, fails).

**4 — Focus indicator, drawn.** `:focus-visible` only, never `:focus`. **2 px ring, 2 px
offset, in the accent**, plus a **1 px inner separator** in the substrate so the ring survives
on a mid-tone. One flip rule for the one case it cannot survive: **on a coral element the ring
is ink (`#0c2422` light) or paper (`#f2ede3` dark)**. Measured against every background it can
land on: coral on petrol-deep 4.81:1, on dark surface 4.56:1, coral-ink on paper 4.34:1, on
surface 4.78:1 — all clear 1.4.11's 3:1. Not `outline: auto`, not a deeper shadow.

**5 — Sticky chrome geometry.** Decided per concept because the answer is a layout number:
- **D1 `bench`: none.** No sticky chrome at all — 2.4.11 cannot be violated by chrome that
  does not exist. Nav is a footer jump-list plus a per-section "back to top".
- **D2 `strip-board`: reserved.** The bay header is sticky at **56 px** (7 × 8), and
  `scroll-padding-block-start: 56px` (technique C43) so a focused strip is never obscured.
- **D3 `as-built`: reserved.** The title block is persistent at **96 px** (12 × 8) on desktop,
  `scroll-padding-block-end: 96px`; static in flow on narrow viewports.
The heights are tokens in the spacing scale, not values picked in CSS later.

**6 — Author-built drag.** **There is none, in any concept.** D2's strips move between bays as
a scroll-driven presentational transition, not a user-operable drag. Recorded with its
consequence: if Loop 2 makes that movement user-operable, the comp owes adjacent up/down
controls per W3C's own sortable-list example, and those controls occupy layout space in the
strip's right field — 2.5.7 is not satisfied by the keyboard path.

**7 — Authentication path.** **No authentication exists on this surface.** No login, nothing
gated. 3.3.8 does not engage. Recorded as N/A with the reason rather than as silence. The
contact form is single-step, so 3.3.7 Redundant Entry has nothing to re-ask — and on a failed
submission the entered values are **preserved, never cleared**, in all three concepts.

**8 — Help's fixed slot.** Help mechanism = the contact block (email + form). Fixed slot:
**last group in the footer, same relative order on every page in the set.** The set is two
pages — the page and the 404 — and the 404 carries the same contact block in the same serial
order. A narrow viewport may move it visually as long as the serial order holds (the
responsive exception is explicit and narrow; navigating between pages does not qualify).

**9 — Landmark map and heading outline**, separate from the type scale.
- Landmarks: one `banner`, one `main`, one `contentinfo`, one `nav aria-label="Sections"`. If
  the footer repeats the same link set, it uses **the same label** — APG's inverse rule; two
  differently-named navs holding one link set tells the user there are two navigations.
  Every invented major section is `<section aria-labelledby="…">` pointing at its own heading,
  never a bare unlabeled `region`.
- **Nesting trap, explicit build constraint:** do not wrap the page in a `<section>`. `header`
  and `footer` are landmarks only in body context; the wrapper silently deletes `banner` and
  `contentinfo` with no visual change and no error.
- Outline: one `h1` (the subject's name / the sheet title), `h2` per section in scroll order,
  `h3` per item. No skipped levels. D1's "Three brackets" heading is visually the smallest
  thing in its section and is still an `h2` — headings are the outline, `STYLES.md` owns size.
- **Skip link** — "Skip to content", first in tab order, visible on focus, all three concepts.

**10 — Accessible name for every icon-only control, as the actual string.** Name the action,
not the picture:

| Control | The string |
|---|---|
| Theme toggle | `Switch to dark theme` / `Switch to light theme` (state-dependent) |
| GitHub | `Taha Mahmoodi on GitHub` |
| LinkedIn | `Taha Mahmoodi on LinkedIn` |
| Instagram | `Taha Mahmoodi on Instagram` |
| Back-to-top arrow | `Back to top` |
| Arrow inside a project row that already names the project | `alt=""` / `aria-hidden` — it duplicates adjacent text, and naming both produces doubled speech |
| D3 detail zoom | `Enlarge sheet 04` |

And Material's design-time rule: **below 20 dp a key-action icon owes a *visible* text label**,
so the footer social row ships visible labels rather than bare glyphs at small sizes.

**11 — Reduced-motion still frame, art-directed** (`§10` **[HARD]**), one composed frame each,
not `animation: none`:
- **D1** — the lamp's drift and the motes are the motion. Still: **lamp at full key, no drift,
  no motes**; the composed 3 a.m. frame at its brightest, which is a different and deliberate
  image, not a paused one.
- **D2** — strips travel between bays on scroll. Still: **the board in its end state, every
  strip already in its final bay, with each bay's count printed in the header.** The arc
  becomes a caption instead of a movement.
- **D3** — the redline draws itself over the black drawing. Still: **both layers at full
  opacity from first paint, redline stroke-ends squared rather than tapered**, so it reads as
  drawn rather than caught mid-draw.

**12 — Script, direction, expansion budget.** **Latin, LTR, English.** The subject's name is
Persian in origin and is presented as *Taha Mahmoodi*, the name he goes by — not transliterated,
not shortened to fit (`§13`). **Deferred with its cost: no Persian/RTL version is in scope for
this run.** If one is added later, the two places that break are D2's fixed-width strip fields
and D3's dimension callouts, because both bake short strings into tight fixed fields.
Expansion budget on the **tightest string in the design — D2's bay label `WORKING`, 7
characters**: at ≤10 characters IBM/W3C put average expansion at **200–300%**, so the bay column
header is sized to roughly **3× its English label width**, or the label wraps to two lines with
the count staying on line one. Same rule on D1's eyebrow `OFF THE BENCH` and D3's title-block
field names. **And no text is baked into a graphic anywhere** — the bay labels are live text over
the generated field, never part of it.

**13 — Focus on route change and on removal.** Single-page scroll surface, so "route change" is
an in-page jump. The specification is genuinely silent here; this is a decision, not an
inheritance, and the widely reported default (focus falls to `<body>`) resets a keyboard user
to zero on every navigation.
- Jump-list activation → **focus moves to the target section's `h2`** (`tabindex="-1"`), never
  to `body`. Verified by navigating, then tabbing, and watching where the ring appears.
- 404 → home → **focus to the `h1`**.
- A disclosure closing → **focus returns to its trigger**.
- D2's bay filter emptying the list → **focus to the filter control, not the empty list**.
One rule, applied to every jump.

**Deferred rows and their cost:** row 12's RTL/Persian version only (cost stated above). Row 7
is N/A by architecture. Nothing else is open.

---

## §4 Derivation — physical experience first, families second

**Archetype words (row 4):** builds for the thrill of the problem; indifferent to applause;
unafraid of risk and mistakes. Row 4's own physical check: *a workbench mid-project, not a
gallery.*
**Shadow (row 4):** the identity-maker's own craft of self-presentation — he designs identities
and refuses to perform his own.
**Three-second feel (row 3):** finds a problem worth solving, plans the solve, builds it,
delivers it, fixes its flaws on the way. He ships the whole arc; mistakes are part of the method.

**Physical experiences derived before any style was named:** a machinist's routing traveler that
rides with a part and carries its rework column; a bound lab notebook where a wrong entry is
struck through and left readable; a dye-penetrant crack test where the flaw is what you
photograph; a control tower's flight-progress strip board where state is a physical position; an
as-built drawing redlined on site; a proof-load test taken past yield; a workbench at 2 a.m.

**Reflex check.** No Swiss grid. No terminal. The dense-technical-console probe was left
*un-banned* by row 5, not *pulled toward* — none of the three survivors is phosphor-on-black
monospace, and the closest (D2) is paper in metal, machine-printed, on a light substrate.

**The shadow governs all three.** Each survivor answers "what happens if the archetype is played
at full volume" — because anti-performance played loud becomes its own performance, which is the
single most performative posture available to a designer's portfolio.

### The three surviving directions, each in one concrete sentence

**D1 — THE BENCH.** *A workbench at the hour before it works: the jig still clamped, three
versions of the same bracket lined up because the first two were wrong, nothing put away, one
lamp on.*
Shadow answer: the room is entered mid-work, so there is nothing arranged to admire. Full-volume
failure it must avoid: a beautifully lit still life, which is a gallery photograph wearing
overalls.

**D2 — THE STRIP BOARD.** *A control tower's flight-progress strip board: every job is a paper
strip, hand-annotated, that physically moves through bays from pending to working to handed off —
and nobody applauds a strip.*
Shadow answer: an operational object has no author; the subject appears as one strip in the same
format as the rest. Full-volume failure it must avoid: a portfolio that never says who, because
it has hidden the person inside the system.

**D3 — THE AS-BUILT.** *An as-built drawing: the issued blueprint in black, with the site
engineer's red-pen corrections drawn straight over it showing what actually got built and where
the plan was wrong.*
Shadow answer: the least glamorous document a project produces, and the only one that admits the
plan was wrong in writing. Full-volume failure it must avoid: the corrections becoming decorative
— redline as a graphic device rather than a correction.

### The cut (STYLES "Picking one", five inputs)

1. **Category cluster.** Designer/creative portfolios: full-bleed dark video, oversized rotating
   type, a horizontal case-study rail, a cursor dot, a card grid of projects. All five are the
   fence.
2. **The empty position.** Nobody's portfolio is an **operational document**. Every one is an
   exhibition. An operational document is credibly this subject and is unoccupied.
3. **Anti-positioning (row 5), honored absolutely.** Gig-poster textural and broadsheet
   editorial-review are both *framings of the work as performed or celebrated*. This is the input
   that did the cutting — see the rejected concept below.
4. **Viewer's risk appetite.** Row 2's viewer is *anyone*, and the decision is *forming an
   accurate read*. No procurement committee, no conversion. Tolerance for strangeness is high;
   tolerance for illegibility is zero, because an inaccurate read is the only real failure.
5. **What is already owned (row 6).** Cabinet Grotesk + General Sans, the petrol/paper system,
   and — **found by sampling, absent from the filled table** — the coral accent. Constraints,
   not suggestions.

---

## §5 Palette — sampled once, built out per direction

### The sample

`§6` says sample the pixels. **Sampled source:
`~/Documents/madeintaha-portfolio/css/style.css`, the subject's own shipped-but-unlaunched
portfolio, custom-property block lines 14–54.** Not remembered, not recalled from the TRANSLATE
row — re-read at run time.

**The sample corrected TRANSLATE row 6.** The filled table lists petrol, deep, paper, surface and
ink and **stops before the accent**. The source declares it explicitly, with the subject's own
comments attached:

```
--coral:     #e9503a;   /* accent surfaces */
--coral-ink: #c63f28;   /* accent text, large only (>=3:1 on paper) */
```

**`#e9503a` is the run's one sampled accent.** Petrol is the substrate family; coral is the
accent, and the subject had already reasoned about its contrast ceiling in a code comment. Every
direction below reconciles against that single hex. Row 3 reconciliation: coral is the colour of
a mark someone made deliberately on something they built — a redline, a dye, a hot strip — which
is precisely "mistakes are part of the method" rendered as a colour rather than a claim.

All hexes below carry their OKLCH; gradient endpoints are written in `oklch()` so interpolation
does not silently drop to sRGB. Every ratio is measured, at the size it is used, per mode.

### D1 `bench` — dark-first, **two art directions**

The direction is atmospheric and single-key lit. `STYLES.md`: *there is no light version of a
lit set.* Light mode is a second art direction — a printed still with the grade baked in as a
petrol duotone, no vignette, no bloom.

**Dark (primary art direction) — the room**

| Token | Swatch | OKLCH | Foreground | Ratio | Used at |
|---|---|---|---|---|---|
| substrate | `#0e2e2c` | `oklch(27.7% 0.037 189.6)` | `#f2ede3` | **12.45:1** | body 17px |
| substrate-2 (shelf) | `#0d201e` | `oklch(22.7% 0.025 186.8)` | `#efe7d6` | **13.74:1** | body 17px |
| lit surface | `#123230` | `oklch(29.3% 0.038 189.8)` | `#efe7d6` | **11.20:1** | body 17px |
| accent (the lamp) | `#f26a52` | `oklch(68.7% 0.173 31.9)` | `#0c2422` | **5.39:1** | 13px label on accent |
| accent as text | `#f26a52` on `#0e2e2c` | — | — | **4.81:1** | body 17px, permitted |
| accent hover | `#f4795f` | `oklch(71.3% 0.157 33.3)` | `#0c2422` | 6.24:1 on `#0d201e` | — |
| cool neutral | `#7fb5ad` | `oklch(73.3% 0.058 184.6)` | on `#0e2e2c` | **6.30:1** | 13px meta |
| ramp-60 (dimmed) | `#97a19a` | `oklch(69.9% 0.015 155.4)` | on `#0e2e2c` | **5.45:1** | 13px meta |
| ramp-42 (disabled) | `#6c746b` | `oklch(54.9% 0.017 142.2)` | on `#0d201e` | **3.50:1** | disabled, never colour-alone |
| hairline | `#31403b` | `oklch(35.7% 0.021 172.7)` | on `#0d201e` | 1.55:1 | decorative rule only, carries no meaning |
| focus ring | `#f26a52` | — | vs `#0e2e2c` **4.81:1**, vs `#123230` **4.56:1** | ≥3:1 both | 2px + 2px offset |

Gradient (the lamp falloff): `linear-gradient(oklch(29.3% 0.038 189.8), oklch(22.7% 0.025 186.8))`.

**Light (second art direction) — the printed still**

| Token | Swatch | Foreground | Ratio |
|---|---|---|---|
| substrate | `#f2ede3` | `#0e2e2c` | **12.45:1** body |
| plate | `#eae2d2` | `#0c2422` | **12.63:1** body |
| accent | `#c63f28` `oklch(56.0% 0.175 32.2)` | on `#f2ede3` | **4.34:1 — large text only (≥18px)** |
| accent surface | `#e9503a` | `#0c2422` on it | **4.39:1** at 18px+ |
| ramp-64 | `#5f6c67` | on `#f2ede3` | **4.70:1** body |
| ramp-44 (disabled) | `#8d958e` | on `#f2ede3` | 2.64:1 — **disabled only**, exempt, and never the sole signal |
| hairline | `#d2d1c8` | on `#f2ede3` | 1.31:1 decorative |
| focus ring | `#c63f28` | vs `#f2ede3` **4.34:1** | ≥3:1 |

Named divergence: the accent sits at its **most emissive** here — highest lightness, on
near-black — because a single lamp is the direction's whole surface argument.

### D2 `strip-board` — light-first, **one design in two palettes**

A strip board is paper in a metal frame. Dark mode is the night shift: the same object, lower
ambient, same design. Declared, not defaulted.

**Light (primary)**

| Token | Swatch | OKLCH | Foreground | Ratio | Used at |
|---|---|---|---|---|---|
| board enamel | `#eae2d2` | `oklch(91.5% 0.023 84.6)` | `#0c2422` | **12.63:1** | body 16px |
| strip stock | `#fbf8f1` | `oklch(98.0% 0.010 87.5)` | `#0c2422` | **15.34:1** | body 16px |
| bay frame (metal) | `#14403d` | `oklch(34.0% 0.048 188.9)` | `#fbf8f1` | **10.82:1** | 24px bay label |
| accent — active strip | `#c63f28` | `oklch(56.0% 0.175 32.2)` | on `#fbf8f1` | **4.78:1** | body 16px, **on strip stock only** |
| accent on board | `#c63f28` on `#eae2d2` | — | — | 3.94:1 | **large/graphic only — fails body** |
| accent fill | `#e9503a` | `oklch(63.8% 0.193 31.0)` | `#0c2422` | **4.39:1** | 18px+ label on fill |
| accent active (pressed) | `#a83320` | `oklch(49.4% 0.156 31.9)` | `#f2ede3` | **5.70:1** | — |
| ramp-64 | `#5f6c67` | on `#fbf8f1` | **5.17:1** | 13px meta |
| ramp-44 (disabled/parked) | `#8d958e` | on `#eae2d2` | 2.39:1 — disabled only, paired with a struck rule so colour is never alone |
| hairline (bay divider) | `#14403d` at 30% | — | — | decorative |
| focus ring | `#c63f28` | vs `#fbf8f1` **4.78:1**, vs `#eae2d2` 3.94:1 | ≥3:1 both | 2px + 2px offset |

**Dark (same design, second palette)**

| Token | Swatch | Foreground | Ratio |
|---|---|---|---|
| board enamel | `#0a1a18` | `#efe7d6` | **14.54:1** |
| strip stock | `#123230` | `#efe7d6` | **11.20:1** |
| bay frame | `#7fb5ad` | on `#0a1a18` | **7.77:1** |
| accent — active strip | `#f26a52` | on `#123230` | **4.56:1** body |
| focus ring | `#f26a52` | vs `#123230` **4.56:1** | ≥3:1 |

Named divergence: the accent sits at its **densest** here — used as ink, not as light, and
restricted by measurement to the strip stock, because the board itself cannot carry it at body
size.

### D3 `as-built` — **two art directions**, by print convention

`STYLES.md`: *white-on-blue and blue-on-white are both real print conventions; switch between them
on purpose, with line weights retuned, since hairlines that read on dark disappear on white.*
Both modes are built, and the **line weights change with the mode** — that is the whole of the
mode work here.

**Dark = cyanotype**

| Token | Swatch | OKLCH | Foreground | Ratio | Used at |
|---|---|---|---|---|---|
| sheet field | `#0e2e2c` | `oklch(27.7% 0.037 189.6)` | `#efe7d6` | **11.81:1** | body 17px |
| drawing line (primary) | `#efe7d6` | `oklch(93.0% 0.024 85.8)` | on field | **11.81:1** | **1.5 px** stroke |
| drawing line (secondary) | `#7fb5ad` | `oklch(73.3% 0.058 184.6)` | on field | **6.30:1** | **1 px** stroke |
| dimension micro | `#7fb5ad` | — | on field | **6.30:1** | 12px, tabular |
| **redline** | `#f26a52` | `oklch(68.7% 0.173 31.9)` | on field | **4.81:1** | **2 px** stroke — graphical, and 16px italic where it speaks |
| focus ring | `#f26a52` | vs `#0e2e2c` | **4.81:1** | 2px + 2px offset |

**Light = diazo / whiteprint**

| Token | Swatch | Foreground | Ratio | Used at |
|---|---|---|---|---|
| sheet field | `#fbf8f1` | `#0e2e2c` | **13.69:1** | body 17px |
| drawing line (primary) | `#0e2e2c` | on field | **13.69:1** | **1 px** stroke — retuned down from 1.5 |
| drawing line (secondary) | `#14403d` | on field | **10.82:1** | **0.75 px** stroke |
| dimension micro | `#14403d` | on field | **10.82:1** | 12px, tabular |
| **redline** | `#c63f28` | on field | **4.78:1** | **1.5 px** stroke; 16px italic where it speaks |
| redline graphic-only tint | `#e9503a` | on field | 3.49:1 | cloud outlines, never text |
| focus ring | `#c63f28` | vs `#fbf8f1` **4.78:1** | — | 2px + 2px offset |

Named divergence: the accent is a **pure 3:1 graphical line weight** here and, per decision 3,
is permitted as text only at `#c63f28`/`#f26a52` on the two field colours where it measures
above 4.5:1. The stroke weights, not the hues, are what change between modes.

---

## §6 Type — per direction, each face carrying its reason on the same line

Row 6 owns **Cabinet Grotesk** (display) and **General Sans** (text), both already vendored and
self-hosted in the subject's source. Load-bearing per STYLES input 5, so they are the default —
and a direction that replaces one says why.

### D1 `bench` — two families

- **Cabinet Grotesk** — *display only.* Reason: its high-waisted, drawn-not-generated caps hold
  their shape at 100 px under a single hard key light, where a neutral grotesque's even stroke
  goes flat and reads as a rendered overlay instead of an object in the room.
- **General Sans** — *text.* Reason: it is the one face in the pair with a genuine text optical
  size; the direction spends its distinctiveness on light and structure, so the body voice is
  asked to be quiet and legible at 17 px on a dark substrate, not characterful.

| Level | Face | Size | Weight | Line-height | Tracking |
|---|---|---|---|---|---|
| h1 hero | Cabinet Grotesk | `clamp(3.25rem, 7vw, 6.5rem)` (52–104px) | 700 | 0.94 | −0.02em |
| h2 section | Cabinet Grotesk | `clamp(2rem, 3.4vw, 3rem)` (32–48px) | 500 | 1.02 | −0.015em |
| h3 item | General Sans | 1.25rem (20px) | 600 | 1.25 | 0 |
| body | General Sans | 1.0625rem (17px) | 400 | 1.6 | 0, measure 62ch |
| eyebrow | General Sans | 0.75rem (12px) | 500 | 1.2 | 0.14em, caps |
| meta / dates | General Sans | 0.8125rem (13px) | 400 | 1.45 | 0, **tabular figures** |

### D2 `strip-board` — two families, and Cabinet Grotesk is dropped

- **General Sans** — *everything typeset.* Reason: a strip board has no display typography at
  all; the largest type on it is a 24 px bay label, so a display face would be carried for one
  size and earn nothing. Dropping it is the direction's type decision, not an omission.
- **Martian Mono** (SIL OFL, Evil Martians) — *strip field data only, never prose.* Reason: it
  is drawn wide and unambiguous for code tokens, so a six-character job code occupies a fixed
  field width and scans as a **column position** rather than as a word — which is exactly what a
  strip is. Constraint attached: **never below 12 px, never for running text.**

| Level | Face | Size | Weight | Line-height | Tracking |
|---|---|---|---|---|---|
| h1 page | General Sans | `clamp(2.25rem, 4vw, 3.25rem)` (36–52px) | 700 | 1.05 | −0.01em |
| h2 bay label | General Sans | 1.5rem (24px) | 600 | 1.1 | 0.08em, caps |
| h3 strip title | General Sans | 1.0625rem (17px) | 600 | 1.3 | 0 |
| strip field | Martian Mono | 0.8125rem (13px) | 400 | 1.4 | 0, tabular by construction |
| strip serial | Martian Mono | 0.75rem (12px) | 400 | 1.2 | 0.02em — the stated floor |
| body / note | General Sans | 1rem (16px) | 400 | 1.6 | 0, measure 58ch |

### D3 `as-built` — **one family**, and the direction earns it

- **Cabinet Grotesk**, alone, across four optical roles. Reason: a drawing sheet is lettered in
  one lettering set — a second family on a sheet reads as a second draftsman, which is the one
  thing an as-built must never suggest, because the whole document's authority rests on one hand
  having made both the drawing and the correction. The roles are separated by **case, tracking
  and weight**, never by a second face.

| Role | Size | Weight | Line-height | Tracking | Case |
|---|---|---|---|---|---|
| sheet title (h1) | `clamp(2.5rem, 5vw, 4.5rem)` (40–72px) | 700 | 1.0 | 0.02em | caps |
| drawing lettering (h2) | 1.125rem (18px) | 500 | 1.2 | 0.16em | caps |
| title-block field | 0.8125rem (13px) | 600 | 1.3 | 0.08em | caps |
| dimension micro | 0.75rem (12px) | 400 | 1.1 | 0.1em | caps, **tabular figures** |
| note / body | 1.0625rem (17px) | 400 | 1.65 | 0 | sentence, measure 60ch |
| **redline** | 1rem (16px) | 500 *italic* | 1.4 | 0.01em | sentence |

Stated cost: Cabinet Grotesk is a display face carrying 17 px body. See RISK 3.

---

## §7 Concepts

### Grid and rhythm, per concept

| | D1 `bench` | D2 `strip-board` | D3 `as-built` |
|---|---|---|---|
| container | 1320px (the owned `--mw`) | 1440px — the board is wider than a page | 1512px sheet, 32px drawn border |
| columns | 12 × 24px gutter | 4 bays × 16px gutter | 16 × 24px gutter (a drawing grid) |
| vertical rhythm | 8px | 8px | 4px (finer drafting grid; adjacent targets still hold 24px c-to-c) |
| section padding | `clamp(5rem, 11vw, 10.5rem)` (the owned `--pad-y`) | 72px fixed strip height, 24px bay padding | 48px sheet margin, 96px title-block band |
| radius | 4px / 10px (the owned `--r`) | 2px — strips are cut, not rounded | 0 — a drawing has no radii |

---

## Concept 1 — `bench`

**Collision (structural parent named first).** *Reductive hairline structure carries the bones;
a single-key cinematic grade carries the surface* — a workbench at 2 a.m., where the layout is
almost empty and hairline-ruled and the light is doing all the atmospheric work, so the page
reads as a room someone is still working in rather than a page someone finished.
Modification against the named `STYLES.md` collision "brutalist structure with a cinematic
grade": the structural parent here is **reductive, not brutalist** — nothing raw, nothing
default, a hairline system with real optical spacing — because raw-and-unstyled would read as
a pose, and a pose is the shadow.

**Opening move (first three seconds).** No name, no title, no headline in the usual place. The
viewer arrives in a dark room lit by one lamp, and the only thing lit is a thing **still
clamped in a vise**, mid-cut. The name is set small at the lower left, at meta size, next to a
timestamp. What is understood in three seconds without reading a word: *someone works here, and
they are not finished.*

**How the primary content is presented — invented, not a card grid.** The **bench run**: one
continuous horizontal shelf across the full container, on which every shipped thing sits at the
same three fixed positions — name at the left baseline, *what broke* at the centre baseline,
*what shipped* at the right baseline. Positions hold from item to item, so a reader comparing
two projects scans one axis. A flexible card layout would move the "what broke" field around and
force a hunt; the shelf refuses to.

**Navigation.** No persistent chrome. A skip link, then a jump list in the footer band, with a
"back to top" closing every section. Activating a jump moves focus to the target `h2`.

**Missing or wrong.** *404:* "Not on the bench." — the dark plate, one empty vise, the jump list
below it. *Failed contact submission:* the note falls off the bench — entered values stay in the
fields, an inline coral note under the offending field says what failed and what to do, the
button becomes "Try again". Never a toast that disappears.

**Style under density.** *At forty rows the grade stops at the shell.* The lamp falloff lights
the header, the margins and the empty state only; the forty-row run sits on a flat, evenly-lit
`#123230` plate inside the room. Atmospheric families put the bottom eight rows in the dark
otherwise — this is the fork, named now.

**Sections — 6.**

---

#### `bench` · Surface 1 of 6 — **The bench, mid-project** (hero, 21:9)

- **Job:** the viewer understands, before reading, that they have walked in on work in progress.
- **Layout:** a single full-bleed dark field with one lit zone at 38% from the left; container
  1320px is *ignored* here — the field is edge to edge and only the type respects the container.
  12-col, content occupies cols 2–6, vertical rhythm 8px, hero height `min(88vh, 900px)`.
- **Type:** h1 Cabinet Grotesk 700 / `clamp(3.25rem,7vw,6.5rem)` / lh 0.94 / −0.02em, set in
  **two lines, lower-left**, not centred. Meta line General Sans 400 / 13px / lh 1.45 / tabular.
  Eyebrow General Sans 500 / 12px / 0.14em caps.
- **Color:** bg `#0e2e2c` → `#0d201e` `linear-gradient(oklch(27.7% 0.037 189.6), oklch(22.7% 0.025 186.8))`;
  fg `#f2ede3` (12.45:1); the lit zone is `#123230` with `#f26a52` as the single accent (4.81:1).
- **Anchor / background mode:** `full-field` / `full-bleed-image` — the field is generated
  in-browser (canvas radial key + grain), per `§8`; nothing is placed raw and no stock is used.
- **Content direction:** the eyebrow reads `MADEINTAHA.ME`; the h1 is two short lines in the
  subject's own register — *"Still clamped. / Come back in an hour."* — with the meta line
  carrying `Taha Mahmoodi · builds systems around AI, and the design that has to survive them`.
  No superlative, no tagline grammar.

#### `bench` · Surface 2 of 6 — **What's clamped** (the current problem)

- **Job:** the viewer learns what he is *currently* solving, before learning anything he has done.
- **Layout:** narrow left rail (cols 1–3) holding the label and the one-paragraph statement; wide
  right field (cols 4–12) holding the in-progress object at working scale, cropped by the section
  edge so it reads as continuing past the frame. Section padding `clamp(5rem,11vw,10.5rem)`.
- **Type:** h2 Cabinet Grotesk 500 / `clamp(2rem,3.4vw,3rem)` / lh 1.02. Body General Sans 400 /
  17px / lh 1.6 / 62ch. Eyebrow 12px caps 0.14em.
- **Color:** bg `#0e2e2c`, fg `#f2ede3` (12.45:1); the crop's soft edge falls to `#0d201e`;
  one `#f26a52` hairline marks the cut line (graphical, 4.81:1).
- **Anchor / background mode:** `left-rail-caption` / `vignette-crop`.
- **Content direction:** the current problem stated in two plain sentences drawn from the real
  position — building systems *around* AI and *for* AI, and integrating AI into systems that
  already have users. Named, unfinished, no claim of a result.

#### `bench` · Surface 3 of 6 — **Three brackets** (the first two were wrong)

- **Job:** the method is shown, not asserted — mistakes are part of it.
- **Layout:** three equal fields meeting on two hard vertical rules, 60/40 weighting *inside*
  each field so the third reads heavier; cols 1–4 / 5–8 / 9–12, 24px gutter, all three at the
  same baseline so the differences between them are the only thing that moves.
- **Type:** h2 Cabinet Grotesk 500 / 32–48px. Each field's h3 General Sans 600 / 20px / lh 1.25.
  Annotation General Sans 400 / 13px / lh 1.45, tabular for the version numbers.
- **Color:** bg `#0d201e`, fg `#efe7d6` (13.74:1); fields 1 and 2 dimmed to ramp-60 `#97a19a`
  (5.45:1) and field 3 at full `#efe7d6`; `#f26a52` marks the point of failure on 1 and 2 only.
- **Anchor / background mode:** `split-field` / `flat-surface`.
- **Content direction:** one real thing built three times — the honest candidate is
  `atlas-erp`'s manufacturing slice, with v1 and v2 annotated by what specifically failed and
  v3 by what shipped. Annotations are diagnostic, not confessional.

#### `bench` · Surface 4 of 6 — **Off the bench** (what shipped)

- **Job:** the range of built work, at a glance, without any of it being celebrated.
- **Layout:** the **bench run** — a full-width shelf, one row per shipped thing, 56px row height,
  three fixed baselines: name (cols 1–4), what broke (cols 5–8), what shipped (cols 9–12).
  Hairline rule between rows. Rows never reflow their fields; on narrow viewports each row
  becomes three stacked lines in the same order.
- **Type:** h2 Cabinet Grotesk 500 / 32–48px. Row name General Sans 600 / 17px. Row fields
  General Sans 400 / 15px / lh 1.45. Dates General Sans 400 / 13px **tabular**.
- **Color:** bg `#0e2e2c`, fg `#f2ede3` (12.45:1); hairline `#31403b`; the "what broke" field in
  ramp-60 `#97a19a` (5.45:1); `#f26a52` only on the row currently hovered/focused, paired with a
  1px left rule so the state is never colour alone.
- **Anchor / background mode:** `dense-grid` / `flat-surface`.
- **Content direction:** the real list — `atlas-erp`, `chapters`, `vectory`, Metal ERP, Vivid
  Tents, Safa Tyour, Squad Mojo, Canin DCMP, Maher, TrueTale, Avaye Zaryab, Herat Dental Union.
  No metrics unless a real one exists; a count in the comp is structure, not a claim.

#### `bench` · Surface 5 of 6 — **The tool wall** (what he reaches for)

- **Job:** who this person is, stated as capability rather than as adjectives.
- **Layout:** entry at top-left with the statement in cols 1–5; the capability set falls to the
  bottom-right as an unaligned run of short items on a 4px sub-grid — deliberately hung on the
  wall rather than gridded, but every item on the same baseline family.
- **Type:** h2 Cabinet Grotesk 500 / 32–48px. Statement General Sans 400 / 17px / lh 1.6 / 62ch.
  Items General Sans 500 / 15px / lh 1.4. Org labels 13px tabular.
- **Color:** bg `#0e2e2c` with `noise-over-solid` micro-grain at ≤3% opacity, dropped to 0 on
  text layers; fg `#f2ede3` (12.45:1); `#7fb5ad` (6.30:1) for org labels.
- **Anchor / background mode:** `top-left-lead` / `noise-over-solid`.
- **Content direction:** the real roles and orgs — PIIIX (founder), Alkharazmy (CTO),
  CyborgTech (co-founder, **paused**, said plainly), plus the real prior titles including
  *Conversational UX QA & Model Tester*, which is the honest bridge from design craft to AI work.

#### `bench` · Surface 6 of 6 — **Leave a note** (contact)

- **Job:** one way to reach him, with no persuasion attached.
- **Layout:** content held in the lower band, 40% of section height, over the empty lit field
  above it; cols 4–9, centred within the container but anchored to the bottom edge with 96px of
  clearance. Section height `min(70vh, 720px)`.
- **Type:** h2 Cabinet Grotesk 500 / 32–48px. Field labels General Sans 500 / 13px / 0.08em caps.
  Inputs General Sans 400 / 17px. Button label General Sans 600 / 16px.
- **Color:** bg `linear-gradient(oklch(22.7% 0.025 186.8), oklch(27.7% 0.037 189.6))`;
  fg `#f2ede3`; input border `#7fb5ad` (6.30:1 — clears 1.4.11's 3:1, which is where most
  systems fail); button fill `#f26a52` with `#0c2422` label (5.39:1); focus ring `#f26a52`,
  flipping to `#f2ede3` on the button itself.
- **Anchor / background mode:** `bottom-anchored` / `tonal-gradient`.
- **Content direction:** an email address, the GitHub handle `Taha-Mahmoodi`, and a two-line
  note in his register about what he is interested in being sent. Help block sits last, in the
  fixed footer slot (ACCESS decision 8).

---

## Concept 2 — `strip-board`

**Collision (structural parent named first).** *The bay grid of a control tower's strip board
carries the structure; the machine-printed, hand-annotated strip carries the surface* — a career
presented as things currently in motion between bays rather than things on display, where the
annotation in the margin of each strip is the only voice on the page.
Modification: this is `STYLES.md`'s "data-brutalist rows inside an editorial shell" inverted —
the shell is **operational**, not editorial, and the annotation is a working mark rather than
marginalia written for a reader. It is emphatically not risograph, not letterpress, not textural
(row 5), because a controller's ballpoint is functional and ugly and is never printed twice.

**Opening move.** The whole board at once: four bays, every strip in its bay, counts printed in
each bay header. In three seconds the viewer sees the *shape of a working life* — how much is
pending, how much is active, how much has been handed off, how much is parked — before reading a
single project name.

**How the primary content is presented.** The **strip stack**: fixed 72px rows in fixed columns —
`SERIAL / TITLE / ROLE / STATE / HANDED-OFF`. Every field in the same column on every strip. It
is a table with the chrome removed and the discipline kept, and it is the honest default here
because the things genuinely are comparable.

**Navigation.** The bay row *is* the nav: a sticky 56px header of four bay labels, each an
in-page link. Current bay carries `aria-current="true"`, a coral underline **and** a filled
square, so state is never colour alone. Activating one moves focus to that bay's `h2`.

**Missing or wrong.** *404:* a single strip in a fifth bay headed `NO SUCH STRIP`, with the
requested path printed on it in the serial field, and the real board visible behind. *Failed
submission:* the strip moves to `HOLDING` with a reason printed in its note field; nothing is
cleared, and the reason names the fix.

**Style under density.** *At forty rows this is the style at its designed load.* Forty strips is
a normal shift. The bay column scrolls, the fixed field widths keep every code in the same
column, and Martian Mono's fixed advance means the fortieth strip aligns with the first. This is
the direction that gets *better* with more data.

**Sections — 6.**

---

#### `strip-board` · Surface 1 of 6 — **The board** (hero, 21:9)

- **Job:** the shape of the working life, understood before any name is read.
- **Layout:** four bays across the full 1440px container, 16px gutter, each bay a column of 72px
  strips; sticky bay header 56px with `scroll-padding-block-start: 56px` reserved. Board edge
  drawn as a 6px metal frame in `#14403d`.
- **Type:** h1 General Sans 700 / `clamp(2.25rem,4vw,3.25rem)` / lh 1.05, set **inside the frame's
  top-left corner plate**, not over the bays. Bay labels General Sans 600 / 24px / 0.08em caps.
  Strip fields Martian Mono 400 / 13px.
- **Color:** board `#eae2d2` (12.63:1 with `#0c2422`); strips `#fbf8f1` (15.34:1); frame `#14403d`
  with `#fbf8f1` labels (10.82:1); active-bay strips carry `#c63f28` text on `#fbf8f1` (4.78:1).
- **Anchor / background mode:** `dense-grid` / `image-as-canvas` — the enamel board surface is the
  canvas, generated in-browser (CSS/canvas enamel + hairline mesh), interface sitting on it.
- **Content direction:** bay headers `PENDING · WORKING · HANDED OFF · HOLDING`; the corner plate
  carries `TAHA MAHMOODI` and one line of position. Strip counts are structure, verified at build,
  never presented as an achievement.

#### `strip-board` · Surface 2 of 6 — **How to read a strip** (the legend)

- **Job:** the "about" section, disguised as a legend — teaching the format teaches the person.
- **Layout:** one strip, blown up to 3× scale, centred on the axis, with five leader lines out to
  five field explanations. Everything else on the section is subordinate. Container narrows to
  1080px here.
- **Type:** h2 General Sans 600 / 24px / 0.08em caps. The enlarged strip's fields Martian Mono 400
  at 3× (39px). Explanations General Sans 400 / 16px / lh 1.6 / 58ch.
- **Color:** bg `#eae2d2`, strip `#fbf8f1`, fg `#0c2422` (15.34:1); leader lines `#14403d` at 30%;
  the `STATE` field explanation carries `#c63f28` on `#fbf8f1` (4.78:1).
- **Anchor / background mode:** `centered-statement` / `flat-surface`.
- **Content direction:** the five field explanations are where he says who he is, one field at a
  time — what a serial means, what counts as a role, what "handed off" means to him, and why
  `HOLDING` exists at all. Plain, first-person, no manifesto.

#### `strip-board` · Surface 3 of 6 — **WORKING** (the active bay)

- **Job:** what he is building right now.
- **Layout:** narrow left rail (cols 1–3 of the 1440px container) holding the bay label, the
  count and one note; wide right field holding the active strips at full 72px height with their
  annotation margins exposed at 96px.
- **Type:** h2 General Sans 600 / 24px caps. Strip titles General Sans 600 / 17px. Fields Martian
  Mono 400 / 13px. Annotations General Sans 400 / 15px / lh 1.5.
- **Color:** bay block `#14403d` on the left with `#fbf8f1` label (10.82:1); strips `#fbf8f1` on
  `#eae2d2`; active marker `#e9503a` fill with `#0c2422` label at 18px (4.39:1); annotation text
  `#5f6c67` (**5.17:1** on `#fbf8f1`).
- **Anchor / background mode:** `left-rail-caption` / `color-block`.
- **Content direction:** the genuinely active work — `atlas-erp`, `chapters`, and the AI-systems
  thread — each with a one-line annotation of what is currently unresolved on it.

#### `strip-board` · Surface 4 of 6 — **HANDED OFF** (shipped)

- **Job:** the built body of work, as a scan rather than a showcase.
- **Layout:** the full strip stack at density — 72px rows, five fixed columns, hairline dividers,
  no cards, no images. Column widths fixed and identical to the legend in Surface 2.
- **Type:** as the legend. Handed-off dates Martian Mono 400 / 13px, tabular by construction.
- **Color:** bg `#eae2d2`, strips `#fbf8f1`, fg `#0c2422` (15.34:1); divider `#14403d` at 30%;
  focus/hover row marked by `#c63f28` text plus a 2px left rule.
- **Anchor / background mode:** `dense-grid` / `flat-surface`.
- **Content direction:** the real client work — Metal ERP, Vivid Tents, Safa Tyour, Squad Mojo,
  Canin DCMP, Maher, TrueTale, Avaye Zaryab, Herat Dental Union — plus `vectory`. Role field
  carries the real role, not an inflated one.

#### `strip-board` · Surface 5 of 6 — **HOLDING** (parked, said plainly)

- **Job:** the risk-and-mistakes stance, made structural instead of stated.
- **Layout:** wide left field holding the parked strips dimmed; narrow right rail (cols 10–12)
  holding a short note on why a bay for parked work exists.
- **Type:** h2 General Sans 600 / 24px caps. Parked strip titles General Sans 600 / 17px in the
  disabled ramp, with a 1px strike rule through the STATE field so the state is not colour alone.
  Note General Sans 400 / 16px / lh 1.6.
- **Color:** bg `#eae2d2`; parked strips `#fbf8f1` with `#8d958e` field text (disabled ramp,
  paired with the strike) and `#0c2422` titles at 12.63:1 so the *name* stays fully legible;
  the note in `#0c2422`.
- **Anchor / background mode:** `right-rail-caption` / `flat-surface`.
- **Content direction:** CyborgTech (co-founder, paused) is the real, verified entry. The note
  says why parked work is on the board at all, in one or two sentences — no apology, no lesson.

#### `strip-board` · Surface 6 of 6 — **Frequency** (contact)

- **Job:** how to reach the tower.
- **Layout:** a single vertical run down the middle, 520px wide, space held either side; the form
  is three fields stacked, each 56px, on the 8px rhythm.
- **Type:** h2 General Sans 600 / 24px caps. Labels General Sans 500 / 13px / 0.08em caps. Inputs
  General Sans 400 / 16px. Address line Martian Mono 400 / 13px.
- **Color:** bg `linear-gradient(oklch(91.5% 0.023 84.6), oklch(98.0% 0.010 87.5))`; fg `#0c2422`;
  input borders `#14403d` (10.82:1); submit fill `#e9503a` with `#0c2422` label at 18px (4.39:1);
  focus ring `#c63f28`, flipping to `#0c2422` on the coral submit.
- **Anchor / background mode:** `stacked-center` / `tonal-gradient`.
- **Content direction:** email, `Taha-Mahmoodi` on GitHub, and one line naming what he wants sent.
  Help block last in the footer, fixed slot.

---

## Concept 3 — `as-built`

**Collision (structural parent named first).** *The issued technical drawing — title block,
dimension grid, sheet numbers, revision clouds — carries the structure; the site engineer's
coral redline drawn straight over it carries the surface*, so the page argues that the
corrections **are** the work rather than a blemish on it.
Modification against `STYLES.md`'s listed "ink gesture across data-brutalism": a redline is a
**correction**, not a gesture — it is legible, dimensioned, and dated, and it never sits over a
table; it sits over a drawing that a plan already made a claim about. The gesture version
asserts that a person had a view; this version proves a person was wrong and fixed it.

**Opening move.** Sheet 01, issued, with its first redline already on it. In three seconds the
viewer sees a plan and a correction to the plan on the same surface, in two inks, and understands
without reading that the second ink is the point.

**How the primary content is presented.** The **drawing schedule** — the door-schedule pattern
every drawing set already contains: `MARK / DESCRIPTION / SCALE / REV / NOTES`, hairline rules,
tabular figures, the redline confined to the `REV` column. Positions hold absolutely; a schedule
that moved its columns would be an unusable drawing.

**Navigation.** The **sheet index** in the persistent title block, bottom-right on desktop
(96px reserved, `scroll-padding-block-end: 96px`), listing `SHEET 01`–`SHEET 06`. Current sheet
marked by a coral box **and** the word `CURRENT` printed in the block. On narrow viewports the
title block becomes a static footer in the same serial order (3.2.6's responsive exception).

**Missing or wrong.** *404:* `SHEET NOT ISSUED` stamped across an empty drawing frame, with the
live sheet index printed beneath it. *Failed submission:* a revision cloud is drawn around the
field that failed and a redline note beside it names the correction; the original entry is
preserved verbatim (3.3.7).

**Style under density.** *At forty rows it becomes a schedule, which drawings already have.*
Hairline rules at 1px (dark) / 0.75px (light), tabular figures throughout, 4px vertical rhythm,
and the redline **confined to the REV column** so forty rows do not become forty corrections.
This is the direction with the least density risk of the three.

**Sections — 6.**

---

#### `as-built` · Surface 1 of 6 — **Sheet 01, as built** (hero, 21:9)

- **Job:** a plan and its correction, understood as one object, before a word is read.
- **Layout:** full-bleed drawing field, 32px drawn sheet border inset from every edge, 16-col
  drawing grid at 24px gutter visible as hairlines. The h1 sits in the sheet's upper-left corner
  as a title, not as a hero headline. Hero height `min(90vh, 940px)`.
- **Type:** h1 Cabinet Grotesk 700 / `clamp(2.5rem,5vw,4.5rem)` / lh 1.0 / 0.02em caps.
  Dimension micro 12px / 400 / 0.1em caps tabular. Redline 16px / 500 italic.
- **Color (dark/cyanotype):** field `#0e2e2c`; primary line `#efe7d6` at 1.5px (11.81:1);
  secondary `#7fb5ad` at 1px (6.30:1); redline `#f26a52` at 2px (4.81:1).
  **(light/diazo):** field `#fbf8f1`; primary `#0e2e2c` at 1px (13.69:1); secondary `#14403d` at
  0.75px (10.82:1); redline `#c63f28` at 1.5px (4.78:1).
- **Anchor / background mode:** `full-field` / `full-bleed-image` — the drawing field is generated
  in-browser as SVG line work, per `§8`; no raster is placed.
- **Content direction:** sheet title `TAHA MAHMOODI — AS BUILT`, `REV C`, and one redline note in
  his register correcting the sheet's own stated scope. The redline is the only sentence on the
  screen.

#### `as-built` · Surface 2 of 6 — **The title block** (who drew it)

- **Job:** the bio, in the one format that cannot be a bio — a title block states authorship as a
  field, not as a paragraph.
- **Layout:** content held in the lower band as a real title block: a 96px-tall, 5-cell strip
  spanning cols 9–16, with `DRAWN BY / CHECKED / SCALE / DATE / REV` and a 240px-tall notes cell
  above it. Empty drawing field above, deliberately.
- **Type:** title-block fields Cabinet Grotesk 600 / 13px / 0.08em caps. Values 400 / 13px
  tabular. Notes cell 17px / 400 / lh 1.65 / 60ch — the only sentence case on the sheet.
- **Color:** field, lines and redline per the concept palette above; the `REV` cell is the one
  cell carrying the redline colour, at graphical weight only.
- **Anchor / background mode:** `bottom-anchored` / `flat-surface`.
- **Content direction:** `DRAWN BY: Taha Mahmoodi`, the real orgs as the `CHECKED` chain
  (PIIIX / Alkharazmy / CyborgTech — paused), and a notes cell of three or four sentences
  covering the actual position: systems around AI, systems for AI, AI integrated into systems
  that already have users, on top of the brand and product design craft.

#### `as-built` · Surface 3 of 6 — **Revision cloud** (where the plan was wrong)

- **Job:** the risk-and-mistakes stance, evidenced.
- **Layout:** deliberately off-grid — the one section that breaks the 16-col drawing grid the rest
  of the set keeps. The cloud sits at a 4° rotation across cols 3–11 with its callout leader
  crossing the gutter; body text hangs below in cols 3–8.
- **Type:** h2 Cabinet Grotesk 500 / 18px / 0.16em caps. Redline note 16px / 500 italic / lh 1.4.
  Body 17px / 400 / lh 1.65 / 60ch. Revision numbers 12px tabular.
- **Color:** field per mode; cloud outline in the graphic-only tint (`#e9503a` 3.49:1 light,
  `#f26a52` 4.81:1 dark) — **outline only, never carrying text**; the redline note itself in the
  text-legal accent (`#c63f28` / `#f26a52`).
- **Anchor / background mode:** `offset-editorial` / `textured-surface` — the drawing's hairline
  mesh at low contrast, no image.
- **Content direction:** two or three real revisions, each one sentence: what the plan said, what
  actually got built, dated. Candidate material is on record — the position itself is `REV C`
  (design lead → systems and AI), and one project-level rework.

#### `as-built` · Surface 4 of 6 — **Sheet index** (the work)

- **Job:** every piece of work, findable, as a set rather than as a showcase.
- **Layout:** the drawing schedule at density — `MARK / DESCRIPTION / SCALE / REV / NOTES`, 40px
  rows on the 4px rhythm, hairline rules, spanning cols 1–16. Column widths locked; on narrow
  viewports rows become five stacked labelled lines in the same order.
- **Type:** column heads Cabinet Grotesk 600 / 13px / 0.08em caps. Cells 400 / 13px, **tabular
  figures on MARK, SCALE and REV**. Description cell 15px.
- **Color:** rules `#7fb5ad` 1px (dark) / `#14403d` 0.75px (light); text at the primary line
  colour (11.81:1 / 13.69:1); redline confined to the `REV` column.
- **Anchor / background mode:** `dense-grid` / `flat-surface`.
- **Content direction:** every real project as a sheet — `atlas-erp`, `chapters`, `vectory`,
  Metal ERP, Vivid Tents, Safa Tyour, Squad Mojo, Canin DCMP, Maher, TrueTale, Avaye Zaryab,
  Herat Dental Union. `SCALE` is the honest size of the engagement; `REV` is how many times it
  was reworked.

#### `as-built` · Surface 5 of 6 — **Detail at 1:5** (one project, enlarged)

- **Job:** depth on one thing, so the index is not the only evidence.
- **Layout:** two comparable fields meeting on one hard vertical rule at 60/40 — the enlarged
  detail left (cols 1–10), the written account right (cols 11–16) with its own dimension callouts.
- **Type:** h2 Cabinet Grotesk 500 / 18px / 0.16em caps. Account 17px / 400 / lh 1.65 / 60ch.
  Callouts 12px / 0.1em caps tabular. Redline 16px italic.
- **Color:** the detail is `duotone-treated` to exactly two palette values — field colour and
  primary line colour — per `§8`; no third value, no photographic grey. Redline over it at the
  text-legal accent.
- **Anchor / background mode:** `split-field` / `duotone-treated`.
- **Content direction:** one project taken apart — the strongest candidate is `atlas-erp`, where
  the plan, the rework and the shipped result are all documented. Five beats, no metrics unless
  real.

#### `as-built` · Surface 6 of 6 — **Issued for construction** (contact)

- **Job:** one way to reach him, framed as issuing rather than selling.
- **Layout:** one block on the sheet's axis — a 560px stamp block, centred, with the form's three
  fields inside it on the 4px rhythm; the sheet border continues around it unbroken.
- **Type:** h2 Cabinet Grotesk 500 / 18px / 0.16em caps. Stamp text 700 / 40px / 0.02em caps.
  Labels 600 / 13px / 0.08em caps. Inputs 400 / 17px.
- **Color:** two flat fields meeting on a hard edge — the sheet field and a solid accent block
  (`#c63f28` light / `#f26a52` dark) carrying the stamp text in the field colour — measured
  `#fbf8f1` on `#c63f28` **4.78:1** and `#0e2e2c` on `#f26a52` **4.81:1**, both body-legal at
  40px display size with margin; input borders at the secondary line colour (10.82:1 /
  6.30:1, both clearing 1.4.11).
- **Anchor / background mode:** `centered-statement` / `color-block`.
- **Content direction:** `ISSUED FOR CONSTRUCTION`, an email, `Taha-Mahmoodi` on GitHub, and one
  line on what he wants sent. Help block last, fixed slot.

---

## §7b Distinctness — tested on the artifact

### Swap test

Swapping each concept's opening line into the other two:

| Line | Into `bench` | Into `strip-board` | Into `as-built` |
|---|---|---|---|
| *"Still clamped. Come back in an hour."* | native | **breaks** — a strip is never clamped; the board has no vise and no clock-hour | **breaks** — a drawing is issued, not clamped |
| *"PENDING · WORKING · HANDED OFF · HOLDING"* | **breaks** — a bench has no bays and no states; things are either on it or off it | native | **breaks** — a sheet has revisions, not states |
| *"TAHA MAHMOODI — AS BUILT. REV C."* | **breaks** — a bench has no revision numbering | **breaks** — a strip has a serial, not a revision | native |

Every swap is detectable in under a second, and it is detectable **structurally**, not by tone —
the receiving concept has no object for the word to attach to. **Pass.**

Second swap, on the primary action's label: `Leave a note` / `Send to the tower` /
`Issue for construction`. Each is wrong in the other two for the same reason.

### Family pass

Labels, chosen for this run, not from a vocabulary: **`bench`**, **`strip-board`**, **`as-built`**.

- Does `bench` apply to `strip-board`? No — a board has no work surface and nothing is in
  progress *on* it; strips record work happening elsewhere.
- Does `strip-board` apply to `as-built`? No — a drawing has no bays and nothing moves; a
  revision is a change to a record, not a change of position.
- Does `as-built` apply to `bench`? No — a bench holds no plan and makes no claim to correct.

**Pass**, and the honest caveat: `bench` and `strip-board` both put unfinished work in front of
the viewer, so they share a *stance*. They do not share an object, a layout, a palette weighting
or a type system, and the labels do not transfer. The stance is shared because row 4 is one
person.

### Category-reflex check

Guessable from "portfolio for a designer"? No — the category reflex is hero + case-study rail +
card grid, and none of the three has a card grid at all. Guessable from category-plus-obvious-
twist? The obvious twist for a designer-who-builds is an IDE or terminal skin; none of the three
is that, and the closest (`strip-board`) is light-substrate paper in metal. **Pass.**

### The concept that was rejected, and why

**`tear-down` — an engine tear-down shot from directly overhead on a dark magnetic tray, every
part laid out in the order it came off, the two that failed set slightly apart.**

It derived cleanly from row 4 and it was the most immediately beautiful of the four. It was cut
on **row 5**, which is honored absolutely and sits on `BREAKING.md`'s never-breakable list:
*an arranged, evenly-lit overhead of parts in order is a curation, and a curation is the
work-as-exhibited framing the broadsheet ban names.* The arrangement is the tell — a workbench
mid-project is not arranged, and the moment the parts are laid out in order for a viewer, the
subject is performing the method rather than working in it, which is precisely the shadow row 4
identifies. Rejecting it is what forced the `as-built` derivation, which reaches the same
material (evidence of what went wrong) through a document rather than a display.

---

## §10 Set-level check — run on the logged tokens, per concept

**Not suspended.** This is a page-shaped set, the brief is not deliberately minimal, and there is
no tool-shaped surface in the run. All three criteria run in full on all three sets.

| | S1 | S2 | S3 | S4 | S5 | S6 |
|---|---|---|---|---|---|---|
| **`bench` anchor** | `full-field` | `left-rail-caption` | `split-field` | `dense-grid` | `top-left-lead` | `bottom-anchored` |
| **`bench` bg** | `full-bleed-image` | `vignette-crop` | `flat-surface` | `flat-surface` | `noise-over-solid` | `tonal-gradient` |
| **`strip-board` anchor** | `dense-grid` | `centered-statement` | `left-rail-caption` | `dense-grid` | `right-rail-caption` | `stacked-center` |
| **`strip-board` bg** | `image-as-canvas` | `flat-surface` | `color-block` | `flat-surface` | `flat-surface` | `tonal-gradient` |
| **`as-built` anchor** | `full-field` | `bottom-anchored` | `offset-editorial` | `dense-grid` | `split-field` | `centered-statement` |
| **`as-built` bg** | `full-bleed-image` | `flat-surface` | `textured-surface` | `flat-surface` | `duotone-treated` | `color-block` |

- **Anchor repeated more than twice in a row:** none. Zero consecutive repeats in any set;
  `strip-board` repeats `dense-grid` at S1 and S4, non-consecutively, which is inside the rule.
- **Background mode repeated more than three times in a row:** none. Longest run is 2
  (`bench` S3–S4, `strip-board` S4–S5).
- **A full-bleed treatment appears in every set:** `bench` S1 `full-bleed-image`;
  `strip-board` S1 `image-as-canvas`; `as-built` S1 `full-bleed-image`. All three generated
  in-browser per `§8`, never placed raw and never stock.

**PASS on all three sets. Nothing rejected, nothing regenerated.**

**What the sets do not vary — never suspended.** Within each concept: one palette (the tables in
§5), one type hierarchy (the tables in §6), one component family (bench-run row / strip / schedule
row, respectively), one surface treatment. Composition, emphasis and visual tempo are the only
things that move. Across concepts palette and type deliberately differ — that is what §5 and §6
built per direction and what Gate A is choosing between.

**One honesty note on this check:** it was run against tokens I assigned while writing the specs,
not against tokens returned by independent workers who could not see their neighbours. The check
exists because no worker can see its neighbours; run by the author of the specs, it is a weaker
instrument, and it is weaker in a specific direction — I could have chosen non-repeating tokens
*because* I knew the rule. Read it accordingly.

---

## SAFE / RISK

### The safe reading

All three concepts are coherent, derived rather than picked, honor row 5 absolutely, reconcile
against one sampled accent, and carry measured contrast in both modes. `strip-board` is the
safest of the three: light-first, highest measured contrast, densest-load-tolerant, and the only
one whose structure a stranger could navigate with the sound off. If the run needs a direction
that cannot embarrass anyone, that is it.

### The risks, each costed

**RISK 1 — `bench` is a dark atmospheric direction, so it is two art directions and two builds.**
`STYLES.md` is unambiguous that there is no light version of a lit set. **Cost if it lands
badly:** roughly **1.6–1.8× the CSS surface** of a single-palette direction and a second
art-directed reduced-motion still, which is Loop 2 build time not Loop 4; the page that gets
forwarded and read in daylight is the *second* design, so the weaker of the two is the one most
strangers see; and the in-browser generated key-light field is the only thing carrying the
concept, so if it degrades on a low-end GPU the direction degrades to a dark page with hairlines.
**Cost if we avoid it:** the direction that most directly renders row 4's own physical check
(*a workbench, not a gallery*) is the one we did not build.

**RISK 2 — `strip-board`'s hand-annotation is one step from the banned gig-poster register.**
Row 5 bans textural, loud, handmade-performative absolutely. A controller's ballpoint annotation
is handmade, and the defense is that it is functional and ugly rather than expressive. That
defense is real but it is thin, and it rests entirely on execution restraint. **Cost if it lands
badly:** the concept trips the exact ban it was derived to avoid, which is a **Gate A rejection
at the *brief* level, not the execution level** — meaning it does not come back as a re-render,
it comes back as a re-derivation, and per loops/01 that is the most expensive rejection class in
the loop. **Mitigation available now, at a cost:** drop the annotation to machine-printed
overstrike only, which loses the single human mark on the concept and makes it colder.

**RISK 3 — `as-built` runs a display face at body size, and it is the single-family direction.**
Cabinet Grotesk carries 17px body text at lh 1.65 across the whole concept. Display faces have
tighter apertures and less generous spacing at text sizes, and the direction has no second family
to fall back to because the single-hand argument is the concept. **Cost if it lands badly:**
the sheet's notes cell and the Detail-at-1:5 account become measurably harder to read, which
costs the run **the exact thing row 2 asks for — an accurate read** — and the fix is either a
second family (which breaks the collision's single-hand claim and is a Loop 2 redraw of the
title block, the schedule and the redline voice) or a body-size bump to 18–19px that pushes every
column measure and re-flows the 16-column drawing grid. This is the one risk I would test with a
real text block before Gate A closes.

**RISK 4 — the accent cannot carry body text in light mode, and two of three concepts are
light-first or dual-mode.** Measured: `#c63f28` on `#f2ede3` is 4.34:1, short of 4.5. **Cost:**
the accent's placement is *constrained by measurement*, not by taste — it is confined to `#fbf8f1`
for text and to graphical roles elsewhere, permanently. If a later build wants coral body text on
the board substrate, the answer is no, and the only ways out are shifting the sampled hex (which
breaks `§6`'s sample-from-reality) or changing the substrate (which changes the direction).

---

## Cost ledger

| Item | Count |
|---|---|
| Concepts generated | **3** (plus 1 derived and rejected — `tear-down`) |
| Sections per concept | **6**, identical across concepts so the sets are comparable |
| Comp specs produced | **18** |
| **Images generated** | **0 — replaced by coded comps at subject request (mid-run redirect)** |
| Images rejected / regenerated | 0 / n/a — no image phase ran |
| `surface-designer` workers dispatched | **0** |
| Image MCP tools loaded | **0** |

**Wall-clock per phase — not instrumented, reported as observable tool round-trips instead.**
No phase timer exists anywhere in the pipeline and no file asks for one, so honest counts:

| Phase | Round-trips |
|---|---|
| Reading the corpus (role file, TRANSLATE, RUN-NOTES, loops/01, PRINCIPLES, STYLES ×3, ACCESS ×5, surface-designer) | 13 |
| Sampling row 6 from the real source | 3 |
| Derivation, concepts, distinctness tests | 0 (in-context) |
| Colour math (OKLCH + every measured ratio) | 2 |
| Writing the draft | 1 |

The 3× cost this run was meant to measure **was not measured**, because the image phase was
cancelled. What it would have been, committed in advance: *three concepts, six surfaces, eighteen
images*, at one worker dispatch per image.

---

## Pipeline observations — for the run ledger

Numbered, blunt. Every place a file failed me, an ambiguity forced an invention, or an
instruction could not be followed as written.

**1. TRANSLATE row 6 was incomplete, and trusting it would have corrupted §5.** The filled row
lists petrol, deep, paper, surface and ink and **stops before the accent**. The real source
declares `--coral: #e9503a /* accent surfaces */` and `--coral-ink: #c63f28 /* accent text, large
only */` — the subject had already reasoned about its contrast ceiling in a code comment. My
dispatch calls TRANSLATE "your only strategy input"; `§6` says sample the pixels. Those two
instructions disagree, and only `§6` was right. **Fix:** row 6 needs a required accent field, and
`direction-conductor.md` should say *re-sample the source, do not accept row 6's summary as the
sample.* A conductor that obeyed its dispatch literally would have invented an accent for a
subject who already owns one — the exact failure `§6` exists to prevent.

**2. `N` is undefined the moment section lists are derived per concept.** loops/01 §8 states
"N is the surface count", requires the label `<concept>: Surface X of N`, and warns that a
concept rendered at three surfaces cannot be compared against one rendered at nine. §7 states the
surface list is derived per concept from row 2's viewer. Two concepts wanting different section
counts breaks both the label format and the comparability argument. **I invented the resolution:**
N fixed at 6 for the run, identical across concepts, different content in each. **Fix:** §8 should
say N is set once, before §7 develops the concepts — or the label and the set-check need a ragged-
set story.

**3. "Type per direction" and "row 6 is a constraint" are never reconciled.** loops/01 §6 says
type is built per direction. STYLES' picking procedure input 5 says owned elements are
constraints, not suggestions. The subject owns exactly two faces and there are three directions.
Nothing in any file says which rule wins. **I invented the rule:** the owned pair is the default,
and a direction replacing one states its reason on the same line. That produced `strip-board`
dropping Cabinet Grotesk and `as-built` collapsing to one family — both defensible, neither
derived from a written instruction.

**4. ACCESS §13 has no not-applicable state, only a deferred-with-cost state.** Row 7
(authentication) assumes an auth surface exists. This portfolio has no login, so "there is no
authentication" is neither an answer nor a skip, and §13's preamble only offers *skipped = decision
with its cost*. Recording it as a deferral would have been a fabricated cost. **Fix:** §13 needs an
explicit N/A-with-reason state distinct from deferred-with-cost.

**5. Several §13 rows fork per concept, and the list is written as if they are per run.** Sticky
chrome geometry (row 5), the reduced-motion still (row 11) and the focus ring's flip case (row 4)
each have three different correct answers here — `bench` has no sticky chrome at all, `strip-board`
reserves 56px, `as-built` reserves 96px. §13 says the answers "land in DIRECTION.md" as a flat list
of thirteen. **Fix:** mark which rows are per-run and which fork per concept, or the decision list
silently becomes 3×13 in an unpredictable subset.

**6. The set-level check cannot be run honestly by whoever wrote the specs.** loops/01 §10
justifies the check with "no worker can run it — none of them can see its neighbors." Its validity
depends on the tokens being logged by agents who did not know the anti-repeat rule. With the image
phase cancelled I assigned all eighteen tokens myself, knowing the rule, then checked my own
assignment. It passed, and the pass is worth much less than a real one. `direction-conductor.md`'s
degradation section acknowledges this for the inline-image case ("harder to be honest about") but
not for the no-worker case, where the problem is worse because there is no artifact to check the
token against. **Recorded in-file at the check, not hidden.**

**7. Nothing in the pipeline supports a coded-comp deliverable — and it should.** The redirect was
not an edge case. A subject who reads hexes, type scales and spacing numbers more accurately than
a rendered image is a normal design client, and arguably the *right* client for a plugin whose
premise is measured contrast pairs and stated numbers. loops/01 §8–§9, `surface-designer.md`, and
Gate A's presentation list are all written as if an image is the only possible artifact.
**What `surface-designer.md` needs for this to be a supported path rather than an override:** a
coded-comp mode holding the same one-surface-one-concept rule and the same two logged tokens, with
the deliverable a spec block — layout move plus numbers, type table, paired colours with measured
ratios, one line of content direction. "Get it onto disk" becomes "write the spec block to the run
directory"; "Look at it, then gate yourself" becomes "read your own numbers back and check them
against the palette table" — the embarrassment gate survives intact, applied to a spec. The
`tools:` fence would shrink to `Read, Write, Bash` with no image tool at all.

**8. `§12` has no coded-comp equivalent, and the confidence loss is real.** With images, the
conductor at least sees whether the model held the hexes. With specs, nothing between here and
Loop 4 renders anything. Every contrast ratio in this document is *computed*, not *observed* — the
arithmetic is right, but "it computes" is not "it renders", which is the same distinction `§12`
draws about builds. No file names this gap.

**9. No phase timing exists anywhere in the pipeline.** The dispatch asked for wall-clock per
phase. Nothing records time, no agent file asks for it, and a subagent has no clock. I reported
tool round-trips instead, which is honest but is not what was asked. **Fix:** if the 3× cost is
meant to be a real measurement, the run ledger needs a timestamp convention — one `date` call at
each phase boundary, six round-trips for the whole loop.

**10. loops/01 §8's aspect-ratio table is the file's most concrete instruction and it evaporates
in a coded comp.** "21:9 hero" is purely about canvas fidelity. The coded equivalent is a viewport
height and a container width, which I wrote (`min(88vh, 900px)`, `min(90vh, 940px)`) — but I
invented the translation. **Fix:** the ratio table should carry a coded column, or the coded mode
has a hole exactly where the image mode is most specific.

**11. §7 gives no guidance on deriving a section list when row 2 has no task.** It says the list
comes from "row 2's viewer and their task". Row 2 here has no task — the decision is *form an
accurate read*, and there is no funnel to derive an order from. RUN-NOTES already flagged the
identity-portfolio case as a row-2 gap; it propagates into §7 and nobody caught it there. The
dispatch supplied "roughly 5–7 sections"; the file supplies nothing. **Fix:** §7 should name what
the list is derived from when there is no objective — here it was the archetype's own arc (the
problem, the attempts, the shipped work, the parked work, the person, the way in).

**12. STYLES' "Style under density" table is indexed by single family, and every real direction is
a collision.** All three of mine are two-family collisions. `bench` is atmospheric × reductive:
the atmospheric row says "confine the grade to the shell", the reductive row says "usually the
honest answer is no". I composed the answer by taking the stricter of the two. **Fix:** the table
should state that rule explicitly — a collision inherits the stricter parent's density answer —
because otherwise every collision run invents its own arbitration.

**13. One thing that worked exactly as documented, recorded because it earned it.**
`direction-conductor.md`'s clause *"on a harness that grants every tool regardless of what the
frontmatter says, treat `tools:` as an instruction rather than a fence"* is the only reason
CRAFT.md stayed unread, no code was written, and Loop 2 was not started. This harness enforces
nothing; the prose held. That paragraph is load-bearing and should not be trimmed.
