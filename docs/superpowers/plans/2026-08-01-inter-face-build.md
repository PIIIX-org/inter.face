# inter.face Implementation Plan

> **Retraction notice, 2026-08-14.** This plan is a dated historical record of what v0.1 set out to
> build and is left unrevised, but two claims inside it were later withdrawn and are still printed
> below. **Task 4's Liquid Glass rules** ("Never the content layer", "Never mix the two variants;
> never stack glass on glass") overstate or misstate Apple — see `docs/research/mobile-native-verified.md`
> and `SURFACES.md` §4 for the corrected wording and for which parts remain unconfirmed. **The
> "six of seven audited skills" tally** used twice below was recounted to four of five — see
> `docs/audit/competitor-small-skills.md` §6.

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the inter.face plugin — a cross-agent, design-only pipeline that takes a six-row translation table and produces `DIRECTION.md`, `tokens.json`, one design image per surface, and one measured prototype per technique.

**Architecture:** Plain markdown, no runtime. A thin always-resident router (`AGENTS.md`) routes to on-demand reference files. Seven per-agent adapter files all point at that one router. Content is merged from three parent repos plus 10 verified research documents. A shell check script is the test harness.

**Tech Stack:** Markdown, JSON, one bash check script (`jq`, `grep`, `awk` — no dependencies to install).

## Global Constraints

- **Sourcing rule (HARD).** No quotation ships unless it was read off a rendered primary source and is recorded in `docs/research/`. Three fabricated quotes were caught during research; two summarizer fabrications in the WCAG run, one Liquid Glass stacking rule attributed to a page that does not contain it. Any quote whose text cannot be found in `docs/research/*.md` fails `scripts/check.sh`.
- **No placeholder leakage (HARD).** A research workflow returned a literal `"test claim"` sourced to `example.com` that passed schema validation. `scripts/check.sh` greps for `example.com`, `TBD`, `TODO`, `Lorem`, `test claim`, `FIXME` across all shipped markdown. Zero tolerance.
- **Resident budget.** `AGENTS.md` ≤ 200 lines. It is the only always-loaded file.
- **Every reference file opens with its page-shaped and tool-shaped answer**, before any other content. Forking only the loop body was v1's error.
- **No subject-indexed catalogs.** Keying guidance on "what should a *funeral home* look like" is the category reflex mechanized. Key on visual family, surface class, or measurable property only.
- **Attribution.** README credits `portfolio.me`, `webcrab`, `systemcicy` as parents.
- **Identity.** All commits as `Taha-Mahmoodi <85902429+Taha-Mahmoodi@users.noreply.github.com>`. The repo already has this in local git config. Never let the `sadeqisaidmohaddes-star` gh account become active during this work.
- **Apple numbers ship as pairs.** Never "44pt minimum" — always default *and* minimum, per platform. This was the single most-repeated error found in the competitive landscape.

## File Structure

| File | Responsibility | Source |
|---|---|---|
| `AGENTS.md` | Universal entry, routing table, scope + limits. Always resident. | New |
| `PRINCIPLES.md` | 16 rules, 3 hard | portfolio.me `PRINCIPLES.md` subset + systemcicy |
| `TRANSLATE.md` | The 6-row input contract | New, from BRAND/POSITIONING convergence |
| `STYLES.md` | What it looks like: families, picking, clichés, collision, density | pf.me + webcrab merge |
| `CRAFT.md` | How it renders: arsenal, prototypes, budget, motion, **icons** | pf.me + webcrab merge |
| `TOOLS.md` | Tool-shaped surfaces: 9 states, density, keyboard, forms, tables | systemcicy `INTERFACE.md` |
| `SURFACES.md` | Mobile / tablet / desktop platform law + numbers | Research docs |
| `ACCESS.md` | Accessibility as Loop-1 decisions, **+ i18n** | Research docs |
| `REDESIGN.md` | Brownfield: correction vs reposition fork | Audit findings |
| `BREAKING.md` | When to break a rule deliberately | Authored |
| `loops/01-direction.md` | Palette, type, concepts, images → Gate A | pf.me loop 2a + steals |
| `loops/02-craft.md` | Technique, prototypes, motion, budget → Gate B | pf.me loop 2b + steals |
| `agents/surface-designer.md` | One image per surface | pf.me + imagegen steals |
| `agents/technique-prototyper.md` | Runnable measured proof | pf.me |
| `skills/inter.face/SKILL.md` | Claude Code skill entry | New |
| `commands/interface.md` | Slash command | New |
| 7 adapter files | Cross-agent packaging | Copy pattern from portfolio.me |
| `scripts/check.sh` | The test harness | New |
| `README.md`, `LICENSE` | Front door, MIT | New |

**Icons fold into `CRAFT.md`; i18n folds into `ACCESS.md`.** Neither would ever be read by a loop not already reading its parent, and the impeccable audit found that one extra file-read hop cost more than 500 resident lines.

---

### Task 1: The check script

**Files:**
- Create: `scripts/check.sh`

**Interfaces:**
- Produces: `scripts/check.sh` — exits 0 clean, 1 on any violation. Every later task runs it.

- [ ] **Step 1: Write the check script**

```bash
#!/usr/bin/env bash
# inter.face integrity checks. No deps beyond coreutils + jq.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
FAIL=0
fail() { printf '  FAIL: %s\n' "$1"; FAIL=1; }
ok()   { printf '  ok: %s\n' "$1"; }

echo "== placeholder scan =="
# The deep-research harness once returned a literal "test claim" / example.com
# stub that passed schema validation. Never let that reach a shipped file.
HITS=$(grep -rniE 'example\.com|\bTBD\b|\bTODO\b|Lorem ipsum|test claim|FIXME|XXX' \
  --include='*.md' --include='*.json' --include='*.mdc' . \
  2>/dev/null | grep -v '^\./docs/' | grep -v '^\./\.git' || true)
if [ -n "$HITS" ]; then fail "placeholder text in shipped files:"; echo "$HITS" | sed 's/^/    /'
else ok "no placeholders"; fi

echo "== resident budget =="
if [ -f AGENTS.md ]; then
  N=$(wc -l < AGENTS.md | tr -d ' ')
  [ "$N" -le 200 ] && ok "AGENTS.md ${N} lines (<=200)" || fail "AGENTS.md ${N} lines, budget 200"
else fail "AGENTS.md missing"; fi

echo "== json validity =="
for f in .claude-plugin/plugin.json .claude-plugin/marketplace.json \
         .codex-plugin/plugin.json gemini-extension.json opencode.json; do
  if [ -f "$f" ]; then
    jq empty "$f" 2>/dev/null && ok "$f parses" || fail "$f is not valid JSON"
  else fail "$f missing"; fi
done

echo "== skill frontmatter =="
for f in skills/inter.face/SKILL.md commands/interface.md .cursor/rules/inter.face.mdc; do
  if [ -f "$f" ]; then
    head -1 "$f" | grep -q '^---$' && ok "$f has frontmatter" || fail "$f missing opening ---"
  else fail "$f missing"; fi
done

echo "== internal links resolve =="
BROKEN=0
while IFS= read -r line; do
  src=${line%%:*}; target=${line#*:}
  dir=$(dirname "$src")
  [ -e "$dir/$target" ] || { fail "broken link in $src -> $target"; BROKEN=1; }
done < <(grep -rhoE '\]\(\.{1,2}/[^)#]+\)' --include='*.md' . 2>/dev/null \
         | grep -v '^\./docs/' >/dev/null 2>&1; \
         grep -rnoE '\]\((\.{1,2}/[^)#]+)\)' --include='*.md' . 2>/dev/null \
         | grep -v '/docs/' | sed -E 's/^([^:]+):[0-9]+:\]\((.*)\)$/\1:\2/')
[ "$BROKEN" -eq 0 ] && ok "all relative links resolve"

echo "== every reference file forks on surface class =="
for f in STYLES.md CRAFT.md TOOLS.md SURFACES.md ACCESS.md; do
  if [ -f "$f" ]; then
    if grep -qiE 'page-shaped' "$f" && grep -qiE 'tool-shaped' "$f"; then
      ok "$f forks on surface class"
    else fail "$f does not address both page-shaped and tool-shaped"; fi
  fi
done

echo "== Apple numbers ship as pairs =="
if [ -f SURFACES.md ]; then
  if grep -q '44' SURFACES.md && grep -q '28' SURFACES.md; then
    ok "SURFACES.md carries default AND minimum"
  else fail "SURFACES.md must carry 44pt default AND 28pt minimum, never 44 alone"; fi
fi

echo
[ "$FAIL" -eq 0 ] && echo "ALL CHECKS PASS" || echo "CHECKS FAILED"
exit "$FAIL"
```

