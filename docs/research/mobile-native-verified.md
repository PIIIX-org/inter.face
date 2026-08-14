# Verified — native mobile design law

**Date:** 2026-08-01
**Method:** rendered DOM read off the live primary sources with a headless browser.

Pages read:

| Source | URL | Read |
|---|---|---|
| Apple HIG — Materials | `https://developer.apple.com/design/human-interface-guidelines/materials` | 2026-08-01, 2026-08-14 |
| Apple HIG — VoiceOver | `https://developer.apple.com/design/human-interface-guidelines/voiceover` | 2026-08-01, 2026-08-14 |
| Material Design blog — Start building with Material 3 Expressive | `https://m3.material.io/blog/building-with-m3-expressive` | 2026-08-01, 2026-08-14 |
| Apple Technology Overviews — Adopting Liquid Glass | `https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass` | 2026-08-14 (fourth pass) |
| Apple SwiftUI docs — Applying Liquid Glass to custom views | `https://developer.apple.com/documentation/swiftui/applying-liquid-glass-to-custom-views` | 2026-08-14 (fourth pass) |

The Materials page carries a change log entry of **September 9, 2025** ("Updated guidance for
Liquid Glass"); the VoiceOver page carries **March 7, 2025** ("New page"). The M3 Expressive
post is dated **May 13, 2025**.

**Citation backfill, 2026-08-14 — and the backfill's own fabrication.** This file originally
shipped with no URLs, including for the fabrication finding below, which is the project's
flagship catch and had nothing an outsider could open. The backfill added the three URLs above
and wrote, in this paragraph: *"Every quote below was re-fetched from the three pages above on
that date and confirmed present before the URL was written here"* and *"Source-unrecovered:
none."* **That assertion was false.** A reviewer refetched the pages by two independent paths
and found two Apple quotes that do not match the page — one of them reversed in meaning. In the
file whose subject is a quote Apple never wrote, the backfill added two more of the same kind.
It is recorded here rather than quietly fixed, because a verification claim that was not
performed is the failure this document exists to catch.

**Correction pass, 2026-08-14 (second pass).** Every block quote in this file was refetched from
the rendered text of the three pages above (Firecrawl, JS-rendered, live fetch with `maxAge: 0`,
so no cached copy) and compared word by word against the page. Result:

- **2 quotes materially wrong** — both on the Materials page, both corrected below and both
  annotated in place with what the earlier text claimed.
- **6 quotes elided or spliced without marking** — meaning preserved in each, but below this
  file's own standard. All now carry ellipses, or are restored in full where the full sentence
  is short enough to be worth having. *(This is the second pass's count and it read 5 until the
  third pass counted the annotations it left: the dropped "elements", the dimming bullets, the
  system-settings sentence, both M3 quotes, and the VoiceOver labels quote. The third pass found
  four more of its own — see below.)*
- **1 unreproducible number dropped** — the `"vibrancy" | 24` occurrence count. See the table.
- The **four zeros** — the fabrication finding itself — reproduce exactly.

**Source-unrecovered: none** (every claim has an openable URL). **Verbatim fidelity: repaired on
this pass, not present before it.** Not verified on this pass: the change-log dates and the
`17,870 characters` figure below, both of which come from the 2026-08-01 headless-browser run;
the change-log dates were re-read today and still match, the character count was not
re-measured and is not reproducible across fetch paths.

**Third pass, 2026-08-14.** This file's claims *about itself* were checked against the file and
against the pages. Three were wrong. The tally above read **5** where six quotes are annotated
in place. "Both of these are quoted in full" was not true — the *Use Liquid Glass effects
sparingly* quote stopped a sentence short of where the page stops, and so did the first dimming
bullet and both VoiceOver quotes: **four more unmarked trailing cuts**, none caught by the pass
that declared the file repaired. And the visionOS vibrancy sentence claimed an enumeration that
section does not carry. Materials and VoiceOver were refetched for this (Firecrawl, JS-rendered,
`maxAge: 0`); every trailing sentence is restored and marked at its quote, with Apple's link
text carried in as plain words. Not re-checked on this pass: the M3 Expressive page, whose
quotes the second pass restored, and the four zeros, unchanged since the second pass re-ran
them. **The pattern is the finding.** Three passes, each declaring the file clean, each followed
by a pass that found more of the same defect. Trailing cuts survive review because the quote
still reads as a complete thought — which is exactly why the next reader should assume this file
has more of them rather than fewer.

**Fourth pass, 2026-08-14 — the fourth catch, and it is an unrecorded verification.** A pass
before this one replaced an unsourced hard rule in `SURFACES.md §4` with two new Apple block
quotes attributed to a page called **Adopting Liquid Glass**, and wrote in two places that three
Apple pages were *"read on 2026-08-14"*. **No file in this repo recorded any of it.** This
file's Pages read table listed three URLs, none of them that page, and the string "Adopting
Liquid Glass" appeared nowhere under `docs/` except inside those `SURFACES.md` parentheticals.
That is the same failure as the 2026-08-14 backfill above — a verification asserted, not
recorded — wearing a fourth hat, and it is written down here rather than quietly repaired.

*Method for this pass:* Adopting Liquid Glass and Applying Liquid Glass to custom views were
fetched live from Apple's rendered documentation data
(`https://developer.apple.com/tutorials/data/documentation/…json`, no cache), and every text and
code node was extracted end to end and searched — 26,172 and 7,545 characters of rendered text
respectively. Materials was re-read the same day through a second, independent path (Firecrawl,
JS-rendered, `maxAge: 0`) because the two phrases in question needed checking on it too. The
plain HTML of an HIG page is a 158-character JS shell and is not a usable source; this is
recorded so the next reader does not conclude from an empty `curl` that a phrase is absent.

*Result:* **both quotes are on the page, verbatim.** They are recorded below with their
context, and `SURFACES.md` now cites a page this repo can show. Three further findings:

- **A fifth unmarked trailing cut, same defect as the third pass.** `SURFACES.md` ended the
  custom-backgrounds quote at "let the system determine the background appearance" where the
  page continues ", especially for the following elements:" and then lists them. Marked there
  with a trailing ellipsis.
- **"highly translucent" is Apple's wording and is confirmed** — but on **Materials**, not on
  Adopting Liquid Glass, where it does not occur. See the Clear row below.
- **The fills/transparency/vibrancy prescription and the never-mix-variants rule are absent from
  all three pages**, which is what `SURFACES.md` says about them. Occurrence counts below.

*Not verified on this pass:* the M3 Expressive quotes (unchanged since the second pass) and the
VoiceOver quotes (unchanged since the third pass). The change-log dates were not re-read today.

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

Re-run against `https://developer.apple.com/design/human-interface-guidelines/materials` on
**2026-08-14**, reading the full rendered page text end to end: all four phrases still absent.
The finding reproduces.

*A fifth row, `"vibrancy" | 24`, was dropped on 2026-08-14. It is not reproducible: the count
depends on whether the fetch includes navigation chrome, API symbol names
(`UIVibrancyEffectStyle.label` and friends) and image alt text, independent fetches returned
different totals, and no stated method yields 24. What is checkable without a count is the
qualitative claim it was standing in for: the page does discuss vibrancy — the Standard
materials section names blur, vibrancy and blending modes together; the iOS/iPadOS section
enumerates vibrancy styles for labels, fills and separators; and the visionOS section enumerates
three, all of them label styles, while naming fills only in prose. An unreproducible number does
not belong beside four that reproduce. (Narrowed 2026-08-14, third pass: this sentence had both
sections enumerating "labels and fills"; only iOS/iPadOS does.)*

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

> Liquid Glass forms a distinct functional layer for controls and navigation elements — like tab
> bars and sidebars — that floats above the content layer, establishing a clear visual hierarchy
> between functional elements and content.

*Corrected 2026-08-14 (second pass): the earlier text read "for controls and navigation — like
tab bars", dropping Apple's word "elements" without marking it.*

### The hard rules, in Apple's words

Both of these are quoted in full, deliberately. Each was previously quoted in a shortened form
that changed what Apple said.

> **Don't use Liquid Glass in the content layer.** Liquid Glass works best when it provides a
> clear distinction between interactive elements and content, and including it in the content
> layer can result in unnecessary complexity and a confusing visual hierarchy. Instead, use
> standard materials for elements in the content layer, such as app backgrounds. An exception to
> this is for controls in the content layer with a transient interactive element like sliders
> and toggles; in these cases, the element takes on a Liquid Glass appearance to emphasize its
> interactivity when a person activates it.

*Corrected 2026-08-14 (second pass). The 2026-08-14 backfill printed this as "Liquid Glass works
best when it provides a clear distinction between the functional layer and the content layer" —
a sentence Apple does not write. Apple's distinction is between **interactive elements and
content**, not between two layers, the "unnecessary complexity and a confusing visual hierarchy"
clause was dropped, and the named **exception for transient content-layer controls** was dropped
with it. That exception is the part a design rule most needs.*

> **Use Liquid Glass effects sparingly.** Standard components from system frameworks pick up the
> appearance and behavior of this material automatically. If you apply Liquid Glass effects to a
> custom control, do so sparingly. Liquid Glass seeks to bring attention to the underlying
> content, and overusing this material in multiple custom controls can provide a subpar user
> experience by distracting from that content. Limit these effects to the most important
> functional elements in your app. For developer guidance, see Applying Liquid Glass to custom
> views.

*Corrected 2026-08-14 (second pass), and this one had been **inverted**. The backfill printed
"overusing this material can distract from important functional elements." Apple says overuse
distracts from the **content** — "can provide a subpar user experience by distracting from that
content" — which is the whole point of the material. The words "important functional elements"
were taken from the following sentence ("Limit these effects to the most important functional
elements in your app") and pasted in as the object of the wrong verb, with two clauses dropped
and no ellipsis, inside a block quote. Third pass, 2026-08-14: the closing sentence "For
developer guidance, see Applying Liquid Glass to custom views" was still missing, so this quote
was not yet the "in full" the heading above claimed. Restored, link text unlinked.*

So it is a **controls-and-navigation material**: applied automatically by standard system
components, used sparingly on custom ones, and kept out of the content layer *except* for
content-layer controls with a transient interactive element — sliders and toggles, which Apple
says do take on the appearance while a person is activating them. A design that renders content
cards in Liquid Glass is violating the rule. A slider that picks up glass on touch is following
it.

### Two variants, and the choice between them is a decision procedure

| Variant | What it does | When |
|---|---|---|
| **Regular** | "blurs and adjusts the luminosity of background content to maintain legibility of text and other foreground elements" | when background content **might create legibility issues**, or when components carry significant text — *alerts, sidebars, popovers* |
| **Clear** | "highly translucent, which is ideal for prioritizing the visibility of the underlying content and ensuring visually rich background elements remain prominent" | **only** for components over **visually rich backgrounds** — photos, video |

*Wording verified 2026-08-14 (fourth pass). The Clear cell previously carried the paraphrase
"lets rich content through for immersion" while `SURFACES.md` quoted `"highly translucent"` as
Apple's words with no verified row behind it — the phrase's only appearance under `docs/` was
`_mobile-raw-claims.md:17`, which this file classifies as a lead, not evidence. It is Apple's
wording: the Materials page reads "The clear variant is highly translucent, which is ideal for
prioritizing the visibility of the underlying content and ensuring visually rich background
elements remain prominent." Both cells now carry the page's words. The phrase does **not** occur
on Adopting Liquid Glass (0 occurrences), so Materials is the citation.*

> **Only use clear Liquid Glass for components that appear over visually rich backgrounds.**

And clear carries a follow-on decision:

> For optimal contrast and legibility, determine whether to add a dimming layer behind
> components with clear Liquid Glass:
>
> - If the underlying content is bright, consider adding a dark dimming layer of 35% opacity.
>   For developer guidance, see clear.
> - If the underlying content is sufficiently dark, or if you use standard media playback
>   controls from AVKit that provide their own dimming layer, you don't need to apply a dimming
>   layer.

*Restored in full 2026-08-14 (second pass). The earlier rendering compressed Apple's two bullets
into one line with bracketed substitutions and lost the **35% opacity** figure, which is the
only number in the rule. Third pass, same date: "in full" was still not literally true — the
first bullet ends "For developer guidance, see `clear`." on the page. Restored, link text
unlinked.*

**Scroll edge effects** are named as a separate legibility mechanism — "blurring and reducing
the opacity of background content."

### It is not static

> The appearance of these variants can differ in response to certain system settings, like if
> people choose a preferred look for Liquid Glass in their device's settings, or turn on
> accessibility settings that reduce transparency or increase contrast in the interface.

*Restored in full 2026-08-14 (second pass): the earlier rendering opened with a bracketed
paraphrase, "[Liquid Glass responds] to certain system settings", and cut "in the interface" off
the end without marking it. Note what the full sentence says and the paraphrase hid — it is the
appearance of **both variants**, regular and clear, that changes under these settings.*

A design that assumes the glass look is fixed will break under Reduce Transparency and Increase
Contrast. Both are design-time states to art-direct, not runtime accidents — the same rule
`§12` applies to reduced motion.

---

## Adopting Liquid Glass — verified (fourth pass, 2026-08-14)

`https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass`, read
2026-08-14 from Apple's rendered documentation data. Both quotes `SURFACES.md §4` attributes to
this page are present. Each is a bolded guideline lead followed by its paragraph, the same shape
as the Materials rules; the lead is included here because `SURFACES.md` quotes only the body.

> **Check for crowding or overlapping of controls.** Prefer to use standard spacing metrics
> instead of overriding them, and avoid overcrowding or layering Liquid Glass elements on top of
> each other.

That is the whole guideline — `SURFACES.md` quotes the second sentence complete, and nothing
follows it in the paragraph.

> **Reduce your use of custom backgrounds in controls and navigation elements.** Any custom
> backgrounds and appearances you use in these elements might overlay or interfere with Liquid
> Glass or other effects that the system provides, such as the scroll edge effect. Make sure to
> check any custom backgrounds in elements like split views, tab bars, and toolbars. Prefer to
> remove custom effects and let the system determine the background appearance, especially for
> the following elements:

The colon introduces a list of framework symbols, which is why the sentence ends open. This is
the fifth unmarked trailing cut of the release: `SURFACES.md` stopped at "background appearance"
and dropped ", especially for the following elements:". It now carries a trailing ellipsis.

What is **not** on this page, searched over its full rendered text:

| Phrase | Occurrences on Adopting Liquid Glass |
|---|---|
| "fills, transparency" | **0** |
| "vibrancy" | **0** |
| "highly translucent" | **0** |
| "thin overlay" | **0** |
| "reflects and refracts" | **0** |
| "mix" (as a variant rule) | **0** — the one hit is "don't mix text and icons" in toolbars |

`https://developer.apple.com/documentation/swiftui/applying-liquid-glass-to-custom-views`, read
the same day, is 7,545 characters and contains none of those phrases either — 0 for
"fills, transparency", "vibrancy", "thin overlay" and "highly translucent". So the
fills/transparency/vibrancy prescription and the "two variants are never mixed" rule are absent
from all three Liquid Glass pages, which is what `SURFACES.md` states about them. Neither is
disproved; a WWDC session may state either. None was opened.

---

## Material 3 Expressive — verified

**It is not a new version and M3 is not deprecated.** Google states this directly:

> And to be clear — M3 Expressive isn't a new version of the system. We're not deprecating M3,
> and this isn't "M4."

*Restored in full 2026-08-14 (second pass): the earlier rendering began mid-sentence at "to be
clear" and cut the trailing clause `, and this isn't "M4."` without marking either.*

It is "an evolution of the Material 3 design system… a set of new features, updated components,
and design tactics for creating emotionally impactful UX" — two sentences on the page, spliced
here with the ellipsis marking the join.

### The research basis, which is unusually strong for design guidance

> M3 Expressive is our most researched update to the design system since its launch in 2014.
> Extensive user research — 46 studies with more than 18,000 participants — has helped ensure
> that this evolution isn't just about aesthetics, but about truly enhancing your users'
> experience.

*Restored in full 2026-08-14 (second pass): the earlier rendering stopped at "18,000
participants" mid-sentence, with a full stop where the page has an em dash, and bolded a phrase
the page does not bold.* **46 studies, more than 18,000 participants** is the number worth
carrying.

Stated takeaways include three of the four the page lists — the omitted one is Google's third,
"Users are more likely to switch to products that use M3 Expressive components and techniques,"
which is a marketing claim, not design guidance:

- Expressive designs are **preferred by people of all ages**
- They "consistently score higher on user **attributes** like playfulness, energy, creativity,
  and friendliness" — *corrected 2026-08-14. An earlier revision of this file rendered this as
  "score higher on user attention," which is not what the page says; the page says attributes,
  and lists them. Caught during the citation backfill.*
- **"participants spotting key UI elements up to four times faster in expressive screens"**

That last one is the load-bearing number, and it is the rare case where an *expressive* choice
is defended on usability grounds rather than taste. It belongs in `STYLES.md` as a counterweight
to the reflex that restraint is always safer.

---

## VoiceOver as a design decision — verified

The VoiceOver page is **new as of March 7, 2025** (split out of the main accessibility page).
Its content is design-time, not code-time:

> **Provide alternative labels for all key interface elements.** VoiceOver uses alternative
> labels (which aren't visible onscreen) to audibly describe your app's interface.
> System-provided controls have generic labels by default, but you should provide more
> descriptive labels that convey your app's functionality. Add labels to any custom elements
> your app defines. Be sure to keep your descriptions up-to-date as your app's interface and
> content change. For developer guidance, see Accessibility modifiers.

*Marked 2026-08-14 (second pass): the earlier rendering silently dropped Apple's second sentence
and replaced "System-provided controls" with a bracketed "[Standard elements]"; the real phrase
is narrower and is now used. Restored in full on the third pass, same date — the second pass had
covered the drop with an ellipsis but had also cut two sentences off the end unmarked, so the
whole paragraph is printed here instead. The restored tail is guidance, not decoration:
descriptions go stale as the interface changes.*

The genuinely design-shaped rule, and the one that has no web checklist equivalent:

> **Specify how elements are grouped, ordered, or linked.** Proximity, alignment, and other
> visible contextual cues help sighted people perceive the relationships between elements.
> Examine your app for places where relationships among elements are visual only. Then, describe
> these relationships to VoiceOver.

*Restored in full 2026-08-14 (third pass): the earlier rendering stopped at "between elements."
and dropped the two sentences that turn the observation into an instruction — find the
visual-only relationships, then declare them. That is the design-time action this whole section
is about.*

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
| Liquid Glass: functional layer, out of the content layer — **with Apple's named exception** for transient content-layer controls (sliders, toggles) | `SURFACES.md`, as a rule that ships with its exception |
| Regular vs clear variant decision + the dimming-layer follow-on | `SURFACES.md` decision procedure |
| Reduce Transparency / Increase Contrast as designed states | `ACCESS.md` + `CRAFT.md` three-states |
| M3 Expressive: not a new version; 46 studies / 18,000 participants; 4× faster element spotting | `STYLES.md` |
| VoiceOver grouping as a layout-time decision | `ACCESS.md`, Loop 1 |
| The fabrication finding | `PRINCIPLES.md` — sourcing rule for anything the plugin quotes |

## What the corrected quotes mean for `SURFACES.md` — not fixed here

`SURFACES.md §4` was written from the uncorrected text and carries the same two misquotes
verbatim (its Liquid Glass block quotes), plus the same dropped "elements" in the definition and
the same bracketed paraphrase of the system-settings sentence. This file does not edit it. What
a corrections pass there has to decide:

*Status, 2026-08-14 (fourth pass): items 1, 2 and 5 have since been applied in `SURFACES.md` —
it carries the corrected block quotes, states Apple's rule with its named exception instead of
"never", and no longer calls clear non-adaptive. Items 3 and 4 are carried there as explicitly
unconfirmed, and this pass extended the search for both to Adopting Liquid Glass and Applying
Liquid Glass to custom views: still absent. The list below is kept as written because it is the
record of what the pass found, not a to-do.*

1. **The two block quotes are wrong and must be replaced** with the wording above. The inverted
   one — overuse distracting from *content*, not from *functional elements* — is the priority.
2. **"Never the content layer" as a hard rule overstates the page.** Apple's rule is
   "Don't use Liquid Glass in the content layer" with a named exception for transient
   interactive controls. `SURFACES.md` already states that exception in its prose, so the
   conclusion survives; the word "never" and the fabricated "functional layer / content layer"
   phrasing do not.
3. **"Never stack glass on glass"** and the instruction to use fills, transparency and vibrancy
   on top elements do **not** appear on the Materials page. That is the wording of the original
   fabricated quote, restated as a rule. It may be true and sourced elsewhere in Apple's docs,
   but as of this pass it is **unconfirmed**.
4. **"The two variants are never mixed in the same interface"** does not appear on the Materials
   page either. Unconfirmed.
5. **"Clear: non-adaptive"** is contradicted by the page: Apple says the appearance of *these
   variants* — both of them — can differ under system settings.

## Still open on this topic

Navigation models per platform (tab bar vs bottom nav, predictive back), safe-area and
edge-to-edge specifics including the Android 15 change, gesture conflicts with author-built
swipe, and TalkBack. The cached claims cover these but none is verified.
