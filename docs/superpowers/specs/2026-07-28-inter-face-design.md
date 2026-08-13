# inter.face — design

**Date:** 2026-08-01
**Revision:** v2 — rewritten after the four competitor audits and the first research run

> **Retraction notice, 2026-08-14.** Left unrevised as a dated record, but two figures below were
> later recounted. The **"six of seven audited skills"** tally is now four of five — see
> `docs/audit/competitor-small-skills.md` §6. The **"only 65 of 388 `STYLES.md` lines still
> match"** overlap figure counted blank lines, 53 of the 65; the non-blank overlap is 12, which is
> what `README.md` now prints. Both are recorded in README's Corrections section.
**Status:** architecture settled; content pending five research runs

A cross-agent design plugin: intent in, art direction out. It stops before code.

> **v1 → v2.** v1 was written from the three parent repos alone. It survived contact with
> the audits in outline and failed in five specifics, all corrected below and each marked
> **[v2]**. Two were outright bugs. Git holds v1.

---

## Why it exists

Three PIIIX pipelines each grew their own design system, and they have drifted:

| Doc | portfolio.me | webcrab | systemcicy |
|---|---|---|---|
| `STYLES.md` | 388 | 255 | — |
| `CRAFT.md` | 418 | 240 | — |
| `loops/02-design.md` | 188 | 258 | — |
| `INTERFACE.md` | — | — | 229 |

Only 65 of 388 `STYLES.md` lines still match between the first two. The drift is not decay
— each fork grew material the others lack. webcrab has a style *selection procedure* and a
category-cliché fence portfolio.me never got. portfolio.me has the deeper technique
arsenal. systemcicy is the only one that knows how to design a tool rather than a page.

**[v2] The same failure is visible in someone else's skills directory**, which is worth
citing in the README as evidence this is a general problem and not PIIIX housekeeping:
`imagegen-frontend-web` and `image-to-code` are the same file forked — 191 identical lines
— and have already diverged. The web fork grew composition anchors and a set-level
anti-repeat check; the code fork grew extraction rules and anti-drift. Neither has both.

---

## What it is

A design-only pipeline. Input is a filled translation table. Output is:

- `DIRECTION.md` — **[v2] at rendered-style resolution, not brief resolution** (see below)
- `tokens.json` — **[v2]** a machine-readable sibling in W3C DTCG format
- one design image per surface, at **[v2]** an aspect ratio keyed to surface class
- one runnable prototype per technique, with a measured frame rate and a ship / cut /
  ship-with-caveat verdict carrying **[v2]** an evidence label

It does not write the site. `DIRECTION.md` + `tokens.json` + images + prototypes handed to
a build step — a sibling pipeline's Loop 4, gstack's `/design-html`, a human, or another
agent — is the deliverable.

### [v2] `DIRECTION.md` resolution — the single most consequential correction

v1 said `DIRECTION.md` carries "the palette with sampled sources, the type system, the
technique assignment" without saying at what resolution. The audit answered it by
contrast.

A `STYLES.md` entry is a **brief** — glassmorphism in full is "translucent panels over a
substrate worth seeing through to… **Implies** `backdrop-filter`… **Fails** as gray
rectangles." Zero numbers. Every value still to be invented downstream.

`minimalist-ui` is a **rendered style** — `border: 1px solid #EAEAEA`, radius `8px` or
`12px`, padding `24px`–`40px`, body `#111111` at `line-height: 1.6`, and colors as *paired*
tokens (`#FDEBEC` background / `#9F2F2D` text) so an agent cannot pick a pastel and then
invent a foreground that fails contrast.

**The verdict: a single-style skill is the wrong unit for input and the right shape for
output.** Keep `STYLES.md` as the catalog — it does selection, collision, per-style failure
modes and per-style light/dark, none of which a single-style skill can do, and a shelf of
34 single-style skills would be 34 destinations. But `DIRECTION.md` must *read* like one.
A brief-resolution `DIRECTION.md` hands the build step the same invention problem the
pipeline just solved.

The pipeline is therefore: **34 briefs in → one collision picked → one rendered style out**,
a bespoke artifact that has never existed before.

---

## The spine: surfaces have a class