- [ ] **Step 2: Make executable and run — expect failures**

```bash
chmod +x scripts/check.sh && ./scripts/check.sh
```

Expected: FAIL. `AGENTS.md missing`, all five JSON files missing, all three frontmatter files missing. This is correct — nothing is built yet.

- [ ] **Step 3: Commit**

```bash
git add scripts/check.sh
git commit -m "Add integrity check script

Greps for the placeholder text a broken research workflow once emitted
(example.com, 'test claim'), enforces the 200-line resident budget on
AGENTS.md, validates all adapter JSON, verifies every reference file forks
on surface class, and asserts Apple target numbers ship as default+minimum
pairs rather than the widely-repeated '44pt minimum' error."
```

---

### Task 2: PRINCIPLES.md

**Files:**
- Create: `PRINCIPLES.md`
- Read first: `~/Documents/portfolio.me/PRINCIPLES.md` (268 lines)

**Interfaces:**
- Produces: `§1`–`§16` numbering that every other file cites. Later tasks reference these by number, so the numbering is frozen here.

- [ ] **Step 1: Write PRINCIPLES.md**

Carry these 13 from portfolio.me, **renumbered**, editing each to remove portfolio-specific framing (a "subject" becomes "the subject or product"):

| New § | From pf.me | Rule |
|---|---|---|
| §1 | §1 | Creativity is the baseline |
| §2 | §2 | Out of the box as a hard rule |
| §3 | §3 | Reinvent every component, every run |
| §4 | §4 | Propose, don't just execute |
| §5 | §7 | The work is the hero |
| §6 | §8 | Sample the brand color from reality |
| §7 | §9 | Own every asset |
| §8 | §10 | Generate your visuals |
| §9 | §11 | Anti-slop — **re-aimed at image text** |
| §10 | §12 | Accessible by default **[HARD]** |
| §11 | §13 | Performance in two tiers |
| §12 | §14 | Verify live |
| §13 | §17 | Respect language and script |
| §14 | §22 | Never generate a real person's likeness |

Plus three new:

- **§15 Keyboard completeness [HARD for tool-shaped]** — from systemcicy. Every primary workflow completable by keyboard alone.
- **§16 Human gates are real stops [HARD]** — Gate A and Gate B. Carries the anti-shortcut clause verbatim in spirit: *the written output is the OUTPUT of the interactive review, not a substitute for it. If there is any non-trivial finding, the path to proceeding goes through the human.*
- **Skipping is allowed, silent degradation is not** — folded into §16's tail, with the deferred-decision pricing table format (`decision needed | if deferred, what happens`).

**§9 must be rewritten**, not copied. v1's bug was dropping it entirely reasoning "this plugin writes no body copy." It writes image text. New text:

> **§9. Anti-slop, aimed at what the images say.** This pipeline writes almost no prose — but every design image renders text, and an unconstrained image model writes "Elevate your workflow" over an invented logo. Realistic copy lengths. Minimal text per image. No invented brand names. No hollow superlatives. No "not X, but Y." Where real copy exists, use it; where it does not, use plausible-length lorem-free placeholder drawn from the subject's actual domain.

**§10 must be rewritten** to be design-time, not a checklist. Its body cites `ACCESS.md` and states the structural rule the audit produced:

> Accessibility is decided in Loop 1, not audited in a final pass. Across the three parent pipelines there were zero mentions of ARIA, focus management, or live regions while this same rule was marked hard — because every one of those is *designed*, and the pipelines only ever *checked*. A hard rule enforced only after the build is a hard rule in name.

Mark exactly three **[HARD]**: §10 accessibility, §15 keyboard completeness (tool-shaped only), §16 human gates.

- [ ] **Step 2: Run the check**

```bash
./scripts/check.sh
```

Expected: still fails on missing `AGENTS.md`/JSON/frontmatter, but no new failures introduced. No placeholder hits.

- [ ] **Step 3: Commit**

```bash
git add PRINCIPLES.md
git commit -m "PRINCIPLES.md: 16 rules, 3 hard

13 design rules carried from portfolio.me and renumbered, plus keyboard
completeness from systemcicy and human gates. S9 anti-slop is rewritten
rather than dropped -- v1's bug was reasoning 'this plugin writes no body
copy' when in fact every design image renders text. S10 accessibility is
rewritten as a Loop 1 decision rather than a Loop 8 checklist, which is the
central finding of the parent audit."
```

---

### Task 3: TRANSLATE.md

**Files:**
- Create: `TRANSLATE.md`

**Interfaces:**
- Consumes: `PRINCIPLES.md` §-numbers from Task 2.
- Produces: the six row names that `loops/01-direction.md` reads: `surface class`, `viewer and decision`, `three-second feel`, `archetype and shadow`, `anti-positioning`, `already owned`.

- [ ] **Step 1: Write TRANSLATE.md**

Six rows, each with: what it is, what it *derives* downstream, and what a blank looks like.

| Row | Drives |
|---|---|
| Surface class | which half of every reference file applies |
| Viewer + their decision or task | section/screen list, density, what earns space |
| The three-second feel | opening move, palette temperature, motion character |
| Archetype + shadow | style shortlist and the collision between them |
| Anti-positioning | styles banned outright, honored absolutely |
| What is already owned | logo, sampled color, existing type, load-bearing brand |

Three rules the file must state:

1. **Row 3 uses the forcing question**, stolen from gstack's design-consultation: *"What is the one thing you want someone to remember after they see this for the first time?"* — with its failure named: *design that tries to be memorable for everything is memorable for nothing.*
2. **Every row must visibly change something downstream.** `stitch-design-taste` ships four configurable dials of which exactly two are read by any rule. A parameter that changes no output is a lie about configurability. Each row in this file names the file and section it derives.
3. **The escape hatch.** If row 6 names an existing design system that must be conformed to — GOV.UK, Material, a corporate DS — **invention is the wrong answer.** Route to conformance and say so. This is the one case where `§1`–`§3` are suspended, and `BREAKING.md` covers how to say that out loud.

- [ ] **Step 2: Run the check, then commit**

