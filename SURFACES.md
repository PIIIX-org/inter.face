# Surfaces

`STYLES.md` is what an interface looks like. `CRAFT.md` is how you render it. `TOOLS.md` is
what it must do when it is used for hours. This file is **where it runs**, and it is the one
file in the plugin where every hard number lives.

Nothing here is a starting position under `§3`. The rest of the plugin is a set of opinions
to argue with; a platform's published control size is not an opinion. **Every number below
was read off a rendered primary source**, and if a number is not in the research it is not in
this file. That rule is not decoration. This project has already caught two fabricated W3C
quotes, a Liquid Glass rule attributed verbatim to a page that does not contain the words, and
a research harness that returned a literal stub object which satisfied its output schema and
so passed validation without erroring. Do not round these numbers, do not interpolate between
them, and do not add one because it feels right.

---

## The fork

Read row 1 of `TRANSLATE.md` first. Which numbers bind depends on it.

**Page-shaped** — read for seconds, once. Almost always web, and the target law that binds is
**WCAG 2.5.8**, not a platform table: 24×24 CSS px of effective area, satisfiable by size
**or** by the geometric spacing exception. The platform tables below are for the case where a
page-shaped surface is genuinely native — an onboarding flow, a marketing screen inside an
app — and the moment it is native, the platform's own default is the number, not the web's.

**Tool-shaped** — read for hours, daily. This is where the numbers fight each other. Density
is a feature (`TOOLS.md`), and a 48dp touch floor is what density runs into first. The escape
is the pointer pair, not a smaller touch target: when a mouse and keyboard are the primary
input, Material publishes a **separate, smaller spec** — and it is a spec, not a licence to
shrink. A tool that ships pointer-sized targets and is then used on a tablet has failed
silently.

**And a third question, for anything that runs on a tablet or a desktop:** *what is the
narrowest and the widest this can be dragged to, and is every width between them correct?*
There is no notification and no control — see §5 below. A tablet layout is not a breakpoint.
It is a resize contract.

---

## 1. Platform mode is a pre-decision

Before a style, before a target number: **which platform's law binds.** Three branches. The
answer is written into `DIRECTION.md` before Gate A, because everything below forks on it and
discovering the fork during the build is a rewrite.

### iOS-native

- **Liquid Glass binds** (§4 below). It is the functional layer for controls and navigation.
  Standard components pick it up automatically; the only decision is where to extend it to
  custom elements, and the instruction there is *sparingly*.
- **Targets: 44×44 pt default, 28×28 pt minimum.** Type: 17 pt default, 11 pt minimum.
- **Dynamic Type is twelve sizes**, and surviving them is a layout decision, not a font
  decision (§3 below).
- **SF Symbols is a font, not an icon set.** It aligns to San Francisco by weight and by cap
  height, and the container picks the variant: *"an iOS tab bar prefers the fill variant,
  whereas a toolbar takes the outline variant."* An SF Symbol in a logo is a licence
  violation, not a taste question.
- **Layout is designed against available width, not against the size class** (§5 below).
- **Reduce Transparency and Increase Contrast are designed states**, not runtime accidents.

### Android-native

- **Material 3, and M3 Expressive is not a new version of it.** Google states it directly:
  *"M3 Expressive isn't a new version of the system. We're not deprecating M3."* A designer
  targeting Android is working inside M3; Expressive is an additive layer of components and
  tactics on top of it, not a replacement and not "M4."
- **Targets: 48×48 dp touch**, and Android's own design guidance requires that 48dp be met
  *even where it extends past the visible bounds of the element*. **Pointer targets are a
  separate, smaller spec: 44×44 dp.**
- **Icon and target sizes are two decisions, paired per input method** — 24dp icon in a 48dp
  target for touch, 20dp icon in a 40dp target for mouse and keyboard (§2 below).
- **Type is declared in `sp`** so the OS font-scaling setting applies at all, with a 12sp floor
  for body text — and above Android 14 the scaling curve is non-linear, so `4sp + 20sp ≠ 24sp`
  and any layout arithmetic that adds sp values is wrong (§3 below).
- **Five breakpoints, and the pane count per breakpoint** (§5 below).

### Cross-platform-neutral

- **48dp / 44pt.** One pair, and it clears every floor above.
- **No Liquid Glass and no SF Symbols.** Both are Apple-platform assets with their own rules,
  and in SF Symbols' case with licence terms that a cross-platform product will breach.
- **Type: no platform's default is authoritative here.** The number that still binds is the
  scaling target — Apple's word is *ideally*, at least 200% (140% in watchOS apps), and §3 below
  carries the correction — because that one is a layout decision and layout is the thing all
  three branches share. Design to it; do not cite it as a mandate Apple did not write.
