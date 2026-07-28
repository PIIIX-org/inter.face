# Gap audit — the three parents against "any interface"

**Date:** 2026-07-28
**Scope tested:** web, mobile, tablet, desktop
**Corpus:** `portfolio.me`, `webcrab`, `systemcicy` — all `.md` outside `runs/`, ~5,000 lines

Method: word-boundary grep, case-sensitive on acronyms, then every hit read in context to
separate real guidance from incidental mention. Counts below are verified-in-context, not
raw grep — the raw counts were inflated by `iOS` matching "portfol**ios**", `Material`
matching "surface and **material**", and `graph` matching "typo**graph**y".

---

## The headline

Three findings, in order of how much they should change the build.

### 1. Accessibility is a verification concern, never a design concern

This is the most important thing in this audit, and it is not "a11y is thin."

Across roughly 5,000 lines: **zero** mentions of ARIA, **zero** of focus management,
**zero** of live regions, **zero** of accessible names. WCAG appears three times, all in
webcrab, none normative.

What *does* exist is entirely on the verification side. Every screen-reader mention is a
check performed after the site is built:

> `portfolio.me/loops/08-verify.md:42` — "**Assistive technology.** A real screen reader
> — VoiceOver, NVDA — *if available*."

> `systemcicy/loops/06-harden.md:132` — "A screen reader on the top three flows at least
> once."

And `§12`, which portfolio.me marks **[HARD]** — "cannot be skipped, waived, or traded
away, because they are about integrity rather than quality" — is this in full:

> Semantic HTML. Keyboard-reachable everything, visible focus. Descriptive alt text on
> every image. Body contrast ≥ 4.5:1. Every animation ships a designed
> `prefers-reduced-motion` state. Every WebGL surface ships a no-WebGL fallback.

That is a good 2015 bar. It contains nothing that is *designed* — only things that are
*checked*. Which is exactly why ARIA, focus order on route change, live regions for async
results, accessible names on custom controls, and error identification are all at zero:
those are design decisions made at concept time, and the pipeline has no concept-time
accessibility step at all.

The structural consequence: `§12` is hard, but its enforcement lives in Loop 8. By the
time it fails, the thing is built. A hard rule audited only after the build is a hard rule
in name.

Also entirely absent, and all of it design-time: WCAG 2.2's added criteria — target size
(2.5.8), dragging alternatives (2.5.7), focus not obscured (2.4.11/2.4.12), consistent
help (3.2.6), redundant entry (3.3.7).

**Consequence for inter.face:** accessibility cannot be a principle plus a Loop 8
checklist. It has to appear in Loop 1, at concept time, or it will keep being an audit.

### 2. Native is not thin — it is absent

| Term | Verified hits | What they actually are |
|---|---|---|
| `iOS` / `SwiftUI` / `HIG` / `UIKit` | **2** | one is a *style warning* ("2010 iOS pastiche"); one is a *browser* note ("iOS Safari misses more") |
| `safe area` / `notch` / `dynamic island` / `home indicator` | **0** | — |
| `touch target` / `tap target` | **2** | systemcicy only, both in a field-use paragraph |
| `Android` / `Material Design` / `Jetpack` | ~3 real | mostly "a five-year-old Android" as a performance floor |
| `gesture` / `swipe` / `pinch` | 7 | web scroll-interaction, not platform gesture systems |

Neither iOS nor Android design guidance exists anywhere in the family. Not thin, not
dated — zero. `CRAFT.md`'s arsenal is WebGL, CSS, SVG, and View Transitions end to end.

### 3. Tablet is a viewport width, not a design target

Both hits are the same thing — a number in a screenshot checklist:

> `portfolio.me/PRINCIPLES.md:133` — "Screenshot the rendered site at mobile, tablet, and
> desktop and look at it."

> `portfolio.me/CRAFT.md:312` — "screenshot at mobile, tablet, desktop per `§14`"

Nothing about split view, multitasking, hybrid pointer-and-touch, external keyboard, or
why a stretched phone layout fails on a tablet. Tablet is a breakpoint here, not a
surface.