```bash
./scripts/check.sh
git add TRANSLATE.md
git commit -m "TRANSLATE.md: the six-row input contract

Every row names what it derives downstream -- a parameter that changes no
output is a lie about configurability, which is the bug stitch-design-taste
ships (four dials, two of them read by any rule). Row 3 takes gstack's
sharper forcing question. Adds the official-design-system escape hatch: when
the subject must conform to GOV.UK or Material, invention is wrong and S1-S3
are suspended."
```

---

### Task 4: STYLES.md

**Files:**
- Create: `STYLES.md`
- Read first: `~/Documents/portfolio.me/STYLES.md` (388), `~/Documents/webcrab/STYLES.md` (255), `docs/audit/competitor-impeccable.md` §3.9, `docs/audit/competitor-small-skills.md` §2

**Interfaces:**
- Consumes: `TRANSLATE.md` rows 4 and 5.
- Produces: the style-family vocabulary and the `Picking one` procedure that `loops/01-direction.md` invokes.

- [ ] **Step 1: Write STYLES.md**

Base: portfolio.me's **seven families** (surface and material, structural, atmospheric, motion-native, technical and data, textural, reductive) — the richer taxonomy. Keep every `**Implies** / **Fails** / **Right when**` triplet; that structure is what makes an entry a brief rather than a menu item.

**Front-load the derivation, from impeccable's departure mode.** This runs *before* the family list is consulted:

> Do NOT pick from a fixed catalog. Picking from a list is itself the training-data reflex — the model reaches for "Swiss-grid, Terminal, Industrial-signage" every time, because those are the furthest-from-editorial items in any enumerated list.
>
> 1. Read the archetype words from `TRANSLATE.md` row 4. What physical, spatial, or material experiences would embody those words if design were not involved?
> 2. From those experiences derive three visual directions genuinely different from each other.
> 3. Each direction must be expressible in one concrete sentence naming a real-world referent — "a museum exhibition label system for a contemporary art gallery," not "clean and minimal." **If your sentence contains only adjectives, it is not concrete enough.**

Then webcrab's **five-input "Picking one"** narrows: category cluster, the empty position, anti-positioning, the viewer's risk appetite, what the brand already owns. Generalize "buyer"→"viewer", "client"→"subject".

Then webcrab's **category-cliché fence** — nine rows (cliché × why it persists × the opening) — **extended** with tool-shaped rows the parents never had: internal tool, admin panel, analytics dashboard, developer console. systemcicy names the first ("the generic admin template is the failure mode") but never tabulates it.

**New section — style under density.** Every family gets one line on what it does holding forty rows. Two worked answers exist and must be cited:
- `industrial-brutalist-ui`'s **bimodal density**: layouts oscillate between extreme data density and vast calculated negative space.
- `minimalist-ui` **cannot** hold forty rows — 24–40px card padding, 1.6 line-height, `max-w-4xl`. That is a Gate A finding, and today nothing surfaces it.

**New section — reveal, don't stretch** (from `docs/research/tablet-desktop-verified.md`). Material's own words: *"Additional space doesn't just mean making the same thing bigger."* Extra width reveals a pane or expands a rail; it never widens a column.

**Paired color tokens.** Colors are defined as swatch + foreground pairs so contrast is structural at definition time rather than repaired in an audit table later.

Keep from portfolio.me unchanged: collision, subversion, the guardrails, style and accessibility, light and dark as two designs.

**Add the M3 Expressive counterweight** (from `docs/research/native-mobile-design-synthesized.md`): 46 studies, 18,000+ participants, key elements spotted **up to 4× faster** in expressive screens — with Google's own caveat that expressive styling cannot fix a broken interaction paradigm. This is the rare usability-grounded argument *against* reflexive restraint.

**Font bans get their reason.** Copy gstack's framing, not a bare blacklist: the ban is about *convergence*, not the typeface. "Space Grotesk is on the list specifically because every AI design tool converges on it as the safe alternative to Inter." A ban without its reason reads as fashion and goes stale in eighteen months.

Open with the page-shaped/tool-shaped fork.

- [ ] **Step 2: Run the check, then commit**

```bash
./scripts/check.sh
git add STYLES.md
git commit -m "STYLES.md: seven families, with derivation before the list

Merges portfolio.me's richer taxonomy with webcrab's five-input picking
procedure and category-cliche fence, extended with tool-shaped rows the
parents never had. Front-loads impeccable's departure-mode derivation --
personality to physical experience to direction, with a concreteness test --
because picking from a list is itself the training-data reflex.

New, from neither parent: style under density (with the two worked answers
that exist, including proof that minimalist cannot hold forty rows), the
reveal-dont-stretch rule from Material's own guidance, and paired color
tokens so contrast is structural rather than audited."
```

---

### Task 5: CRAFT.md (including icons)

**Files:**
- Create: `CRAFT.md`
- Read first: `~/Documents/portfolio.me/CRAFT.md` (418), `~/Documents/webcrab/CRAFT.md` (240), `docs/research/platform-numbers-verified.md`

**Interfaces:**
- Consumes: `STYLES.md` family names.
- Produces: the technique arsenal and the three-question test that `loops/02-craft.md` runs per surface.

- [ ] **Step 1: Research icons before writing that section**

The icons section has **no parent material and no completed research run.** Verify it now, the same way every other number in this repo was verified:

```bash
B="$HOME/.claude/skills/gstack/browse/dist/browse"
$B goto "https://m3.material.io/styles/icons/overview" ; sleep 3 ; $B text | head -200
$B goto "https://developer.apple.com/design/human-interface-guidelines/sf-symbols" ; sleep 3 ; $B text | head -200
```

Record what you find in `docs/research/icons-verified.md` with the same header format as the other research docs (Date, Method, and an explicit note that this was read off the rendered page). **If a fact cannot be verified, it does not ship** — write the section shorter rather than filling it from memory.

- [ ] **Step 2: Write CRAFT.md**

Base: portfolio.me's arsenal — rendering and GPU, post-processing and treatment, CSS and SVG native, information design, motion and input, whole-page, typographic craft. **Preserve the information-design section verbatim in substance** — Cleveland & McGill's measured numbers (position 1.4–2.5× more accurate than length, 1.96× more than angle, 5.3–7.3× fewer catastrophic misreads), ColorBrewer construction, the hard no-rainbow rule with its reason. That section is the most research-grounded content in any of the parents.

Merge from webcrab:
- **"Showing the product"** — eight techniques, with its hard rule: never fake a screen implying a feature that does not exist.
- **"The cheap wins"** — ranked by return per byte, now with a second axis: order by impact ÷ risk, stolen from `redesign-existing-projects`' Fix Priority ladder.
- **The three-question commercial test**, which **supersedes** portfolio.me's one-question version rather than sitting beside it: what does this make the viewer understand · which objection does it answer or proof does it carry · what does it cost in bytes and main-thread time. Same test with the cost column filled in.

**States are class-dependent.** Page-shaped: three render states (full, designed reduced-motion, no-WebGL). Tool-shaped: the nine data states, which live in `TOOLS.md`. A tool surface with heavy motion owes both sets — they are different axes, not a longer list.

**Motion, from `docs/research/platform-numbers-verified.md`.** Apple names the five techniques, and these ship verbatim because they are the "designed reduced-motion state" `§10` demands, spelled out:
> tighten animation springs to reduce bounce · track animations directly with people's gestures · avoid animating depth changes in z-axis layers · replace transitions in x-, y-, and z-axes with fades · avoid animating into and out of blurs