- **Material's five breakpoints are the usable breakpoint system**, because Apple's size
  classes do not vary on the device where they would matter most (§5 below).

### They do not mix

A neutral surface that borrows Liquid Glass for its content cards has broken two rules in one
move: Apple's, because Liquid Glass is not a content-layer material, and its own, because it
declared no platform. A platform-committed surface that adopts the other platform's numbers
gets a layout that is wrong on both. Pick a branch, write it in `DIRECTION.md`, hold it, and
if it changes, treat that as a direction change and not a tweak.

---

## 2. The four target numbers are four different things

They get quoted interchangeably and they are not interchangeable. Four standards, four
measurements, four scopes.

| Standard | Number | Applies to |
|---|---|---|
| **WCAG 2.5.8** (AA) | 24×24 CSS px effective area | web; satisfiable by size **or** by the geometric spacing exception |
| **Apple iOS/iPadOS** | 44×44 pt default, 28×28 pt minimum | native iOS controls |
| **Material** | 48×48 dp | touch targets |
| **Material** | 44×44 dp | **pointer** targets — a separate, smaller spec |

Material states the touch and pointer numbers as two sentences, not one:

> For most platforms, consider making touch targets at least 48 x 48dp.

> Consider making pointer targets minimums 44 x 44dp.

It also anchors the touch number in physical space rather than in pixels — *"The recommended
target size for touchscreen elements is 7-10mm"* — which is why the number does not travel to
a pointer surface. A finger is a fixed size. A cursor is not.

### The correction: "Apple's minimum is 44×44 pt" is wrong

It is repeated nearly everywhere, including in most design skills, and it is wrong. **44 is
the default.** Apple's Accessibility page — change log **June 9, 2025** — publishes **two**
numbers for every platform:

| Platform | Default control size | Minimum control size |
|---|---|---|
| **iOS, iPadOS** | 44×44 pt | 28×28 pt |
| **macOS** | 28×28 pt | 20×20 pt |
| **tvOS** | 66×66 pt | 56×56 pt |
| **visionOS** | 60×60 pt | 28×28 pt |
| **watchOS** | 44×44 pt | 28×28 pt |

> Offer sufficiently sized controls. Controls that are too small are hard for many people to
> interact with and select. Strive to meet the recommended minimum control size for each
> platform.

Two qualifiers travel with that table and must not be dropped:

1. **Apple's own verb is "strive to meet."** This is framed as aspirational, not as a hard
   floor the way Android's 48dp is. Quote it as Apple's recommendation, not as a requirement.
2. **Control size and tappable hit region are different measures.** Apple's Buttons page states
   a separate 44×44 pt hit-region rule (60×60 pt on visionOS). So the like-for-like comparison
   to Android's 48dp is Apple's **44pt hit region**, not the 28pt control-size minimum — and on
   visionOS, Apple's own two pages disagree with each other, 28×28 pt control size against a
   60×60 pt hit region. Flag that conflict where it comes up. Do not silently resolve it.

A rule that says "44pt minimum on iOS" will be cited as Apple's requirement, and it is not. It
is trivially checkable and it is wrong in both directions at once. Ship the pair.

### The decision procedure

1. **Cross-platform-neutral takes 48dp / 44pt.** That pair clears every floor in the table
   above, on every platform, for touch. It is the default answer and it needs no argument.
2. **A platform-committed design may use its own platform's default** — 44×44 pt on iOS, 48dp
   on Android, 28×28 pt on macOS — and should say in `DIRECTION.md` that it is committed.
3. **Nothing ships at a platform *minimum* without a stated reason.** A minimum is a floor for
   constrained cases, not a target. If a control ships at 28×28 pt, the reason is written down.
4. **On the web, WCAG 2.5.8's spacing exception is a real second route.** 24×24 CSS px of
   *effective* area, reached by size or by spacing, is the standard — not the platform tables.

### Spacing is a separate obligation from size

A target can be the right size and still be unusable because of what is beside it.

**Material: 8dp between targets.**

> In most cases, targets separated by 8dp of space or more promote balanced information
> density and usability.

**Apple, more specifically, and this is the rule almost nobody encodes:**

> In general, it works well to add about **12 points** of padding around elements that include
> a bezel. For elements **without** a bezel, about **24 points** of padding works well around
> the element's visible edges.

**A bezel-less control needs double the padding of a bezelled one.** That is checkable, it is
free, and it is the difference between a flat toolbar that reads as a set of controls and one
that reads as a row of words.

### Icon size and target size are two decisions

Material names the trap that makes small targets look compliant:

> an icon may appear to be 24 x 24dp, but the padding surrounding it comprises the full
> 48 x 48dp touch target

And then it states the positive form of the rule **twice — once per input method:**

> Symbols of 24dp should have a target size of 48dp by default.

