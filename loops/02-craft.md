# Loop 2 — Craft

**Goal:** decide how the approved direction renders, prove it before anything is designed
around it, and write the handoff at a resolution that leaves the build step no aesthetic
decisions to make.

**Input:** the approved concept from Gate A, and `DIRECTION.md` as far as Loop 1 wrote it.

**Output:** `DIRECTION.md`, complete. `tokens.json` alongside it. One runnable prototype per
technique, each with a measured verdict. A signed Gate B.

**Timekeeping:** run `date` at each phase boundary and write it into the run ledger — a
subagent has no clock of its own.

```text
1 assign ──► 2 prototype ──► 3 motion ──► 4 budget ──► 5 DIRECTION.md ──► Gate B
technique     one agent      curves,      two tiers,   + 6 tokens.json     human
per surface   per technique  durations,   both with    at rendered-        decides
three-question evidence      stagger,     numbers      style resolution
test           labels        reduced state
```

---

## The fork

**Page-shaped** — read for seconds, once. A technique is evidence of capability and a carrier
of argument: three seconds to make a viewer understand something a paragraph would have taken
thirty seconds to say. The budget is a first-paint budget and the audience arrives cold on an
unknown device. This class owes `CRAFT.md`'s **three render states**.

**Tool-shaped** — read for hours, daily, by the same person. A technique is something the
operator pays for every day, and a scroll-linked reveal that delights once is a tax on the
four-hundredth repetition. The arsenal inverts: the heavy groups mostly cost and the
unglamorous ones mostly pay — grid determinism, information design, icon discipline, a
hairline that does not double. This class owes `TOOLS.md`'s **nine data states**, and `§15`
binds **[HARD]**.

A tool-shaped surface carrying heavy motion owes **both sets**. They are different axes, not
a longer list: render states answer *can this machine and this person's settings display it*,
data states answer *what is true of the data right now*. Cross them; do not concatenate them.

---

## 1. Assign a technique per surface

For each surface, assign a technique from [`CRAFT.md`](../CRAFT.md) that serves the style
already approved at Gate A. Style decides what is on the table; the technique executes it.
Reaching for a style because you want to use a shader is the tail wagging the dog and it
shows in the output.

**Every assignment passes `CRAFT.md`'s three-question test**, three answers, one line each:

1. What does this make the viewer **understand** about the subject or the product? *"It looks
   impressive"* — cut it.
2. Which **objection** does it answer, or which **proof** does it carry? None — demote it to a
   decorative layer with a stated byte budget.
3. What does it cost in **bytes and main-thread time**? Unknown — prototype it before it
   enters the design.

Tool-shaped reads question two as *which part of the operator's day does this make shorter*
and question three as *what does it cost on the four-hundredth repetition*.

A technique answering all three is worth building at any complexity. One answering none is
worth nothing at any complexity, and no gate grants an exemption.

**Spend the budget where the surface is decided.** Page-shaped: the opening, the moment the
product is shown, and the moment just before the ask. Tool-shaped: the two or three objects
the operator touches forty times a day, with the other thirty left quiet. Expression
everywhere is the same failure as restraint everywhere — a flat field with more noise in it.

## 2. Dispatch `technique-prototyper`

**One agent per technique.** Each researches it properly, builds a standalone runnable HTML
proof, screenshots it, measures frame rate under load, records the byte cost, and builds every
state the surface class owes. Free rein while prototyping — any library, any CDN, any
reference — and that freedom ends at handoff, where `§7` requires everything vendored.

**Report failure honestly. Failing cheap here is the entire point of the loop.** A technique
that fails prototyping does not reach Gate B: it is not proposed, not promised, and not built
anyway on the theory that it comes together in integration. Failing here costs one file and
twenty minutes. Failing in the build costs the surface, the layout designed around it, and
the copy written to fit.

### Verdicts carry an evidence label

Every verdict is **ship**, **cut**, or **ship-with-caveat**, and every verdict carries one of
three labels. **Never guess. State the source.**

