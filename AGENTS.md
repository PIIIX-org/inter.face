# inter.face

Art direction for any interface. Six rows and an inbox in; `DIRECTION.md`, `tokens.json`, one
comp per surface — a coded comp by default, a generated image when the run opts into image mode
— the board they are reviewed on, one measured prototype per technique, and a component sheet
built from the tokens. Three human gates. Web, mobile, tablet, desktop.

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
2. [`TRANSLATE.md`](./TRANSLATE.md) — the six-row input contract, and the inbox that fills it.
   Row 1 blank means nothing starts.
3. The loop you are on, from §5 below.

Nothing else until §3 sends you there.

## 3. The phase routing table

The corpus is **6,705 lines** across thirteen reference files. An agent that reads it before
deciding anything has spent the context the decisions needed. Read by phase.

| Phase | Core — always | Conditional — read only if the condition holds |
|---|---|---|
| **Scout** (brownfield only) | [`REDESIGN.md`](./REDESIGN.md) 331 · `TRANSLATE.md` rows 1 and 6 · `STYLES.md`'s family sections, for positioning only · **`SURFACES.md` §2**, to adjudicate the target sweep | `TOOLS.md` §4 **if tool-shaped** — what the nine data states owe, so the absence sweep knows what it is looking for |
| **Loop 1 · direction** | [`PRINCIPLES.md`](./PRINCIPLES.md) 177 · [`TRANSLATE.md`](./TRANSLATE.md) 355 · [`STYLES.md`](./STYLES.md) 802 · [`loops/01-direction.md`](./loops/01-direction.md) 601 · **`ACCESS.md` §13 only** — 50 of 1,429 | [`TOOLS.md`](./TOOLS.md) 273 **if tool-shaped** · **`SURFACES.md` §1–§3** 250 of 772 **if this surface runs on a phone or a tablet** — platform mode has three branches and `cross-platform-neutral` is one of them, so a responsive mobile web surface owes §1 too · `CURRENT.md` **if reposition** |
| **Gate A** | the returned package. Nothing new is read at a gate | — |
| **Loop 2 · craft** | [`CRAFT.md`](./CRAFT.md) 786 · [`loops/02-craft.md`](./loops/02-craft.md) 385 | [`TOOLS.md`](./TOOLS.md) **if tool-shaped** · [`BREAKING.md`](./BREAKING.md) 339 **only when a rule is actually being broken** |
| **Gate B** | the returned package | — |
| **Loop 3 · system** | [`loops/03-system.md`](./loops/03-system.md) 289 · this run's own `DIRECTION.md` and `tokens.json`, which are the source the sheet gets built from | [`TOOLS.md`](./TOOLS.md) **if tool-shaped** — the nine data states cross every component that holds data |
| **Gate C** | the returned package | — |
| **Close** | [`IMPROVE.md`](./IMPROVE.md) 166 | — |

**Do not read across phases.** Loop 1 does not open `CRAFT.md` — Loop 2 assigns techniques.
Loop 2 does not re-open `PRINCIPLES.md`, `STYLES.md`, `ACCESS.md`, `SURFACES.md`, or
`TRANSLATE.md` — their answers arrived in `DIRECTION.md`, and re-deriving them is how a Loop 1
decision gets quietly overturned. Loop 3 opens neither loop before it: it builds from
`tokens.json` and `DIRECTION.md`, and a value that is not in them is the finding it exists to
produce. **A genuine gap is a finding about the loop that owed it**, reported as one, never
filled in silently.

**Two files carry a follow-the-pointer escape at section entry.** `ACCESS.md` §13 is the Loop 1
decision list — thirteen rows both classes owe, six more tool-shaped, four more native — and you
follow a row's *where it binds* pointer into the body only when you cannot answer the row without
it. `SURFACES.md` §1–§3 is platform mode, the four target numbers, and type scaling; follow §1's
own pointers into **§4** (Liquid Glass, on iOS-native) and **§5** (the breakpoint and pane-count
table `STYLES.md` promises, on tablet or desktop) where they bind. Every other file is read by the
sections its phase's reading list names — `TOOLS.md` by named section in any loop, but only when
row 1 is tool-shaped; `CRAFT.md` by named section in Loop 2 alone, one or two arsenal groups, not
all nine — or entered whole and read by name inside it, as `STYLES.md`'s seven family sections are
a reference you consult rather than a list you read through.

**Worked example — page-shaped, web, Loop 1.** This file 218 + `PRINCIPLES.md` 177 +
`TRANSLATE.md` 355 + `STYLES.md` 802 + `loops/01-direction.md` 601 + `ACCESS.md` §13 50 =
**2,203 of 6,923**, the fourteen-file total with this router in it; the 6,705 above excludes it.
`TOOLS.md`, `SURFACES.md`, `REDESIGN.md`, `BREAKING.md`, `IMPROVE.md`, `loops/03-system.md` and
1,379 lines of `ACCESS.md` never load. Loop 2 is 218 + 786 + 385 = **1,389**; Loop 3 is
218 + 289 = **507**, plus this run's own artifacts, which is the point of that loop.

