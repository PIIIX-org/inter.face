# Verified icons — Material Symbols and SF Symbols

**Date:** 2026-08-02
**Method:** rendered DOM text pulled with a headless browser from the primary source itself,
then read in context. **Not** WebFetch summaries and **not** from memory — three fabricated
quotes have already been caught in this project, so every quote below was read off the live
rendered page. `curl` is useless here: both m3.material.io and Apple HIG are JS-rendered and
return a near-empty shell to a plain fetch.

Pages read:

| Source | URL |
|---|---|
| Material 3 — Icons: Overview | `https://m3.material.io/styles/icons/overview` |
| Material 3 — Icons: Designing icons | `https://m3.material.io/styles/icons/designing-icons` |
| Material 3 — Icons: Applying icons | `https://m3.material.io/styles/icons/applying-icons` |
| Apple HIG — SF Symbols | `https://developer.apple.com/design/human-interface-guidelines/sf-symbols` |
| Apple HIG — Icons | `https://developer.apple.com/design/human-interface-guidelines/icons` |

Apple's SF Symbols page carries a change log entry of **July 28, 2025**; the Icons page carries
**June 9, 2025**. Material's icon pages publish no date.

This section had **no parent material and no prior research run.** Everything below is new.

---

## The rule that was already verified, now with its pair

`platform-numbers-verified.md` already carried the trap:

> an icon may appear to be 24 x 24dp, but the padding surrounding it comprises the full
> 48 x 48dp touch target

The Applying-icons page states the positive form of the same rule, and — this is the part that
was not previously captured — states a **second, smaller pair for pointer input**:

> Symbols of 24dp should have a target size of 48dp by default.

> When a mouse and keyboard are the primary input methods, measurements may be condensed to
> accommodate denser layouts. A 20dp size symbol can use a target size of 40dp.

So Material publishes an icon/target **pair per input method**, not one number:

| Primary input | Icon | Target |
|---|---|---|
| Touch | 24dp | 48dp |
| Mouse and keyboard | 20dp | 40dp |

This is exactly parallel to the touch-vs-pointer target split already recorded in
`platform-numbers-verified.md` (48×48dp touch, 44×44dp pointer). **Icon size and target size are
independent decisions** in both rows. A 24dp icon that *is* the 24dp target is a failure in
Material's own terms.

## Material — sizes, grid, and the live area

**Standard size and the supported set:**

> Standard icons are displayed as 24dp x 24dp. For pixel-perfect accuracy, create icons for
> viewing at 100% scale.

> Icons support additional sizes: 20dp, 40dp, and 48dp, with 20dp primarily for desktop, dense
> layouts, and small scale visuals, and 40dp and 48dp optimized for display or headline type,
> plus larger screen sizes.

**The live area** — the constraint that makes an icon set look like a set:

> Icon content is limited to the 20dp x 20dp live area, with 2dp of padding around the perimeter

with a stated escape hatch and a hard stop:

> If additional visual weight is needed, content may extend into the padding between the live
> area and the trim area (the complete size of a graphic). No parts of the icon should extend
> outside of the trim area.

**Keyline shapes**, the four proportions every glyph in the set is drawn against:

| Keyline | Dimension |
|---|---|
| Square | 18dp × 18dp |
| Circle | 20dp diameter |
| Vertical rectangle | 20dp high × 16dp wide |
| Horizontal rectangle | 16dp high × 20dp wide |

> The icon grid establishes clear rules for the consistent, but flexible, positioning of graphic
> elements. Keyline shapes are the foundation of the grid.

Plus: *"Position icons 'on pixel' within the icon grid."*

**Stroke and corners:**

> The recommended stroke weight for icons is 2dp or the regular weight (400), which includes
> curves, angles, and both interior and exterior strokes.

> Corner radii are 2dp by default. For the outlined style symbols, interior corners are square,
> not rounded. For shapes 2dp wide or less, stroke corners shouldn't be rounded.

Sharp style takes those same radii "from 2dp to 0dp"; rounded style rounds both exterior and
interior.

**Optical correction is permitted and named:**

