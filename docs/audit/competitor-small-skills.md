# Competitor audit — small design skills + the user's own gstack tooling

**Date:** 2026-07-28
**Read against:** `docs/superpowers/specs/2026-07-28-inter-face-design.md`
**Quality bar applied:** guidance counts if it is (a) a decision procedure, (b) a named failure with its opening/escape, or (c) a checkable rule. A list to browse does not count.

Files read in full:

| Skill | Path | Lines |
|---|---|---|
| gpt-taste | `/Users/taha/.claude/skills/gpt-taste/SKILL.md` | 74 |
| stitch-design-taste | `/Users/taha/.claude/skills/stitch-design-taste/SKILL.md` + `DESIGN.md` | 184 + 121 |
| high-end-visual-design | `/Users/taha/.claude/skills/high-end-visual-design/SKILL.md` | 98 |
| redesign-existing-projects | `/Users/taha/.claude/skills/redesign-existing-projects/SKILL.md` | 178 |
| minimalist-ui | `/Users/taha/.claude/skills/minimalist-ui/SKILL.md` | 85 |
| industrial-brutalist-ui | `/Users/taha/.claude/skills/industrial-brutalist-ui/SKILL.md` | 92 |
| gstack design-consultation | `/Users/taha/.claude/skills/gstack/design-consultation/SKILL.md` + `sections/proposal-and-preview.md` | 1231 + 408 |
| gstack design-review | `/Users/taha/.claude/skills/gstack/design-review/SKILL.md` | 1994 |
| gstack design-shotgun | `/Users/taha/.claude/skills/gstack/design-shotgun/SKILL.md` | 1373 |
| gstack plan-design-review | `/Users/taha/.claude/skills/gstack/plan-design-review/SKILL.md` + `sections/review-sections.md` | 1514 + 616 |
| gstack design-html | `/Users/taha/.claude/skills/gstack/design-html/SKILL.md` | 1511 |
| gstack devex-review | `/Users/taha/.claude/skills/gstack/devex-review/SKILL.md` | 1305 |
| (reference) gstack DESIGN.md | `/Users/taha/.claude/skills/gstack/DESIGN.md` | 86 |
| (reference) our parent | `/Users/taha/Documents/portfolio.me/STYLES.md` | 389 |

---

## 1. Per-skill: what it is, its structure, its one good idea

### gpt-taste

A single-prompt persona for "Awwwards-level" React/GSAP landing pages. Eight numbered sections: randomization, AIDA structure, hero architecture, bento grid, GSAP motion, component arsenal, bans, and a mandatory `<design_plan>` pre-flight. No files, no loops, no gates.

**One good idea: the pre-flight block with arithmetic in it.** Section 8 forces the model to emit a `<design_plan>` before any code, and two of its five checks are actually verifiable rather than aspirational:

> **Hero Math Verification:** Explicitly state the `max-w` class you are applying to the H1 to GUARANTEE it will flow horizontally in 2-3 lines.
> **Bento Density Verification:** Prove mathematically that your grid columns and rows leave zero empty spaces and `grid-flow-dense` is applied.

Naming a specific structural failure ("4, 5, or 6 lines is a catastrophic failure") and making the model state the class that prevents it is a checkable rule, not a vibe. Everything else in the file is a list.

### stitch-design-taste

A meta-skill: it generates a `DESIGN.md` for Google Stitch rather than producing design itself. Nine analysis instructions (atmosphere → color → type → hero → components → layout → responsive → motion → anti-patterns) mapped one-to-one onto a seven-section output template. Ships a worked example `DESIGN.md`.

**One good idea: three named dials with described endpoints, set before anything else.**

> | **Variance** | `8` | `1` = Predictable, symmetric grids. `5` = Subtle offsets. `10` = Artsy chaotic, no two sections alike.

Density / Variance / Motion with concrete endpoint descriptions is a compact way to make a design brief comparable across runs, and "Default baseline: Variance 8, Motion 6, Density 4" gives an agent a defensible starting position. It's the closest thing in the corpus to a numeric brief. (Whether the rest of the file actually honors the dials — it mostly doesn't — is §6.)

### high-end-visual-design

An "agency-tier" persona for React/Tailwind. Eight sections: anti-patterns, a variance engine (3 vibes × 3 layouts), haptic component patterns, motion choreography, performance guardrails, a five-step execution protocol, and an 11-item pre-output checklist.

**One good idea: the Double-Bezel, specified as concentric geometry rather than as a look.**

> **Inner Core:** ... a mathematically calculated smaller radius (e.g., `rounded-[calc(2rem-0.375rem)]`) for concentric curves.

`inner radius = outer radius − gap` is a real, checkable craft rule with a physical justification (concentric curves read as machined). It also has the only three mobile-collapse rules in the corpus written per-layout rather than as a blanket breakpoint, e.g. for Z-Axis Cascade: "Remove all rotations and negative-margin overlaps below `768px`... Overlapping elements cause touch-target conflicts on mobile." That's a named failure with its escape.

### redesign-existing-projects

The only skill in the corpus aimed at existing work. Three-phase spine (Scan → Diagnose → Fix), a ~120-item audit across nine categories, an Upgrade Techniques menu, a seven-step Fix Priority ordering, and six operating Rules. Covered in depth in §3.