**The honest ceiling.** Nothing in markdown stops an agent reading everything. What this protocol
does is make the right path cheap and the wrong path visibly wasteful — an agent that ignores the
table still gets correct guidance, just expensively, with less context left to use it.

## 4. Where everything is written

One run per **surface**, not per product. `<slug>` is that surface, kebab-cased —
`acme-marketing` and `acme-console` are two runs. `runs/` lives in the invoking project's
working directory, never in the plugin's install directory, and never in a per-device cache:
that is what makes the record readable by whoever picks the project up next.

```text
runs/<slug>/
  inbox/refs/ · inbox/refs.md · inbox/brand/   what the human handed over — TRANSLATE.md
  TRANSLATE.md                              the six rows, as filled in for this run
  CURRENT.md · SCOUT.md                     redesign-scout writes them; reposition reads them
  DIRECTION.md                              Loop 1 writes the direction half; 2 and 3 finish it
  direction-draft.md · craft-draft.md       each loop's reasoning, kept current as work lands
  tokens.json                               beside DIRECTION.md — Loop 2 §6, closed in Loop 3 §5
  SKIPS.md                                  the run's skip ledger, appended at every gate
  RUN-NOTES.md · FEEDBACK.md                the run ledger, and its harvest — IMPROVE.md
  design/<concept>/<NN>-<surface>.md        coded comp, or the .png's token sidecar in image mode
  design/<concept>/<NN>-<surface>.png       image mode only — one image per surface per concept
  design/board.html                         every concept, every surface, navigable — Loop 1 §11
  prototypes/<technique>.html               standalone, states switched by query string
  prototypes/<technique>.verdict.md         the verdict, its evidence label, its measurements
  prototypes/shots/<technique>-<state>.png  prototype screenshots, one per state
  system/sheet.html · system/gaps.md        the component sheet and its gap report — Loop 3
  system/keyboard-walk.md · system/shots/   the walk, and every component group in both modes
  shots/current/                            the scout's screenshots of the live surface
```

`<concept>` is the family-pass label from `loops/01-direction.md` §7 — *exhibition*, *cockpit*
— so the three renders of one surface never collide. `<NN>` is surface order, zero-padded.

`§16` records every deferral in `DIRECTION.md` as a decision — *decision needed · if deferred,
what happens*. **`SKIPS.md`** is the run-level append-only copy, appended at each of the three
gates and never rewritten. Silence is not a skip. Dispatches carry absolute paths built from
this layout, and **everything above is on disk before the agent that owns it returns.**

## 5. Three loops, three gates

| | Runs | Produces | Gate |
|---|---|---|---|
| [`loops/01-direction.md`](./loops/01-direction.md) | class, platform mode, `ACCESS.md` §13, derive three directions, palette and type per direction, concepts, two distinctness tests, comps, set check, board | the direction half of `DIRECTION.md`, N comps per concept, `design/board.html` | **Gate A** — the human picks the concept |
| [`loops/02-craft.md`](./loops/02-craft.md) | a technique per surface against the three-question test, one prototype each, motion spec, both budget tiers | `DIRECTION.md` at schema resolution, `tokens.json`, one runnable prototype per technique | **Gate B** — the human approves or cuts the technique set |
| [`loops/03-system.md`](./loops/03-system.md) | component inventory from the comps, the state matrix, the sheet built from the tokens, the gap report | `system/sheet.html` and its screenshots, every gap closed in `DIRECTION.md` and `tokens.json` | **Gate C** — the human signs off the component set |

All three gates are `§16` **[HARD]**. **The written output is the OUTPUT of an interactive
review, not a substitute for it.** A gate that becomes a document somebody reads later has been
removed, not satisfied. Three rejections at one gate means `TRANSLATE.md` is wrong, not the work.
Then the run closes through [`IMPROVE.md`](./IMPROVE.md), which is §10 below.

## 6. Surface class, in six lines

**`page-shaped`** — read for seconds, once: a landing page, a marketing site, a campaign.
**`tool-shaped`** — read for hours, daily, by the same person: a dashboard, console, or
internal tool. Set once per surface by `TRANSLATE.md` row 1, before anything else, with no safe
default. It decides which half of every reference file applies — `STYLES.md`, `CRAFT.md`,
`TOOLS.md`, `SURFACES.md`, `ACCESS.md`, `REDESIGN.md`, and `BREAKING.md` each open with the
fork — the state set owed (3 render states and, crossed, `TOOLS.md`'s 9 data states where both
apply — a tool-shaped surface carrying motion owes both sets), the comp's aspect ratio in image
mode and its frame width in coded mode, and whether `§15` binds **[HARD]** or as `§10`'s
ordinary keyboard reachability.

## 7. The three hard rules

- **`§10` Accessible by default.** Decided in Loop 1 through `ACCESS.md` §13, before a comp is
  produced — not audited in a final pass. Every animation ships a *designed* reduced-motion
  state; every WebGL surface ships a no-WebGL fallback.