| Label | What it means | What it looks like written down |
|---|---|---|
| **TESTED** | Measured, on a named machine, at a named viewport, with the number recorded | *"58fps sustained, 1440×900, M2 Air, 6× CPU throttle, 12k instances"* |
| **PARTIAL** | Measured, but not against what ships — one viewport, one machine, a stand-in for the real data, or fewer states than the class owes | *"61fps at desktop; phone not measured; reduced-motion state built, no-GPU state not"* |
| **INFERRED** | Not measured. From the library's documentation, a reference implementation, or reasoning | *"the library documents 60fps at 10k instances; not run here"* |

A frame rate measured on one machine at one viewport is not the same claim as one inferred,
and collapsing them is how a number that was always a guess arrives at the build wearing a
measurement's authority. **A `ship` verdict on an INFERRED frame rate is a proposal, not a
proof** — it goes to Gate B labeled as one, and the human decides whether to buy it.

## 3. Write the motion spec

Undocumented motion gets rebuilt three times, differently each time. Motion character comes
from `TRANSLATE.md` row 3 and row 4 — an institutional archetype moves slowly and inevitably,
a challenger moves abruptly — and the spec is what turns that sentence into numbers.

Written at the resolution §5 below demands, which for motion means:

- **Durations in ms.** Per interaction class, not one global number.
- **Easing as a named curve with its coefficients** — `cubic-bezier(0.16, 1, 0.3, 1)`, named
  once and referenced everywhere. "Smooth" is not an easing curve.
- **Stagger in ms, with a cap**, so a list of forty rows does not take eight seconds to
  arrive.
- **Exit shorter than enter.** A departure that takes as long as an arrival reads as lag.
- **What triggers what**, and the scroll mapping if there is one. `IntersectionObserver`,
  never a `scroll` listener — continuous reflow kills mobile performance and it is the most
  common motion bug in the corpus.
- **The reduced-motion state per technique**, art-directed. `§10` is **[HARD]** and this is
  the part of it most often faked: `animation: none` on a layout that assumed motion leaves
  elements at `opacity: 0` and sequences that never complete. `CRAFT.md` carries Apple's five
  techniques, and two of them — replacing z-axis transitions with fades, and not animating
  into and out of blurs — are exactly what nobody removes.

Two rules that do not fork: **nothing animates in above the fold** (it is already visible;
animating it makes it briefly not), and **motion never gates information**.

## 4. Declare both budget tiers

`§11` in practice, per `CRAFT.md`'s two-tier table, and both tiers carry a number at this gate.

- **Tier 1, shell** — HTML, critical CSS, subset fonts, minimal JS. **Under 100KB**, paints
  something real with no JS at all, **LCP under 1.5s**. If it fails, the run fails.
- **Tier 2, heavy** — rendering, GPU, post-processing, physics, generated imagery. **Declared
  per run, here, as a number.** Loads after first paint, gated on intersection, never in the
  LCP path. If it fails, the surface still works.

Measure on a throttled mid-range Android, not on the machine that built it. **A technique that
cannot be deferred has to justify its bytes at this gate**, in front of the human, against
what the surface is for. Usually the honest answer is the tier-1 technique that gets 80% of the
effect for 2% of the weight, and that is the largest group in `CRAFT.md`.

## 5. Write `DIRECTION.md`

**The test, and it is the whole point of this file:**

> **Could a build agent execute this without making a single aesthetic decision?**
>
> If no, it is still a brief.

This is the single most consequential correction from the audits. A handoff at brief
resolution — "generous spacing," "a warm neutral," "smooth transitions" — re-opens every
decision this pipeline just spent two loops making, and re-opens it in front of whoever picks
up the build. The images carry composition, proportion, mood, and where the eye lands. **Every
value a builder would otherwise have to measure off an image gets written down as a number.**

### The output schema

