# Audit — the four imagegen design skills

**Date:** 2026-07-28
**Audited:** 4,478 lines across four skills on disk
**For:** `inter.face` spec at `/Users/taha/Documents/inter.face/docs/superpowers/specs/2026-07-28-inter-face-design.md`

| Skill | Path | Lines | What it actually is |
|---|---|---|---|
| `imagegen-frontend-mobile` | `/Users/taha/.claude/skills/imagegen-frontend-mobile/SKILL.md` | 1465 | Mobile screen-image art direction. 38 numbered sections. Generates images only, explicitly refuses code |
| `image-to-code` | `/Users/taha/.claude/skills/image-to-code/SKILL.md` | 1228 | Image-first web build: generate → analyze → implement |
| `imagegen-frontend-web` | `/Users/taha/.claude/skills/imagegen-frontend-web/SKILL.md` | 987 | Per-section web design-image generation |
| `brandkit` | `/Users/taha/.claude/skills/brandkit/SKILL.md` | 798 | Brand-guidelines board generation — logo, palette, identity system |

**Headline finding for our purposes.** The 1,465 lines of mobile material are almost
entirely *surface convention and image direction* — safe areas, navigation models,
device framing, screen-flow logic. They are not native implementation craft. Our spec's
out-of-scope line ("`CRAFT.md`'s arsenal is web technique … for iOS or Android the
principles hold and the arsenal does not") therefore does **not** block taking this
material. What is out of scope is a native technique arsenal. What is in scope, and
what we are currently missing entirely, is *what a mobile surface is shaped like* — and
that is what this file contains.

**Second finding.** All four files cover phone only. Across 4,478 lines: zero
occurrences of `tablet`, `iPad`, `landscape`, `split view`, or `desktop app`. Mining
these closes the phone hole. Tablet and desktop remain open and will not be closed from
this source.

---

## 1. Mobile design knowledge in `imagegen-frontend-mobile`

Everything below is extractable. Where the source is a browsable list, the conversion
into our house form (procedure / named failure with an opening / checkable rule) is
given.

### 1.1 Platform mode is decided first, before anything else

The one genuine decision procedure in the entire file (§2, lines 152–192):

> Always decide the platform mode first.
> Choose one:
> 1. iOS-native premium
> 2. Android-native premium
> 3. cross-platform premium neutral

Each branch carries its own bias list:

| Mode | Bias toward |
|---|---|
| **iOS-native premium** | "cleaner top areas / tab-bar clarity / safe-area awareness / elegant spacing / restrained chrome / calm hierarchy / native-feeling sheets and cards / polished but not overdecorated" |
| **Android-native premium** | "stronger component rhythm / clearer app bar behavior / bottom navigation clarity / sheet logic / card/list structure / slightly firmer layout framing / more explicit state clarity" |
| **Cross-platform premium neutral** | "clean safe-area handling / universal mobile navigation patterns / clear hierarchy / less platform-specific ornament / premium but broadly buildable visual language" |

Closing rule, and the reason the branch matters:

> Do not mix iOS and Android patterns carelessly. Pick one dominant platform feel and
> stay coherent.

**Take it as-is.** This is the mobile analog of our surface class fork: one question
asked before the loop body runs, everything downstream conditioned on the answer. It
belongs in `agents/surface-designer.md` as a required front-matter decision for any
mobile surface, recorded in `DIRECTION.md`.

### 1.2 Safe areas are the mobile grid

§13 (lines 479–498) is the single most valuable checkable rule in the file, because it
is the thing that separates a real screen from a poster:

> Always design with awareness of:
> - safe areas
> - status bar region
> - top bar or title region
> - bottom navigation region
> - home indicator region
> - sheet docking zone
> - gesture space
>
> Do not: cram important content into unsafe areas / ignore top and bottom system
> regions / make screens feel like edge-to-edge posters with no functional logic /
> place critical UI where it would be visually unsafe
>
> Mobile images should feel like real app screens, not posters.

**Converted to a checkable rule:** every mobile surface image must show, or visibly
reserve, four bands — status bar, title/nav region, content region, bottom
nav/home-indicator region. A screen whose content runs edge to edge in all four
directions has failed, regardless of how good it looks.

### 1.3 Navigation must be a model, not decoration

§14 (lines 502–521) names the patterns and their jobs:

> - tab bar / bottom navigation for major app sections
> - stack navigation feel for drill-down flows
> - sheets for secondary tasks
> - segmented controls for local switching
> - app bars where useful
> - clear primary and secondary actions
>
> Do not: overload bottom navigation / hide the main path through the app / make every
> action equally important / create unclear hierarchy between tabs, sheets, and actions

**Named failure with its opening.** *Failure:* every action rendered at equal weight,
so the screen has no main path. *Why it persists:* an image model has no cost function
for navigation, so it draws whatever fills the space. *Opening:* name the one action
this screen exists for before writing the prompt; everything else renders one tier down
(smaller, outlined, or in the overflow).

### 1.4 The screen is the unit, and the flow between screens is designed

§8 (lines 323–345) — this is the piece our spec has no equivalent of, since we design
surfaces independently:

> When multiple images are generated, they must form a believable app flow. Do not
> generate random unrelated screens. The screen order should make sense.
>
> Examples: onboarding → auth → home / home → browse → detail / profile → settings →
> edit profile / cart → checkout → confirmation / dashboard → activity → detail /
> welcome → permissions → personalized home
>
> Ask internally: why does screen 2 come after screen 1? what action or navigation
> leads to the next screen? is this a believable user journey? does the UI state carry
> forward logically?

**Converted to a procedure:** for a mobile run, the surface list is not a set, it is an
ordered path. Before dispatch, write the transition between each adjacent pair — the
tap, the state carried forward. A surface with no inbound transition is either the
entry point or a mistake.

The six named flows above double as a default screen-set generator when the brief only
says "an app."

### 1.5 Screen count — n requested, n produced

§4 (lines 211–236) is the mobile restatement of the rule our `surface-designer` already
holds, with one addition worth taking:

> It is better to generate multiple clean readable screens than one compressed board
> with tiny unreadable text.
>
> If a detail is unclear: generate an extra detail image, or regenerate that screen
> cleanly.
>
> Never reduce screen count just for convenience if it weakens the app concept.

Plus §5 (240–256), the no-crop rule:

> When a screen or detail needs a dedicated view, do not just crop or zoom into a
> previously generated larger image … Instead: generate a fresh standalone screen
> image … keep the same design language, colors, type mood, and component family.

**Why this matters mechanically:** the same rule appears in `image-to-code` §5 with the
reason stated (lines 220–228) — cropping destroys "spacing accuracy, type scale
relationships, clean margins, layout proportions, button clarity, section balance." A
crop is a lossy rescale of the exact relationships the image exists to communicate.

### 1.6 Phone mockup framing — the most directly reusable block

§9 and §10 (lines 349–405) are the operational rules our `surface-designer` currently
lacks entirely. Default presence (§9):

> By default, present the mobile UI inside a clean phone mockup with a visible device
> border/frame … Do not omit the device frame by default. Only remove the visible
> device frame if: the user explicitly asks for raw screen-only output / the concept
> clearly benefits from borderless presentation / the user asks for UI sheets or assets
> instead of full phone compositions.
>
> Default rule: phone mockup present / content still primary

Framing discipline (§10) — eleven checkable rules:

> - use one coherent device style across the full set
> - keep device scale consistent across all screens in the same series
> - keep the mockup centered or aligned with clear discipline
> - keep top, bottom, left, and right canvas margins visually even
> - do not let the phone touch the canvas edges
> - do not use awkwardly cropped device frames
> - do not use inconsistent bezels or random frame sizes across screens
> - keep shadows soft and controlled
> - the phone border/frame should be visible and clean
> - the mockup should support the screen, not overpower it
> - keep visual emphasis on the UI content inside the phone
>
> If multiple device mockups appear in one composition: keep the same scale / keep
> equal gutter spacing between devices / align them cleanly / avoid random overlap
> unless explicitly art-directed.

**The stated failure this prevents** (line 73): "device frames that dominate more than
the actual screen content." The skill declares a dial for it — `CONTENT_FIRST_MOCKUP_BALANCE: 10`
— which is an admission that the default framing eats the subject.

**Our version should invert the default.** See §7 below: the frame is a presentation
choice, not a design one, and it costs canvas. Our rule: frame only when the surface's
*physicality* is load-bearing (a field app used in gloves, an app-store shot); otherwise
render the screen bare with even margins. When framed: thin bezel, no branding on the
device, consistent scale across the set, phone never touching the canvas edge.

### 1.7 Type sizing and readability — a strong rule with no numbers

§29 (lines 1087–1121) states the rule better than any other line in the four files:

> Strong rule: **if the text feels small, the design is not finished yet**

And gives an escape ladder, which is the part worth stealing verbatim:

> If a design choice makes text too small:
> - simplify the layout
> - reduce content
> - increase spacing
> - enlarge the text
> - split content into another screen if needed
> - regenerate the screen if necessary
>
> Readable beats clever. Readable beats dense. Readable beats decorative small type.

Type hierarchy rules from §30 (1124–1145):

> Always ensure: strong title/body/label contrast / readable mobile scale / clear
> section headers / short CTA copy / believable type rhythm across screens / good line
> count control.
>
> Do not: make everything the same weight / use too many font moods / create awkward
> line wrapping / use oversized headline drama on every screen / let body text become
> tiny or decorative.

**The hole.** Across all four files there are **zero** numeric type sizes, touch-target
sizes, or spacing values — `grep -Ec "[0-9]+ ?(px|pt|dp|rem|sp)"` returns 0 for every
file. "Comfortably readable" is unfalsifiable. Ours should carry the numbers, because a
number is checkable and an adjective is not:

- iOS body 17pt, minimum legible caption 11pt; Dynamic Type must not break the layout
- Android body 16sp, minimum 12sp
- Touch target: 44×44pt (iOS HIG) / 48×48dp (Material), including the invisible hit area
- Adjacent targets separated by at least 8pt of dead space
- In a design image, judged proportionally: body type at roughly 1/45th of the screen
  height. Below that, the layout is carrying too much

### 1.8 Touch targets — the real gap, and where to fill it from

The mobile skill mentions touch exactly twice, both as vibes: "touch-friendly" (§31,
line 1167) and, in the web skill, "maintain tap-friendly hit sizes" (§18, line 892).
There is no size, no thumb-reach model, no hover rule.

The better material is already in our family — `/Users/taha/Documents/systemcicy/INTERFACE.md`
§10 "Mobile and field use" (lines 170–181):

> If any role works away from a desk, that is a different design, not a narrower one.
> - Large touch targets, thumb-reachable primary actions, and no hover dependency
> - Works in sunlight: contrast well above the minimum
> - Works with gloves, in a warehouse, on a five-year-old Android with two bars
> - Offline behavior explicit … what queues, what does not, what the conflict state is
> - Camera, scanner, and signature where the work uses them
> - Never require a desktop step in the middle of a field workflow

**Merge instruction:** `TOOLS.md` inherits systemcicy §10 verbatim per the spec. Add
the numbers from 1.7, the thumb-reach rule (primary action in the bottom third; never
in the top corners on a phone), and the no-hover rule (any state reachable only by
hover does not exist on touch — it needs a press, a long-press, or a visible affordance).

### 1.9 The design bible — a lock list that is really a DIRECTION.md schema

§6 (lines 260–286). Sixteen fields locked before image 1 and held across the set:

> platform mode / device frame style / device scale / palette logic / typography mood /
> type scale rhythm / spacing system / corner radius logic / icon style / illustration
> · imagery treatment / texture intensity / decorative asset language / navigation
> model / card and list behavior / button styling / shadow language
>
> Do not let screen 3, 4, or 5 drift into a different app.

§7 (288–319) adds the variance boundary, which is the sharper half:

> **Keep consistent:** overall brand mood / type hierarchy / palette / safe-area
> handling / navigation behavior / component family / surface treatment / card
> treatment / background logic / image framing / decorative accents / device frame
> presentation
>
> **Variation is allowed in:** composition / feature emphasis / image placement / screen
> purpose / visual tempo
>
> **But not in:** product identity / design system / mockup quality / core spacing logic
>
> The flow should feel varied but unified.

**Take the whole thing.** This is a better-specified `DIRECTION.md` than our spec
currently describes. Our field list is concept, collision, palette with sources, type
system, technique per surface, motion spec, budget tiers, inventions. It has no radius
logic, no icon style, no shadow language, no navigation model, no card/list behavior —
and those are exactly the fields a build step has to guess if we do not write them down.

### 1.10 Iconography

§20 (lines 687–710) — a ban with a weak opening, worth taking with the opening
strengthened:

> Do not default to generic developer-style icon packs or bland Lucide-like icon vibes.
>
> Avoid: generic line-icon defaults that make the app feel like a template / overused
> developer-tool icon language / icons that feel too plain, too open-source-default …
> / randomly mixing icon weights and styles
>
> Prefer: a clean custom-feeling icon system / restrained, brand-appropriate
> iconography / consistent stroke or filled logic / icons with slightly more character
> when the concept allows it / product-specific icon decisions

**The checkable part is the last one:** stroke *or* filled, one choice, applied to every
icon in the set. Mixed weight is visible in an image and is a legitimate reject. "Feels
custom" is not checkable and should be dropped in favor of our `§3` (reinvent every
component), which already says the same thing enforceably.

