# Competitor audit — `impeccable` v3.9.1

**Audited:** 2026-07-28 · `/Users/taha/.claude/skills/impeccable`
**Against:** `/Users/taha/Documents/inter.face/docs/superpowers/specs/2026-07-28-inter-face-design.md`
**Method:** every file read.

---

## 1. What it is

### The real shape of the thing

The brief said "96 files, ~6648 lines of markdown." That undercounts it by an order of
magnitude and mis-frames what it is:

| Layer | Files | Lines |
|---|---|---|
| Markdown (`SKILL.md` + `reference/*.md`) | 29 | 6,648 |
| JavaScript / JSON (`scripts/**`) | 67 | ~43,700 |
| **Total** | **96** | **~50,300** |

**Impeccable is not a prompt pack with some helper scripts. It is a Node application
with a markdown front-end.** The JS is 6.5× the prose. That single fact should reset how
we position: our entire spec — 18 files, all markdown — competes with impeccable's
*documentation layer* only. The parts of impeccable that no one else in this category
has are all in the JS: a deterministic anti-pattern detector, editor hooks that fire on
save across four harnesses, and a live in-browser variant mode with a durable event
journal.

### File tree

```
impeccable/
├── SKILL.md                        168 lines — always loaded; router + shared law
├── reference/                       28 files, 6,480 lines
│   ├── brand.md          108        register A  ─┐ exactly one of these is
│   ├── product.md         60        register B  ─┘ mandatory every run
│   ├── craft.md          123   ┐
│   ├── shape.md          165   │  Build (4)
│   ├── init.md           172   │
│   ├── document.md       429   ┘
│   ├── extract.md         69
│   ├── critique.md       780   ┐  Evaluate (2)
│   ├── audit.md          133   ┘
│   ├── polish.md         241   ┐
│   ├── bolder.md         120   │
│   ├── quieter.md         99   │  Refine (6)
│   ├── distill.md        111   │
│   ├── harden.md         347   │
│   ├── onboard.md        234   ┘
│   ├── animate.md        201   ┐
│   ├── colorize.md       257   │
│   ├── typeset.md        279   │  Enhance (6)
│   ├── layout.md         161   │
│   ├── delight.md        302   │
│   ├── overdrive.md      130   ┘
│   ├── clarify.md        288   ┐
│   ├── adapt.md          311   │  Fix (3)
│   ├── optimize.md       258   ┘
│   ├── interaction-design.md 189   shared leaf, pulled in by craft
│   ├── live.md           718        iterate mode (10.8% of all prose)
│   ├── hooks.md           90        detector-hook admin
│   └── codex.md          105        image-gen gated sub-flow of craft
└── scripts/                         67 files
    ├── context.mjs / context-signals.mjs / palette.mjs / pin.mjs
    ├── detect.mjs + detector/       4 engines, 40-rule registry, 2,707-line rule file
    ├── hook*.mjs                    postToolUse (Claude/Codex/Copilot), preToolUse (Cursor)
    ├── live*.mjs + live/            ~20 files: HTTP helper, SSE, journal, wrap/insert/accept
    └── critique-storage.mjs         persisted scored snapshots + trend
```

### Loading strategy — genuine progressive disclosure, with a mandatory prelude

`SKILL.md` is the only always-resident file. It is deliberately small (168 lines) and
carries: a 5-step setup procedure, ~30 lines of shared design law, 7 absolute bans, the
AI-slop test, a 23-row command table, and 4 routing rules. Everything else is
on-demand.

The **setup sequence is non-optional and is the most interesting part of the
architecture** (`SKILL.md` §Setup):

1. Run `scripts/context.mjs` once per session. It prints the project's `PRODUCT.md`
   (strategic: register, users, brand personality, anti-references, principles) and
   `DESIGN.md` (visual: the Google-Stitch-format token spec) as a markdown block. If it
   reports `NO_PRODUCT_MD`, **the whole task stops and reroutes into `init`.** There is
   no "just design something" path on an unconfigured project.
2. If a sub-command was named, `reference/<command>.md` **must** be read. "Non-optional.
   The reference defines the command's flow; without it you will skip steps the user
   expects."
3. Read at least one real project file (CSS/tokens/theme/a component). Required *even
   when a sub-command reference was loaded.*
4. Read the matching register reference — `brand.md` or `product.md`. "**This is
   non-optional; skipping it produces generic output.**" Picked by first match: task cue
   → surface in focus → `register` field in `PRODUCT.md`.
5. Greenfield only: run `scripts/palette.mjs` for a brand seed color.

Typical resident context for a real invocation: 168 (SKILL) + 60–780 (command) + 60–108
(register) + project files. Usually well under 1,200 lines of skill prose. That is a
good ratio and we should match it.

### The two axes

Impeccable forks on **command × register**, a 23 × 2 matrix.

- **Command** (23 verbs, 6 categories) is the *task* axis: Build / Evaluate / Refine /
  Enhance / Fix / Iterate.
- **Register** (2) is the *surface* axis and is our surface class under a different
  name: `brand.md` = "design IS the product" (marketing, landing, campaign, portfolio,
  long-form) vs `product.md` = "design SERVES the product" (app UI, admin, dashboards,
  tools, authenticated surfaces).

Their register split is close enough to our page-shaped/tool-shaped fork that the
comparison is direct — and **they apply the fork more aggressively than we do.** Our
spec forks only the loop body. Impeccable forks at every guidance leaf: `layout.md`,
`typeset.md`, `colorize.md`, `animate.md`, `delight.md`, `bolder.md`, `quieter.md` each
open with a two-paragraph `## Register` block giving the brand answer and the product
answer before any other content. See §5, steal #9.

### Navigation

Four routing rules (`SKILL.md` §Routing rules):

1. **No argument** → run `scripts/context-signals.mjs`, read its JSON (PRODUCT/DESIGN
   presence, latest critique score + P0/P1 counts, git changed files, dev-server port
   probe, detector scan targets), reason over the raw signals, and lead with 2–3 pointed
   recommendations plus the exact command to type. Explicitly: "**Never auto-run a
   command; the recommendation is a suggestion the user confirms.**" The script
   deliberately "does NOT score or rank. The agent reasons over the raw signals."
2. **First word matches a command** → load its reference, everything after is the target.
3. **First word doesn't match but intent maps** ("fix the spacing" → `layout`) → load
   that reference and proceed as if invoked. Two candidates → ask once.
4. **No match** → general invocation using setup + shared law + register.

### Two structural decisions worth noting

**They de-composed, then re-composed.** Files like `cognitive-load.md`,
`heuristics-scoring.md`, `personas.md`, `ux-writing.md`, `typography.md`,
`color-and-contrast.md`, `responsive-design.md` used to be separate leaves. They were
folded *back into* their consuming command as a trailing `## Reference Material`
section, with an explicit note: "They live inline now so the critique flow has all its
deep context in one place." That is why `critique.md` is 780 lines. **The lesson: one
extra file-read hop was judged more expensive than 500 extra resident lines.** Worth
weighing against our 18-file plan.

**State persists across runs.** `.impeccable/critique/<iso>__<slug>.md` snapshots carry
YAML frontmatter (`score`, `p0`, `p1`, `slug`, `timestamp`). `critique` writes one and
prints a trend line — "Trend for `<slug>` (last 5 runs): 24 → 28 → 32 → 29 → 32" —
and `polish` reads the latest snapshot as its backlog. Also persisted:
`.impeccable/config.json` (+ gitignored `config.local.json`) for detector ignores and
hook settings, `.impeccable/live/config.json`, `.impeccable/design.json` sidecar. **Our
spec has no memory across runs at all.**

