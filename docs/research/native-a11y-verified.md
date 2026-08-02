# Research — native mobile accessibility as a design decision (legal half unresearched)
**Date:** 2026-08-01  
**Method:** deep-research harness, resumed twice. Final run: 111/111 agents, 0 errors, full synthesis.

## Coverage warning

The question had two halves. **Half one (native platform accessibility) is well answered.** **Half two — EAA, ADA Title II, Section 508, and WCAG 2.2's legal status — returned zero surviving claims across every attempt.** Marked unresearched, not absent. The legal-enforcement research question is still open.

---

## Summary

Verified evidence answers only HALF ONE of the two-part question (native platform accessibility as a design decision) in depth; HALF TWO (EAA, ADA Title II, Section 508, WCAG 2.2 legal status) has zero surviving claims, not even a refuted one, so it is effectively unresearched in this evidence set. On HALF ONE: Apple's Dynamic Type ramp is fully specified (7 standard sizes plus 5 accessibility sizes AX1-AX5; Body text 17pt to 53pt, about 311 percent at AX5, crossing 200 percent already at AX3), and Apple's HIG and App Store Connect docs give designers concrete, quoted instructions to switch side-by-side layouts to vertical stacks, allow text to wrap to 2+ lines instead of truncating, and never rely on system Zoom or Hover Text to claim Larger Text support - a native-specific rule with no web equivalent, since browser zoom and reflow is an accepted mechanism for WCAG 1.4.4 and 1.4.10. VoiceOver guidance requires two separate designer decisions not implied by any web checklist: explicit grouping and ordering of elements (default order is layout-derived, top-to-bottom left-to-right, so unpaired image plus caption elements read as two disjoint streams), and keeping accessibility labels free of control-type or state words (which belong in traits, not labels, to avoid doubled speech like checkbox-checkbox) while treating value as a separate channel from label. Android 14 raised max font scaling to 200 percent via a nonlinear curve that breaks sp-value additivity (4sp+20sp does not equal 24sp) and requires apps to be explicitly re-tested at 200 percent, and Android's own design guidance sets a 48dp minimum touch target (extending past the visual bounds if needed) and a 12sp body-text floor - a stricter, more literally enforced regime than Apple's 44x44pt/28x28pt table, which Apple itself frames as aspirational (strive to meet) rather than a hard minimum.

## Caveats

