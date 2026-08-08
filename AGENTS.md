# inter.face

Art direction for any interface. A six-row table in; `DIRECTION.md`, `tokens.json`, one design
image per surface, and one measured prototype per technique out. Two human gates. Web, mobile,
tablet, desktop.

**This file is a decision-tree skeleton. Its steps point at on-demand sections. Read a section
in full before doing its step; do not work from memory.**

## 1. What this is

A design-only pipeline. **Markdown is the product; your agent is the runtime.** Nothing here
executes. The reference files are inert on disk until something Reads them, and this router is
the only file that stays resident.

**It stops before code.** The deliverable is a direction specified to the resolution where a
build agent makes no aesthetic decisions. It does not build the site, the app, or the component.

## 2. Read first

1. [`PRINCIPLES.md`](./PRINCIPLES.md) — sixteen rules, three of them **[HARD]**.
2. [`TRANSLATE.md`](./TRANSLATE.md) — the six-row input contract. Row 1 blank means nothing starts.
3. The loop you are on, from §5 below.

Nothing else until §3 sends you there.

## 3. The phase routing table

The corpus is **5,435 lines** across eleven reference files. An agent that reads it before
deciding anything has spent the context the decisions needed. Read by phase.

| Phase | Core — always | Conditional — read only if the condition holds |
|---|---|---|
| **Scout** (brownfield only) | [`REDESIGN.md`](./REDESIGN.md) 326 · `TRANSLATE.md` rows 1 and 6 · `STYLES.md`'s family sections, for positioning only · **`SURFACES.md` §2**, to adjudicate the target sweep | `TOOLS.md` §4 **if tool-shaped** — what the nine data states owe, so the absence sweep knows what it is looking for |
| **Loop 1 · direction** | [`PRINCIPLES.md`](./PRINCIPLES.md) 172 · [`TRANSLATE.md`](./TRANSLATE.md) 247 · [`STYLES.md`](./STYLES.md) 687 · [`loops/01-direction.md`](./loops/01-direction.md) 409 · **`ACCESS.md` §13 only** — 45 of 1,357 | [`TOOLS.md`](./TOOLS.md) 273 **if tool-shaped** · **`SURFACES.md` §1–§3** 249 of 558 **if this surface runs on a phone or a tablet** — platform mode has three branches and `cross-platform-neutral` is one of them, so a responsive mobile web surface owes §1 too · `CURRENT.md` **if reposition** |
| **Gate A** | the returned package. Nothing new is read at a gate | — |
| **Loop 2 · craft** | [`CRAFT.md`](./CRAFT.md) 704 · [`loops/02-craft.md`](./loops/02-craft.md) 363 | [`TOOLS.md`](./TOOLS.md) **if tool-shaped** · [`BREAKING.md`](./BREAKING.md) 339 **only when a rule is actually being broken** |
| **Gate B** | the returned package | — |

**Do not read across phases.** Loop 1 does not open `CRAFT.md` — Loop 2 assigns techniques.
Loop 2 does not re-open `PRINCIPLES.md`, `STYLES.md`, `ACCESS.md`, `SURFACES.md`, or
`TRANSLATE.md` — their answers arrived in `DIRECTION.md`, and re-deriving them is how a Loop 1
decision gets quietly overturned. A genuine gap there is a **finding about Loop 1**, reported
as one, not filled in silently.

**Two files carry a follow-the-pointer escape at section entry.**
`ACCESS.md` §13 is the Loop 1 decision list — thirteen rows both classes owe, six more
tool-shaped, four more native — and you follow a row's *where it binds* pointer into the body
only when you cannot answer the row without it. `SURFACES.md` §1–§3 is platform mode, the four
target numbers, and type scaling; follow §1's own pointers into **§4** (Liquid Glass, on
iOS-native) and **§5** (the breakpoint and pane-count table `STYLES.md` promises, on tablet or
desktop) where they bind. Every other file is read by the sections its phase's reading list
names — both conductors read `TOOLS.md` and `CRAFT.md` by named section — or entered whole and
read by name inside it: `STYLES.md`'s seven family sections are a reference you consult, not a
list you read through, and `CRAFT.md` gives up the one or two arsenal groups you are assigning
from, not all nine.
**Over-splitting is its own failure**: one extra file-read hop costs more than 500 resident
lines, which is why the corpus is eleven files and not forty.