Note that the last two are exactly what is fashionable right now, and exactly what a motion-sensitive person cannot tolerate.

Plus: `IntersectionObserver`, never a scroll listener, with the failure named (continuous reflow kills mobile performance).

**Craft rules from the audit** that cost two lines each and fix common tells:
- **Concentric radius**: inner radius = outer radius − gap.
- **Apple's shape system** (from `docs/research/native-mobile-design-synthesized.md`): three shape types — fixed, capsule (radius = half container height), and **concentric** (radius = parent radius − padding), so nested containers compute their inner radius rather than guessing it.
- **Grid determinism**: `display: grid; gap: 1px` with contrasting parent/child backgrounds produces hairline rules that never double at intersections and never round wrong at nested corners.

**New section — icons**, written from Step 1's verified research. It must contain at minimum the one fact already verified in `docs/research/platform-numbers-verified.md`:
> Icon size and target size are independent decisions. Material: *"an icon may appear to be 24 x 24dp, but the padding surrounding it comprises the full 48 x 48dp touch target."* A 24dp icon inside a 48dp target is correct; a 24dp icon that **is** the target is a failure.

Open with the page-shaped/tool-shaped fork.

- [ ] **Step 3: Run the check, then commit**

```bash
./scripts/check.sh
git add CRAFT.md docs/research/icons-verified.md
git commit -m "CRAFT.md: merged arsenal, plus icons researched at write time

portfolio.me's arsenal as the base with the Cleveland & McGill information
design section preserved intact -- the most research-grounded content in any
parent. webcrab's three-question commercial test SUPERSEDES portfolio.me's
one-question version rather than sitting beside it.

Apple's five named reduced-motion techniques ship verbatim; the last two
(z-axis depth, blur transitions) are exactly what is fashionable and exactly
what a motion-sensitive person cannot tolerate. Adds Apple's three-type shape
system so nested radii are computed, not guessed.

Icons researched by browser at write time rather than from memory, since no
workflow ever covered them."
```

---

### Task 6: TOOLS.md

**Files:**
- Create: `TOOLS.md`
- Read first: `~/Documents/systemcicy/INTERFACE.md` (229 lines)

**Interfaces:**
- Produces: the nine data states that `CRAFT.md` and `loops/02-craft.md` both reference by name.

- [ ] **Step 1: Port systemcicy's INTERFACE.md**

Near-verbatim. Its thirteen sections stand as written: design the day not the screen, density is a feature, keyboard completeness, the nine states, forms, tables and lists, navigation and IA, feedback/confirmation/undo, the system's words, mobile and field use, performance as felt, the design system, the deliverable.

Three edits only:
1. **Renumber its `§` references** to this repo's `PRINCIPLES.md` numbering from Task 2.
2. **Cut its three reaches into systemcicy-specific docs** — `DOMAIN.md §2`, `ARCHITECTURE.md §7`, `ARCHITECTURE.md §9`. Replace with the substance inline or delete.
3. **Add a pointer back to `STYLES.md`.** systemcicy's version never asks what a tool should *look* like — it assumes a plain system. A tool having a deliberate style is what this merge makes possible and neither parent could do alone.

Add the **trunk test** from gstack's design-review to the navigation section: cover everything but the nav — can you still answer what site, what page, what sections, where am I?

Add **desktop window states** from `docs/research/tablet-desktop-verified.md`: main, key, inactive — a required state set for desktop-shaped surfaces, the same way tool-shaped surfaces get nine data states.

Open with the page-shaped/tool-shaped fork (here the tool-shaped half is the whole file; say so and point page-shaped readers to `STYLES.md`).

- [ ] **Step 2: Run the check, then commit**

```bash
./scripts/check.sh
git add TOOLS.md
git commit -m "TOOLS.md: systemcicy's INTERFACE.md, renumbered and unhooked

Near-verbatim port of the only file in the family that knows how to design a
tool rather than a page. Cuts its three reaches into systemcicy-specific docs
and adds the pointer STYLES.md that systemcicy never had -- it assumes a
plain system, and a tool having a deliberate style is what this merge makes
possible. Adds desktop window states (main/key/inactive) as a required state
set alongside the nine data states."
```

---

### Task 7: SURFACES.md

**Files:**
- Create: `SURFACES.md`
- Read first: `docs/research/platform-numbers-verified.md`, `tablet-desktop-verified.md`, `mobile-native-verified.md`, `native-mobile-design-synthesized.md`, `tablet-desktop-workflow-salvaged.md`

**Interfaces:**
- Consumes: nothing.
- Produces: the platform-mode pre-decision that `agents/surface-designer.md` requires.

- [ ] **Step 1: Write SURFACES.md from the verified research only**

Five sections. **Every number below is already verified — do not re-derive, and do not add numbers that are not in the research docs.**

**1. Platform mode is a pre-decision.** Three branches with bias lists — iOS-native, Android-native, cross-platform-neutral — and the closing rule that they do not mix. Recorded in `DIRECTION.md`.

**2. The four target numbers are four different things.**

| Standard | Number | Applies to |
|---|---|---|
| WCAG 2.5.8 (AA) | 24×24 CSS px effective area | web; satisfiable by size **or** the geometric spacing exception |
| Apple iOS/iPadOS | **44×44 pt default, 28×28 pt minimum** | native iOS controls |
| Material | 48×48 dp | touch targets |
| Material | 44×44 dp | *pointer* targets — a separate, smaller spec |

Full Apple table (default / minimum): iOS+iPadOS 44/28 · macOS 28/20 · tvOS 66/56 · visionOS 60/28 · watchOS 44/28.

State the correction explicitly: **"Apple's minimum is 44×44pt" is wrong and is repeated nearly everywhere.** 44 is the default.

Decision procedure: cross-platform-neutral takes **48dp / 44pt**, clearing every floor. A platform-committed design may use its own default. Nothing ships at a platform *minimum* without a stated reason — a minimum is for constrained cases, not a target.

Spacing is a separate obligation: Material 8dp between targets; Apple ~12pt padding around bezelled elements and ~**24pt** around bezel-less ones (double).

**3. Type and scaling.** Apple default/minimum per platform: iOS+iPadOS 17/11 · macOS 13/10 · tvOS 29/23 · visionOS 17/12 · watchOS 16/12. Dynamic Type is **12 sizes** (7 standard + AX1–AX5); Body runs 17pt → 53pt, ~3.1×, crossing 200% at AX3. Layout guidance: switch side-by-side to vertical stack, let text wrap rather than truncate. Android 14 max scaling 200% with a **non-linear curve — `4sp + 20sp ≠ 24sp`**, which breaks additive layout math.

**4. Liquid Glass.** Functional layer for controls and navigation only. **Never the content layer** — the one exception is transient controls (sliders, toggles) while active. Sparingly on custom controls. Two variants: regular (adaptive, for components carrying significant text — alerts, sidebars, popovers) and clear (only over visually rich media, with a **35% opacity dark dimming layer** if the underlying content is bright). Never mix the two variants; never stack glass on glass. Re-renders under Reduce Transparency and Increase Contrast — both are designed states.

