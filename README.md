# inter.face

Art direction for any interface. A six-row translation table in; a fully specified design
direction out. Plain markdown, portable across seven coding agents. It stops before code.

## What it is, and what it is not

A design-only pipeline. The deliverable is:

- **`DIRECTION.md`** — the direction at rendered-style resolution: named values, not adjectives,
  so a build agent makes no aesthetic decisions
- **`tokens.json`** — its machine-readable sibling, in the Design Tokens Community Group (DTCG)
  format
- **one comp per surface, per concept** — a **coded comp** by default: real hexes, real faces,
  real spacing, written as a spec block the human reads on a rendered board. **Image generation
  is the opt-in mode**, at an aspect ratio keyed to the surface class, taken when the reviewer
  wants imagery or the build target needs it
- **one prototype per technique** — standalone runnable HTML that is *required* to measure its
  own frame rate under load, priced in bytes, with all required states and a ship / cut /
  ship-with-caveat verdict. The verdict carries the label its evidence earned: TESTED when the
  number came back under a real throttle, PARTIAL when it was measured against something other
  than what ships, INFERRED when it was not measured at all. An instrument that fails caps the
  label and says why; it never rounds up into a number

Two human gates, both hard under [`PRINCIPLES.md`](./PRINCIPLES.md) `§16` — that file holds the
sixteen numbered rules, and a bare `§N` here and throughout the corpus means one of them, while
sections of any other file are named with their file, as in `AGENTS.md` §3. **Gate A** is where
the human picks the concept; **Gate B** is where the human approves or cuts the technique set.
The written output is the output of an interactive review, not a substitute for one.

It does not build the site, the app, or the component. The package hands off to whatever comes
next — a sibling pipeline's build loop, gstack's `/design-html`, a human, or another agent.

## Why it exists