---

## The rest, ranked

| Gap | Verified hits | Status |
|---|---|---|
| **Icons** | 7, all incidental | One cliché warning, one RTL-mirroring note, two favicon lines. No icon system guidance: stroke weight, optical sizing, grid, set-vs-bespoke, semantic vs decorative |
| **Desktop app** (Electron/Tauri, window management, menu bar) | **0** | Absent. "Desktop" always means a browser width |
| **i18n past RTL** (text expansion, CJK line breaking, pluralization) | **0** | `§17` covers script, direction, and not mangling names — genuinely good. Nothing on German expansion, CJK breaking, or plural rules |
| **Component interaction states** | 3 | systemcicy §12 has one line: "every component with all its states — default, hover, focus-visible, active, disabled, error, loading." Named once, never specified |
| **Onboarding / first-run** | 4 | systemcicy's empty state teaches the first action. No onboarding, progressive disclosure, or first-session design |
| **Design tokens as output** | 14 | Discussed as a build-time concern. Never an output artifact. `DIRECTION.md` is prose — nothing machine-consumable crosses the handoff |

---

## What is genuinely strong — do not rewrite these

The audit is not one-sided. Several parts of the parents beat anything in the competing
skills I have seen, and the merge must preserve them intact.

- **Information design** (`portfolio.me/CRAFT.md:107`). Not chart styling — which visual
  channel carries the value, decided before rendering. Cites Cleveland & McGill's measured
  numbers (position judgments 1.4–2.5× more accurate than length, 1.96× more than angle,
  5.3–7.3× fewer catastrophic misreads), ColorBrewer's construction grammar, and a hard
  no-rainbow rule with the reason (a bright mid-band reads as a false peak). This is
  research-grounded, not taste.
- **The nine data states** (`systemcicy/INTERFACE.md:78`). Empty, loading, partial, error,
  permission-denied, offline, stale, conflict, bulk — each with its failure named. The
  conflict row ("silently overwriting somebody's work") is the kind of thing that only
  comes from having shipped one.
- **The category-cliché fence** (`webcrab/STYLES.md:122`). Nine categories × cliché ×
  why-it-persists × the opening. Makes "be original" checkable.
- **Prototype-before-you-design-around-it** with a measured frame rate. Nothing else in
  the landscape does this.
- **The two-tier performance budget.** Shell under 100KB painting alone; heavy layer
  deferred and declared at a gate.
- **Density as a feature** (`systemcicy/INTERFACE.md:41`) and keyboard completeness (§57).

---

## What this changes in the spec

1. **Accessibility moves to Loop 1.** A concept-time accessibility pass, not a
   verification checklist. This is a structural change, not an added file.
2. **`CRAFT.md` splits by surface family.** A single web arsenal cannot carry native. Web,
   mobile, tablet, and desktop each need their own technique set, which forces the
   progressive-disclosure architecture rather than merely suggesting it.
3. **Tablet gets promoted from breakpoint to surface class.** The page/tool fork in the
   current spec is necessary but insufficient — a tool on a tablet is not a tool on a
   desktop.
4. **Two new reference files with no parent material at all:** icons, and i18n beyond
   RTL. These get researched from scratch.
5. **`DIRECTION.md` gains a machine-readable sibling** — a tokens file. Prose does not
   survive a handoff to a build agent.

## Research questions this audit produces

Sharpened from the audit rather than guessed, for the deep-research phase:

1. iOS and Android design systems as of 2026 — current, not remembered.
2. Tablet and large-screen design as a discipline of its own.
3. Desktop application design outside the browser.
4. Design-time accessibility: ARIA authoring practices, focus management, live regions,
   WCAG 2.2 additions, and the legal drivers (EAA, ADA, Section 508).
5. Icon system design.
6. i18n beyond direction: expansion, breaking, plurals, formats.
7. Design tokens as an interchange format (W3C DTCG).
8. Regulated-industry design constraints.
9. Rule-breaking: when a convention should be violated deliberately, and at what cost.