### 1.11 Layout — one structural move, not five levels of framing

§15 (lines 524–546), which `image-to-code` §16 repeats for web:

> Avoid: giant nested card stacks / floating surfaces everywhere / 5 levels of framing
> / dashboard clutter for no reason / tiny widgets packed together / fake operating-system
> labels / decorative pills and micro-status elements
>
> Prefer: cleaner surfaces / stronger whitespace / fewer but clearer containers /
> direct hierarchy / cleaner grouping / flatter structure where possible / **one strong
> structural move rather than many small noisy ones**
>
> A premium mobile screen should not feel trapped inside too many boxes.

**Checkable rule:** count nesting depth in the rendered image. Screen → card → card is
two. Three is the reject threshold.

### 1.12 First screen cleanliness

§12 (lines 437–476) — the mobile analog of our page-shaped "opening move":

> - use one primary focal point
> - keep the top screen area controlled
> - keep the headline short
> - do not overload the first viewport
> - do not fill it with extra stats, chips, tags, or pills
> - do not bury the main CTA
> - make the first screen work on a normal phone size without feeling cramped
> - if imagery is used behind text, preserve clear readability with fades, masks, or
>   soft scrims
>
> Strong preference: 1 to 3 short lines for the main statement / concise supporting
> text / one clear next action
>
> Avoid: … "website hero inside a phone frame"