> When a mouse and keyboard are the primary input methods, measurements may be condensed to
> accommodate denser layouts. A 20dp size symbol can use a target size of 40dp.

| Primary input | Icon | Target |
|---|---|---|
| **Touch** | 24dp | 48dp |
| **Mouse and keyboard** | 20dp | 40dp |

This is exactly parallel to the 48dp-touch / 44dp-pointer split in the four-standards table
above, and it is the pair a tool-shaped surface actually needs: the way to get density is the
**pointer row**, not a shrunken touch target. A 24dp icon inside a 48dp target is correct. A
24dp icon that *is* the target is a failure in Material's own terms.

**No cross-platform icon-size equivalence exists.** Material publishes a dp grid; Apple
publishes no numeric canvas size for interface icons at all, defining symbol scale relative to
the San Francisco cap height instead. Any "24dp ≈ 24pt" mapping would be invented. Do not
write one.

---

## 3. Type and scaling

### Apple's per-platform defaults and minimums

Same structure as the target table, same discipline — the pair, never one number.

| Platform | Default | Minimum |
|---|---|---|
| **iOS, iPadOS** | 17 pt | 11 pt |
| **macOS** | 13 pt | 10 pt |
| **tvOS** | 29 pt | 23 pt |
| **visionOS** | 17 pt | 12 pt |
| **watchOS** | 16 pt | 12 pt |

> Use recommended defaults for custom type sizes. Each platform has different default and
> minimum sizes for system-defined type styles to promote readability.

### The scaling obligation, which is what actually breaks layouts

> Ideally, give people the option to enlarge text by at least **200 percent** (or **140
> percent** in watchOS apps).

Apple's own word is *ideally*. App Store Connect converts the same numbers into pass/fail
criteria for the Larger Text badge, so the aspiration has a scoreboard.

**Apple's Dynamic Type ramp is twelve sizes** — seven standard (xSmall through xxxLarge,
default Large) plus five accessibility sizes, AX1 through AX5. Body runs **17 pt to 53 pt**,
about 3.1×, **crossing 200% already at AX3** and exceeding 300% at AX5. Scaling is *not*
uniform across styles: Large Title runs 34 pt to 60 pt, about 1.76×. At the top of the ramp,
Body at 53 pt exceeds a default-size Large Title — the hierarchy inverts, and a layout whose
headings work only because they are bigger has nothing left.

**A layout that cannot survive 200% text is not an accessibility bug found in QA. It is a
layout decision made at design time**, and it belongs in Loop 1 with the other layout
decisions.

### What Apple says to actually do about it

Three instructions, all of them layout instructions rather than font instructions:

- **Switch side-by-side and horizontal layouts to a vertical stack** so each element gets the
  full display width.
- **Let text wrap to two or more lines rather than truncate.**
- **Reduce multicolumn text to fewer columns.**

And one native-only prohibition with no web equivalent: **system-level magnification does not
count.** Zoom and Hover Text cannot be relied on to satisfy the enlargement obligation in a
native app. On the web, browser zoom and reflow *are* accepted mechanisms for WCAG 1.4.4 and
1.4.10 — so a web-derived checklist will pass a native app that has done nothing.

### Android: 200%, and the curve that breaks the arithmetic

Android 14 raised maximum font scaling to **200%** and applies a **non-linear scaling curve**,
so large text scales less aggressively than small text — which preserves the type hierarchy and
prevents oversized text from being cut off.

The consequence is the one that catches people:

**`4sp + 20sp ≠ 24sp`.** sp values are no longer additive. So `sp` must not be used for padding
or for view heights that assume implicit padding, and any layout math built by summing sp
values is wrong at scale. Text in `sp` gets the improvement automatically, but the app still
has to be explicitly tested at the 200% maximum. There is no CSS analogue to this and no
web-derived checklist catches it.

Android's floor for body text is **12sp**, aligned to the Material type scale, and font sizes
must be declared in `sp` rather than `dp` or `px` for the user's scaling setting to apply at
all.

### One contrast note, because the boundary moves

Apple's contrast boundary is **17 pt**, not the web's 18px/14pt-bold convention. A design
system that carries one contrast rule across web and iOS is using the wrong breakpoint on one
of them. `ACCESS.md` owns contrast; this line exists so nobody carries the web number into a
native type ramp by reflex.

---

## 4. Liquid Glass

Apple platforms have two material types: Liquid Glass, and standard materials. Liquid Glass is
the current one, introduced at WWDC 2025 for iOS 26 and shared across iOS, iPadOS, macOS, tvOS
and watchOS, and it has exactly one job:

> Liquid Glass forms a distinct functional layer for controls and navigation elements — like tab
> bars and sidebars — that floats above the content layer, establishing a clear visual hierarchy
> between functional elements and content.