| Field | Written as | Not acceptable |
|---|---|---|
| **Concept and why it won** | Prose, with the rejected concept and its reason | — |
| **Collision or subversion** | One sentence, structural parent named. If a subversion: the broken rule, by name | "Inspired by" anything |
| **Surface class · platform mode** | `page-shaped` / `tool-shaped`; `iOS` / `Android` / `neutral` | Unstated |
| **Style-under-density line** | *At forty rows this does X* | Absent |
| **Palette** | Every token a **pair** — swatch plus legal foreground — in `oklch()` **and** hex, with the sampled source and the measured ratio, **per mode** | Color names. A lone hex. A swatch with no foreground |
| **Modes** | "One design in two palettes" or "two art directions", declared | Implied |
| **Type** | Families with the reason on the same line; **which kind of scale this is** — a ratio, stated and defended, or role-indexed with the roles named — and the computed value per step in rem either way; weights and variable axes; line-height per step; measure in ch | "A modern sans." A ratio with no computed steps. A ratio asserted over what are really roles |
| **Spacing** | Base unit, the token naming scheme, and every step that has a job — in px or rem. Absent steps are information, not omissions | "Generous." "Tight." An unbroken 4px ladder to 128 |
| **Radius** | Every step in px, plus the concentric rule in use — inner = outer − gap | "Rounded" |
| **Stroke and divider** | Weight per mode in px, and where hairlines come from grid gap rather than borders | "Subtle borders" |
| **Elevation** | The levels first, then how each is drawn — tonal, shadow, or scrim — with offset, blur, spread, and color per level per mode; which levels are resting and which are interaction-only. Or the statement that this direction has no shadow language | "Soft shadow." A shadow ramp that varies blur while the offset stays put |
| **Background and surface treatment** | Gradient stops in `oklch()` with the interpolation space declared — `in oklab` — and the angle or shape; scrim and overlay opacity as a number; grain or noise as amount, scale, and blend mode; the treatment applied in-browser to every generated image (`§8`) and every supplied photograph (`§14`) — duotone stops, halftone pitch, dither, crop, mask | "Atmospheric." A gradient with no stops. A generated image placed raw. "Subtle texture" |
| **Icons** | Source and licence, grid size, stroke weight, grade per mode, and the icon-size / target-size **pair** per input method | "Clean line icons" |
| **Grid and layout** | Columns, gutters, and margins per breakpoint, with the collapse order named — and the column count defended, since no system publishes one. Margins that keep growing past desktop are an invention; say so rather than implying a system | "Responsive" |
| **Navigation model** | The pattern, its keyboard contract, and its state at every breakpoint — plus, on a phone or tablet, which canonical shape this is and **how every author-built swipe resolves against the system's** (`SURFACES.md` §6–§8: back is negotiable inside a 200dp band, home is not negotiable at all) | "Standard nav." A horizontal swipe at a screen edge with no statement about system back |
| **Content presentation** | Card, list, table, or the invented one — with the per-item attribute positions fixed | "Card grid" |
| **Buttons and controls** | Shape, hierarchy, padding, and a token per state: default, hover, focus-visible, active, disabled, error, loading | Three of the seven states |
| **Per-surface technique** | Technique, its three-question answers, verdict, **evidence label**, byte cost | A verdict with no label |
| **Motion spec** | §3 above, in ms and named curves | "Smooth." "Snappy" |
| **Budgets** | Both tiers, both as numbers | One tier |
| **Accessibility** | The `ACCESS.md` Loop 1 answers, including the accessible name for every icon-only control **as the actual string** | "Follows WCAG" |
| **Composition log** | The anchor and background mode per surface, carried from Loop 1 | — |
| **What was invented** | The thing that exists in this run and no other (`§3`) | Absent |
| **SAFE / RISK split** | Carried from Gate A, with what each risk costs | — |
| **Broken rules** | The table below | Prose about liberties taken |
| **Deferred decisions** | The `§16` table: decision needed, if deferred what happens | Silence |

**Tool-shaped surfaces add `TOOLS.md` §13's nine** — the day per role with counts, the screen
inventory, key flows with all nine states, the keyboard map, the design system with its status
vocabulary and data formats, density decisions, mobile and field design, copy, and
accessibility notes. Those are in addition to every row above, not instead of it.

### The broken-rules table

`BREAKING.md`'s recording rule lands here. **A broken rule that is not written down is
indistinguishable from a mistake** — not similar to, indistinguishable, in the strict sense
that no property of the artifact separates them. So every break gets one row:

