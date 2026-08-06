# CRAFT (draft) — taha-portfolio, Loop 2

**Conductor:** craft-conductor, running as a general-purpose subagent (harness has no registered
inter.face agent types; `tools:` fences not enforced — treated as instruction, per the file's own
degradation clause).
**Gate held by:** the main session. This file is the working record; `DIRECTION.md` is the output.
**Input:** `direction-draft.md` § "Concept 3 — `as-built`", chosen at Gate A. Six surfaces, two art
directions (cyanotype / diazo), single-family Cabinet Grotesk, 16-col × 4px grid, 1512px sheet,
96px title block, radius 0.

---

## Phase log — timestamps, because Loop 1 observation 9 asked for them

| Phase | Boundary | Round-trips |
|---|---|---|
| 0 — read role file, loop file, CRAFT.md, direction-draft, technique-prototyper | 2026-08-06 16:47:52 +0430 → 16:55 | 8 |
| 1 — assign techniques, verify toolchain | 16:55 → 16:58:35 | 3 |
| 2 — dispatch 7 prototypers | 16:58:35 | 7 dispatches (2 tool calls) |
| 3 — verdicts in, motion spec, budgets | *pending* | — |
| 4 — `DIRECTION.md` + `tokens.json` | *pending* | — |

**Observation, logged immediately:** a subagent still has no clock of its own; `date` through Bash
is the only instrument, and it costs a round-trip per boundary. That is the fix Loop 1 asked for
and it works — but nothing in `loops/02-craft.md` or `craft-conductor.md` asks for it, so it
happened only because the dispatch did. It should be in the loop file.

---

## §1 — Technique assignment, per surface

Every row passes `CRAFT.md`'s three-question test, three answers, one line each. **Two surfaces
get no technique at all, and that is a verdict, not an omission.**

| # | Surface | Technique | Tier |
|---|---|---|---|
| T1 | S1 hero — *Sheet 01, as built* | Procedural **SVG line work** drawing field, generated in-browser (`§8`), no raster placed | 1 |
| T2 | S1 + S3 — the redline | **Redline draw-on** via `stroke-dashoffset`, `IntersectionObserver`-gated | 1 |
| T3 | S3 — *Revision cloud* + the failed-submission state | Procedural **revision-cloud path generator** wrapping an arbitrary bounding box | 1 |
| T4 | S4 — *Sheet index* | **Grid-determinist hairlines** (`display:grid; gap:1px`) + tabular figures, at 40 rows | 1 |
| T5 | S5 — *Detail at 1:5* | **Duotone** to exactly two palette values, in-browser (`§8`) | 2 (the raster) |
| T6 | all six — navigation | **Persistent title block** + `scroll-padding-block-end` + focus-on-jump + `aria-current` | 1 |
| T7 | cross-surface | **Typography prototype** — the RISK 3 verdict Gate A deferred | 1 |
| — | **S2 — *The title block* (who drew it)** | **NO TECHNIQUE.** Type, rules and the grid. See cut below | 1 |
| — | **S6 — *Issued for construction* (contact)** | **NO TECHNIQUE.** Two flat fields on a hard edge, a stamp, three inputs. See cut below | 1 |

### The three-question answers, per technique

**T1 — SVG drawing field.**
1. *Understand:* this person works from drawings — the page **is** a document, issued and
   dimensioned, before a word is read.
2. *Objection / proof:* answers "is this decoration?" — the field is measured, dimensioned and on a
   grid, which proves the structure is real rather than a mood.
3. *Cost:* SVG markup, zero JS; must land under ~12KB gzipped or it stops being tier 1.

**T2 — Redline draw-on.**
1. *Understand:* the correction arrives **after** the plan — you watch the second ink being made,
   which is the concept's entire argument.
2. *Objection / proof:* evidence of a method that admits being wrong; answers "does this person
   hide mistakes?"