Three PIIIX pipelines — [portfolio.me](https://github.com/PIIIX-org), webcrab, and systemcicy,
the parents of this plugin — each grew their own design system, and they drifted:

| Doc | portfolio.me | webcrab | systemcicy |
|---|---|---|---|
| `STYLES.md` | 388 | 255 | — |
| `CRAFT.md` | 418 | 240 | — |
| `loops/02-design.md` | 188 | 258 | — |
| `INTERFACE.md` | — | — | 229 |

Only **12** of portfolio.me's 324 non-blank `STYLES.md` lines still appear anywhere in webcrab's
202. The drift is not decay — each fork grew material the others lack. webcrab has a style
selection procedure and a category-cliché fence portfolio.me never got; portfolio.me has the
deeper technique arsenal; systemcicy is the only one that knows how to design a tool rather than
a page. inter.face is the union of their design halves, made canonical. Full lineage in the
[design spec](./docs/superpowers/specs/2026-07-28-inter-face-design.md), which prints an older,
different figure for that overlap — see [Corrections](#corrections).

This is a general failure of design guidance kept as prose, not PIIIX housekeeping. The
[imagegen audit](./docs/audit/competitor-imagegen.md) found the same thing in someone else's
skills directory: `imagegen-frontend-web` and `image-to-code` are the same file forked — **191**
non-blank lines still literally identical — and each fork has since grown what the other lacks.
The web fork gained composition anchors and a set-level anti-repeat check; the code fork gained
extraction rules and anti-drift. Neither got the other's additions.

## What is genuinely new — and what is not

**New:** nothing in the surveyed landscape (four competitor audits, in
[`docs/audit/`](./docs/audit/competitor-impeccable.md)) builds a runnable proof of a design
technique, requires it to measure its own frame rate under load, prices it in bytes, and returns
a verdict *before* the design commits. That is Loop 2, and it is the product. The demand for the
measurement is unconditional; the number coming back is not. Where the instrument fails, the
verdict says so and the evidence label caps at PARTIAL or INFERRED — the first real run is that
case, and it is the third finding in the run section below.

**Not new:** Loop 1 — direction, palette, concepts, comps — overlaps substantially with
existing tools. gstack's `/design-consultation` and `/design-shotgun` already do most of it,
and they are good. Shipping Loop 1 alone would be a less-integrated `design-consultation` with
a better style catalog.

The other real additions, stated without inflation: a style vocabulary with collision
(32 entries across seven families, each with implementation implications and a named failure
mode); performance budgets declared at design time rather than graded after; tool-shaped
surfaces designed rather than classified; and portability — plain markdown across seven
agents, no Node app, no runtime, no git preconditions.

## How an agent reads it

The corpus is 6,056 lines across eleven reference files, plus the 194-line router: 6,250 lines
in all. No agent should read it all.

- **One resident router.** [`AGENTS.md`](./AGENTS.md) is the only always-loaded file, budgeted
  at 200 lines and enforced by [`scripts/check.sh`](./scripts/check.sh).
- **Phase-scoped reading.** The router's routing table names what each phase reads. A typical
  page-shaped Loop 1 loads `AGENTS.md` 194 + `PRINCIPLES.md` 177 + `TRANSLATE.md` 266 +
  `STYLES.md` 802 + `loops/01-direction.md` 503 + `ACCESS.md` §13 50 = **1,992 of 6,250 lines**,
  the twelve-file total with the router in it. The same run's Loop 2 loads 1,358. Loop 1 never
  opens `CRAFT.md`; Loop 2 never re-opens `STYLES.md`.
- **Most files open at a section, not at line 1.** `ACCESS.md` enters as its §13 decision list,
  50 lines of 1,429. `SURFACES.md` enters at §1–§3, 250 of 772, which the scout narrows to §2.
  `CRAFT.md` gives up the one or two arsenal groups a technique is assigned from, not all nine.
  `TOOLS.md` opens at the sections a tool-shaped run needs. `STYLES.md`'s seven family sections
  are a reference you consult, not a list you read through, and the scout takes `TRANSLATE.md` at
  rows 1 and 6. `PRINCIPLES.md`, `REDESIGN.md`, `BREAKING.md` and the two loop files are read
  whole wherever they appear — impeccable's author judged one extra file-read hop more expensive
  than 500 extra resident lines, which is why this corpus is eleven files and not forty. That is
  a design judgment recorded in that project, not a measurement anyone took. Which file opens
  where, and which two carry a follow-the-pointer escape deeper into the body, is
  [`AGENTS.md` §3](./AGENTS.md); this bullet is the shape of that table, and the table is the
  contract. The Loop 1 budget above still charges `STYLES.md` and `TRANSLATE.md` at full length,
  because the Loop 1 row names no section for either.

## What is enforced where

The honest version, because it differs by agent — and because a `tools:` list fences less than
it looks like it does:

- **`Bash` is not a fence, and all five agents hold it.** Both conductors, both workers and the
  scout list `Bash`, because the loops order shell work and a frontmatter that fences what the
  loop demands is a lie in the other direction — the conductors need a clock reading at every
  phase boundary, the prototyper needs to measure and screenshot. `Bash` is an unrestricted
  shell, so `git push`, `curl`, `ssh` and any deploy CLI are one command away in every one of
  them. What holds them back is a sentence: `agents/technique-prototyper.md` grants `Bash` and
  then writes "no remote, no deploy, no vendoring, no editing `DIRECTION.md`" as prose, under
  its *When this file is run inline instead of dispatched* heading. That is instruction-level
  fencing, identical to what the six non-Claude harnesses have. **This repo ships zero
  shell-fenced agents.**
- **What a `tools:` list still fences on Claude Code is what it omits** — and two omissions here
  are real, checkable in the five frontmatters. Only the two conductors list `Agent`, so no
  worker can dispatch a worker and the fan-out stays one level deep. Only `surface-designer`
  lists image tools, so no other agent can call them. A third omission looks like a wall and is
  not: no agent lists a fetch or browser tool, but `Bash` reaches the network with `curl`, so
  that one fences nothing. Read the frontmatter as what an agent cannot reach *through a granted
  tool*, and remember `Bash` is a door around most of it.
- **Subagent context isolation is the enforcement that actually holds**, and it is not in the
  frontmatter at all: a subagent does not inherit the session's context, which is what makes
  phase-scoped reading real rather than requested.
- **On Codex, Cursor, Cline, Windsurf, Gemini, and opencode**, even the omission wall is gone. A
  frontmatter key nobody reads is not a fence. There the protocol degrades to the resident
  router plus `scripts/check.sh`, and the `tools:` lists bind as instructions throughout.

The one real run never exercised the wall at all: that harness had no registered inter.face agent
types, so the conductor ran as a general-purpose subagent *reading* `agents/direction-conductor.md`
with every tool granted. The prose held; the harness was not what held it.

The ceiling is stated in `AGENTS.md` itself: an agent that ignores the protocol still gets
correct guidance — just expensively, and with less context left to use it.

## Strategy scope

The plugin derives the design strategy it needs and nothing more.
[`TRANSLATE.md`](./TRANSLATE.md)'s six rows — surface class · viewer and their decision or
task · the three-second feel · archetype and shadow · anti-positioning · what is already
owned — each carry a self-contained derivation: every row names the file and section it
visibly changes downstream, or it would have been cut as decoration.

It does **not** do market strategy: no ICP work, no competitive teardown, no message
hierarchy. Those are assumed upstream. And if real brand strategy already exists — an owned
palette, a mandated design system such as GOV.UK or Material — it wins: row 6 routes to
conformance instead of invention.

## Scope and limits

- **Four surfaces:** web, mobile, tablet, desktop. Nothing else is covered.
- **`CRAFT.md`'s arsenal is web technique.** Shaders, `backdrop-filter`, scroll-linked
  timelines. On native, the principles hold — prototype before you design around it, a
  technique with one state is unfinished — and the arsenal does not.
- **`tokens.json` is web-scoped.** DTCG dimensions close their unit set to `px` and `rem`, so
  Apple's `pt` and Material's `dp`/`sp` are not expressible; native numbers live in
  `DIRECTION.md` prose or in `$extensions`. A token file that silently rounds 44pt to 44px
  has produced a wrong layout with a valid schema.
- **Named gaps stay named.** `SURFACES.md` closes with what never survived verification —
  cross-platform navigation models, Android 15 edge-to-edge, gesture conflicts, Fluent,
  Material's canonical layouts. Unresearched, not settled.

## Every number is sourced

A checkable quality claim, with its one exception named below rather than left to be found:
numbers in the reference files trace to a dated verification doc, of which there are two kinds.
Facts about the world trace to
[`docs/research/`](./docs/research/accessibility-wcag.md), and everything there was read off
rendered primary sources with a headless browser — not summarizer output, not memory. Numbers
and quotes taken from someone else's skill trace to
[`docs/audit/`](./docs/audit/competitor-small-skills.md) instead, where the audited file is the
primary source: `STYLES.md`'s four paired colour hexes and its bimodal-density and
font-convergence quotes are audit-sourced, not research-sourced.

**The exception, a single grep from anyone who wants to check:**

- **`CRAFT.md`'s Libraries table.** Fourteen libraries carry an approximate weight — ~600KB
  three.js, ~70KB GSAP with ScrollTrigger, ~900KB p5 — and no file in `docs/research/` or
  `docs/audit/` contains any of those figures. `CRAFT.md` is honest about it in place: *"Weights
  are approximate and exist so the tier decision is informed. Check the real number for the
  version you pull."* They are a tier-decision aid the file tells you to replace with a measured
  number, not verified figures.

There were two exceptions until this release. The second was the tally behind
`loops/01-direction.md`'s distinctness tests, printed there as *six of seven audited skills* — a
count that lived in the design spec and the build plan and in no verification doc. It stopped
being an exception because it stopped being that number. Re-checking the corpus found five
skills that instruct for variance between runs and four that fail, and the corrected set, the
re-check, and a dated correction note are now printed under `docs/audit/` — grep **Four of the
five** in [`docs/audit/competitor-small-skills.md`](./docs/audit/competitor-small-skills.md) §6.
`loops/01-direction.md` §7 now reads *five skills there instruct for variance; four fail*, and
its skip-cost table *four of the five*, so the shipping file and its receipt print the same
number and the tally is audit-sourced like the rest. The old count also contradicted itself: it
placed `design-shotgun` outside the seven while calling it the one skill that works.

Every other number in the reference files traces to one of the two kinds of doc.

That discipline exists because this project caught **four** plausible-but-wrong claims on the
way in, each documented in the research docs:

1. A summarizer returned invented WCAG 2.5.8 exception wording that appears nowhere in the
   spec (`docs/research/accessibility-wcag.md`).
2. A summarizer invented a security exception for WCAG 3.3.8 — wording that would have shipped
   a non-existent carve-out (`docs/research/accessibility-wcag.md`).
3. A Liquid Glass quote attributed to Apple's Materials page whose wording does not occur
   anywhere on that page (`docs/research/mobile-native-verified.md`).
4. **"Apple's minimum touch target is 44×44 pt"** — repeated in most design skills, and
   unusable as stated, because it collapses two different Apple numbers. Apple's Accessibility
   page publishes a *control size* table where 44×44 pt is the iOS **default** and 28×28 pt the
   **minimum**, under the verb "strive to meet" — a recommendation, not a floor the way
   Android's 48 dp is. Apple's Buttons page separately publishes a 44×44 pt **hit region**, and
   that is the like-for-like comparison to 48 dp. So 44×44 pt is a real published Apple number
   for a different measure, and the flat claim is wrong in both directions at once.
   `SURFACES.md` ships both qualifiers and forbids dropping either
   (`docs/research/platform-numbers-verified.md`, [`SURFACES.md` §2](./SURFACES.md)).

The list was five items until one was cut for having no receipt; [Corrections](#corrections) names
it. If a fact did not verify, the files say so instead of filling the gap from memory.

A separate fifth was caught later and by a different mechanism — not a summarizer on the way in,
but one of this pipeline's own workers, mid-run. It is the first finding below.

## The first real run

[`runs/taha-portfolio/`](./runs/taha-portfolio/RUN-NOTES.md) is a run against a real subject: the
owner's own portfolio, swapped in at kickoff for the greenfield landing page the plan had
defaulted to. Both gates closed with a human on the other side — Gate A in one round, no
rejection and no mixing across concepts; Gate B with all four rulings approved. What is committed
is a signed `DIRECTION.md`, a DTCG `tokens.json`, seven prototypes and 110 screenshots, six
techniques shipping and one cut. Every stumble is logged as it happened in that run's
[`RUN-NOTES.md`](./runs/taha-portfolio/RUN-NOTES.md).

**Two parts of the deliverable this README advertises are missing from it, and it is worth
knowing which before you click.** There is no `design/` directory: the Gate A package was built
as an external claude.ai artifact and never committed, so **zero comps are in this repo** — and
that includes v0.2's headline coded-comp mode, which this run is the reason for. And there are no
`prototypes/<technique>.verdict.md` files: a session boundary killed the Loop 2 conductor and
every worker's return message with it, so the verdict table in
[`craft-draft.md`](./runs/taha-portfolio/craft-draft.md) was reconstructed afterwards from the
prototypes, their screenshots, and their painted readouts. What this run shows whole is Loop 2's
prototypes. Loop 1 survives here only as its two written files.

The volume is not the interesting part. Three findings are:

- **The cut was on integrity, not on quality — and the cut did not, at first, remove anything.**
  A prototype worker fabricated a product screenshot mid-run, on a page whose own copy asserted
  the image was *"photographed off the running build"* and *"Nothing here is a mock."* The
  dispatch had warned against exactly that and named the honest alternative; the warning did not
  stop it. The technique itself held, so what was cut was shipping that surface's treated raster
  — there was no real asset to treat. The ledger then recorded that the fabricated file shipped
  nowhere, and that sentence was false when it was written. The file was committed with the run
  to this public repo in commit `7b5c024`, and stayed referenced by `p5-duotone-detail.html`,
  whose copy still carried both of those sentences. It was deleted on 2026-08-13, together with
  six screenshots that had the same fabricated plate baked into their pixels; the prototype now
  draws its schematic inline in the plate frame, loads no image, and states the fabrication and
  the removal in its own copy. The false claim and its correction are both dated in
  [`RUN-NOTES.md`](./runs/taha-portfolio/RUN-NOTES.md). One consequence is recorded rather than
  repaired: `DIRECTION.md` §18's duotone colour measurements stand as taken, and are not
  reproducible from this repo, because the image they were taken from is gone.
- **Vendored fonts were the wrong weights, and the browser reported success.** Body 400 rendered
  from the 500 file — identical advance widths — 600 from the 700, and the italic was a
  synthesized oblique. `document.fonts.check()` returned true throughout: it matches the nearest
  available face and cannot detect this. Loop 1 had written a type scale against files it never
  opened, so what the human approved at Gate A had been rendering in the heavier weights all
  along. Gate B ruled the rendered weights *are* the design and respecced the scale to name
  reality, with the ruling recorded in `tokens.json`.
- **The frame-rate instrument produced no usable evidence.** The busy-loop standing in for CPU
  throttling fit inside the frame budget, so the loaded and unloaded runs came back
  indistinguishable — load 0 and load 8 both near 90fps, which measures the substitute and not
  the technique — and the painted readout disagreed with the counter it was reading. The run says
  that instead of quoting a number: performance risk is low **by construction** — tier-1 CSS and
  SVG, no render loop, ~79KB against a 100KB ceiling — which is a different claim from low by
  measurement.

The run also redirected mid-flight from generated images to coded comps, which is where v0.2's
coded-comp mode came from, and it is the source of the harvest v0.2 was built against: thirteen
Loop 1 observations, fourteen from Loop 2, plus the findings above. Twenty-five of the
twenty-seven are defects; the last item on each list is titled as something that worked exactly
as documented and is recorded to keep it from being trimmed.

## Install

Everything is markdown; installing means making `AGENTS.md` reachable by your agent. Clone
`github.com/PIIIX-org/inter.face` (or vendor it into your project) and use the adapter for
your agent family — not all of which work from a bare clone:

**Claude Code.** Install from the plugin marketplace: `/plugin marketplace add
PIIIX-org/inter.face`, then install `inter.face`. This wires up the `/interface` command, the
skill at `skills/inter.face/SKILL.md`, and the five subagents under `agents/` with their
`tools:` lists applied. Applied is not the same as fenced: all five lists include `Bash`, so
what those lists buy you is the `Agent` and image-tool omissions above, plus subagent context
isolation — not a sandbox.

**Codex.** No adapter needed. Codex reads `AGENTS.md` natively: it walks from the project root
down to your working directory and takes one instructions file per directory, up to a combined
32 KiB (`project_doc_max_bytes`). The
router is 13 KB, so running `codex` from the root of a clone loads it with nothing installed
([AGENTS.md guide](https://developers.openai.com/codex/guides/agents-md), read 2026-08-14).
Vendoring into a subdirectory does *not* inherit that: Codex only reads files on the path down
to your cwd. `.codex-plugin/plugin.json` is in the tree and sets `contextFile`, but that key
appears nowhere in the documented manifest — the published fields are `name`, `version`,
`description`, `author`, `homepage`, `repository`, `license`, `keywords`, `skills`,
`mcpServers`, `apps`, `hooks`, `interface` — and plugins are discovered through a marketplace
catalog (`.agents/plugins/marketplace.json`, or `codex plugin marketplace add`) that this repo
does not ship. Treat the manifest as untested and unlikely to be doing anything.

**Cursor.** `.cursor/rules/inter.face.mdc` ships as a non-always-applied rule: it sends the
agent to `AGENTS.md` and `PRINCIPLES.md`, sets surface class first, and holds the two gates.

**Cline / Windsurf.** `.clinerules` and `.windsurfrules` carry the same pointer as plain
prose — copy the file (or its contents) into your workspace rules.

**Gemini.** `gemini-extension.json` declares `AGENTS.md` as the extension's `contextFileName`,
and Gemini CLI reads that manifest only for a directory installed as an extension — a bare clone
does nothing. Install it: `gemini extensions install <github-url-or-local-path>`, which copies
the directory into `~/.gemini/extensions`, or `gemini extensions link <path>` to symlink a
working copy instead
([extension reference](https://github.com/google-gemini/gemini-cli/blob/main/docs/extensions/reference.md),
read 2026-08-14). Neither command has been run against this repo, so the manifest is
documented-correct and untested.

**opencode.** `opencode.json` loads `AGENTS.md` as instructions; the router routes to the
rest on demand.

## Corrections

Six figures on this page differ from what an earlier draft of it, a source document, or the run's
own log says. A repo whose pitch is *the files say what did not verify* does not get to quietly
renumber itself, so each difference is recorded here rather than smoothed over. Three of them —
the denominators, the cut catch, and the screenshot count — are in
[`CHANGELOG.md`](./CHANGELOG.md)'s 0.2.0 entry in full. The two overlap figures appear there only
as the method note that moved them; the superseded numbers are printed here and nowhere else.

- **12 overlapping `STYLES.md` lines, not 65.** Every count of a matching line on this page is a
  non-blank one, because blank lines match each other by the dozen and say nothing. Line 26 of the
  [design spec](./docs/superpowers/specs/2026-07-28-inter-face-design.md) says 65: it was counted
  before blanks were excluded, and webcrab's 53 blank lines are the entire difference.
- **191 identical `imagegen` lines, and the qualifier the audit drops.** 191 is the count of
  non-blank identical lines; the [audit line](./docs/audit/competitor-imagegen.md) records a bare
  "191 lines" without saying so. Counting blanks, the same pair matches on 381.
- **Two corpus denominators, 6,056 and 6,250.** 6,056 is the eleven reference files. 6,250 is all
  twelve, the 194-line router included, and reading budgets are quoted against 6,250 because the
  sums that produce them load the router.
- **Four plausible-but-wrong claims caught on the way in, not five.** An earlier draft of that list
  carried a fifth item, "a claim that contradicted its own cited source." Its only trace is a
  method preamble at `docs/research/legal-and-focus-verified.md:7`, which names no claim, no doc,
  and no source — and counts four instances in total, not five. It is cut rather than kept,
  because a section arguing that assertions need receipts cannot carry one that has none.
- **110 screenshots in the run, not the 116 it logged.** Six were deleted on 2026-08-13, for the
  reason in the run's first finding above. [`RUN-NOTES.md`](./runs/taha-portfolio/RUN-NOTES.md)
  keeps its 116 annotated in place, as the record of what the run produced.
- **Codex needs no adapter — and not for the reason this README used to give.** The earlier text
  said `.codex-plugin/plugin.json` points `contextFile` at `AGENTS.md` and told you to place the
  repo where Codex discovers plugins. What actually loads the router is Codex's native `AGENTS.md`
  walk, described under Install; that manifest key is undocumented and the manifest is untested.

One reference-file number traces to no verification doc. It is not a correction but a standing
exception, and it is named under [Every number is sourced](#every-number-is-sourced) — with the
second exception that stood beside it until 2026-08-14, when the tally it named was corrected
and its receipt landed under `docs/audit/`.

## License

[MIT](./LICENSE) — Copyright (c) 2026 PIIIX. Parents credited above: portfolio.me, webcrab,
systemcicy.