---

## 2. What it covers that our spec does not

Ranked roughly by how much it hurts us.

### 2.1 Component state matrices — the biggest gap

`reference/interaction-design.md:3-18` — "The Eight Interactive States":

| State | When | Visual Treatment |
|---|---|---|
| Default | At rest | Base styling |
| Hover | Pointer over (not touch) | Subtle lift, color shift |
| Focus | Keyboard/programmatic focus | Visible ring |
| Active | Being pressed | Pressed in, darker |
| Disabled | Not interactive | Reduced opacity, no pointer |
| Loading | Processing | Spinner, skeleton |
| Error | Invalid state | Red border, icon, message |
| Success | Completed | Green check, confirmation |

> "**The common miss**: Designing hover without focus, or vice versa. They're different.
> Keyboard users never see hover states."

Our spec's states are **surface**-level (3 for page-shaped: full / designed
reduced-motion / no-WebGL fallback; 9 for tool-shaped from systemcicy). These 8 are
**component**-level and orthogonal. Reinforced in `product.md:32` — "Every interactive
component has: default, hover, focus, active, disabled, loading, error. Don't ship with
half of these" — and in `polish.md:98-109`, where "Missing states create confusion and
broken experiences" is a checklist item.

Our `technique-prototyper` agent ships "all required states." Nothing in our spec says
what those are for a *component*.

### 2.2 Responsive / mobile / tablet / desktop

Our spec claims scope "web + mobile + tablet + desktop" and then never mentions tablet,
desktop, breakpoints, touch targets, or input method again. Impeccable's `adapt.md` (311
lines) is entirely this, plus `adapt.md:198-311` (the inlined `responsive-design.md`):

- Per-context strategy blocks: Mobile / Tablet / Desktop / **Print** / **Email** — two
  contexts we don't have at all. Email: "Narrow width (600px max), single column only,
  inline CSS, table-based layouts."
- **Input method ≠ screen size** (`adapt.md:208-234`): `@media (pointer: fine)` vs
  `(pointer: coarse)` vs `(hover: hover)` vs `(hover: none)`, with the rule "Don't rely
  on hover for functionality. Touch users can't hover."
- **Safe areas** (`adapt.md:236-257`): `env(safe-area-inset-*)`,
  `max(1rem, env(safe-area-inset-bottom))`, and `viewport-fit=cover` in the meta tag.
- Responsive images: `srcset` with `w` descriptors + `sizes`, and `<picture>` for art
  direction (different crops, not just resolutions).
- Touch targets 44×44px minimum, restated in `layout.md:115-122` with the hit-area
  expansion technique (`::before { inset: -10px }`).
- Testing: "DevTools device emulation is useful for layout but misses actual touch
  interactions, real CPU/memory constraints, network latency, font rendering, browser
  chrome/keyboard appearances. **Cheap Android phones reveal performance issues you'll
  never see on simulators.**"

Also `layout.md:74-82` — **container queries** for components vs viewport queries for
page layouts, with a worked example. We have nothing.

Neither skill has native (SwiftUI/Compose). Our spec is explicit about that limit;
impeccable simply doesn't claim it.

### 2.3 Onboarding, empty states, first-run

`reference/onboard.md`, 234 lines, a whole discipline we have zero coverage of.

- Framing: "Onboarding's job is not to teach the product. Its job is to get people to
  the moment that proves the product is worth their time."
- Five principles: Show Don't Tell / Make It Optional / Time to Value / Context Over
  Ceremony / Respect User Intelligence.
- Surfaces: welcome screen, account setup, core-concept intro (1–3 concepts, not
  everything), first success, empty states, contextual tooltips, feature announcements,
  progressive onboarding, guided tours ("3–7 steps max per tour"), interactive tutorials
  with a sandbox and a graduation moment.
- **Five empty-state types** with distinct treatments (`onboard.md:187-192`): first use
  (emphasize value, provide template) / user cleared (light touch) / no results (suggest
  different query, clear filters) / no permissions (explain why, how to get access) /
  error (explain what happened, retry).
- Every empty state needs five things: what will be here, why it matters, how to get
  started, visual interest, contextual help.
- Verification metrics: time to completion, comprehension, action taken, skip rate,
  completion rate, time to value.

Our TOOLS.md inherits systemcicy's 9 states, which presumably includes "empty" — but as
one state among nine, not as a designed surface with five sub-types.

### 2.4 i18n / RTL / text expansion

`harden.md:85-138` and `clarify.md:240-256`:

- Expansion budget table: German +30%, French +20%, Finnish +30–40%, Chinese −30%
  (fewer chars, same width). "Add 30-40% space budget for translations."
- Concrete failure: `<button className="w-24">Submit</button>` breaks; `px-4 py-2` doesn't.
- RTL via logical properties: `margin-inline-start`, `padding-inline`,
  `border-inline-end`, plus `[dir="rtl"] .arrow { transform: scaleX(-1) }`.
- `Intl.DateTimeFormat` / `Intl.NumberFormat` instead of hand-rolled formatting.
- Pluralization: `` `${count} item${count !== 1 ? 's' : ''}` `` is named as wrong.
- Translation-friendly patterns: "Keep numbers separate ('New messages: 3' not 'You have
  3 new messages'). Use full sentences as single strings (word order varies by
  language). Avoid abbreviations. Give translators context about where strings appear."

Our spec has `§17 respect the script and language` — one principle line, no procedure.

### 2.5 Error states and UX copy

`clarify.md` (288 lines) — our spec explicitly drops anti-slop prose because "this
plugin writes no body copy." But **error text, button labels, and empty-state copy are
design decisions**, and TOOLS.md's "the system's words" section is the only place we
touch it.

- Error formula: "(1) What happened? (2) Why? (3) How to fix it?"
- Five templates (`clarify.md:206-212`): format error → "[Field] needs to be [format].
  Example: [example]"; missing required; permission denied; network error; server error.
- Button labels (`clarify.md:188-194`): "Never use 'OK', 'Submit', or 'Yes/No'." Table:
  OK → Save changes · Submit → Create account · Yes → Delete message · **Cancel → Keep
  editing** · Click here → Download PDF. "For destructive actions, name the destruction:
  'Delete' not 'Remove'... 'Delete 5 items' not 'Delete selected'."
- Voice vs tone table (success/error/loading/destructive-confirm).
- Terminology enforcement table: Delete/Remove/Trash → Delete; Settings/Preferences/
  Options → Settings; Sign in/Log in/Enter → Sign in.
- API status-code → UI mapping (`harden.md:165-172`): 400 validation, 401 redirect to
  login, 403 permission error, 404 not-found state, 429 rate limit, 500 generic + support.

### 2.6 Accessibility depth

Our spec makes accessibility one of only two **hard, unskippable** rules and then gives
it no procedure. Impeccable's is spread but substantive:

- `SKILL.md:33` — the sharpest single a11y line in the corpus: "Body text ≥4.5:1;
  large text (≥18px or bold ≥14px) ≥3:1. **Placeholder text needs the same 4.5:1, not
  the muted-gray default.** The most common failure: muted gray body text on a tinted
  near-white."
- `interaction-design.md:20-42` — focus rings done right: never `outline: none` without
  replacement; `:focus-visible` so mouse users don't see it; 3:1 against adjacent
  colors, 2–3px, offset outside the element, consistent everywhere.
