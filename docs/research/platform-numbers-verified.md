# Verified platform numbers — targets, type, contrast

**Date:** 2026-08-01
**Method:** rendered DOM text pulled with a headless browser from the primary source itself,
then read in context. **Not** WebFetch summaries — the earlier research run caught
summarizers returning fabricated normative wording twice, so every number here was read off
the live page.

`curl` is useless for these: Apple HIG and m3.material.io are JS-rendered and return a
~160-character shell to a plain fetch.

---

## The correction that matters most

**"Apple's minimum touch target is 44×44 pt" is wrong**, and it is repeated nearly
everywhere including in most design skills.

Apple's own Accessibility page (change log: *June 9, 2025*) publishes **two** numbers per
platform, and 44 is the *default*, not the minimum:

| Platform | Default control size | **Minimum** control size |
|---|---|---|
| iOS, iPadOS | 44×44 pt | **28×28 pt** |
| macOS | 28×28 pt | **20×20 pt** |
| tvOS | 66×66 pt | **56×56 pt** |
| visionOS | 60×60 pt | **28×28 pt** |
| watchOS | 44×44 pt | **28×28 pt** |

> Offer sufficiently sized controls. Controls that are too small are hard for many people to
> interact with and select. Strive to meet the recommended minimum control size for each
> platform.

Why this matters for us: a rule that says "44pt minimum on iOS" will be *cited as Apple's
requirement* and it is not. Ship the pair — default and floor — or the plugin is confidently
wrong in a way that is trivially checkable.

## The four target numbers are four different things

| Standard | Number | Applies to |
|---|---|---|
| **WCAG 2.5.8** (AA) | 24×24 CSS px effective area | web, satisfiable by size **or** the geometric spacing exception |
| **Apple iOS/iPadOS** | 44×44 pt default, 28×28 pt floor | native iOS controls |
| **Material** | **48×48 dp** | touch targets |
| **Material** | **44×44 dp** | *pointer* targets — a separate, smaller spec |

Material states the touch and pointer numbers separately:

> For most platforms, consider making touch targets at least 48 x 48dp.

> Consider making pointer targets minimums 44 x 44dp.

Material also anchors the touch number in physical space rather than pixels — *"The
recommended target size for touchscreen elements is 7-10mm"* — and notes iOS's 44 itself.

**The decision procedure this produces:** a cross-platform-neutral design takes **48dp /
44pt**, which clears every floor above. A platform-committed design may go to its own
default. Nothing goes to a platform *minimum* without a stated reason, because the minimum
is a floor for constrained cases, not a target.

### Spacing is a separate obligation from size

Material: **8dp** between targets.

> In most cases, targets separated by 8dp of space or more promote balanced information
> density and usability.

Apple, more specifically, and this is a rule almost nobody encodes:

> In general, it works well to add about **12 points** of padding around elements that
> include a bezel. For elements **without** a bezel, about **24 points** of padding works
> well around the element's visible edges.

A bezel-less control needs *double* the padding of a bezelled one. That is a checkable rule
and it belongs in the density section.

Material also names the trap that makes small targets look compliant:

> an icon may appear to be 24 x 24dp, but the padding surrounding it comprises the full
> 48 x 48dp touch target

So the **icon size and the target size are independent decisions.** A 24dp icon in a 48dp
target is correct; a 24dp icon that *is* the target is a failure.

---

## Apple type sizes — default and minimum, per platform

| Platform | Default | Minimum |
|---|---|---|
| iOS, iPadOS | 17 pt | 11 pt |
| macOS | 13 pt | 10 pt |
| tvOS | 29 pt | 23 pt |
| visionOS | 17 pt | 12 pt |
| watchOS | 16 pt | 12 pt |

> Use recommended defaults for custom type sizes. Each platform has different default and
> minimum sizes for system-defined type styles to promote readability.

And the scaling obligation, which is the one that actually breaks layouts:

> Ideally, give people the option to enlarge text by at least **200 percent** (or **140
> percent** in watchOS apps).

A layout that cannot survive 200% text is not an accessibility bug found in QA — it is a
layout decision made at design time. This is exactly the audit's "accessibility is a
verification concern" failure, and it belongs in Loop 1.

## Apple's contrast table — and that it names APCA

Apple cites **both** WCAG and APCA, then states what its own tooling enforces:

> Two popular standards of measure for color contrast are the Web Content Accessibility
> Guidelines (WCAG) and the Accessible Perceptual Contrast Algorithm (APCA). Accessibility
> Inspector uses the following values from WCAG Level AA.

| Text size | Weight | Minimum ratio |
|---|---|---|
| Up to 17 pt | all | 4.5:1 |
| 18 pt | all | 3:1 |
| any | bold | 3:1 |

Note the boundary is **17 pt**, not the web's 18px/14pt-bold convention. A design system
that carries one contrast rule across web and iOS is using the wrong breakpoint on one of
them.

## Reduce Motion — Apple names the techniques, not just the setting

Most guidance says "respect `prefers-reduced-motion`." Apple says what to actually do, and
these are design instructions:

> - Tightening animation springs to reduce bounce effects
> - Tracking animations directly with people's gestures
> - Avoiding animating depth changes in z-axis layers
> - Replacing transitions in x-, y-, and z-axes with fades to avoid motion
> - Avoiding animating into and out of blurs

This is the "designed reduced-motion state" that `§12` demands, spelled out. The last two are
the ones that get missed — a z-axis or blur transition is exactly what a motion-sensitive
person cannot tolerate, and both are fashionable right now.

## Other design-time obligations found on the page

- **Gesture alternatives are mandatory, not optional.** "If you use a swipe gesture to
  dismiss a view, also make a button available." A swipe-only interaction is a design defect.
  This is the native analogue of WCAG 2.5.7 Dragging Movements.
- **Time-boxed UI.** "Views and controls that auto-dismiss on a timer can be problematic…
  Prefer dismissing views with an explicit action."
- **Assistive Access** (iOS/iPadOS) is a distinct layout mode a designer must plan for:
  identify core functionality, one interaction per screen, confirm twice on
  hard-to-recover actions.
- **Accessibility Nutrition Labels** now exist on the App Store — accessibility support is
  publicly declared, which changes it from an internal quality bar to a marketing surface.

---

## What goes where

| Finding | File |
|---|---|
| Default-vs-minimum target tables, all platforms | `SURFACES.md` |
| The four-standards target table + cross-platform 48dp/44pt rule | `SURFACES.md`, as the decision procedure |
| Bezel 12pt / bezel-less 24pt padding | `STYLES.md` style-under-density |
| Icon size ≠ target size | new icons section |
| Type default/minimum tables + the 200% rule | `SURFACES.md` + `ACCESS.md` |
| Apple's 17pt contrast boundary vs web's | `ACCESS.md` — flag the cross-platform mismatch |
| The five Reduce Motion techniques | `CRAFT.md` motion, as the designed reduced-motion spec |
| Gesture alternatives, time-boxed UI | `ACCESS.md`, Loop 1 decisions |

## Still unverified

Everything in `_mobile-raw-claims.md` and `_weba11y-raw-claims.md` that is not restated
above. Those files are extraction output from research runs that died before their
adversarial verification pass. Liquid Glass, Material 3 Expressive, predictive back,
edge-to-edge, window size classes, and the whole ARIA/focus/live-region set still need the
same treatment this page got.
