# Craft

`STYLES.md` is **what an interface looks like**. This file is **the technique arsenal: how you
render it**. The separation is load-bearing and collapsing it is how runs end up templated. A
style is a destination — a palette, a type system, a spatial logic, a mood. A technique is a
means of arriving: a shader, a filter, a timeline, a solver, a grid declaration. One style is
reachable through a dozen techniques; one technique serves a dozen unrelated styles.
`backdrop-filter` builds the refractive panel of liquid glass and the single frosted plane of a
Swiss layout. The style is the opinion; the technique carries none.

The order is fixed. **Style is chosen at Gate A**, from `TRANSLATE.md`. **Techniques are assigned
in Loop 2 to serve the style already chosen**, each one proven in a standalone runnable prototype
before any screen is designed to depend on it, and gated at **Gate B**. Reaching for a style
because you want to use a shader is the tail wagging the dog, and it shows in the output.

Everything below is a starting position under `§3`, never a destination. If the right answer for
this subject is a technique with no name yet, build that instead.

---

## The fork: what a technique is for

Read row 1 of `TRANSLATE.md` first. Technique means two different things depending on the surface
class, and the same entry in the same table earns its place for opposite reasons.

**Page-shaped** — read for seconds, once. Technique is **evidence of capability and a carrier of
argument.** It has three seconds to make a viewer understand something about the subject or the
product that a paragraph would have taken thirty seconds to say. The budget is a first-paint
budget, the audience arrives cold on an unknown device, and the failure mode is a site nobody can
fault and nobody can describe the subject from. This class owes **three render states**.

**Tool-shaped** — read for hours, daily, by the same person. Technique is **something the operator
pays for every day.** A scroll-linked reveal that delights once is a tax on the four-hundredth
repetition. Here the arsenal inverts: the heavy groups mostly cost, the cheap ones mostly pay, and
the highest-value techniques in the file are the unglamorous ones — grid determinism, information
design, icon discipline, a hairline that does not double. This class owes the **nine data states**
(`TOOLS.md`), and `§15` binds **[HARD]**: every primary workflow completable by keyboard alone.

A technique that carries meaning page-shaped and costs attention tool-shaped is not a technique
with a bug. It is a technique on the wrong surface.

**A tool-shaped surface that also carries heavy motion owes both sets.** Three render states and
nine data states are **different axes, not a longer list**: render states answer *can this machine
and this person's settings display it*, data states answer *what is true of the data right now*. An
empty table still has a reduced-motion state; a fully-loaded table still has an error state. Cross
them, do not concatenate them.

---

## The three-question test

Run this before a technique enters `DIRECTION.md`, in **Loop 2**, per surface. Three answers, one
line each.

| Question | Failure |
|---|---|
| What does this make the viewer **understand** about the subject or the product? | "It looks impressive" — cut it |
| Which **objection** does it answer, or which **proof** does it carry? | None — demote it to a decorative layer with a stated byte budget |
| What does it cost in **bytes and main-thread time**? | Unknown — prototype it before it enters the design |

A technique that answers all three is worth building at any complexity. One that answers none is
worth nothing at any complexity.

Real answers to question one: *the particle dissolve shows the scale of the dataset this person
worked with. The displacement on hover reveals the before-state of the redesign. Type on every
variable axis is the point, because the subject designs typefaces. The live latency figure is the
claim, watched being true.* If the answer is that it looks good, that it was technically hard, or
that the section felt empty, remove it. No gate grants an exemption.

Question two is where a page-shaped commercial surface diverges from a portfolio. On a company
site, impressive and irrelevant is not neutral — it is scroll depth the converting section needed.
On a tool-shaped surface, read question two as *which part of the operator's day does this make
shorter*, and question three as *what does it cost on the four-hundredth repetition*.

Question three is why this is a three-question test and not a one-question one: the cost column is
what stops a technique that passes on meaning from shipping unmeasured. Run the whole test again at
Gate B, and once more in Loop 4 with real copy and real data in place. Techniques that survived an
empty layout often stop making sense once there are words and rows on it.

---

## The arsenal

Nothing here is required and nothing here is exhaustive. Free rein to look up how any of it works —
the papers, the shadertoy, the library docs, someone's blog post from 2013 — and free rein to pull
libraries from a CDN while prototyping. Everything gets vendored before ship under `§7`.

### Showing the product

The highest-value group on a commercial page-shaped surface, and the most neglected. Also the
group most often replaced by an illustration of the product, which proves nothing.

| Technique | What it is | Where it earns its place |
|---|---|---|
| Live embedded product | The real application, running, in an iframe or a sandbox | The strongest conversion asset that exists. Nothing else removes as much doubt per byte |
| Scripted interactive demo | A faithful clickable replica driven by a script, not the real backend | When the real product needs auth or data. Cheaper to maintain than it looks, and far better than video |
| Annotated UI crop | A real screen, cropped to one job, with callouts | Explains a mechanism in one screen. Works in a deck and an email too |
| Sequenced UI reveal | Screens stepping through a workflow on scroll or a timer | A flow without a video's weight. Ships a paused, stepped fallback |
| Before / after scrubber | A draggable divider between two real states | Instantly legible proof for anything visual: migrations, cleanups, redesigns |
| Live data from the real system | A number, a chart, or a status pulled from production | Turns a claim into something the visitor watches be true. Needs a designed offline state |
| Synthetic-data replica | The real UI populated with realistic, non-real records | The answer when the product is under NDA or the data is personal |
| Video of the real thing | A real screen recording: short, poster-first, click to play | Never autoplay with sound. Poster in the shell, player loaded on interaction |