> The paperclip icon uses 1.5dp of the possible 2dp stroke area to fit multiple curves within
> the 24dp x 24dp icon space

with the constraint that corrections "should use the geometric forms on which all other icons
are based, without skewing or distorting those shapes."

**And a flat prohibition:** *"Don't tilt, rotate, or make icons appear dimensional."*

## Material — the four variable axes

Material Symbols ship in **three styles** (outlined, rounded, sharp) with **four axes**:

> Material Symbols have four adjustable stylistic variable font attributes called axes… The
> attributes are: weight, fill, optical size, grade.

| Axis | Range | What it is for |
|---|---|---|
| Weight | thin (100) – bold (700) | Stroke weight. "Weight can also affect the overall size of the symbol" |
| Fill | 0 – 1 | "can be used to convey a state of transition, such as unfilled and filled states" |
| Grade | finer than weight | Thickness at near-constant size; matches a text font's grade |
| Optical size | 20dp – 48dp | Holds stroke weight constant as the icon scales |

Three quotable rules come off this page:

> Don't use the lightest weight for standard-size (24dp) icons. The minimum weight for this size
> should be 200.

> To match the apparent icon size, the default grade for a dark icon on a light background is 0,
> and -25 for a light icon on a dark background.

> Traditionally, icons are resized from a 24dp source vector, resulting in a large scaled icon
> that's too heavy compared to the original. With the optical size axis, you can maintain the
> stroke weight (thickness) as the icon size grows.

The grade rule is the one nobody encodes: **the same icon needs a different grade in dark mode
than in light**, because of visual bleed. That is a light/dark obligation on the icon layer, not
just the color layer.

## Material — icons set with type

Three do/don't pairs, verbatim:

> Use the same size for your Material Symbols and text

> Use the same optical weight for your symbol and text

> Shift down the baseline of symbols to approximately 11.5% of the text size

The 11.5% baseline shift is a real, checkable number and it is the difference between an icon
that sits in a line of text and one that floats above it.

## Material — labels, and when an icon may not stand alone

> Use caution if icons are displayed without labels. Icon meaning should always be unambiguous
> and accessible for all users. Text labels can be omitted in specific circumstances where
> reduced visual impact is necessary.

> Simple symbols, like stars for ratings, can be used on their own at any size, as long as they
> remain identifiable. Other symbols should have an accompanying text label below 20dp to ensure
> their meaning is clear and to maintain accessibility. These symbols include: Complex icons,
> which are highly detailed or have multiple parts [and] Icons with a key action, which are
> essential to using the product.

> Remember that navigation items must have labels for clarity and accessibility

**Below 20dp, a complex or key-action icon owes a visible text label.** That is a design-time
rule, not a screen-reader patch.

## Material — localization is an icon decision

> Translate icons for local markets. For example, different locales may prefer a cart, bag, or
> basket for checkout experiences.

> Consider cultural interpretations of symbols. In many western cultures, owls represent wisdom,
> while some eastern cultures view them as a negative omen.

> Color carries cultural significance… White is commonly associated with purity in western
> cultures but symbolizes mourning in some eastern cultures.

> Some locales use red as a warning color, while others use green.

Also: *"people who use the internet a lot may have different understandings of icons than people
who use the internet less."*

## Apple — SF Symbols is a font, not an icon set

> SF Symbols provides thousands of consistent, highly configurable symbols that integrate
> seamlessly with the San Francisco system font, automatically aligning with text in all weights
> and sizes.

**Nine weights, three scales:**

> Each of the nine symbol weights — from ultralight to black — corresponds to a weight of the San
> Francisco system font, helping you achieve precise weight matching between symbols and adjacent
> text

> Each symbol is also available in three scales: small, medium (the default), and large. The
> scales are defined relative to the cap height of the San Francisco system font.

Scale and weight are orthogonal on purpose: *"Specifying a scale lets you adjust a symbol's
emphasis compared to adjacent text, without disrupting the weight matching with text that uses
the same point size."*

**Four rendering modes** — monochrome, hierarchical, palette, multicolor — implemented by
layering a symbol's paths:

> To support the rendering modes, SF Symbols organizes a symbol's paths into distinct layers.