### The hard rules, in Apple's words

> **Don't use Liquid Glass in the content layer.** Liquid Glass works best when it provides a
> clear distinction between interactive elements and content, and including it in the content
> layer can result in unnecessary complexity and a confusing visual hierarchy. Instead, use
> standard materials for elements in the content layer, such as app backgrounds. An exception to
> this is for controls in the content layer with a transient interactive element like sliders
> and toggles; in these cases, the element takes on a Liquid Glass appearance to emphasize its
> interactivity when a person activates it.

**Out of the content layer, and the exception is part of the rule.** A design that renders
content cards in Liquid Glass is violating the primary rule of the material. A slider that
picks up glass while it is being dragged is following it — Apple names **transient interactive
controls**, sliders and toggles, as the one exception, and they take the appearance only while
a person is activating them. State the rule with its exception attached; the exception is the
part a design decision actually turns on.

> **Use Liquid Glass effects sparingly.** Standard components from system frameworks pick up the
> appearance and behavior of this material automatically. If you apply Liquid Glass effects to a
> custom control, do so sparingly. Liquid Glass seeks to bring attention to the underlying
> content, and overusing this material in multiple custom controls can provide a subpar user
> experience by distracting from that content. Limit these effects to the most important
> functional elements in your app. For developer guidance, see Applying Liquid Glass to custom
> views.

So the material is applied *for* you on standard components. The designer's only decision is
which custom elements get it, and the instruction on that decision is restraint. Note what
overuse costs: not the controls, **the content** — the thing the material exists to bring
attention to.

**Don't crowd or layer glass onto glass.** Apple's wording, on the Adopting Liquid Glass page
rather than on Materials: *"Prefer to use standard spacing metrics instead of overriding them,
and avoid overcrowding or layering Liquid Glass elements on top of each other."* The same page
tells you to **strip pre-existing custom bar decoration** — *"Reduce your use of custom
backgrounds in controls and navigation elements… Prefer to remove custom effects and let the
system determine the background appearance…"* — because extra backgrounds and borders fight a
system appearance that already supplies its own visual weight. Both quotes were read off the
rendered page on 2026-08-14 and are recorded, with the URL and the elided text, in
`docs/research/mobile-native-verified.md`.

*(Unconfirmed, and named because an earlier draft of this file shipped it as a hard rule: the
prescription that elements placed on top of the material should instead use "fills, transparency
and vibrancy", and that a custom control takes the material on itself rather than on its inner
views. Neither appears on Materials, on Adopting Liquid Glass, or on Applying Liquid Glass to
custom views — all three read on 2026-08-14. The fills/transparency/vibrancy wording is the
wording of the fabricated quote this release exists to catch, restated as a rule, and it is not
carried here as one. Apple's vibrancy guidance on the Materials page is about vibrant colors on
top of **standard** materials, which is a different claim. A WWDC session may state it; none was
opened.)*

### Two variants, and the choice between them is a procedure

| Variant | What it does | When |
|---|---|---|
| **Regular** | Adapts to what is behind it: *"blurs and adjusts the luminosity of background content to maintain legibility of text and other foreground elements"*. Most system components use it | The default. When background content might create legibility issues, and for anything carrying significant text — alerts, sidebars, popovers |
| **Clear** | *"highly translucent, which is ideal for prioritizing the visibility of the underlying content and ensuring visually rich background elements remain prominent"* | **Only** over visually rich backgrounds — photos, video |

Neither variant is a fixed look. Apple's sentence is about *these variants*, plural: the
appearance of **both** can differ under system settings (§ *It is not a static look* below).
"Clear" means more translucent than regular, not exempt from adaptation.

> **Only use clear Liquid Glass for components that appear over visually rich backgrounds.**

Clear carries a follow-on decision:

> For optimal contrast and legibility, determine whether to add a dimming layer behind
> components with clear Liquid Glass:
>
> - If the underlying content is bright, consider adding a dark dimming layer of 35% opacity.
>   For developer guidance, see clear.
> - If the underlying content is sufficiently dark, or if you use standard media playback
>   controls from AVKit that provide their own dimming layer, you don't need to apply a dimming
>   layer.

So the dimming layer is **dark, 35% opacity**, and conditional on the underlying content being
bright — it is not a default, and standard AVKit playback controls already supply their own.

*(Unconfirmed, and demoted from a hard rule on 2026-08-14: earlier drafts of this file stated
"the two variants are never mixed in the same interface — picking clear for one bar and regular
for another is not a stylistic choice; it is a broken material." No such rule appears on
Materials, on Adopting Liquid Glass, or on Applying Liquid Glass to custom views, all three read
on 2026-08-14; the origin of the sentence in this project is not recoverable. What Apple does say
cuts the other way on its face — the two variants are "variants… that you can choose when
building custom components or styling some system components", chosen per component. The
defensible part is the one Apple states directly and this file already carries: clear is **only**
for components over visually rich backgrounds, so a clear bar over a plain background is wrong on
that rule, mixed or not. Treat consistency as taste, not as law, until someone opens a source.)*

