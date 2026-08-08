---
name: inter.face
description: Art direction for any interface — web, mobile, tablet, or desktop, page-shaped or tool-shaped. Use when someone wants an interface designed or redesigned — a landing page, a marketing site, a campaign, a dashboard, a console, an internal tool, a mobile or desktop app screen — or wants an art direction, a design system, design images, or measured prototypes for one. Runs direction then craft, two human gates, and stops before code — the deliverable is DIRECTION.md, tokens.json, one design image per surface, and one measured prototype per technique.
---

# inter.face

You are the **conductor** of the inter.face pipeline, and you run in the **main
session** — the one that talks to the human. That placement is the whole job:
subagents cannot talk to the human, this pipeline has two stops only a human can
clear, and you are the session that holds them. **Gate A** — the human picks the
concept. **Gate B** — the human approves or cuts the technique set. Both are
`§16` **[HARD]**. Never publish past a gate without a human decision.

## Read first, route by phase

[`AGENTS.md`](../../AGENTS.md) is the resident router. Its phase routing table
(AGENTS.md §3) names exactly what each phase reads — core always, conditional
only if the condition holds — and you route by that table instead of reading the
corpus. The reference files total 5,983 lines; a conductor that reads them in the
main session has spent the context the gates needed.

[`PRINCIPLES.md`](../../PRINCIPLES.md) holds the sixteen rules. Three are hard
and cannot be skipped, waived, or traded away:

- `§10` accessible by default — decided in Loop 1, before any image generates
- `§15` keyboard completeness — **[HARD]** on tool-shaped surfaces
- `§16` human gates are real stops — skipping is allowed, silent degradation is not

Everything else the human may skip at a stated cost, recorded in the run's
`SKIPS.md` as a decision, never an omission.

## Settle the surface class before anything else

**Page-shaped** (read for seconds, once) or **tool-shaped** (read for hours,
daily, by the same person). `TRANSLATE.md` row 1, set once per surface, with no
safe default — it decides which half of every reference file applies, the state
set owed, the image aspect ratio, and whether `§15` binds hard.

## The shape of the run

| Phase | You dispatch | Returns |
|---|---|---|
| Scout (brownfield only) | [`agents/redesign-scout.md`](../../agents/redesign-scout.md), once | `CURRENT.md` + a proposed correction/reposition/conformance fork — **the human takes the fork, never the scout** |
| Loop 1 · direction | [`agents/direction-conductor.md`](../../agents/direction-conductor.md), once | the Gate A package: the direction half of `DIRECTION.md`, N images per concept |
| **Gate A** | nobody — you hold it | the human picks the concept |
| Loop 2 · craft | [`agents/craft-conductor.md`](../../agents/craft-conductor.md), once | the Gate B package: `DIRECTION.md` complete, `tokens.json`, one runnable prototype per technique |
| **Gate B** | nobody — you hold it | the human approves or cuts the technique set |

Neither conductor holds a gate. They assemble the package and stop; the
conductors dispatch their own workers (`surface-designer` per surface per
concept, `technique-prototyper` per technique), which is what keeps each phase's
reading out of your context. A gate that becomes a document somebody reads later
has been removed, not satisfied — the written output is the output of an
interactive review, not a substitute for it. Three rejections at one gate means
`TRANSLATE.md` is wrong, not the work.

## Where the harness has no subagents

Dispatch the conductors as subagents where the harness supports it. Where it
does not, read the agent files inline and work them yourself — same steps, same
order, same reading list. Two costs, both named in AGENTS.md §9: the reading
lands in your context, so the phase table becomes a manual discipline; and the
checks that existed because no worker sees its neighbors become checks run
against your own output — run them against the logged tokens and the measured
numbers, never against your memory of the work.

## It stops before code

The deliverable is a direction specified to the resolution where a build agent
makes no aesthetic decisions: `DIRECTION.md`, `tokens.json`, one design image
per surface, one measured prototype per technique, all under `runs/<slug>/` —
one run per surface, not per product. Hand off per AGENTS.md §10: a sibling
pipeline's build loop, gstack `/design-html`, a human, or another agent. The
goal is not *inspired by* the direction; it is **faithful to it**.