**One good idea: Fix Priority as an impact-per-risk ladder.**

> 1. **Font swap** — biggest instant improvement, lowest risk
> 2. **Color palette cleanup** ... 3. **Hover and active states** ... 7. **Polish typography scale and spacing** — the premium final touch

Ordered by (visual delta ÷ blast radius), not by category. It converts a 120-item list into a decision procedure. No other skill here — including gstack's — sequences its findings by risk.

### minimalist-ui

One aesthetic, completely specified, in 85 lines. Eight sections: overview, bans, typographic architecture, palette, component specs, iconography/imagery, motion, execution protocol.

**One good idea: color specified as paired swatch + foreground, so the accent can never fail contrast.**

> - Pale Red: `#FDEBEC` (Text: `#9F2F2D`)
> - Pale Blue: `#E1F3FE` (Text: `#1F6C9F`)
> - Pale Green: `#EDF3EC` (Text: `#346538`)
> - Pale Yellow: `#FBF3DB` (Text: `#956400`)

Four tokens, each a *pair*. An agent cannot pick a pastel background and then invent a text color on top of it. Our `STYLES.md` handles this after the fact, in the accessibility table, as a repair. This handles it at definition time, as a shape. That is strictly better.

### industrial-brutalist-ui

One aesthetic that internally forks into two committed substrates. Eight sections: meta, two visual archetypes, three-tier typography, color per substrate, layout, symbology, post-processing, engineering directives.

**One good idea: a CSS mechanism that produces the aesthetic's signature for free.**

> **Grid Determinism:** Utilize `display: grid; gap: 1px;` with contrasting parent/child background colors to generate mathematically perfect, razor-thin dividing lines without complex border declarations.

That is a `CRAFT.md`-grade technique: one line, zero cost, hairline rules that never double up at intersections and never round wrong at nested corners. It belongs in "the cheap wins."

Runner-up, and the more architecturally interesting one: it is the only skill in the corpus that answers **style under density** — the section our spec lists as "New, from neither":

> **Bimodal Density:** Layouts oscillate between extreme data density (tightly packed monospace metadata clustered together) and vast expanses of calculated negative space framing macro-typography.

### gstack design-consultation

A conversational design-system builder: Phase 0 pre-checks → Phase 1 product context (+ taste profile) → Phase 2 optional competitive research via headless browser → outside voices (Codex + Claude subagent in parallel) → Phase 3 the complete proposal → Phase 4 drill-downs → Phase 5 mockups + comparison board → Phase 6 write `DESIGN.md`. Output is a `DESIGN.md` with Product Context / Aesthetic Direction / Typography / Color / Spacing / Layout / Motion / Decisions Log.

**One good idea: the SAFE/RISK split, with the reasoning for why coherence is not enough.**

> The SAFE/RISK breakdown is critical. Design coherence is table stakes — every product in a category can be coherent and still look identical. The real question is: where do you take creative risks? The agent should always propose at least 2 risks, each with a clear rationale for why the risk is worth taking and what the user gives up.

Honourable mentions, all three genuinely good and all three absent from our spec: the **memorable-thing forcing question** ("What's the one thing you want someone to remember after they see this product for the first time?... Design that tries to be memorable for everything is memorable for nothing"); the **anti-convergence directive across generations** ("If the user's prior session used Geist + dark + editorial, propose something different this time... Convergence across generations is slop"); and the **embarrassment self-gate** before showing any mockup ("Would a human designer be embarrassed to put their name on this?" — with an explicit trigger list and a hard reject).

### gstack design-review

Post-build visual QA on a live URL, with a fix loop. Eleven phases: first impression → design-system extraction → page audit (10 categories, ~80 items) → interaction flow → cross-page consistency → report → triage → fix loop → final audit → report → TODOS. Dual headline grades (Design Score, AI Slop Score), regression mode against a stored `design-baseline.json`.

**One good idea: Phase 2 extracts the *rendered* design system from the live DOM, not the stated one.**

```
$B js "JSON.stringify([...new Set([...document.querySelectorAll('*')].slice(0,500).map(e => getComputedStyle(e).fontFamily))])"
```

Four one-liners recover fonts-in-use, the real color palette, the heading scale, and every interactive element under 44px — then it offers to write that up as `DESIGN.md`. This is the audit-first primitive `redesign-existing-projects` is missing and that our spec has no story for at all (§3).

Runner-up: the fix loop self-regulates with a **risk formula and a hard cap** — `+15%` per revert, `+5%` per component-file change, `+20%` for touching unrelated files, stop above 20%, hard cap 30 fixes.

### gstack design-shotgun

Visual brainstorming. Session detection → context gathering (5 dimensions) → taste memory → concept generation → concept confirmation → N parallel subagents each generating one variant → comparison board over HTTP → structured feedback JSON → save `approved.json`.

**One good idea: anti-convergence with a falsifiable test.**

> **Anti-convergence directive (hard requirement):** Each variant MUST use a different font family, color palette, and layout approach... Concrete test: if someone could swap the headline text between two variants without noticing, they're too similar. Variants should feel like they came from three different design teams, not the same team at three different coffee levels.

That is the single most stealable line in the entire corpus. It converts "make them distinct" — which every skill here asserts and none enforces — into something a model can actually check against its own output.