**Never fake a screen that implies a feature that does not exist.** A mocked-up UI ships only when
labeled as a concept, and on a marketing site it almost never should be. This is the same integrity
rule as `§14`'s ban on generating a real person's face: an invented screenshot is a claim about a
product that someone will buy on.

### Rendering and GPU

The heavy layer. All of it is tier two under `§11`, none of it in the LCP path. Almost none of it
belongs on a tool-shaped surface, and the exceptions are the ones where the render **is** the data:
a map, a volume, a point cloud, a graph at a scale a DOM cannot hold.

| Technique | What it is | Where it earns its place |
|---|---|---|
| Raymarching + SDFs | Geometry defined as a distance function, marched per pixel | Impossible forms, infinite repetition, soft shadows and ambient occlusion for free. A hero that could not be modeled |
| Domain warping (fbm) | Noise fed into the coordinates of more noise | Organic movement that never loops visibly. Clouds, ink, marble, smoke, atmosphere |
| Metaballs / marching squares | Implicit blobs meeting and merging on a field | Liquid identity, merging nav states, anything that should feel alive rather than placed |
| Reaction-diffusion | Two chemicals competing on a grid, Gray-Scott | Growth over time, developing as the visitor watches. Biotech, research, process narratives |
| Cellular automata | Grid state stepping under local rules | Emergent texture from near-zero bytes. Systems, infrastructure, generative subjects |
| Voronoi / Delaunay | Space partitioned by proximity to seed points | Territory and coverage, crystalline structure, a grid that is not a grid |
| Caustics | Refracted light patterns on a surface | Water, glass, liquid depth. Sells a scene as physical rather than drawn |
| Screen-space reflections | Reflections resolved from the depth buffer | Wet floors, polished surfaces, product-grade renders without cubemaps |
| Feedback loops (ping-pong FBO) | Rendering into a buffer that reads its own previous frame | Trails, decay, persistence, echoes. The cheapest route to a signature look |
| GPGPU particle systems | Particle state stored in textures, stepped in a shader | Millions of points at 60fps. Data made physical: transactions, users, deliveries |
| Curl-noise flow fields | Divergence-free noise driving velocity | Fluid motion with no fluid solver. Smoke, wind, drift, networks, logistics |
| Instanced geometry at 10k+ | One mesh, many transforms, one draw call | Density as a statement. A field of the thing this subject actually makes |
| Marching cubes / point clouds | Volumes turned into surfaces, or scans left as points | Scanned or reconstructed subject matter. Reads as data rather than illustration |
| MSDF text in WebGL | Signed-distance glyph atlases | Type living inside the 3D scene at any scale, warped, lit, still crisp |
| WebGPU compute + WebGL fallback | Compute shaders where available, degrade to WebGL | Simulation budgets WebGL cannot reach. Only with the fallback actually built |
| Volumetric / god rays | Light scattering through a participating medium | Atmosphere and depth. Turns a flat scene into a space with air in it |
| Procedural terrain / noise geometry | Mesh displaced by noise fields or real data | Landscape, topography, coverage, mapped data as physical relief |

### Post-processing and treatment

The pass after the render, cheap relative to what it buys, and where `§8` gets satisfied: generated
imagery becomes yours by what you do to it in the browser. Raw model output never reaches the page.

| Technique | What it is | Where it earns its place |
|---|---|---|
| Bloom | Bright regions bleeding into their neighbors | Makes emissive things read as light rather than pale color. Usually the first pass worth adding |
| Chromatic aberration | Channel separation at the edges | Lens realism at rest, energy under motion. Scale it with scroll velocity. Never on a glyph |
| Film grain | Animated noise over the composite | Kills banding, unifies CSS and canvas layers, adds material to flat gradients |
| Displacement | One texture pushing another's UVs | Transitions, hover distortion, heat, liquid. The workhorse of interactive treatment |
| Film LUT grading | A 3D color lookup applied to the final frame | One pass that makes every layer share a grade. The difference between colored and art-directed |
| Duotone | Two-color mapping of a luminance ramp | Pulls generated or supplied imagery into the palette. Cheap, and instantly proprietary |
| Ordered dithering / halftone / posterize | Quantized tone with a structured pattern | Print, plotter, newsprint, early-computing registers. Also compresses beautifully |
| ASCII / character shaders | Luminance mapped to a glyph atlas | Technical and terminal-native subjects. High cliche risk, so only with a reason |
| Anaglyph / lenticular | Offset stereo channels | Dimensional effects without a headset. Best in small doses on a single moment |
| Depth-map parallax | A generated image plus generated depth, displaced on pointer | Turns one flat frame into a scene with volume. High payoff per byte |
| Vignette | Falloff toward the frame edge | Directs the eye. Invisible when correct, obvious when missing. Body copy stays out of the falloff |
| Motion blur | Accumulated or velocity-buffer smear | Speed that reads as speed rather than strobe |
| Edge detection / sobel | Gradient magnitude as an outline | Blueprint, x-ray, and diagram registers. Pairs well with posterize |

### CSS and SVG native

Zero dependencies, tier one, consistently underused. **Reach here first.** A technique that ships in
the shell costs nothing against the heavy budget, which makes this the only arsenal group that is
unambiguously right on both surface classes.