| rule broken | what it buys | what it costs | why the trade is honest here |
|---|---|---|---|
| `§11` shell budget — 2.4MB WebGL hero | The product is a real-time renderer; the hero is the demo | LCP 3.1s on the target mid-range Android; everyone below it gets the fallback | Capability is the whole claim, measured on device rather than assumed, and the fallback is art-directed and signed off |

Three properties of that row matter more than its format. **It is written when the break is
made**, not at the end — a retroactive rationale describes the result, and everybody can tell.
**The cost column cannot be "none"** — a break with no cost is a rule that was wrong, and the
honest move is to say so and fix the rule. **It names the rule by its number.**

Four rules are never breakable and never appear in this table: `§10`, `§15` on a tool-shaped
surface, `§16`, and `TRANSLATE.md` row 5. The line is consent, not magnitude.

### What faithful means

Close `DIRECTION.md` with the handoff clause, because the deliverable is the handoff. The goal
is not *inspired by* this direction; it is faithful to it. During the build: do not simplify
into default templates, do not replace a distinctive surface with a generic row, do not
compress the stated spacing, do not flatten the type hierarchy, do not merge surfaces into a
repeating pattern that was not in the design, and do not reintroduce nested boxes the design
removed. Where the design is genuinely ambiguous, preserve the visible design language,
then the spacing logic, then the component family — and ask before filling ambiguity with a
default.

## 6. Write `tokens.json`

`DIRECTION.md` is prose. `tokens.json` is its machine-readable sibling, so the build step
parses values instead of English.

**State the format's limits in the file's own `$description`, because they are real.**

- It is the **Design Tokens Community Group (DTCG) format**, and the plugin targets the
  **Community Group Draft of 30 July 2026**. It is **not** a W3C Recommendation and calling it
  "the W3C design token standard" is wrong in the same checkable way as any other fabricated
  citation. Pin the draft by date: the value shapes have already changed between drafts.
- **`dimension` is an object, not a string.** `{ "value": 16, "unit": "px" }` — and the unit
  set is **closed to `px` and `rem`**. No `em`, no `%`, no `pt`, no `dp`.
- **`duration` is likewise an object**, numeric value plus `"ms"` or `"s"`.
- **Therefore `tokens.json` is a web artifact.** Apple specifies in `pt`, Material in `dp` and
  `sp`, and **neither is expressible in a DTCG `dimension`**. Native numbers live in
  `DIRECTION.md` prose, or in `$extensions` where a tool will read them. Say the limit out loud
  rather than pretending one file serves four surfaces — a token file that silently rounds
  44pt to 44px has produced a wrong layout with a valid schema.
- **An object cannot be both a token and a group.** `color.brand` cannot hold a `$value` *and*
  contain `color.brand.hover`. That forces a naming decision now: `color.brand.base` and
  `color.brand.hover`, or a flat leaf.
- **Group by type, not by component**, so `$type` inherits from the nearest ancestor group and
  the file stays short.
- **The paired color token is a convention this plugin imposes**, not one the format enforces
  — DTCG has no pair type. Model it as a group of two color tokens with a `$description`
  binding them and the measured ratio recorded there.
- **One thing is not settled**: the `color` value shape in this draft — hex string versus a
  `colorSpace` plus components object — was not confirmed against the primary source. Write
  color values in the shape below and treat `DIRECTION.md` as authoritative for color until it
  is confirmed. Naming the gap is what stops a later reader from building on it.

The shape:

```json
{
  "color": {
    "$type": "color",
    "accent": {
      "base": { "$value": "#2F5D50", "$description": "sampled from the pressed foil on their 2019 catalogue" },
      "on-base": { "$value": "#F4F1EA", "$description": "pair for accent.base — measured 8.1:1 at body size" }
    }
  },
  "space": {
    "$type": "dimension",
    "3": { "$value": { "value": 12, "unit": "px" } },
    "4": { "$value": { "value": 16, "unit": "px" } }
  },
  "motion": {
    "duration": {
      "$type": "duration",
      "enter": { "$value": { "value": 240, "unit": "ms" } },
      "exit": { "$value": { "value": 160, "unit": "ms" } }
    },
    "easing": {
      "$type": "cubicBezier",
      "settle": { "$value": [0.16, 1, 0.3, 1] }
    },
    "transition": {
      "$type": "transition",
      "enter": {
        "$value": {
          "duration": "{motion.duration.enter}",
          "delay": { "value": 0, "unit": "ms" },
          "timingFunction": "{motion.easing.settle}"
        },
        "$description": "list and card entrance; stagger 40ms, capped at 8 items"
      }
    }
  }
}
```