Two HALF ONE items landed at split 2-1 votes rather than unanimous 3-0 (the WWDC24 vertical-stack claim, and the Android sp/12sp floor claim) - treat those two as slightly less certain, though in both cases the dissent appears to be about wording strength ('requires' vs Apple/Google's softer 'consider'/'specify'), not about the underlying fact. Several claims require careful verb-softening when reused: Apple's 44x44pt minimum is aspirational (strive to meet), not a hard floor; the 200/140 percent text-enlargement target is Ideally, not must; and the 28x28pt visionOS control-size figure conflicts with a 60x60pt hit-region figure on Apple's own Buttons page, so control size and tappable hit region must not be conflated when comparing to Android's 48dp. Six other candidate claims (VoiceOver rotor/heading structure, reachability of every element via rotor plus linear navigation, custom-actions-vs-individual-navigation for grouped elements, Android decorative-image null-description convention, Android semantic heading markup for structural navigation) were tested and refuted (0-3 or 1-2 votes) - the specific wording researched did not hold up, not necessarily that the underlying practice is false; these topics remain open for re-research with more precise claims. Most significant caveat: HALF TWO of the research question (EAA, ADA Title II, Section 508, WCAG 2.2 binding status) has no surviving evidence at all in this claim set - the findings above cover HALF ONE only. Time-sensitivity: the Apple HIG and App Store Connect sources show live edit dates as recent as December 2025 and are current as of the August 2026 fetch; the Android 14 features page describes a 2023-era platform change that remains current stable guidance through 2026 with no indication of reversal.

---

## Findings

### 1. Apple's Dynamic Type ramp has 7 standard sizes (xSmall through xxxLarge, default is Large) plus 5 accessibility sizes AX1-AX5, for 12 total sizes a layout must survive. Body text scales 17pt to 53pt (about 3.1x, crossing 200 percent already at AX3 and exceeding 300 percent at AX5); Large Title scales 34pt to 60pt (about 1.76x) - scaling is non-uniform across text styles, and at the top of the ramp Body (53pt) nearly equals default-size Headline/Title 3 and exceeds default Large Title.

**Confidence:** high

Three independent primary Apple sources (HIG typography spec table, WWDC24 Get started with Dynamic Type session, App Store Connect Larger Text evaluation criteria) corroborate the same 7+5=12 size structure and percentage/point figures, all at unanimous 3-0 verification votes. Gives designers the concrete numeric commitment the question asked for: a layout must remain usable with body text at roughly 3x its default size, non-uniformly relative to other styles.

**Sources:**
- https://developer.apple.com/design/human-interface-guidelines/typography
- https://developer.apple.com/videos/play/wwdc2024/10074/
- https://developer.apple.com/help/app-store-connect/manage-app-accessibility/larger-text-evaluation-criteria/

### 2. Apple's stated design guidance for surviving large accessibility text sizes is to switch side-by-side or horizontal layouts to a vertical stack so each element gets full display width, to let text wrap to two or more lines rather than truncate, and to reduce multicolumn text to fewer columns - a layout decision (stack-axis change), not merely a font-scaling decision.

**Confidence:** high

Four related claims (HIG typography stacked-layout bullet, WWDC24 HStack-to-VStack code example gated on dynamicTypeSize.isAccessibilitySize, and two App Store Connect evaluation-criteria bullets on overlap/wrapping and truncation) converge from three separate Apple documents, three at 3-0 and one at 2-1. Caveat: HIG language is advisory (Consider adjusting...) not a hard mandate, though App Store Connect converts the same guidance into pass/fail evaluation criteria for the Larger Text label.

**Sources:**
- https://developer.apple.com/design/human-interface-guidelines/typography
- https://developer.apple.com/videos/play/wwdc2024/10074/
- https://developer.apple.com/help/app-store-connect/manage-app-accessibility/larger-text-evaluation-criteria/

### 3. Apple sets an explicit text-enlargement target of at least 200 percent (140 percent on watchOS) achievable via custom UI or Dynamic Type, and explicitly disallows counting on system-level magnification (Zoom, Hover Text) to satisfy this - a native-specific requirement with no direct web-checklist equivalent, since browser zoom and reflow is an accepted mechanism for WCAG 1.4.4 Resize Text and 1.4.10 Reflow.

**Confidence:** high

Both claims verified 3-0 against verbatim primary-source quotes. Apple's own word for the 200/140 percent figures is Ideally (aspirational), but App Store Connect converts the same numbers into a pass/fail bar for the Larger Text badge. Directly answers part 4 of the research question: a web-derived checklist would treat OS/browser zoom as sufficient, but Apple explicitly excludes it from counting toward native app compliance.

**Sources:**
- https://developer.apple.com/design/human-interface-guidelines/accessibility
- https://developer.apple.com/help/app-store-connect/manage-app-accessibility/larger-text-evaluation-criteria/

### 4. Apple publishes a per-platform table of default/minimum control sizes (iOS/iPadOS 44x44pt default / 28x28pt minimum; macOS 28x28/20x20; tvOS 66x66/56x56; visionOS 60x60/28x28; watchOS 44x44/28x28), framed as aspirational (strive to meet) rather than a hard minimum, and distinct from the separate 44x44pt (60x60pt on visionOS) button hit-region rule on Apple's Buttons page - control size and tappable hit area are different measures, so the like-for-like comparison to Android's 48dp is Apple's 44pt hit region, not the 28pt control-size minimum.

**Confidence:** high

Verified 3-0, verbatim table match. Verifier flagged two qualifiers to preserve downstream: (1) hard minimum overstates Apple's actual verb (strive to meet); (2) the 28x28pt figure is control size, not hit region - conflating it with Android's 48dp understates Apple's actual requirement. visionOS shows a direct internal inconsistency between two Apple pages (28x28pt control minimum vs 60x60pt hit region) that must be flagged, not silently resolved.

**Sources:**
- https://developer.apple.com/design/human-interface-guidelines/accessibility
- https://developer.apple.com/design/human-interface-guidelines/buttons
- https://developer.android.com/guide/topics/ui/accessibility/apps

### 5. VoiceOver's default reading order is derived from layout (top-to-bottom, left-to-right in the user's active locale), so a designer must explicitly decide grouping - auditing the UI for relationships conveyed only by visual proximity/alignment and describing those relationships to VoiceOver - or visually-paired elements (e.g. image plus caption) will be read as two separate streams (all images, then all captions).

**Confidence:** high

Two related claims from the same live HIG VoiceOver page, both verified 3-0 with verbatim quote matches (including reproducing Apple's own 'in the their' typo, confirming direct transcription). Squarely a designer-level decision distinct from developer implementation: Apple frames it as 'Specify how elements are grouped, ordered, or linked' at the design-guideline level and defers the how (accessibilityElements, sortPriority APIs) to separate developer-guidance links.

**Sources:**
- https://developer.apple.com/design/human-interface-guidelines/voiceover

### 6. Apple's VoiceOver evaluation criteria require a label distinct from a control's value (label names the field, e.g. phone number; value carries content, e.g. 555-555-1212), and separately prohibit encoding control type or state (e.g. checkbox, checked) inside the label - that information belongs in accessibility traits - because duplicating it in the label produces redundant doubled speech like checkbox-checkbox.

**Confidence:** high

Both claims verified 3-0 with verbatim quotes from Apple's App Store Connect VoiceOver evaluation criteria page, independently corroborated by third-party iOS-accessibility practitioner sources (Deque, mobilea11y, 24a11y). Directly answers the requested label-vs-hint-vs-value distinction, though the source is Apple's App Store Connect help center rather than the HIG page itself - still primary and current, a different Apple property.

**Sources:**
- https://developer.apple.com/help/app-store-connect/manage-app-accessibility/voiceover-evaluation-criteria/

### 7. Android 14 raised maximum font scaling to 200 percent and applies a nonlinear scaling curve so large text scales less aggressively than small text (preserving type hierarchy and preventing cutoff/unreadable oversized text); a direct consequence is that sp values are no longer additive (4sp+20sp may not equal 24sp), so sp must not be used for padding or view heights that assume implicit padding, and apps must still be explicitly UI-tested at the 200 percent maximum even if they already use sp (which gets the improvement automatically).

**Confidence:** high

Three tightly related claims, all verified 3-0 with verbatim quote matches from the same live Android 14 features page. Surfaces a native-only pitfall - non-additive sp arithmetic breaking padding/height math - that has no web-CSS analogue and that a web-derived accessibility checklist would not catch.

**Sources:**
- https://developer.android.com/about/versions/14/features

### 8. Android's official design guidance sets a minimum touch target of 48dp and explicitly requires it be met even when it extends past the visible bounds of the UI element; separately, font sizes should be declared in sp (not dp/px) so the user's OS font-scaling setting applies at all, with a floor of 12sp for body text aligned to the Material type scale.

**Confidence:** high

The 48dp claim verified 3-0 verbatim; the sp/12sp claim verified 2-1 (verbatim quote confirmed, dissent likely on 'requires' vs the source's softer 'specify' framing). Requested WCAG-comparison point: Android's 48dp is commonly compared to WCAG 2.5.5/2.5.8 target-size criteria, but no primary source in this pass directly bridges Android's 48dp to a specific WCAG success-criterion number - that mapping is common practice, not confirmed here against WCAG text itself.

**Sources:**
- https://developer.android.com/design/ui/mobile/guides/foundations/accessibility

### 9. No verified evidence exists on HALF TWO of the research question: the European Accessibility Act's June 2025 applicability date and scope, the microenterprise exemption, EN 301 549's relationship to WCAG, the DOJ ADA Title II web rule (28 CFR 35 subpart H), its named technical standard and size-tiered compliance deadlines, Section 508's current referenced standard, or whether any binding instrument names WCAG 2.2.

**Confidence:** low

Zero claims about EAA/EUR-Lex, ada.gov/Federal Register, or ETSI EN 301 549 appear in either the confirmed or refuted claim lists supplied for synthesis - a gap in the underlying research, not a disagreement resolved against those claims. All 19 confirmed and 6 refuted claims cluster exclusively on Apple/Android native accessibility topics (HALF ONE). This half of the question is unanswered and needs a dedicated research pass against EUR-Lex, ada.gov, and ETSI primary texts before it can be reported with any confidence.

---

## Refuted

- **Apple sets a concrete, testable commitment for surviving the largest accessibility sizes: the amount of useful text displayed at the largest accessibility font size should equal what is displayed at the largest standard font size, and truncation in scrollable regions is disallowed unless a separate full-content view exists.**
- **The VoiceOver rotor is a navigation control that lets people move through content by headings, links, and other content types, and Apple states apps must identify those elements to the rotor for it to work; the rotor can also bring up the braille keyboard.**
- **Apple's criteria require every visible element to be reachable both linearly (swipe/VO+Arrow) and via the VoiceOver rotor, require the user to be able to navigate away from any element, and require that forward and backward traversal never skip items or loop repeatedly.**
- **For grouped elements, Apple gives designers a binary choice: either each item in the group is individually navigable, or the grouped behaviors are exposed as VoiceOver custom actions (e.g. reply, forward, delete on a single grouped row).**
- **Android's designer-facing accessibility guidance requires textual descriptions for icons and images, and requires decorative items to have their description set to null so screen readers skip them — a labelling decision distinct from web alt-text conventions.**
- **Android's official accessibility principles require designers/developers to mark heading elements semantically (the `heading` property in the `semantics` modifier), because accessibility-service users can then jump between headings instead of paragraphs or words — Android's structural-navigation analogue to the iOS VoiceOver rotor.**

---

## Open questions

- What does the European Accessibility Act (Directive EU 2019/882) actually say about June 2025 applicability, in-scope products and services, and the microenterprise exemption thresholds, per EUR-Lex primary text - entirely unresearched in this pass.
- What technical standard does the DOJ's ADA Title II web rule (28 CFR 35 subpart H) name, and what are the compliance deadlines by public-entity size, per ada.gov and the Federal Register - entirely unresearched in this pass.
- What standard does Section 508 currently reference, and does any binding legal instrument (EAA, Title II rule, Section 508, or other) name WCAG 2.2 rather than 2.1 or 2.0 - entirely unresearched in this pass.
- How does EN 301 549 map to WCAG levels and versions, and is there a primary-source bridge between Android's 48dp touch-target recommendation and a specific WCAG 2.5.5/2.5.8 success-criterion number - neither was resolved with primary-source confirmation.
- What does Apple's HIG say specifically about the VoiceOver rotor and heading structure, and what do Android's docs say about content-description conventions for decorative images and semantic heading navigation - these were researched but the specific claims tested did not survive verification (refuted 0-3 or 1-2), so they need re-approaching with different claim wording rather than being treated as settled either way.

---

## Sources

- [primary] https://developer.apple.com/design/human-interface-guidelines/typography — 5 claims
- [primary] https://developer.apple.com/design/human-interface-guidelines/accessibility — 5 claims
- [primary] https://developer.apple.com/design/human-interface-guidelines/voiceover — 5 claims
- [primary] https://developer.apple.com/videos/play/wwdc2024/10074/ — 5 claims
- [primary] https://developer.apple.com/help/app-store-connect/manage-app-accessibility/larger-text-evaluation-criteria/ — 5 claims
- [primary] https://developer.apple.com/help/app-store-connect/manage-app-accessibility/voiceover-evaluation-criteria/ — 5 claims
- [primary] https://developer.android.com/about/versions/14/features — 5 claims
- [primary] https://developer.android.com/design/ui/mobile/guides/foundations/accessibility — 5 claims
- [primary] https://developer.android.com/guide/topics/ui/accessibility/principles — 5 claims
- [primary] https://developer.android.com/guide/topics/ui/accessibility/apps — 5 claims
- [primary] https://developer.android.com/develop/ui/compose/accessibility/scalable-content — 5 claims
- [primary] https://developer.android.com/guide/topics/ui/accessibility/testing — 5 claims
- [primary] https://www.w3.org/TR/wcag2mobile-22/ — 5 claims
- [primary] https://www.w3.org/TR/wcag2ict-22/ — 5 claims
- [primary] https://www.w3.org/TR/mobile-accessibility-mapping/ — 5 claims
- [primary] https://eur-lex.europa.eu/legal-content/EN/TXT/HTML/?uri=CELEX%3A32019L0882 — 5 claims
- [primary] https://commission.europa.eu/strategy-and-policy/policies/justice-and-fundamental-rights/disability/european-accessibility-act-eaa_en — 4 claims
- [primary] https://ec.europa.eu/social/main.jsp?catId=1202&intPageId=5581&langId=en — 5 claims
- [primary] https://www.etsi.org/deliver/etsi_en/301500_301599/301549/03.02.01_60/en_301549v030201p.pdf — 5 claims
- [primary] https://www.etsi.org/deliver/etsi_en/301500_301599/301549/04.01.00_20/en_301549v040100ev.pdf — 5 claims
- [primary] https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32021D1339 — 5 claims
- [primary] https://digital-strategy.ec.europa.eu/en/policies/latest-changes-accessibility-standard — 5 claims
- [primary] https://www.federalregister.gov/documents/2026/04/20/2026-07663/extension-of-compliance-dates-for-nondiscrimination-on-the-basis-of-disability-accessibility-of-web — 5 claims
- [primary] https://www.ecfr.gov/current/title-28/chapter-I/part-35/subpart-H — 5 claims
- [primary] https://www.ada.gov/resources/2024-03-08-web-rule/ — 5 claims
- [primary] https://www.ada.gov/resources/small-entity-compliance-guide/ — 5 claims
- [primary] https://www.section508.gov/develop/applicability-conformance/ — 5 claims
- [primary] https://www.access-board.gov/news/2023/11/27/w3c-wcag-2-2-now-available/ — 5 claims