| | **Page-shaped** | **Tool-shaped** |
|---|---|---|
| Read for | seconds, once | hours, daily |
| Unit of design | section | screen |
| Density | whitespace is the luxury | rows-per-screen is the luxury |
| Delight is | the opening move | keystrokes removed |
| Input | pointer, scroll | keyboard first |
| States per surface | 3 render states | 9 data states |
| Failure mode | the category reflex | the generic admin template |
| Inherited from | portfolio.me, webcrab | systemcicy |

A product with a marketing site and an application is **two runs sharing a palette and a
type system**, not one run averaging them. The class is set per surface, not per project.

### [v2] Fork at every guidance leaf, not only the loop body

v1 forked only `loops/`. impeccable forks its equivalent axis (`brand` vs `product`
register) at *every* leaf — layout, typography, color, motion, and delight each open by
answering both cases before any other content. That is more thorough and costs nothing.
Adopt it: every reference file opens with its page-shaped and tool-shaped answer.

### [v2] Platform mode is a second, nested pre-decision

For any mobile surface, one question precedes the loop body, with three branches and a
bias list each: **iOS-native / Android-native / cross-platform-neutral**, and a closing
rule that they do not mix. This is the surface-class fork one level down. Recorded in
`DIRECTION.md`.

---

## Files

**[v2] Progressive disclosure, with a warning attached.**

```
AGENTS.md                    universal entry + the routing table. ALWAYS RESIDENT. Target <200 lines
PRINCIPLES.md                16 rules, 3 hard
TRANSLATE.md                 input contract: intent → design constraint
STYLES.md                    what it looks like — read on demand
CRAFT.md                     how it renders — read on demand
TOOLS.md                     tool-shaped surfaces — read on demand
SURFACES.md            [v2]  mobile, tablet, desktop platform law — read on demand
ACCESS.md              [v2]  accessibility as design-time decisions — read on demand
REDESIGN.md            [v2]  the brownfield path
BREAKING.md            [v2]  when a rule should be broken deliberately
loops/01-direction.md        palette, type, concepts, images        → Gate A
loops/02-craft.md            technique, prototypes, motion, budget  → Gate B
agents/surface-designer.md
agents/technique-prototyper.md
skills/inter.face/SKILL.md
commands/interface.md
+ 7 cross-agent adapters, README, LICENSE
```

impeccable's model: a 168-line always-resident router, then exactly one command reference
and one register file loaded on demand — under ~1,200 lines resident for a real
invocation. Match that ratio.

**The warning, from the same source.** impeccable de-composed into leaves and then
*re-composed* several back inline, noting that one extra file-read hop cost more than 500
extra resident lines. And gstack's own worst problem is the opposite failure: an 85-line
UX block inlined verbatim in four skills, plus ~800 lines of preamble before any design
content. Neither extreme. The rule: **loops route to reference files and never inline
them; a reference file that is only ever read by one loop gets folded into that loop.**

---

## The merge, decided

### `STYLES.md`

portfolio.me's seven families as the base. Merged in from webcrab: **"Picking one"** (a
five-input selection procedure, generalized from buyer/client to viewer/subject) and
**"Category clichés — the fence, not the field"** (nine categories × cliché × why it
persists × the opening), extended with tool-shaped and **[v2]** mobile rows.

**[v2] "Picking one" gets a better front half.** impeccable's departure mode derives
direction without touching a list at all, and explains why that matters:

> **Do NOT pick from a fixed catalog of lane categories.** Picking from a list is itself
> the training-data reflex — the model selects "Swiss-grid, Terminal, Industrial-signage"
> every time because those are the furthest-from-editorial items in any enumerated list.

Its procedure: personality words → **physical, spatial or material experiences that would
embody them if design were not involved** → three visual directions → a concreteness test
("a museum exhibition label system for a contemporary art gallery," not "clean and
minimal"; *if your sentence contains only adjectives it is not concrete enough*). That runs
*before* the five-input picker narrows anything.

**[v2] Paired color tokens** at definition time, so contrast is structural rather than
audited afterwards. **[v2] Style under density** per family — `industrial-brutalist-ui`'s
"bimodal density" is one worked answer, and `minimalist-ui`'s 24–40px padding and 1.6
line-height prove some styles simply cannot hold forty rows. That is a Gate A finding.

### `CRAFT.md`

portfolio.me's arsenal as the base. Merged from webcrab: **"Showing the product"** (eight
techniques, carrying its own hard rule — never fake a screen implying a feature that does
not exist), **"The cheap wins"** (ranked by return per byte), and **the three-question
commercial test**, which *supersedes* portfolio.me's one-question version rather than
sitting beside it — same test with the cost column filled in.