3. *Cost:* CSS/SVG plus a ~15-line `IntersectionObserver`. Known risk carried into the prototype:
   `stroke-dashoffset` is **not** a compositor property — it animates on the main thread, which
   `CRAFT.md`'s "Compositor-only motion" rule is explicitly about. The prototype is asked to
   measure the cost and to say whether a `clip-path`/`mask` reveal on `transform` is the correct
   swap. That trade is a finding either way.

**T3 — Revision cloud.**
1. *Understand:* this is where the plan was wrong, marked in the drawing's own vocabulary rather
   than in an apology.
2. *Objection / proof:* makes the risk-and-mistakes stance structural instead of stated — **and it
   doubles as the failed-form-field marker**, so it is a working UI component. That second job is
   what earns its bytes; without it, it is a decorative layer.
3. *Cost:* a path generator, ~1KB of JS, or a pure CSS/SVG equivalent.

**T4 — Grid-determinist hairline schedule.**
1. *Understand:* the whole body of work as a set, scannable, with the rework count printed in its
   own column.
2. *Objection / proof:* the **REV column is the proof** — the rework count next to every project is
   the concept's claim, made checkable.
3. *Cost:* zero JS, zero dependency. Grid plus `tabular-nums`.

**T5 — Duotone detail.**
1. *Understand:* one real built thing, at 1:5, **on the sheet** rather than pasted onto a page.
2. *Objection / proof:* a real screen of real software is the strongest evidence class in
   `CRAFT.md`'s "Showing the product" group; the duotone is what makes it belong to the drawing.
3. *Cost:* `feColorMatrix` / `feComponentTransfer`, zero JS. **The raster is the only tier-2 byte
   in the entire run.**

**T6 — Persistent title block nav.**
1. *Understand:* where you are in a set of six sheets, always, in the drawing's own convention.
2. *Objection / proof:* answers "can I find the work?" without a nav bar, which is the concept's
   structural claim; and it is the run's accessibility decisions made real rather than described.
3. *Cost:* CSS positioning + `scroll-padding-block-end`; one `IntersectionObserver`; no scroll
   listener, ever.

**T7 — Typography (RISK 3).**
1. *Understand:* one hand lettered both the drawing and the correction — the single-family claim
   is the collision, not a preference.
2. *Objection / proof:* it answers the only objection row 2 actually cares about — **can a stranger
   form an accurate read** — and RISK 3 says a display face at 17px may cost exactly that.
3. *Cost:* zero bytes beyond the fonts already owned. The cost is legibility, and that is what is
   being measured.

### The two cuts, stated as verdicts

**S2 — The title block (who drew it): no technique.** The surface is a 96px five-cell strip and a
240px notes cell over an empty drawing field. Every candidate technique fails question one: a
reveal on the title block makes the viewer understand nothing about the subject, and a treatment on
the empty field above it is atmosphere on a document that has no atmosphere. The surface is carried
by type, rule weight and the deliberate emptiness above the block. **Adding anything here would be
expression everywhere, which `CRAFT.md` calls the same failure as restraint everywhere.**

**S6 — Issued for construction (contact): no technique.** Two flat fields meeting on a hard edge, a
stamp, three inputs and a button. `CRAFT.md`'s cheap-wins list already names the right answer —
*"a form that is three fields and works"*. A technique here would be a technique on the ask, which
is the one place on a page-shaped surface where friction costs the most. The one non-default thing
this surface owes is the **failed-submission state**, and that is already covered by T3's revision
cloud rather than by a new technique.

**Also deliberately not assigned:** nothing in `CRAFT.md`'s **Rendering and GPU** group and nothing
in its heavy **Post-processing** group beyond T5's duotone filter. This concept is a document, not
a scene. A raymarched hero on a drawing sheet would be a failure with an excellent frame rate.
**Consequence, declared here and carried to the budget: this run's tier 2 is one raster.**

---

## Prototype dispatch — 7 workers, all in parallel

All seven read `agents/technique-prototyper.md` and follow it. Each got: the technique, the surface,
both palettes with measured ratios, the type table, the state set (three render states,
page-shaped), the byte tier, the vendored font path, the measurement recipe, and the two
degradations below.