| Technique | What it is | Where it earns its place |
|---|---|---|
| OKLCH color and gradients | Perceptual color space interpolation | Gradients with no gray dead zone in the middle. Free by default in CSS Color 4, which interpolates in Oklab **unless** an endpoint uses legacy sRGB syntax — `hex`, `rgb()`, `hsl()`. Write at least one endpoint as `oklch()` or `color(srgb …)` or the browser silently falls back to muddy sRGB mixing |
| `@property` | Typed, animatable custom properties | Gradients, angles, and colors that actually interpolate. Unlocks CSS-only effects that used to need JS |
| `animation-timeline` | Native scroll-driven animation | Scroll effects off the main thread with no library. Check support, then fall back |
| View Transitions API | Native cross-document and same-document morphs. Cross-document needs `@view-transition { navigation: auto; }` on both pages, same-origin only; browsers without support ignore the unknown at-rule, so it ships with zero fallback code | Continuity between screens. A thumbnail that becomes the hero, a pricing tier that becomes the form. The browser keeps the new state live rather than snapshotting it, so anything still running keeps running through the transition |
| Container queries | Components responding to their own box | Real art direction per component rather than per viewport. The correct tool for a card that lives in three contexts |
| CSS anchor positioning | Elements tethered to other elements | Annotations, tooltips, marginalia, and popovers that hold their relationship with no JS measurement |
| `:has()` | Parent and sibling selection | State-driven layout with no JS. Form states, filled-field styling, a row that restyles because of what it contains |
| SVG filters | `feTurbulence`, `feDisplacementMap`, `feColorMatrix` | Procedural noise, warping, and duotone on live DOM. Text and images, no canvas needed |
| The gooey filter | `feGaussianBlur` into `feColorMatrix` contrast | Metaball merging on real HTML elements. Nav items that fuse, cursors that stretch |
| Masks | Alpha and luminance masking | Reveals, scroll-tied wipes, text that windows onto media |
| Clip-paths | Geometric and path-based clipping | Non-rectangular layout. Animatable, and the fastest exit from the card grid |
| `mix-blend-mode` | Compositing between stacked layers | Inverting cursors, type that reacts to what passes behind it, layered color opacity cannot fake |
| `backdrop-filter` | Filtering what sits behind an element | Real depth in sticky UI. Blur, saturate, and grade the background layer |
| Conic / repeating gradients | Gradient functions used as pattern | Texture and moire at zero byte cost. Halftones, guilloche, radial rhythm |
| Morphing SVG paths | Interpolation between path definitions | Logos that transform, section markers that become something else |
| Houdini paint worklets | Custom paint in a background image | Procedural texture inside CSS layout. Narrow support, always with a static fallback |
| `text-wrap: balance` / `pretty` | Native line-break optimization | Headlines that break where a designer would break them. One declaration |

### Information design

Zero dependencies, same as the group above. **This is not chart styling** — it is which channel
carries the value, decided before a single pixel renders. Both surface classes are full of these
and neither treats them as design: page-shaped it is the stat block, the pricing comparison, the
before-and-after, the ROI figure, each one a proof point that fails the argument if encoded badly.
Tool-shaped it is every chart on every dashboard, read a thousand times by someone who acts on it.

| Technique | What it is | Where it earns its place |
|---|---|---|
| Position-first encoding | The value sits on a shared scale as a position, not as a length, angle, area, or color alone | Position judgments run 1.4–2.5× more accurate than length and 1.96× more accurate than angle, with 5.3–7.3× fewer catastrophic misreads (Cleveland & McGill). Any stat block, comparison table, or before/after figure |
| Perceptually-uniform color scales | Sequential scales built lightness-dominant, dark reading as more. Diverging scales mark their break with both hue and lightness together. Qualitative scales hold saturation and lightness near-constant and vary hue alone | ColorBrewer's construction grammar. A scale built this way survives greyscale and holds together for colorblind readers **by construction**, which is `§10` satisfied at design time rather than patched in a final pass. Caps near 7–9 classes before further division reads as noise |
| No rainbow, ever | Jet and rainbow-family colormaps stay off the table regardless of the palette elsewhere on the page | A bright mid-range band reads as a false peak — measured brighter than the true data maximum by a wide margin. The distortion hits every reader, not only colorblind ones. The false peak is usually in the chart arguing for the product |

### Icons

An icon system is a technique group, not an asset download. Two platforms publish the rules; both
were read off the rendered page and recorded in `docs/research/icons-verified.md`.

**The rule that gets broken most.** Icon size and target size are **independent decisions**.
Material:

> an icon may appear to be 24 x 24dp, but the padding surrounding it comprises the full
> 48 x 48dp touch target

A **24dp icon inside a 48dp target is correct; a 24dp icon that IS the target is a failure.**
Material publishes the pair per input method, and the second row is the one dense tool-shaped
surfaces need: *"Symbols of 24dp should have a target size of 48dp by default"*, and *"When a mouse
and keyboard are the primary input methods, measurements may be condensed to accommodate denser
layouts. A 20dp size symbol can use a target size of 40dp."*

| Primary input | Icon | Target |
|---|---|---|
| Touch | 24dp | 48dp |
| Mouse and keyboard | 20dp | 40dp |