States are class-dependent: three render states page-shaped, nine data states tool-shaped.
A tool surface with heavy motion owes both sets.

**[v2] Kept from the audits:** the concentric radius rule (inner = outer − gap), grid
determinism (`display: grid; gap: 1px` with contrasting backgrounds for hairline rules that
never double at intersections), and `IntersectionObserver` never a scroll listener, with
the failure named.

### `TOOLS.md`

systemcicy's `INTERFACE.md` near-verbatim — thirteen sections, renumbered, with its three
reaches into systemcicy-specific docs cut. Plus a pointer back to `STYLES.md`, since its
version never asks what a tool should *look* like.

### [v2] `SURFACES.md` — new, no parent material

Mobile, tablet, and desktop platform law. Content pending research runs 2 and 4. Confirmed
so far: platform mode as a pre-decision; the **safe-area band rule** — every mobile surface
image shows or reserves four bands (status, title/nav, content, bottom-nav/home-indicator),
and a screen running edge-to-edge in all four directions has failed regardless of how it
looks; and **surfaces as an ordered path** for app flows — a surface with no inbound
transition is either the entry point or a mistake.

### [v2] `ACCESS.md` — new, and it is a structural change

The audit's central finding: across ~5,000 lines of the three parents there are **zero**
mentions of ARIA, focus management, live regions, or accessible names, while `§12` is
marked HARD. The cause is structural — accessibility in all three is a *verification*
concern. Every screen-reader mention is a post-build check. So the things that are
*designed* rather than *checked* are all absent.

**Accessibility therefore moves into Loop 1.** Confirmed design-time requirements from
research run 1, each a Loop 1 decision:

- **24×24 CSS px effective target area** (2.5.8 AA), satisfiable by size *or* by the
  geometric spacing exception — a token and layout decision
- **A visible non-drag pointer affordance** for every author-built drag (2.5.7 AA).
  Keyboard support does not satisfy it; the affordance occupies layout space
- **Sticky chrome geometry** that never entirely covers a focused element (2.4.11 AA)
- **Authentication** with no cognitive function test, never blocking paste or password
  managers (3.3.8 AA)
- Re-use of previously entered data (3.3.7 A) and consistently-placed help (3.2.6 A)

WCAG 2.2 AA is the operative target. WCAG 3.0 is a Working Draft (3 March 2026) that says
it has "several years of work" left and does not deprecate WCAG 2.

### `TRANSLATE.md`

Six rows: surface class · who is looking and what decision or task · the three-second feel
· archetype + shadow · anti-positioning · what is already owned.

**[v2] Row 3 gets gstack's sharper question** — "what is the one thing you want someone to
remember after they see this for the first time?", with its failure named: *design that
tries to be memorable for everything is memorable for nothing.*

**[v2] Every row must visibly change something downstream.** `stitch-design-taste` ships
four configurable dials of which exactly two are read by any rule — a parameter that
changes no output is a lie about configurability. If we cannot point at what a row derives,
the row is decoration.

**[v2] An escape hatch.** When the subject must use an existing design system — GOV.UK,
Material, a corporate DS — invention is the wrong answer. Detect it at row 6 and route to
conformance rather than to Loop 1.

### `PRINCIPLES.md`

Sixteen rules from portfolio.me's twenty-five: thirteen design rules (`§1–4`, `§7–10`,
`§12–14`, `§17`, `§22`), keyboard completeness from systemcicy, human gates from `§16`, and
skipping-with-recorded-cost from `§18`.

**Hard: accessibility, the two gates, [v2] and image-text honesty.**

**[v2] Bug fix — `§11` anti-slop prose comes back.** v1 dropped it reasoning "this plugin
writes no body copy." Wrong: every design image *renders text*, and an unconstrained image
model writes "Elevate your workflow" over a fake logo. The rule survives, re-aimed at image
text — realistic copy lengths, minimal text count, no invented brand names, no placeholder
superlatives.

**[v2] `§1` needs a check, not an instruction.** "Creativity is the baseline" is currently
an exhortation, and six of seven audited skills fail the identical way — two by instructing
the model to simulate a random number generator, which returns its prior with extra steps.
Attach the tests that work, both of which examine the artifact:

> **Swap test.** If someone could swap the headline text between two concepts without
> noticing, they are too similar.

> **Family pass.** Label each concept with a concrete noun of your own choosing
> (*exhibition, cockpit, playbill, field-manual*). If two share a label, or a label applies
> equally to another concept, rework. Do not use a fixed vocabulary for the labels.

**[v2] Amended catalog principle.** v1 said big lookup catalogs are the anti-pattern. The
`ui-ux-pro-max` audit tested that and narrowed it correctly: six of its seven advertised
numbers check out, and threshold tables and Do/Don't rule sets are fine at any scale. What
fails is **subject-indexed** retrieval — `"funeral home"` matched *Smart Home/IoT
Dashboard* on the token "home"; `"death metal record label"` matched nothing and silently
returned hardcoded `#2563EB`/Inter, indistinguishable from a hit. The rule is therefore
**no subject-indexed catalogs, and no silent fallback** — which keeps our own `STYLES.md`
legitimate, since it is keyed on visual family rather than on who the client is.

---

## The loops

```
Loop 1 DIRECTION ──► Gate A ──► Loop 2 CRAFT ──► Gate B
```

**Loop 1** — set surface class, then platform mode if mobile. Derive direction from
physical experience before touching the style list. Sample palette from reality in OKLCH.
Run the accessibility decisions above. Generate 2–3 concepts, each passing the swap test
and the family pass. Check against the cliché fence. **[v2]** Announce N before generating,
dispatch `surface-designer` one agent per surface, then run a **set-level anti-repeat
check** on what comes back — reject if the same composition anchor repeats more than twice
running, or if no full-bleed appears at all.

**Loop 2** — assign a technique per surface, each passing the three-question commercial
test. Dispatch `technique-prototyper`: standalone runnable HTML, screenshot, measured frame
rate under load, byte cost, all required states, and a verdict **[v2] carrying an evidence
label — TESTED, PARTIAL, or INFERRED. Never guess; state the evidence source for every
verdict.** Write the motion spec, declare both budget tiers, write `DIRECTION.md` and
`tokens.json`.

### [v2] Both gates carry an anti-shortcut clause

The precise way a "real stop" degrades into a paragraph, named by gstack:

> The plan file is the OUTPUT of the interactive review, not a substitute for it. Writing
> every finding into one document and calling it done is the failure mode.

If there is any non-trivial finding, the path to proceeding goes *through* the human.

### [v2] Rejections get priced

A deferred-decision table at each gate — decision needed | if deferred, what happens —
so `§18`'s "skipping is allowed, silent degradation is not" has a format that makes the
cost legible at skip time rather than in the final grade.

---

## [v2] Honest positioning

The audits changed what we can claim.

**Loop 1 is ~70% already built** inside gstack's `/design-consultation` and
`/design-shotgun`, and they are good — a served comparison board with structured
`feedback.json` beats a chat prompt as a gate. Shipping Loop 1 alone would be a
less-integrated `design-consultation` with a better style catalog.

**Loop 2 is the genuine product.** Nothing in gstack, in impeccable's 43,606 lines of
JavaScript, or in the six style skills builds a runnable proof of a technique, measures its
frame rate under load, prices it in bytes, and returns a verdict *before* the design
commits. Zero prior art anywhere in the corpus.

The other real additions: a style vocabulary with collision (34 entries with failure modes,
against `design-consultation`'s 10 adjectives); budget tiers declared at design time rather
than graded after; tool-shaped surfaces designed rather than classified; and portability —
plain markdown across seven agents, no Node app, no `~/.gstack`, no git preconditions.

**Where not to build:** a comparison board (`$D compare --serve` exists — accept its
`feedback.json` shape instead), a taste profile across runs, and competitive research
(`TRANSLATE.md` row 5 assumes it upstream).

---

## Out of scope

- Sync back to the three siblings. Their copies stay; this becomes canonical.
- A GitHub fork of portfolio.me. Fresh repo, README crediting all three parents.
- Building the site. The plugin stops at `DIRECTION.md` + `tokens.json`.
- **[v2]** State across runs. impeccable's scored critique trend is good and out of scope;
  we take a table in and write files out.

## Pending research

Content for `SURFACES.md`, `ACCESS.md` (parts 2–3), `BREAKING.md`, icons, design tokens,
and industry verticals is being researched now. Five runs outstanding. Nothing in the
architecture above depends on their outcome.
