# Competitor audit — ui-ux-pro-max, design-taste-frontend, frontend-design

**Date:** 2026-07-28
**Audited against:** `/Users/taha/Documents/inter.face/docs/superpowers/specs/2026-07-28-inter-face-design.md`
**Method:** every file read; all CSV rows counted programmatically; the CLI executed against 12 real briefs.

Files audited:

- `/Users/taha/.claude/skills/ui-ux-pro-max/` — 36 files, 1.7 MB
- `/Users/taha/.claude/skills/design-taste-frontend/SKILL.md` — 1 file, 1206 lines, 87 KB
- `/Users/taha/.claude/plugins/cache/claude-plugins-official/frontend-design/unknown/` — 6 files; the skill itself is 55 lines

---

## 1. ui-ux-pro-max: claim vs reality

The frontmatter at `/Users/taha/.claude/skills/ui-ux-pro-max/SKILL.md:3` advertises: *"50+ styles, 161 color palettes, 57 font pairings, 161 product types, 99 UX guidelines, and 25 chart types across 10 stacks."*

### The counts

| Claim | Actual rows | Verdict |
|---|---|---|
| 50+ styles | **84** in `data/styles.csv` | ✅ over-delivers on count |
| 161 color palettes | **161** rows in `data/colors.csv` | ⚠️ literally true, materially false — see below |
| 57 font pairings | **73** rows, 73 unique names, 59 unique heading fonts, in `data/typography.csv` | ✅ over-delivers |
| 161 product types | **161** rows in `data/products.csv`, 161 in `data/ui-reasoning.csv` | ✅ true |
| 99 UX guidelines | **99** rows in `data/ux-guidelines.csv` | ✅ exactly true |
| 25 chart types | **25** rows in `data/charts.csv` | ✅ true |
| across 10 stacks | **16** stack CSVs exist in `data/stacks/`; `core.py:75-92` registers 16; `SKILL.md:468-472` lists **1** | ❌ three different numbers in one skill |

So on raw arithmetic the catalog is real. Six of seven numbers check out or over-deliver. That is more honest than most skills of this kind, and it should be said plainly before the criticism starts.

### But "161 color palettes" does not survive contact

`data/colors.csv` has 161 rows × 19 columns = 1591 hex values. Of those there are **272 distinct hexes**, and the palettes collapse hard on inspection:

```
Primary:      49 distinct / 161    top: #2563EB ×15, #7C3AED ×14, #DC2626 ×9
Background:   33 distinct / 161    top: #F8FAFC ×21, #0F172A ×20, #F0F9FF ×13
Accent:       32 distinct / 161    top: #059669 ×23, #EA580C ×22, #2563EB ×16
Destructive:   3 distinct / 161    #DC2626 ×143  (89% identical)
Ring:         49 distinct / 161    (identical to Primary, always)
```

Every one of those is a stock Tailwind swatch. `#2563EB` is `blue-600`. `#7C3AED` is `violet-600`. `#F8FAFC` is `slate-50`. `#0F172A` is `slate-900`. `#059669` is `emerald-600`.

The reason is in the generator. `data/_sync_all.py` builds the file:

```python
def derive_row(pt, pri, sec, acc, bg, notes=""):
    """Generate full 16-token color row from 4 base colors."""
    ...
    muted  = blend(bg, pri, 0.08) if dark else blend("#FFFFFF", pri, 0.06)
    border = f"rgba(255,255,255,0.08)" if dark else blend("#FFFFFF", pri, 0.12)
    destr  = "#DC2626"
    ring   = pri
```

So each "palette" is four hand-picked Tailwind swatches plus twelve tokens derived by arithmetic. `destructive` is a hardcoded literal. `ring` is an alias of `primary`. **161 palettes is really ~49 seed colors.**

And the seeds are the clichés, written down as the rationale. Straight from `_sync_all.py`'s `NEW_COLORS` table:

```python
"Food Delivery / On-Demand":    (... ,"Appetizing orange + trust blue"),
"Meditation & Mindfulness":     (... ,"Calm lavender + mindful green"),
"Diary & Journal App":          (... ,"Warm journal brown + ink violet"),
"Habit Tracker":               (... ,"Streak amber + habit green"),
"Flashcard & Study Tool":       (... ,"Study purple + correct green"),
```

`#7C3AED` — the AI-purple that `design-taste-frontend` bans by name as "THE LILA RULE" — is the assigned primary for 14 product types including Gaming, AI/Chatbot, Meditation, Church/Religious Organization, and Mood Tracker.

### How it is stored and loaded

All content is CSV under `data/`. Nothing is markdown, nothing is progressively disclosed as reference files. The agent never reads a CSV directly — it shells out:

```bash
python3 ~/.claude/skills/ui-ux-pro-max/scripts/search.py "<query>" --design-system -p "Project"
```

`scripts/core.py` implements BM25 from scratch (no dependency), re-indexing the entire target CSV on every invocation. `MAX_RESULTS = 3` (`core.py:15`), and `search.py:48-49` truncates every field to 300 characters.

**So yes, there is routing, and it is real.** The agent sees ~3 rows of ~10 fields, not 161 rows. Token cost per query is small. This is the one architectural thing the skill gets right and it deserves credit.

The routing is `detect_domain()` at `core.py:198-218` — a hardcoded keyword list, with a ~100-term `product` bucket enumerating "fintech, healthcare, gaming, … coding bootcamp". Fallback when nothing matches is `"style"`.

### What the routing actually returns — four real runs

I ran the documented entry point against real briefs. Verbatim outputs:

**`"beauty spa wellness service"`** → style *Soft UI Evolution*, primary `#EC4899` (pink-500), secondary `#F9A8D4`, background `#FDF2F8`, notes *"Soft pink + lavender luxury"*, type *Lora / Raleway*, pattern *"Hero-Centric + Social Proof"*, sections *Hero > Features > CTA*.

That is the spa cliché, complete, delivered as the recommendation.

**`"funeral home"`** → style **Dark Mode (OLED)**, primary `#1E293B`, accent `#22C55E` (green-500), background `#0F172A`, pattern **"Real-Time Monitoring"**, type *Plus Jakarta Sans*.

The BM25 index matched the token `home` and resolved the product type to **`Smart Home/IoT Dashboard`**. A funeral home gets a dark operations dashboard with a green status accent. The tool reports this with no hedge, no confidence score, no alternative.

**`"death metal record label"`** and **`"artisanal coffee roaster"`** → both returned primary `#2563EB`, accent `#F97316`, background `#F8FAFC`, heading *Inter*, body *Inter*.

I traced it:

```
'death metal record label'    color hits=0  typography hits=0
'artisanal coffee roaster'    color hits=0  typography hits=0
```

Zero matches. Those hexes are the **hardcoded defaults** at `scripts/design_system.py:219-223`:

```python
"primary":    best_color.get("Primary",    "#2563EB"),
"secondary":  best_color.get("Secondary",  "#3B82F6"),
"accent":     best_color.get("Accent",     "#F97316"),
"background": best_color.get("Background", "#F8FAFC"),
```