| Technique | What it is | Where it earns its place |
|---|---|---|
| Variable icon axes | Material Symbols carry four: weight (100–700), fill (0–1), grade, and optical size (20–48dp) | Fill animates a selected state without a second asset. Optical size holds stroke weight constant as the icon scales, where a resized 24dp vector goes *"too heavy compared to the original."* Material's own floor: *"Don't use the lightest weight for standard-size (24dp) icons. The minimum weight for this size should be 200"* |
| Grade per mode | A finer thickness axis than weight, at near-constant size | *"To match the apparent icon size, the default grade for a dark icon on a light background is 0, and -25 for a light icon on a dark background."* Visual bleed means the same glyph needs a **different grade in each mode** — an icon-layer obligation in the light/dark section below, not just a color-token one |
| Icons set with type | Match the metrics, not the box | Material states three: *"Use the same size for your Material Symbols and text"*, *"Use the same optical weight for your symbol and text"*, and *"Shift down the baseline of symbols to approximately 11.5% of the text size."* Apple states the same intent — *"In general, match the weights of interface icons and adjacent text"* — because SF Symbols weights map one-to-one onto San Francisco's nine weights |
| Optical centering | Correcting an asymmetric glyph against its own visual mass | Apple: *"Some icons — especially asymmetric ones — can look unbalanced when you center them geometrically instead of optically."* Bake the correction into the asset as padding, then *"you can optically center the icon by geometrically centering the asset"* — the fix survives every consumer of the file |
| Rendering modes | SF Symbols ships four: monochrome, hierarchical, palette, multicolor, backed by real layers | Hierarchical gives depth from one color at graded opacity. Apple draws the line: *"Use variable color to communicate change — don't use it to communicate depth"* |
| Variant chosen by container | Outline, fill, slash, enclosed | *"In many cases, the view that displays a symbol determines whether to use outline or fill… an iOS tab bar prefers the fill variant, whereas a toolbar takes the outline variant."* And *"Symbols that use an enclosing shape — like a square or circle — can improve legibility at small sizes"* |
| Custom glyphs on a real grid | A 24dp canvas with a 20dp live area, 2dp of padding, 2dp stroke, 2dp corners, drawn on-pixel | Material's keylines are the reason a set reads as a set: square 18dp, circle 20dp diameter, vertical rectangle 20×16dp, horizontal 16×20dp. Optical correction is allowed within the geometry — the paperclip uses 1.5dp of its 2dp stroke — but *"Don't tilt, rotate, or make icons appear dimensional"* |

**Four hard rules out of the same research.**

1. **Below 20dp, a complex or key-action icon owes a visible text label.** Material: *"Other
   symbols should have an accompanying text label below 20dp to ensure their meaning is clear and
   to maintain accessibility"*, naming complex icons and *"Icons with a key action, which are
   essential to using the product."* Navigation items owe a label at any size.
2. **Every custom glyph owes alternative text** (`§10`). Apple states it on both its icon pages.
   Decorative marks are hidden from assistive technology rather than described.
3. **Icons localize** (`§13`). Material: *"Translate icons for local markets. For example,
   different locales may prefer a cart, bag, or basket for checkout experiences."* Apple ships
   script-specific variants for Latin, Arabic, Hebrew, Hindi, Thai, Chinese, Japanese, Korean,
   Cyrillic, Devanagari, and several Indic numeral systems, which *"adapt automatically when the
   device language changes"*, and requires a mirrored glyph where one suggests reading direction.
4. **SF Symbols are licensed, not free.** Apple states *"the prohibition against using symbols — or
   images that are confusingly similar — in app icons, logos, or any other trademarked use"*, and
   *"Don't design replicas of Apple products."* A symbol in a logo is a license violation, not a
   taste question.

Format is settled: a custom interface icon ships as vector — Apple names PDF or SVG — so the system
scales it rather than you shipping a raster per density.

### Motion and input

Motion is where a surface proves someone can control time. Every entry here is bound by `§10`: a
**designed** reduced-motion state ships with it, and the specification for that state is below.

| Technique | What it is | Where it earns its place |
|---|---|---|
| Scrubbed scroll timelines | Progress tied to scroll position | Scroll as a scrub head. The visitor controls the story instead of watching it. One section, never a whole page |
| Spring and inertia physics | Motion resolved by simulation rather than easing | Motion that responds to how the input arrived. Nothing else feels this alive |
| Magnetic elements | Targets attracted to the pointer within a radius | Weighted feel on the primary action. A few elements only |
| Custom cursors | The pointer replaced or augmented | Signals a designed environment within one second, at almost no cost. Desktop only — design mobile first |
| Cursor-as-light-source masks | The pointer driving a mask or light position | Reveals, spotlights, and darkness the visitor navigates by hand |
| Per-glyph 3D transforms | Individual characters in 3D space | Headlines that assemble, rotate, and settle. High effort, high recall |
| Kinetic typography | Type as the animated subject | When the words are the work. Writers, brand strategists, anyone verbal |
| Split-text stagger | Sequencing at glyph or word level | Entrances with rhythm. The enabler for most of this group |
| Variable fonts on all axes | Scroll or cursor driving every available axis | Optical size, slant, width, grade, and custom axes. **Weight alone is the amateur signal.** Read the font's axis list and use what is there |
| Scroll-velocity distortion | Speed of scroll feeding a shader or filter | The surface responds to how fast someone moves. Subtle, immediately felt |
| Audio-reactive via Web Audio | Analyser output driving visual parameters | Musicians, sound designers, anything with an audio dimension. Opt-in only |
| Pointer-tilt / device orientation | Gyroscope or pointer position driving parallax | Depth on mobile where there is no hover. Always with a permission-aware fallback |
| Symbol animation | Platform icon animation presets — appear, bounce, pulse, breathe, replace, wiggle, rotate, draw | Feedback inside a control at near-zero cost. Apple's own bound: *"too many animations can overwhelm an interface and distract people"* |
| Number roll-ups on reveal | Counting to a real figure | Only for the one number the page is about, once. Otherwise it is a tic |
| Haptics | Vibration on supported devices | Confirmation you feel. Sparingly, and never on scroll |

**`IntersectionObserver`, never a scroll listener.** A `scroll` handler that reads `offsetTop`,
`getBoundingClientRect()`, or `scrollHeight` forces a synchronous layout on **every scroll event**,
which on a mid-range Android is continuous reflow on the main thread: the scroll janks, the frame
budget is gone before any of your animation runs, and the effect you wrote the listener for is the
thing that stutters. `IntersectionObserver` computes off the main thread and calls you only when a
threshold is crossed. Same for element size — `ResizeObserver`, never a `resize` handler that
measures. There is no traffic volume at which the listener version is correct.