- **`§15` Keyboard completeness**, **[HARD]** on tool-shaped surfaces. Every primary workflow
  completable by keyboard alone, walked and recorded on Loop 3's sheet. The full set is in
  [`TOOLS.md`](./TOOLS.md).
- **`§16` Human gates are real stops.** Skipping is allowed; silent degradation is not.

`BREAKING.md` holds these three and `TRANSLATE.md` row 5 on its never-breakable list. The line
is consent, not magnitude: breaking any of them transfers a cost onto someone who did not agree
to pay it. Everything else is breakable, and every break is recorded — rule by number, what it
buys, what it costs, why the trade is honest. **A break that is not written down is
indistinguishable from a mistake.**

## 8. Scope and limits, plainly

Four surfaces: **web, mobile, tablet, desktop**. Two of those claims are narrower than they
look, and both are stated rather than implied.

- **`CRAFT.md`'s arsenal is web technique** — shaders, `backdrop-filter`, scroll-linked
  timelines, WebGL context loss. On native the *principles* hold; the entries and the byte
  budgets do not cross.
- **`tokens.json` is a web artifact.** DTCG `dimension` is an object whose unit set is closed
  to `px` and `rem`, so Apple's `pt` and Material's `dp`/`sp` are not expressible. Native
  numbers live in `DIRECTION.md` prose or in `$extensions`. A token file that silently rounds
  44pt to 44px has produced a wrong layout with a valid schema.
- `SURFACES.md` closes with named gaps — Fluent and Windows conventions, Electron and Tauri,
  iOS's side of the gesture question, Apple's per-device safe-area values. They are
  **unresearched, not settled.** A run that needs one researches it rather than recalling it.

## 9. The six agents

A subagent does not inherit this session's context, so a phase's reading never enters it.
**That is the enforcement mechanism for §3, not a preference about tidiness.** Route to them.

| Agent | Phase | Dispatch |
|---|---|---|
| [`redesign-scout`](./agents/redesign-scout.md) | before Loop 1, brownfield only | once — proposes the correction/reposition/conformance fork, never takes it |
| [`direction-conductor`](./agents/direction-conductor.md) | Loop 1 | once — returns the Gate A package |
| [`surface-designer`](./agents/surface-designer.md) | Loop 1 worker | one per surface **per concept**, in parallel. Never a compressed board |
| [`craft-conductor`](./agents/craft-conductor.md) | Loop 2 | once — returns the Gate B package |
| [`technique-prototyper`](./agents/technique-prototyper.md) | Loop 2 worker | one per technique, in parallel |
| [`system-builder`](./agents/system-builder.md) | Loop 3 | once — returns the sheet and the gap report |

**No conductor holds a gate.** They assemble the package and stop; the session that talks to
the human holds Gate A, Gate B, and Gate C. `§16` does not degrade.

**On `model:` in the frontmatter.** All six name `fable` — Fable 5, `claude-fable-5` — because
this pipeline is derivation and judgment against a long reading list, which is where a weaker
model reaches for the category reflex every rule here exists to prevent. Harnesses that read the
key apply it; on the ones that do not, set it before dispatching. It is the plugin's default and
not one of its rules: a run with a reason to use something else records the reason and proceeds.

**On `tools:` in the frontmatter.** A **hard capability restriction on Claude Code**, enforced by
the harness and **absent on most others** — a key nobody reads is not a fence. Where it is absent
it binds as an instruction: the direction conductor does not open `CRAFT.md`, the prototyper does
not vendor or deploy, the system builder does not invent a value. **The fallback is keyed on the
agent's own capability, not on whether the harness recognizes the key.** An agent that cannot spawn
subagents reads `agents/*.md` and works inline — same steps, same order, same reading list — at two
costs named in those files: the reading lands in this context, so §3's budget becomes a manual
discipline, and the checks that existed because no worker sees its neighbors become checks against
your own output. Run those against the logged tokens and the measured numbers, never against memory.

## 10. What it hands off to, and how the run closes

`DIRECTION.md` + `tokens.json` + the comps + the board + the prototypes + the sheet go to
whichever comes next:

- **A sibling pipeline's build loop** — portfolio.me, webcrab, or systemcicy. Same
  `runs/<slug>/` layout, so the handoff is a path.
- **gstack `/design-html`**, for production-quality HTML and CSS from the finished direction.
- **A human**, or **another agent**, building from the spec.

Close `DIRECTION.md` with the handoff clause from `loops/02-craft.md` §5, which lists what a build
may not quietly do to a direction. The goal is not *inspired by* it; it is **faithful to it**.

Then close the run through [`IMPROVE.md`](./IMPROVE.md): the run record is already on disk, the
harvest turns it into findings about this plugin, and the human is asked **once**, with the
payload shown in full and the default set to no, whether to send it to PIIIX — and separately
whether to put one screenshot in the gallery. There is no telemetry here and nothing is ever
sent without that yes.
