# Verified — tablet and desktop as their own disciplines

**Date:** 2026-07-28
**Method:** rendered DOM read off the live primary sources with a headless browser. Every
number and every absence below was checked on the page, not recalled.

This topic was a **total blank** in all three parent repos — "tablet" appeared twice, both
times as a number in a screenshot checklist.

---

## The finding that invalidates most existing guidance

**Split View, Slide Over, and Stage Manager no longer exist in Apple's design guidance.**

Searched the current Multitasking page for each term:

| Term | Occurrences |
|---|---|
| Split View | **0** |
| Slide Over | **0** |
| Stage Manager | **0** |
| windowed | 4 |
| tiling | 1 |

Change log on that page: **June 9, 2025 — "Reorganized guidance in platform considerations,
and added guidance for multitasking with multiple windows in iPadOS."**

What replaced them, in Apple's words:

> People can use iPad with either full-screen or windowed apps. When full screen, apps occupy
> the full screen, and people can switch between individual app windows using the app
> switcher… with behavior **similar to macOS**. The system provides window controls for
> common tiling configurations, entering full screen, minimizing, and closing windows.

**iPad multitasking is now a macOS-shaped windowing model.** Any guidance teaching the
three-mode Split View / Slide Over / Stage Manager vocabulary is teaching a superseded
system. I would have written those three from memory without hesitating — this is the
clearest justification in the whole project for researching rather than recalling.

### The design rule that follows, stated by Apple

> **Apps don't control multitasking configurations or receive any indication of the ones that
> people choose.**

You cannot detect the mode and you cannot request one. So a tablet design is not "a layout
for a tablet" — it is a layout that must be correct at **any width the user drags it to**,
with no notification that it changed.

And the resize rule, which is the opposite of the mobile-first reflex:

> As someone resizes a window, **defer switching to a compact view for as long as possible.
> Design for a full-screen view first**, and only switch to a compact view when a version of
> the content no longer fits.

---

## Material: five breakpoints, not three

Most references cite compact / medium / expanded. There are five.

| Breakpoint | Width | Common devices |
|---|---|---|
| **Compact** | under 600dp | phone in portrait |
| **Medium** | 600–839dp | tablet in portrait, foldable in portrait (unfolded) |
| **Expanded** | 840–1199dp | phone in landscape, foldable in landscape (unfolded), desktop |
| **Large** | 1200–1599dp | desktop |
| **Extra-large** | 1600dp+ | desktop, ultra-wide monitors |

Note two things a naive reading misses: a **phone in landscape is Expanded**, the same class
as a desktop; and **medium is a tablet in portrait**, not a tablet generally.

### Panes per breakpoint — the actual layout decision

| Breakpoint | Panes |
|---|---|
| Compact | 1 |
| Medium | 1 (recommended) or 2 |
| Expanded | 1 or **2 (recommended)** |
| Large | 1 or **2 (recommended)** |
| Extra-large | **3** |

Material names the failure directly:

> **Additional space doesn't just mean making the same thing bigger.**

That is the stretched-phone-layout failure, stated by the primary source. The escape is
stated too — extra width **reveals** rather than **stretches**: a collapsed navigation rail
expands, and a second pane appears showing what was previously a separate screen (a
messaging list gains the conversation beside it).

### Height breakpoints exist and usually don't matter

Compact/medium/expanded also exist for height, but Material says it plainly: *"since most
layouts contain vertically scrolling content, it's rare that layouts need to adjust."* Worth
one line in the plugin, not a system.

---

## Apple size classes

A coarser system than Material's: each dimension is **regular** or **compact**, where regular
means a larger screen or a screen in landscape. Every current iPad model is
**regular-width, regular-height in both orientations**, which is why size classes alone are
insufficient for iPad layout now that windows resize freely — the size class does not change
as the user drags the window narrower.

**Consequence:** on iPadOS, design against *available width*, not against the size class.

---

## macOS windows — three states, and they are visual

> A macOS window can have one of three states: **Main** … **Key** … **Inactive**.

The key window is the one receiving keyboard input, and it *"uses color in the title bar
options for closing, minimizing, and zooming; inactive windows and main windows that aren't
key use gray."* A window becomes key only when someone clicks its title bar or a component
requiring keyboard input.

Design obligations that have no web equivalent:

- **Three window states to design, not one.** A web page has no concept of being visible but
  not focused, with a different chrome treatment.
- **Window controls sit at the leading edge of the toolbar** — *"Make sure window controls
  don't overlap toolbar items."* A custom title bar that ignores this collides with the
  system.
- **Avoid putting critical information or actions** where window chrome may cover it.
- Custom windows must use system-defined appearances, or the state transitions must be
  hand-implemented: *"appearances update automatically… if you use custom implementations,
  you need to do this work yourself."*
- Primary vs auxiliary windows are distinct types with distinct rules.

## tvOS safe area, since it is a hard number

> Inset primary content **60 points** from the top and bottom of the screen, and **80 points**
> from the sides.

Out of our four-surface scope, but it is the only overscan number in the corpus and costs one
line to carry.

---

## What this changes in the plugin

1. **Tablet is not a breakpoint, it is a resize contract.** The surface-class fork needs a
   third question for tablet/desktop: *what is the narrowest and widest this can be dragged
   to, and is every width between them correct?* There is no notification and no control.
2. **`SURFACES.md` carries both breakpoint systems** — Material's five with dp values, and
   Apple's regular/compact with the warning that it does not change on iPad resize.
3. **The reveal-vs-stretch rule** goes in `STYLES.md` beside style-under-density. Extra width
   reveals a pane or expands a rail; it does not widen a column.
4. **Desktop gets window states** — main, key, inactive — as a required state set for
   desktop-shaped surfaces, the same way tool-shaped surfaces get the nine data states.
5. **Delete any Split View / Slide Over / Stage Manager language** before it is ever written.

## Not yet covered here

Windows/Fluent conventions, Electron and Tauri specifics, keyboard shortcut divergence
between macOS and Windows, and Android's large-screen quality guidelines. Those remain open.