That last banned phrase is the most useful line in the file. It names the exact failure
an image model produces when asked for a mobile screen.

### 1.13 Image-behind-text — the readability treatment menu

§18 (lines 615–648) is genuinely specific and has no equivalent in our docs:

> Preferred treatments:
> - image background under a title block with a fade to transparent
> - bottom-to-top gradient fade to support text legibility
> - side fade masks so text sits over the clean portion
> - soft blur overlays behind text
> - image partially visible behind copy, fading into the background color
> - large edge-to-edge visual with a scrim under headline and CTA
> - photo or illustration bleeding behind typography but gently masked
>
> Avoid: raw image under text with no readability support / muddy overlays / too many
> heavy gradients / noisy backgrounds that destroy hierarchy

Pair with §17's texture menu (580–611): "soft film grain / subtle noise / paper-like
texture / lightly speckled surfaces / brushed or frosted texture feel / tonal gradient
fog / clouded ambient depth / tactile matte surfaces / faint grid or pattern texture /
blurred photographic background layers," governed by:

> texture should support the mood, not compete with the interface.

### 1.14 Density and spacing

§31 (1148–1176). The rule worth keeping is the cross-screen one:

> avoid one screen feeling cramped while the next is empty … separate dense screens
> from calmer screens in a flow

Note the baseline: mobile runs `VISUAL_DENSITY: 3` against web's `4` and
`SPACING_GENEROSITY: 9` against web's `8`. The direction is right — a phone screen has
less room and needs more air per element, not less — even if the dials themselves are
meaningless (§7).

### 1.15 Screen-to-screen variation

§32 (1179–1201). Vary "top-area composition / image-to-text balance / content density /
card-list emphasis / CTA placement / visual tempo / module proportions / background
treatment / texture intensity / use of creative assets" while holding the system fixed.
This is the mobile twin of the web skill's composition-anchor rotation (§2), and unlike
the web version it has **no numeric anti-repeat threshold** — that has to come from the
web file (§2.4 below).

### 1.16 Category bias

§33 (1205–1259), compressed:

| Category | Prefer | The tell it is avoiding |
|---|---|---|
| Fintech | trust, calm spacing, clear numbers, restrained accents, strong transaction clarity | "less fake chart spam" |
| Health / fitness | calm structure, strong metric hierarchy, readable progress modules, airy spacing | "motivating but not noisy" |
| Productivity | clarity, list and card discipline, navigation simplicity, strong task hierarchy | "calm density" |
| Social | profile and feed rhythm, hierarchy between creation and browsing, flow variety | expressive image direction, not a feed clone |
| Commerce | browse / detail / cart clarity, stable product card proportions, clean checkout hierarchy | generic commerce template |
| Wellness / lifestyle | softer materials, calm typography, breathing room, tactile backgrounds | "standard wellness pastel app" |

**Feed straight into our cliché table.** The spec plans to extend webcrab's nine
category rows with tool-shaped rows. Add mobile rows on the same schema — cliché, why it
persists, the opening — using the right-hand column above as the cliché.

### 1.17 The mobile failure table (converted)

The skill's failures are scattered across the preamble (51–74), §21 (713–758), and §34
(1262–1289). Reorganized into our form:

| Named failure | Source | Why it persists | The opening |
|---|---|---|---|
| **Phone-shaped website** | lines 57, 476, 1296 | The model's "beautiful UI" prior is web heroes; a big headline + sub + CTA centered in a portrait frame renders cleanly | Require one native chrome element per screen (tab bar, nav bar with back, sheet grabber) and one content row clipped by the screen edge, so it reads as scrollable rather than as a poster |
| **Fake chart dashboard spam** | 53, 727 | Charts read as "product" to an image model and cost it nothing to invent | One metric earns hero size; the rest are rows. If the product does not compute a number the user acts on, it has no chart |
| **Cloned onboarding** | 430: "3 identical screens with only icon and headline changes" | Onboarding is the easiest thing to template and the hardest to differentiate | Each onboarding screen changes image-to-text ratio and composition, not just the copy |
| **Screen-set drift** | 71: "screen sets that drift into different design systems" | Each generation is independent; nothing carries state | Lock the sixteen design-bible fields (§1.9) and restate them verbatim in every prompt in the set |
| **Box-in-box-in-box** | 528–535 | Nesting is how a model signals "designed" | Nesting depth ≤ 2. One structural move per screen |
| **Device frame steals the subject** | 73 | The frame is the most photographable object in the image | Frame only when physicality is load-bearing; thin bezel; content-first |
| **Tiny text** | 1092 | Density looks like richness | The five-step escape ladder in §1.7 |
| **Default icon library look** | 689 | Lucide-shaped icons are the training-set mode | One stroke-or-fill decision applied to the whole set; product-specific glyphs for the three most-used actions |
| **Purple-blue startup gradient** | 68, 717, 893 | It is the palette prior for "app" | Sample from reality (our `§8`); OKLCH; ban the hue band outright in the prompt |
| **Sterile flat background** | 65 | Flat is the safe default | The §17 texture menu, at low intensity, chosen once for the set |
| **Copy slop** | 735–748 | The model fills text boxes with motivational filler | Ban list in-prompt: "elevate your life / unlock your potential / next-gen finance / seamless control / smarter than ever / transform your day"; ban fake brands "Acme / NovaCore / Flowbit / Quantix / VeloPay" |