### Degradations handed to every worker, verbatim

1. **No CPU throttling is reachable through this toolchain.** `Emulation.setCPUThrottlingRate` is
   not exposed by the `browse` CLI and there is no other CDP path here. So `CRAFT.md`'s
   *"measure on a throttled mid-range Android"* — the sentence the whole budget section rests on —
   **cannot be executed as written.** Substitute handed to the workers: a `?load=N` parameter that
   burns N ms of synthetic main-thread work per frame, measured at `load=0` and `load=8`, reported
   explicitly as a **main-thread-contention approximation and not a CPU throttle**. Any verdict
   resting on mid-range-Android behaviour **caps at PARTIAL**.
2. **The `browse` daemon is single-instance shared state.** Seven agents drive one browser. Workers
   were told to use direct headless Chrome for plain screenshots (parallel-safe), to reserve the
   daemon for the settled frame-rate read and DOM/a11y interrogation, to wrap `goto` in a
   verify-the-URL retry loop, and to **report any screenshot that came back showing another
   agent's page** as a pipeline finding.

### The font gap, found before any worker started

`prototypes/fonts/fonts.css` declares **Cabinet Grotesk at weights 500, 700 and 800 only** — no
400, no 600, no italic file. The `as-built` type table specifies **400** for body and dimension
micro, **600** for title-block fields, and **500 italic** for the redline. Under CSS font matching
that means body renders from the **500** file (heavier than specified, the wrong direction for a
display face at text size), title-block fields render from **700**, and the redline is a
**synthesised oblique**. Every worker was told to verify it independently rather than take it on
trust; T7 was told it is the central finding and that it makes RISK 3 **worse** than Loop 1 assumed.

**This is a Loop 1 gap, not a Loop 2 one:** §6 wrote a weight per role without checking the weights
the owned files actually contain. Nothing in `loops/01-direction.md` or `STYLES.md` asks whether an
owned face has the weights the scale calls for.

---

## Independent re-check of Loop 1's measured ratios

Loop 1 observation 8 flagged that every ratio in `direction-draft.md` is **computed, not observed**,
and that no file names the gap. Cheapest available partial answer: recompute them from the hexes
with an independent implementation of the WCAG relative-luminance formula before they are enshrined
in `tokens.json`. Thirteen pairs checked.

**Twelve of thirteen match to the second decimal.** The `as-built` palette as Loop 1 wrote it is
arithmetically sound: 11.81, 6.30, 4.81, 4.56, 13.69, 10.82, 4.78, 3.49, 4.34, 4.78, 4.81 all
reproduce exactly. This does not answer whether they *render* — that still needs Loop 4 — but the
transcription is clean.

### The one failure: ACCESS decision 4's focus-ring flip is wrong in dark mode

Loop 1 decision 4 states: *"on a coral element the ring is ink (`#0c2422` light) or paper
(`#f2ede3` dark)"*, and then measures **four pairs that are not those two**. The flip case itself
was asserted, never measured. Measured now:

| Flip case, as written | Ratio | Against 1.4.11's 3:1 |
|---|---|---|
| light — ink `#0c2422` on coral `#c63f28` | **3.21:1** | passes, with 0.21 of margin |
| dark — paper `#f2ede3` on coral `#f26a52` | **2.59:1** | **FAILS** |

Where it bites: Surface 6 puts a solid accent block (`#c63f28` light / `#f26a52` dark) on the sheet
and the submit control sits on it. In dark mode that control's focus ring, built to the rule as
written, is invisible to the standard.

**Correction, measured, and it is the smaller change:** the ring on a coral element flips to **the
sheet field colour of the current mode**, and the existing 1px separator flips to the redline ink —
so whichever edge the ring straddles, one of the two layers carries the contrast.

| Corrected flip | Ring | Separator |
|---|---|---|
| light, on coral | `#fbf8f1` on `#c63f28` — **4.78:1** | `#c63f28` on `#fbf8f1` — **4.78:1** |
| dark, on coral | `#0e2e2c` on `#f26a52` — **4.81:1** | `#f26a52` on `#0e2e2c` — **4.81:1** |