### gstack plan-design-review

Design review of a *plan*, before implementation. Hard scope gate as the literal first tool call → pre-review system audit → Step 0 rate 0-10 → Step 0.5 mockups by default → outside voices with a litmus scorecard → 7 passes (Information Architecture, Interaction State Coverage, User Journey & Emotional Arc, AI Slop Risk, Design System Alignment, Responsive & Accessibility, Unresolved Decisions) → required outputs → implementation tasks as markdown + JSONL → completion summary → review report appended to the plan file.

**One good idea: the anti-shortcut clause, which names the exact way a gate gets written past.**

> The plan file is the OUTPUT of the interactive review, not a substitute for it. Writing every finding into one plan write and calling ExitPlanMode without firing AskUserQuestion is the precise failure mode of the May 2026 transcript bug — the model explored, found issues, and dumped them into a deliverable rather than walking the user through them... If you have ANY non-trivial finding in any review section, the path from finding to ExitPlanMode goes THROUGH AskUserQuestion.

A named failure, its mechanism, and the structural rule that closes it. Both our gates need this verbatim in spirit.

Runner-up: **Pass 7's deferred-decision table**, which prices ambiguity rather than just listing it —

```
DECISION NEEDED                  | IF DEFERRED, WHAT HAPPENS
What does empty state look like? | Engineer ships "No items found."
Mobile nav pattern?              | Desktop nav hides behind hamburger
```

### gstack design-html

Turns an approved mockup into runnable HTML using Pretext (computed text layout). Input detection with four routing cases (approved.json / plan context / clean slate / evolve) → design analysis → Pretext tier routing → framework detection → generation → live-reload server → refinement loop (max 10) → save + optional `DESIGN.md` token extraction.

**One good idea: routing the *technique* off a classification of the design, in a table.**

> | Chat/messaging UI | `prepareWithSegments()` + `walkLineRanges()` | Tight-fit bubbles, min-width |
> | Content-heavy (editorial, blog) | `prepareWithSegments()` + `layoutNextLine()` | Text around obstacles |

Five design types → five specific API pairings → the capability each unlocks. That is exactly the shape our `CRAFT.md` technique assignment should have: not "here are techniques," but "this kind of surface takes this technique because it buys you this."

### gstack devex-review

Developer-experience audit of a live developer product. Eight scored dimensions, TTHW (time-to-hello-world) benchmarks, boomerang comparison against the plan-stage scores. No design overlap.

**One good idea: every score carries its evidence method.**

> | Getting Started | __/10 | [screenshots] | TESTED |
> | Upgrade Path | __/10 | [file refs] | INFERRED |

Plus the scope declaration that makes it honest: "Browse CANNOT test: CLI install friction, terminal output quality... For untestable dimensions... mark as INFERRED from artifacts. **Never guess. State your evidence source for every score.**" A verdict without its provenance is an opinion wearing a number.

---

## 2. The single-style-skill format — verdict

The question: `minimalist-ui` and `industrial-brutalist-ui` each encode ONE aesthetic completely. Our `STYLES.md` carries seven families / 34 styles and asks the agent to shortlist. Which produces better design?

### They are not the same kind of object

A `STYLES.md` entry is a **brief**. Here is glassmorphism, in full:

> **Glassmorphism.** Translucent panels over a substrate worth seeing through to, legible from the blur behind them, never from a fill. Depth reads as blur radius, nearest layer blurring hardest, each panel edged with a 1px light-catching border. **Implies** `backdrop-filter`, z-layering, `color-mix()` borders. **Fails** as gray rectangles on a flat background, and breaks `§12` under body copy. **Right when** the background is itself content.

Zero numbers. Every value — blur radius, border color, opacity, scrim strength — still has to be invented downstream.

A single-style skill is a **rendered style**. Here is minimalist-ui on the same territory:

> - Cards must have exactly `border: 1px solid #EAEAEA`.
> - Border-radius must be crisp: `8px` or `12px` maximum.
> - Internal padding must be generous (e.g., `24px` to `40px`).
> - Body text must never be absolute black... Use off-black/charcoal (`#111111` or `#2F3437`) with a generous `line-height` of `1.6`. Secondary text should be muted gray (`#787774`).

Every value decided. An agent can execute this with no further decisions and no taste. It will also produce Notion, every time, forever.

### What each format can and cannot do

| | Single-style skill | Our STYLES.md |
|---|---|---|
| Executable without further decisions | **Yes** — hex, px, ms all present | No — every value still to be invented |
| Contrast guaranteed at definition time | **Yes** — paired swatch+text tokens | No — repaired later in the a11y table |
| Answers "which style, and why this one" | No — you already chose by invoking it | **Yes** — five-input picking procedure |
| Names the style's own failure mode | Partially (bans only) | **Yes** — "**Fails** as..." on all 34 |
| Escape from looking like everyone else | **None** | **Yes** — collision, subversion, invention |
| Two styles in tension | Impossible — no interop between skills | **Yes** — the collision table is the point |
| Behavior under 40 rows of data | industrial-brutalist: yes. minimalist: no. | Not yet (spec lists it as new work) |
| Light and dark as two designs | No — each picks one substrate and commits | **Yes** — seven styles get per-mode direction |
| Discoverable by an agent that doesn't know it wants this | **Yes** — the frontmatter description routes | No — one plugin, one entry point |