**Worked example — page-shaped, web, Loop 1.** This file 194 + `PRINCIPLES.md` 172 +
`TRANSLATE.md` 247 + `STYLES.md` 687 + `loops/01-direction.md` 409 + `ACCESS.md` §13 45 =
**~1,750 lines**, not 5,435. `TOOLS.md`, `SURFACES.md`, `REDESIGN.md`, `BREAKING.md`, and 1,312
lines of `ACCESS.md` never load. The same run's Loop 2 is 194 + 704 + 363 = **~1,260**.

**The honest ceiling.** Nothing in markdown can stop an agent reading everything. What this
protocol does is make the right path cheap and the wrong path visibly wasteful. An agent that
ignores this table still gets correct guidance — just expensively, and with less context left
to use it.

## 4. Where everything is written

One run per **surface**, not per product. `<slug>` is that surface, kebab-cased —
`acme-marketing` and `acme-console` are two runs. `runs/` lives in the invoking project's
working directory, never in the plugin's install directory.

```text
runs/<slug>/
  TRANSLATE.md                            the six rows, as filled in for this run
  CURRENT.md                              redesign-scout writes it; reposition reads it
  DIRECTION.md                            Loop 1 writes the direction half; Loop 2 completes it
  tokens.json                             beside DIRECTION.md — Loop 2 §6
  SKIPS.md                                the run's skip ledger
  design/<concept>/<NN>-<surface>.png     one image per surface per concept
  prototypes/<technique>.html             standalone, states switched by query string
  shots/<technique>-<state>.png           prototype screenshots, one per state
  shots/current/                          the scout's screenshots of the live surface
```

`<concept>` is the family-pass label from `loops/01-direction.md` §7 — *exhibition*, *cockpit*
— so the three renders of one surface never collide. `<NN>` is surface order, zero-padded.

`§16` records every deferral in `DIRECTION.md` as a decision — *decision needed · if deferred,
what happens* — and `DIRECTION.md` carries every row. **`SKIPS.md`** is the run-level
append-only copy: appended at each gate, never rewritten. Silence is not a skip.

Dispatches carry absolute paths built from this layout. Every agent writes where its dispatch
says, and this section is what the dispatch says.

## 5. Two loops, two gates

| | Runs | Produces | Gate |
|---|---|---|---|
| [`loops/01-direction.md`](./loops/01-direction.md) | class, platform mode, `ACCESS.md` §13, derive three directions, palette and type per direction, concepts, two distinctness tests, images, set check | the direction half of `DIRECTION.md`, N images per concept | **Gate A** — the human picks the concept |
| [`loops/02-craft.md`](./loops/02-craft.md) | a technique per surface against the three-question test, one prototype each, motion spec, both budget tiers | `DIRECTION.md` complete, `tokens.json`, one runnable prototype per technique | **Gate B** — the human approves or cuts the technique set |

Both gates are `§16` **[HARD]**. **The written output is the OUTPUT of an interactive review,
not a substitute for it.** A gate that becomes a document somebody reads later has been removed,
not satisfied. Three rejections at one gate means `TRANSLATE.md` is wrong, not the work.

## 6. Surface class, in six lines

**`page-shaped`** — read for seconds, once: a landing page, a marketing site, a campaign.
**`tool-shaped`** — read for hours, daily, by the same person: a dashboard, console, or
internal tool. Set once per surface by `TRANSLATE.md` row 1, before anything else, with no safe
default. It decides which half of every reference file applies — `STYLES.md`, `CRAFT.md`,
`TOOLS.md`, `SURFACES.md`, `ACCESS.md`, `REDESIGN.md`, and `BREAKING.md` each open with the
fork — the state set owed (3 render states and, crossed, `TOOLS.md`'s 9 data states where both
apply — a tool-shaped surface carrying motion owes both sets), the image aspect
ratio, and whether `§15` binds **[HARD]** or as `§10`'s ordinary keyboard reachability.

## 7. The three hard rules

- **`§10` Accessible by default.** Decided in Loop 1 through `ACCESS.md` §13, before an image
  generates — not audited in a final pass. Every animation ships a *designed* reduced-motion
  state; every WebGL surface ships a no-WebGL fallback.
