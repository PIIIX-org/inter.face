# Styles

This file is the visual vocabulary: **what an interface looks like**. `CRAFT.md` is the
technique arsenal: **how you render it**. They are separate on purpose, and collapsing
them is how runs end up templated. Techniques carry no opinion — `backdrop-filter` builds
the layered translucency of liquid glass and the flat frosted panel of a Swiss layout
where the blur is the only softness on the page. The style is the opinion; the technique
is a means of getting there.

**Read row 1 of `TRANSLATE.md` before anything below.** A style means two different things
depending on the surface class.

On a **page-shaped** surface — read for seconds, once — the style is a claim, and it is
read before a single word is. A viewer decides whether this looks like something credible
before they have parsed the headline, and they are not wrong to. Style choice is a trust
decision as much as a taste one, and the failure mode is looking like the category.

On a **tool-shaped** surface — read for hours, daily — the style is paid for every day by
the same person. Whitespace stops being the luxury and rows-per-screen becomes it
(`TRANSLATE.md` row 2). Density is a feature; a marketing site's spacing scale applied to
an operations table turns one screen of work into six scrolls. The failure mode has its own
name, from systemcicy:

> The generic admin template is the failure mode. An operator can tell inside a minute
> whether anyone thought about their job.

The same family can serve both classes, but an entry that reads well page-shaped can be
structurally incapable of holding a tool-shaped surface. That is what
[Style under density](#style-under-density) exists to catch, and it is checked before
Gate A, not at build.

The order is fixed. **Style is chosen at Gate A with the direction**, from `TRANSLATE.md`.
**Techniques are assigned in Loop 2 to serve the style already chosen.** Reaching for a
style because you want to use a shader is the tail wagging the dog, and it shows in the
output. Everything below is a starting position under `§3`. Read
[the guardrails](#the-guardrails) before you pick.

---

## Before the list: derive, don't pick

This section runs **first**, before the families below are consulted at all. The order is
the point.

> **Do NOT pick from a fixed catalog.** The right three directions for this subject are
> not the same as the right three for another, and **picking from a list is itself the
> training-data reflex** — the model reaches for "Swiss-grid, Terminal,
> Industrial-signage" every time, because those are the furthest-from-editorial items in
> any enumerated list.
>
> Instead, work from the subject:
>
> 1. Read the **archetype words** from `TRANSLATE.md` row 4. What physical, spatial, or
>    material experiences would embody those words if design were not involved? (A
>    personality described as "specific, earned, unmistakable" evokes a hand-stamped
>    letter, a numbered print, a watchmaker's loupe.)
> 2. From those physical experiences, derive **three visual directions** genuinely
>    different from each other.
> 3. Avoid the reflex-reject lanes. Don't trade one monoculture for another. **If you find
>    yourself reaching for "Swiss-grid" or "Terminal" by reflex, you are pattern-matching a
>    catalog in your training data, not reading the subject. Start over from the archetype
>    words.**
> 4. Each direction must be expressible in **one concrete sentence naming a real-world
>    referent** — "a museum exhibition label system for a contemporary art gallery," not
>    "clean and minimal." **If your sentence contains only adjectives, it is not concrete
>    enough.**

The concreteness test in step 4 is the one that does the work. "Clean, modern,
professional" is three adjectives and no decisions; "the departure board of a station that
was refurbished once, in 1974" decides type, palette, motion, and the sound of the copy in
one sentence.

The shadow from row 4 is the other half. The archetype names the target and the shadow
names the failure of hitting it too hard — "confident, understated" with "sterile, cold"
underneath. A direction that has no answer for the shadow is the archetype at full volume,
which is the most common way a defensible direction becomes an unpleasant one.

**Then, and only then,** read the families. They are there to name what you derived, to
tell you what it implies technically, and to warn you how it fails — not to generate it.
An entry you arrived at by derivation and an entry you picked off the list look identical
on the page and different on the screen.

## Picking one

The derivation produces three directions. These five inputs **cut**; they do not generate.
A shortlist that starts here is a shortlist that started in a catalog.

1. **Category cluster** — what every comparable surface already looks like. Page-shaped:
   the competitors a viewer saw this morning. Tool-shaped: the other tools already open in
   this operator's other tabs. That is the fence, not the field
2. **The empty position** — what nobody in the category looks like, that this subject or
   product could credibly be
3. **Anti-positioning** (`TRANSLATE.md` row 5) — styles banned outright. Honor absolutely.
   Row 5 sits on `BREAKING.md`'s never-breakable list alongside `§10`, `§15`, and `§16`
4. **The viewer's risk appetite** — a procurement committee buying infrastructure and a
   founder buying a design sprint tolerate different amounts of strangeness. Tool-shaped
   inverts the question: an operator's tolerance is high for anything that removes
   keystrokes and near zero for anything that costs them a habit they already have
5. **What is already owned** (`TRANSLATE.md` row 6) — load-bearing elements are
   constraints, not suggestions. If row 6 names a design system the subject must conform
   to, `TRANSLATE.md`'s escape hatch applies and this file is not the right one to be
   reading

Never one answer. Bring **three directions** to Gate A (`§4`), each with its concrete
sentence and each labelled with what it would cost.

## Category clichés — the fence, not the field

What the viewer has already seen five times this morning. `§2` and `§3` mean none of these
is available unmodified. Check the subject's category before Gate A.

**Page-shaped:**

| Category | The cliché | Why it persists | The opening |
|---|---|---|---|
| **B2B SaaS** | Purple-to-blue gradient, isometric illustration, centered hero, three cards, a logo bar | Every template ships it | Real product UI at working resolution (`§5`), editorial structure, visible pricing |
| **Agency / studio** | Full-bleed dark video, oversized rotating type, a horizontal case-study rail, a cursor dot | It signals membership in the agency club | Work at depth, the process, a stated refusal, actual results with numbers |
| **AI product** | Purple glow, particle mesh, gradient orb, "powered by AI", a chat bubble | The category copies itself faster than it ships | Show the output. The demo is the differentiator, and almost nobody ships one |
| **Fintech** | Blue, a phone mockup at an angle, abstract nodes, a padlock icon | Trust-by-convention | Real numbers, real regulation named, real screens |
| **Developer tool** | Dark terminal hero, a code block, monospace everything | Native credibility, and now noise | Show the failure it prevents. Benchmark honestly. Docs as the marketing site |
| **Healthcare** | Stock clinician, soft blue-green, rounded everything, hands | Regulatory caution flattened into blandness | Specificity about the condition, the workflow, the outcome |
| **Ecommerce brand** | Hero lifestyle shot, three-up product grid, a countdown bar | Platform themes | Product at obsessive resolution, the making, the material |
| **Professional services** | Handshake photo, a serif wordmark, "trusted advisors" | Risk aversion | Named people, named outcomes, an opinion someone could disagree with |
| **Local service** | Template with a stock van, a five-star widget, a phone number in a banner | Whoever built it charged £400 | Real photos of real work, a real person, real prices |

**Tool-shaped.** The parents never tabulated these, and they are the ones a tool-shaped run
actually walks into:

| Category | The cliché | Why it persists | The opening |
|---|---|---|---|
| **Internal tool** | Left nav, breadcrumb, page title, a card wrapping a table, an "Add New" button top-right in the framework's default blue | Nobody's promotion depends on it, and the starter template shipped it complete | Design the day, not the screen. Write the operator's day as a sequence with counts, then give the action performed forty times the layout and let the one performed once be plain |
| **Admin panel** | Every entity gets the same generated list-detail-form triple, every list is the same table, and CRUD ordering decides the information architecture | Scaffolding generated it from the schema, so the interface is a picture of the database | Model the operator's verbs, not the tables. Merge the entities nobody thinks about separately; give the one they live in all day a real screen of its own |
| **Analytics dashboard** | A 3×3 grid of chart cards, four big numbers across the top, a date-range picker top-right, and one chart nobody has ever read | Every charting library's demo page is exactly this, and it photographs like work | One question per screen, and every number carries its comparison — up from what, good or bad. A number with no comparison is decoration with a monospace font |
| **Developer console** | Dark theme, monospace everything, terminal-green accent, a code block in the hero of the settings page | It reads as native credibility to the people who build it, who are not the people who use it | The credibility is in the error message, the empty state, and the keyboard path (`§15`). A console can be light, humanist, and entirely for developers |

Being the only surface in the category that shows a price, ships a working demo, names a
person, or completes its main job without the mouse is worth more than any visual move on
this page.

---

## Surface and material

**Glassmorphism.** Translucent panels over a substrate worth seeing through to, legible
from the blur behind them, never from a fill. Depth reads as blur radius, nearest layer
blurring hardest, each panel edged with a 1px light-catching border. **Implies**
`backdrop-filter`, z-layering, `color-mix()` borders. **Fails** as gray rectangles on a
flat background, and breaks `§10` under body copy. **Right when** the background is itself
content.

**Liquid glass.** Apple's 2025 material language, where the panel refracts rather than
merely blurs: content bends passing under the edge, specular highlights track the light,
the shape lenses on scroll. Real implementation is an SDF and shader job; `backdrop-filter`
alone gets glassmorphism with a borrowed name. It is a functional layer that floats above
content to hold navigation and controls, never a treatment applied to the content layer,
and it is never stacked on itself. **Implies** WebGL, an SDF panel, scroll-linked light, a
hard `§11` budget. **Fails** as chrome that buries the work (`§5`). **Right when** the
subject or product is material or hardware.

**Neumorphism / soft UI.** Every element extruded from one background hue by a matched
shadow pair, dark and light, cast from a single committed angle. No borders and almost no
color: form is entirely shadow, in one narrow tonal band. It fails contrast by default and
ships only with the fix in [Style and accessibility](#style-and-accessibility). **Implies**
dual `box-shadow`, one hue. **Fails** as putty with invisible affordances. **Right when**
exactly one object is extruded and the rest is flat.

**Claymorphism.** Inflated rounded volumes with large radii, soft occlusion at the base, a
bright saturated palette, and heavy rounded type. Objects read as pressable toys with
thickness, lifted by a diffuse colored shadow. **Implies** big `border-radius`, layered
colored shadows, spring press. **Fails** as childish, which sinks a senior claim faster
than anything else on this page. **Right when** the audience is consumer and the copy stays
serious.

**Skeuomorphic revival.** Real material simulation, never nostalgic gloss: paper with
visible fiber, ink bleeding into it, embossed metal with a directional brush, edges worn
where a thumb rests. One material, simulated honestly. **Implies** generated textures per
`§8`, displacement maps, per-material lighting. **Fails** as 2010 iOS pastiche the moment
two materials share a surface. **Right when** the thing has a physical antecedent.

**Aerogel / frosted depth.** Milky diffuse layers with no light source, where depth reads
as accumulated haze and nothing has a hard edge. Separation comes from density, the palette
stays desaturated, light bleeds between planes. **Implies** stacked low-opacity fills,
large soft blurs, a fog gradient. **Fails** as washed-out mush when every layer sits at one
density. **Right when** hierarchy rides on type alone.

## Structural

**Swiss / International.** A visible modular grid, one family at a strict scale, flush-left
ragged-right setting, objective photography on grid intersections. Whitespace is
structural, color appears once, every alignment is provable against the column. **Implies**
CSS Grid with named lines, a mathematical scale, one `§6` accent. **Fails** as an agency
template, the most-copied system in design. **Right when** dense work needs an authoritative
frame, with a collision applied.

**Brutalism.** Raw HTML honesty: system fonts, default link blue, visible borders, unstyled
form controls, layout that reveals the DOM instead of disguising it. **Implies** near-zero
CSS, system font stacks, native controls, no motion. **Fails** as an excuse for laziness,
indistinguishable from an unfinished build. **Right when** credibility comes from substance
and refusing to decorate is the position.

**Neo-brutalism.** Thick black borders, hard offset shadows with no blur, saturated flat
blocks, heavy grotesque type at aggressive sizes. Elements rotate slightly and overlap
without softening; interaction moves the shadow, never fades anything. **Implies** solid
`box-shadow` offsets, 2–4px borders, transform on hover. **Fails** as Gumroad cosplay, the
most saturated style on the web right now. **Right when** the collision partner supplies
the restraint.

**Bento.** A dense grid of unequal self-contained cards sized by importance rather than
content length, uniform radii, consistent gaps, reading as one object at a glance.
**Implies** CSS Grid with spanning areas, container queries, per-card art direction.
**Fails** as a dashboard with nothing to show, and hides narrative because every card is
equal in reading order. **Right when** many small things matter at once.

**Editorial / print.** Magazine mechanics carried honestly onto screen: measured columns,
real hyphenation, drop caps on the baseline grid, pull quotes breaking the measure,
marginalia, running heads and folios. Type does the work; images are plates. **Implies**
`hyphens`, `text-wrap: pretty`, `initial-letter`, a serif with optical sizes, self-hosted
per `§7`. **Fails** past a 75-character measure, or when columns force scroll-up reading on
mobile. **Right when** the reading is long and someone will actually do it.

**Swiss-punk / Ray Gun.** The Swiss grid built, then deliberately violated: type
overlapping, rotated, set in conflicting families, letters cropped by the viewport. Type
becomes image and legibility becomes a variable the designer controls. **Implies** absolute
positioning over a grid, `mix-blend-mode`, variable-font extremes. **Fails** as noise when
the grid was never built, since the violation only reads against visible order. **Right
when** the audience reads sophistication.

## Atmospheric

**Cinematic dark.** A single key light with real falloff, deep vignette, grain sized to the
viewport, blacks lifted and tinted. Content sits in pools of light and the space between
them is genuinely dark. **Implies** radial key, grain shader or SVG turbulence, LUT via
`feColorMatrix`, controlled bloom. **Fails** when the grade crushes body copy below 4.5:1
and grain eats small type. **Right when** the subject benefits from being lit.

**Aurora / mesh gradient.** Large soft color fields drifting across each other with no
visible edges and no repeat. OKLCH interpolation keeps midpoints saturated instead of gray,
and motion is slow enough to be felt without being watched. **Implies** OKLCH gradients,
canvas or WebGL mesh, grain against banding. **Fails** as the default AI landing page, the
most generated look of the last three years. **Right when** it is a substrate for another
style, or generated from something real.

**Glow / neon.** A dark substrate with emissive accents that actually bloom, light spilling
past its source and tinting what it lands on. Edges glow from the inside, shadows take the
accent hue, two emissive colors at most. **Implies** layered `box-shadow` bloom or a real
bloom pass, dark tokens, hue-matched shadows. **Fails** as halation that makes every string
of text fringe. **Right when** the emission points at the work.

**Vaporwave / Y2K.** Chromed type with environment reflection, cyan and magenta gradient
meshes, CRT scanlines and phosphor bleed, grids receding to a horizon, deliberate JPEG and
VHS artifacts. The nostalgia is specific to 1995–2003 hardware and reads as costume unless
committed to fully. **Implies** SVG chrome gradients, a CRT shader, chromatic aberration,
dithering. **Fails** as kitsch that dates the subject. **Right when** the audience shares
the reference.

**Solarpunk.** Organic growth forms and botanical geometry under warm optimistic light:
curves derived from phyllotaxis, never arbitrary blobs, terracotta and sage and brass,
layouts that branch instead of stacking. **Implies** generative SVG growth, warm gradients,
curved layout paths, organic easing. **Fails** as generic eco-branding with a leaf icon and
a green button. **Right when** the domain is climate, agriculture, health, or civic.

## Motion-native

In these four the behavior **is** the aesthetic. A still screenshot cannot represent them,
which makes the designed reduced-motion state under `§10` a first-class deliverable rather
than a fallback.

**Kinetic.** Nothing is at rest: type in perpetual motion, marquees running at different
rates by depth, letters responding to pointer velocity, composition recomposing
continuously. Stillness is used once, as punctuation. **Implies** scroll-velocity input,
variable-font axis animation, transform-only compositing. **Fails** as exhausting, and
unreadable when the thing in motion is the thing being read. **Right when** the subject is
performance or sound.

**Physics-world.** Spring, inertia, mass, and collision are the interaction model. Elements
have weight, throwing them works, they settle rather than snap, and they occupy space other
elements respect. Nothing uses a duration; everything uses a stiffness. **Implies** a
physics loop, spring tokens instead of easing curves, a valid resting layout. **Fails** as
a toy when the physics never resolves into something readable, and the novelty is gone in
eight seconds. **Right when** the play makes a point.

**Scroll-cinema.** The surface is a film reel scrubbed by the scrollbar: scroll position
maps to a timeline, sections pin while their contents advance, and the sequence has shots,
cuts, and cadence. **Implies** pinned containers, scrubbed timelines, `will-change`
discipline, a real `§11` budget. **Fails** as hijacked scroll that fights the user and
strands anyone landing mid-page — and skimmers skim. **Right when** the content has
narrative order and one story to tell.

**Spatial / 3D-world.** The surface is a navigable space with camera, depth, and position.
Sections are places, navigation is movement, and the sense of where you are does the work a
menu usually does. **Implies** WebGL or CSS 3D, a camera rig, level-of-detail, a no-WebGL
fallback per `§10`. **Fails** as a maze where nobody finds the thing they came for, which
is `§5` violated structurally. **Right when** a flat surface would misrepresent the subject.

## Technical and data

**Terminal.** Monospace throughout on a real fixed cell grid, blinking block cursor,
phosphor color on near-black, scanlines and slight CRT curvature at the edges, output
persisting in scrollback. **Implies** `ch` units, a monospace with box-drawing coverage, a
CRT shader, typed-output timing. **Fails** as a gimmick with a fake prompt that takes three
commands and breaks on the fourth. **Right when** the terminal is where the work actually
happens.

**Blueprint.** Drawing conventions applied literally: dimension lines with arrowheads and
measurements, section callouts, leader lines to annotations, hatching, a title block, a
consistent line-weight hierarchy. **Implies** SVG line work, precise stroke tokens,
annotation positioning, a drafting typeface. **Fails** as decoration when the dimensions
are fake and measure nothing. **Right when** the callouts annotate something real.

**Data-brutalist.** Dense tables, sparklines, and charts as the aesthetic itself, never as
supporting evidence. Rules are hairlines, numbers tabular, alignment decimal, and the
interest comes from the density of true information. **Implies**
`font-variant-numeric: tabular-nums`, table semantics, inline SVG charts. **Fails** the
moment the numbers are decorative — invented figures on a chart are `§9` slop with a grid
behind them. **Right when** every number on the surface traces to something real.

**Wireframe / vector.** Line art only: no fills, hidden-line removal, contours describing
volume through stroke alone, weight variation carrying depth. **Implies** SVG or WebGL line
rendering, hidden-line computation, stroke-only tokens, draw-on animation. **Fails** as
thin and cold at sizes where strokes vanish. **Right when** the subject is structural and
the outline is the honest view.

## Textural

**Risograph.** Two or three spot inks printed in separate passes with visible
misregistration, halftone dots in the shadows, paper grain showing through, and overprint
areas producing a third color neither ink has. **Implies** separated channels,
`mix-blend-mode: multiply`, per-channel offset, a halftone shader, paper generated per
`§8`. **Fails** as a filter when the misregistration is uniform, since real registration
error drifts. **Right when** the subject prints.

**Xerox / degraded.** Photocopy artifacts as the medium: blown highlights, crushed blacks,
toner scatter at the edges, a slight skew, and generational loss where a copy of a copy has
lost its midtones. **Implies** threshold and dither passes, noise displacement, per-element
skew, a high-contrast duotone. **Fails** as illegible on body copy instead of on images and
headers. **Right when** the work is zine or archival.

**Collage.** Layered scraps at mixed scale with torn edges, tape and staples, cast shadows
from real height differences, elements rotated off axis. The composition is assembled,
never laid out. **Implies** irregular SVG masks, per-element shadow and rotation, generated
paper and tape, deliberate z-order. **Fails** as chaos with no reading order, which loses
`§10`'s semantic structure immediately. **Right when** the practice is genuinely
multidisciplinary.

**Ink / sumi.** Brush dynamics as the whole language: strokes with real pressure variation,
wet bleed into fiber, dry-brush breakup at speed, negative space treated as the subject.
One color, one gesture per composition. **Implies** SVG variable-width paths, bleed via
displacement, generated fiber, stroke-order animation. **Fails** as a stock brush texture,
which reads as clip art instantly, and as decoration the moment there are two gestures.
**Right when** restraint is the position.

## Reductive

**Radical minimalism.** Type and space, nothing else: no borders, no cards, no shadows, no
illustration. Hierarchy comes only from size, weight, and distance, and the whitespace is
measured, never left over. **Implies** one family with real weights, a precise spatial
scale, optical alignment, single-property motion. **Fails** as unmemorable when the copy is
weak, since there is nothing else to look at. **Right when** the writing is strong.

**Monochrome plus one accent.** A single hue's full tonal range carries structure, and
exactly one accent sampled from reality per `§6` appears only where attention must go. The
accent never decorates. **Implies** an OKLCH lightness ramp, one accent token defined as a
[paired token](#paired-color-tokens), usage rules stated in `DIRECTION.md`. **Fails** as
forgettable, the most common way a run looks competent and generic at once. **Right when**
it is the discipline layer under a louder partner.

**ASCII / text-only.** The surface is characters: art drawn in a fixed cell grid, layout
built from box-drawing glyphs, images dithered into character density. Nothing is rendered
that could not be pasted into a text file. **Implies** monospace with full box-drawing
coverage, `ch` and `lh` units, semantic HTML underneath per `§10`. **Fails** as unreadable
to screen readers and unusable below 400px. **Right when** the constraint is the point.

---

## Style under density

Every family gets one line on what it does holding forty rows of real data. This is asked
**at Gate A**, before a single image generates, because the answer is sometimes *it
cannot* — and that is a finding worth having before the direction is approved rather than
at build with the images already signed off.

| Family | Holding forty rows |
|---|---|
| **Surface and material** | Every panel costs a blur pass and a border, so forty translucent rows is forty compositing layers and a scroll that stutters. It survives only if the material stops at the container: one glass shell, opaque rows inside it. The style becomes the frame, never the row |
| **Structural** | The family that holds density natively — Swiss and bento are grids already, and a table is a grid with the lines turned on. Editorial is the exception inside it: a 75-character measure and forty rows are different objects, and one of them has to lose |
| **Atmospheric** | Mood is made of falloff, and forty rows inside a falloff means the bottom eight are unreadable. Confine the grade to the shell — header, rail, empty state — and put the data on a flat, evenly lit substrate |
| **Motion-native** | Forty rows means forty animations, which is either a stagger nobody can read past or a frame budget nobody can hit. Motion moves to the transitions *between* states and never onto the rows themselves |
| **Technical and data** | Built for it. Data-brutalism at forty rows is the style operating at its designed load; terminal holds it as scrollback and blueprint as a schedule. Here density is the aesthetic, so more is more |
| **Textural** | Texture at row scale reads as noise and eats the smallest type on the screen. Paper, ink, and toner belong to the substrate around the table; inside it, hairlines only |
| **Reductive** | Usually the honest answer is no — see the second worked answer below. Monochrome-plus-accent is the one that survives, because a tonal ramp *is* a hierarchy mechanism and forty rows need exactly that |

**A collision inherits the stricter parent's density answer.** The table indexes single
families and every derived direction is a collision of two — when the parents' rows
disagree, the stricter one wins, so no run invents its own arbitration.

**Worked answer one — bimodal density.** `industrial-brutalist-ui` is the only skill in the
audited corpus that answers this question at all, and its answer is good:

> **Bimodal Density:** Layouts oscillate between extreme data density (tightly packed
> monospace metadata clustered together) and vast expanses of calculated negative space
> framing macro-typography.

The mechanism worth stealing: density is not a global setting, it is per zone. The vast
negative space elsewhere is what makes the dense zone read as deliberate rather than
cramped — remove it and the same table reads as an unstyled dump.

**Worked answer two — some styles simply cannot.** `minimalist-ui` specifies 24–40px
internal card padding, a 1.6 line-height, and a `max-w-4xl` container. Those three numbers
together mean it cannot hold forty rows at all: the padding alone puts roughly six rows on
a screen, and the max-width caps the columns before the data is described. This is not a
criticism of the style — it is an excellent page-shaped style — it is the shape of the
finding. A direction can be beautiful, coherent, correct for the archetype, and
structurally incapable of the surface it was chosen for.

**The rule.** Every run writes this line for its chosen direction in `DIRECTION.md`, in the
form *at forty rows this does X*. If the answer is "it cannot," say so at Gate A and either
change the direction or fork it — the shell in the chosen style, the data region in a
family from the row above it that holds density. Naming the fork is a decision; discovering
it during the build is a rewrite.

## Reveal, don't stretch

The layout failure that survives every style choice, named by Material's own guidance:

> **Additional space doesn't just mean making the same thing bigger.**

That is the stretched-phone-layout failure stated by the primary source, and the escape is
stated there too: extra width **reveals** rather than **stretches**. A collapsed navigation
rail expands. A second pane appears showing what was previously a separate screen — a
messaging list gains the conversation beside it. Material's pane counts run from one at
compact through two recommended at expanded and large to three at extra-large; the numbers
and the breakpoints live in `SURFACES.md`.

**Page-shaped.** Extra width reveals what a phone had to hide: the marginalia moves out of
the flow and into the margin, the plate returns to its native crop, the index that was a
disclosure becomes a persistent column. It never widens the measure past its own limit —
a 1400px viewport does not get a 1400px line of body copy, and a single column floating in
two empty halves is the stretch failure wearing whitespace as a disguise.

**Tool-shaped.** Extra width is where a tool earns its day. The rail goes from icons to
icons-with-labels. The list gains its detail pane, so selecting a row stops being a
navigation. The filter panel stops being a sheet and becomes furniture. Three panes at
extra-large is a real layout with its own reading order, not a two-pane layout with more
air in it.

**The test, at every step up:** name what appears. If nothing appears and everything got
bigger, the layout stretched.

---

## Collision

This is the most important section in the file. A single named style is one search away
from being everyone else's interface. The un-templated work lives where two styles are held
in tension, because the constraints of one force the other to behave in ways its own
tradition never asks of it.

| Collision | What it produces that neither parent has |
|---|---|
| **Liquid glass over a blueprint substrate** | A technical drawing is flat and authoritative by convention. Put a refractive lens over it and the dimension lines bend as you scroll, so precision becomes something you look *through*. The drawing gains depth without losing its claim to accuracy |
| **Risograph texture on a Swiss grid** | The grid asserts machine order; the misregistration asserts a hand and a press. Together they read as a printed object instead of a rendered page, and the grid stops looking like every other agency site because it is visibly ink |
| **Terminal chrome around a physics world** | The monospace frame promises determinism and fixed cells. The contents obey springs and collide. A frame that cannot bend around contents that will not sit still is the whole idea, and neither style contains it alone |
| **Editorial print with a spatial 3D reveal** | Columns, drop caps, marginalia, then the page turns out to have depth and the columns are planes standing in space. Reading becomes navigation and the reader's position in the document becomes literal |
| **Brutalist structure with a cinematic grade** | Raw exposed structure and system fonts, lit with a single key and a vignette. The honesty stops reading as unfinished and starts reading as staged, a claim neither raw HTML nor a film grade makes on its own |
| **Neumorphism inside radical minimalism** | The style that normally fails by covering a surface in soft mush is reduced to one extruded object in an empty field. It becomes sculptural, and the contrast failure disappears because nothing has to be read off it |
| **Ink gesture across data-brutalism** | Dense tabular numbers with one brush stroke laid over them. The gesture asserts that a person read these numbers and had a view, which a table cannot say and a painting cannot evidence |
| **Vaporwave chrome under Swiss typography** | Y2K materials disciplined by an unforgiving grid and one type family. The nostalgia survives, the kitsch collapse does not, because the layout refuses to join in |
| **Archival index with cinematic detail reveals** | The list is a dry catalogue with dates and reference numbers; opening one drops into a graded, lit scene. The restraint of the index is what makes the reveal cost something |
| **Data-brutalist rows inside an editorial shell** | The tool-shaped collision. Forty rows at their designed density, framed by real running heads, a stated measure, and marginalia that annotates the table. It says *this data was edited*, which neither a spreadsheet nor an article can claim alone |

**Picking a collision that serves the brief.** One parent comes from the archetype in
`TRANSLATE.md` row 4. The other comes from something materially true about the subject:
their medium, their tools, the physical object the work becomes, the room it happens in.
Both must be defensible in one sentence each against `TRANSLATE.md`. If only one is
defensible, you have a style plus a decoration, and the decoration reads as arbitrary to
everyone who sees it.

**The load-bearing rule:** one parent carries structure, the other carries surface. Two
structural parents fight over the grid and produce mush. Two surface parents produce noise
with no bones. Name which parent is which in `DIRECTION.md` before you build anything. It
is the most common way this technique fails.

## Subversion

The second route out of template. Take one style and break exactly one of its own rules,
and the rule you break has to be the one the style is most identified by. Break two and you
have a different style executed badly.

- **Swiss where one element never obeys the grid.** A single plate hangs past the margin in
  every section, at the same overhang each time. The grid is provable everywhere else,
  which is what makes the overhang read as a decision.
- **Brutalism with immaculate type.** Everything raw, default, unstyled, except the
  typography, which gets real optical sizing, hyphenation, and hung punctuation. The
  refusal to decorate becomes selective and therefore intentional.
- **Cinematic dark that turns the lights on once.** One section drops the grade entirely
  and goes flat daylight white. The return to darkness afterwards hits harder than the
  darkness ever did alone.
- **Glassmorphism with no blur.** The panels refract and catch light at their edges and
  nothing behind them softens. Legibility improves, `§10` gets easier, and the material
  reads as harder and more precise than glass usually does.
- **Editorial print where the margin is the main column.** Marginalia carries the primary
  narrative and the body text becomes the aside. The reader learns a new hierarchy in about
  four seconds and remembers it.
- **Terminal with one full-color photograph.** Everything is phosphor and monospace except
  a single image at full fidelity. It becomes the most important object on the surface with
  no layout emphasis at all.
- **Bento where one tile is thirty times the others.** The style's law is that tiles are
  equal citizens. Break it once and the layout acquires the hierarchy the family normally
  cannot express.

State the broken rule explicitly in `DIRECTION.md`. A subversion nobody can name is
indistinguishable from an inconsistency.

## The guardrails

This section is `§3` enforced.

- **The vocabulary names a starting position, never a destination.** Ship a named style
  unmodified and the run failed. No entry above is a finished answer.
- **Every run states in `DIRECTION.md` what it did to the style that nobody else does** —
  the collision, subversion, or invention applied, in one sentence a stranger could check
  the built surface against.
- **The three-second feel beats the style.** If `TRANSLATE.md` row 3 says "quiet, like a
  printed book," liquid glass is off the table regardless of how good the prototype looks.
  A prototype is not an argument against the intake.
- **The archetype pulls a shortlist, never a single answer.** Row 4 narrows the field to
  three or four candidates. Treating it as a lookup table is how every Sage becomes Swiss
  and every Creator becomes neo-brutalist — the catalog reflex with an extra step.
- **Anti-positioning bans styles outright.** If row 5 says "never look like a crypto
  product," glow-neon and chrome are gone. Honor it absolutely.
- **Never let a style hide the primary action, the price, or the product.** `§5`. On a
  tool-shaped surface, never let it cost the keyboard path either (`§15`).
- **Never ship a style that fails contrast and call it art direction.** `§10` is
  **[HARD]**.
- **The list is open.** Invent one, name it, describe it in the format above, and add it to
  the run. An invented style with a real name and stated mechanics beats the best-executed
  entry on this page, because nobody can pattern-match it.

## The counterweight: restraint is not automatically the safe answer

Most of this file fights the reflex toward the loud, expected style. The opposite reflex is
just as real and much less examined: when unsure, strip it back, ship the quiet version,
and call the result clean. There is exactly one usability-grounded argument against that
reflex worth citing, and it comes from Google.

Google states that Material 3 Expressive is its most-researched design-system update since
Material launched in 2014 — **46 separate research studies with more than 18,000
participants**, testing hundreds of variants over roughly three years. The result it
reports from eye-tracking: participants located key UI elements **up to 4× faster** in the
expressive designs than in the Material 3 baseline, with the "send email" button as the
worked example, across ten apps built in both versions and shown in random order.

Two honesty notes that ship with the number. These are Google's own self-reported figures
about its own system, not independently audited or replicated — cite them as *Google
states*, never as settled fact. And Expressive is an additive layer on Material 3, not a
successor to it; Google is explicit that M3 is not deprecated and that this is not "M4."

The reading that matters here: **emphasis is legibility.** Contrast in size, color, shape,
and motion is what makes the important thing findable, and a screen where everything is
equally quiet is a screen where nothing is found first. "Restrained" is not a neutral
default that costs nothing — it is a design decision with a measurable cost, and it needs
defending the same way a loud one does.

And the ceiling, from the same research, in Google's words: **"no amount of expressive
design will beat basic functionality."** Where basic interaction paradigms are broken,
expressive styling produces poor usability and negative sentiment. Expression is an
emphasis layer over a proven interaction pattern; it is not a licence to invent a
navigation model. Reach for it on the emphasis layer and leave the paradigm alone unless
you have a reason that survives `§10` and `§15`.

Tool-shaped surfaces get the sharpest version of this: spend expression on the two or three
objects the operator touches forty times a day, and let the other thirty stay quiet.
Expression everywhere is the same failure as restraint everywhere — a flat field, with more
noise in it.

## Paired color tokens

**Every color in `DIRECTION.md` ships as a pair: the swatch and the foreground that is
legal on it.** Never a lone hex. `minimalist-ui` does this and it is strictly better than
what any of the parent pipelines did:

> - Pale Red: `#FDEBEC` (Text: `#9F2F2D`)
> - Pale Blue: `#E1F3FE` (Text: `#1F6C9F`)
> - Pale Green: `#EDF3EC` (Text: `#346538`)
> - Pale Yellow: `#FBF3DB` (Text: `#956400`)

Four tokens, each a pair. An agent cannot pick a pastel background and then invent a text
color to sit on it, because the token was never a background in the first place.

The rules that follow from the shape:

- **A swatch with no foreground is an unfinished token.** It does not go in `DIRECTION.md`.
- **The pair carries its measured ratio**, at the size it is actually used: ≥4.5:1 for body
  text, ≥3:1 for large text and for non-text elements that carry meaning (`§10`).
- **Pairs extend to states**, not just to rest: default, hover, active, selected, disabled,
  and the focus ring — which is measured against *both* the swatch and whatever sits behind
  the component, since a ring that vanishes on one of the two is a ring that vanishes.
- **On a translucent or moving substrate the pair is measured against the worst frame**,
  never a still screenshot.
- **The accent sampled from reality per `§6` is a pair too.** Sampling gives you one hex;
  the token needs two, and inventing the second one carelessly is how a sampled brand color
  becomes an accessibility bug.

[Style and accessibility](#style-and-accessibility) below is the **repair** — the table for
styles whose entire idea fights contrast. This section is the **prevention**. Contrast
resolved at definition time never reaches the repair table, and a run that arrives at the
repair table with ordinary colors in it did this section badly.

## Building the ramp

Pairs say what a token must contain. This says how the numbers are arrived at, because "sample
the accent, build a neutral ramp" is an instruction with a whole method hiding inside it.

**Work in OKLCH, and know the coordinate space.** L runs 0–1 and is clamped at parse time; 0
renders black and 1 renders white. C has a reference of `100% = 0.4` and in practice never
exceeds 0.5. Hue angles are anchored: **0° purplish red, 90° mustard yellow, 180° greenish
cyan, 270° sky blue.** Below `C = 0.000004` the hue is powerless — that is the definition of a
true neutral rather than a nearly-neutral.

**The priority order when a color will not fit is hold hue, hold lightness, cut chroma.** That
is not a preference; it is what all three CSS gamut-mapping algorithms do, because "changes in
Hue are particularly objectionable; changes in Chroma are more tolerable." Reason the same way
by hand and the ramp agrees with the display instead of fighting it. One just-noticeable
difference in OkLCh is **0.02** — two steps closer than that are one step.

**A ramp cannot hold chroma constant, and this is the mistake that produces muddy light ends.**
The chroma ceiling collapses at both ends of the lightness axis and peaks near each hue's own
cusp, at a different lightness per hue. Measured maximum in-gamut chroma, sRGB / Display-P3:

| L | red 29° | yellow 110° | green 145° | cyan 195° | blue 264° | magenta 328° |
|---|---|---|---|---|---|---|
| 0.35 | 0.144 / 0.161 | 0.076 / 0.089 | 0.110 / 0.149 | 0.060 / 0.080 | 0.203 / 0.241 | 0.161 / 0.176 |
| 0.50 | 0.205 / 0.231 | 0.109 / 0.127 | 0.157 / 0.213 | 0.085 / 0.115 | 0.281 / 0.300 | 0.230 / 0.251 |
| 0.65 | 0.236 / 0.298 | 0.142 / 0.165 | 0.204 / 0.277 | 0.111 / 0.149 | 0.186 / 0.201 | 0.299 / 0.327 |
| 0.80 | 0.115 / 0.147 | 0.175 / 0.203 | 0.252 / 0.341 | 0.136 / 0.183 | 0.100 / 0.109 | 0.196 / 0.226 |
| 0.90 | 0.052 / 0.068 | 0.196 / 0.228 | 0.195 / 0.218 | 0.154 / 0.172 | 0.048 / 0.053 | 0.089 / 0.109 |

Read it as a shape, not a lookup. Red at L 0.90 carries a fifth of the chroma it carries at
0.65. A blue-accented ramp and a yellow-accented ramp are different objects. **P3 buys 10–35%
more chroma at the same L and H — headroom, never a different palette**, so a direction that
only works in P3 does not work.

Check any single value in three lines rather than guessing, using the browser's own unclamped
conversion:

```js
el.style.color = `color(from oklch(${L} ${C} ${H}) srgb r g b)`;
const rgb = getComputedStyle(el).color.match(/[-\d.]+/g).slice(-3).map(Number);
const inGamut = rgb.every(v => v >= 0 && v <= 1);   // false → reduce C, hold L and H
```

**The tinted neutral** is the accent's hue held constant with chroma at a small fraction —
roughly 0.005–0.03, which is practice rather than spec — and lightness carrying the ramp. It is
what makes a neutral belong to a palette rather than sit beside it. Tool-shaped surfaces feel
this hardest: an operator reads that ramp for eight hours, and a neutral that carries no hue at
all reads as a different product from the accent it surrounds.

**Gradients: declare the interpolation space.** `linear-gradient(in oklab, …)`, not "write one
endpoint in `oklch()` and hope." `CRAFT.md` carries the measurement behind that instruction.

## Fonts: the ban is on convergence, not the typeface

Two lists, kept separate, because they are not the same kind of rule:

1. **A genuine blacklist** — Papyrus, Comic Sans, Lobster. These are quality judgments.
2. **Overused, never recommended as primary** — Inter, and the fonts that have become the
   reflexive escape from Inter. This is not a quality judgment at all.

gstack's framing of the second list is the one worth copying verbatim:

> Space Grotesk is on the list specifically because every AI design tool converges on it as
> "the safe alternative to Inter." That's the convergence trap. Treat it the same as Inter:
> only use if the user asks for it by name.

Inter is an excellent typeface. That is precisely why it is everywhere, and why choosing it
by default guarantees the output looks like every other output. The ban is on the
**reflex**, not the file. If `TRANSLATE.md` row 6 says the subject already uses Inter, it
is load-bearing, it stays, and it gets self-hosted per `§7`. Convergence is reaching for it
when nothing in the intake reached for it first.

A ban that ships without its reason decays. The audited corpus proves it: one skill bans
Inter in its bans section and then recommends "Inter (Extra Bold/Black)" in its font
section, inside the same file. Nobody can maintain a list they cannot derive. So: **every
font decision in `DIRECTION.md` carries its reason on the same line** — what this face does
for this direction that the obvious one would not. A rule with its reason attached survives
a fashion cycle; a bare blacklist goes stale in eighteen months.

## The type scale: ratio-derived or role-indexed

**Deciding which of the two a scale is comes before writing any number**, and a run that skips
the decision defaults to inventing sizes that have no job.

- **Ratio-derived** when the sizes are a continuum and the surface is content-led — editorial,
  marketing, long-form. A ratio gets chosen and defended in one line. Which ratio is craft, not
  citation; no primary source names one.
- **Role-indexed** when the sizes are named jobs with fixed relationships — product UI, tools,
  anything whose type inventory is a component list rather than a document outline. Material 3
  publishes exactly this: 15 baseline styles as Display / Headline / Title / Body / Label × L /
  M / S, plus 15 emphasized, with adjacent steps at no constant ratio, and the explicit note
  that "no single product will use all the styles."

Forcing a ratio onto a role-indexed inventory is how a scale acquires a 20px step that nothing
uses. Stating "there is no ratio here, the sizes are roles" is a finished answer, not a gap.

**The measure has a sourced ceiling and a craft working range.** WCAG 2.2 SC 1.4.8 puts the
ceiling at **80 characters (40 CJK)**; the familiar 45–75ch is practitioner narrowing and gets
labeled as such. A measure written in `rem` is not a measure — `ch` is the unit that tracks the
face. DTCG has no `ch`, so a tokenized measure records the `ch` intent in `$description` and
carries a `rem` value **computed from that face's measured advance width**, never a number that
happens to share the digits.

**Line-height is a floor question before it is a taste question.** SC 1.4.12 (AA) requires that
nothing breaks when the user sets line height to **1.5× font size**, paragraph spacing to **2×**,
letter-spacing to **0.12em**, and word-spacing to **0.16em**. Authoring below those values is
legal; a layout that collapses at them is not. Longer measures want more leading — craft, and
true. And per `CRAFT.md`, if the direction claims a baseline grid, `font-size × line-height` has
to be an integer multiple of the spacing unit or the claim is decoration.

**Fluid type gets both `clamp()` bounds in `rem`.** A pure-`vw` middle term stops responding to
the user's own font-size setting entirely once it pins to its max — measured in `CRAFT.md`.

## The spacing scale: name it by ratio, and leave the gaps

**Pick one base unit and make every token a multiple of it.** Material's system is an 8dp scale
where `space100 = 8dp` and the token number states the multiple — `space300` is 24dp, three times
the base. Sub-base values (2, 4, 6, 10, 14dp) exist as *nested units* only where components
actually use them.

Two rules follow, and both are worth taking:

- **Only the values with a job get a token.** Material defines "the most recommended spacing unit
  values" rather than every step on the scale. A spacing scale with unbroken 4px increments up to
  128 is a list, not a system, and the absent steps are information — they say the design has no
  job at that size.
- **Ratio naming survives a base change.** `space100 = 8dp` tells the reader the relationship
  without knowing the base; `space.24 = 96px` requires remembering that the base is 4. Both are
  defensible and the first is cheaper to read.

**Density is a user setting, not a breakpoint consequence.** Material is explicit: density
"shouldn't automatically change across breakpoints or orientation unless a person changes it."
Compression steps by **4dp** of vertical padding per level, and stops before any target falls
below **48×48 CSS px**. Tool-shaped surfaces are where this earns its keep — density is a control
the operator owns, and `TRANSLATE.md` row 2's answer decides the default, not the window width.

## Style and accessibility

`§10` is **[HARD]**. These styles fight it hardest, and each ships with its fix or does not
ship.

| Style | What it fights | The fix that ships |
|---|---|---|
| **Neumorphism** | Form is shadow on one hue, so nothing has a contrast ratio | Extrusion is for containers only. Every label, value, and control state gets a real foreground token at ≥4.5:1. Focus is a hard visible ring, never a deeper shadow |
| **Glassmorphism / liquid glass** | Text contrast changes with whatever scrolls behind it | An opaque or near-opaque scrim behind every text run, measured against the *worst* frame of the moving substrate, never a screenshot |
| **Cinematic dark** | Vignette, grade, and grain push small type below threshold | Measure contrast on the rendered pixels after grade and grain, not on the tokens. Body copy stays out of the vignette falloff. Grain opacity drops on text layers |
| **Kinetic / physics / scroll-cinema** | Motion is the design, so removing motion removes the surface | An art-directed still per `§10`: a composed frame with type at rest that someone designed. Scroll-cinema degrades to a paginated document, same content, same order |
| **Spatial / 3D-world** | Navigation depends on a camera and a GPU | Keyboard traversal between named places, a text route to every section, and a no-WebGL fallback that is a real page, never an apology |
| **Terminal** | Scanlines and CRT curvature reduce legibility and can trigger | Curvature and scanline opacity behind `prefers-reduced-motion` plus a visible toggle. Body text renders on the flat layer above the effect |
| **ASCII / text-only** | Screen readers read the art as character soup | `aria-hidden` on the art, `role="img"` with a written alt on the block, and real semantic HTML carrying the content underneath |
| **Glow-neon / vaporwave** | Saturated emission on dark causes halation and fringing | Glow applies to non-text elements only. Text uses a desaturated stop of the same hue at full contrast. Chromatic aberration never touches a glyph |
| **Data-brutalist** | Density defeats zoom and reflow | Real table semantics with scoped headers, horizontal scroll containers that are keyboard reachable, a stated minimum readable width, and a genuine narrow layout rather than a shrunken wide one |
| **Neo-brutalism** | Bold color and thick borders read as loud rather than legible the moment hierarchy is left to the palette alone | Hierarchy carried by size and color-intensity variation, not border weight. Pick the clash in OKLCH and check every bold-on-bold pairing at ≥4.5:1 on the actual colors in use, not the swatch in isolation. Loud and 4.5:1 are compatible; loud and untested is not |
| **Aurora / mesh gradient** | Text over a moving gradient has no fixed ratio | Freeze the gradient behind text or scrim it, and measure against the worst frame |
| **Swiss-punk / typographic extremes** | Enormous display type reflowing at 320px | A real narrow-viewport type scale, not a scaled-down wide one. Test at 320px and at 200% zoom |

## Light and dark as two designs

Per `CRAFT.md`'s art-directed modes, a style often needs a genuinely different treatment in
each mode. Never `filter: invert()`. Choose per-mode ink, substrate, shadow direction, and
accent chroma deliberately. These break under naive inversion:

- **Neumorphism.** Inverting the shadow pair puts the light source underneath, which no
  physical object does. Keep the light direction identical in both modes and change only
  the surface hue and the shadow spread.
- **Glassmorphism.** Blur reads as depth on dark and as haze on light. Light mode needs
  more opacity, a heavier border, and less blur to say the same thing.
- **Cinematic dark.** There is no light version of a lit set. Light mode is a second art
  direction: a printed still with the grade baked in as a duotone, no vignette, no bloom.
- **Glow / neon.** Emission requires darkness. In light mode the glow becomes ink
  saturation and weight, and the accent moves from emissive to dense.
- **Risograph.** Paper is the substrate. Dark mode is a black-paper print run with inks
  chosen for it, and the halftone dot inverts to open rather than filled.
- **Blueprint.** White-on-blue and blue-on-white are both real print conventions. Switch
  between them on purpose, with line weights retuned, since hairlines that read on dark
  disappear on white.
- **Aurora / mesh.** OKLCH stops that stay saturated on dark go chalky on light. Each mode
  needs its own stop list, never a lightness shift.

Every paired token from [Paired color tokens](#paired-color-tokens) is paired **per mode**.
A foreground that is legal on the light swatch tells you nothing about the dark one.

There is a surface-class dimension too. Page-shaped: dark reads as
technical-audience-native and light reads as broadly legible, so when the audience spans
both, respect the system preference and make sure the page that gets forwarded is excellent
in light. Tool-shaped: the operator picks once and lives there for years, which makes the
non-default mode a first-class design rather than a courtesy — half of them will never see
the one you designed first.

Declare in `DIRECTION.md` whether the two modes are one design in two palettes or two art
directions. If the chosen style appears above, the answer is two art directions, and both
get built and screenshotted under `§12`.
