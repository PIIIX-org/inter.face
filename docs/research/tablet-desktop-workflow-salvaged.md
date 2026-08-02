# Research — tablet + desktop, salvaged from a broken synthesis

**Date:** 2026-08-01
**Method:** deep-research harness, resumed three times. Final run: 107/107 agents, 0 hard
errors — but its **synthesis step returned a broken placeholder**, not real output.

---

## The bug, stated plainly

The final resume's result object was:

```json
"summary": "test",
"findings": [{"claim": "test claim", "confidence": "high",
              "sources": ["https://example.com"], "evidence": "test evidence"}]
```

That is not degraded content — it is a literal test stub that happened to satisfy the
output schema (every required field present, plausible-looking types) and so passed
validation without erroring. `agents_error: 0` because the harness never saw a failure;
it saw a well-formed object.

**This is worse than an error, because it doesn't announce itself as broken.** If I had
taken the notification at face value and written `DIRECTION.md` guidance sourced to
`example.com`, that would have shipped silently. The only reason it didn't is that every
research doc in this project gets read against its actual JSON before being written up —
the same discipline that already caught three fabricated quotes elsewhere in this session.

**What survived, because they are pass-through fields the synthesis LLM never touches:**
the `refuted` array (4 real claims, real votes, real URLs) and the `sources` bibliography
(21 real primary-source URLs with per-source claim counts). Those are written below.

**What did not survive in this run's output, but is real and recoverable:** the confirmed
claims. This run's *second* resume (before the synthesis bug) returned them directly in a
partial notification, which I read and still have. They are reproduced below, sourced the
same way every other doc in this project sources a claim.

---

## Confirmed claims, recovered from the pre-synthesis verification pass

### iPadOS multitasking is a first-class appearance state, on par with Dark Mode

> "Adapt seamlessly to appearance changes — like device orientation, multitasking modes,
> Dark Mode, and Dynamic Type — and transition effortlessly to running in macOS, letting
> people choose the configurations that work best for them."

Source: `developer.apple.com/design/human-interface-guidelines/platforms/designing-for-ipados/`

An iPad app does not get to treat multitasking as an edge case checked once at the end.
It sits in the same category as orientation and dark mode — a first-class state the
design has to hold from the start.

### Hybrid input is the documented default, not an edge case

> "People can interact with iPad using Multi-Touch gestures and virtual keyboards, an
> attached keyboard or pointing device, Apple Pencil, or voice, and they often combine
> multiple input modes."

Same source. Confirms and sharpens the finding already in `tablet-desktop-verified.md` —
Apple states this as the *fundamental* device characteristic of iPadOS, not a
compatibility footnote.

### Large-display guidance: minimize modals and full-screen transitions

> "Take advantage of the large display to elevate the content people care about,
> minimizing modal interfaces and full-screen transitions, and positioning onscreen
> controls where they're easy to reach, but not in the way."

Same source. This is the opposite instinct from phone design, where a full-screen push is
the default pattern for anything secondary. On a large display, that reflex is named as
the thing to avoid.

### Windows resize continuously, macOS-style — confirming the Split View/Slide Over/Stage Manager absence

> "People can freely resize windows down to a minimum width and height, similar to window
> behavior in macOS. It's important to account for this resizing behavior and the full
> range of possible window sizes when designing your layout."

Source: `developer.apple.com/design/human-interface-guidelines/layout`

This independently confirms the finding already written up in `tablet-desktop-verified.md`
from the manual browser pass — Split View, Slide Over, and Stage Manager as named modes are
gone from current guidance, replaced by continuous free resize. Two separate methods, same
conclusion.

### The collapse order: defer compact, hide tertiary columns first

> "As someone resizes a window, defer switching to a compact view for as long as possible.
> Design for a full-screen view first, and only switch to a compact view when a version of
> the full layout no longer fits... For more complex layouts such as [split views], prefer
> hiding tertiary columns such as inspectors as the view narrows."