The motion spec becomes those `transition` tokens, aliased into the duration and easing groups
rather than duplicating either — which is the first time in this family of pipelines a motion
spec has been machine-readable rather than prose that gets rebuilt three times. Aliasing
resolves into composites, so one easing curve is defined once and referenced by every
transition that uses it.

---

> ## Gate B — human decision. `§16` **[HARD]**
>
> **Presented:**
>
> - **The prototype screenshots**, including the ones that failed
> - **Every verdict with its evidence label** — TESTED, PARTIAL, or INFERRED — and the machine
>   and viewport behind any measured number
> - **The motion spec**, in ms and named curves, with the reduced-motion still frame shown
> - **Both budget tiers**, both as numbers
> - **The broken-rules table**, if there is anything in it
> - **`DIRECTION.md` and `tokens.json`**, against the test in §5 above
>
> **The anti-shortcut clause.** The written output is the OUTPUT of this review, not a
> substitute for it. If there is any non-trivial finding, the path to proceeding goes through
> the human. This is the last stop before real code, and a gate that becomes a document
> somebody reads later has been removed rather than satisfied.
>
> **They approve the technique set, or cut what does not earn its place.** Cutting with
> nothing in its place is a valid outcome: the surface ships in its base state and the budget
> improves.
>
> **Deferrals get priced, in a table:**
>
> | decision needed | if deferred, what happens |
> |---|---|
> | Prototype skipped for the signature technique | The design commits to something nobody has run; the failure moves from twenty minutes to a rebuild |
> | `tokens.json` not written | The build step reads values out of prose, and the first transcription error is silent |
> | Tier-2 budget left undeclared | The heavy layer sizes itself, and the number is discovered on a mid-range Android after launch |
> | Motion spec left as prose | Motion gets rebuilt three times, differently each time |
> | Reduced-motion still not art-directed | `animation: none` on a layout that assumed motion — elements at `opacity: 0`, sequences that never complete |
> | Dark mode left as an inversion | A settings toggle shipped as a design. Half a tool-shaped audience will only ever see it |

---

## When Gate B rejects

Cut the technique, or swap it for another from `CRAFT.md`, then re-prototype. **A rejected
prototype is never argued into acceptance, tuned during the build, or carried forward on the
theory that it comes together in integration.** The replacement faces the same three-question
test the original faced.

If the rejection is not about a technique at all — if what the human is reacting to is the
direction rather than its execution — that is a Gate A finding arriving late. Send it back to
Loop 1 rather than swapping techniques until the direction accidentally changes.

**Record what the rejection revealed** in `DIRECTION.md`, alongside the new direction. What
they reacted against, and what that says about the viewer, the risk appetite, or the archetype
that `TRANSLATE.md` failed to capture. Recording only the correction throws away the more
valuable half.

**Three rejections at the same gate means the translation table is wrong, not the work.** The
same rule as Gate A, and the same remedy: stop iterating, fix the row, come back.

## Skip costs

| Skipping | Costs |
|---|---|
| §1's three-question test | Techniques that are impressive and irrelevant, which on any surface is attention the working part needed |
| §2's prototypes | Proof the technique works before the design depends on it. The same failure in the build costs the surface and the layout around it |
| The evidence labels | The distinction between a measured number and a guessed one, permanently — nobody can recover it later |
| §3's motion spec | Motion rebuilt three times, differently each time |
| §4's tier-2 number | The heavy layer sizes itself |
| §5's resolution | Every aesthetic decision this pipeline made gets re-made by the build step, from an image |
| §6's `tokens.json` | Machine-readable values. The build step transcribes by hand, and transcription errors are silent |
| Gate B | Motion review, budget review, and the last human stop before code |