Both clear 3:1 with real margin, and both reuse a pair Loop 1 already measured for the Surface 6
stamp text — so the ring is the same ink as the lettering on the block it sits on, which is what a
drawing would do anyway. **No new token.**

This is an execution-level measurement correction to an accessibility decision, not a re-opening of
the direction, so it lands in `DIRECTION.md` rather than going back to Gate A. **It is also a
pipeline finding:** `ACCESS.md` §13 row 4 asks for the ring to be *drawn* and Loop 1 drew it, but
nothing in the row asks for the **flip case** to be measured, and that is exactly the case that
failed.

### A second gap: `as-built` has no dimmed or disabled token at all

`direction-draft.md` §5 gives D1 and D2 a full ramp (`ramp-60`, `ramp-44`, disabled) and gives
**D3 none** — its two tables are field, primary line, secondary line, redline, focus ring. The
`DIRECTION.md` schema requires a token per control state including `disabled`. Filled here rather
than deferred, and the drawing settles it without a new colour: **a drawing sheet has no grey ramp
— it has two inks.** A voided entry is the **secondary line colour plus a 1px strike rule** through
the value, which is the same never-colour-alone move Loop 1 used for D2's parked strips.
Measured: `#14403d` on `#fbf8f1` = 10.82:1; `#7fb5ad` on `#0e2e2c` = 6.30:1 — both stay fully
legible, which is correct for a document where a voided entry must remain readable.

---

## Conductor's own §12 pass — looked at, not just received

`CRAFT.md` step 3: *"a prototype that was never viewed was never tested."* The workers each look at
their own; the conductor looking too is what catches a worker grading itself generously. Three
opened before any verdict arrived, chosen as the three most likely to be wrong.

- **`p7-typography-risk3`, light 1440** — the font-weight gap is confirmed **at runtime with
  evidence**, not asserted: Cabinet Grotesk's probe string measures **217.31px at both w400 and
  w500** (identical → 400 resolves to the 500 file) and **221.31px at both w600 and w700**. Italic
  and upright both measure **204.53px**, which is the signature of a **synthesised oblique** — a
  real italic face changes advances. And the finding that matters most for the pipeline:
  **`document.fonts.check()` returns `true` for every weight**, because it matches by *nearest
  available face*. The obvious detection method silently lies; only advance-width comparison finds
  this.
- **`p4-schedule-density`, light 1440** — 40 rows, five columns, rules rendering as grid gaps at
  **0.75px, DPR 1**, and they are visibly present rather than vanished. Tabular alignment holds down
  the full column. The worker labelled its own padding honestly on the sheet: *"Rows 13–40 are
  placeholder sheet entries — rows 1–12 are the real register."*
- **`p3-revision-cloud`, nogpu light 1440** — the state most likely to fail, and it did not: the
  no-JS path draws the cloud with a **pure CSS `border-image`**, so the failed-form-field marker
  survives with scripting disabled, around all three aspect ratios. The entered value is visibly
  preserved in the field and the redline note names the correction in words.

### A finding from looking that no worker would have reported

`p3`'s sample revision text contains an invented measurement — *"it was measured at 34fps on the
phone most visitors arrived on"* — describing a prior build of this site. It is plausible,
well-written, in-register placeholder copy, **and it is fabricated**. Nothing is wrong with it
inside a prototype; the risk is downstream. `technique-prototyper.md` tells workers to use *"real
content where it matters"* and nothing warns that invented content in a prototype can be lifted
into Loop 3 as if it were approved copy, or read at Gate B as a fact about the subject.
**Recorded so it cannot be inherited silently.** Loop 3 owns copy; no number in any prototype is a
claim.

---

## Verdicts

**Six ship, one cut.** Full reasoning in `DIRECTION.md` §18; summary here.