> Hierarchical — Applies one color to all layers in a symbol, varying the color's opacity
> according to each layer's hierarchical level.

> Regardless of rendering mode, using system-provided colors ensures that symbols automatically
> adapt to accessibility accommodations and appearance modes like vibrancy and Dark Mode.

**Variable color** carries state, and Apple draws a line most people cross:

> Use variable color to communicate change — don't use it to communicate depth. To convey depth
> and visual hierarchy, use Hierarchical rendering mode

**Gradients** (SF Symbols 7 and later): *"Gradients render for symbols of any size, but look best
at larger sizes."*

**Design variants** — outline, fill, slash, enclosed — and the rule that the container picks:

> Outline is the most common variant in SF Symbols.

> In many cases, the view that displays a symbol determines whether to use outline or fill, so
> you don't have to specify a variant. For example, an iOS tab bar prefers the fill variant,
> whereas a toolbar takes the outline variant.

> Symbols that use an enclosing shape — like a square or circle — can improve legibility at small
> sizes.

**Script variants ship in the set**, which is `§13` handled at the icon layer:

> SF Symbols provides many variants for specific languages and writing systems, including Latin,
> Arabic, Hebrew, Hindi, Thai, Chinese, Japanese, Korean, Cyrillic, Devanagari, and several Indic
> numeral systems. Language- and script-specific variants adapt automatically when the device
> language changes.

## Apple — symbol animation, and the restraint clause

SF Symbols ships named animation presets: Appear, Disappear, Bounce, Scale, Pulse, Variable
color, Replace (down-up, up-up, off-up), Magic Replace, Wiggle, Breathe, Rotate, and Draw On /
Draw Off (SF Symbols 7 and later). Apple distinguishes two that look alike:

> Breathe is similar to pulse; however pulse animates by changing opacity alone, while breathe
> changes both opacity and size to convey ongoing activity.

And bounds the whole feature:

> Apply symbol animations judiciously. While there's no limit to how many animations you can add
> to a view, too many animations can overwhelm an interface and distract people.

> Make sure that animations serve a clear purpose in communicating a symbol's intent.

## Apple — interface icons (glyphs)

> An effective icon is a graphic asset that expresses a single concept in ways people instantly
> understand.

**Consistency is specified as five properties, not a vibe:**

> all interface icons in your app need to use a consistent size, level of detail, stroke thickness
> (or weight), and perspective. Depending on the visual weight of an icon, you may need to adjust
> its dimensions to ensure that it appears visually consistent with other icons.

> In general, match the weights of interface icons and adjacent text.

**Optical centering, and the trick for shipping it:**

> Some icons — especially asymmetric ones — can look unbalanced when you center them geometrically
> instead of optically.

> When you create an asset that includes your adjustments as padding around an interface icon…
> you can optically center the icon by geometrically centering the asset.

> Adjustments for optical centering are typically very small, but they can have a big impact on
> your app's appearance.

**Format:**

> If you create a custom interface icon, use a vector format like PDF or SVG. The system
> automatically scales a vector-based interface icon for high-resolution displays

**Alt text is stated twice, once on each page:**

> Provide alternative text labels for custom interface icons. Alternative text labels — or
> accessibility descriptions — aren't visible, but they let VoiceOver audibly describe what's
> onscreen

**Inclusion and RTL:**

> Prefer depicting gender-neutral human figures and avoid images that might be hard to recognize
> across different cultures or languages.

> If you need to display individual characters in your icon, be sure to localize them. If you need
> to suggest a passage of text, design an abstract representation of it, and include a flipped
> version of the icon to use when the context is right-to-left.

**Selected states are usually not yours to draw:**

> You don't need to provide selected and unselected appearances for an icon that's used in
> standard system components such as toolbars, tab bars, and buttons. The system updates the
> visual appearance of the selected state automatically.

