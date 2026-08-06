# inter.face

Art direction for any interface. A six-row translation table in; a fully specified design
direction out. Plain markdown, portable across seven coding agents. It stops before code.

## What it is, and what it is not

A design-only pipeline. The deliverable is:

- **`DIRECTION.md`** — the direction at rendered-style resolution: named values, not adjectives,
  so a build agent makes no aesthetic decisions
- **`tokens.json`** — its machine-readable sibling, in the Design Tokens Community Group (DTCG)
  format
- **one design image per surface**, at an aspect ratio keyed to the surface class
- **one measured prototype per technique** — standalone runnable HTML with a measured frame rate
  under load, a byte cost, all required states, and a ship / cut / ship-with-caveat verdict
  labeled by its evidence (TESTED, PARTIAL, or INFERRED)

Two human gates, both `§16` hard: **Gate A**, where the human picks the concept, and **Gate B**,
where the human approves or cuts the technique set. The written output is the output of an
interactive review, not a substitute for one.

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

Only 65 of portfolio.me's 388 `STYLES.md` lines still match webcrab's copy. The drift is not
decay — each fork grew material the others lack. webcrab has a style selection procedure and a
category-cliché fence portfolio.me never got; portfolio.me has the deeper technique arsenal;
systemcicy is the only one that knows how to design a tool rather than a page. inter.face is
the union of their design halves, made canonical. Full lineage in the
[design spec](./docs/superpowers/specs/2026-07-28-inter-face-design.md).

This is a general failure of design guidance kept as prose, not PIIIX housekeeping. The
[imagegen audit](./docs/audit/competitor-imagegen.md) found the same thing in someone else's
skills directory: `imagegen-frontend-web` and `image-to-code` are the same file forked — 191
lines still literally identical — and each fork has since grown what the other lacks. The web
fork gained composition anchors and a set-level anti-repeat check; the code fork gained
extraction rules and anti-drift. Neither got the other's additions.

## What is genuinely new — and what is not

**New:** nothing in the surveyed landscape (four competitor audits, in
[`docs/audit/`](./docs/audit/gap-audit-parents.md)) builds a runnable proof of a design
technique, measures its frame rate under load, prices it in bytes, and returns a verdict
*before* the design commits. That is Loop 2, and it is the product.

**Not new:** Loop 1 — direction, palette, concepts, images — overlaps substantially with
existing tools. gstack's `/design-consultation` and `/design-shotgun` already do most of it,
and they are good. Shipping Loop 1 alone would be a less-integrated `design-consultation` with
a better style catalog.

The other real additions, stated without inflation: a style vocabulary with collision
(32 entries across seven families, each with implementation implications and a named failure
mode); performance budgets declared at design time rather than graded after; tool-shaped
surfaces designed rather than classified; and portability — plain markdown across seven
agents, no Node app, no runtime, no git preconditions.

## How an agent reads it

The corpus is 5,435 lines across eleven reference files. No agent should read it all.

- **One resident router.** [`AGENTS.md`](./AGENTS.md) is the only always-loaded file, budgeted
  at 200 lines and enforced by [`scripts/check.sh`](./scripts/check.sh).
- **Phase-scoped reading.** The router's routing table names what each phase reads. A typical
  page-shaped Loop 1 loads ~1,750 of the 5,435 lines; its Loop 2 loads ~1,260. Loop 1 never
  opens `CRAFT.md`; Loop 2 never re-opens `STYLES.md`.
- **Section-level entry for exactly two files.** `ACCESS.md` is entered at its §13 decision
  list (45 of 1,357 lines) and `SURFACES.md` at §1–§3, each with follow-the-pointer escapes
  into the body. Every other file is entered whole — one extra file-read hop costs more than
  500 resident lines, which is why the corpus is eleven files and not forty.

## What is enforced where

The honest version, because it differs by agent:

- **On Claude Code**, the `tools:` lists in the `agents/` frontmatter are hard capability
  restrictions enforced by the harness — the direction conductor cannot open a browser, the
  prototyper cannot deploy — and subagent context isolation is real: a subagent does not
  inherit the session's context, which is what actually enforces phase-scoped reading.
- **On Codex, Cursor, Cline, Windsurf, Gemini, and opencode**, none of that is enforced. A
  frontmatter key nobody reads is not a fence. There the protocol degrades to the resident
  router plus `scripts/check.sh`, and the `tools:` lists bind as instructions, not walls.

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

A checkable quality claim: every number in the reference files traces to
[`docs/research/`](./docs/research/accessibility-wcag.md), and everything there was read off
rendered primary sources with a headless browser — not summarizer output, not memory. That
discipline exists because this project caught **five** plausible-but-wrong claims on the way
in, each documented in the research docs:

1. A summarizer returned invented WCAG 2.5.8 exception wording that appears nowhere in the
   spec (`docs/research/accessibility-wcag.md`).
2. A summarizer invented a security exception for WCAG 3.3.8 — wording that would have shipped
   a non-existent carve-out (`docs/research/accessibility-wcag.md`).
3. A Liquid Glass quote attributed to Apple's Materials page whose wording does not occur
   anywhere on that page (`docs/research/mobile-native-verified.md`).
4. A claim that contradicted its own cited source
   (`docs/research/legal-and-focus-verified.md`).
5. "Apple's minimum touch target is 44×44pt" — repeated in most design skills, and wrong: 44
   is the *default*; Apple's published iOS minimum is 28×28pt
   (`docs/research/platform-numbers-verified.md`).

If a fact did not verify, the files say so instead of filling the gap from memory.

## Install

Everything is markdown; installing means making `AGENTS.md` reachable by your agent. Clone
`github.com/PIIIX-org/inter.face` (or vendor it into your project) and use the adapter for
your agent family:

**Claude Code.** Install from the plugin marketplace: `/plugin marketplace add
PIIIX-org/inter.face`, then install `inter.face`. This wires up the `/interface` command, the
skill at `skills/inter.face/SKILL.md`, and the five subagents under `agents/` with their
`tools:` restrictions enforced.

**Codex.** `.codex-plugin/plugin.json` points `contextFile` at `AGENTS.md`; place the repo
where Codex discovers plugins and the router loads on its own.

**Cursor.** `.cursor/rules/inter.face.mdc` ships as a non-always-applied rule: it sends the
agent to `AGENTS.md` and `PRINCIPLES.md`, sets surface class first, and holds the two gates.

**Cline / Windsurf.** `.clinerules` and `.windsurfrules` carry the same pointer as plain
prose — copy the file (or its contents) into your workspace rules.

**Gemini.** `gemini-extension.json` declares `AGENTS.md` as the extension's context file.

**opencode.** `opencode.json` loads `AGENTS.md` as instructions; the router routes to the
rest on demand.

## License

[MIT](./LICENSE) — Copyright (c) 2026 PIIIX. Parents credited above: portfolio.me, webcrab,
systemcicy.