**Scroll edge effects** are a separate legibility mechanism, named separately: blurring and
reducing the opacity of background content where content passes under the functional layer.

### It is not a static look

> The appearance of these variants can differ in response to certain system settings, like if
> people choose a preferred look for Liquid Glass in their device's settings, or turn on
> accessibility settings that reduce transparency or increase contrast in the interface.

A design that assumes the glass look is fixed will break under Reduce Transparency and Increase
Contrast. **Both are design-time states to art-direct**, exactly the way `CRAFT.md` treats
reduced motion — a designed state, not a runtime accident and not a degradation you find out
about in QA. Screenshot both.

---

## 5. Tablet and desktop

### Delete this vocabulary on sight

**Split View, Slide Over and Stage Manager no longer exist in Apple's design guidance.** Not
"deprecated" — absent. Searched on the current Multitasking page:

| Term | Occurrences |
|---|---|
| Split View | **0** |
| Slide Over | **0** |
| Stage Manager | **0** |
| windowed | 4 |
| tiling | 1 |

The change log on that page reads **June 9, 2025 — "Reorganized guidance in platform
considerations, and added guidance for multitasking with multiple windows in iPadOS."** What
replaced the three modes, in Apple's words:

> People can use iPad with either full-screen or windowed apps. When full screen, apps occupy
> the full screen, and people can switch between individual app windows using the app
> switcher… with behavior **similar to macOS**. The system provides window controls for
> common tiling configurations, entering full screen, minimizing, and closing windows.

Confirmed independently on the Layout page:

> People can freely resize windows down to a minimum width and height, similar to window
> behavior in macOS. It's important to account for this resizing behavior and the full range of
> possible window sizes when designing your layout.

**iPad multitasking is now a macOS-shaped windowing model.** Any guidance that teaches the
three-mode vocabulary is teaching a superseded system, and it is the kind of thing a model will
produce from memory without hesitating. Two separate research methods reached the same
conclusion here; a third checked a claim that Apple names those modes as a required test matrix
and refuted it 0–3 against Apple's own desktop-class iPad app documentation.

### The replacement constraint is harder than the thing it replaced

> **Apps don't control multitasking configurations or receive any indication of the ones that
> people choose.**

You cannot detect the mode and you cannot request one. So a tablet design is not "a layout for
a tablet." It is a layout that must be correct at **any width the user drags it to, with no
notification that it changed.** Everything the old vocabulary let a designer do — enumerate
three modes, design three layouts, test three screenshots — is gone, and what is left is a
continuous range.

Apple also puts multitasking in the same category as the states nobody skips:

> Adapt seamlessly to appearance changes — like device orientation, multitasking modes, Dark
> Mode, and Dynamic Type — and transition effortlessly to running in macOS, letting people
> choose the configurations that work best for them.

It is a first-class appearance state, on par with Dark Mode. Not an edge case checked at the
end.

### Collapse order: the inverse of the mobile-first reflex

> As someone resizes a window, **defer switching to a compact view for as long as possible.
> Design for a full-screen view first**, and only switch to a compact view when a version of
> the full layout no longer fits... For more complex layouts such as [split views], prefer
> hiding tertiary columns such as inspectors as the view narrows.

Two instructions in one paragraph, and both invert the usual habit:

1. **Design the full-screen view first**, then decide what collapses. Mobile-first builds up;
   this builds down.
2. **When a multi-column layout has to shed a column, the tertiary one goes first** — the
   inspector, not the primary or secondary content. Name the collapse order at design time and
   write it in `DIRECTION.md`. A layout with three columns and no stated collapse order has
   three columns and one unanswered question.

The other large-display instinct to unlearn, from the iPadOS platform page:

> Take advantage of the large display to elevate the content people care about, minimizing
> modal interfaces and full-screen transitions, and positioning onscreen controls where they're
> easy to reach, but not in the way.

On a phone, a full-screen push is the default pattern for anything secondary. On a large
display that reflex is named as the thing to avoid.

And the input assumption, stated by Apple as the fundamental characteristic of the device
rather than as a compatibility footnote:

> People can interact with iPad using Multi-Touch gestures and virtual keyboards, an attached
> keyboard or pointing device, Apple Pencil, or voice, and they often combine multiple input
> modes.

**Hybrid input is the documented default.** Which is why the icon/target pair in §2 above has
two rows and a tablet has to satisfy the touch row.

### Material's five breakpoints — not three

Most references cite compact / medium / expanded. There are five, and the pane count is the
actual layout decision at each one.