**5. Tablet and desktop.**
- **Split View, Slide Over, and Stage Manager no longer exist in Apple's design guidance** (0 occurrences; change log June 9 2025 replaced them with a macOS-shaped windowing model). Delete that vocabulary on sight.
- *"Apps don't control multitasking configurations or receive any indication of the ones that people choose."* A tablet design must be correct at **any width the user drags to**, unnotified.
- *"Defer switching to a compact view for as long as possible. Design for a full-screen view first"* — the inverse of the mobile-first reflex. When a multi-column layout narrows, **hide tertiary columns (inspectors) first.**
- Material's **five** breakpoints: compact <600dp · medium 600–839 · expanded 840–1199 · large 1200–1599 · extra-large 1600+. Panes: 1 / 1–2 / 2 / 2 / 3. Note a phone in landscape is *Expanded*, same class as desktop.
- Apple size classes are binary and **every current iPad is regular/regular in both orientations** — so on iPadOS design against available width, not size class.
- macOS windows have three states: main, key, inactive.

**Scope limit, stated out loud:** `CRAFT.md`'s arsenal is web technique. For native platforms the principles hold — prototype first, three states, two-tier budget, name what the technique teaches — and the arsenal does not.

Open with the page-shaped/tool-shaped fork.

- [ ] **Step 2: Verify no unsourced numbers crept in**

```bash
grep -oE '[0-9]+ ?(pt|dp|sp|px|%)' SURFACES.md | sort -u
```

Every value in that output must appear in a `docs/research/*.md` file. Check each one. If a number is not in the research, delete it from `SURFACES.md`.

- [ ] **Step 3: Run the check, then commit**

```bash
./scripts/check.sh
git add SURFACES.md
git commit -m "SURFACES.md: platform law, every number traced to verified research

Carries the correction that matters most -- Apple publishes default AND
minimum per platform, and the near-universally-repeated '44pt minimum' is
wrong. Four target standards that are four different things, with a decision
procedure (cross-platform-neutral takes 48dp/44pt, clearing every floor).

Deletes Split View / Slide Over / Stage Manager, which have zero occurrences
in current Apple guidance since June 2025. States the harder replacement
constraint: apps get no indication of the multitasking mode, so a tablet
layout must be correct at any width, unnotified.

States the native-arsenal scope limit out loud rather than implying the
four-surface claim covers technique as well as principle."
```

---

### Task 8: ACCESS.md (including i18n)

**Files:**
- Create: `ACCESS.md`
- Read first: `docs/research/accessibility-wcag.md`, `web-a11y-patterns.md`, `native-a11y-verified.md`

**Interfaces:**
- Consumes: `PRINCIPLES.md` §10 and §15.
- Produces: the Loop 1 accessibility decision list that `loops/01-direction.md` runs.

- [ ] **Step 1: Research the two open gaps before writing them**

Legal enforcement and SPA focus/live-regions returned **zero surviving claims across three workflow attempts**. Law and spec sites resist summarizers, which is exactly what the browser fixes. Verify now:

```bash
B="$HOME/.claude/skills/gstack/browse/dist/browse"
$B goto "https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32019L0882" ; sleep 3 ; $B text | head -300
$B goto "https://www.ada.gov/resources/2024-03-08-web-rule/" ; sleep 3 ; $B text | head -200
$B goto "https://www.w3.org/WAI/ARIA/apg/practices/landmark-regions/" ; sleep 3 ; $B text | head -200
```

Append to `docs/research/` as `legal-and-focus-verified.md`. **Anything unverified does not ship** — write "not established" rather than guessing at a compliance deadline. A wrong legal date in a design tool is worse than an absent one.

- [ ] **Step 2: Write ACCESS.md**

**Open with the structural claim**, because it is the reason this file exists:

> Accessibility here is a Loop 1 concern. In the three parent pipelines it was a Loop 8 checklist — and across ~5,000 lines they contained zero mentions of ARIA, focus management, live regions, or accessible names, while marking accessibility a hard rule. That is not an oversight; it is what happens when a rule is only ever *checked*. Everything below is *decided*, at concept time, before an image is generated.

**WCAG 2.2's six new A/AA criteria as design decisions:**
- 2.5.8 target size — 24×24 CSS px effective area, satisfiable by size **or** the geometric spacing exception (a 24px circle centered on each undersized target must not intersect another). A token and layout decision.
- 2.5.7 dragging — a visible **non-drag pointer affordance** for every author-built drag. Keyboard support does *not* satisfy it; the affordance occupies layout space. Applies to reorder lists, kanban, map panning.
- 2.4.11 focus not obscured — sticky chrome geometry that never entirely covers a focused element.
- 3.3.8 accessible authentication — no cognitive function test; never block paste or password managers.
- 3.3.7 redundant entry, 3.2.6 consistent help.

State that **WCAG 2.2 AA is the operative target**: WCAG 3.0 is a Working Draft (3 March 2026) whose own text says it has "several years of work" left and does not deprecate WCAG 2.

**ARIA pattern choice is a design decision** (from `web-a11y-patterns.md`):
- **grid vs table** is a keyboard-model commitment: a grid exposes exactly **one** focusable element to the page tab sequence (roving tabindex); every focusable element in a table stays in the sequence. Same visual table, two different keyboard experiences.
- **combobox** forces a closed choice of four popup roles — listbox, tree, grid, dialog — each with its own keyboard contract, plus `aria-expanded` mirroring visible state.
- **menu/menubar**: Tab *exits* the widget; arrows navigate.
- **modal dialog** bundles focus trap + bidirectional focus transfer + content-dependent initial focus.
- **disclosure vs accordion** is a content-structure decision, not an implementation one. (Flag: this boundary is contested — a W3C issue is open with no editor resolution.)

**The measured case for restraint**, WebAIM Million 2026 (~1M home pages): pages using ARIA average **59.1 detected errors vs 42 without — ~41% more**, scaling with attribute count. Of pages using `role="menu"`, **22% actively introduce barriers** from incomplete markup. An ARIA role is, in the APG's words, "a promise" — it carries no native keyboard behavior. *No ARIA is better than bad ARIA.*

**Native accessibility, and where a web checklist misses:**
- Apple targets **200%** text enlargement (140% watchOS) and **explicitly excludes system Zoom and Hover Text** from counting toward it. Browser zoom *does* satisfy WCAG 1.4.4/1.4.10. Same feature, opposite verdict by platform — this is the cleanest native-vs-web divergence found.
- **VoiceOver grouping is a layout-time decision.** Ungrouped, VoiceOver reads every image then every caption. Visual proximity encodes relationship silently for sighted users and not at all otherwise unless a designer declares it.
- **label and value are separate channels** — label names the field, value carries content. Conflating them causes doubled speech.
- Apple's contrast boundary is **17pt**, not the web's 18px/14pt-bold. A design system carrying one contrast rule across web and iOS uses the wrong breakpoint on one of them.
- Reduce Transparency and Increase Contrast re-render Liquid Glass — designed states.

**i18n section** (folded in, not a separate file): `§13` covers script, direction, and never mangling a name. Add what the parents lacked — text expansion (German runs long; a layout tight at English width breaks), CJK line breaking, and that plural rules are not a two-case if-statement. Verify any specific expansion percentage before quoting it; if unverified, describe the effect without a number.

**Legal**, from Step 1's research. If a fact did not verify, write: *not established in this pass — verify before relying on it.*

Open with the page-shaped/tool-shaped fork.

- [ ] **Step 3: Run the check, then commit**