The decisive asymmetry: **a single-style skill is definitionally convergent.** `industrial-brutalist-ui` even says so out loud and treats it as a virtue — "Pick ONE per project and commit to it. Do not alternate or mix both modes within the same interface." That is correct advice *within a run* and fatal *across runs*. Two projects that both invoke `minimalist-ui` are siblings. Nothing in the format can prevent it, because the format's entire value proposition is that the aesthetic is pre-decided.

Our `STYLES.md` is built around the opposite claim, stated in its own guardrails:

> **The vocabulary names a starting position, never a destination.** Ship a named style unmodified and the run failed. No entry above is a finished answer.

A shelf of 34 single-style skills would be a shelf of 34 destinations. The collision table — "Risograph texture on a Swiss grid," "Terminal chrome around a physics world" — is not expressible as a skill-per-style at all. You cannot invoke two skills and get tension; you get the second one overwriting the first.

### Verdict

**The single-style skill is the wrong unit for input and the right shape for output.**

Keep `STYLES.md` as the catalog. It is doing a job — selection, collision, failure modes, per-style a11y repair, per-style light/dark — that no single-style skill does or can do. Do not fragment it.

But steal the format for the far side of Gate A. Right now the spec describes `DIRECTION.md` as carrying "the palette with sampled sources, the type system, the technique assignment per surface, the motion spec" without saying what resolution that means. **The answer is: `DIRECTION.md` should read like `minimalist-ui/SKILL.md`.** Not "warm monochrome with muted pastel accents" but `#F7F6F3` canvas, `#EAEAEA` rules, `8px`/`12px` radii, paired accent+foreground tokens, `600ms cubic-bezier(0.16, 1, 0.3, 1)` scroll entry. A `DIRECTION.md` at brief resolution hands the build step the same invention problem we just solved; a `DIRECTION.md` at single-style-skill resolution is executable by any of the seven agents without taste.

Concretely, this makes the pipeline: **catalog in (34 briefs) → one collision picked → one rendered style out (a bespoke `minimalist-ui`-shaped artifact that has never existed before).** The single-style skill is what we should be *producing*, one per run.

Two secondary steals from the format:
- **Paired color tokens** (`swatch` + `text`), so contrast is structural rather than audited.
- **The density line.** `industrial-brutalist-ui`'s "Bimodal Density" is a working answer to the section the spec marks as new. It also proves the spec's premise that "some collapse — that is worth knowing at Gate A rather than at build": `minimalist-ui`'s 24–40px card padding, 1.6 line-height, and `max-w-4xl` constraint mean it cannot hold forty rows at all. That is a Gate A finding, and today nothing surfaces it.

One thing not to steal: their frontmatter promises reach beyond what the body delivers. `industrial-brutalist-ui` advertises "data-heavy dashboards" and then gives dashboards exactly two sentences (bimodal density, semantic `<data>`/`<output>` tags) out of 92 lines. Ours forks properly with `TOOLS.md`.

---

## 3. redesign-existing-projects — the method, extracted

Our spec is greenfield-only. This is the only skill in the corpus with a story for existing work, and its method is worth having in full.

### The spine

> 1. **Scan** — Read the codebase. Identify the framework, styling method (Tailwind, vanilla CSS, styled-components, etc.), and current design patterns.
> 2. **Diagnose** — Run through the audit below. List every generic pattern, weak point, and missing state you find.
> 3. **Fix** — Apply targeted upgrades working with the existing stack. Do not rewrite from scratch. Improve what's there.

Three moves. The load-bearing one is the constraint in step 3: the existing stack is a fixed input, not a thing to be corrected.

### The four transferable mechanisms

**1. Every audit item is a symptom paired with its remedy.** Not "use good typography" but:

> - **Orphaned words.** Single words sitting alone on the last line. Fix with `text-wrap: balance` or `text-wrap: pretty`.
> - **Random dark sections in a light mode page (or vice versa).** A single dark-background section breaking an otherwise light page looks like a copy-paste accident. Either commit to a full dark mode or keep a consistent background tone throughout.
> - **Buttons not bottom-aligned in card groups.** When cards have different content lengths, CTAs end up at random heights. Pin buttons to the bottom of each card so they form a clean horizontal line.
> - **Mathematical alignment that looks optically wrong.** Centering by the math doesn't always look centered to the eye. Icons next to text, play buttons in circles, or text in buttons often need 1-2px optical adjustments.

This is our quality bar (b) — named failure with its escape — executed ~120 times. It is the densest instance of our own standard anywhere in the corpus, including our own files.

**2. Fix Priority — sequence by impact ÷ risk.** Quoted in §1. Font swap first because it is the largest visible delta for the smallest blast radius; typography polish last because it is the smallest delta at the highest fiddliness. An audit without an order is a backlog; with an order it is a plan.

**3. Strategic Omissions — a separate axis for what AI *forgets* vs. what it does *wrong*.**

> - **No legal links.** ... - **No "back" navigation.** Dead ends in user flows. ... - **No custom 404 page.** ... - **No form validation.** ... - **No "skip to content" link.** ... - **No cookie consent.**