| Breakpoint | Width | Panes | Common devices |
|---|---|---|---|
| **Compact** | under 600dp | 1 | phone in portrait |
| **Medium** | 600–839dp | 1 (recommended) or 2 | tablet in portrait, foldable in portrait (unfolded) |
| **Expanded** | 840–1199dp | 1 or **2 (recommended)** | **phone in landscape**, foldable in landscape (unfolded), desktop |
| **Large** | 1200–1599dp | 1 or **2 (recommended)** | desktop |
| **Extra-large** | 1600dp and up | **3** | desktop, ultra-wide monitors |

Two readings that a quick scan misses, and the first is the counterintuitive one:

- **A phone in landscape is Expanded — the same class as a desktop.** Not "a slightly wider
  phone." The same breakpoint, the same recommended pane count, as a laptop. If the expanded
  layout assumes a desktop's input and reach, a phone held sideways gets it.
- **Medium is a tablet in *portrait*,** not a tablet generally. A tablet in landscape is
  Expanded or above.

This is the table `STYLES.md` promises when it says the numbers and the breakpoints live here.
The rule it states there is the one these numbers serve:

> **Additional space doesn't just mean making the same thing bigger.**

Extra width **reveals** rather than **stretches** — a collapsed navigation rail expands, a
second pane appears showing what was previously a separate screen. The test at every step up
is to name what appeared. If nothing appeared and everything got bigger, the layout stretched.

**Height breakpoints exist and usually do not matter.** Material says so plainly: *"since most
layouts contain vertically scrolling content, it's rare that layouts need to adjust."* One
line, not a system.

### Apple's size classes, and why they are not enough on iPad

A coarser system than Material's:

> A size class is a value that's either regular or compact, where regular refers to a larger
> screen or a screen in landscape orientation and compact refers to a smaller screen or a
> screen in portrait orientation.

Two values per dimension, and here is the problem: **every current iPad model is regular-width,
regular-height in both orientations** — Pro 12.9", Pro 11", Pro 10.5", Air 13", Air 11", 11",
9.7", mini 7.9". iPhones vary by orientation. iPads do not, and the size class does **not**
change as the user drags a window narrower.

**Consequence: on iPadOS, design against available width, not against the size class.** The
size class will tell you the device is regular/regular while the window is a third of the
screen. Material's five breakpoints are the usable system for reasoning about width even on a
surface where they are not the native vocabulary.

### macOS windows have three states, and they are visual

> A macOS window can have one of three states: **Main** … **Key** … **Inactive**.

The key window is the one receiving keyboard input. It *"uses color in the title bar options
for closing, minimizing, and zooming; inactive windows and main windows that aren't key use
gray."* A window becomes key when someone clicks its title bar or a component that needs
keyboard input.

Design obligations with no web equivalent at all:

- **Three window states to design, not one.** A web page has no concept of being visible but
  not focused, with different chrome for each. A desktop-shaped surface owes all three, the
  same way a page-shaped surface owes three render states and a tool-shaped surface owes nine
  data states.
- **Window controls sit at the leading edge of the toolbar.** *"Make sure window controls don't
  overlap toolbar items."* A custom title bar that ignores this collides with the system.
- **Keep critical information and actions out of where window chrome may cover them.**
- **Custom windows do the state transitions by hand.** *"appearances update automatically… if
  you use custom implementations, you need to do this work yourself."* Choosing a custom window
  is choosing to implement three appearances.
- **Primary and auxiliary windows are distinct types with distinct rules.**

---

## 6. Canonical layouts — three shapes, and a test for which one this is

Material publishes three, each configured for compact, medium, and expanded. They are worth
knowing not as templates but because **each one answers "what happens when the window narrows"
differently**, and that answer is a Loop 1 decision the concept has to state.

*(The source for this was recorded as unreachable in an earlier pass. It had been renamed —
`canonical-layouts` now redirects to `canonical-examples` — the same rename pattern as
window size class → breakpoint.)*

**Feed.** Equivalent elements in a configurable grid. "Size and position establish relationships
among the content elements. Content groups are created by making elements the same size and
positioning them together. Attention is drawn to elements by making them larger than nearby
elements." Adapts from one scrolling column to a multi-column feed, so it survives any width.

**List-detail.** Two side-by-side panes, list and detail. The state rules are the part that
matters, and most designs never make them explicit:

- Expanded showing both, narrowing to medium or compact → **the detail stays, the list hides.**
- Compact showing only detail, widening to expanded → both appear, **and the list shows that
  item as selected.**
- Compact showing only the list, widening → the list plus a **placeholder detail pane.**
- Compact showing only the detail → **back returns to the list**, and that back handler is not
  part of app navigation, because it exists only as a function of window size and selection.