### Whole-page and whole-app

Decisions that apply to the whole surface. Made once, early, and they set the ceiling for
everything else.

| Technique | What it is | Where it earns its place |
|---|---|---|
| A designed preloader | The first designed moment, composed and art-directed | Not a spinner. It earns its seconds by being worth watching and buys the heavy layer time to arrive. Only when there is genuinely something to wait for; if it has nothing to say, ship none |
| Art-directed dark and light | Two designs, each composed on its own terms | An inverted palette is a settings toggle. Two art directions is a design. See the section below |
| Real depth and parallax | Layers with genuine spatial separation | Space continuing behind the content. The cheapest way to stop looking like a document |
| Progressive disclosure | Depth revealed on demand | The committee problem: a page a skimmer can skim and a deep reader can open up. Tool-shaped, it is how density stays survivable |
| Sticky section pinning | A section held while its content advances | One per page, maximum. Two is a tunnel |
| Scroll-linked nav state | Nav adapting to position and direction | Keeps the primary action reachable without a permanent bar eating the viewport |
| Sound design | Considered audio on interaction and ambience | Opt-in, never autoplay, always with a visible mute. When it fits, nobody else did it |
| Procedural texture synthesis | Surface generated rather than downloaded | Grain, paper, fabric, and noise at zero request cost, tuned exactly to the palette |
| Generated-then-treated imagery | Image-tool output run through in-browser treatment | `§8`. Duotone, displacement, dithering, or grain applied in the browser. Raw output never reaches the page |
| Print stylesheet | A real one | Procurement prints pricing pages and operators print reports. Thirty lines, and someone will thank you |
| Reduced-data mode | `prefers-reduced-data` respected, and `navigator.connection.saveData` checked | Drop the heavy layer entirely. Cheap, and honest |
| The absence states | The 404, the empty index, the failed submission, the search with no results | The single likeliest place a visitor meets the generic template underneath everything, because it is the page nobody thought to design. After a migration the 404 gets more traffic than anyone expects, and the failed-submission state is the one a lead sees at the exact moment they were converting. Built from the same collision as the rest of the surface, never a framework default |

### Typographic craft

This group is unglamorous. It is also what separates good from expensive. Nobody compliments the
hanging punctuation; everybody registers its absence as an unnamed cheapness. Run this pass last,
after the real copy is in place.

| Technique | What it is | Where it earns its place |
|---|---|---|
| Optical alignment | Correcting for what the eye sees over what the box measures | Quotes, bullets, and large type that look misaligned when they are mathematically correct |
| Real kerning pairs | Manual correction on display-size pairs | Headlines. `font-kerning` handles body text and fails on the pairs people actually look at |
| Ligatures | Contextual and discretionary glyph substitution | Editorial and serif registers. Check `dlig` and `swsh` on the chosen face and use them deliberately |
| Optical sizing | `opsz` axis matched to rendered size | Display cuts at display sizes, text cuts at text sizes. One property, visible difference |
| Hanging punctuation | Quotes and hyphens set outside the measure | Pull quotes and lists with a clean left edge |
| Baseline grid | A shared vertical rhythm across all type | Sections that feel composed rather than stacked. Enforced with a spacing scale, verified with an overlay |
| Fluid type with `clamp()` | Type scaling continuously between bounds | One scale that works from 320px to 2560px. Set a real ratio, not arbitrary numbers |
| Tabular figures | `font-variant-numeric: tabular-nums` | Any column of numbers that updates. Proportional figures make a live counter jitter and a table's decimals wander. Tool-shaped, this is not optional |
| Hyphenation and justification | `hyphens`, `hyphenate-limit-chars`, language attributes | Justified text without rivers. Requires `lang` set correctly, which `§13` requires anyway |

---

## Craft rules that cost two lines each

Each of these fixes a tell that reads as amateur at a glance and takes one declaration to get
right. They are not optional polish; they are the difference between a surface that was drawn and
one that was assembled.

### Concentric radius

**Inner radius = outer radius − gap.** A 16px card holding an 8px-inset image gives the image an
8px radius. Give both the same radius and the curves run at different rates against each other,
which the eye reads as misalignment without being able to name it.

### Apple's three-shape system

Apple's layout system defines corner radius through **three shape types** rather than fixed
per-component values, and naming them is what makes the rule above computable instead of eyeballed:

| Shape type | Radius |
|---|---|
| **Fixed** | A constant radius |
| **Capsule** | Half the height of the container |
| **Concentric** | The parent's radius minus the padding |

Nested containers — artwork inside a card, an input inside a panel, an icon inside a chip — use the
concentric type so the inner radius is **computed from the parent, not guessed.** The moment a
design has three levels of nesting, guessing produces three unrelated curves.

### Grid determinism for hairlines

`display: grid; gap: 1px` on a container with a contrasting background, children with their own
background, produces hairline rules that **never double at intersections and never round wrong at
nested corners.** Borders do both: adjacent cells each draw their own edge, so every internal line
is 2px while every outer line is 1px, and a border on a rounded child inside a rounded parent
antialiases against the parent's curve. The grid version has no adjacency problem to solve, because
the lines are gaps in a background rather than edges on elements. Tool-shaped surfaces live and die
on this one — a table is a grid with the lines turned on.

### Compositor-only motion

`transform` (translate, scale, rotate, skew) and `opacity` run on the compositor thread and **never
trigger layout shift, by definition.** Animating `top`, `left`, `width`, `height`, or `box-shadow`
does, every time, on every frame. The fix is never "animate it more carefully"; it is animating a
different property. A hover lift moves on `transform: translateY()`, never on `top`. A glow grows
on a pseudo-element's `opacity`, never on `box-shadow` spread.