Absence is invisible to a defect scan. This list is the one thing a reviewer looking at a screen will never generate, because nothing on the screen prompts it.

**4. Rules that protect the host.**

> - Work with the existing tech stack. Do not migrate frameworks or styling libraries.
> - Before importing any new library, check the project's dependency file first.
> - If the project uses Tailwind, check the version (v3 vs v4) before modifying config.
> - Keep changes reviewable and focused. Small, targeted improvements over big rewrites.

### What it does NOT do — and this is the gap we'd have to fill

**It never extracts the existing design system.** It goes straight from Scan (framework detection) to Diagnose (defect list). There is no step that asks *what is this site's current position*, whether that position is defensible, or what the redesign is preserving. Every finding is a defect; nothing is a decision. That works for a generic AI-slop site and fails on anything with real prior art — it would cheerfully "fix" a deliberate brutalist site into a premium one, since raw system fonts and default link blue are on its defect list and are also the entire point of `STYLES.md`'s Brutalism entry.

**It has no gate and no verification.** Scan → Diagnose → Fix in one pass, with no human stop. Its rules say "Do not break existing functionality. Test after every change" but supply no test, no re-screenshot, and no revert path. Compare gstack `/design-review`, operating on the same territory, which per fix does: locate source → optional target mockup → minimal fix → one atomic commit → re-screenshot + console check → classify `verified` / `best-effort` / `reverted` → and every 5 fixes recompute a risk score with a hard cap of 30. The small skill is more dangerous exactly where it operates.

### The redesign method for inter.face, assembled

Neither source has the whole thing. The composite:

1. **Extract the rendered system** — gstack `design-review` Phase 2's four DOM queries (fonts-in-use, palette, heading scale, sub-44px targets) plus `$B perf`. Output is a `CURRENT.md`: what this surface actually is today, measured, not described.
2. **Position it against `STYLES.md`** — which of the 34 is it closest to, and is that a choice or an accident? A site that is 80% Swiss is a Swiss site with drift; a site that is 30% of six styles is a site with no position. Different problems, different fixes.
3. **Classify the ask, and this is a fork not a slider** — is this a **correction** (the position is right, execution has drifted) or a **reposition** (the position itself is wrong)? Correction runs `redesign-existing-projects`' audit + Fix Priority against the extracted system. Reposition runs the normal Loop 1 with `CURRENT.md` as an input constraint, plus one new question our greenfield path never asks: *what is load-bearing and must survive?* That maps cleanly onto `TRANSLATE.md` row 6 ("What is already owned"), which is the row that already exists for exactly this and is currently only reachable via a human filling it in.
4. **Reuse the gate rejection diagnosis.** The spec already distinguishes a rejected execution from a rejected concept from a rejected brief. Correction-vs-reposition is the same distinction one level up, and three rejections at that fork means the ask was a reposition all along.

This is a `REDESIGN.md` plus one branch at the top of `loops/01-direction.md`. It is not a second pipeline.

---

## 4. gstack — where we overlap, where we add

Blunt version first: **Loop 1 of inter.face is roughly 70% already built inside `/design-consultation` + `/design-shotgun`, and those two are good.** If inter.face shipped Loop 1 only, it would be a less-integrated `design-consultation` with a better style catalog. Loop 2 is where the genuine new capability is.

### Overlap map