**Supporting pane.** Primary area is "typically about two thirds"; the supporting pane takes the
rest, and on medium or compact it can retreat into a bottom or side sheet behind a control.

**The test that separates the last two** — quoted, because it is a real decision rule rather
than a picture:

> Secondary pane content is **meaningful only in relation to the primary content**; for example,
> a supporting pane tool window is irrelevant by itself. The supplementary content in the detail
> pane of a list-detail layout, however, **is meaningful even without the primary content**, for
> example, the description of a product from a product listing.

Ask it of the concept's own content. A product description survives alone — list-detail. A
palette, a comment thread, a related-videos rail does not — supporting pane. Getting this
backwards produces a two-pane layout whose narrow state strands the user in a fragment.

## 7. Navigation, and the two platforms disagree about whether the count is a rule

**Material states a count. Apple refuses one.** A cross-platform design that picks one number
and ships it to both has followed neither.

| | Material navigation bar | Apple tab bar |
|---|---|---|
| Count | **"three to five destinations"**, stated as a rule | **No maximum stated.** The only number is "if you let people **select their own tabs**, aim for a default list of five or fewer" — an aim, for customizable bars |
| Overflow | Not applicable at three to five | The trailing tab becomes a **More** tab in iOS and iPadOS when space runs out; Apple says to "limit scenarios in your app where this can happen" |
| Where | Bottom, **mobile and tablet only**; rail from Medium up | Adapts to a **sidebar** for complex information structures |
| Item layout | **Vertical items in compact, horizontal items in medium** | Label beneath or beside the icon; single words where possible |

"iOS allows a maximum of five tabs" is not on the page. It is the same shape of error as
"Apple's minimum target is 44×44 pt" (§2 above) — a real number remembered with the wrong scope.
The genuine constraint is that **device and orientation decide how many tabs are visible**, and
the design owns what happens when they do not all fit.

Two rules that are stated absolutely and are routinely broken:

- **A tab bar is navigation, not actions.** "If you need to provide controls that act on
  elements in the current view, use a toolbar instead."
- **Never disable or hide tab bar buttons**, even when their content is unavailable — it "makes
  your app's interface appear unstable and unpredictable. If a section is empty, explain why its
  content is unavailable." That is an empty-state obligation arriving through the navigation
  door, and it belongs with the concept's absence states rather than being discovered at build.

Keep the bar visible as people navigate; the one exception is a modal covering it, "because a
modal is temporary and self-contained."

**Sheets.** Modality is platform-determined: "In macOS, tvOS, visionOS, and watchOS, a sheet is
always modal"; iOS and iPadOS allow nonmodal, which lets people affect the parent view without
dismissing. Three buttons carry fixed meanings — Cancel/Close dismisses without saving, Done
dismisses after saving, and **Back moves within the flow and "isn't intended to dismiss a
sheet."** A sheet is for a scoped task: "for complex or prolonged user flows, consider
alternatives" — full-screen modal on iOS/iPadOS, a separate window or full screen on macOS.

**Predictive back changes what back *is* on Android.** For apps targeting Android 16, the
predictive back animations are on by default and "`onBackPressed` is not called and
`KeyEvent.KEYCODE_BACK` is not dispatched anymore." The design consequence outlives the API
detail: **the system needs to know where back goes before the gesture completes, because it
animates the destination during the gesture.** A back destination computed at press time cannot
be previewed, so a concept whose back behavior is conditional has to resolve that condition
earlier than it used to.

## 8. Safe areas, edge-to-edge, and system gestures

### Edge-to-edge is no longer a choice on Android

Android 15 made it the default for apps targeting API 35 — Google's own word for it is "a
breaking change" — and **Android 16 removed the opt-out entirely**:
`windowOptOutEdgeToEdgeEnforcement` is "deprecated and disabled, and your app can't opt-out of
going edge-to-edge."

What that means at design time, not build time:

| Area | What happens |
|---|---|
| Gesture handle nav bar | Transparent; content draws behind it unless insets are applied. `setNavigationBarColor` has no effect |
| 3-button navigation | 80% opacity by default; content draws behind; contrast enforcement adds an 80% opaque background |
| Status bar | Transparent; content draws behind it unless insets are applied |
| Display cutout | `SHORT_EDGES`, `NEVER`, and `DEFAULT` are all interpreted as `ALWAYS` |

So **every Android surface is drawn under the system bars and the design owns the insets.** A
bottom action sitting at the window edge has a system gesture handle through it.

### Apple names safe areas and publishes no numbers

The Layout guidance says to respect "system-defined safe areas, margins, and guides (where
available)" and lists what varies — screen size, orientation, "system features like Dynamic
Island and camera controls", external displays, Display Zoom, resizable windows on iPad, Dynamic
Type, locale. There is **no published inset table**, consistent with Apple publishing no spacing
scale or grid module at all. Insets are read from the system at runtime, and **any fixed number
attributed to an Apple safe area is invention.**