- `interaction-design.md:157-176` — roving tabindex for tab/menu/radio groups; skip links.
- `interaction-design.md:52-85` — the `inert` attribute and native `<dialog>` for focus
  trapping; the Popover API for light-dismiss + top-layer stacking ("no z-index wars").
- `colorize.md:205-231` — WCAG AA/AAA table by content type; **dangerous combinations**
  (light gray on white = "the #1 accessibility fail"; red-on-green — "8% of men can't
  distinguish these"; blue on red vibrates; yellow on white).
- `typeset.md:268-275` — never `user-scalable=no`; rem/em not px so browser settings are
  respected; 16px body minimum; links need 44px tap targets via padding or line-height.
- `critique.md:665-691` — persona "Sam", a screen-reader/keyboard-only user, with six
  named red flags including "meaning conveyed by color alone" and "time-limited actions
  without extension option."
- `audit.md:9-19` — accessibility as one of five scored dimensions with a 0–4 rubric.
- `harden.md:275-278` — Windows high contrast mode.

### 2.7 Motion system

We produce a "motion spec" as a DIRECTION.md deliverable but supply no vocabulary for
writing one. `animate.md` supplies:

- **The 100/300/500 duration table** (`animate.md:101-108`): 100–150ms instant feedback ·
  200–300ms state changes · 300–500ms layout changes · 500–800ms entrances. Framed as
  "Timing matters more than easing for 'feels right'."
- Three named easing curves with exact cubic-beziers (`ease-out-quart`
  `.25,1,.5,1` / `quint` `.22,1,.36,1` / `expo` `.16,1,.3,1`) and two explicitly banned
  (bounce, elastic — "feel dated and tacky").
- "**Exit animations are faster than entrances. Use ~75% of enter duration.**"
- **Motion materials** (`animate.md:141-151`) — an explicit rejection of
  transform-and-opacity-only: transform/opacity for movement; blur/backdrop-filter for
  focus pulls and depth; clip-path/masks for wipes and editorial cropping; shadow/glow
  for energy and affordance; grid-template-rows or FLIP for reflow. "The hard rule isn't
  'transform and opacity only.' It's: avoid animating layout-driving properties casually,
  keep expensive effects bounded, verify smoothness in-browser."
- **Stagger cap arithmetic**: "10 items at 50ms each = 500ms total. For more items,
  reduce per-item delay or cap the staggered count." With the CSS custom-property
  technique: `animation-delay: calc(var(--i, 0) * 50ms)`.
- **Perceived performance** (`animate.md:160-168`): the ~80ms threshold ("our brains
  buffer sensory input for that long"); preemptive start; early completion; optimistic
  UI (fine for likes/follows, never for payments or destructive ops); "ease-in makes
  tasks feel shorter because the peak-end effect weights final moments heavily"; and the
  counterintuitive one — "too-fast responses can decrease perceived value for complex
  operations. Sometimes a brief delay signals 'real work' is happening."

### 2.8 Design tokens and an interop format

`document.md` (429 lines) generates a `DESIGN.md` conforming to the **Google Stitch
DESIGN.md spec** — YAML frontmatter with `colors` / `typography` / `rounded` / `spacing`
/ `components`, token refs as `{colors.primary}`, six fixed markdown sections in a fixed
order ("Section headers must match character-for-character so the file stays parseable
by other DESIGN.md-aware tools"). Where the spec is too small (shadows, motion,
breakpoints, tonal ramps, full component HTML/CSS), a sidecar at
`.impeccable/design.json` carries the extensions.

Also: `colorize.md:180-191` palette-structure table (Primary / Neutral 9–11 shades /
Semantic ×4 / Surface 2–3 elevations) and the two-layer token hierarchy (primitive
`--blue-500` vs semantic `--color-primary`, "for dark mode, only redefine the semantic
layer"). `layout.md:57` argues 4pt over 8pt base scale: "8pt is too coarse and you'll
frequently need 12px between 8 and 16." `extract.md` gives the extraction threshold:
"only extract things used 3+ times with the same intent. Premature abstraction is worse
than duplication."

**Our DIRECTION.md has a palette and a type system but no token schema and no interop
format.** A downstream build step gets prose. Impeccable's gets a machine-parseable file
that a second tool can read.

### 2.9 Dark mode as a design discipline

`colorize.md:232-249` — "Dark Mode Is Not Inverted Light Mode," with a mechanism table:

| Light | Dark |
|---|---|
| Shadows for depth | Lighter surfaces for depth (no shadows) |
| Dark text on light | Light text on dark (reduce font weight) |
| Vibrant accents | Desaturate accents slightly |

Plus the 3-step surface scale (15% / 20% / 25% lightness, same hue and chroma as brand),
and "reduce body text weight slightly (e.g. 350 instead of 400) because light text on
dark reads as heavier." `typeset.md:160` gives the three-axis version: "Light text on
dark needs compensation on three axes, not just one. Bump line-height by 0.05–0.1, add
letter-spacing 0.01–0.02em, and step the body weight up one notch. The perceived weight
drops across all three; fix all three."

Our spec carries "light and dark as two designs" from portfolio.me — the slogan without
the mechanics.

### 2.10 Cognitive load

`critique.md:257-362` — the three types (intrinsic / extraneous / germane), the working
memory rule (**≤4 items**, "Miller's Law revised by Cowan, 2001") with per-surface
application (nav ≤5 top-level, ≤4 form fields per group, 1 primary + 1–2 secondary
buttons, ≤4 dashboard metrics above the fold, ≤3 pricing tiers), an 8-item checklist
with a scoring band (0–1 failures = good, 2–3 = address soon, 4+ = critical), and 8 named
violations with fixes (The Wall of Options, The Memory Bridge, The Hidden Navigation,
The Jargon Barrier, The Visual Noise Floor, The Inconsistent Pattern, The Multi-Task
Demand, The Context Switch).

### 2.11 Evaluation rubrics

Both of our gates are unstructured human judgment. Impeccable has two scoring systems:

- **Nielsen 10 heuristics × 0–4** (`critique.md:366-599`) with a written rubric per score
  per heuristic, a /40 total, a five-band rating table, and P0–P3 severity tagging with
  the tiebreaker "Would a user contact support about this? If yes, it's at least P1."
- **Audit health score** (`audit.md`) — five technical dimensions (a11y, performance,
  theming, responsive, anti-patterns) × 0–4 = /20, with rating bands and a per-dimension
  rubric.

(See §6.8 for why I think the composite numbers are partly theater. The *rubrics* are
still better than what we have, which is nothing.)

### 2.12 Personas as a testing procedure

`critique.md:603-780` — five archetypes (Alex power user, Jordan first-timer, Sam
a11y-dependent, Riley stress tester, Casey distracted mobile), each with profile,
behaviors, **test questions**, and **red flags to report specifically**. Plus a selection
table by interface type and a template for deriving project-specific personas from
`PRODUCT.md`. The instruction is good: "Be specific. Name the exact elements and
interactions that fail each persona. Don't write generic persona descriptions; write
what broke for them."

Our TRANSLATE.md row 2 ("who is looking, and what decision or task") is one input row.
This is a testing loop.

### 2.13 Performance as a named discipline

`optimize.md` — Core Web Vitals with targets (LCP <2.5s, INP <200ms, CLS <0.1) and
per-metric fix lists; layout thrashing with the batched-read/batched-write example;
`content-visibility: auto` for long lists; virtual scrolling; `contain`. Our spec has
two budget tiers and a measured frame rate, which is narrower but arguably better
targeted (see §5).

### 2.14 Icons and charts (both thin, but non-zero)

- **Icons**: `craft.md:92` — "Coherent icon set. Use the project's established set;
  otherwise pick one library or use accessible text. **Don't mix.**" `craft.md:30`
  checks for `lucide-react` / `@phosphor-icons/react` / `@iconify/*` / hand-rolled
  sprites before starting. `polish.md:128-134` covers consistent style, sizing, optical
  alignment with adjacent text, and 2× assets. `document.md:300` — sidecar icons must be
  inlined SVG, not package references.
- **Charts**: `colorize.md:78-82` (encode categories, heatmap intensity, comparison
  coding); `overdrive.md:64-67` (GPU-accelerated charts via Canvas/WebGL for datasets too
  large for SVG/DOM — deck.gl, regl; animated data transitions that *morph* between
  states rather than replacing).

Both are gaps for us, but neither is deep enough in impeccable to be a real threat.
Charts especially: a data-heavy tool-shaped surface is exactly our systemcicy heritage,
and neither skill has a real chart discipline. **That is an open position, not a
liability.**

### 2.15 Industry verticals — neither has them, and impeccable is right about why

Impeccable actively **refuses** vertical recipes, and says so in a way that matches our
own quality bar. `brand.md:46`:

> "A category ('restaurant', 'dev tool', 'magazine', 'fintech') is not a recipe;
> treating it as one is the first-order reflex SKILL.md warns against."

Our category-cliché fence from webcrab is the same instinct executed as a *fence* (nine
categories, each with the cliché and the opening) rather than a *field*. That is the
right shape and we should keep it. No change needed here.

### 2.16 Structural capabilities with no analogue in our spec

- **Deterministic detector.** `scripts/detect.mjs` + `detector/` — 40 named
  anti-patterns in a registry, implemented across four engines (regex/source,
  static-html with a CSS cascade resolver, live-browser via injected script,
  visual-contrast from screenshots). Real thresholds, not vibes: side-tab fires at
  `width ≥ 2px && (maxOtherSide ≤ 1 || width ≥ 2 × maxOther)` on a non-neutral color,
  plus `radius > 0` or `width ≥ 3`; icon-tile fires on a 32–128px squarish sibling with
  a visible background or border, containing an icon child <95% its width, ending above
  the heading's top; hero-eyebrow fires on a 2–60-char sibling at ≤14px that is either
  tracked-caps (`letter-spacing ≥ 1.6`) or accent-bold (`weight ≥ 700` + accent color).
  Exit code 2 = findings.
- **Editor hooks.** `hook.mjs` / `hook-before-edit.mjs` install into
  `.claude/settings.local.json`, `.codex/hooks.json`, `.cursor/hooks.json`, and
  `.github/hooks/impeccable.json`. Claude/Codex/Copilot get a post-edit system reminder;
  **Cursor blocks the write via `preToolUse` when the detector finds a real issue.**
- **Live mode.** A local HTTP helper on port 8400, SSE, a durable append-only journal
  under `.impeccable/live/sessions/`, an in-page element picker with comment pins and
  freehand strokes, three-variant generation hot-swapped through HMR, a docked parameter
  panel, a "carbonize" accept flow that stitches the winner into source with markers the
  agent must then clean up, and automatic CSP patching (detects `append-arrays` /
  `append-string` / `middleware` / `meta-tag` shapes, patches the first two behind a
  consent prompt with a `NODE_ENV === "development"` guard).
- **Pin.** `pin.mjs` writes standalone `/typeset`, `/polish` etc. shortcuts into every
  harness directory present.

---

## 3. What it does better than our spec

Honest list. These are places where their prose is sharper than what our spec describes.

### 3.1 The second-order category-reflex check — the single best idea in the corpus

`SKILL.md:97-100`:

> **Category-reflex check.** Run at two altitudes; the second one catches what the first
> one misses.
>
> - **First-order:** if someone could guess the theme + palette from the category alone,
>   it's the first training-data reflex.
> - **Second-order:** if someone could guess the aesthetic family from
>   category-plus-anti-references ("AI workflow tool that's not SaaS-cream →
>   editorial-typographic", "fintech that's not navy-and-gold → terminal-native dark
>   mode"), it's the trap one tier deeper. The first reflex was avoided; the second
>   wasn't. Rework until both answers are not obvious.

Our category-cliché fence is **first-order only**. It catches "law firm → navy and
serif." It does not catch "law firm that is deliberately not navy-and-serif → warm
editorial with a Fraunces italic," which is where every anti-cliché run actually lands.
This is a decision procedure with two runnable tests and a stop condition. It meets our
quality bar better than the thing we planned to ship.

### 3.2 Absolute bans in match-and-refuse form

`SKILL.md:80-91` opens with the enforcement verb, not a description:

> **Match-and-refuse.** If you're about to write any of these, rewrite the element with
> different structure.

Each ban then carries **the pattern + why it's wrong + the named escapes**:

> **Side-stripe borders.** `border-left` or `border-right` greater than 1px as a colored
> accent on cards, list items, callouts, or alerts. Never intentional. **Rewrite with
> full borders, background tints, leading numbers/icons, or nothing.**

And the two hardest ones carry a **distinction sentence** — the reusable form that keeps
a ban from becoming a blanket prohibition:

> "One named kicker as a deliberate brand system is voice; an eyebrow on every section
> is AI grammar."
>
> "One deliberate numbered sequence on one page is voice; numbered eyebrows on every
> section across the site is AI grammar."

That template — *X once is voice; X as grammar is the tell* — is worth adopting as our
standard form for every entry in the cliché fence.

### 3.3 The cream/sand ban is a genuinely checkable rule

`SKILL.md:71`:

> **The cream / sand / beige body bg is the saturated AI default of 2026.** The whole
> warm-neutral band (OKLCH L 0.84-0.97, C < 0.06, hue 40-100) reads as
> cream/sand/paper/parchment regardless of what you call it. Token names like `--paper`,
> `--cream`, `--sand`, `--bone`, `--flour`, `--linen`, `--parchment`, `--wheat`,
> `--biscuit`, `--ivory` are tells in themselves. If the brief is "warm, traditional,
> family-coastal-Italian" or "magazine-warm" or "editorial-restraint", DO NOT translate
> that into a near-white warm-tinted bg; that's the AI move. Pick: (a) a saturated brand
> color as the body, (b) a true off-white at chroma 0 (or chroma toward the brand's own
> hue), or (c) a darker mid-tone tinted neutral that's clearly the brand's own.
> "Warmth" in the brand is carried by accent + typography + imagery, not by body bg.

This is the model form for everything in our `STYLES.md`: **a numeric detection range, a
naming-level detection (the token names are themselves the tell), the specific briefs
that trigger the reflex, and three named escapes.** Not a list to browse — a rule you can
run against a candidate palette and get a yes/no.

### 3.4 The scene sentence, with a stop condition

`SKILL.md:73`:

> Dark vs. light is never a default. Not dark "because tools look cool dark." Not light
> "to be safe." Before choosing, write one sentence of physical scene: who uses this,
> where, under what ambient light, in what mood. **If the sentence doesn't force the
> answer, it's not concrete enough. Add detail until it does.**

A self-terminating procedure. Our TRANSLATE.md row 3 is "the three-second feel," which is
an adjective bucket. Theirs forces a physical scene and then *tests the sentence against
a binary decision* — if it doesn't decide the question, iterate. Adopt the stop
condition verbatim.

### 3.5 The inverse test

`brand.md:15`:

> Then the inverse test: in one sentence, describe what you're about to build the way a
> competitor would describe theirs. If that sentence fits the modal landing page in the
> category, restart.

One sentence, runnable, falsifiable, no lookup required. This belongs in our Gate A.

### 3.6 Gate anti-compression discipline

`craft.md:9-20` and `codex.md:8-16`. Impeccable has *four* human gates before code and
defends each one individually, by name, against the specific failure of collapsing them:

> Craft has **multiple user gates**, not one... You must stop at every gate. **Shape
> confirmation alone is NOT a green light to start coding.** It is the green light to
> begin codex.md Step A. **Compressing gates 2 through 4 because the shape brief felt
> complete is the dominant failure mode of this flow.**

> **Four stop points before code.** ... **Prior shape approval does not satisfy any of
> these.** Shape's "confirm or override" advances you into Step A; it is not a substitute
> for it.

And `craft.md:79`: "**Do not mention implementation, file paths, or patch plans until
that's done.** ... the model that compressed those gates is the model that already failed
this flow."

Our spec says "Two gates, renamed from portfolio.me's B1/B2." It does not name gate
compression as a failure mode or defend against it. Given that our Gate A → Loop 2
boundary is exactly the seam where an eager agent will jump straight to technique
assignment, this is a cheap and necessary addition.

### 3.7 The degraded-run banner

`critique.md:9`:

> If you degrade for any reason, the report's first line MUST be a banner:
> `⚠️ DEGRADED: single-context (<reason>)`. **A silent degraded critique is a failed
> critique.**

Reinforced with a provenance requirement on the report header (`Method: dual-agent
(A: <agent-id> · B: <agent-id>)`) and an explicit definition of what "unavailable"
means: "exactly one thing: no sub-agent/Task tool is exposed in this session. **It does
not mean inconvenient.**"

Our `SKIPS.md` is the same mechanism with worse placement. A skip recorded in a sidecar
file is a skip the reader never sees. **The skip should be line 1 of `DIRECTION.md`.**

### 3.8 Live mode's identity lock and its mode asymmetry

`live.md:200-233`. Three things here are better than anything in our spec.

**The identity extraction is non-skippable and bans conclusion-words:**

> Write down what you see in **one sentence**... Be specific. "Modern" is not a color,
> "elegant" is not a type pairing, "clean" is not a layout. If you can't extract a real
> value for an axis, skip it rather than fabricate. The point is to record what is, not
> to describe what you wish it were.
>
> Do not include adjectives that name an aesthetic family ("editorial-leaning",
> "terminal-flavored", "brutalist"); those are conclusions, not data... **Letting them
> sneak into Phase A is how the identity-lock collapses into a self-fulfilling
> prophecy.**

**The default/departure decision has an explicit asymmetric-cost tiebreaker:**

> If you're unsure, you're in default mode. The cost of being wrong about default is
> "three on-brand variants with similar feel": recoverable, the user picks none. The cost
> of being wrong about departure is "three off-brand variants": unrecoverable, the user
> is annoyed.

That is how you write a decision rule for an agent: not "use judgment," but "here is the
default, here is the trigger list, and here is why the error is asymmetric."

### 3.9 The anti-catalog passage — our own thesis, written by the competitor

`live.md:249-256`, departure mode:

> **Do NOT pick from a fixed catalog of lane categories.** The right three directions for
> this brand are not the same as the right three for another brand, and **picking from a
> list is itself the training-data reflex** (the model selects "Swiss-grid, Terminal,
> Industrial-signage" every time because those are the furthest-from-editorial items in
> any enumerated list).
>
> Instead, work from the brand:
> 1. Read PRODUCT.md's Brand Personality words. What physical, spatial, or material
>    experiences would embody those words if design were not involved? (A personality
>    described as "specific, earned, unmistakable" evokes a hand-stamped letter, a
>    numbered print, a watchmaker's loupe.)
> 2. From those physical experiences, derive three visual directions genuinely different
>    from each other AND from the current surface.
> 3. Avoid the reflex-reject lanes. Don't trade one monoculture for another. **If you
>    find yourself reaching for "Swiss-grid" or "Terminal" by reflex, you are
>    pattern-matching a catalog in your training data, not reading the brand. Start over
>    from the personality words.**
> 4. Each direction must be expressible in one concrete sentence that names a real-world
>    referent ("a museum exhibition label system for a contemporary art gallery" not
>    "clean and minimal"). **If your sentence contains only adjectives, it's not concrete
>    enough.**

Personality words → physical experiences → visual directions, with a concreteness test
at the end. This is the derivation procedure our `STYLES.md` §"Picking one" needs, and
it is materially better than webcrab's five-input procedure because it never touches a
list.

### 3.10 The family/squint distinctness pass

`live.md:263-268`:

> **Family pass.** Label each variant with one design-family word of your own choosing
> (any concrete noun: *exhibition, storefront, cockpit, recipe-card, playbill,
> field-manual*). If any two variants share a label, or if the label could apply to the
> other variants equally well, rework. **Do not use a fixed vocabulary list for the
> labels.** *This pass is non-negotiable in departure mode and catches the monoculture
> failure that the sentence pass misses.*
>
> **Sentence pass.** Write three one-sentence descriptions side by side. If two of them
> rhyme ("both feature big type" / "both are stacks of sections" / "both center the
> CTA"), rework the offender.
>
> When the primary axis is color or theme, forbid the trio from sharing theme + dominant
> hue. Two dark-plus-one-dark is not distinct.

Our Loop 1 says "generate 2–3 distinct concepts." It supplies **no test for
distinctness**. This is that test, it is two passes deep, and it explicitly forbids the
list-based version of itself. Straight into Gate A.

### 3.11 The parameter budget, indexed on a measurable property

`live.md:355-362` — how many tuning knobs a generated variant should expose, keyed on
visual weight, with counts:

| Weight | Definition | Params |
|---|---|---|
| Leaf / tiny | a button, icon, input, bare heading | 0 |
| Small composition | labeled input, simple card (≤ ~5 visual children) | 0–1 |
| Medium composition | section, nav cluster, dense card (6–15 children) | target 2 |
| Large composition | hero, page region, spread (16+ children or multi-section) | target 2–3, up to 4 |

> Count by **visual** children, not DOM depth; a shallow-but-wide hero is still large.
> ... **under-shipping knobs on a dense composition is the more common failure.**

A budget table indexed on something countable, with the failure direction named. That is
the shape our two-tier performance budget should take.

### 3.12 Assert-then-confirm

`shape.md:28`:

> **Assert-then-confirm, not menu-with-escape.** When PRODUCT.md and the user's prompt
> make one option obvious, name it and ask the user to confirm or override. Don't
> enumerate "Restrained / Committed / Or something else?" as a real choice; "This reads
> as Restrained, confirm?" beats a four-option menu when the answer is already clear.

And `shape.md:157`:

> Don't list "open questions" you've already recommended a default for; assert the
> default and move on. **If you'd write `Recommend: X` next to a question, just decide X.**

Both apply directly to `TRANSLATE.md` intake (our spec says the plugin "refuses to enter
Loop 1 with an empty row; it asks") and to both gates.

### 3.13 Root-cause classification of drift

`polish.md:13`:

> **Identify drift, then name the root cause**: For every deviation, classify it as a
> **missing token** (the value should exist in the system but doesn't), a **one-off
> implementation** (a shared component already exists but wasn't used), or a
> **conceptual misalignment** (the feature's flow, IA, or hierarchy doesn't match
> neighboring features). The fix differs by category: patch the value, swap to the shared
> component, or rework the flow. **Fixing the symptom without naming the cause is how
> drift compounds.**

Structurally identical to our gate rejection diagnosis (rejected execution vs concept vs
brief) — three-way classification where the classes route to different remedies. Good
confirmation that the shape works; worth reusing at Gate B for prototype verdicts.

### 3.14 A named failure that directly threatens our deliverable

`SKILL.md:59`:

> **Reveal animations must enhance an already-visible default.** Don't gate content
> visibility on a class-triggered transition; **transitions pause on hidden tabs and
> headless renderers, so the reveal never fires and the section ships blank.**

We produce screenshots of prototypes via headless rendering. If a prototype gates
visibility behind a scroll-triggered class, our design image is a blank rectangle and we
won't know why. This is a named failure with a mechanism and an escape, aimed squarely
at our pipeline.

---

## 4. Where it falls into the catalog trap

Impeccable is roughly half procedure, half catalog. The catalog half is concentrated in
the Refine/Enhance/Fix commands, and it follows a recognizable template: *Assess (5
bullets) → Plan (4 bullets) → Improve systematically across N dimensions (N × 5 bullets)
→ NEVER (8 bullets) → Verify (6 bullets).* That template is browsable, not runnable.

**`delight.md` (302 lines) is the worst offender.** Its sections are eight menus:
Micro-interactions / Personality in Copy / Illustrations / Satisfying Interactions /
Sound Design / Easter Eggs / Loading & Waiting / Celebration Moments. There is no
decision procedure for *which moment earns delight* — the closest is a list of seven
"natural delight moments" which is itself a menu. And it self-refutes: it supplies
example playful copy —

> "Error 404" → "This page is playing hide and seek. (And winning)"
> "Connection failed" → "Looks like the internet took a coffee break. Want to retry?"

— then 120 lines later warns:

> **WARNING**: Avoid cliched loading messages like "Herding pixels", "Teaching robots to
> dance"... These are AI-slop copy, instantly recognizable as machine-generated.

The two examples it *supplies* are the same register as the ones it *bans*. That is the
category reflex arriving through the front door, delivered by a file that knows better.

**`harden.md` (347 lines)** is an exhaustive list of everything that can break, with no
ordering, no triage, and no procedure for deciding which of the ~60 items applies to the
surface at hand. Its `NEVER` block is eight universal truisms ("Assume perfect input,"
"Ignore internationalization," "Leave error messages generic"). An agent reading this
either does all of it or picks arbitrarily.

**`adapt.md`** is the sharpest instance of the trap because it *names the trap in its own
first paragraph*:

> "The trap is treating adaptation as scaling. The job is rethinking the experience for
> the new context." ... "**CRITICAL**: Adaptation is rethinking the experience for the new
> context, not scaling pixels."

Then, thirty lines later, it hands you the scaled version as a recipe: "Mobile: single
column instead of multi-column. Vertical stacking. Full-width components. Bottom
navigation instead of top/side navigation. Hamburger menu." That *is* the category
reflex for mobile, prescribed. A model reading this file produces the modal mobile
layout while believing it followed the instruction not to.

**`optimize.md`** opens correctly — "Identify the actual bottleneck for THIS interface,
fix it, then measure. Don't optimize what isn't slow" — and then delivers 200 lines of
generic web-performance advice organized by technology (images, JS bundle, CSS, fonts,
rendering, animation, React, network) regardless of what the bottleneck turned out to be.
The React subsection (`memo` / `useMemo` / `useCallback`) is framework trivia inside a
design skill.

**`distill.md` and `quieter.md`** are the same five-dimension × five-bullet shape. Much
of their content is duplicated across `polish.md`, `layout.md`, and `bolder.md`. Six of
the 23 commands independently say "use a consistent spacing scale, don't use arbitrary
values, fix the hierarchy."

**`onboard.md`'s implementation section** is a dated library catalog with no selection
criterion: "Tooltip libraries: Tippy.js, Popper.js. Tour libraries: Intro.js,
Shepherd.js, React Joyride. Physics libraries: React Spring, Popmotion."

**`palette.mjs` — 129 hand-curated seeds.** This is a lookup catalog, but the most
defensible one in the corpus, and the header comment argues the case:

> "4-color frozen palettes drift toward safe defaults (warm-cream bg, complementary
> accent on near-white) regardless of brief. A single seed + the model's own composition
> lets the same seed produce a dark-mode jazz club or a light-mode hospitality brand
> depending on what the brief calls for. Tested empirically against curated 4-color
> palettes; seed approach wins on mood-fit in 3 of 5 cases and ties on the rest."

The mitigation is real: only *one* color comes from the catalog and the other five roles
are composed by the model against the brief, under hard constraints (ink ≥7:1, primary
chroma ≤0.23, primary-vs-accent contrast ≥1.7, no muddy mid-tone accents, target
distribution ~50% pure white / ~25% pure black / ~25% tinted). But the seed is still
selected *at random or by hashing a key*, not derived from the subject. **Our
`TRANSLATE.md` row 6 — "color sampled from reality" — is a strictly better answer to the
same problem**, and this is the clearest place where our approach beats theirs.

**`critique.md`'s persona selection table** is a lookup ("Landing page → Jordan, Riley,
Casey; Dashboard → Alex, Sam"). The per-persona red-flag lists are checkable rules, so it
half-escapes, but the five stock names are a fixed catalog of users.

**`overdrive.md`'s toolkit** is a catalog with the right mitigation: it is indexed by
*intent* ("Make transitions feel cinematic," "Tie animation to scroll position," "Make
data feel alive," "Push performance boundaries") rather than by technology, and every
entry carries current browser support inline. That indexing is the cheapest possible
defense against browsing-by-technology and we should copy it (steal #16).

---

## 5. What we should steal — ranked

Ranked by (value to us) × (cheapness). "Rewrite" = does not currently meet our bar of
*decision procedure / named failure with escape / checkable rule*.

| # | What | Goes in | Rewrite? |
|---|---|---|---|
| 1 | Departure-mode concept derivation (personality → physical experience → direction, with the concreteness test) + the explicit anti-catalog instruction | `STYLES.md` §"Picking one"; `loops/01-direction.md` | No — verbatim, retargeted |
| 2 | Family pass + sentence pass distinctness test on the 2–3 concepts | `loops/01-direction.md`, enforced at Gate A | No |
| 3 | Second-order category-reflex check | `STYLES.md` cliché fence; `PRINCIPLES.md §1` | No |
| 4 | Match-and-refuse ban form + the "*X once is voice; X as grammar is the tell*" distinction sentence | `STYLES.md`, `CRAFT.md` | Rewrite ours into this shape |
| 5 | Eight component interaction states + "the common miss: hover without focus" | `TOOLS.md`; prototype requirements in `CRAFT.md` | Merge with our 9 surface states — they are orthogonal axes, say so |
| 6 | Scene sentence with its stop condition ("if it doesn't force the answer, add detail until it does") | `TRANSLATE.md` row 3 | Replaces our "three-second feel" phrasing |
| 7 | Degraded/skip banner as line 1 of the deliverable, not a sidecar | `PRINCIPLES.md` §skipping; `DIRECTION.md` template | Restructure — keep `SKIPS.md`, add the banner |
| 8 | Gate anti-compression: name the collapse as *the* dominant failure mode, defend each gate individually | `loops/*.md`, both gates | Write fresh in their voice |
| 9 | Register block at every guidance leaf (page-shaped / tool-shaped, two lines, before any other content) | every section of `STYLES.md` + `CRAFT.md` | Structural; cheap; high leverage |
| 10 | Parameter knobs on prototypes (`range` / `steps` / `toggle` → CSS custom properties + data attributes) with the visual-weight budget table | `CRAFT.md`; `agents/technique-prototyper.md` | Real capability add — a prototype tunable at Gate B without a rebuild |
| 11 | Motion vocabulary: 100/300/500 duration table, three named easings + two banned, exit = 75% of enter, stagger cap arithmetic, the motion-materials list | `CRAFT.md` motion spec | Trim to the checkable parts; drop the prose |
| 12 | The reveal-animation blank-section failure (transitions pause in headless renderers) | `CRAFT.md` prototype states; `agents/technique-prototyper.md` | No — already a named failure with a mechanism |
| 13 | Assert-then-confirm + "if you'd write `Recommend: X`, just decide X" | `TRANSLATE.md` intake; both gates | No |
| 14 | Contrast rules with the named #1 failure (muted gray on tinted near-white; placeholders need 4.5:1 too) | `PRINCIPLES.md` accessibility — currently a hard rule with no procedure | Rewrite into checkable form |
| 15 | Dark-mode mechanics (depth from surface lightness not shadow; 3-step scale at 15/20/25% L; body weight 400→350; three-axis light-on-dark compensation) | `STYLES.md` "light and dark as two designs" | No — ours is a slogan, theirs is mechanics |
| 16 | Intent-first indexing layered over the technique arsenal ("make transitions feel cinematic" → the techniques), plus inline browser-support | `CRAFT.md` | Additive index over our family taxonomy; cheap |
| 17 | The inverse test ("describe it the way a competitor would describe theirs; if it fits the modal page, restart") | Gate A checklist | No |
| 18 | Three-way root-cause classification applied to prototype verdicts | Gate B; `agents/technique-prototyper.md` | Adapt from `polish.md`'s drift version |
| 19 | Machine-readable token block in `DIRECTION.md` (frontmatter, semantic keys, `{ref}` syntax) so a build step gets data not prose | `DIRECTION.md` template | Design ours; don't adopt Stitch's 8-prop limit, it's too small |
| 20 | Persisted scored snapshot + trend line across runs | Out of scope for v1 — note as the v2 direction | n/a |
| 21 | A detector run against our own prototypes at Gate B | Out of scope for v1 — but see below | n/a |

**Two strategic notes on the bottom of the list.**

*On #21.* We stop before code, so a source-code detector looks out of scope. But **our
prototypes are code**, and they are code we generated. A 40-rule detector pass over
`prototypes/*.html` at Gate B costs almost nothing and would make us the only
design-only pipeline in this space with an automated check on its own output. It is the
clearest available differentiator against every markdown-only competitor. Flag it for v2.

*On our advantage over their whole ban strategy.* Impeccable's anti-slop knowledge is a
timestamped snapshot: "the 2023-era kicker," "the saturated AI default of 2026," "more
entries land here on the same cadence the font list updates." It requires perpetual
maintenance and it guarantees that every user of the skill converges on the same
*anti*-pattern — the second-order reflex it names but cannot escape by adding bans. Our
`TRANSLATE.md` row 5 (anti-positioning, derived per-run from the subject) does not decay.
**We should say this out loud in `README.md` and in `PRINCIPLES.md`.** It is our
strongest structural argument and it costs nothing to make.

---

## 6. What it gets wrong

### 6.1 `adapt.md` prescribes the reflex it forbids

Covered in §4. The file's thesis ("rethinking, not scaling") and the file's content (the
canonical scaled mobile layout as a bullet list) are in direct opposition. Whichever a
model follows, it violates the other.

### 6.2 Two contradictory breakpoint sets in one file

`adapt.md:132-135`: "Mobile: 320px-767px / Tablet: 768px-1023px / Desktop: 1024px+."
`adapt.md:175`: "**NEVER** ... Use generic breakpoints blindly (use content-driven
breakpoints)." `adapt.md:204`: "Don't chase device sizes; let content tell you where to
break... Three breakpoints usually suffice (640, 768, 1024px)."

Three positions, two of them numeric and different, inside 70 lines.

### 6.3 Two disagreeing banned-font lists

`brand.md:32` reflex-reject: Fraunces · Newsreader · Lora · Crimson (×3) · Playfair
Display · Cormorant · Syne · IBM Plex (×3) · Space Mono · Space Grotesk · Inter · DM Sans
· DM Serif (×2) · Outfit · Plus Jakarta Sans · Instrument Sans · Instrument Serif.

`detector/shared/constants.mjs` `OVERUSED_FONTS`: inter · roboto · open sans · lato ·
montserrat · arial · helvetica · fraunces · instrument sans · instrument serif · geist
(×3) · mona sans · plus jakarta sans · space grotesk · recoleta.

Neither is a superset. The prose bans Syne, Lora, Cormorant, IBM Plex, DM Sans, Outfit —
the detector doesn't flag any of them. The detector flags Roboto, Lato, Montserrat,
Arial, Helvetica, Geist, Mona Sans, Recoleta — the prose doesn't ban any of them. The
model and the machine disagree about the rule they are both enforcing.

Worse, the prose ban directly contradicts a sibling file: `product.md:57` lists "System
fonts and familiar sans defaults (**Inter**, SF Pro, system-ui stacks)" as a **product
permission**, and `typeset.md:175` says "System fonts are underrated." The contradiction
is resolved only by the register split — which an agent that loaded `brand.md` will never
see, because it loaded exactly one register file.

### 6.4 Contradictory guidance on humor in errors

`clarify.md:158` ("NEVER ... Use humor for errors — be empathetic instead") and
`clarify.md:234` ("**Never use humor for errors.** Users are already frustrated. Be
helpful, not cute."). Meanwhile `delight.md:117-124` supplies playful 404 and
connection-failure copy as a technique. A 404 is not a validation error and the
distinction would resolve it — the corpus never draws it.

### 6.5 Contradictory guidance on cards, with no positive criterion

`SKILL.md:47` "Cards are the lazy answer. Use them only when they're truly the best
affordance. Nested cards are always wrong." · `layout.md:86` "Don't default to card grids
for everything." · `distill.md:55` "Remove unnecessary cards." · `brand.md:71` "When cards
ARE the right affordance, use `repeat(auto-fit, minmax(280px, 1fr))`."

Four prohibitions, one conditional, and **no file anywhere states when a card *is* the
right affordance.** A rule an agent can satisfy only by avoidance is a rule that produces
worse design, not better — it pushes the model toward exotic containers to dodge the ban.

### 6.6 The 60-30-10 rule survives its own refutation

`colorize.md:9` opens with the register block: "Committed, Full palette, and Drenched
deliberately exceed the ≤10% rule; **that rule is Restrained only.**" Then
`colorize.md:193-201` reprints 60-30-10 in the shared Reference Material as "The 60-30-10
Rule (Applied Correctly)" with no caveat and the flat assertion "Accent colors work
*because* they're rare. Overuse kills their power." A Drenched brand hero read against
that section fails a rule that doesn't apply to it.

### 6.7 Dated technical references

- `optimize.md:199` — "First Input Delay (FID < 100ms) / INP (< 200ms)." FID was
  deprecated in favor of INP in March 2024. It hedges but still leads with the dead
  metric and repeats "FID" in the key-metrics list.
- `delight.md:267` — "Framer Motion (React)." Renamed to `motion`. `SKILL.md:56` and
  `overdrive.md:53` both know the new name; `delight.md` doesn't.
- `delight.md:277` — Popmotion, absorbed/deprecated.
- `onboard.md:198-202` — Intro.js, Shepherd.js, React Joyride, Tippy, Popper as the
  recommended set, with no note that `interaction-design.md` in the same skill recommends
  the native Popover API and CSS Anchor Positioning for exactly these jobs and calls it
  "accessible by default" with "no z-index wars."

### 6.8 The composite scores invite number theater

Two problems with the Nielsen /40.

First, the anchor: "**Most real interfaces score 20-32.**" Given to a model that also
generates the scores, this is an instruction to produce a number in that band, not an
observation about the world.

Second, the composite is structurally unfair to whole surface classes. Heuristic 10
(Help and Documentation) is scored on every interface — including a one-page marketing
site where "no help available anywhere" is score 0 *and also the correct design*.
Heuristic 7 (Flexibility / accelerators, keyboard shortcuts, bulk actions) is likewise
near-zero-by-design on a brand page. **A landing page is structurally capped around
34/40 for reasons that are not defects**, and the trend line ("24 → 28 → 32 → 29 → 32")
then treats that ceiling as a performance history. The per-heuristic rubrics are good.
The sum is not a measurement.

### 6.9 Five stock personas are the category reflex applied to users

Alex / Jordan / Sam / Riley / Casey, with a lookup table mapping interface type →
personas. This is the same failure the skill's own `SKILL.md` warns about, one level up:
a fixed catalog that a model selects from by reflex. A model given these five will report
Alex's power-user red flags ("no keyboard shortcuts detected") on a surface that has no
power users. The file half-catches it — "Only generate project-specific personas when
real Design Context data is available" — but the default path is the five stock names,
and the derived personas are capped at "1–2 additional."

### 6.10 Engineering advice inside a design skill

`harden.md:229-234` instructs on server-side validation, injection attacks, and rate
limiting. `optimize.md` covers web workers, WASM, bundle analyzers, and Sentry/DataDog.
`harden.md:288-292` covers memory leaks and subscription cleanup. Our spec's
`PRINCIPLES.md` section explicitly drops deploy reversibility, attribution, and NDA
handling as "belonging to whatever ships the design; a design plugin that enforces deploy
rules is overreaching." The same argument applies here, and impeccable didn't make it.

### 6.11 `delight.md` contains actively bad advice

- "**Mini-games during long loads.**" This makes a slow product feel slower (it draws
  attention to the wait), it is a maintenance liability, and it is a 2015 idea.
- **Sound design defaults to on.** It says "respect system sound settings, provide mute
  option" but never says opt-in-first. Unrequested audio on a web surface is a defect.
- "**Confetti burst for major achievements**" and "'Achievement unlocked' style
  notifications" listed without a register gate. `delight.md`'s own register block says
  product delight belongs at "completion, first-time actions, error recovery, milestone
  crossings" — then the technique list ignores it.
- "**Konami code unlocks special theme**" as a recommended easter egg.

### 6.12 `live.md` is 10.8% of the corpus and is not design

718 lines of poll-loop semantics, per-harness threading policy, SSE reconnection, a
durable journal protocol, CSP auto-patching templates per framework, Svelte component
sidecar params, and a five-step "carbonize" source-cleanup ritual. It is impressive
engineering. It also means that in impeccable's `reference/` directory, **the largest
single document an agent might load is about debugging a WebSocket-adjacent event loop**,
sitting alongside the files about choosing a typeface. The design content inside it
(§3.8–3.11 above, all excellent) is buried in transport plumbing.

For us this is a direct warning: our `AGENTS.md` cross-agent adapter layer and our
`agents/*.md` dispatch specs must not grow into this. Keep the mechanism out of the
guidance files.

### 6.13 The strategic weakness: bans decay, derivations don't

Stated in §5 but it belongs here as a criticism. Impeccable's anti-slop layer is a
snapshot of what generators produce *right now*, encoded as prohibitions:
"the 2023-era kicker," "the saturated AI default of 2026," "(More entries land here on
the same cadence the font list updates. Brutalist-utility and acid-maximalism may join
when they saturate.)"

Two consequences it acknowledges and one it doesn't. It acknowledges the maintenance
treadmill. It acknowledges the second-order reflex. It does **not** acknowledge that a
widely-adopted ban list *creates* the next monoculture — every impeccable user avoids
Fraunces, so the escape route from Fraunces becomes the new saturated lane, and the fix
is another ban. The `reflex-reject aesthetic lanes` section is that cycle already
happening, one turn in, with exactly one entry (editorial-typographic) and a note that
more are coming.

A per-run derivation from the subject's own anti-positioning does not have this
property. That is our position and we should hold it.

---

## Appendix — quick facts worth keeping

- **Version** 3.9.1, Apache 2.0, distributed via `npx impeccable` with a self-update
  check piggybacked on `context.mjs` boot (throttled to daily, re-notify weekly, 1.2s
  fetch timeout, silent on failure).
- **`SKILL.md`'s `description` frontmatter is a 90-word keyword-stuffed trigger list**
  (design, redesign, shape, critique, audit, polish, clarify, distill, harden, optimize,
  adapt, animate, colorize, extract... websites, landing pages, dashboards, product UI,
  app shells, components, forms, settings, onboarding, empty states...). Whatever we
  think of it aesthetically, it is a deliberate discoverability tactic for skill routing
  and it ends with a negative clause: "Not for backend-only or non-UI tasks."
- **`allowed-tools` is scoped to two Bash patterns** — `Bash(npx impeccable *)` and
  `Bash(node .claude/skills/impeccable/scripts/*)`. Tight.
- **Detector engine coverage matrix** (`registry/antipatterns.mjs:414-419`): regex →
  source, page-analyzer · static-html → element, page · browser → element, page, layout ·
  visual → visual-contrast.
- **Provider-gated rules** exist: four rules behind `--gpt` (hairline-border-plus-wide-
  shadow, repeating-gradient stripes, two-axis grid-line backgrounds, "theater" framing
  copy) and one behind `--gemini` (image hover transform). They are model-specific
  fingerprints, off by default. Notable as an idea: *different generators have different
  tells.*
- **Ignore mechanism** is three-tier: config (`detector.ignoreRules` / `ignoreFiles` /
  `ignoreValues`, shared or `.local`), plus inline comment markers
  (`impeccable-disable <rule>`, `impeccable-disable-line`, `impeccable-disable-next-line`)
  reserved for "a waiver that must travel with a single file that leaves the repo."
- **`critique` mandates two isolated sub-agents** and forbids inline execution when a
  Task tool exists: "Running them inline in this context is 'possible' but is NOT
  permitted; it is a degraded run." Rationale given: "Assessment A must finish before
  detector findings enter the parent synthesis context. Detector output is deterministic,
  but it still anchors judgment." Good reasoning about ordering bias — relevant to how we
  sequence `surface-designer` output against Gate A review.