Apple also publishes a **standard-action symbol table** (change log: June 9, 2025) naming the
symbol for each common action — `scissors` cut, `document.on.document` copy,
`document.on.clipboard` paste, `checkmark` done, `xmark` cancel/close/deselect, `trash` delete,
`arrow.uturn.backward` / `arrow.uturn.forward` undo/redo, `square.and.pencil` compose, `pencil`
rename, `paperclip` attach, `plus` add, `ellipsis` more, `magnifyingglass` search,
`line.3.horizontal.decrease` filter, `square.and.arrow.up` share/export, `printer` print,
`person.crop.circle` account, `hand.thumbsup` / `hand.thumbsdown` like/dislike. Inventing a new
glyph for any of these on an Apple platform is a decision to be less legible than the system.

## Licensing — the constraint nobody reads

Both prohibitions are on Apple's own pages, in normative language:

> Be sure to understand the terms and conditions for using SF Symbols, including the prohibition
> against using symbols — or images that are confusingly similar — in app icons, logos, or any
> other trademarked use.

> SF Symbols includes copyrighted symbols that depict Apple products and features. You can display
> these symbols in your app, but you can't customize them.

> Don't design replicas of Apple products.

> Avoid using replicas of Apple hardware products. Hardware designs tend to change frequently and
> can make your interface icons and other content appear dated.

An SF Symbol in a logo is a license violation, not a taste question. Material's own icon set is
offered under a separate open license (its keyline template is stated as Apache 2.0) — but the
two sets are not interchangeable at the legal layer, and a run that mixes them owes a check.

---

## What goes where

| Finding | File |
|---|---|
| Icon size ≠ target size; the 24/48 touch and 20/40 pointer pairs | `CRAFT.md` icons, `SURFACES.md` targets |
| Live area, keylines, 2dp stroke, 2dp corners, on-pixel | `CRAFT.md` icons — the custom-glyph rules |
| Four Material axes; the 200-weight floor at 24dp | `CRAFT.md` icons |
| Grade 0 light / −25 dark | `CRAFT.md` icons **and** the light/dark section — it is a per-mode token |
| Same size, same optical weight, 11.5% baseline shift | `CRAFT.md` icons + typographic craft |
| Label required below 20dp for complex or key-action icons | `CRAFT.md` icons, `ACCESS.md` |
| Icon localization and cultural meaning | `CRAFT.md` icons, `§13` |
| SF Symbols nine weights / three scales / four rendering modes | `CRAFT.md` icons |
| Container picks outline vs fill | `CRAFT.md` icons, `SURFACES.md` native |
| Script-specific variants adapt on device language | `ACCESS.md`, `§13` |
| Symbol animation presets + "judiciously" | `CRAFT.md` motion |
| Optical centering by baking padding into the asset | `CRAFT.md` icons + typographic craft |
| Alt text on every custom glyph | `ACCESS.md`, `§10` |
| SF Symbols trademark prohibition | `CRAFT.md` icons, `§7`-adjacent asset rules |

## Not verified — do not ship these

Named explicitly so a later run does not assume silence means settled:

- **No cross-platform icon-size equivalence exists on these pages.** Material publishes a dp
  grid; Apple publishes **no numeric canvas size at all** for interface icons, defining scale
  relative to the San Francisco cap height instead. Any "24dp ≈ 24pt" mapping would be invented.
- **No verified web/SVG icon guidance.** Stroke alignment, pixel snapping, `currentColor`,
  sprite vs inline, and the accessible name of an icon-only button were not checked against a
  primary source in this pass. The ARIA and WCAG side of icon-only controls is unresearched.
- **Android's 3:1 non-text contrast ratio for icons** appears in `_mobile-raw-claims.md`, which
  is pre-verification extraction output, and the nearest line in `native-a11y-verified.md` sits
  in that file's **Refuted** section. Treat as unverified. Do not cite it.
- **Icon comprehension research** — no measured study of icon recognition, label-vs-no-label
  performance, or first-use ambiguity was located or checked. Material's "use caution if icons
  are displayed without labels" is guidance, not a measured finding, and must not be dressed up
  as one.
- **Material Symbols licensing terms** were not read; only the keyline template's Apache 2.0
  note appears on the rendered page. The font set's own license was not opened.
- **Icon Composer** (Apple's app-icon tool, listed in the developer downloads nav) was not read.
  App icons are a different problem from interface icons and are outside this pass.