§34's regeneration triggers (1262–1289) are the same content as a checklist to run
against a rendered image — useful as the `surface-designer` "look at it" step: text too
small, spacing unclear, navigation fake, looks like a website, too crowded, onboarding
repetitive, image framing inconsistent, cards too nested, first screen noisy, flow
lacks variation, backgrounds flat, imagery weak, fade treatment poor, palette muddy,
set loses consistency, device framing uneven.

### 1.18 What the mobile skill does not have

Not present anywhere in 1,465 lines, and therefore still our problem: any measurement;
tablet or landscape or split-view; app icon, widget, notification, or watch surfaces;
keyboard avoidance; gesture and haptic specification; VoiceOver / TalkBack / Dynamic
Type; dark mode as a second design; empty, loading, error, offline, and permission-denied
states (the nine states exist only in systemcicy, for tools); localization and RTL; and
any named platform component (it says "sheet," never `UISheetPresentationController` or
`ModalBottomSheet`).

---

## 2. Design-image prompt craft

This is the part these files have genuinely solved, and it is mostly in
`imagegen-frontend-web`.

### 2.1 The hard rule is placed before the persona

The web skill's first content, above even "you are an elite art director" (lines 6–21):

> **Generate one separate horizontal image PER section. Always. No exceptions.**
> - 1 section requested -> 1 image … 12 sections requested -> 12 images
> - "landing page" with no count -> default to 6 sections -> 6 images
> …
> This rule overrides any model default that wants to collapse output into a single
> image.

Two craft decisions worth copying: the rule is stated **before** the role description,
and it explicitly names the model behavior it is fighting. Rules buried in §5 get
averaged away; rules in the first 20 lines survive.

Ambiguity resolves **high**, not low (§5, 407–413): landing page → 6, full website → 8,
marketing site → 8, product page → 6, portfolio → 6.

### 2.2 Announce the count out loud before generating

§19 step 3 (line 918):

