# Research — the construction layer

**Date:** 2026-08-08
**Method:** headless Chromium (`Chrome/145.0.7632.6`) against rendered primary sources, plus
values measured in that same browser. No summarizers — the two fabrications this project
already caught both came from one.

**Why this pass exists.** The plugin demands numbers at every leaf — a neutral ramp, a type
scale, a spacing step, an elevation level, columns and gutters per breakpoint — and taught no
method for deriving any of them. The dogfood run produced all five anyway, honestly, and in
doing so showed exactly where the invention happens. That is what this closes.

Three evidence tiers are used below and never blurred:

- **SPEC** — quoted off the rendered normative document, with its date.
- **MEASURED** — a number this pass produced in the browser. Reproducible; the probe is included.
- **CRAFT** — practitioner consensus with no primary source. Labeled, never dressed as spec.
  Same precedent as `ACCESS.md` §6.

---

## 1. OKLCH: building a ramp that survives the display

**Source:** CSS Color Module Level 4, W3C Candidate Recommendation Draft, **6 August 2026**
(`https://www.w3.org/TR/css-color-4/`).

### The coordinate space, exactly (SPEC)

- **L** is `0`–`1` (or `0%`–`100%`). Out-of-range values are **clamped at parsed-value time**.
  L of 0 renders black, L of 1 renders white, per the display's gamut mapping.
- **C** has a percent reference of `100% = 0.4`. Its "minimum useful value is 0, while its
  maximum is theoretically unbounded (but in practice does not exceed 0.5)". Negative C is
  clamped to 0 at parsed-value time.
- **H** is an angle, and the spec names the anchors: **0° = purplish red** (the positive `a`
  axis), **90° = mustard yellow**, **180° = greenish cyan**, **270° = sky blue**.
- Chroma at or below `0.000004` makes the **hue powerless** — the practical definition of a
  true neutral in this space.

### The rule that makes a ramp buildable (SPEC)

All three CSS gamut-mapping algorithms "aim at **constant-lightness, constant-hue chroma
reduction** in the OkLCh color space." The reason is stated plainly:

> when doing gamut mapping changes in Hue are particularly objectionable; changes in Chroma
> are more tolerable, and small changes in Lightness can also be acceptable especially if the
> alternative is a larger Chroma reduction.

So the priority order when a color will not fit is **hold hue, hold lightness, cut chroma** —
which is also the order a designer should reason in when a sampled brand color has to become
a ten-step ramp. One just-noticeable difference in OkLCh is a **deltaEOK of 0.02** (the spec
notes this is 100× smaller than the CIE Lab figure of 2 because OkLCh lightness runs 0–1).
0.02 is the useful floor for "are these two steps actually different steps."

### The chroma ceiling collapses at the ends — MEASURED

Held constant across a ramp, chroma is not physically available. Maximum in-gamut chroma per
lightness and hue, binary-searched to 26 iterations using the browser's own unclamped
conversion (`color(from oklch(L C H) srgb r g b)`, in gamut when every component is within
`[0, 1]`):

| L | red 29° | orange 70° | yellow 110° | green 145° | cyan 195° | blue 264° | magenta 328° |
|---|---|---|---|---|---|---|---|
| 0.20 | 0.082 / 0.092 | 0.043 / 0.050 | 0.044 / 0.051 | 0.063 / 0.085 | 0.034 / 0.046 | 0.117 / 0.138 | 0.092 / 0.101 |
| 0.35 | 0.144 / 0.161 | 0.076 / 0.087 | 0.076 / 0.089 | 0.110 / 0.149 | 0.060 / 0.080 | 0.203 / 0.241 | 0.161 / 0.176 |
| 0.50 | 0.205 / 0.231 | 0.108 / 0.124 | 0.109 / 0.127 | 0.157 / 0.213 | 0.085 / 0.115 | 0.281 / 0.300 | 0.230 / 0.251 |
| 0.65 | 0.236 / 0.298 | 0.141 / 0.162 | 0.142 / 0.165 | 0.204 / 0.277 | 0.111 / 0.149 | 0.186 / 0.201 | 0.299 / 0.327 |
| 0.80 | 0.115 / 0.147 | 0.162 / 0.199 | 0.175 / 0.203 | 0.252 / 0.341 | 0.136 / 0.183 | 0.100 / 0.109 | 0.196 / 0.226 |
| 0.90 | 0.052 / 0.068 | 0.076 / 0.095 | 0.196 / 0.228 | 0.195 / 0.218 | 0.154 / 0.172 | 0.048 / 0.053 | 0.089 / 0.109 |
| 0.97 | 0.015 / 0.019 | 0.022 / 0.027 | 0.178 / 0.181 | 0.051 / 0.057 | 0.044 / 0.050 | 0.014 / 0.016 | 0.025 / 0.032 |