```bash
./scripts/check.sh
git add ACCESS.md docs/research/legal-and-focus-verified.md
git commit -m "ACCESS.md: accessibility as Loop 1 decisions, not a final checklist

Opens with the structural finding that produced this file: the parents marked
accessibility hard and contained zero ARIA, focus-management or live-region
guidance across ~5000 lines, because they only ever checked it and never
designed it.

Carries WCAG 2.2's six new A/AA criteria as design decisions, ARIA pattern
choice as a keyboard-model commitment, and WebAIM Million's measured harm
(59.1 errors with ARIA vs 42 without). Names the cleanest native-vs-web
divergence found: Apple excludes system Zoom from its 200% target while
browser zoom satisfies WCAG 1.4.4.

Legal and SPA-focus content researched by browser at write time after three
workflow attempts returned zero surviving claims; anything still unverified
is marked as such rather than guessed."
```

---

### Task 9: REDESIGN.md and BREAKING.md

**Files:**
- Create: `REDESIGN.md`, `BREAKING.md`
- Read first: `docs/audit/competitor-small-skills.md` §3

**Interfaces:**
- Consumes: `TRANSLATE.md` row 6, `STYLES.md` families.
- Produces: the correction/reposition fork that `loops/01-direction.md` branches on.

- [ ] **Step 1: Write REDESIGN.md**

Four steps, assembled from two sources neither of which has the whole thing:

1. **Extract the rendered system** — gstack design-review's four DOM queries (fonts in use, real palette, heading scale, every interactive element under 44px) plus a perf read. Output `CURRENT.md`: what this surface *is* today, measured, not described.
2. **Position it against `STYLES.md`** — which family is it closest to, and is that a choice or an accident? A site 80% Swiss is a Swiss site with drift. A site that is 30% of six styles has no position. Different problems, different fixes.
3. **Classify the ask — a fork, not a slider.** **Correction** (position right, execution drifted) runs an audit + fix-priority pass against the extracted system. **Reposition** (position itself wrong) runs Loop 1 with `CURRENT.md` as a constraint, plus the question greenfield never asks: *what is load-bearing and must survive?* — which is exactly `TRANSLATE.md` row 6.
4. **Fix Priority ladder** — order by impact ÷ risk, not by category. Font swap first (largest visible delta, smallest blast radius); typography polish last. An audit without an order is a backlog; with an order it is a plan.

State the discipline `redesign-existing-projects` lacks and gstack has: one fix at a time, re-screenshot after each, classify verified / best-effort / reverted, and a hard cap. A scan-diagnose-fix pass with no gate and no revert path is more dangerous than the problem it solves.

- [ ] **Step 2: Write BREAKING.md**

This is **authored, not researched** — no primary source publishes "when to violate design conventions." It is the natural completion of `§1`–`§3`, which currently say "be bold" and then hand the agent a rulebook, a contradiction the family never resolved.

Structure: for each breakable rule — **what it is · what breaking it buys · what it costs · the conditions that make the trade honest · how to record it.**

Rules that are breakable, with their real conditions:
- **Platform convention** (a non-native nav, a custom control). Buys distinctiveness; costs learnability and every platform affordance the system gave you free. Honest when the audience uses this daily and the gain compounds; dishonest for a one-visit surface.
- **The category cliché fence** — sometimes the cliché is load-bearing (a padlock on a bank). Breaking *the fence* means using the expected form deliberately, which is different from reaching for it reflexively. Record which.
- **Density norms** — a marketing site that goes dense, a tool that goes spacious. Honest when the content genuinely inverts the usual read pattern.
- **The style's own guardrails** — shipping a named style unmodified is a `§3` failure, but *deliberately* shipping it near-pure as the collision itself is a legitimate move if stated.
- **The two-tier budget** — a heavy hero that blows the shell budget, when the surface's whole job is proving capability.

**What is never breakable**, and say why in one line each: `§10` accessibility, `§15` keyboard completeness on tool-shaped surfaces, `§16` the human gates, and the `TRANSLATE.md` anti-positioning row. These are not aesthetic preferences; breaking them transfers cost onto someone who did not consent.

**The recording rule:** a broken rule that is not written down is indistinguishable from a mistake. Every break is named in `DIRECTION.md` with its rationale and its cost — that is what separates a decision from an accident, and it is what `§3`'s "name what was invented" was always reaching for.

- [ ] **Step 3: Run the check, then commit**

```bash
./scripts/check.sh
git add REDESIGN.md BREAKING.md
git commit -m "REDESIGN.md and BREAKING.md

REDESIGN closes the greenfield-only gap: extract the rendered system first,
position it against STYLES.md, then fork on correction vs reposition -- they
go to different places. Inherits gstack's per-fix discipline rather than the
small skill's no-gate no-revert scan-and-fix pass.

BREAKING is authored, not researched -- nobody publishes 'when to violate
design conventions' as a primary source. It completes S1-S3, which currently
say be bold and then hand over a rulebook. Each breakable rule gets what
breaking buys, what it costs, and the conditions that make the trade honest.
Four rules are marked never-breakable because breaking them transfers cost
onto someone who did not consent."
```

---

### Task 10: The two loops

**Files:**
- Create: `loops/01-direction.md`, `loops/02-craft.md`
- Read first: `~/Documents/portfolio.me/loops/02-design.md`, `~/Documents/webcrab/loops/02-design.md`

**Interfaces:**
- Consumes: every reference file from Tasks 3–9.
- Produces: Gate A and Gate B definitions; the `DIRECTION.md` and `tokens.json` output schemas that `agents/*` write into.

- [ ] **Step 1: Write loops/01-direction.md**

Sequence: set surface class → set platform mode if mobile → run the `ACCESS.md` Loop 1 decisions → derive direction from physical experience (`STYLES.md`) → sample palette from reality in OKLCH → type (two families max) → generate 2–3 concepts → dispatch `surface-designer` → set-level check → **Gate A**.

**Concept distinctness gets two tests that examine the artifact**, because `§1` as an instruction is what six of seven audited skills already fail at:
> **Swap test.** If someone could swap the headline text between two concepts without noticing, they are too similar.
> **Family pass.** Label each concept with a concrete noun of your own choosing (*exhibition, cockpit, playbill, field-manual*). If two share a label, or a label applies equally to another concept, rework. Do not use a fixed vocabulary for the labels.

**Set-level anti-repeat check**, run by the conductor on what comes back: reject if the same composition anchor repeats more than twice running, or if no full-bleed appears at all. Suspend for deliberately minimal briefs.

**Aspect ratio keyed to surface class** — this is v1's second bug. Page-shaped sections are horizontal; phone screens are portrait; tool-shaped screens are landscape-ish. State a ratio per class rather than "one horizontal image."

**Announce N before generating**, and label each image "Surface X of N."

**Gate A** presents: rendered images per concept, palette with sampled sources, type system, the collision sentence, and a **SAFE/RISK split with at least two risks**, each with what it costs. Carries the anti-shortcut clause from `PRINCIPLES.md` §16.

**Rejection diagnosis** — execution vs concept vs brief go to different places. Three rejections at the same gate means the translation table is wrong, not the work.

- [ ] **Step 2: Write loops/02-craft.md**

Assign a technique per surface from `CRAFT.md`; each passes the three-question commercial test. Dispatch `technique-prototyper`. Write the motion spec. Declare both budget tiers. Write `DIRECTION.md` **and** `tokens.json`. **Gate B.**