and `"Inter"` at lines 235-236. **The tool cannot distinguish "here is the researched palette for your category" from "I found nothing and made this up."** Both render identically inside the same Unicode box, under the same header `RECOMMENDED DESIGN SYSTEM`. That is silent degradation — precisely what our `PRINCIPLES.md §18` ("skipping is allowed, silent degradation is not") exists to forbid.

### Three functional defects found

1. **A documented flag that hard-errors.** `SKILL.md:437` and `:465` document `--domain prompt`. `CSV_CONFIG` (`core.py:17-73`) has no `prompt` key, and `search.py:59` builds `choices` from those keys. Running the documented command exits with an argparse usage error.

2. **The "reasoning engine" output is discarded.** `ui-reasoning.csv` supplies a `Decision_Rules` JSON column. All 161 rows parse. `design_system.py:107` loads it, `:244` puts it in the return dict — and **no formatter renders it.** Verified across `format_ascii_box`, `format_markdown`, `format_master_md`, `format_page_override_md`: zero references. Same for `severity`. The advertised reasoning never reaches the agent. (For what it's worth, the rules are thin anyway — the SaaS entry in full is `{"if_ux_focused": "prioritize-minimalism", "if_data_heavy": "add-glassmorphism"}`.)

3. **The icon data contradicts the icon prose and is unreachable.** `data/icons.csv` is 105 rows, of which **100 are Phosphor**. Meanwhile `SKILL.md:130` instructs *"Use SVG icons (Heroicons, Lucide), not emojis"* and the pre-delivery checklist repeats *"use SVG: Heroicons/Lucide"*. The `icons` domain exists in `core.py:53` but is absent from the documented domain table at `SKILL.md:453-465`.

4. **212 KB of admitted dead weight ships in the skill.** `data/design.csv` (99 KB) and `data/draft.csv` (99 KB) are near-duplicates — `draft.csv` contains `design.csv` verbatim plus a header. That header, in Chinese, reads: *"此文件仅作为设计备份/参考文档，当前搜索引擎与 CLI 不会读取或执行本文件内容"* — "this file is only a design backup/reference document; the current search engine and CLI will not read or execute its contents." Neither is referenced by any script.

5. **The local SKILL.md has been hard-wired to React Native.** `SKILL.md:358` — *"**Stack**: React Native (this project's only tech stack)"*; `:439` — *"Step 4: Stack Guidelines (React Native)"*; the Available Stacks table lists one row. The frontmatter on the same file advertises ten. Whether that is upstream or a local edit, the file argues with itself.

---

## 2. Its architecture

```
ui-ux-pro-max/
├── SKILL.md                    658 lines / 44,896 B  ≈ 11,200 tokens — ALWAYS LOADED
├── scripts/
│   ├── core.py       262 L  BM25 from scratch, CSV_CONFIG (11 domains), STACK_CONFIG (16), detect_domain()
│   ├── search.py     114 L  argparse CLI, 300-char field truncation, MAX_RESULTS=3
│   └── design_system.py 1148 L  multi-domain aggregation + 4 output formatters + MASTER.md persistence
└── data/
    ├── styles.csv          84 rows × 22 cols   (142 KB — the widest, richest file)
    ├── colors.csv         161 × 19             (generated by _sync_all.py)
    ├── products.csv       161 × 9
    ├── ui-reasoning.csv   161 × 10             (Decision_Rules never rendered)
    ├── typography.csv      73 × 11
    ├── google-fonts.csv  1923 × 15  (745 KB — a full Google Fonts metadata dump)
    ├── ux-guidelines.csv   99 × 10
    ├── icons.csv          105 × 9   (undocumented domain)
    ├── charts.csv          25 × 14  (the best file in the skill)
    ├── landing.csv         34 × 8
    ├── app-interface.csv   30 × 11  (all iOS/Android/RN)
    ├── react-performance.csv 44 × 11
    ├── design.csv        1757 × 1   ← DEAD, Chinese
    ├── draft.csv         1760 × 1   ← DEAD, self-declared
    ├── _sync_all.py       414 L     (the palette generator)
    └── stacks/*.csv        16 files, 49-60 rows each, identical 10-col schema
```

**Loading strategy:** one always-on 44 KB `SKILL.md`, plus CLI-mediated retrieval into the data. That is a two-tier design, not progressive disclosure in the reference-file sense — there are no `references/*.md` the agent can choose to open. Data is only reachable through Python.

**Progressive disclosure verdict: partial, and inverted.** The retrieval layer (CSV via BM25, 3 rows, truncated) is genuinely lean. The *prose* layer is not disclosed at all — `SKILL.md` front-loads ~11,200 tokens of flat checklist before the agent has read the brief. Sections 1-10 of "Quick Reference" are 230 lines of bulleted rules (`SKILL.md:67-300`) that fire for every invocation regardless of whether the task is a chart, a login form, or a color question. The skill put its disclosure effort on the 1.5 MB of data and none on the 45 KB of prose, which is backwards: the data was already cheap because it is CLI-gated.

**Navigation:** `SKILL.md:339-349` gives a scenario→step routing table (*"New component" → Step 3 (domain search: style, ux)*), and `:536-546` a "Common Sticking Points" table mapping symptoms to sections (*"Animations feel unnatural" → §7: `spring-physics` + `easing` + `exit-faster-than-enter`*). That second table is the best navigation artifact in the skill — symptom-indexed, not category-indexed. Steal the shape of it (see §6).

**Persistence:** `--persist` writes `design-system/<project>/MASTER.md` plus `design-system/pages/<page>.md`, with an explicit precedence rule emitted into the file (`design_system.py:629-631`):

> *"**LOGIC:** When building a specific page, first check `design-system/pages/[page-name].md`. If that file exists, its rules **override** this Master file. If not, strictly follow the rules below."*

That is a real idea and we do not have it (see §4).

### The other two

**design-taste-frontend** — a single 1206-line / 87 KB `SKILL.md` ≈ **21,800 tokens, always loaded**. Twice ui-ux-pro-max's prose and no retrieval layer at all. It declares a `blocks/` directory schema at §12 (`SKILL.md:841-861`) with required frontmatter and 8 required body sections — but the directory does not exist. §12 states its own status: *"schema defined here. Blocks will be added iteratively."* So the one place it planned progressive disclosure is unbuilt.

**frontend-design** (Anthropic official) — 55 lines, ≈2,000 tokens, no data, no scripts, no routing. Deliberately a prompt, not a system. Authors credited in the README as Prithvi Rajasekaran and Alexander Bricken; it points at the [Frontend Aesthetics Cookbook](https://github.com/anthropics/claude-cookbooks/blob/main/coding/prompting_for_frontend_aesthetics.ipynb) for the rest.

**Token budgets, side by side:**

| Skill | Always-loaded | Retrieval layer |
|---|---|---|
| frontend-design | ~2,000 tok | none |
| ui-ux-pro-max | ~11,200 tok | BM25 CLI over 1.5 MB |
| design-taste-frontend | ~21,800 tok | none |
| **inter.face (spec'd)** | AGENTS.md + PRINCIPLES + TRANSLATE, then loop file on demand | STYLES/CRAFT/TOOLS read per loop |

Our file split is the better architecture of the four. Worth defending explicitly in `AGENTS.md`.

---

## 3. What all three cover that our spec does not

Cited by file path. Our spec's coverage is from the sections named in the spec doc.

### 3.1 Native platform craft — the largest gap, and we declared it out of scope

The spec says (line 296-299): *"**Native platform craft.** `CRAFT.md`'s arsenal is web technique … For iOS or Android the principles hold … and the arsenal does not."*

But the task brief for this audit says our scope is **web + mobile + tablet + desktop**. Those two statements are in conflict, and ui-ux-pro-max has the material we would need:

- `data/stacks/swiftui.csv` (50 rows), `data/stacks/jetpack-compose.csv` (52), `data/stacks/react-native.csv` (51), `data/stacks/flutter.csv` (52) — all `Category | Guideline | Description | Do | Don't | Code Good | Code Bad | Severity | Docs URL`
- `data/app-interface.csv` — 30 rows, `Platform` = `iOS/Android/React Native` on all 30
- `data/styles.csv` — 17 of 84 rows have `Type: Mobile` (*Material You (MD3 Mobile)*, *Terminal CLI (Mobile)*, *Academia (Scholarly Mobile)*, *Bitcoin DeFi (Mobile)*…)
- `SKILL.md:84-102, 240-267` — safe areas, notch/Dynamic Island/gesture bar, haptics, Dynamic Type, VoiceOver/TalkBack reading order, system-gesture non-blocking, iOS Tab Bar vs Android Top App Bar, Android predictive back, `hitSlop`, 44pt vs 48dp

Concrete rules we have nothing equivalent to:

> `safe-area-awareness` - Keep primary touch targets away from notch, Dynamic Island, gesture bar and screen edges — `SKILL.md:99`
> `drag-threshold` - Use a movement threshold before starting drag to avoid accidental drags — `SKILL.md:103`
> `back-stack-integrity` - Never silently reset the navigation stack or unexpectedly jump to home — `SKILL.md:260`

`design-taste-frontend` explicitly punts here too (`SKILL.md:903`: *"Native mobile (use Apple HIG / Material directly)"*), so ui-ux-pro-max is the only one of the three with real native material.

### 3.2 Tablet — nobody covers it, including us

`grep -i tablet` across all of ui-ux-pro-max: **9 hits**, all in `SKILL.md` and one product row. The entire tablet content is:

> *"Consistent content width — Keep predictable content width per device class (phone/tablet)"* — `SKILL.md:610`
> *"Readable text measure — Keep long-form text readable on large devices (avoid edge-to-edge paragraphs on tablets)"* — `SKILL.md:612`
> *"adaptive-navigation - Large screens (≥1024px) prefer sidebar; small screens use bottom/top nav (Material Adaptive)"* — `SKILL.md:259`
> *"Verified on small phone, large phone, and tablet (portrait + landscape)"* — `SKILL.md:649`

`design-taste-frontend`: zero tablet content. `frontend-design`: zero. Our spec: zero.

**Tablet is an open field.** The interesting question none of them ask — does a tool-shaped surface at 1024px become the desktop layout or the phone layout, and who decides? — is exactly the kind of fork our surface-class spine is built to answer.

### 3.3 Desktop (native) — also nobody

All 19 "desktop" hits in ui-ux-pro-max mean *desktop web breakpoint*. `SKILL.md:562` scopes itself away explicitly: *"Scope notice: The rules below are for App UI (iOS/Android/React Native/Flutter), **not desktop-web interaction patterns**."* Neither other skill mentions Electron, Tauri, menu bars, window chrome, or multi-window.

### 3.4 Icons — a system-level gap for us

We have no icon guidance at all. Both competitors do, and `design-taste-frontend §3.C` (`SKILL.md:140-146`) is a decision procedure:

> *"**Allowed libraries (priority order):** `@phosphor-icons/react`, `hugeicons-react`, `@radix-ui/react-icons`, `@tabler/icons-react`. **Discouraged:** `lucide-react`… **NEVER hand-roll SVG icons**… **One family per project**… **Standardize `strokeWidth` globally** (e.g. `1.5` or `2.0`)."*

ui-ux-pro-max's `SKILL.md:566-577` icon table adds checkable rules we lack: consistent stroke width within a visual layer, filled-vs-outline discipline per hierarchy level, icon sizes as tokens (`icon-sm`/`icon-md = 24pt`), icon contrast 3:1 for larger glyphs.

This matters for us more than for them: our `PRINCIPLES §8` says *own every asset* and `§9` *generate your visuals*. An agent following those two rules with no icon-system rule will hand-draw SVG icon paths — the exact thing both competitors ban.

### 3.5 Charts — the single best artifact in any of the three

`data/charts.csv`, 25 rows × 14 columns. One row in full:

```
Data Type:              Trend Over Time
Best Chart Type:        Line Chart
Secondary Options:      Area Chart, Smooth Area
When to Use:            Data has a time axis; user needs to observe rise/fall trends
When NOT to Use:        Fewer than 4 data points (use stat card); more than 6 series
                        (visual noise); no time dimension exists
Data Volume Threshold:  <1000 pts: SVG; ≥1000 pts: Canvas + downsampling;
                        >10000: aggregate to intervals
Accessibility Grade:    AA
A11y Fallback:          Dashed/dotted lines per series; togglable data table with
                        timestamps and values
Library Recommendation: Chart.js, Recharts, ApexCharts
```

That is not a catalog entry, it is a decision procedure with numeric thresholds and a named alternative on each branch. Our `CRAFT.md` has an "information design" family and no chart material.

Note the claim inflation though: *"25 chart types across 10 stacks"* implies per-stack chart guidance. There is none — the stack CSVs are framework hygiene, and charts.csv has one `Library Recommendation` column. Two unrelated numbers welded into one sentence.

### 3.6 Component-level states

Our spec covers *surface* states well — 3 render states for page-shaped, 9 data states for tool-shaped (spec lines 164-168). Neither competitor matches that framing. But both have *component*-level state rules we lack entirely, and `design-taste-frontend §4.5` (`SKILL.md:219-228`) is the strongest:

> *"**BUTTON CONTRAST CHECK (mandatory, a11y):** … White button + white text, `bg-white` CTA with `text-white` label, transparent button against the page background with no border → all banned."*
> *"**CTA BUTTON WRAP BAN (mandatory):** Button text MUST fit on one line at desktop. If a label like 'VIEW SELECTED WORK' wraps to 2 or 3 lines, the button is broken."*
> *"**NO DUPLICATE CTA INTENT (mandatory):** … 'Get in touch' + 'Contact us' + 'Let's talk' + 'Start a project' … = all 'contact' intent → pick ONE label and use it everywhere."*

Our nine data states tell an agent *which screens to draw*. These tell it *what is broken in the screen it drew*. Different axis, both needed.

### 3.7 Onboarding — an industry-wide blank

`data/ux-guidelines.csv` has category counts: Accessibility 11, Forms 10, Animation 8, … **Onboarding 1**, Data Entry 1. `design-taste-frontend`: none. `frontend-design`: none. Us: none.

For tool-shaped surfaces, first-run is the highest-stakes screen and it is missing everywhere. `TOOLS.md`'s nine states include empty — but *empty because new* and *empty because filtered* are different designs, and nobody has written that down.

### 3.8 i18n — the biggest blank of all

- `internationaliz`: **0 hits** across all of ui-ux-pro-max
- `localiz`: **0**
- `pluraliz`: **0**
- `rtl`: 122 hits, **all** of them font-subset metadata in `google-fonts.csv`/`typography.csv`. Zero RTL layout guidance.
- `i18n`: 3 hits, all in `data/stacks/nuxtjs.csv` (module config)

The complete i18n content in the skill is two lines:

> `number-formatting` - Use locale-aware formatting for numbers, dates, currencies on axes and labels — `SKILL.md:283`
> `truncation-strategy` - Prefer wrapping over truncation… — `SKILL.md:174` (the closest thing to a text-expansion rule)

`design-taste-frontend`: zero. Our spec keeps `§17` *respect the script and language* — one line, but it is one line more than either competitor. **We are already ahead here and the bar is on the floor.** German text expansion breaking a fixed-width nav, RTL mirroring of directional icons and motion, CJK line-breaking, locale-driven date/number/currency — none of it exists anywhere in this competitive set.

### 3.9 Accessibility depth

ui-ux-pro-max has the most raw a11y surface of the three: 14 items at `SKILL.md:69-82`, 11 rows in `ux-guidelines.csv`, 5 in `app-interface.csv`, plus per-chart `Accessibility Grade` and `A11y Fallback` columns, and an `Accessibility` column on all 84 styles.

`design-taste-frontend` has fewer rules but sharper ones — mechanical checks rather than reminders (button contrast, form contrast, italic descender clearance at `SKILL.md:183`).

Our spec makes accessibility one of two hard, unskippable rules. That is the right *policy* and there is currently no *procedure* under it. `§12 accessible by default` needs the checkable layer these two have.

### 3.10 Motion

`design-taste-frontend §5, §5.A-5.D` (`SKILL.md:352-516`) has runnable GSAP/Motion skeletons with the exact failure named per pattern:

> *"Common failure: trigger fires halfway through scroll instead of pinning at viewport top. Fix: `start: "top top"` not `start: "top center"` or `"top 80%"`."* — `SKILL.md:362`

plus a forbidden list (`§5.D`): `window.addEventListener("scroll")` banned, `requestAnimationFrame` loops touching React state banned, `useState` for continuous values banned (`§3.B`).

ui-ux-pro-max `SKILL.md:181-204` has 24 motion rules with numbers: 150-300ms micro-interactions, exit at 60-70% of enter, stagger 30-50ms per item, scale 0.95-1.05 on press.

Our spec produces a "motion spec" and a measured prototype. We have the *verification* (fps under load) and none of the *vocabulary* — no named motion failures, no duration defaults, no forbidden-implementation list.

### 3.11 Design tokens

`design-taste-frontend §8.A` gives a token strategy decision (Tailwind `dark:` variant *or* CSS variables, pick one per project). ui-ux-pro-max's `MASTER.md` emits a full spacing scale (`--space-xs`…`--space-3xl`), shadow scale (`--shadow-sm`…`--shadow-xl`), and CSS for buttons/cards/inputs/modals (`design_system.py:690-812`). Every `styles.csv` row carries a `Design System Variables` column, e.g. Brutalism:

```
--border-radius: 0px, --transition-duration: 0s, --font-weight: 700-900,
--colors: primary only, --border-style: visible, --grid-visible: true
```

Our `DIRECTION.md` carries palette + type + technique + motion + budget. It carries **no spacing scale, no radius scale, no elevation scale, and no shape-consistency rule**. A build step receiving our `DIRECTION.md` has to invent all of those, which means two surfaces from the same run will not agree on corner radius.

### 3.12 Verticals

161 product types vs our 9 cliché rows (+ the tool-shaped rows the spec adds). Their breadth is real; §5 argues it is also the problem.

### 3.13 Two more, not on the list but load-bearing

**Redesign / brownfield.** `design-taste-frontend §11` (`SKILL.md:783-831`) is a complete protocol: mode detection (greenfield / preserve / overhaul), audit-before-touching (brand tokens, IA, content blocks, patterns to preserve, patterns to retire, dial reading of the existing site, **SEO baseline** — *"SEO migration is the #1 redesign risk"*), preservation rules, modernisation levers in priority order (*"1. Typography refresh - biggest visual lift per unit of risk"*), a decision tree (*"IA, content, and SEO sound → targeted evolution (Levers 1-4). ~70% of value at ~40% of risk"*), and a never-change-silently list (URL structure, nav labels, form field names, logo, legal copy).

**Our spec has no brownfield path whatsoever.** It reads as greenfield-only. Yet the drift problem it was born from is itself a redesign problem, and TRANSLATE row 6 ("what is already owned") is a redesign input with no procedure attached to it.

**Real design systems.** `design-taste-frontend §2.A` (`SKILL.md:86-104`) routes the brief to an official package — Fluent / Material Web / Carbon / Polaris / Atlaskit / Primer / **GOV.UK Frontend** / USWDS / Radix / shadcn / Bootstrap — with an honesty rule:

> *"if the brief reads as one of the systems above, install and use the **official** package. Do not recreate its CSS by hand. Do not import a system's tokens but then override 90% of them."* — `SKILL.md:102`

Our pipeline would take a UK public-sector brief into Loop 1 and invent a style for it. That is a correctness failure, not a taste failure, and `§1 creativity is the baseline` actively pushes toward it. We need an escape hatch that fires *before* Loop 1.

---

## 4. What each does better than our spec

Honestly, with quotes.

### frontend-design (55 lines) — the best guidance-per-token of the three

**a. It solves the category reflex more generally than our cliché table does.** Our `STYLES.md` fence is nine named categories with their clichés. Theirs is a *self-test that needs no table*:

> *"review that plan against the brief before building: if any part of it reads like the generic default you would produce for any similar page (**work through a similar prompt to see if you arrive somewhere similar**) rather than a choice made for this specific brief — revise that part, say what you changed and why."* — `SKILL.md:35`

Simulate yourself on a neighbouring brief; if you converge, you reflexed. That generalizes to categories no table anticipated. Our nine rows do not.

**b. It calibrates against the model's *actual current* defaults, not generic ones:**

> *"AI-generated design right now clusters around three looks: (1) a warm cream background (near #F4F1EA) with a high-contrast serif display and a terracotta accent; (2) a near-black background with a single bright acid-green or vermilion accent; (3) a broadsheet-style layout with hairline rules, zero border-radius, and dense newspaper-like columns. All three are legitimate for some briefs, but they are **defaults rather than choices, and they appear regardless of subject**."* — `SKILL.md:31`

Then the crucial escape, which most anti-slop writing omits: *"Where the brief pins down a visual direction, follow it exactly — the brief's own words always win, **including when it asks for one of these looks**."*

**c. Budget discipline.** *"Spend your boldness in one place. Let the signature element be the one memorable thing, keep everything around it quiet"* and *"Consider Chanel's advice: before leaving the house, take a look in the mirror and remove one accessory"* (`SKILL.md:43`). Our spec has no restraint mechanism — `§1-3` (creativity as baseline, out-of-the-box as floor, reinvent every component) all push *up*. A run that reinvents every component and picks a maximal technique per surface has nothing telling it to remove an accessory.

**d. The hero as an argument, not a slot.** *"the hero is a thesis. Open with the most characteristic thing in the subject's world… Be deliberate with your choice: a big number with a small label, supporting stats, and a gradient accent is the template answer"* (`SKILL.md:17`). Our "opening move" says *that* there is one; this says *how to find it*.

**e. Structure carries meaning.** *"Structural devices, numbering, eyebrows, dividers, labels, should encode something true about the content, not decorate it. Many generic designs use numbered markers (01 / 02 / 03), but that's only appropriate if the content actually is a sequence"* (`SKILL.md:21`).

**f. Copy as design material.** A whole section (`SKILL.md:45-55`): *"A person manages notifications, not webhook config"*; *"An action keeps the same name through the whole flow, so the button that says 'Publish' produces a toast that says 'Published'"*; *"Errors don't apologize, and they are never vague about what happened. An empty screen is an invitation to act."* We dropped `§11` anti-slop prose on the grounds that the plugin writes no body copy — but our design images and prototypes are full of strings, and our nine states include empty and error.

**g. Also, quietly, it beats us on gate economics:** *"Try to do a lot of this planning and iteration in your thinking, and only show ideas to the user when you have higher confidence it'll delight them."* Our two human gates are real stops; this is a reminder that what arrives at a gate should already be filtered.

### design-taste-frontend — the best *checkable rules* of the three

**a. Mechanically countable rules.** This is our stated quality bar, executed better than we execute it:

> *"**EYEBROW RESTRAINT (mandatory, the #1 violated rule in production tests).** … **Maximum 1 eyebrow per 3 sections.** Hero counts as 1. So a page with 9 sections may use at most 3 eyebrows total. … **Pre-Flight Check is mechanical:** count instances of `uppercase tracking` … across all section components. If count > ceil(sectionCount / 3), the output fails."* — `SKILL.md:253-257`

An agent can execute that with `grep -c`. Compare `BENTO CELL COUNT RULE` (`:250`): *"N items → N cells… If your grid has an empty cell in the middle or at the end, you planned wrong."* And `ZIGZAG ALTERNATION CAP` (`:252`): *"Max 2 sections in a row with this image+text-split pattern. The 3rd consecutive image+text split is a Pre-Flight Fail."*

**b. Named failures with hex-level specificity.** The `PREMIUM-CONSUMER PALETTE BAN` (`SKILL.md:192-207`) names the failure, enumerates the exact banned hex families, explains *why it is a failure*, gives seven escapes, and adds a memory rule:

> *"Backgrounds: `#f5f1ea`, `#f7f5f1`, `#fbf8f1`, `#efeae0`, `#ece6db`, `#faf7f1`, `#e8dfcb` (all 'warm paper / cream / chalk / bone'). Accents: `#b08947`, `#b6553a`, `#9a2436`, `#9c6e2a`, `#bc7c3a`, `#7d5621` (all 'brass / clay / oxblood / ochre')… **Every premium-consumer site you have ever shipped uses this exact palette. The brand becomes invisible.**"*
> *"**Palette-rotation rule:** if the previous premium-consumer project you generated used the beige+brass family, this one MUST use a different family."*

Note the structural inversion worth learning from: **ui-ux-pro-max's `colors.csv` ships these as recommendations; design-taste-frontend ships the same colors as bans.** Same content, opposite polarity, and only one of them produces work.

**c. The dial system beats our "three-second feel."** Three integers — `DESIGN_VARIANCE`, `MOTION_INTENSITY`, `VISUAL_DENSITY`, baseline `8/6/4` (`SKILL.md:47-51`) — inferred from the brief via a signal table (`§1.A`), defined operationally (`§7`: *"8-10 (Asymmetric): Masonry layouts, CSS Grid with fractional units (`grid-template-columns: 2fr 1fr 1fr`), massive empty zones (`padding-left: 20vw`)"*), then referenced as gates throughout (*"Centered Hero / H1 sections are avoided when `DESIGN_VARIANCE > 4`"*, *"For `VISUAL_DENSITY > 7`: generic card containers are banned"*).

Our TRANSLATE row "the three-second feel" drives *"the opening move, the palette temperature, motion character"* — prose, and nothing downstream can test whether it was honored.

**d. The self-consistency check.** *"**'Motion claimed, motion shown.'** If `MOTION_INTENSITY > 4`, the page must actually move… A static page that claims `MOTION_INTENSITY: 7` is broken. Conversely, if you cannot ship working motion in the available scope, **drop the dial to 3 and ship a clean static page.** Never half-build motion that breaks"* (`SKILL.md:359`). That is our `§18` skipping-vs-silent-degradation rule applied to a specific dimension, with the downgrade path spelled out.

**e. Motion must be motivated — a one-sentence test.** *"Before adding any animation, ask: 'what does this animation communicate?' Valid answers: hierarchy, storytelling, feedback, state transition. Invalid answer: 'it looked cool'. GSAP everywhere because GSAP is available is amateur. **If you cannot articulate the reason in one sentence, drop the animation.**"* (`SKILL.md:360`). This is our three-question commercial test, applied to motion instead of technique. We should merge the two.

**f. It knows what it is not for and says where to go.** `§13` (`SKILL.md:896-906`): *"This skill is NOT for: Dashboards / dense product UI / admin panels (use Fluent, Carbon, Atlassian, or Polaris from Section 2.A). Data tables (use TanStack Table or AG Grid)…"* — and then *"If the brief is one of the above, **say so explicitly, point to the right tool**, and only apply this skill's marketing-page parts to the surfaces where they apply."*

Our spec's out-of-scope list (lines 289-300) says what we won't do. It doesn't say where the user should go instead. Cheap to fix.

**g. Honesty about borrowed aesthetics.** `Appendix C` (`SKILL.md:1113-1202`) on Apple Liquid Glass: *"There is no `liquid-glass.css` from Apple for normal websites… that is web glassmorphism approximation, not official Apple Liquid Glass. **Label it as such in comments.**"* Same family as our "never fake a screen that implies a feature that does not exist" — a different instance of the same rule, and one we don't cover.

### ui-ux-pro-max — better in four specific places

**a. Every style has a negative.** `styles.csv` has a `Do Not Use For` column on all 84 rows. Brutalism: *"Corporate environments, conservative industries, critical accessibility, customer-facing professional."* Our spec adds **style under density** (what each family does at forty rows) which is excellent and no competitor has it — but *style under stakes* is the other missing axis, and they have it.

**b. Every style is a comparable row, not a paragraph.** 22 columns including `Light Mode ✓`, `Dark Mode ✓`, `Performance`, `Accessibility`, `Mobile-Friendly`, `Conversion-Focused`, `Complexity`, `Framework Compatibility` (*"Tailwind 10/10, Bootstrap 7/10"*). Whatever else is wrong with the file, "these three candidate styles side by side on seven axes" is a real Gate A artifact and our `STYLES.md` families cannot produce it.

**c. Style → checkable output.** `Implementation Checklist` and `Design System Variables` per row turn a style name into something verifiable:

```
Implementation Checklist: ☐ No border-radius (0px), ☐ No transitions (instant),
  ☐ Bold typography (700+), ☐ Pure primary colors used, ☐ Visible grid/borders,
  ☐ Asymmetric layout intentional
```

That is the bridge from "we chose Brutalism" to "here is how you fail Brutalism," and our `STYLES.md` does not have it.

**d. Master + page-override persistence.** `design-system/<project>/MASTER.md` + `pages/<page>.md` with an explicit precedence rule written into the artifact (`design_system.py:629-631`). Our spec emits one `DIRECTION.md` for the whole run. Multi-surface runs — and the spec's own example, *"a product with a marketing site and an application is two runs sharing a palette and a type system"* — need exactly this: a shared master plus per-surface deltas, with the override direction stated in the file. We should steal the mechanism outright.

**e. Symptom-indexed navigation.** `SKILL.md:536-546` maps *problems* to *sections*: *"Animations feel unnatural → §7: `spring-physics` + `easing` + `exit-faster-than-enter`."* This is the one index in the whole skill that is not organized by category, and it is the useful one.

---

## 5. Catalog trap analysis

Our stated position: *big lookup catalogs are an anti-pattern; an agent that looks up its answer produces the category reflex.* Both sides from the actual content.

### The case that the catalog is useful

**1. Retrieval is genuinely bounded.** `MAX_RESULTS = 3`, 300-char truncation. The agent never sees 161 rows. The token cost of the "161 palettes" is near zero at query time. Our "the agent reads all of it" worry is factually wrong for the data layer.

**2. Some of the catalog is decision-shaped, not lookup-shaped.** `charts.csv` is the proof:

> *"**When NOT to Use:** Fewer than 4 data points (use stat card); more than 6 series (visual noise); no time dimension exists."*
> *"**Data Volume Threshold:** <1000 pts: SVG; ≥1000 pts: Canvas + downsampling; >10000: aggregate to intervals."*

Those are thresholds with named alternatives on each branch. An agent reading them does not "browse" — it evaluates a condition. That is our (a) decision procedure and (c) checkable rule, in a CSV. Scale did not hurt it.

**3. `ux-guidelines.csv` uses the failure-shaped schema we advocate.** Columns are `Issue | Description | Do | Don't | Code Example Good | Code Example Bad | Severity`. That is literally "a named failure with its opening/escape," 99 times. Same for all 16 stack CSVs and `app-interface.csv`.

**4. Some knowledge is irreducibly enumerative.** *Which* Google Font supports Devanagari, *what* the official Carbon package name is, *whether* Android calls it predictive back — no reasoning procedure derives these. A catalog is the correct data structure for facts. Our spec has no place to put a fact.

**5. The 84 styles carry columns a procedure cannot generate.** `Do Not Use For`, `Mobile-Friendly`, `Framework Compatibility` are empirical properties of a style. You look them up because they are lookup-shaped.

### The case that the catalog is exactly the failure we think it is

**1. The tested output is the category reflex, verbatim.** Ten of twelve briefs I ran produced the cliché. `"beauty spa wellness"` → soft pink + lavender + Lora/Raleway + Hero>Features>CTA. That is the spa website. The catalog did not help the agent avoid it; the catalog *is* it.

**2. The rationale strings prove intent.** From `_sync_all.py`: *"Appetizing orange + trust blue"*, *"Calm lavender + mindful green"*, *"Study purple + correct green"*, *"Streak amber + habit green"*. The design method encoded in this skill is *"what color do apps in this category use?"* — a definition of the category reflex, shipped as the deliverable.

**3. The single most damning comparison in this audit.** `#7C3AED` (violet-600) is the assigned primary for 14 product types in `colors.csv`. `design-taste-frontend §4.2` bans that exact family by name:

> *"**THE LILA RULE:** The 'AI Purple / Blue glow' aesthetic is discouraged as a default. No automatic purple button glows, no random neon gradients."* — `SKILL.md:187`

One skill's catalog entry is another skill's named anti-pattern. Both cannot be right, and the one with the catalog is the one recommending the tell.

**4. The taxonomy has collapsed under its own size.** `styles.csv` mixes visual styles (*Brutalism*, *Glassmorphism*, *Memphis Design*) with page goals (*Conversion-Optimized*, *Hero-Centric Design*, *Social Proof-Focused*) with product categories (*Financial Dashboard*, *Executive Dashboard*, *Real-Time Monitoring*). Those are three different kinds of thing in one column. That is why "funeral home" got **Real-Time Monitoring** as its *style*: the category axis and the aesthetic axis were merged, so a category mismatch became an aesthetic disaster. Catalogs degrade this way as they grow — every new row is easier to append than to place.

**5. Retrieval quality is unbounded even though retrieval size is bounded.** BM25 over a 100-term keyword bucket matched `home` in "funeral home" to `Smart Home/IoT Dashboard`. There is no threshold, no confidence report, no "no good match" path. `_find_reasoning_rule` (`design_system.py:64-86`) makes it worse: exact match → substring match → *"split the category name into words and match ANY of them."* Three fallbacks deep, still returning a confident answer. `ui-reasoning.csv` has no `General` row for it to land on.

**6. The catalog manufactures false confidence, which is worse than no catalog.** A bare model asked to design a funeral home site produces something generic. This tool produces something generic **and tells the agent it is the researched, category-appropriate answer**, in an ASCII box titled `RECOMMENDED DESIGN SYSTEM`, with #2563EB rendered identically whether it was matched or invented. The catalog's real output is not the palette. It is the *authority*, and the authority is unearned.

**7. The reasoning layer is decoration.** `Decision_Rules` parses on all 161 rows and is rendered by zero formatters. The skill advertises *"Applies reasoning rules from `ui-reasoning.csv` to select best matches"* (`SKILL.md:371`). It applies them to internal variables that are then dropped. Whatever reasoning the catalog claimed to add does not reach the agent.

### Verdict

**The catalog is the failure — but our stated reason for believing that is wrong, and the corrected reason is more useful.**

Size is not the problem. `charts.csv` (25 rows) and `ux-guidelines.csv` (99 rows) are good, and would still be good at 300 rows. `google-fonts.csv` (1923 rows) is harmless — it is a fact table, queried for facts.

**The problem is the index.** A catalog indexed by **subject category** — "you are a spa, therefore pink" — *is* the category reflex, mechanized, and it gets worse with scale because every added row deepens the mapping from *who the client is* to *what the design looks like*. A catalog indexed by **failure** (`ux-guidelines.csv`: symptom → Do/Don't) or by **threshold** (`charts.csv`: >1000 points → Canvas) is not a lookup at all; it is a decision procedure that happens to be stored in rows. Those are safe at any size.

Diagnostic, one line: **does a row map from a property of the subject, or from a property of the situation?** Subject-indexed rows produce the reflex. Situation-indexed rows produce a decision. `colors.csv` is indexed by `Product Type`. `charts.csv` is indexed by `Data Type`. That single column difference is the whole delta between the worst file in the skill and the best.

**Where this should change our position:** the spec currently allows no lookup material anywhere, which would cost us the chart thresholds, the icon-library shortlist, the official-design-system routing table, and the font-script facts. Those are all situation-indexed and all worth having. Recommend amending the principle from *"no catalogs"* to:

> **No subject-indexed catalogs. Situation-indexed tables are allowed, and each must be keyed on a condition the agent evaluates, not on a category the agent belongs to.**

That is a rule we can enforce at review time on our own files, which "no catalogs" never was.

**Where the position holds unchanged:** `STYLES.md` must not acquire a product-type→style table, and `TRANSLATE.md` row 4 (archetype + shadow) must never be resolvable by lookup. Those are the two places the reflex would enter our pipeline, and the spec is right to route both through the collision and the cliché fence instead.

---

## 6. What to steal, ranked

Ranked by (value to our pipeline) × (cost to integrate).

| # | Steal | From | Into |
|---|---|---|---|
| 1 | **The self-simulation reflex test** | frontend-design `SKILL.md:35` | `STYLES.md`, "Picking one" |
| 2 | **Master + per-surface override artifact** | ui-ux-pro-max `design_system.py:561-631` | `loops/02-craft.md` + `DIRECTION.md` shape |
| 3 | **Mechanical, countable pre-flight checks** | design-taste-frontend `§14`, `§4.7` | Gate A / Gate B |
| 4 | **Official-design-system escape hatch** | design-taste-frontend `§2.A` (`SKILL.md:86-104`) | `TRANSLATE.md` → pre-Loop-1 |
| 5 | **The three dials** | design-taste-frontend `§1`, `§7` | `TRANSLATE.md` row 3 |
| 6 | **Chart decision thresholds** | ui-ux-pro-max `data/charts.csv` | `CRAFT.md` information design; `TOOLS.md` |
| 7 | **Per-style Implementation Checklist + Do Not Use For** | ui-ux-pro-max `styles.csv` | `STYLES.md`, every family |
| 8 | **Motion-must-be-motivated + motion-claimed-motion-shown** | design-taste-frontend `SKILL.md:359-360` | `CRAFT.md` §7 test |
| 9 | **Redesign / brownfield protocol** | design-taste-frontend `§11` | new `loops/00-audit.md` or `TRANSLATE.md` row 6 |
| 10 | **Icon system rules** | design-taste-frontend `§3.C`; ui-ux-pro-max `SKILL.md:566-577` | `CRAFT.md`, new subsection |
| 11 | **Spend-your-boldness-in-one-place** | frontend-design `SKILL.md:43` | `PRINCIPLES.md`, as a counterweight to §1-3 |
| 12 | **Copy-as-design-material** | frontend-design `SKILL.md:45-55` | `TOOLS.md` "the system's words" |
| 13 | **Symptom→section index** | ui-ux-pro-max `SKILL.md:536-546` | `AGENTS.md` |
| 14 | **Out-of-scope-with-a-destination** | design-taste-frontend `§13` | spec's out-of-scope section |
| 15 | **Native platform appendix** | ui-ux-pro-max stacks + `app-interface.csv` | deferred — see note |

### Detail on the top five

**1. The self-simulation reflex test → `STYLES.md`, "Picking one."**
One paragraph, no data, generalizes past our nine cliché rows. Wording to adapt: *before committing a concept, run the same brief with the subject swapped for its nearest neighbour in the same category. If the palette, type, and opening move survive the swap unchanged, you designed the category, not the subject. Name what changed; if nothing changed, that is the finding.* This makes `§1` enforceable for categories our table never anticipated, and it costs one paragraph.

**2. Master + per-surface override → `DIRECTION.md` shape.**
The spec's own example demands it: *"a product with a marketing site and an application is two runs sharing a palette and a type system."* Adopt ui-ux-pro-max's structure with the precedence rule written *into* the artifact, as they do:

```
DIRECTION.md              palette, type, concept, collision, motion character, budget tiers
surfaces/<name>.md        class, technique, states, deltas from DIRECTION.md
```

with a header on each surface file naming which file wins on conflict. Cheap, and it removes the "one DIRECTION.md for a two-class project" ambiguity the spec currently leaves open.

**3. Mechanical pre-flight checks → Gate A / Gate B.**
Our gates are human judgment. Theirs run first as arithmetic. Add a machine pass before each gate so the human sees only work that already passes counting. Directly portable, in their words:

- eyebrow count ≤ `ceil(sectionCount / 3)` — grep for `uppercase tracking`
- no 3 consecutive sections sharing a layout family
- ≥ 4 distinct layout families across 8 sections
- bento cells == item count, no empty cells
- one accent color across all sections; one radius scale
- every CTA label fits one line at desktop; no two CTAs share an intent
- hero: headline ≤ 2 lines, subtext ≤ 20 words, CTA above the fold

Then add ours: every technique has a passing prototype with a measured fps; every blank TRANSLATE row is resolved; every skip is recorded in `SKIPS.md`.

**4. Official-design-system escape hatch → `TRANSLATE.md`, before Loop 1.**
A GOV.UK service, a Shopify app surface, or a Jira plugin has a *mandated* system, and our `§1 creativity is the baseline` would drive an agent straight past it. Add a short table (GOV.UK / USWDS / Polaris / Atlaskit / Fluent / Carbon / Material / Primer) and a rule: *if the surface is a member of one of these systems, the plugin does not run Loop 1 for style — it reports the system, and applies only its craft, states, and motion layers on top.* This is a correctness fix, and it is the only item on this list that prevents a wrong answer rather than improving a good one.

**5. The three dials → `TRANSLATE.md` row 3.**
Replace or supplement "the three-second feel" with `VARIANCE / MOTION / DENSITY` as integers, inferred from the table and stated in `DIRECTION.md`. Three benefits: the prototyper gets a testable motion target; `STYLES.md`'s new *style under density* section gets a numeric input instead of a vibe; and Gate B gains the "motion claimed = motion shown" check, which is our `§18` in a form a machine can verify.

### Note on #15

Take the native appendix only if the scope really is web + mobile + tablet + desktop. The spec currently declares native craft out of scope (lines 296-299), and those two positions must be reconciled before anyone writes the file. If native is in scope, the shape to copy is `app-interface.csv`'s — `Category | Issue | Do | Don't | Severity`, situation-indexed, ~30 rows — not the four framework CSVs, which are code hygiene rather than design.

**Do not steal:** `colors.csv`, `products.csv`, `ui-reasoning.csv`, `landing.csv`. All four are subject-indexed and all four are the failure in §5.

---

## 7. What they get wrong

### ui-ux-pro-max

1. **Confident wrong answers with no uncertainty channel.** Zero-match briefs return hardcoded `#2563EB` / `#F97316` / `Inter` indistinguishably from matched ones (`design_system.py:219-236`). A `"no confident match — here is why"` branch is ~5 lines and would fix the single worst behavior in the skill.
2. **BM25 over category names is the wrong retrieval for design.** `funeral home` → `Smart Home/IoT Dashboard`. Lexical overlap is not semantic similarity, and the three-deep fallback chain in `_find_reasoning_rule` guarantees *something* is always returned.
3. **A taxonomy that merged three axes.** Visual style, page goal, and product category in one `Style Category` column. This is the root cause of #2's severity.
4. **Advertised reasoning that is never rendered.** `Decision_Rules` and `Severity`, all 161 rows, dropped by every formatter.
5. **Prose that is not disclosed.** ~11,200 tokens of flat checklist on every invocation, including 30 chart rules for someone fixing a button. It solved disclosure for the cheap layer and not the expensive one.
6. **Ships 212 KB of files it documents as unused**, one of which is a duplicate of the other.
7. **Documented flags that error** (`--domain prompt`), and shipped data that is undocumented (`--domain icons`).
8. **Internal contradiction on icons** — 100 Phosphor rows in the data, "Heroicons/Lucide" in the prose and in the generated `MASTER.md` checklist.
9. **Frontmatter that inflates and conflates.** "10 stacks" against 16 in code and 1 in the body; "25 chart types across 10 stacks" implying per-stack chart guidance that does not exist.
10. **It recommends the tells its competitors ban.** `#7C3AED` as primary for 14 product types.
11. **No negative capability anywhere.** No rule tells the agent to *stop*, *cut*, or *do less*. Every artifact adds. Compare frontend-design's "remove one accessory."

### design-taste-frontend

1. **21,800 tokens, always on, zero retrieval.** The largest always-loaded cost of the three, and it contains a 90-line GSAP appendix and an Apple Liquid Glass CSS block that most invocations will never use. It correctly diagnosed the need for a block library (`§12`) and then never built it.
2. **Bans that are too absolute to survive.** `§9.G` bans the em-dash *and the en-dash* everywhere, including *"Date ranges (`2018-2026`) use a hyphen. Number ranges (`€40-80k`) use a hyphen."* That is typographically wrong — the en-dash is the correct character for ranges. The rule is enforcing an LLM-detection heuristic at the cost of correct typography, and it says so: *"The agent has historically ignored em-dash limits when phrased as 'use sparingly.' The phrasing here is binary."* A ban knowingly overshooting to defeat the model's own drift is a smell — the failure is real, the mechanism is a hammer.
3. **Stack-locked.** React/Next/Tailwind v4/Motion assumed throughout, with `"use client"` and `next/font` baked into rules that are otherwise stack-neutral. Everything in `§4.7` (layout discipline) is a universal design truth expressed in Tailwind class names. Our cross-agent, cross-stack constraint means we must extract the rule and drop the syntax.
4. **A 64-item pre-flight checklist.** `§14` is 64 boxes with *"THIS IS NOT OPTIONAL. Run every box."* Past roughly 20 items a checklist becomes a thing to claim rather than a thing to run. It needs tiering — the ~10 mechanical greps, then the ~15 judgment calls, then the rest as reference.
5. **Bans-heavy, opening-light.** `§9` is ~90 lines of forbidden patterns. Many name the failure without naming the escape (*"NO custom mouse cursors"*, *"NO oversized H1s"*). Our bar requires both. Their good rules do it (the palette ban lists seven alternatives); their bulk list does not.
6. **Half of it is a lookup catalog too, and it does not notice.** `§10 REFERENCE VOCABULARY` is 60 named patterns — *Gooey Menu*, *Dome Gallery*, *Holographic Foil Card*, *Liquid Swipe Transition* — with no selection procedure. It defends itself as *"a vocabulary, not a library"*, but a list of 60 cool effects with no rule for choosing between them is browsable, and browsing is how you get *Holographic Foil Card* on a legal-services site. Same trap as ui-ux-pro-max, differently dressed.
7. **Prescriptive at the wrong altitude in places.** *"Discouraged as default: `Inter`"* and *"Discouraged: `lucide-react`"* are taste calls stated as rules. They will age, and they cost credibility on the rules that are actually load-bearing.
8. **Scoped away from exactly what we do.** `§13`: not for dashboards, data tables, multi-step forms, native mobile. So it excludes the entire tool-shaped half of our spine.

### frontend-design

1. **Too small to route.** No surface-class distinction, no per-surface process, no gates, no verification. It is a strong prompt, and it stops where our pipeline starts.
2. **No verification whatsoever.** *"Critique your own work as you build, taking screenshots if your environment supports it"* is the whole check. No measurement, no states, no budget, no accessibility floor beyond one clause: *"responsive down to mobile, visible keyboard focus, reduced motion respected."*
3. **Its calibration paragraph has a shelf life.** The three named AI-default looks (`SKILL.md:31`) are correct *right now*. They are a snapshot of a moving target, and there is no mechanism to update them. Their own general test (self-simulation) is the durable version, and it sits two paragraphs below — the specific list, which will rot, is stated first.
4. **Memory dependence.** It twice suggests using notes about prior work (*"if you have a space to quickly jot down notes about what you've tried"*, *"Human creators have memory"*) with no mechanism for it. design-taste-frontend has the same hole with its palette-rotation rule, which requires knowing what the previous project used. **Both skills identify cross-run variety as essential and neither can implement it.** Our `runs/<slug>/` layout could — a one-line `runs/index.md` recording palette family and style family per run would make "do not repeat the last one" a real rule rather than an aspiration. Nobody in this competitive set has that.
5. **Web-only, unstated.** *"For web designs, the hero is a thesis"* is its only scope marker.

### All three, together

- **i18n does not exist.** Zero real content across 1.7 MB, 1206 lines, and 55 lines. Not thin — absent.
- **Tablet does not exist.** Nine passing mentions total.
- **Onboarding does not exist.** One row in 99.
- **Nobody separates page-shaped from tool-shaped as a first-class fork.** ui-ux-pro-max blends them into one style taxonomy, which is how a funeral home gets a monitoring dashboard. design-taste-frontend excludes tools by fiat. frontend-design does not raise it. **Our spine is the real differentiator in this set, and this audit strengthens rather than weakens that claim** — the competitor that tried to serve both surface classes from one index produced the worst failure I measured.
- **Nobody prototypes or measures.** No competitor builds a runnable artifact, measures a frame rate, or reports a byte cost. Our `technique-prototyper` with *"a verdict of ship / cut / ship-with-caveat"* has no counterpart anywhere in this set. That plus the two human gates is the second real differentiator.
- **Nobody handles cross-run variety**, though two of them ask for it.
