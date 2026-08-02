# Research — native mobile design law: Liquid Glass + M3 Expressive, full synthesis
**Date:** 2026-08-01  
**Method:** deep-research harness, resumed twice. Final run: 109/109 agents, 0 errors, full synthesis.

## Coverage warning

Of the seven areas asked, only two are substantively covered: **Liquid Glass** and **Material 3 Expressive**. Navigation models, numeric specs (touch targets, type scale, spacing), safe areas / edge-to-edge, and gesture conflicts returned no surviving claims in this batch — treat as unresearched. See `platform-numbers-verified.md` and `mobile-native-verified.md` for what was pulled by hand on the numeric side.

## Cross-validation note

This independently confirms the hand-verified Liquid Glass findings from `mobile-native-verified.md` (content-layer prohibition, sparing use on custom controls, never-stack-glass-on-glass) against a much larger primary-source set including WWDC25 session transcripts — and goes further, into **iOS 27** content the manual pass never reached. The two methods agree everywhere they overlap.

---

## Summary

Of the seven areas requested, the verified claim set that survived adversarial review substantively covers only two: Apple's Liquid Glass material (WWDC 2025 / iOS 26 HIG) and Google's Material 3 Expressive. Liquid Glass is confirmed as a distinct functional layer — not a content-layer treatment — that floats above app content to house navigation and controls (tab bars, sidebars, toolbars), ships in exactly two variants (Regular, adaptive default; Clear, non-adaptive, media-only with a 35%-opacity dimming layer), must never be stacked on itself, and comes with explicit "don't" rules (don't put it in the content layer, don't overuse it on custom controls, don't decorate bars the system already gives weight to) plus a three-type concentric corner-radius system. Material 3 Expressive is confirmed as an additive evolution of M3 (not a new major version / "M4"), backed by Google's own claim of 46 studies and 18,000+ participants showing up to 4x faster element location in eye-tracking tests, with Google's own caveat that expressive styling cannot fix or override broken interaction paradigms. No claims in this batch address navigation-model choice (tab bar vs. bottom nav, back-stack/predictive-back, sheets, split view vs. nav rail), the numeric touch-target/type-scale/spacing specs, safe-area/edge-to-edge system regions, gesture-conflict rules, or genuine cross-platform divergence — these five of the seven requested areas returned zero surviving verified claims and must be treated as an open gap, not as "platforms agree" or "no differences exist."

## Caveats

This synthesis is built entirely from the pre-verified claim set supplied for merging — no new source-checking was performed in this pass. Two structural gaps matter: (1) Five of the seven requested research areas — navigation-model selection beyond the single iOS tab-bar claim (Android bottom nav, back stack, predictive back, sheets/modals, NavigationSplitView vs. nav rail), the numeric specs (44pt vs 48dp touch targets, type scale, spacing/margins, corner-radius conventions outside Apple's shape-type system), safe areas/edge-to-edge/Android 15 mandatory edge-to-edge, gesture-conflict rules, and genuine cross-platform divergence — returned zero surviving verified claims in this batch. That is a coverage gap in the underlying research, not a finding that those areas are settled, agree across platforms, or don't matter; a downstream reader must not infer "no differences" from silence. (2) All Liquid Glass sources are Apple's own HIG/developer documentation and WWDC session transcripts (several pulled from JS-rendered pages via their backing JSON/data feeds since the HTML shells return empty to naive fetches) — appropriately primary and authoritative for definitional/normative design-law claims, but self-reported by the platform owner, same as the M3 Expressive research statistics (46 studies, 18,000 participants, 4x eye-tracking result) which are Google's own unaudited claims about its own system, not independently replicated research. (3) Two included findings carry a 2-1 vote (automatic Liquid Glass adoption on standard controls; M3 Expressive's "don't break interaction paradigms" constraint) — treat these as slightly less airtight than the unanimous 3-0 findings, though no counter-evidence was found in either case. (4) Several near-duplicate draft claims were explicitly refuted during verification (e.g., a claim that Liquid Glass color restraint exists specifically to prevent "saturating the glass layer," and a claim ranking Materials as a first-class HIG foundation alongside Accessibility/Color/Typography) — downstream text should not reintroduce those specific framings. (5) Time-sensitivity: all Liquid Glass sources were fetched 2026-08-01/02, after WWDC 2026 (iOS 27), and were confirmed still current at that point, but Apple has an active pattern of refining Liquid Glass (transparency/intensity controls, mandatory adoption in iOS 27) — re-verify before relying on this for anything beyond mid-2026.

---

## Findings

### 1. Liquid Glass is Apple's current design material (introduced WWDC 2025 for iOS 26 and shared across iOS, iPadOS, macOS, tvOS, watchOS): a single dynamic material combining glass optics with fluidity, forming a distinct functional layer for controls and navigation (tab bars, sidebars, toolbars) that floats above the content layer. It is a control/chrome-surface material, not a decorative background or wallpaper treatment — content is meant to scroll and peek through beneath it while the material itself brings structure and clarity without stealing focus.

**Confidence:** high

Merges 5 separately-verified claims (votes 3-0, 3-0, 3-0, 3-0, 3-0) all pulled from live Apple primary sources (HIG page, two TechnologyOverview docs, a WWDC25 session transcript, and the HIG root page's own image alt-text), each independently confirming the same definitional model: functional layer above content, not a content-layer or wallpaper effect. Verified as current post-WWDC 2026 (iOS 27 refines, does not replace, this model).

**Sources:**
- https://developer.apple.com/design/human-interface-guidelines/materials
- https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass
- https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass
- https://developer.apple.com/videos/play/wwdc2025/356/
- https://developer.apple.com/design/human-interface-guidelines

### 2. Liquid Glass is explicitly restricted to the navigation/control layer and must not be applied to content-layer elements (e.g., a table view, app backgrounds) because it muddies hierarchy; the one named exception is transient interactive controls (sliders, toggles) that adopt a Liquid Glass look only while active. The material ships in exactly two variants — Regular (adaptive, legible over any content, used for most system components including alerts/sidebars/popovers) and Clear (non-adaptive, permanently more transparent, valid only over bold/bright media-rich backgrounds, needs a dark dimming layer at ~35% opacity if content is bright) — and the two variants must never be mixed in the same interface.

**Confidence:** high

Merges 4 separately-verified claims (votes 3-0, 3-0, 3-0, 3-0) from the live HIG Materials page and the WWDC25 'Meet Liquid Glass' session transcript. The content-layer prohibition, the transient-control exception, the two-variant taxonomy, and the 35% dimming figure and 'never mixed' rule were each confirmed verbatim against primary text, with no contradicting revision found as of the 2026-08-01/02 fetch (post-WWDC 2026).

**Sources:**
- https://developer.apple.com/design/human-interface-guidelines/materials
- https://developer.apple.com/videos/play/wwdc2025/219/

### 3. Apple imposes usage discipline on designers: use Liquid Glass effects sparingly on custom controls (system components adopt it automatically; overusing it on multiple custom controls distracts from content — limit to the most important functional elements); never stack Liquid Glass on Liquid Glass (elements placed on top of glass must use fills, transparency, and vibrancy instead, not a second glass layer); and strip pre-existing custom bar decoration (extra backgrounds/borders) since the new system appearance supplies visual weight on its own — when building custom controls, apply the material to the control itself, not its inner views.

**Confidence:** high

Merges 3 separately-verified claims (votes 3-0, 3-0, 3-0) from the HIG Materials page and two WWDC25 session transcripts, each confirmed verbatim: 'use Liquid Glass effects sparingly... limit these effects to the most important functional elements'; 'always avoid glass on glass... use fills, transparency, and vibrancy'; and the bar-decoration cleanup instruction with 'apply the material directly to the control, not its inner views.'

**Sources:**
- https://developer.apple.com/design/human-interface-guidelines/materials
- https://developer.apple.com/videos/play/wwdc2025/219/
- https://developer.apple.com/videos/play/wwdc2025/356/

### 4. Apple's new layout system defines corner radius through three shape types rather than fixed per-component values: fixed shapes (constant radius), capsules (radius = half the container height), and concentric shapes (radius = parent radius minus padding). Nested containers (e.g., artwork in a card) should use concentric shapes so the system computes the correct inner radius automatically relative to the parent.

**Confidence:** high

Verified verbatim (vote 3-0) against the WWDC25 'Get to know the new design system' transcript, cross-checked with an independent WebSearch pass returning identical phrasing: 'fixed shapes have a constant corner radius. Capsules use a radius that's half the height of the container. And concentric shapes calculate their radius by subtracting padding from the parent's.'

**Sources:**
- https://developer.apple.com/videos/play/wwdc2025/356/

### 5. Liquid Glass is applied automatically by the system to standard SwiftUI/UIKit/AppKit controls and navigation elements — a designer does not choose whether the tab bar or sidebar gets the material, only where to extend it to custom elements (which requires explicit adoption, e.g. via glassEffect()/GlassEffectContainer). Within that layer, Apple instructs restraint on color specifically in controls and navigation so they stay legible and let underlying content's color 'infuse and shine through' rather than compete with it.

**Confidence:** medium

Two claims from the same primary source, each independently verified but with one dissenting vote apiece (votes 2-1 and 3-0 respectively — the automatic-adoption claim scored 2-1). Quotes confirmed verbatim: 'Standard components... pick up the appearance and behavior of this material automatically. You can also implement these effects in custom interface elements' and 'Be judicious with your use of color in controls and navigation so they stay legible and allow your content to infuse them and shine through.' Note a closely related but differently-worded color-restraint claim from a different source was refuted 0-3 in this same research run, so this narrower, directly-quoted version should be preferred over any paraphrase.

**Sources:**
- https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass

### 6. On iOS, the tab bar is reserved strictly for persistent, app-level destinations — screen-specific actions (e.g., a checkout button) must live with the content they act on, not in the tab bar, to keep the persistent/contextual distinction clear. As of iOS 26, Apple has added a dedicated Search tab at the bottom of the tab bar to make search quicker and easier to reach when content isn't visible upfront.

**Confidence:** high

Verified verbatim (vote 3-0) against the WWDC25 'Get to know the new design system' session transcript: 'Avoid placing screen-specific actions here—a checkout button, for example, belongs with the content it supports' and 'That's why iOS now includes a dedicated Search tab at the bottom.' This is the only navigation-model claim (of the research question's item 3) that survived verification in this batch; Android bottom-nav rules, back-stack/predictive-back behavior, sheet/modal conventions, and NavigationSplitView-vs-nav-rail guidance returned no surviving claims.

**Sources:**
- https://developer.apple.com/videos/play/wwdc2025/356/

### 7. Material 3 Expressive (Google, launched May 2025) is an evolution of Material 3, not a new major version — Google explicitly states M3 is not deprecated and Expressive is not 'M4.' A designer targeting Android in 2026 is still working within M3; Expressive is an additive layer of new components, color/typography/shape/motion tactics, and design guidance layered on top of the existing system, not a replacement for it.

**Confidence:** high

Verified verbatim (vote 3-0) against the live M3 blog, rendered via a JS-capable fetch since the page is a SPA: 'M3 Expressive is an evolution of the Material 3 design system... M3 Expressive isn't a new version of the system. We're not deprecating M3, and this isn't "M4."' Cross-checked live against the m3.material.io homepage on the research date, which still frames Expressive as additive.

**Sources:**
- https://m3.material.io/blog/building-with-m3-expressive

### 8. Google states M3 Expressive is its most-researched design-system update since Material's 2014 launch, based on 46 separate research studies with more than 18,000 participants worldwide (roughly 3 years of development, testing hundreds of design variants). Google also reports a specific usability result from eye-tracking studies: participants located key UI elements up to 4x faster in M3 Expressive designs than in the prior Material 3 baseline (e.g., finding a 'send email' button 4x faster).

**Confidence:** high

Merges 3 separately-verified claims (votes 3-0, 3-0, 3-0) from two independent Google primary sources that state the same 46-studies/18,000-participants figure. The 4x eye-tracking result and methodology (10 apps tested in both M3 and M3 Expressive versions, randomly ordered) confirmed verbatim on design.google. These are Google's own self-reported research claims about its own system, not independently audited — framed here as 'Google states,' not as third-party-verified fact.

**Sources:**
- https://design.google/library/expressive-material-design-google-research
- https://m3.material.io/blog/building-with-m3-expressive

### 9. Google's own guidance caps how far expressive styling can go: when basic interaction paradigms are broken, expressive design leads to poor usability or negative sentiment — i.e., Material 3 Expressive is a styling/emphasis layer meant to enhance proven interaction patterns, not license to override or replace established navigation/interaction conventions. Google states 'no amount of expressive design will beat basic functionality.'

**Confidence:** medium

Verified verbatim (vote 2-1, one dissent) against the primary source's 'Context still matters' section, including two named cautionary examples (a playlist redesign that broke a recognizable list pattern; email actions that lost usability when text labels were dropped for visual appeal).

**Sources:**
- https://design.google/library/expressive-material-design-google-research

---

## Refuted

- **Liquid Glass applies to the controls and navigation layer, not the content layer: standard SwiftUI/UIKit/AppKit controls and navigation elements adopt the material automatically, and only custom interface elements require explicit application.**
- **Apple instructs designers to restrain color in controls and navigation under Liquid Glass, because the material is meant to let underlying content show through and tint it — saturating the glass layer is the named failure mode.**
- **Apple frames Liquid Glass as a layer that sits over background content and refracts/bends what is behind it, establishing depth by layering rather than by opacity — stated in the alt text of the Materials foundation thumbnail on the HIG root.**
- **Materials is a first-class HIG "foundation" for designers, ranked on the root page alongside Accessibility, App icons, Color, Layout, and Typography, and Apple defines a material as a visual effect creating depth, layering, and hierarchy between foreground and background elements.**

---

## Open questions

- What are the verified primary-source touch-target minimums (Apple 44pt vs Material 48dp), default type scale/body text sizes, and spacing/margin baselines for iOS and Android as of 2026? No claim in this batch addresses this despite it being explicitly requested.
- What do developer.android.com and the Material 3 spec say about bottom navigation bar usage rules, Android's back stack, system back vs. predictive back gesture, and sheet/modal conventions — and how do they compare to the one verified iOS tab-bar rule found here?
- What is Apple's and Google's current primary-source guidance on safe areas, Dynamic Island/display-cutout handling, and Android 15+'s mandatory edge-to-edge requirement? Zero verified claims exist on this in the current batch.
- Where do iOS's interactive pop gesture and Android's back-swipe/predictive-back conflict with author-built horizontal affordances (carousels, swipe-to-delete), and what do the platform guidelines say a designer must do to avoid the conflict? This and the broader 'what genuinely can't be shared across platforms' question (research item 7) remain unanswered by any surviving claim.

---

## Sources

- [primary] https://developer.apple.com/design/human-interface-guidelines/materials — 5 claims
- [primary] https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass — 5 claims
- [primary] https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass — 5 claims
- [primary] https://developer.apple.com/videos/play/wwdc2025/356/ — 5 claims
- [primary] https://developer.apple.com/videos/play/wwdc2025/219/ — 5 claims
- [primary] https://developer.apple.com/design/human-interface-guidelines — 5 claims
- [primary] https://design.google/library/expressive-material-design-google-research — 5 claims
- [primary] https://m3.material.io/blog/building-with-m3-expressive — 5 claims
- [primary] https://m3.material.io/blog/m3-expressive-motion-theming — 5 claims
- [primary] https://developer.android.com/jetpack/androidx/releases/compose-material3 — 5 claims
- [primary] https://m3.material.io/styles/typography/type-scale-tokens — 5 claims
- [primary] https://blog.google/products-and-platforms/platforms/android/material-3-expressive-android-wearos-launch/ — 5 claims
- [primary] https://developer.android.com/develop/ui/views/touch-and-input/gestures/gesturenav — 5 claims
- [primary] https://developer.android.com/design/ui/mobile/guides/patterns/predictive-back — 5 claims
- [primary] https://developer.apple.com/design/human-interface-guidelines/tab-bars — 5 claims
- [primary] https://m3.material.io/components/navigation-rail/guidelines — 5 claims
- [primary] https://developer.apple.com/design/human-interface-guidelines/sheets — 5 claims
- [primary] https://developer.apple.com/design/human-interface-guidelines/gestures — 5 claims
- [primary] https://developer.apple.com/design/human-interface-guidelines/accessibility — 5 claims
- [primary] https://developer.android.com/design/ui/mobile/guides/foundations/accessibility — 5 claims
- [primary] https://developer.apple.com/design/human-interface-guidelines/typography — 5 claims
- [primary] https://m3.material.io/styles/spacing/tokens — 5 claims
- [primary] https://developer.android.com/about/versions/15/behavior-changes-15 — 5 claims
- [primary] https://developer.android.com/about/versions/16/behavior-changes-16 — 5 claims
- [primary] https://developer.android.com/design/ui/mobile/guides/layout-and-content/edge-to-edge — 5 claims
- [primary] https://developer.apple.com/design/human-interface-guidelines/layout — 5 claims
- [primary] https://developer.android.com/develop/ui/compose/system/insets — 5 claims