**`DIRECTION.md` at rendered-style resolution** — this is the single most consequential correction from the audits. Specify the output schema explicitly: hex values not color names, px/rem not "generous", ms and named easing curves not "smooth", paired accent+foreground tokens. The test: *could a build agent execute this without making a single aesthetic decision?* If no, it is still a brief.

**`tokens.json` in DTCG format**, with the limits stated: it is a **Community Group Draft** (pin the date, not "the W3C standard"); `dimension` is an object `{value, unit}` with units closed to **px and rem only**; `duration` likewise ms/s. Apple `pt` and Material `dp`/`sp` **cannot** be expressed — native numbers live in `DIRECTION.md` prose or `$extensions`. Say the limit rather than pretending one file serves four surfaces.

**Prototype verdicts carry evidence labels** — TESTED / PARTIAL / INFERRED. Never guess; state the evidence source for every verdict. A frame rate measured on one machine at one viewport is not the same claim as one inferred.

- [ ] **Step 3: Run the check, then commit**

```bash
./scripts/check.sh
git add loops/
git commit -m "loops/: direction and craft, with tests that examine the artifact

Loop 1 attaches the swap test and family pass to concept generation, because
S1 as a bare instruction is exactly what six of seven audited skills fail at
-- two of them by asking the model to simulate a random number generator.
Fixes v1's aspect-ratio bug: ratio is keyed to surface class, since phone
screens are portrait and 'one horizontal image' was inherited from a
web-sections-only parent.

Loop 2 specifies DIRECTION.md at rendered-style resolution with an executable
test -- could a build agent run this without one aesthetic decision? -- and
states the DTCG unit limits rather than pretending tokens.json serves native."
```

---

### Task 11: The two worker agents

**Files:**
- Create: `agents/surface-designer.md`, `agents/technique-prototyper.md`

**Interfaces:**
- Consumes: `SURFACES.md` platform mode, `STYLES.md`, `loops/01-direction.md` schema.
- Produces: one image per surface; one prototype + verdict per technique.

- [ ] **Step 1: Write agents/surface-designer.md**

Frontmatter with `name` and `description`. Body states: one agent per surface, one image, never a compressed board — *a compressed board hides exactly the detail the human needs to judge.*

Required per-image decisions, from the imagegen audit:
- **Platform mode** honored (iOS / Android / neutral).
- **Safe-area bands** — every mobile surface image shows or reserves four bands: status, title/nav, content, bottom-nav/home-indicator. A screen running edge-to-edge in all four directions has failed regardless of how it looks.
- **Composition anchor and background mode** — one pick each, logged, so the set-level anti-repeat check has something to compare.
- **Text-in-image constraints** — realistic lengths, minimal count, no invented brand names, no placeholder superlatives (`PRINCIPLES.md` §9).
- **Device framing inverted from the source skill's default**: bare screen unless physicality is load-bearing. A phone bezel consumes ~30% of the canvas and pulls the model's fidelity toward rendering a handset instead of the interface under review.
- **Embarrassment self-gate** before returning: would a designer put their name on this? Reject in the worker — cheaper than at Gate A.

State the runtime note: an agent that cannot spawn subagents reads this file and does the work inline.

- [ ] **Step 2: Write agents/technique-prototyper.md**

One agent per technique. Delivers: a standalone runnable HTML file, a screenshot, a **measured** frame rate under load, the byte cost, all required states for the surface class, and a verdict — **ship / cut / ship-with-caveat** — carrying a TESTED / PARTIAL / INFERRED evidence label.

Free rein while prototyping (any library, any CDN). That freedom ends at handoff, where `§7` requires everything vendored.

**Report failure honestly — failing cheap here is the entire point of the loop.** A rejected prototype is never argued into acceptance, tuned during the build, or carried forward on the theory that it comes together in integration.

- [ ] **Step 3: Run the check, then commit**

```bash
./scripts/check.sh
git add agents/
git commit -m "agents/: surface-designer and technique-prototyper

surface-designer carries the safe-area band rule (four bands visible or
reserved, or the image is a poster not a screen) and inverts the device-frame
default -- a bezel eats ~30% of canvas and pulls model fidelity toward
rendering a handset instead of the interface under review.

technique-prototyper is the genuine product: nothing in gstack, impeccable's
43k lines of JavaScript, or the six style skills builds a runnable proof and
measures it before the design commits. Verdicts carry evidence labels."
```

---

### Task 12: AGENTS.md router

**Files:**
- Create: `AGENTS.md`

**Interfaces:**
- Consumes: every file built so far.
- Produces: the routing table all seven adapters point at.

- [ ] **Step 1: Write AGENTS.md, under 200 lines**

Sections, tight:
1. **What this is** — a design-only pipeline; markdown is the product, your agent is the runtime; it stops before code.
2. **Read first** — `PRINCIPLES.md`, then `TRANSLATE.md`, then the loop you are on.
3. **The routing table** — a row per reference file with a one-line "read this when."
4. **The two loops and two gates.**
5. **Surface class**, in six lines, with the pointer to where each half lives.
6. **The three hard rules.**
7. **Scope and limits, stated plainly** — web, mobile, tablet, desktop. `CRAFT.md`'s arsenal is web technique; for native the principles hold and the arsenal does not. `tokens.json` is web-scoped (DTCG units are px/rem only).
8. **Sub-agent note** — an agent that cannot spawn subagents reads `agents/*.md` and works inline.
9. **What it hands off to** — a sibling pipeline's build loop, gstack `/design-html`, a human, or another agent.

Copy impeccable's routing discipline verbatim in spirit: *this file is a decision-tree skeleton; the steps point to on-demand sections. Read a section in full before doing its step; do not work from memory.*

- [ ] **Step 2: Verify the budget**

```bash
wc -l AGENTS.md && ./scripts/check.sh
```

Expected: ≤ 200 lines, and the resident-budget check now passes.

- [ ] **Step 3: Commit**

```bash
git add AGENTS.md
git commit -m "AGENTS.md: the resident router, under 200 lines

Matches impeccable's ratio -- a small always-loaded router plus on-demand
leaves, ~1200 resident lines for a real invocation -- and copies its routing
discipline verbatim in spirit: read a section in full before doing its step,
do not work from memory. States the native-arsenal and DTCG-unit scope limits
plainly instead of letting the four-surface claim imply more than it covers."
```

---

### Task 13: Skill, command, and the seven adapters

**Files:**
- Create: `skills/inter.face/SKILL.md`, `commands/interface.md`, `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`, `.codex-plugin/plugin.json`, `.cursor/rules/inter.face.mdc`, `.clinerules`, `.windsurfrules`, `gemini-extension.json`, `opencode.json`
- Read first: the same ten files in `~/Documents/portfolio.me/` — copy the *pattern*, not the content

**Interfaces:**
- Consumes: `AGENTS.md`.
- Produces: the installable plugin surface.

- [ ] **Step 1: Write the skill and command**

`skills/inter.face/SKILL.md` — frontmatter `name: inter.face` and a `description` that routes on real triggers: designing or redesigning any interface, web / mobile / tablet / desktop, page-shaped or tool-shaped, art direction, design system, design images, prototypes. Body: the conductor role, the two gates, what is never delegated (subagents cannot talk to the human — **you** hold every gate), and the loop table.

`commands/interface.md` — frontmatter with `description` and `argument-hint`. Body invokes the skill for `$ARGUMENTS`, states the three hard rules, and says: settle surface class before anything else, since it changes every downstream file.

- [ ] **Step 2: Write the seven adapters**