> **commit out loud** to the section count and announce it ("Generating N horizontal
> images, one per section")

And step 16 (931):

> **generate every per-section horizontal image, labeled "Section X of N: <name>"**,
> until the full set is delivered. Do not stop early. Do not summarize. Do not return
> only one image.

Committing to N in text before generating makes stopping at 3 a visible contradiction.
Cheap, and it works on the exact failure mode (silent under-generation) our
`surface-designer` is built to prevent.

### 2.3 Format

§5 (417–428):

> - Always horizontal (16:9, 16:10, or 21:9 depending on density)
> - Each image renders one focused section in high fidelity
> - Hero usually 16:9 or 21:9; narrower content sections may be 16:10

**This is where our spec has a live conflict.** "One horizontal image per surface" is a
page-shaped rule. A phone screen is roughly 9:19.5 — rendering it on a 16:9 canvas
means ~75% of the pixels are background, and the image model spends its fidelity budget
on the empty field rather than the UI. The mobile skill sidesteps this by never
specifying a canvas ratio at all. Resolution for `loops/01-direction.md`:

| Surface | Canvas | Contents |
|---|---|---|
| Page-shaped web section | 16:9 (hero 21:9) | one section |
| Tool-shaped desktop screen | 16:10 | one screen, full chrome |
| Mobile screen | 16:9 canvas holding **2–3 phone-portrait screens** at identical scale, or a single 4:5 canvas for one screen | one step of the flow |
| Tablet screen | 4:3 or 16:10 | one screen |

Two to three phones on one horizontal canvas is the exception to "never a compressed
board" — because they are the *same surface across the flow*, at readable scale, not
different surfaces stacked. If type stops being legible, drop to one phone per canvas.

### 2.4 The anti-repetition check — the best mechanical rule in all four files

§18 (902–910):

> Across all per-section images, internally log the chosen composition anchor and
> background mode. Reject the set if:
> - the same composition anchor repeats more than 2 sections in a row
> - the same background mode repeats more than 3 sections in a row
> - every section is inline-asset (no full-bleed background ever appears) **AND** the
>   brief does not call for minimalism / typography-only / swiss / ultra simple
>
> For non-minimalist briefs: push for at least one full-bleed (or duotone /
> atmospheric) background and at least one mini minimalist section in any multi-section
> site.
>
> For minimalist briefs: this rule is suspended. Restraint is the design.

A logged variable, numeric thresholds, a stated exemption, and a reject verdict. This
is exactly our quality bar and it should be lifted almost verbatim into
`loops/01-direction.md` as a check the conductor runs on the returned set — not on each
agent, since no single `surface-designer` can see its neighbors.

### 2.5 The per-image pick lists

Each section picks one from each menu (§2, 242–307). These are the raw material a
prompt is assembled from:

**Composition anchor** (10): centered statement · top-left lead with support
bottom-right · bottom-left text over background image · bottom-right CTA cluster ·
left-third caption + right-two-thirds visual · right-third caption + left-two-thirds
visual · centered low (text in lower 40% over hero image) · off-grid editorial offset ·
stacked center · image-as-canvas with text overlaid in a clean safe area.

**Background mode** (12): solid surface with inline asset · subtle texture/paper/grid ·
full-bleed image with tonal overlay · editorial side-image (50/50, 60/40, 40/60,
invertible) · image as the entire visual · flat color block + detail crop · cinematic
tonal gradient · atmospheric photo with strong color grade · duotone treated image ·
soft radial vignette + product crop · micro-noise gradient over solid · color-blocked
diptych.

**CTA variation** (6): classic primary pill · outline/ghost · underlined inline link
with arrow · banner-style full-width · oversized headline + tiny CTA hint · CTA as
caption under a strong visual. Rule: "Across the site, vary CTA style at least once.
The page's primary action stays unmistakable."

**Hero scale**, picked once per page (283–288): Giant Statement · Mid Editorial · Mini
Minimalist — "Mini does not mean weak — it means confident restraint."

**Narrative / concept spine** (291–298), threaded through the whole set: artifact /
collectible · journey / pilgrimage · tool / precision instrument · living system /
garden · stage / spotlight · archive / dossier.

**Second-read moment** (300–307) — exactly one per page:

> - asymmetric bleed that still respects hierarchy
> - one oversized punctuation or numeral serving structure
> - a single unexpected material switch (paper vs gloss vs metal accent)
> - a narrow vertical side-rail editorial note style
> - a macro crop that carries brand color naturally
>
> Avoid gimmick-for-gimmick: the moment must aid scan order or brand recall.

That last constraint is what makes it a rule instead of a mood.

### 2.6 The brief-to-direction mapping

§1 (115–161) — a genuine decision table from brief adjective to concrete image
parameters:

| If the brief says | Hero scale | Background mode | Gradients | Composition |
|---|---|---|---|---|
| minimalist / clean / typography-only / swiss | Mini Minimalist | solid, subtle texture, optional one color-blocked diptych | skip, or softest tonal only | stacked center, generous negative space |
| editorial / magazine / art-directed / fashion | Mid Editorial or Giant | editorial side-image, duotone, atmospheric grade | subtle tonal only | off-grid offset, asymmetric pulls |
| cinematic / atmospheric / premium / luxury / bold | Giant Statement | full-bleed + tonal overlay, radial vignette + product, micro-noise gradient | cinematic, palette-matched | bottom-left over image, centered low, image-as-canvas |
| SaaS / product / dashboard / fintech / infra | Mid Editorial | solid + inline asset, flat block + detail crop | very subtle, palette-matched | clear product framing, trust anchors |
| agency / creative studio / portfolio | Giant **or** Mini (decisive) | vary boldly | editorial washes acceptable | off-grid, poster-like |
| e-commerce / shop / product page | Mid Editorial, product-focused | full-bleed product photo, radial vignette + crop | subtle, never competing with product | product-led, unmistakable CTAs |
| silent on style | pick one decisively | confident variety | — | "do not split the difference" |

Closing rule (161):

> Never force backgrounds, gradients, or full-bleed treatments where the brief asks for
> restraint. Never strip them out where the brief asks for atmosphere.

This is the output half of webcrab's "Picking one" procedure, which our `STYLES.md`
already plans to inherit. webcrab tells you which style; this tells you which image
parameters that style implies.

### 2.7 The gradient fence

§13 (723–740), a genuine allow/ban list rather than a warning:

> **Allowed (use confidently):** low-chroma palette-matched tonal gradients (ink to
> graphite, cream to sand, ivory to warm grey) · single-hue atmospheric grades behind
> hero photography · soft vignettes and radial depth that direct the eye ·
> noise-textured gradients adding tactile depth without color noise · editorial color
> washes that match brand mood
>
> **Banned (AI gradient slop):** rainbow / mesh blob gradients · purple-to-blue "AI"
> defaults · pink-to-orange "creator" defaults · neon edges and glow halos with no
> purpose · gradient text as a shortcut for "premium" · gradients that compete with
> imagery instead of supporting it

Plus the background confidence rule (741–747): "Do not retreat to plain white surfaces
by default."

### 2.8 Palette consistency across images

§13 (708–721) and §16 (823–839). The stated mechanism:

> Use one controlled palette across the entire site: 1 primary (brand anchor) · 1
> secondary (supporting tone) · 1 accent (used sparingly for CTA / highlight) · a
> neutral scale (background, surface, text, hairline).
>
> Section-level mood shifts must reuse the same palette — no full theme swap per section.
>
> When using full-bleed image backgrounds: the image must tonally match the palette
> (not fight it) · use overlays to keep text fully readable · the brand accent stays
> consistent regardless of background image.

§16's consistency invariants: same brand world, type scale logic, spacing discipline,
CTA family, icon/illustration mood, image treatment, tonal language. Variation allowed
in: composition anchor, background mode, section size and density, which second-read
moment appears. Verdict line: "Anything that breaks brand recall is over-variation."

**But the actual enforcement mechanism is missing from all four skills.** They never
say *how* the palette gets into image N — no instruction to restate hexes in each
prompt. The only place that mechanism is written down in this family is
`/Users/taha/Documents/portfolio.me/agents/section-designer.md` step 5: "State the exact
hexes. State the typeface names and their character." Our `surface-designer` already
inherits that; keep it, and add brandkit's "accents must repeat across panels."

### 2.9 Text inside generated images

`brandkit` is the only file that treats rendered text as an image-model constraint
(lines 556–577):

> Use very little text.
>
> Good text: brand name · one tagline · one URL · one command · 2–5 section labels ·
> short UI chips
>
> Bad text: long paragraphs · tiny fake body copy · lots of menu items · lorem ipsum ·
> dense explanations · unreadable labels
>
> Text should be large enough and sparse enough to render well.

That last clause is the real reason — image models garble small text — and it should be
stated as the reason in ours, because a reason survives paraphrase where a rule does not.

Counterweight from `portfolio.me/agents/section-designer.md`: "Use realistic text
lengths for a hero line, a blurb, or a case-study paragraph, so the human judges a
layout that real copy will fit." Both are right: realistic *lengths*, minimal *count*.

### 2.10 The word bans

Web §8 (546–565), mobile §21 (733–748), image-to-code §29 — near-identical lists.
Banned copy vibes: unleash · elevate · revolutionize · next-gen · seamless · powerful
solution · transformative platform · smarter than ever · unlock your potential · your
day, transformed. Banned fake brands: Acme · Nexus · Flowbit · Quantumly · NovaCore ·
Quantix · VeloPay.

**This exposes a real bug in our spec.** `PRINCIPLES.md` drops portfolio.me's `§11`
anti-slop prose on the grounds that "this plugin writes no body copy." But every design
image contains rendered text — headline, CTA label, nav items, a fake brand name — and
the image model *will* produce "Elevate your workflow" for "Acme" unless the prompt bans
it. The ban belongs in `agents/surface-designer.md` as a prompt constraint even though
`§11` correctly stays out of `PRINCIPLES.md`.

### 2.11 The hero self-interrogation

§4 (350–351):

> ### Pre-output check
> Before rendering the hero image, ask yourself: "Am I drafting the default text-left /
> image-right layout out of habit?" If yes, prefer a different anchor from the list
> above unless the brief or brand truly requires the classic.

A one-line reflex check aimed at a specific known default. Worth copying as a form: our
category-reflex check is the same shape at concept level; this is its layout-level twin.

### 2.12 The clarity check

§17 (843–868), 21 questions, of which the mechanically checkable ones are worth keeping
and the rest ("Is it premium rather than template-like?") are not:

> 15. Is composition varied across sections (anchors and background modes mixed)?
> 18. Is the palette consistent across all per-section images?
> 19. Is each image horizontal and one-section-only?
> 20. Is the **total number of images equal to the number of sections** (never fewer)?
> 21. Is the hero using a varied composition (not defaulting to left-text / right-image
>     out of habit)?
>
> If not, refine internally before output. If the count is wrong, regenerate the missing
> sections.

---

## 3. `image-to-code` methodology — the handoff

This matters to us because our deliverable is `DIRECTION.md` + images + prototypes
handed to a build step. This skill is the only one of the four that has actually thought
about that seam.

### 3.1 The mandatory order

§2 (112–130):

> 1. generate the design image or image set yourself first
> 2. deeply inspect and analyze the generated image(s)
> 3. extract the design system from them
> 4. implement the frontend only after that
>
> The image is the design source. The code is the translation layer.

§10 (368–388) adds the ambiguity clause: "only invent missing details when the images
leave something ambiguous."

### 3.2 The extraction spec

§9 (320–365) is the most useful list in the file — it is, read backwards, a
specification of what a build step needs and therefore what our `DIRECTION.md` must
carry:

> exact visible text where readable · hero headline wording · subheadline wording · CTA
> wording · section titles · typography character · type scale relationships · font mood
> · line count · line wrapping behavior · alignment logic · section spacing · internal
> spacing · padding and gutters · card dimensions and rhythm · border radius logic ·
> stroke / divider usage · button shapes · button hierarchy · button padding ·
> hover-implied styling · color palette · accent colors · background treatment · image
> treatment · icon treatment · shadows / depth logic · grid logic · layout structure ·
> section ordering · section density · visual rhythm · repeated motifs that define the
> design language

Broken out further in §21–§25 (text, typography, spacing, buttons/components, color),
each with its own inspect list. §23's framing is the right one:

> The goal is not exact pixel OCR. The goal is faithful spacing logic.

**Our improvement.** Their answer to "the image is ambiguous" is *generate another
image* — expensive, lossy, and still an image. Ours should be: write the number down.
`DIRECTION.md` states the palette in OKLCH, the type families and their scale ratio, the
spacing scale, the radius scale, the shadow language, the icon rule. Then the build step
never has to OCR anything, and the image only has to carry what a number cannot —
composition, proportion, mood, where the eye lands. **This inversion is the strongest
single idea to take from `image-to-code`, and we should take it by contradiction.**

### 3.3 Anti-drift — a named failure we have no answer to

§27 (860–877):

> A common failure mode is design drift: the generated images look strong, but the coded
> result becomes generic.
>
> During implementation:
> - do not simplify into default templates
> - do not replace distinctive sections with generic rows
> - do not compress generous spacing into dense layout
> - do not replace strong typography with plain hierarchy
> - do not remove the page's visual identity for convenience
> - do not merge section logic into repetitive patterns that were not present in the
>   source images
> - do not reintroduce nested-box complexity that was intentionally removed during
>   analysis

And §26 (835–857):

> The goal is not: inspired by the image.
> The goal is: visually faithful to the image, translated into real frontend.

Our spec stops at `DIRECTION.md` and says nothing about what happens next. Since the
handoff *is* the deliverable, `DIRECTION.md` should close with a short "what faithful
means" clause carrying these seven do-nots plus the identity/inspired distinction. It
costs ten lines and it is the difference between the design surviving the build and not.

### 3.4 Missing-detail resolution order

§28 (880–894) — a real decision procedure, in priority order:

> 1. preserve the visible design language
> 2. preserve layout and spacing logic
> 3. preserve component family
> 4. preserve mood and polish level
> 5. generate an extra detail image if needed
> 6. regenerate the section as a fresh standalone image if needed
> 7. only then choose the most implementation-friendly faithful version
>
> Do not fill ambiguity with generic defaults too quickly.

### 3.5 The detail / extraction image as a second artifact class

§7 (259–286): when a section image does not expose enough detail, generate a second
image of the *same* section, "focused mainly on typography and spacing instead of the
full composition," with larger text. Explicitly not a redesign (§6, 233–256): "This is
not a different design. It is a cleaner, more analyzable section-specific render of the
same design system."

Worth adding to `loops/01-direction.md` as an allowed second artifact — one per surface,
on demand, when the human at Gate A cannot read something.

### 3.6 The small-laptop rule

§15 (559–581): the first view must work on a small laptop — clear headline, readable
supporting text, clean spacing, visible CTA, one balanced focal point, and nothing else.
A concrete viewport constraint on the hero, which is more checkable than "clean."

### 3.7 The micro-UI clutter ban, with the best concrete example in the corpus

§17 (610–639):

> Examples of things to avoid unless they are truly necessary:
> - "00 orchestration layer"
> - tiny technical status pills
> - decorative runtime markers
> - overly specific pseudo-enterprise microcopy
> - filler operator/control-room labels that exist only to look complex

Naming the exact string an image model invents is worth more than a paragraph about
restraint. Ours should name strings too.

---

## 4. `brandkit`

Weakest fit — our plugin takes "what is already owned" as a `TRANSLATE.md` input rather
than deriving an identity — but four things are worth taking.

### 4.1 Category → symbol logic

Lines 117–128, a derivation table from category to metaphor to mark:

| Category | Core ideas | Possible symbol logic |
|---|---|---|
| Developer tool | building, speed, precision, control | cursor, frame, bolt, scaffold, grid |
| AI assistant | delegation, intelligence, clarity | spark, orbit, signal, path, node |
| Security | protection, vigilance, boundary | shield, eye, seal, protected core |
| Voice AI | sound, rhythm, command, flow | waveform, mic, orb, speech path |
| Compliance | trust, order, rules, protection | seal, dog, badge, document, shield |
| Luxury / editorial | taste, material, ritual, restraint | monogram, seal, paper, emboss, mark |
| Productivity | focus, momentum, clarity | path, check, block, calendar, light |

Closing line: "Do not pick symbols randomly." This is the same move as our cliché
table run forwards instead of backwards — and it is a useful cross-check: if the symbol
you picked is the first row of this table for your category, you have picked the cliché.

### 4.2 Logo concept methods, with a hard count

Lines 161–246: **monogram + meaning · product action · metaphor fusion · negative space
· construction geometry**, governed by "Use one or combine two maximum." A numeric
constraint on combination is exactly our house form, and it generalizes: our collision
already says two parents, never three.

### 4.3 Panel rhythm — "do not make every panel equally loud"

Lines 248–270:

> A strong brand-kit board should feel like a curated sequence … The board should have
> rhythm: quiet · functional · emotional · technical · atmospheric · detailed.
>
> Do not make every panel equally loud.

That single line is a better statement of section rhythm than either the web skill's
§10 or `image-to-code`'s §31, both of which take a paragraph to say less. Take the
sentence.

### 4.4 Color discipline

Lines 661–687:

> Default: base color · primary accent · secondary accent · neutrals
>
> Rules: **accents must repeat across panels** · no random rainbow unless requested · no
> generic purple-blue AI glow unless appropriate · **one accent can carry the entire
> system**

Plus eight named reference palettes that are useful as sanity checks on a sampled
palette: "black + cyan + muted coral · black + red + cream + blue · forest green + lime
+ fog gray · navy + white + steel · ivory + deep blue + red + gold · black + lilac +
soft purple · black + amber + red · charcoal + white + pale blue."

### 4.5 Reference usage — an anti-plagiarism procedure

Lines 709–732:

> **Extract:** layout rhythm · grid style · spacing · typography scale · visual density
> · logo placement · amount of text · image treatment · accent color logic ·
> brand-system behavior
>
> **Do not copy:** exact logo · exact brand name · exact composition · exact slogan ·
> unique visual asset
>
> Use references as quality training, not as templates.

A clean two-column split of what is transferable from a reference and what is theft.
Our `§3` (reinvent every component) and anti-positioning say adjacent things; this says
it operationally and should go in `STYLES.md` next to subversion.

### 4.6 The only literal prompt scaffold in the corpus

Lines 736–777 — a fill-in template (brand strategy / layout / panels / visual mode /
palette / style / typography / logo). Structurally useful as a shape for our
`surface-designer` prompt block, even though the content is identity-specific:
**subject → strategy fields → layout → contents → mode → palette → style → type**. The
generalizable insight is that strategy fields come *before* visual fields in the prompt,
so the model conditions on meaning before style.

---

## 5. What they cover that our spec does not

| Coverage | Where | Our gap |
|---|---|---|
| Platform mode decided before anything else | mobile `SKILL.md:152-192` | Spec forks on surface *class*, never on platform |
| Safe areas / system regions | mobile `SKILL.md:479-498` | Nothing. A mobile image with no reserved system bands reads as a poster |
| Device mockup framing discipline | mobile `SKILL.md:349-405` | `surface-designer` has no framing rule at all |
| Ordered screen flow with transitions | mobile `SKILL.md:323-345` | Our surfaces are a set, not a path |
| Sixteen-field design bible | mobile `SKILL.md:260-286` | `DIRECTION.md` lacks radius, icon, shadow, nav model, card/list behavior |
| Anti-repeat thresholds across a set | web `SKILL.md:902-910` | Spec says "never a compressed board" but nothing about set-level sameness |
| Composition anchor / background mode menus | web `SKILL.md:242-271` | No per-image composition vocabulary |
| Brief adjective → image parameters | web `SKILL.md:115-161` | webcrab's picker chooses a style; nothing maps style → image parameters |
| Gradient allow/ban fence | web `SKILL.md:723-740` | Guardrails inherited from portfolio.me do not name gradients |
| Copy and fake-brand ban lists | web `SKILL.md:546-565`, mobile `SKILL.md:733-748` | Spec explicitly drops anti-slop prose — but images contain text (§2.10) |
| Canvas aspect ratio guidance | web `SKILL.md:417-428` | "One horizontal image" is unresolved for portrait surfaces (§2.3) |
| Image extraction spec | `image-to-code:320-365` | `DIRECTION.md` field list is thinner than what a builder needs |
| Anti-drift at build time | `image-to-code:860-877` | Nothing — and the handoff *is* our deliverable |
| Detail/extraction image as an artifact class | `image-to-code:259-286` | One image per surface, no second render defined |
| Missing-detail resolution order | `image-to-code:880-894` | Undefined |
| Announce N before generating | web `SKILL.md:918` | Undefined |
| Text-in-image sparsity as a model constraint | `brandkit:556-577` | Undefined |
| Category → symbol derivation | `brandkit:117-128` | `TRANSLATE.md` row 6 assumes a logo exists |
| Reference: extract-vs-copy split | `brandkit:709-732` | Adjacent to `§3` but not operational |
| Iconography stroke-or-fill consistency | mobile `SKILL.md:687-710` | Undefined |
| Mobile category clichés | mobile `SKILL.md:1205-1259` | Cliché table planned but has no mobile rows |

---

## 6. What to steal, ranked

| # | Steal | From | Into | Form |
|---|---|---|---|---|
| 1 | **Platform mode as a required pre-decision** (iOS / Android / cross-platform neutral, each with its bias list) | mobile §2 | `agents/surface-designer.md`, recorded in `DIRECTION.md` | Decision procedure, 3 branches |
| 2 | **Safe-area band rule** — status / title / content / bottom-nav, four bands visible or reserved | mobile §13 | `agents/surface-designer.md` + `TOOLS.md` §10 | Checkable rule |
| 3 | **Set-level anti-repeat check** with numeric thresholds and a stated exemption | web §18 | `loops/01-direction.md`, run by the conductor on the returned set | Checkable rule |
| 4 | **The mobile failure table** (§1.17 above) — eleven failures, each with why it persists and its opening | mobile preamble + §21 + §34 | `STYLES.md` cliché table, mobile rows | Named failures with openings |
| 5 | **Extraction list inverted into `DIRECTION.md` fields** — every value a builder would otherwise have to OCR gets written as a number | `image-to-code` §9, §21–25 | `loops/01-direction.md` (`DIRECTION.md` schema) | Checkable rule |
| 6 | **Anti-drift clause at handoff** — seven do-nots + "faithful, not inspired by" | `image-to-code` §26–27 | `DIRECTION.md` closing section, `CRAFT.md` | Named failure with opening |
| 7 | **Device mockup framing rules** — inverted default (bare screen unless physicality is load-bearing), thin bezel, one device style, consistent scale, even margins, never touching the canvas edge | mobile §9–10 | `agents/surface-designer.md` | Checkable rules |
| 8 | **Text-in-image constraints** — realistic lengths, minimal count, the copy and fake-brand ban lists | brandkit text rules + web §8 + mobile §21 | `agents/surface-designer.md` prompt block | Checkable rule. Fixes the `§11` gap (§2.10) |
| 9 | **Composition anchor + background mode menus, one pick each per surface, logged** | web §2 | Menus in `STYLES.md`, picking in `agents/surface-designer.md`, logging in `loops/01-direction.md` | Menu + procedure |
| 10 | **Sixteen-field design bible** as the consistency lock, restated verbatim in every prompt of a set | mobile §6–7 | `loops/01-direction.md` | Checkable rule |
| 11 | **Brief adjective → hero scale / background mode / gradient policy / composition** | web §1 | `STYLES.md`, appended to "Picking one" as its output half | Decision table |
| 12 | **Type-size floor with the five-step escape ladder**, plus real numbers (17pt/16sp body, 44pt/48dp targets) which the source lacks | mobile §29 + systemcicy §10 | `TOOLS.md` §10, `STYLES.md` style-under-density | Checkable rule |
| 13 | **Screen-flow ordering** — surfaces as a path with named transitions; a surface with no inbound transition is entry or error | mobile §8 | `loops/01-direction.md` | Procedure |
| 14 | **Announce N before generating**, label each "Surface X of N" | web §19 | `loops/01-direction.md` | Checkable rule |
| 15 | **Detail/extraction image** as a permitted second render per surface + the missing-detail resolution order | `image-to-code` §7, §28 | `loops/01-direction.md`, `agents/surface-designer.md` | Procedure |
| 16 | **Aspect ratio per surface class** (§2.3 table), resolving the portrait conflict | new, forced by web §5 | `loops/01-direction.md` | Checkable rule |
| 17 | **Gradient allow/ban fence** | web §13 | `STYLES.md` guardrails | Checkable rule |
| 18 | **Reference extract-vs-copy split** | brandkit | `STYLES.md`, beside subversion | Procedure |
| 19 | **Panel rhythm sentence** — "do not make every panel equally loud" | brandkit | `STYLES.md` section rhythm | Rule |
| 20 | **Category → symbol table** as a cliché cross-check | brandkit | `TRANSLATE.md` row 4 note | Optional |

**No new file.** Everything above lands in the five files already planned. Mobile does
not need a `MOBILE.md`: platform mode, safe areas, and framing are image-generation
rules (`agents/surface-designer.md`); touch, density, and field use extend `TOOLS.md`
§10; the failures extend the `STYLES.md` cliché table; the flow and the schema extend
`loops/01-direction.md`.

---

## 7. What they get wrong

**They are lists, not procedures.** 4,478 lines contain roughly three real decision
procedures — mobile §2 (platform mode), web §1 (brief mapping), `image-to-code` §28
(ambiguity order) — and about six checkable rules. Everything else is adjective piles.
The mobile skill opens with twelve of them in a row: "app-native · premium · clean ·
highly intentional · visually strong · readable · believable · flow-aware ·
platform-aware · creatively art-directed · non-generic · consistent" (lines 36–49). An
agent cannot check any of those and so will not.

**The numeric dials are theatre.** `DESIGN_VARIANCE: 8`, `VISUAL_DENSITY: 3`,
`NON_GENERICITY: 10`, `CONTENT_FIRST_MOCKUP_BALANCE: 10` — no unit, no consumer, no
verification. Nothing downstream reads them and nothing can tell whether an 8 was hit.
They are a confidence display. Do not copy the mechanism; copy only the *directional*
information in it (mobile density 3 < web density 4 is a true and useful claim about
phones).

**Zero accessibility, in all four files.** `grep -Ei "accessib|wcag|4\.5:1|screen
reader|voiceover|talkback|reduced motion|dynamic type"` returns nothing across 4,478
lines. "Contrast" appears 18 times, always as visual tension ("strong scale contrast",
"keep contrast intentional"), never as a ratio. Our accessibility rule is hard and
unskippable; that alone puts our floor above their ceiling.

**Zero measurements.** `grep -Ec "[0-9]+ ?(px|pt|dp|rem|sp)"` returns 0 in every file.
A 1,465-line mobile design skill that never names a touch-target size or a body type
size is telling the model to have taste rather than giving it a specification.

**Nothing is verified.** No screenshot review against the spec, no contrast check, no
frame-rate measurement, no byte budget, no human gate. The closest thing is "verify
internally" before output — self-assessment by the same model that produced the work.
Our two gates, the measured prototypes, and the ship/cut/ship-with-caveat verdict are
categorically stronger, and this is the biggest structural advantage we have.

**`image-to-code` and `imagegen-frontend-web` are the same file, forked.** 191 lines are
literally identical; the variation engine (web §2 / i2c §12), the section packs (web §15
/ i2c §33), the slop lists (web §8 / i2c §29), and the typography discipline sections
are near-verbatim duplicates. They have already drifted — the web fork gained
composition anchors, background modes, narrative spine, and the anti-repeat check; the
code fork gained the extraction rules and anti-drift — and neither got the other's
additions. **This is our spec's opening paragraph, happening to somebody else.** Worth
citing in the README as the case for merging.

**The suite contradicts itself.** `brandkit` defaults to a 3×3 grid board (lines 73–92)
— exactly the "compressed board with tiny unreadable text" that the web and mobile
skills ban as their primary failure mode. Nothing reconciles this.

**Bans without openings.** "Do not default to generic developer-style icon packs or
bland Lucide-like icon vibes" (mobile §20) tells a model what not to draw and gives it
nowhere to go, so it draws the same icons with a different stroke weight. Same for "the
design should not feel like a default template" (§24) and "avoid generic color choices"
(§1). Every ban we take must arrive with its opening attached.

**"Do not be lazy" is not an instruction.** It appears in some form ten times across the
mobile and `image-to-code` files ("Do not be lazy with screen count", "Do not be lazy
with image count", "Never reduce screen count just for convenience"). The web skill
solves the same problem properly, by making the model commit to N out loud before
generating (§19 step 3). Mechanism beats exhortation; take the mechanism, drop the
scolding.

**The device-frame default is wrong for design review.** A phone bezel consumes ~30% of
the canvas and pulls the image model's fidelity toward rendering a photorealistic
handset instead of the interface under review. The skill knows this — it invented
`CONTENT_FIRST_MOCKUP_BALANCE: 10` and warns against "device frames that dominate more
than the actual screen content" — but keeps the frame as the default anyway. Invert it.

**`image-to-code` answers ambiguity with more images.** "If something is unclear,
generate another image before coding" (§8, line 308) is expensive, slow, and still
produces an artifact that has to be interpreted. The number was known at design time.
Write it down once instead.

**Unmaintained.** `imagegen-frontend-web` §19 has two steps numbered 5 (lines 920–921).
Small, but it is the kind of thing that survives only in a file nobody has re-read.