Each cell is **sRGB / Display-P3**. Two internal checks passed: P3 ≥ sRGB in every cell, and
the sRGB primaries round-trip to `oklch(0.628 0.258 29.2)`, `oklch(0.866 0.295 142.5)`,
`oklch(0.452 0.313 264.1)` — each sitting at the peak of its own hue's column, which is what a
correct probe must show.

What this settles:

- **A ramp cannot hold chroma constant.** Red at L 0.90 tops out at C 0.052 in sRGB — a fifth
  of what the same hue carries at L 0.65. A ten-step ramp written at one chroma is a ramp
  whose light end is silently gamut-mapped into something else.
- **The ceiling peaks near the hue's own cusp**, and the cusp lightness differs per hue: red
  and blue peak in the middle, yellow near the top. A ramp built on a blue accent and a ramp
  built on a yellow accent are not the same shape.
- **P3 buys headroom, not a different palette.** Typically 10–35% more chroma at the same L
  and H. It is worth declaring, and it is never worth designing a direction around.
- **Neutral ramps.** A tinted neutral is the accent hue held constant with chroma at a small
  fraction — roughly 0.005–0.03 in practice — and lightness carrying the whole ramp. Below
  `C = 0.000004` the hue is powerless and the ramp is a true gray.

Probe, for anyone re-deriving this (it needs no library, and it is the same three lines that
answer "will this color survive on an sRGB display?"):

```js
const e = document.createElement('div'); document.body.appendChild(e);
e.style.color = `color(from oklch(${L} ${C} ${H}) srgb r g b)`;
const rgb = getComputedStyle(e).color.match(/[-\d.]+/g).slice(-3).map(Number);
const inGamut = rgb.every(v => v >= 0 && v <= 1);   // out of gamut → reduce C, hold L and H
```

### Interpolation space is a separate decision from notation (SPEC + MEASURED)