All point at `AGENTS.md`. Keep each to the size portfolio.me uses — these are pointers, not documentation.

```json
// .codex-plugin/plugin.json
{
  "name": "inter.face",
  "version": "0.1.0",
  "description": "Art direction for any interface. A translation table in; DIRECTION.md, tokens.json, one design image per surface and one measured prototype per technique out. Two human gates. Web, mobile, tablet, desktop.",
  "author": { "name": "PIIIX", "url": "https://github.com/PIIIX-org" },
  "homepage": "https://github.com/PIIIX-org/inter.face",
  "repository": "https://github.com/PIIIX-org/inter.face",
  "contextFile": "AGENTS.md"
}
```

```json
// gemini-extension.json
{
  "name": "inter.face",
  "version": "0.1.0",
  "description": "Art direction for any interface — design-only pipeline with two human gates.",
  "contextFileName": "AGENTS.md"
}
```

```json
// opencode.json
{
  "$schema": "https://opencode.ai/config.json",
  "instructions": ["AGENTS.md", "PRINCIPLES.md", "TRANSLATE.md"]
}
```

`.claude-plugin/plugin.json` and `marketplace.json` follow portfolio.me's shape with inter.face's name, description, and `"category": "productivity"`.

`.cursor/rules/inter.face.mdc` needs frontmatter (`description`, `alwaysApply: false`) then a short numbered body: read `AGENTS.md` and `PRINCIPLES.md`, set surface class first, run Loop 1 → Gate A → Loop 2 → Gate B, never publish past a gate without a human decision.

`.clinerules` and `.windsurfrules` are plain prose, ~10 lines each, same content without frontmatter.

- [ ] **Step 3: Run the check**

```bash
./scripts/check.sh
```

Expected: **ALL CHECKS PASS.** Every JSON parses, every frontmatter file has its opening `---`, links resolve, budget holds.

- [ ] **Step 4: Commit**

```bash
git add skills/ commands/ .claude-plugin/ .codex-plugin/ .cursor/ .clinerules .windsurfrules gemini-extension.json opencode.json
git commit -m "Cross-agent packaging: skill, command, seven adapters

Copies portfolio.me's adapter pattern -- seven small files all pointing at one
AGENTS.md -- retargeted. This is the axis impeccable cannot compete on: its
moat is 43,606 lines of JavaScript, which is exactly what makes it
unportable. Plain markdown runs in Claude Code, Codex, Cursor, Windsurf,
Cline, Gemini and opencode with no runtime."
```

---

### Task 14: README, LICENSE, and the honest positioning

**Files:**
- Create: `README.md`, `LICENSE`

- [ ] **Step 1: Write README.md**

Must contain, because the audits earned them:

- **What it is and what it is not.** It stops before code. The deliverable is `DIRECTION.md` + `tokens.json` + images + prototypes.
- **The parents**, credited: `portfolio.me`, `webcrab`, `systemcicy`.
- **Why it exists**, with the drift table (388/255 `STYLES.md`, only 65 lines still matching) — and the outside evidence that this is a general problem, not PIIIX housekeeping: `imagegen-frontend-web` and `image-to-code` are the same file forked, 191 identical lines, each having grown what the other lacks.
- **What is genuinely new**, stated without inflation: nothing in the surveyed landscape builds a runnable proof of a technique, measures its frame rate, prices it in bytes, and returns a verdict *before* the design commits. That is the product. Loop 1 overlaps substantially with existing tools and the README says so.
- **Scope and limits** — four surfaces; web arsenal only; `tokens.json` is web-scoped.
- **The sourcing rule**, as a quality claim a reader can check: every number traces to `docs/research/`, read off rendered primary sources. Three fabricated quotes were caught and are documented.

- [ ] **Step 2: Write LICENSE** — MIT, `Copyright (c) 2026 PIIIX`.

- [ ] **Step 3: Run the check and commit**

```bash
./scripts/check.sh
git add README.md LICENSE
git commit -m "README and LICENSE

States the positioning honestly, including that Loop 1 overlaps substantially
with tools that already exist and Loop 2 is the genuine addition. Cites the
imagegen-web/image-to-code fork as outside evidence that design-guidance
drift is a general problem rather than PIIIX housekeeping."
```

---

### Task 15: Final verification and push

- [ ] **Step 1: Full check**

```bash
./scripts/check.sh
```

Expected: ALL CHECKS PASS.

- [ ] **Step 2: Verify every quote traces to research**

For each `> ` blockquote in the shipped `.md` files, confirm its text appears in a `docs/research/*.md` file:

```bash
grep -rhoE '^> .{20,}' *.md loops/*.md agents/*.md | sed 's/^> //' | while IFS= read -r q; do
  frag=$(printf '%s' "$q" | cut -c1-40)
  grep -rqF "$frag" docs/research/ docs/audit/ || echo "UNSOURCED: $q"
done
```

Any `UNSOURCED` line is a violation of the sourcing rule. Either find its source and add it to `docs/research/`, or delete the quote.

- [ ] **Step 3: Verify identity before pushing**

```bash
git config user.name && git config user.email && gh api user --jq .login
```

Expected: `Taha-Mahmoodi`, the noreply email, and `Taha-Mahmoodi` as the active gh account. A mismatch stops the push — the `sadeqisaidmohaddes-star` account must never author here.

- [ ] **Step 4: Push**

```bash
git push origin main && gh repo view PIIIX-org/inter.face --json name,visibility
```

- [ ] **Step 5: Report**

Summarize: files shipped, what the check script enforces, which sections carry unverified content marked as such, and the remaining open items (Material canonical layouts, navigation models, gesture conflicts, safe-area/edge-to-edge specifics) so the gaps are legible rather than silent.

---

## Self-Review

**Spec coverage.** Every file in spec v2's list has a task: `AGENTS.md` (12), `PRINCIPLES.md` (2), `TRANSLATE.md` (3), `STYLES.md` (4), `CRAFT.md` (5), `TOOLS.md` (6), `SURFACES.md` (7), `ACCESS.md` (8), `REDESIGN.md` + `BREAKING.md` (9), loops (10), agents (11), skill/command/adapters (13), README/LICENSE (14). The spec's separate icons and i18n files are deliberately folded into Tasks 5 and 8 — documented in File Structure with the reason.

**Every v2 correction is carried:** `DIRECTION.md` at rendered-style resolution (Task 10), `§9` anti-slop restored and re-aimed (Task 2), aspect ratio per surface class (Task 10), no-subject-indexed-catalogs (Global Constraints), `§1` given artifact-examining tests (Task 10), fork at every guidance leaf (Global Constraints + check script), platform mode pre-decision (Tasks 7, 11).

**Placeholder scan.** No TBD/TODO in any task. Every step names exact files, exact content, and a runnable command. The two research steps (Tasks 5 and 8) specify exact URLs and an explicit rule for what to do when a fact does not verify — write it shorter, never fill from memory.

**Type consistency.** File names are identical across all tasks and the check script. `§` numbers are frozen in Task 2 and every later reference uses that numbering. `DIRECTION.md` / `tokens.json` / `CURRENT.md` are named consistently. Gate A and Gate B are used throughout; no B1/B2 leakage from portfolio.me.

**Known-incomplete, and deliberately so:** Material's canonical layouts, navigation models, gesture conflicts, and edge-to-edge specifics never survived verification. Task 15 Step 5 requires reporting them as open rather than letting the absence read as coverage.