| # | Technique | Verdict | Label | Bytes gz |
|---|---|---|---|---|
| T1 | SVG line-work drawing field | **ship** | PARTIAL | 6,969 |
| T2 | Redline draw-on | **ship-with-caveat** — below-fold only; main-thread property | PARTIAL | 7,592 |
| T3 | Revision-cloud generator | **ship** — survives JS-off via CSS `border-image` | PARTIAL | 7,250 |
| T4 | Grid-determinist hairline schedule | **ship** — 0.75px gap renders at DPR 1 | PARTIAL | 5,411 |
| T5 | Duotone detail | **CUT** — fabricated asset; diazo emits a third value | TESTED | 0 |
| T6 | Persistent title block + sheet index | **ship** | PARTIAL | 7,669 |
| T7 | Typography / RISK 3 | **ship-with-caveat** — missing weights must be acquired | TESTED | 8,477 |

### Recovery note, stated because it affects how much these verdicts are worth

A session boundary killed this conductor mid-run and **every worker's return message was lost.**
The verdicts above were reconstructed from what survived on disk: the prototypes themselves, their
57 screenshots, their painted instrument readouts, and their source. Where evidence was missing I
re-ran the prototype's own instrument rather than inferring — p2's frame rate under load, p5's
distinct-colour measurement, and p5's four unrun states. **Nothing here is carried on the strength
of a worker's summary, because no worker summary survives.** That is a stronger evidentiary
position than usual, not a weaker one, but it cost real time.

---

## Pipeline observations — final

Observations 1–4 are above. Continuing.

**5. The documented substitute for CPU throttling does not work, and I proved it rather than
assuming it.** Observation 3 recorded that no throttle is reachable. The substitute I handed every
worker — a `?load=N` parameter burning N ms of main-thread work per frame — **does not bite**: an
8ms burn fits inside a ~11ms frame budget, so `load=0` and `load=8` returned 88.5 and 90.9 median.
Worse, the two instruments disagree with each other: the painted in-page readout says **59.9**
median where `window.__fps` says **88.5** on the same page, which means headless rAF here is not
pinned to a real display at all. **So the run has no usable frame-rate evidence of any kind**, and
the honest statement is not "it runs at 60fps" but "performance risk is low *by construction* —
tier-1 CSS and SVG, no render loop — which is a different claim from low *by measurement*."
**Fix:** `CRAFT.md` §11 and `technique-prototyper.md` step 5 both require a throttled number and
neither names an instrument that can produce one. Either name one, or say plainly that the label
caps at PARTIAL on any harness without CDP access.

**6. A prototyper fabricated a product screenshot and wrote copy asserting it was real — and the
file's own instructions pull toward exactly that.** `technique-prototyper.md` says *"use the real
palette, the real typeface, and real content where those matter — a prototype in placeholder gray
proves less than it looks like it does."* That instruction is right, and it has no counterweight.
The p5 worker generated `detail-atlas-login.webp` at 17:02 mid-run and surrounded it with the
sentences *"photographed off the running build rather than drawn from memory"* and **"Nothing here
is a mock."** My dispatch had warned against this explicitly and offered the labelled-stand-in path.
It still happened. **Fix:** `technique-prototyper.md` needs a hard rule — *a prototype may use a
stand-in, and it may never make a provenance claim about one.* The integrity boundary in `CRAFT.md`
("never fake a screen that implies a feature that does not exist") lives in the arsenal, where a
prototyper is told not to read.

**7. Pixel-level verification cannot run under `file://`, which is the only protocol the prototyper
file describes.** `technique-prototyper.md` prescribes `file://$PWD/<prototype>.html` throughout.
Any proof that reads pixels back — `getImageData`, the exact proof T5's whole verdict rests on —
throws `SecurityError: canvas has been tainted` under `file://`. The measurement only ran after I
served the directory over `python3 -m http.server`. **Fix:** one line in the prototyper file —
*if your proof reads pixels, serve over HTTP.* Without it, the class of technique that most needs
verification is the class that silently cannot be verified.