| Our piece | gstack equivalent | Honest assessment |
|---|---|---|
| `TRANSLATE.md` (6-row intake) | `design-consultation` Phase 1 + memorable-thing question | **They're ahead on one row.** Their "what's the one thing you want someone to remember" beats our row 3 ("the three-second feel") because it forces a single answer and states the failure ("memorable for everything is memorable for nothing"). Steal it. |
| `STYLES.md` | `design-consultation`'s 10 aesthetic one-liners ("Brutally Minimal — Type and whitespace only. No decoration. Modernist.") | **We are far ahead.** No collision, no per-style failure mode, no per-style a11y repair, no light/dark-as-two-designs, no invention clause. Their list is a menu; ours is a vocabulary. |
| Loop 1 concepts (2-3 distinct) | `design-shotgun` Step 3a concepts + anti-convergence swap test | **They're ahead on enforcement.** We assert distinctness; they test it. Steal the swap test verbatim. |
| `surface-designer`, one image per surface | `design-shotgun` Step 3c — N parallel subagents, one variant each, `/tmp` then `cp`, retry-on-429, per-agent quality check | **Already built, and battle-scarred.** They document a real sandbox failure ("`$D generate --output ~/.gstack/...` failed with 'The operation was aborted' while `--output /tmp/...` succeeded"). Their parallel-dispatch pattern is directly reusable. |
| Gate A | `design-shotgun` / `plan-design-review` comparison board + `feedback.json` + "the comparison board IS the chooser" | **They're ahead.** A served HTML board with ratings, per-variant comments, remix, and structured JSON out is a materially better gate than a chat prompt. Also: their **anti-shortcut clause** is the thing that keeps a gate from being written past. |
| `DIRECTION.md` | `DESIGN.md` (design-consultation Phase 6) | **Same artifact, ~80% overlap.** Their template already carries Product Context / Aesthetic / Typography / Color / Spacing / Layout / Motion / Decisions Log, and the real `~/.claude/skills/gstack/DESIGN.md` is a good example of the form. Ours adds: technique per surface, motion spec, two budget tiers, and "what this run invented." |
| `CRAFT.md` + `technique-prototyper` | **Nothing.** | **This is the whole genuine addition.** gstack measures LCP/CLS on a *finished* site in `design-review` Phase 10. Nobody anywhere in gstack builds a standalone runnable proof of a technique, measures its frame rate under load, prices it in bytes, ships its reduced-motion and fallback states, and returns ship / cut / ship-with-caveat *before* the design commits to it. "Prototype before you design around it" has no counterpart. |
| `TOOLS.md` (page vs tool fork) | The MARKETING/LANDING vs APP UI vs HYBRID classifier, with two rule sets | **They had the idea first; we go much deeper.** Their App UI rules are seven bullets ("Calm surface hierarchy, strong typography, few colors / Dense but readable, minimal chrome / ...Cards only when card IS the interaction"). Ours is 13 sections, nine states, keyboard completeness as a hard rule, density as a feature. Credit the classifier as prior art in `AGENTS.md`; do not pretend the fork is novel. |
| Gate B / budget tiers | Nothing at plan time; `design-review` category 10 post-hoc | Genuine addition. |
| Cross-agent packaging | Claude Code only | Genuine addition, and structural: every gstack design skill carries ~800 lines of preamble (telemetry prompts, upgrade checks, brain sync, question tuning, `AskUserQuestion` protocol) before any design content. That is unportable by construction. |
| Design-only output contract | Entangled — `/design-review` refuses to run on a dirty working tree; artifacts are pinned to `~/.gstack/projects/$SLUG/`; review results go to `reviews.jsonl`; plan-mode exceptions are threaded throughout | Genuine addition. Our contract is: a 6-row table in, files out. |
| Redesign path | `design-review` Phase 2 extraction (good), no repositioning story | Partial overlap; §3 covers the composite. |
| `/design-html` | The build step we explicitly excluded | **No overlap, and it's the natural consumer.** `DIRECTION.md` + images + prototypes → `/design-html` is a clean handoff. Worth naming in `AGENTS.md` as one of the "sibling pipeline's Loop 4, or a human, or another agent" options. |
| `/devex-review` | None | No overlap. Only the evidence-labelling format transfers. |

### Where we genuinely add, ranked

1. **Measured prototypes before commitment.** No prior art anywhere in gstack or the six small skills. Also the most expensive thing to build.
2. **A style vocabulary with collision.** 34 entries with failure modes vs. 10 adjectives.
3. **Two budget tiers declared at design time**, rather than a performance grade discovered after the build.
4. **Tool-shaped surfaces designed rather than classified.** Nine states, keyboard completeness as a hard rule, density as a deliverable.
5. **Portability.** Seven agents, plain markdown, no binaries, no `~/.gstack`, no git-state preconditions.

### Where we should not build

- **A comparison board.** `$D compare --serve` exists, works, and returns structured JSON. If the run is inside Claude Code, use it. Our gates should accept a `feedback.json`-shaped input so they can be driven either way.
- **A taste profile.** `design-consultation` and `design-shotgun` share a v1-schema `taste-profile.json` with per-dimension approved/rejected entries and **5%/week confidence decay computed at read time**. That is a nicely-judged piece of design and it is out of our scope (we take a table in; we do not accumulate state across runs). Note it and move on.
- **Competitive research.** `design-consultation` Phase 2 does WebSearch → browse screenshots → three-layer synthesis (tried-and-true / new-and-popular / first-principles) with an explicit Eureka check. `TRANSLATE.md` row 5 (anti-positioning) assumes this work is already done upstream. Keep that assumption.

---

## 5. What to steal, ranked, mapped to our files