---

## Light and dark as two art directions

`STYLES.md` sends you here for this, and the rule is: **an inverted palette is a settings toggle;
two art directions is a design.** Never `filter: invert()`. Choose per-mode ink, substrate, shadow
direction, and accent chroma deliberately, and screenshot both under `§12`.

Both modes are real deliverables on both surface classes, for different reasons. **Page-shaped:**
dark reads as technical-audience-native and light reads as broadly legible, so when the audience
spans both, respect the system preference and make sure the version that gets forwarded is
excellent. **Tool-shaped:** the operator picks once and lives there for years, which makes the
non-default mode a first-class design rather than a courtesy — half of them will never see the one
you designed first.

What actually changes between the two, beyond the palette:

- **Imagery and grade.** Different treatment, different LUT, sometimes different images. A lit set
  has no light version; its light mode is a printed still with the grade baked in as duotone.
- **Shadow.** Keep the light direction identical in both modes and change the surface hue and the
  spread. Inverting a shadow pair puts the light source underneath, which no physical object does.
- **Material weight.** Blur reads as depth on dark and as haze on light, so a translucent panel
  needs more opacity, a heavier border, and less blur in light mode to say the same thing.
- **Emission.** Glow requires darkness. In light mode the accent moves from emissive to dense: ink
  saturation and weight instead of bloom.
- **Hairline weight.** A hairline that reads on dark disappears on white. Retune line weights per
  mode rather than reusing one token.
- **Gradient stops.** OKLCH stops that stay saturated on dark go chalky on light. Each mode needs
  its own stop list, never a lightness shift applied to one.
- **Icon grade.** The verified one: *"the default grade for a dark icon on a light background is 0,
  and -25 for a light icon on a dark background."* Same glyph, different grade, because visual
  bleed changes its apparent size. If the icon system has a grade axis and both modes use the same
  value, one of the two modes is wrong.

Every paired color token is paired **per mode** — a foreground legal on the light swatch tells you
nothing about the dark one. Declare in `DIRECTION.md` whether the two modes are one design in two
palettes or two art directions, and if the chosen family is atmospheric, motion-native, or
material-heavy, the answer is two art directions and both get built.

---

## Motion, reduced

`§10` is **[HARD]** and this is the part of it most often faked. `animation: none` on a layout that
assumed motion produces a broken surface: elements sit at `opacity: 0`, sequences never complete,
and the person who gets motion sick gets a blank screen. The reduced state is **a frame someone
art-directed** — pick the moment in the animation that reads best as a still, compose it, grade it,
ship that. A visitor who never saw the full version should not know anything is missing.

Honor the preference at both layers: the CSS media query, and
`matchMedia('(prefers-reduced-motion: reduce)')` for JS and shader work, with a listener so a
mid-session change is respected.

### Apple's five techniques

Most guidance says "respect `prefers-reduced-motion`." Apple says what to actually do, and these are
design instructions, not implementation notes. Verbatim from
`docs/research/platform-numbers-verified.md`:

> - Tightening animation springs to reduce bounce effects
> - Tracking animations directly with people's gestures
> - Avoiding animating depth changes in z-axis layers
> - Replacing transitions in x-, y-, and z-axes with fades to avoid motion
> - Avoiding animating into and out of blurs

**Read the last two again.** A z-axis depth transition and a blur-in/blur-out are exactly what is
fashionable right now — they are the default page transition in every framework starter and the
signature of every product launch of the last two years — and they are exactly what a
motion-sensitive person cannot tolerate. They are also the two nobody removes, because a designer
testing their own reduced-motion build sees the fades and thinks the job is done while the modal
still scales in from depth and the sheet still blurs the layer behind it.

The first two are the more interesting half: they say the reduced state does not have to be a
still. Motion **tracked directly to a gesture** is motion the person is causing, and a spring
tightened to remove bounce is still a spring. Reduced motion is a bound on unrequested,
unpredictable, and depth-simulating movement — not a bound on responsiveness.

### The three render states — page-shaped

`§10`, non-negotiable, no exceptions at any gate. A technique with one state is unfinished, and
unfinished is not shippable.

| State | What ships | What it is for |
|---|---|---|
| **Full** | The technique as designed | Capable hardware, motion allowed |
| **Reduced motion** | A **designed** still, or gesture-tracked motion per the five techniques | `prefers-reduced-motion: reduce`. Composition and grade intact |
| **No GPU** | A no-WebGL, no-canvas rendering | Context loss, old GPUs, blocked or software-rendered contexts. A real page, never an apology |

The fallback is a design deliverable, and on a commercial surface it is a commercial one too: the
visitor on locked-down corporate hardware with scripts restricted is frequently the enterprise
buyer.

### The nine data states — tool-shaped

They live in `TOOLS.md` and are referenced here by name because a tool surface with motion owes both
sets. Do not restate them here and do not treat them as a longer version of the three above: the
render states are about the machine and the person's settings, the data states are about what is
true of the data. **Cross the two axes.** An empty state has a reduced-motion rendering. A loading
state has a no-GPU rendering. A surface that ships nine data states and one render state has
satisfied `TOOLS.md` and failed `§10`.

### Context loss

`webglcontextlost` fires on tab switches, driver resets, GPU pressure, and memory reclaim on mobile.
It is a normal event, not an edge case.

- Listen for `webglcontextlost` and call `preventDefault()` on it.
- Show the fallback immediately. The static poster from the deferral pattern is already the right
  thing.
- Handle `webglcontextrestored` by rebuilding resources, or leave the fallback in place. Both are
  valid. Silently showing a black rectangle is not.