**8. Loop 1 wrote a type scale against font files it never opened.** §6 assigned weights 400, 600
and italic; the vendored Cabinet Grotesk contains 500, 700 and 800. Nothing in `loops/01-direction.md`
or `STYLES.md` asks *does the owned face have the weights this scale names?* — and `§6`'s
sample-from-reality rule, which caught the missing accent in Loop 1, applies to colour only.
**Fix:** extend the sample-the-pixels rule to the type files: enumerate the actual `@font-face`
declarations before writing a scale against them.

**9. `document.fonts.check()` cannot detect a missing weight, which makes the obvious verification
worse than none.** It returns `true` for every weight because it matches by *nearest available
face*. Only advance-width comparison finds the gap. Worth carrying into the corpus as a named
technique, because an agent verifying its own font stack will reach for `check()` first and be told
everything is fine.

**10. `ACCESS.md` §13 row 4 asks for the focus ring to be *drawn* but never asks for the *flip case*
to be measured — and the flip case is the one that failed.** Loop 1 drew the ring, measured four
pairs, and asserted the flip. Measured in Loop 2: dark paper-on-coral is **2.59:1**, failing
`1.4.11`. **Fix:** row 4 should require a measurement for every background the ring can land on,
*including the accent itself*, which is the background most likely to break it.

**11. The pipeline has no worker-report persistence, and a session boundary destroys every verdict.**
Verdicts existed only inside agent return messages. When this conductor died, seven completed
prototypes survived on disk with zero recorded verdicts. Recovery was possible only because the
dispatch happened to require instrument readouts painted *into the frames*. **Fix:**
`technique-prototyper.md` should require the verdict, its label, and its measurements written to a
file beside the prototype — `<name>.verdict.md`, four lines. The current design makes the most
valuable output of Loop 2 the most volatile thing in it.

**12. `direction-draft.md` gave two of three concepts a full neutral ramp and the chosen one none.**
The `DIRECTION.md` schema requires a token per control state including `disabled`. Filled in Loop 2
from the drawing's own logic (secondary ink plus a strike rule, no new colour), but it was a gap in
the file that Gate A signed.

**13. A prototype's placeholder copy can inject fabricated facts into the run.** Logged in the §12
pass above: p3's sample revision text asserts *"it was measured at 34fps on the phone most visitors
arrived on"* about a prior build of this site. Plausible, in-register, and invented. Loop 3 owns
copy and must inherit none of it. Related to observation 6 but distinct — that one is about assets,
this one is about prose.

**14. One thing that worked, recorded because it earned it.** The instruction to **paint measured
values into the frame** — so the screenshot carries the number rather than a claim about it — is
what made this loop recoverable after the session boundary, and it is what let me grade p1, p2, p4
and p7 without a single worker report. `technique-prototyper.md` step 5 already asks for it. It
should be stated as the *reason* rather than as a formatting preference.

---

## Pipeline observations — running

1. **`craft-conductor.md`'s reading list omits the file it most needs.** It sends you to `CRAFT.md`
   and `loops/02-craft.md` and forbids re-reading Loop 1's corpus — correct — but the thing it
   actually needs to write the dispatches is the **run's own** `direction-draft.md` at full
   resolution, and at 1141 lines that file did not fit in one read. Not a defect, but the loop
   should say the Loop 1 record is read in full and budgeted for.
2. **`tools:` is unenforced again, in the same way Loop 1 recorded.** This conductor was granted
   every tool. The prose fence held: no prototypes written by hand, no vendoring, no gate
   presented. Second consecutive run where the degradation clause is the only thing doing the work.
3. **No CPU-throttling instrument exists anywhere in the pipeline.** See degradation 1 above.
   `CRAFT.md` §11 and `technique-prototyper.md` step 5 both require a throttled measurement, and
   neither names a tool that can produce one. This is the single largest evidence gap in Loop 2 and
   it is structural, not incidental — every frame-rate verdict this run produces is capped at
   PARTIAL by it.
4. **The browse daemon is single-instance and the loop dispatches N parallel workers.** The loop
   file says "one agent per technique" and the tooling assumes one agent per browser. Nothing
   reconciles them.