- **`§15` Keyboard completeness**, **[HARD]** on tool-shaped surfaces. Every primary workflow
  completable by keyboard alone. The full set is in [`TOOLS.md`](./TOOLS.md).
- **`§16` Human gates are real stops.** Skipping is allowed; silent degradation is not.

`BREAKING.md` holds these three and `TRANSLATE.md` row 5 on its never-breakable list. The line
is consent, not magnitude: breaking any of them transfers a cost onto someone who did not agree
to pay it. Everything else is breakable, and every break is recorded — rule by number, what it
buys, what it costs, why the trade is honest. **A break that is not written down is
indistinguishable from a mistake.**

## 8. Scope and limits, plainly

Four surfaces: **web, mobile, tablet, desktop**. Two of those claims are narrower than they
look, and both are stated rather than implied.

- **`CRAFT.md`'s arsenal is web technique.** Shaders, `backdrop-filter`, scroll-linked
  timelines, WebGL context loss. On native the *principles* hold — prototype before you design
  around it, a technique with one state is unfinished, the two-tier budget, name what the
  technique teaches — and the *arsenal* does not. Entries and byte budgets do not cross.
- **`tokens.json` is a web artifact.** DTCG `dimension` is an object whose unit set is closed
  to `px` and `rem`, so Apple's `pt` and Material's `dp`/`sp` are not expressible. Native
  numbers live in `DIRECTION.md` prose or in `$extensions`. A token file that silently rounds
  44pt to 44px has produced a wrong layout with a valid schema.
- `SURFACES.md` closes with named gaps — Fluent and Windows conventions, Electron and Tauri,
  iOS's side of the gesture question, Apple's per-device safe-area values. They are
  **unresearched, not settled.** A run that needs one researches it rather than recalling it.

## 9. The five agents

A subagent does not inherit this session's context, so a phase's reading never enters it.
**That is the enforcement mechanism for §3, not a preference about tidiness.** Route to them.

| Agent | Phase | Dispatch |
|---|---|---|
| [`redesign-scout`](./agents/redesign-scout.md) | before Loop 1, brownfield only | once — proposes the correction/reposition/conformance fork, never takes it |
| [`direction-conductor`](./agents/direction-conductor.md) | Loop 1 | once — returns the Gate A package |
| [`surface-designer`](./agents/surface-designer.md) | Loop 1 worker | one per surface **per concept**, in parallel. Never a compressed board |
| [`craft-conductor`](./agents/craft-conductor.md) | Loop 2 | once — returns the Gate B package |
| [`technique-prototyper`](./agents/technique-prototyper.md) | Loop 2 worker | one per technique, in parallel |

**Neither conductor holds a gate.** They assemble the package and stop; the session that talks
to the human holds Gate A and Gate B. `§16` does not degrade.

**On `tools:` in the frontmatter.** It is a **hard capability restriction on Claude Code**,
enforced by the harness, and **absent on most others** — a key nobody reads is not a fence.
Where it is absent, treat it as an instruction: the direction conductor still does not open
`CRAFT.md`, the prototyper still does not vendor or deploy.

**The fallback is keyed on the agent's own capability, not on whether the harness recognizes
the key.** An agent that cannot spawn subagents reads `agents/*.md` and works inline — same
steps, same order, same reading list. Two costs, both named in those files: the reading lands
in this context, so §3's budget becomes a manual discipline; and the checks that existed
because no worker sees its neighbors — the set-level check, the honest `cut` — become checks
run against your own output. Run them against the logged tokens and the measured numbers, never
against your memory of the work.

## 10. What it hands off to

`DIRECTION.md` + `tokens.json` + the images + the prototypes go to whichever comes next:

- **A sibling pipeline's build loop** — portfolio.me, webcrab, or systemcicy. Same
  `runs/<slug>/` layout, so the handoff is a path.
- **gstack `/design-html`**, for production-quality HTML and CSS from the finished direction.
- **A human**, or **another agent**, building from the spec.

Close `DIRECTION.md` with the handoff clause from `loops/02-craft.md` §5. The goal is not
*inspired by* this direction; it is **faithful to it**. During the build: do not simplify into
default templates, do not compress the stated spacing, do not flatten the type hierarchy, and
where the design is genuinely ambiguous, ask rather than fill the ambiguity with a default.