CSS Color 4 §13.1 distinguishes three intents: **Oklab** for perceptually even spacing,
**OkLCh** for maximum chroma through the transition ("if avoiding graying out in color mixing
is desired"), and sRGB only for legacy compatibility, "even though it produces poorer results
(overly dark or greyish mixes)."

CSS Images 4 sets the gradient default: "If no `<color-interpolation-method>` is specified in
the gradient function, the color space used for gradient interpolation is the **default
interpolation color space, Oklab**."

**But that is not what the browser does when the stops are legacy colors.** Measured in
Chromium 145, sampling the midpoint of a 200px gradient from `#0000ff` to `#ffff00`:

| gradient | midpoint RGB |
|---|---|
| `linear-gradient(to right, #0000ff, #ffff00)` | `(118, 118, 137)` |
| `linear-gradient(in srgb to right, #0000ff, #ffff00)` | `(118, 118, 137)` |
| `linear-gradient(in oklab to right, #0000ff, #ffff00)` | `(96, 164, 204)` |
| `linear-gradient(to right, oklch(45.2% .313 264), oklch(96.8% .211 109.8))` | `(96, 164, 204)` |

Plain-hex stops interpolate in **sRGB**, pixel-identical to an explicit `in srgb`. One
`oklch()` stop flips the whole gradient to Oklab. So the operative advice already in
`CRAFT.md` is right about behavior and wrong about cause: this is a browser web-compat
carve-out for legacy color syntax, not a spec rule. The robust instruction is stronger than
the one currently shipped — **name the interpolation space in the gradient** rather than rely
on stop notation to trigger it, because the notation trigger is the thing that can change out
from under a design.

---

## 2. Type: what the scale is derived from

### There is no single ratio, and the biggest system says so (SPEC)

Material 3 publishes **one type scale of 15 baseline styles** (Display / Headline / Title /
Body / Label, each Large / Medium / Small), plus 15 emphasized styles added in the expressive
update. It is **role-indexed, not a geometric progression**, and the guidance is explicit that
partial use is correct: "No single product will use all the styles. Instead, select styles
from the scale that are most appropriate."

This retires an assumption the plugin was carrying implicitly. A modular ratio is one method,
not the method. The fork:

- **Ratio-derived** when the surface is content-led and the sizes are a continuum — editorial,
  marketing, long-form. The ratio is a decision that gets stated and defended.
- **Role-indexed** when the sizes are named jobs with fixed relationships — product UI, tools,
  anything whose type inventory is a component list rather than a document outline. Adjacent
  steps will not be a constant ratio and forcing them to be one invents sizes with no job.

The dogfood run reached the second answer unprompted and wrote it down as a confession
("there is no modular ratio, and pretending there is one would be a fabrication"). It was not
a confession. It was the correct branch, taken without a rule to take it under.

Unit conversion, for a cross-platform scale (SPEC, Material): Android `sp` → web `rem` at a
ratio of **0.0625** (that is, ÷16); tracking converts as *(tracking px ÷ font size) = em*.

### The floors are normative, and they are floors on robustness, not on taste (SPEC)

WCAG 2.2, W3C Recommendation **12 December 2024**:

- **SC 1.4.12 Text Spacing (AA)** — no loss of content or functionality when the user sets
  **line height to 1.5× font size**, **spacing after paragraphs to 2× font size**,
  **letter-spacing to 0.12em**, and **word-spacing to 0.16em**. Note 1 is the part designers
  misread: "Content is not required to use these text spacing values. The requirement is to
  ensure that when a user overrides the authored text spacing, content or functionality is not
  lost." A 1.2 line-height is legal. A layout that breaks when the user forces 1.5 is not.
- **SC 1.4.8 Visual Presentation (AAA)** — width no more than **80 characters or glyphs (40 if
  CJK)**; line spacing at least space-and-a-half within paragraphs; paragraph spacing at least
  1.5× the line spacing; text not justified. Also a mechanism criterion, not a value mandate.
- **SC 1.4.10 Reflow (AA)** — no two-dimensional scrolling at a width equivalent to **320 CSS
  px**, which is 1280px at 400% zoom.
- **SC 1.4.4 Resize Text (AA)** — text resizable to **200%** without loss of content or
  functionality.

The measure ceiling therefore has a documented number — 80 characters — from which the
familiar 45–75ch working range is a **CRAFT** narrowing, and should be labeled as one. What is
not craft: a measure written in `rem` is not a measure. `ch` is the unit that tracks the font,
and DTCG's `dimension` type has no `ch`, so a tokenized measure needs the `ch` intent recorded
and a computed `rem` equivalent derived from the actual face's advance width — not a number
that happens to share the digits.

### Fluid type silently ignores the user's font size — MEASURED

Three strategies, computed font-size read at three viewport widths, first at a 16px root and
then with the root set to 32px (a user who doubled their browser's default text size):

| viewport | `clamp(1rem, 2.5vw, 2rem)` | `clamp(1rem, .6667rem + 1.6667vw, 2rem)` | `1.25rem` |
|---|---|---|---|
| 320px | 16 → 32px (**2.00×**) | 16 → 32px (**2.00×**) | 20 → 40px (**2.00×**) |
| 768px | 19.2 → 32px (**1.67×**) | 23.5 → 34.1px (**1.45×**) | 20 → 40px (**2.00×**) |
| 1280px | 32 → 32px (**1.00×**) | 32 → 42.7px (**1.33×**) | 20 → 40px (**2.00×**) |

The pure-viewport middle term is the common reflex and it is the worst of the three: at a
desktop width it is pinned to its `max` bound, so a user who doubles their default text size
gets **no change at all**. The Utopia-shaped expression — a `rem` intercept plus a `vw` slope,
derived as `slope = (maxSize − minSize) / (maxVW − minVW)` and
`intercept = minSize − slope × minVW` — degrades rather than fails, but still under-responds
in the middle of its range. Pure `rem` steps track the user exactly.

Scope this honestly: it measures the **user-default-font-size** path, not browser page zoom,
which scales the CSS viewport and therefore carries `vw` along with it. The failure is real
and it is specific. The rule that follows is that the `clamp()` **min and max bounds must be
`rem`**, and any direction whose type is fluid states what happens at a doubled root size.

### The baseline grid, defined (SPEC-adjacent + MEASURED)

`CRAFT.md` invokes a baseline grid and never says what makes one. It is one number: a vertical
unit that every line box is a whole multiple of. The derivation is arithmetic — **`font-size ×
line-height` must be an integer multiple of the spacing unit** — and browsers do not round it
for you. Measured:

| type | computed line-height | three-line block |
|---|---|---|
| 17px × 1.65 | 28.05px | **84.1406px** |
| 16px × 1.5 | 24px | **72.0000px** |

The first is the dogfood run's own body setting, under a `DIRECTION.md` that declares
"vertical rhythm: 4px at every breakpoint." It drifts 0.05px per line and never lands on the
grid it claims. The second lands exactly, on both a 4px and an 8px unit. Neither is a bug;
declaring the first one as a grid is. **A stated baseline grid that the line-height does not
divide into is decoration.** Either set the ratio so the product is an integer multiple, set
line-height in the unit directly, or drop the claim.

---

## 3. Spacing: the scale is named by ratio, and gaps in it are the point

**Source:** Material 3 spacing (`m3.material.io/styles/spacing/overview` and `/tokens`).
Caveat stated on the page itself: "The spacing system tokens are only used on Jetpack
Compose" — Android Views and Web are marked Unavailable. The *scale* is the transferable part;
the token names are not yet cross-platform.

> The spacing system is measured on an **8dp scale, where `space100` = 8dp**.

Values are a multiplier of that base, and the token number is `100 × (value ÷ 8)`:

| token | dp | | token | dp | | token | dp |
|---|---|---|---|---|---|---|---|
| Space 0 | 0 | | Space 150 | 12 | | Space 450 | 36 |
| Space 25 | 2 | | Space 175 | 14 | | Space 500 | 40 |
| Space 50 | 4 | | Space 200 | 16 | | Space 600 | 48 |
| Space 75 | 6 | | Space 250 | 20 | | Space 700 | 56 |
| Space 100 | **8** | | Space 300 | 24 | | Space 800 | 64 |
| Space 125 | 10 | | Space 400 | 32 | | Space 900 | 72 |

Two rules come out of the page and both are worth taking:

- **Only the values with a job get defined.** "Rather than defining every value, Material only
  defines the most recommended spacing unit values on the scale." The values that are not
  multiples of 8 — 2, 4, 6, 10, 12, 14, 20, 36 in the published set; the page's own examples
  are "2dp, 4dp, 6dp, and 10dp" — are called *nested units* and exist only because components
  actually use them. The
  dogfood run arrived at the identical rule independently — "a step that has no job does not
  get a token" — which is now sourced rather than asserted.
- **Ratio naming beats ordinal naming.** `space100 = 8dp` means every other token's number
  states its relationship to the base. `space.24 = 96px` (the run's scheme: 24 × 4px) requires
  the reader to remember the base to decode any token. Both are defensible; the first survives
  a base change.

The **density** page supplies the step size for compression: the component density scale runs
0, −1, −2, −3, and "higher density is typically applied by decreasing the top and bottom
padding or overall height by **4dp**." It also fixes the floor the plugin already carries from
another direction: "The default target size should be at least **48x48 CSS pixels**", and
"Don't apply component scaling by default if it would result in a target below 48x48 CSS
pixels." Note the unit — the density page says CSS pixels, not dp.

Density is a **user setting, not a breakpoint consequence**: "Density shouldn't automatically
change across breakpoints or orientation unless a person changes it." That is the opposite of
the reflex to compress a tool's spacing because the window got small.

---

## 4. Elevation: six levels, and the token carries no shadow

**Source:** Material 3 elevation (`m3.material.io/styles/elevation/`, overview / applying /
tokens tabs).

**Six levels, in dp, with resting states restricted (SPEC):**

| level | dp | what rests here |
|---|---|---|
| 0 | 0 | app bar (not scrolled), filled/tonal/outlined buttons, filled/outlined cards, chips, lists, tabs, sliders, navigation rail, full-screen dialog |
| +1 | 1 | banner, modal bottom sheet, elevated button, elevated card, elevated chips, modal navigation drawer, modal side sheet |
| +2 | 3 | app bar (scrolled), menu, navigation bar, rich tooltip, toolbar |
| +3 | 6 | date/time pickers, modal dialogs, FAB and extended FAB, search |
| +4 | 8 | **not assigned as a resting level** |
| +5 | 12 | **not assigned as a resting level** |

"An element's resting state can be on levels 0 to +3, while levels **+4 and +5 are reserved
for user-interacted states** such as hover and dragged." Hover or focus "usually raises
elevation by one level."

The rest of the model:

- **"Tokens have no shadows or color; each platform determines the specific shadows and values
  to use at each elevation level."** Elevation is a distance, and the shadow is a rendering of
  it. A `DIRECTION.md` elevation section that lists shadows without the levels behind them has
  written the rendering and skipped the system.
- **Three ways to depict it**: tonal difference between surface roles (M3's own default),
  shadow, or scrim. A surface must show its edges, its overlap, and its distance.
- **Shadow construction, stated as two coupled variables**: "Both a shadow's size and amount of
  softness or diffusion express the degree of distance... a surface with a shadow that's small
  and sharp indicates a surface's close proximity to the surface behind it. Larger, softer
  shadows express more distance." A shadow scale that varies blur and not offset, or offset and
  not blur, is not a scale.
- **Scrims use the scrim color role at 32% opacity.**
- **Contrast is not optional at the edges**: "For interactive components, edges must create
  sufficient contrast between surfaces (by meeting or exceeding accessible contrast ratios) for
  them to be seen as separate from one another." This is the `§10` non-text 3:1 rule arriving
  through the elevation door.
- **Surface tint color is deprecated** — use the elevation level tokens 0–5.
- Two restraint rules, in Material's own words: "Avoid changing the default elevation of
  Material 3 components", and "When it comes to applying shadows, less is more."

The run's `DIRECTION.md` §11 said "this direction has no shadow language" and enumerated what
that meant. That is a complete answer to this section, and the schema should keep saying so.

---

## 5. Grid derivation: the margins stop growing, the panes take over

**Source:** Material 3 breakpoints (`m3.material.io/foundations/layout/breakpoints/*`) and
grids (`/foundations/layout/grids-spacing/grids`). Note the rename: **"window size class" is
now "breakpoint"** — `applying-layout/window-size-classes` redirects to
`foundations/layout/breakpoints/overview`, and the pages gloss it as "breakpoints (previously
window size classes)". Earlier docs in this repo cite the old URLs; they still resolve.

| breakpoint | width | margins | spacer | panes | navigation |
|---|---|---|---|---|---|
| Compact | < 600dp | **16dp** | — | single | navigation bar, or modal expanded rail |
| Medium | 600–839dp | **24dp** | 24dp | single recommended; two only for low-density content, **50/50**, no custom widths | rail (single-pane) / bar (two-pane) |
| Expanded | 840–1199dp | **24dp** | 24dp | two often best; fixed pane **360dp** in fixed-and-flexible | rail, collapsed or expanded |
| Large | 1200–1599dp | **24dp** | 24dp | two; fixed pane **412dp** | rail, collapsed or expanded |
| Extra-large | ≥ 1600dp | **24dp** | 24dp | two; fixed pane **412dp** | expanded rail suits it best |

The counter-reflex finding: **margins cap at 24dp and never grow again.** Everything above
Medium adapts by changing *pane structure* — how many, which is fixed, which is flexible — not
by widening gutters. A ladder whose margins keep climbing to 48, 64, 96 at desktop is inventing
a system, and should say so out loud rather than implying Material.

On columns, Material is now deliberately unspecific: the grids page states that "column count,
width, and spacing change" across breakpoints and publishes **no column table**. The published
structure is the ruler set instead — bar/safety rulers reserving space for status bar and
gesture navigation, a title ruler, and content rulers ("First content ruler: emphasizes major
blocks like hero images, headlines, or primary components"). Margin rulers are explicitly
adjustable: "Choosing a narrower or wider margin can create or remove negative space."

For web, this leaves column count genuinely author-chosen, which means a `DIRECTION.md` grid
table has to defend its own number rather than cite one. The honest derivation, and this is
**CRAFT**: pick the column count that makes the primary content land at its measure at the
widest breakpoint, then check that the same count divides sensibly at the narrow one. Twelve is
a convention, not a derivation, and a design that needs sixteen because its content is a
drawing sheet should have sixteen.

---

## 6. Corrections this pass forces on files already shipped

1. **`CRAFT.md`, OKLCH gradient row.** The behavior described is right; the attribution is
   wrong. CSS Images 4 makes Oklab the default with no legacy exception in its prose — the
   sRGB fallback for legacy stops is browser behavior, measured here, not a spec rule. And the
   advice should be upgraded from "write one endpoint as `oklch()`" to "declare
   `in oklab` / `in oklch` explicitly."
2. **Type sections that assume a ratio.** `loops/01-direction.md` §6 and `STYLES.md` treat a
   scale as something you write; neither offers the role-indexed branch that Material
   publishes and that the run independently needed.
3. **The baseline grid.** Referenced in `CRAFT.md`'s typographic craft table with no
   definition; now definable in one measurable sentence.
4. **Measure in tokens.** The run flagged `ch` as inexpressible in DTCG and parked a `rem`
   placeholder with a do-not-consume warning. The fix is a derivation, not a warning: compute
   the `rem` equivalent from the face's measured advance width and record the `ch` intent.

## 7. What is CRAFT here, and is labeled as such

- The 45–75ch working measure (80 is the sourced ceiling; the narrowing is consensus).
- Choosing a modular ratio, and which ratio — no primary source states one.
- Line-height as a function of measure as well as size (longer lines want more leading).
- Column count derivation for web.
- Tinted-neutral chroma in the 0.005–0.03 band — the *shape* of the rule is measured, the
  band is practice.

## 8. Still open

- **Apple has no published spacing scale or grid module** comparable to Material's. iOS layout
  guidance is margin- and safe-area-shaped, not column-shaped. Anything claiming an "Apple 8pt
  grid" is convention, not documentation — do not source it.
- **M3 type scale token values** (the per-role size/line-height/tracking numbers) render behind
  an expanding tree widget that did not yield to programmatic expansion this pass. The scale's
  *structure* is sourced above; its numbers are not, and should not be quoted until they are.
- **Whether other engines share Chromium's legacy-stop sRGB gradient behavior** — measured in
  Chromium 145 only. The instruction written from it (declare the space) is engine-independent,
  which is why it is the one that ships.