Same source. Adds a specific detail the manual pass didn't reach: when a multi-column
layout has to shed a column under narrowing, the *tertiary* column (an inspector, not the
primary or secondary content) goes first.

### Size classes are binary, and iPad never varies on them

> "A size class is a value that's either regular or compact, where regular refers to a
> larger screen or a screen in landscape orientation and compact refers to a smaller
> screen or a screen in portrait orientation."

Same source, cross-checked against the device table: every current iPad model —
Pro 12.9", Pro 11", Pro 10.5", Air 13", Air 11", 11", 9.7", mini 7.9" — is **regular
width, regular height in both orientations.** iPhones vary by orientation; iPads do not.
This is the primary-source confirmation for the earlier finding that on iPadOS you design
against *available width*, not against size class, because the size class never changes as
a window resizes.

---

## Refuted — plausible claims the panel checked and could not support

Do not reuse these even though each sounds like something Apple would say.

- **"Apple explicitly directs designers to support combined-input interactions rather than
  designing for one input mode at a time."** Voted 0-3. The primary source states hybrid
  input is common, not that supporting simultaneous combination is a mandate.
- **"The pointing device is additive rather than substitutive — it does not replace touch —
  and an app must deliver an equivalent experience across gestures, pointer, and
  keyboard."** Voted 1-2, contested. `pointing-devices` HIG page doesn't state this as
  cleanly as the claim implies.
- **"Apple names the specific set of non-full-screen configurations an app must be tested
  in: full screen, Split View, Slide Over, Picture in Picture, and dynamic resizing under
  Stage Manager."** Voted 0-3. Checked against Apple's own `building-a-desktop-class-ipad-app`
  doc — even that page does not name Split View or Slide Over. Consistent with the
  earlier finding that this vocabulary is gone from current guidance, not just the
  Multitasking page.
- **"Designers should NOT build custom keyboard navigation for standard controls — Full
  Keyboard Access is the designated mechanism."** Voted 0-3. Not supported as stated; the
  real guidance is more scoped than this claim represents.

---

## Sources actually fetched (real, from this run)

Apple: `designing-for-ipados`, `layout`, `split-views`, `pointing-devices`,
`building-a-desktop-class-ipad-app`, `keyboards`, `the-menu-bar`, `windows`,
`designing-for-macos`, `drag-and-drop`

Google: `developer.android.com/develop/adaptive-apps/guides/use-window-size-classes`,
`m3.material.io/foundations/layout/applying-layout/window-size-classes`,
`developer.android.com/docs/quality-guidelines/adaptive-app-quality`,
`m3.material.io/components/navigation-rail/guidelines`,
`developer.android.com/develop/ui/views/layout/canonical-layouts`

Microsoft: `learn.microsoft.com` keyboard-accelerators, titlebar-design,
apply-snap-layout-menu, commanding-basics

Electron: `electronjs.org` custom-title-bar, api/menu

One source came back marked `"quality":"unreliable","claimCount":0` —
`m3.material.io/foundations/layout/canonical-layouts/overview` — so Material's canonical
layouts (list-detail, supporting pane, feed) named in the original research question were
**not actually verified** from that page. Still open.

---

## What is still genuinely open after four attempts at this topic

- Material's canonical layouts (list-detail, supporting pane, feed) — the source that
  should confirm these came back unreliable
- Windows/Fluent keyboard-shortcut divergence from macOS, in detail (sources were fetched,
  content not yet synthesized)
- Electron/Tauri's "website in a window" failure and the native-feel checklist (sources
  fetched, content not yet synthesized)
- Everything under desktop menu-bar and window-management specifics beyond what's quoted
  above

## Process note for future runs

If a `deep-research` synthesis result contains implausibly generic content (`"test"`,
round numbers, `example.com`), treat it as a harness bug and go straight to the journal
rather than trusting the top-level summary. This is now the second and third distinct
failure mode observed in this project, after the session-boundary process death and the
transient org-access outage — none of the three were survivable by trusting the tool's own
completion notification without inspecting the underlying data.