| # | Steal | From | Goes into | Why it clears the bar |
|---|---|---|---|---|
| 1 | **The swap test** — "if someone could swap the headline text between two variants without noticing, they're too similar" | design-shotgun | `loops/01-direction.md`, concept generation | Checkable rule. Turns our asserted "2-3 distinct concepts" into something the agent can fail. |
| 2 | **`DIRECTION.md` at rendered-style resolution** — hex, px, ms, paired accent+foreground tokens, not adjectives | minimalist-ui, industrial-brutalist-ui | `loops/02-craft.md` output spec + `PRINCIPLES.md` | The pipeline's whole value is that the build step needs no taste. Brief-resolution output re-opens every decision. |
| 3 | **Correction vs. reposition fork + live system extraction** | redesign-existing-projects (spine, Fix Priority) + design-review Phase 2 (DOM queries) | new `REDESIGN.md` + one branch at the top of `loops/01-direction.md` | Decision procedure. Closes the greenfield-only gap; reuses `TRANSLATE.md` row 6. |
| 4 | **The anti-shortcut clause** — "the plan file is the OUTPUT of the interactive review, not a substitute for it" | plan-design-review `sections/review-sections.md` | Gate A and Gate B definitions in `PRINCIPLES.md` | Named failure with its structural escape. This is precisely how a "real stop" degrades into a paragraph. |
| 5 | **The memorable-thing forcing question** | design-consultation Phase 1 | `TRANSLATE.md` — sharpen row 3, or add as the one question asked when row 3 is blank | Decision procedure + named failure ("memorable for everything is memorable for nothing"). |
| 6 | **SAFE/RISK split**, minimum two risks, each with what it costs | design-consultation Phase 3 | `DIRECTION.md` structure + how Gate A presents | Decision procedure. Coherence is table stakes; this asks the only question that separates runs. |
| 7 | **Evidence labels: TESTED / PARTIAL / INFERRED, never guess** | devex-review | `agents/technique-prototyper.md` verdicts + `DIRECTION.md` | Checkable rule. "60fps" measured on one machine at one viewport is not the same claim as "60fps" inferred; the verdict must say which. |
| 8 | **Fix Priority ladder** (impact ÷ risk ordering) | redesign-existing-projects | `REDESIGN.md`; and the ordering idea → `CRAFT.md` "the cheap wins" | Decision procedure. Our cheap-wins section ranks by return-per-byte; risk is the missing second axis. |
| 9 | **Embarrassment self-gate** before returning any generated image | design-consultation Phase 5 | `agents/surface-designer.md` | Checkable rule with an explicit trigger list. "A mediocre AI mockup is worse than no mockup" — and it is cheaper to reject in the worker than at Gate A. |
| 10 | **Style-under-density, already written** — "Bimodal Density: layouts oscillate between extreme data density and vast expanses of calculated negative space" | industrial-brutalist-ui | `STYLES.md` new density line, per family | The spec marks this as new work. One family's answer already exists; it also proves some styles have no answer. |
| 11 | **Paired color tokens** (`#FDEBEC` / text `#9F2F2D`) | minimalist-ui | `STYLES.md` accessibility section + `DIRECTION.md` palette format | Makes contrast structural instead of audited. Cheaper than the repair table and catches the case the repair table misses (an accent invented at build time). |
| 12 | **Grid determinism** — `display: grid; gap: 1px` with contrasting parent/child backgrounds for hairline rules | industrial-brutalist-ui | `CRAFT.md` — "the cheap wins" | Checkable rule, near-zero bytes, and correct at nested corners where borders are not. |
| 13 | **Deferred-decision pricing table** — decision needed \| if deferred, what happens | plan-design-review Pass 7 | Both gates, and `SKIPS.md` | Decision procedure. `§18` says skipping is allowed but silent degradation is not; this is the format that makes the cost legible at skip time. |
| 14 | **Design-type → technique routing table** (5 design types → specific APIs → what it buys) | design-html Step 2 | `CRAFT.md` technique-assignment section | Decision procedure. Our arsenal is organized by technique family; this organizes by the surface that needs it, which is the direction an agent actually queries. |
| 15 | **Trunk test** — cover everything but the nav; can you still answer what site / what page / what sections / where am I | design-review Phase 3 | `TOOLS.md` navigation-and-IA section | Checkable rule, and a good one for tool-shaped surfaces where nav debt compounds daily. |
| 16 | **Parallel-worker prompt template** with per-agent retry, quality check, and one-line `VARIANT_x_DONE` / `_FAILED` / `_RATE_LIMITED` report contract | design-shotgun Step 3c | `agents/surface-designer.md`, `agents/technique-prototyper.md` | Operational, but the strict single-line report contract is what makes a fan-out legible to the orchestrator. Also inherit the `/tmp`-then-`cp` workaround. |
| 17 | **Per-mode motion/entry defaults with a stated curve** — `translateY(12px)` + `opacity: 0` over `600ms cubic-bezier(0.16, 1, 0.3, 1)`, `IntersectionObserver` never `scroll` listener | minimalist-ui §7, high-end-visual-design §5C | `CRAFT.md` motion section | Checkable rule with a named failure ("`window.addEventListener('scroll')` causes continuous reflows and kills mobile performance"). |
| 18 | **Concentric radius rule** — inner radius = outer radius − gap | high-end-visual-design §4A | `CRAFT.md` typographic/surface craft | Checkable rule; two lines; fixes the single most common nested-card tell. |

Deliberately **not** stealing: the Goodwill Reservoir point system, the letter-grade weighted average, the dial-based DESIGN.md config, banned-font lists as a substitute for choosing (see §6).

---

## 6. What they get wrong

**Simulated randomness is not randomness.** `gpt-taste` §1:

> you MUST simulate a Python script execution in your `<design_plan>` before writing any UI code. Use a deterministic seed (e.g., character count of the user prompt modulo math) to simulate `random.choice()`

`high-end-visual-design` §3 does the same thing with dice: "silently 'roll the dice' and select ONE combination." A model asked to simulate an RNG returns its prior with extra steps — and because the prompt is the seed, similar prompts produce identical "rolls." The goal (variance) is correct and is the same goal our `§1`/`§3` hold. The mechanism is theater. Compare `design-shotgun`, which solves the same problem with a test on the *output* rather than a ritual on the input. Lesson for us: enforce distinctness by checking what came out, never by instructing the model to be random.

**Also, count the space.** `high-end-visual-design` promises "NEVER generate the exact same layout or aesthetic twice in a row" over 3 vibes × 3 layouts = 9 outcomes. Nine. Ours is 34 styles × collision × subversion, which is why the collision table has to survive the merge intact.