- Never let the render loop keep calling into a lost context.

### Feature detection

Detect capability, never user agent.

- WebGL2: attempt `getContext('webgl2')`, then `'webgl'`, branch on null.
- WebGPU: check `navigator.gpu` and await `requestAdapter()`. A present `navigator.gpu` with a null
  adapter is a real case.
- CSS: `@supports` for `backdrop-filter`, `animation-timeline`, anchor positioning, and anything
  else with partial support. Author the fallback first and let `@supports` upgrade it.
- Skip tier 2 entirely when `navigator.connection.saveData` is set.

### Testing all three

All three get verified before ship, each with a screenshot in the run report per `§12`.

| State | How to test |
|---|---|
| Full | Normal load, screenshot at mobile, tablet, desktop where the surface class applies |
| Reduced motion | OS-level setting, or DevTools rendering emulation |
| No GPU | Force it. Call `loseContext()` from the `WEBGL_lose_context` extension, or disable hardware acceleration and reload |

---

## The cheap wins

If a run only has budget for a handful of moves, these are the ones with the best return per byte.
Ordered by **impact ÷ risk** — highest impact per unit of risk first, so a run that stops partway
down has still taken the best available trades. Everything above the line is low-risk by
construction: it cannot break a layout, cannot fail on a device, and cannot be undone by a browser
update.

**Page-shaped:**

1. **Real product or real work, well shot and annotated.** Highest impact in the file, near-zero
   risk. Nothing else removes as much doubt.
2. **`text-wrap: balance` on every headline.** One declaration, immediate, degrades to nothing.
3. **OKLCH palette with a properly built neutral ramp.** Makes every later decision better.
4. **A real type system with one variable font on more than one axis.** Weight alone is the
   amateur signal.
5. **Named, faced, sourced proof placed next to the claim it supports.**
6. **A visible price**, where there is one. A design decision as much as a business one.
7. **Tabular figures and correct optical sizing.** Invisible when present, cheap as a tell.
8. **A form that is three fields and works.**
9. **Print stylesheet and a proper OG image.** Both invisible until someone needs them.
10. **A 12-second real screen recording, poster-first.** Real bytes, so it sits below the free
    wins.
11. **One collision-carrying signature moment**, prototyped, that nobody else has. Highest impact
    and the highest risk, which is why it is last rather than first — it is the one that can fail
    in a way the other ten cannot.

**Tool-shaped**, where the ranking changes because the reader returns:

1. **Grid-determinist hairlines and real tabular figures.** Every screen, every day, one
   declaration each.
2. **The keyboard path through the primary workflow** (`§15`, **[HARD]**).
3. **Information design on the charts that already exist.** Position-first encoding on a dashboard
   built from library defaults is a rewrite of nothing and a change to everything.
4. **Icon and target sizing at the pointer pair** — 20dp icon, 40dp target — so density and
   reachability stop fighting.
5. **The empty, error, and loading states designed rather than defaulted.**
6. **A density that matches the operator's actual day**, not a marketing site's spacing scale.
7. **Both color modes built**, because the operator picked one years ago.

---

## Prototype before you design around it

A technique is not available to the design until it has been proven. This is the rule of Loop 2, and
free rein while prototyping — any library, any CDN, any reference — ends at Loop 4, where everything
gets vendored and committed under `§7`.

1. **Research it.** Look up how it actually works. Read the reference implementation. Do not reason
   about a shader from memory.
2. **Build it standalone.** One self-contained runnable file, opening with no build step. Real
   content where it matters: the actual typeface, palette, and imagery.
3. **Screenshot it.** Look at it with your eyes per `§12`. A prototype that was never viewed was
   never tested.
4. **Measure frame rate under load**, on throttled hardware. Record the number, the viewport, and
   the machine.
5. **Build all states** the surface class owes.
6. **Record the verdict** in `DIRECTION.md` — ship, cut, or ship-with-caveat — alongside the byte
   cost.

**Report failure honestly.** Failing cheap here is the entire point of the loop. A technique that
fails prototyping does not reach Gate B: it does not get proposed, promised, or built anyway on the
theory that it comes together in integration. Failing here costs one file and twenty minutes.
Failing later costs the section, the layout designed around it, and the copy written to fit. That
asymmetry is the reason the loop exists.

---

## The two-tier performance budget

`§11` in practice. Two tiers, and the boundary between them is not negotiable.

| | Tier 1: Shell | Tier 2: Heavy |
|---|---|---|
| Budget | Under 100KB total | Declared per run at Gate B |
| Contains | HTML, critical CSS, subset fonts, minimal JS, everything in **CSS and SVG native**, **information design**, and **icons** | Everything in **Rendering and GPU** and **Post-processing**, physics solvers, generated imagery |
| Must | Paint something real alone, with no JS at all | Load after first paint |
| LCP | Under 1.5s | Never in the LCP path |
| If it fails | The run fails | The surface still works |

A gradient hero, an SVG filter, a clip-path reveal, and a `@property` animation all sit in tier 1
and cost close to nothing.

Restated as build rules: hero image preloaded, correctly sized, modern format, explicit dimensions.
Fonts self-hosted, subset, `font-display: swap`, preloaded if they are in the LCP element. Every
third-party tag deferred and consented. No layout shift after paint — reserve space for everything
that arrives late, including the consent banner. **Measure on a throttled mid-range Android, not on
the machine you built it on.** The throttle is CDP `Emulation.setCPUThrottlingRate` at 4× where the
harness exposes CDP; without it no throttled number exists, and every frame-rate evidence label caps
at PARTIAL with that reason written into the verdict.

### Deferring a heavy scene

