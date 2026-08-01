# Verified — native mobile design law

**Date:** 2026-08-01
**Method:** rendered DOM read off the live primary sources with a headless browser.

---

## First: a third fabrication, and what it means for the cached claims

The dead mobile research run extracted a claim attributing this to Apple's Materials page:

> "When placing elements on top of Liquid Glass, avoid applying the material to both layers.
> Instead, use fills, transparency, and vibrancy for the top elements to make them feel like a
> thin overlay that is part of the material."

and defined Liquid Glass as *"a translucent surface that reflects and refracts light."*

Checked against the live page (17,870 characters of rendered text):

| Phrase | Occurrences |
|---|---|
| "both layers" | **0** |
| "on top of Liquid Glass" | **0** |
| "thin overlay" | **0** |
| "reflects and refracts" | **0** |
| "vibrancy" | 24 |

The page genuinely discusses vibrancy, so the claim is *plausible* and may paraphrase real
guidance elsewhere in Apple's docs. But **the quoted wording does not exist on the page it was
attributed to.** That is the third instance of this failure — the completed WCAG run caught two
others and warned that "every quotation in the final deliverable must be re-derived from raw
W3C HTML."

**Standing rule for this project:** no quotation ships in the plugin unless it was read off the
rendered primary source. The 353 claims in `_mobile-raw-claims.md` and `_weba11y-raw-claims.md`
are leads, not evidence.

---

## Liquid Glass — verified

Apple platforms have **two** material types: Liquid Glass, and standard materials.

> Liquid Glass forms a distinct functional layer for controls and navigation — like tab bars and
> sidebars — that floats above the content layer, establishing a clear visual hierarchy between
> functional elements and content.

### The hard rules, in Apple's words

> **Don't use Liquid Glass in the content layer.** Liquid Glass works best when it provides a
> clear distinction between the functional layer and the content layer.

> **Use Liquid Glass effects sparingly.** Standard components… pick up the appearance and
> behavior of this material automatically. If you apply Liquid Glass effects to a custom
> control, do so sparingly. Liquid Glass seeks to bring attention to the underlying content, and
> overusing this material can distract from important functional elements.

So it is a **navigation-and-controls material only**, applied automatically by standard
components, and deliberately used sparingly on custom ones. A design that renders content cards
in Liquid Glass is violating the primary rule of the material.

### Two variants, and the choice between them is a decision procedure

| Variant | What it does | When |
|---|---|---|
| **Regular** | "blurs and adjusts the luminosity of background content to maintain legibility of text and other foreground elements" | when background content **might create legibility issues**, or when components carry significant text — *alerts, sidebars, popovers* |
| **Clear** | lets rich content through for immersion | **only** for components over **visually rich backgrounds** — photos, video |

> **Only use clear Liquid Glass for components that appear over visually rich backgrounds.**

And clear carries a follow-on decision:

> For optimal contrast and legibility, determine whether to add a **dimming layer** behind
> components with clear Liquid Glass: if the underlying content is bright, consider [adding
> one]… you don't need to apply a dimming layer [otherwise].

**Scroll edge effects** are named as a separate legibility mechanism — "blurring and reducing
the opacity of background content."

### It is not static

> [Liquid Glass responds] to certain system settings, like if people choose a preferred look for
> Liquid Glass in their device's settings, or turn on accessibility settings that **reduce
> transparency** or **increase contrast**.

A design that assumes the glass look is fixed will break under Reduce Transparency and Increase
Contrast. Both are design-time states to art-direct, not runtime accidents — the same rule
`§12` applies to reduced motion.

---

## Material 3 Expressive — verified

**It is not a new version and M3 is not deprecated.** Google states this directly:

> to be clear — M3 Expressive isn't a new version of the system. We're not deprecating M3.

It is "an evolution… a set of new features, updated components, and design tactics."

### The research basis, which is unusually strong for design guidance

> M3 Expressive is our most researched update to the design system since its launch in 2014.
> Extensive user research — **46 studies with more than 18,000 participants**.

Stated takeaways:

- Expressive designs are **preferred by people of all ages**
- They score higher on user attention
- **"participants spotting key UI elements up to four times faster in expressive screens"**

That last one is the load-bearing number, and it is the rare case where an *expressive* choice
is defended on usability grounds rather than taste. It belongs in `STYLES.md` as a counterweight
to the reflex that restraint is always safer.

---

## VoiceOver as a design decision — verified

The VoiceOver page is **new as of March 7, 2025** (split out of the main accessibility page).
Its content is design-time, not code-time:

> **Provide alternative labels for all key interface elements.** [Standard elements] have
> generic labels by default, but you should provide more descriptive labels that convey your
> app's functionality. Add labels to any custom elements your app defines.

The genuinely design-shaped rule, and the one that has no web checklist equivalent:

> **Specify how elements are grouped, ordered, or linked.** Proximity, alignment, and other
> visible contextual cues help sighted people perceive the relationships between elements.

With Apple's own worked example: in an **ungrouped** layout "VoiceOver describes each image
before moving on to the captions"; in a **grouped** one it describes each image with its caption.

**This is the point.** Visual proximity silently encodes relationship for sighted users. That
relationship does not exist for VoiceOver unless someone *declares* it — and whoever decides
that images and captions belong together is the designer, at layout time, not a developer
patching later. Default reading order in US English is top-to-bottom, left-to-right.

**Rotor support** is the native analogue of heading/landmark navigation: identify headings and
key elements so people can jump by type rather than traverse linearly.

---

## What goes where

| Finding | File |
|---|---|
| Liquid Glass: functional layer only, never content layer | `SURFACES.md`, as a hard rule |
| Regular vs clear variant decision + the dimming-layer follow-on | `SURFACES.md` decision procedure |
| Reduce Transparency / Increase Contrast as designed states | `ACCESS.md` + `CRAFT.md` three-states |
| M3 Expressive: not a new version; 46 studies / 18,000 participants; 4× faster element spotting | `STYLES.md` |
| VoiceOver grouping as a layout-time decision | `ACCESS.md`, Loop 1 |
| The fabrication finding | `PRINCIPLES.md` — sourcing rule for anything the plugin quotes |

## Still open on this topic

Navigation models per platform (tab bar vs bottom nav, predictive back), safe-area and
edge-to-edge specifics including the Android 15 change, gesture conflicts with author-built
swipe, and TalkBack. The cached claims cover these but none is verified.