**Dials that nothing reads.** `stitch-design-taste` opens with four configurable dials, then writes ~120 rules of which exactly two are conditional on a dial ("Centered Hero layouts BANNED when variance exceeds 4"; "When density exceeds 7, all numbers must use Monospace"). Set Creativity to 1 and the file still bans Inter, still bans centered heroes in the shipped `DESIGN.md`, still mandates inline-image-typography as "the signature creative technique." The two files also disagree: `SKILL.md` says centered heroes are banned *above* variance 4, `DESIGN.md` says they are banned flat. A parameter that doesn't change the output is a lie about configurability. If our `TRANSLATE.md` rows do not each visibly change something downstream, we have the same bug — and the spec's own claim that "a blank row is a design decision downstream with no derivation" is the right defense only if we can point at what each row derives.

**Banned-font lists as a proxy for taste.** All six small skills ban Inter. `industrial-brutalist-ui` then recommends it: "**Optimal Web Fonts:** Neue Haas Grotesk (Black), **Inter (Extra Bold/Black)**, Archivo Black..." A direct contradiction inside one skills directory. gstack is more honest — it separates a genuine blacklist (Papyrus, Comic Sans, Lobster) from "overused fonts (never recommend as primary)" and explains the reasoning for Space Grotesk:

> Space Grotesk is on the list specifically because every AI design tool converges on it as "the safe alternative to Inter." That's the convergence trap. Treat it the same as Inter: only use if the user asks for it by name.

That's the correct framing — the ban is about *convergence*, not about the typeface. Our `CRAFT.md`/`STYLES.md` should say the same thing explicitly, or the rule reads as fashion and gets stale in eighteen months.

**Long unordered lists.** `redesign-existing-projects` has ~120 audit items, `stitch-design-taste` 22 anti-patterns, gstack `design-review` "10 categories, ~80 items." Under our bar most individual lines pass as checkable rules. The *sets* mostly fail, because a 120-item list with no order is a backlog. `redesign-existing-projects` redeems itself with Fix Priority. Nothing else does — gstack's design-review checklist runs 80 items and then weights them into a letter grade, which is ordering for *reporting*, not for *acting*.

**Numeric precision that isn't measured.** gstack's Goodwill Reservoir assigns point values (−15 hidden pricing, −10 format punishment, −5 per ambiguous choice), concedes "These scores are heuristic, not measured," and then prints `FINAL: 35/100 ⚠️ CRITICAL UX DEBT`. The underlying observations are excellent; the arithmetic makes them look measured when they are not — which is exactly the failure `devex-review` gets right two skills over with TESTED/INFERRED. Related: `design-review`'s grade computation — "Each category starts at A. Each High-impact finding drops one letter grade" — means five high findings is an F whether they are five typography nits or five failed contrast ratios. Arithmetic wearing judgment's clothes.

**A fix loop with no revert path.** `redesign-existing-projects` scans, diagnoses, and fixes in one uninterrupted pass on someone's working site, with no gate, no verification step, and no rollback. Its Rules say "Do not break existing functionality. Test after every change" and supply neither a test nor a definition of broken. gstack `/design-review`, operating on the same territory, requires a clean working tree up front, commits one fix at a time, re-screenshots, classifies `verified` / `best-effort` / `reverted`, and self-regulates on a risk score with a hard cap of 30 fixes. Whatever we build for redesign inherits gstack's discipline, not the small skill's.

**gstack's own worst problem is duplication.** The 85-line "UX Principles: How Users Actually Behave" block (three laws, satisficing, billboard design, trunk test, goodwill reservoir, mobile) is inlined **verbatim in four skills**: `design-review`, `design-shotgun`, `plan-design-review`, `design-html`. Same for the Design Hard Rules / AI Slop blacklist (three copies) and the Review Readiness Dashboard (three copies). It is generated from templates, so it's cheap to maintain and expensive to read — every design skill pays ~800 lines of preamble plus several hundred lines of duplicated doctrine before reaching its own content. Our 18-file plan must not converge on this. `STYLES.md`, `CRAFT.md`, and `TOOLS.md` are *read on demand* by the loop that needs them; the loops must not inline them. `plan-design-review`'s own Section index pattern is the right answer and gstack already uses it in two places — "This skill is a decision-tree skeleton. The steps below point to on-demand sections. Read a section in full before doing its step; do not work from memory." Copy that mechanism into `AGENTS.md`.

**Nobody covers native.** Our scope claims web + mobile + tablet + desktop. Across all twelve skills, "mobile" means a breakpoint, "tablet" means `768px`, and "desktop" means `1440px`. Not one line addresses iOS, Android, or a desktop application. `imagegen-frontend-mobile` exists elsewhere in the skills directory but is image generation, not design method. The spec's own out-of-scope note — "For iOS or Android the principles hold... and the arsenal does not" — is the right call, and this audit found zero prior art that would let us do better. State the limit in `AGENTS.md` as planned; do not quietly let the four-platform claim in the scope line imply otherwise.

**One more, aimed at us.** Every skill in this corpus that has a "creativity" or "variance" instruction — all six small ones plus `design-consultation`'s anti-convergence directive — is trying to solve the same problem our `§1` states ("creativity is the baseline"). Six of the seven attempts fail because they instruct the model to *be* creative. The one that works (`design-shotgun`'s swap test) checks the artifact. `PRINCIPLES.md §1` is currently an instruction. It needs a check attached, or it joins them.