1. Ship a **static poster** in the shell — a gradient, an SVG, or a treated still from the scene
   itself, composed and art-directed. It is what the LCP measures.
2. Load the scene module dynamically after first paint: `import()` behind `requestIdleCallback`, or
   behind the intersection gate below.
3. Cross-fade the canvas over the poster when the first frame is genuinely ready, rather than when
   the module resolves.
4. If the load fails, the poster stays. That is the `§10` fallback already in place, at no extra
   cost.

### Intersection gating

Nothing below the fold initializes before it is near the viewport. Nothing off-screen keeps running.

- Instantiate on intersection with a `rootMargin` of roughly one viewport.
- Stop the render loop when the canvas leaves the viewport. Restart on re-entry.
- Stop on `visibilitychange` when the tab is hidden.
- Cap the pixel ratio at `Math.min(devicePixelRatio, 2)`, lower on large canvases.

One unthrottled always-on render loop drains a laptop battery and undoes every other performance
decision in the run. On a tool-shaped surface it does that for eight hours a day.

**A technique that cannot be deferred has to justify its bytes**, at Gate B, against the goal. In
the shell it competes directly with the fonts and the copy, and it wins only by being the thing the
surface is about. Usually the honest answer is the tier-1 technique that gets 80% of the effect for
2% of the weight, and that group is the largest one in this file.

---

## Libraries

Free rein while prototyping. Pull any of these from a CDN and move fast.

| Library | What it is for | Rough weight |
|---|---|---|
| three.js | The general-purpose 3D engine. Scene graph, loaders, materials, post-processing | ~600KB min, ~150KB tree-shaken |
| ogl | Minimal WebGL. Same primitives, far less surface | ~40KB |
| GSAP + ScrollTrigger | Timelines, easing, and scroll orchestration. Still the most reliable sequencer | ~70KB combined |
| Lenis | Smooth scroll that keeps native scroll semantics | ~10KB |
| Motion | Spring-first web animation on the WAAPI | ~20KB, ~5KB mini |
| Matter.js | 2D rigid-body physics | ~90KB |
| Rapier | Rust and WASM physics, 2D and 3D, fast | ~500KB WASM |
| p5 | Creative-coding sketches, fastest path to a generative idea | ~900KB |
| regl | Functional WebGL. Excellent for pure shader work with no scene graph | ~30KB |
| Theatre.js | Visual sequencer with a real editor, exports JSON | ~150KB, editor dev-only |
| Lottie | After Effects animation playback | ~250KB plus JSON |
| Splitting | Splits text into per-character and per-word elements | ~5KB |
| curtains.js | DOM elements mapped to WebGL planes with shaders | ~60KB |
| PixiJS | Fast 2D WebGL renderer. Particles, filters, sprites | ~400KB |
| TSL / three-shader-language | Node-based shaders authored in JS, compiles to WebGL and WebGPU | Part of three.js |

Weights are approximate and exist so the tier decision is informed. Check the real number for the
version you pull and record it in `DIRECTION.md` next to the technique it serves.

### The hard rule

**Every library gets downloaded, committed, and self-hosted before ship.** `§7`, no exceptions.

- Vendor the exact built file used in the prototype. Pin and record the version.
- Remove every CDN `<script>` and `@import` before the build passes complete.
- Grep the built output for `unpkg`, `jsdelivr`, `cdnjs`, and `googleapis`. A hit is a build
  failure.

A dead CDN takes the surface down with it, permanently, on someone's name, years after anyone is
watching. Vendoring is a one-time cost that buys against that forever.

---

## When the technique is wrong

`§5` enforcement. The work is the hero, and this is the file most likely to forget it.

**If the technique is more memorable than what it frames, the technique is wrong.** Not overtuned,
not slightly heavy. Wrong. Remove it.

**If it does not serve the direction recorded at Gate A, cut it.** However good the prototype was,
however long it took. A raymarched hero on a subject whose intake says quiet, editorial, and precise
is a failure with excellent frame rate. The prototype budget was spent to learn this cheaply, and
the learning only pays if you act on it.

**Impressive and irrelevant is still a failure.** Page-shaped, it is a surface nobody can fault and
nobody can describe the subject from. Tool-shaped, it is a surface that impressed the buyer in the
demo and costs the operator four seconds a hundred times a day, which is the only design failure in
this file that compounds.

Skipping is allowed, silent degradation is not (`§16`). If the human declines a technique's proper
state, record the cost in `DIRECTION.md` as a decision — *"reduced-motion still not art-directed,
ships as a plain freeze"* — state it once, accept the answer, and carry it into the run's
confidence.

---

## Invention

The arsenal is a floor. Everything on it has been done, and a run that only executes from this list
produces competent work that pattern-matches to something.

**Combining two techniques into something unnamed is the highest-value move available.**
Reaction-diffusion as a displacement map. A gooey SVG filter driven by scroll velocity.
Variable-font axes wired to an audio analyser. Marching squares over the alpha of live DOM text.
Container queries switching which shader a component runs. A grade axis animating with the icon's
own state change. Combinations are where `§1`, `§2`, and `§3` get satisfied, because nobody else did
that one. Ways in:

- Feed a technique from one group into a technique from another.
- Apply a heavy-layer idea with a tier-1 tool and find out what the constraint forces.
- Use a technique for the thing it is worst at, deliberately.
- Take the standard combination and invert which layer drives which.
- Take a technique the page-shaped half takes for granted and put it on a tool-shaped surface, or
  the reverse. Most of the unclaimed ground is on that boundary.

Record every invention in `DIRECTION.md`: what was combined, what it produces, what it cost, and the
three answers from the test at the top of this file. That entry is what `§3` asks for when it
requires every run to state what it did that nobody else did.