### The web has the same concept, plus the variable most designs are missing

`env(safe-area-inset-top / -right / -bottom / -left)` define the rectangle inside which all
content is visible. Two things about them decide whether a layout works:

- **"For rectangular displays, these must all be zero."** So `padding: env(safe-area-inset-bottom)`
  collapses to nothing on a desktop, and the pattern that actually works is
  `max(<spacing token>, env(safe-area-inset-bottom))`.
- **`safe-area-max-inset-*`** is the static counterpart: the maximum value of each dynamic inset
  "when dynamic UA interfaces are retracted." The dynamic insets change as mobile browser chrome
  hides on scroll. **A layout that jumps when the toolbar retracts is a layout using the dynamic
  value where it wanted the static one.**

The insets are only non-zero with `viewport-fit=cover`, which sets the layout and visual viewport
to "the circumscribed rectangle of the physical screen of the device." `viewport-segment-*`
exists for foldables.

### Gesture conflicts: one edge is negotiable, the other is not

**Back is negotiable, within a ceiling.** System back is "an inward swipe from **either the left
or the right edge**." An app claims regions back with `View.setSystemGestureExclusionRects()`
(`DrawerLayout` and `SeekBar` do it automatically) — but "the system will put a limit of **200dp
on the vertical extent** of the exclusions it takes into account." And it is for precision only:
"not necessary ... for broadly spanning regions such as the entirety of a `ScrollView` or for
simple press and release click targets such as `Button`. Mark an exclusion rect when interacting
with a view requires a **precision touch gesture in a small area**."

**Home and quick switch are not negotiable.** "Apps can't opt out of these gestures as they can
with the back gesture." The only mitigation is reading
`WindowInsets.getMandatorySystemGestureInsets()` for the touch thresholds; games can request
immersive mode, "only when necessary, such as during gameplay."

**The design rule.** A horizontal swipe near a screen edge is competing with system back and can
win only inside a 200dp-tall band the design nominates. A vertical swipe at the bottom is
competing with home and **cannot** win. Carousels, swipe-to-delete rows, sliders, and drawing
canvases are the four that keep colliding, and the resolution belongs in `DIRECTION.md` beside
the navigation model — discovering it during the build means redrawing the interaction.

*(Verified on Android. Apple's equivalent — the `preferredScreenEdgesDeferringSystemGestures`
family — was not read, so no cross-platform claim is made from one side.)*

---

## The scope limit, stated out loud

**`CRAFT.md`'s arsenal is web technique.** Shaders, `backdrop-filter`, scroll-linked timelines,
CSS grid declarations, WebGL context loss — that is a web toolkit, and this file does not
pretend it crosses.

**On a native surface the principles hold and the arsenal does not:**

- **Prototype before you design around it.** Standalone, screenshotted, frame rate measured
  under load, verdict recorded in `DIRECTION.md`. Platform-independent.
- **Three states.** The names change — on Apple platforms, Reduce Transparency and Increase
  Contrast join reduced motion as designed states (§4 above) — but the rule that a technique
  with one state is unfinished does not.
- **The two-tier budget.** A shell that paints something real on its own, and heavy work that
  loads after. The units change; the boundary does not.
- **Name what the technique teaches.** A technique that carries no argument about the subject is
  decoration on any platform.

What does not cross: the entries themselves, the byte budgets stated in web terms, and the
assumption that a fallback path exists in the same shape. `tokens.json` does not cross either —
the DTCG `dimension` unit set has no `pt`, no `dp`, no `sp`, so native numbers live in
`DIRECTION.md` prose rather than in the token file. Say the limit rather than letting the
four-surface claim imply that one arsenal covers all of them.

**And the honest gaps**, named so silence is not read as agreement. Four that used to be listed
here are now researched and live in §6–§8 above: navigation models, safe areas and edge-to-edge,
gesture conflicts, and Material's canonical layouts.

What is still unresearched:

- **Windows and Fluent conventions**, and the Windows/macOS keyboard-shortcut divergence in
  detail. Sources were fetched in an earlier pass; the content was never synthesised.
- **Electron and Tauri specifics** — the "website in a window" failure and what a native-feel
  checklist actually contains.
- **iOS's side of the gesture-conflict question.** §8 above is verified on Android only; Apple's
  `preferredScreenEdgesDeferringSystemGestures` family was not read, and a cross-platform gesture
  claim must not be made from one side.
- **Per-device safe-area inset values from Apple.** Not published on the Layout page; the
  read-at-runtime rule holds regardless.

These are unresearched, not settled — and a run that needs one researches it rather than
recalling it.
