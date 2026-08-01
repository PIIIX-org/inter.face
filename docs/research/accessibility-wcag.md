# Research — design-time accessibility (part 1: WCAG 2.2 + 3.0)
**Date:** 2026-08-01  
**Method:** deep-research harness — 5 angles, 24 sources fetched, 120 claims extracted, 25 verified by 3-vote adversarial panel, 20 confirmed, 5 killed, 12 after synthesis.

> **COVERAGE WARNING.** This run answered 2 of the 8 areas asked. Areas 3–8 (ARIA APG, SPA focus management, live regions, accessible names, legal enforcement detail, native iOS/Android) returned **no claims that survived verification** and are UNRESEARCHED, not settled. They are re-run separately.

---

## Summary

The verified body of evidence covers only the first two of the eight requested areas — WCAG 2.2's new success criteria and WCAG 3.0's status — but covers them at normative-text depth from W3C primary sources. The design-time answer for WCAG 2.2 is concrete: six of the nine new criteria land at Level A/AA and each converts a formerly-implicit design decision into a measurable spec item — a 24x24 CSS px effective target area (2.5.8 AA), a visible non-drag affordance for every author-built drag interaction (2.5.7 AA), layout geometry or scroll-padding that keeps focused elements from being entirely covered by sticky chrome (2.4.11 AA), an authentication flow that never requires an unaided cognitive function test and never blocks paste or password managers (3.3.8 AA), re-use of previously entered data within a process (3.3.7 A), and consistently-placed help (3.2.6 A). WCAG 3.0 is a Working Draft dated 3 March 2026 whose own text says it "still has several years of work" and explicitly does not deprecate WCAG 2, so WCAG 2.2 AA is the operative 2026 design target while the binding legal instruments still name WCAG 2.1 (EU/DOJ) or 2.0 (Section 508). Areas 3 through 8 of the brief — ARIA APG patterns, SPA focus management, live regions, accessible names, the legal-enforcement detail, and native iOS/Android — produced no claims that survived verification and must be treated as unresearched, not as settled. A methodological warning runs through the verification record: several claims' own "supporting quotes" were paraphrases rather than spec text, and WebFetch summarizers twice returned fabricated normative wording, so every quotation in the final deliverable must be re-derived from raw W3C HTML.

---

## Findings

### 1. WCAG 2.2 adds nine success criteria over 2.1 and removes one (4.1.1 Parsing), giving 87 SCs vs 2.1's 78. The nine and their levels: 2.4.11 Focus Not Obscured (Minimum) AA, 2.4.12 Focus Not Obscured (Enhanced) AAA, 2.4.13 Focus Appearance AAA, 2.5.7 Dragging Movements AA, 2.5.8 Target Size (Minimum) AA, 3.2.6 Consistent Help A, 3.3.7 Redundant Entry A, 3.3.8 Accessible Authentication (Minimum) AA, 3.3.9 Accessible Authentication (Enhanced) AAA. Six of the nine (2.4.11, 2.5.7, 2.5.8, 3.2.6, 3.3.7, 3.3.8) are in scope for an A/AA conformance target.

**Confidence:** high · **Panel vote:** 3-0 (one adjacent phrasing of the same list was voted down 0-3 on quote-support grounds, not on the facts)

Confirmed against three W3C sources including the normative Recommendation (published 5 Oct 2023, republished 12 Dec 2024). The errata page was checked for supersession: every erratum through 2025-10-28 is Editorial (e.g. "e-mail" -> "email", alphabetizing definitions); none adds, removes, renumbers or renames an SC. Two traps the deliverable must avoid: (a) earlier WCAG 2.2 drafts numbered 2.4.11/2.4.12 as "Focus Appearance (Minimum/Enhanced)" — the final Recommendation uses Focus Not Obscured for 2.4.11/2.4.12 and a single 2.4.13 Focus Appearance; (b) 2.4.7 Focus Visible remains AA, contrary to a common myth that it moved to A. Note the removal of 4.1.1 alongside the nine additions — quoting "adds nine" without it produces a wrong SC count.

**Sources:**
- https://www.w3.org/TR/WCAG22/
- https://www.w3.org/WAI/WCAG22/Understanding/
- https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/
- https://www.w3.org/WAI/WCAG22/errata/

### 2. SC 2.5.8 Target Size (Minimum), Level AA, requires a 24x24 CSS pixel effective target area, measured by whether a solid 24x24 CSS px axis-aligned square fits entirely inside the target, with exactly five exceptions: Spacing, Equivalent, Inline, User Agent Control, Essential. The Spacing exception is a geometric test — a 24 CSS px diameter circle centered on each undersized target's bounding box must not intersect another target OR the circle for another undersized target — so two adjacent undersized targets need 24px centre-to-centre separation. This makes minimum hit area and inter-target spacing a component/token and layout decision.

**Confidence:** high · **Panel vote:** 3-0 across five merged claims (0, 5, 7, 10, 11); one narrower restatement of the Spacing test alone was voted 1-2

Verified by raw curl of the normative spec, not WebFetch summary. Verbatim SC text and all five exception names confirmed; the square-fit measurement rule is verbatim from the Understanding doc's "Size requirement" section but is INFORMATIVE, not normative. Only erratum touching 2.5.8 is 2024-11-19 (#3189), explicitly editorial formatting of the exceptions. Three corrections the deliverable must carry: (1) "hard 24px floor" is imprecise — Spacing permits smaller rendered controls, so the floor is on effective spacing-inclusive activation area, satisfiable by size OR spacing; (2) the Inline exception exempts links inside a sentence and targets constrained by line-height of non-target text, so over-speccing prose links is a real risk; (3) the framing "cannot be retrofitted post-build" is editorially overstated — axe-core ships an automated `target-size` rule (wcag22aa/wcag258, Serious impact) that measures both the size and spacing routes, and padding/min-height remediation is routine. What is genuinely not automatable is the Inline exception (a checker cannot prove line-height constrains the target) and unmarked custom widgets. Cross-platform note for the eventual deliverable: 24 CSS px is web/pointer-scoped; Apple HIG specifies 44x44 pt and Material 48x48 dp, both materially larger, and WCAG's own AAA SC 2.5.5 is 44x44.

**Sources:**
- https://www.w3.org/TR/WCAG22/
- https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum.html
- https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/
- https://www.w3.org/WAI/WCAG22/errata/
- https://dequeuniversity.com/rules/axe/4.9/target-size

### 3. SC 2.5.7 Dragging Movements, Level AA: "All functionality that uses a dragging movement for operation can be achieved by a single pointer without dragging, unless dragging is essential or the functionality is determined by the user agent and not modified by the author." Critically, satisfying the keyboard criteria (2.1.1/2.1.3) does NOT satisfy 2.5.7 — the conforming fix is a pointer-operable control, i.e. a visible affordance that occupies layout space, which is why this is a concept-stage interaction-design decision for author-built reorder lists, kanban boards and map panning.

**Confidence:** high · **Panel vote:** merged from claims 1 (2-1) and 8 (3-0)

Normative text confirmed by raw curl of the 12 Dec 2024 Recommendation; 2.5.7 unaffected by any erratum. W3C's own Understanding examples are exactly the design patterns to spec: "A sortable list of elements may, after tapping or clicking on a list element, provide adjacent controls for moving the element up or down"; "A task board that allows users to drag and drop items between columns also provides an additional pop-up menu after tapping or clicking"; "A map allows users to drag the view of the map around, and the map has up/down/left/right buttons." Understanding also notes there are "very few situations in which dragging movements are essential." TWO SCOPE CORRECTIONS: (a) the claim's original example list over-reached — the user-agent exception means native <input type="range"> and native file-input drop behaviour are exempt; only custom pointer-event sliders and author-built dropzones are in scope, and a drag-to-upload zone usually already ships its alternative as the file input's Browse button; (b) "never a code fix" is not universally true — for a custom slider the conforming alternative is click-anywhere-on-track, a pure implementation change with no new UI. The design-time framing holds specifically for the reorder/kanban/map class W3C itself names. Also do not confuse 2.5.7 with 2.5.1 Pointer Gestures (path-based) — one vendor blog claiming touch sliders are exempt as "swipe gestures" makes exactly this error and carries no W3C weight.

**Sources:**
- https://www.w3.org/TR/WCAG22/
- https://www.w3.org/WAI/WCAG22/Understanding/dragging-movements.html
- https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/

### 4. Focus obscuring is split across two levels with different thresholds: 2.4.11 (AA) forbids the focused component being ENTIRELY hidden by author-created content — partial obscuring passes at AA — while 2.4.12 (AAA) forbids any part being hidden. 2.4.13 Focus Appearance (AAA) additionally requires a focus indicator at least as large as a 2 CSS px thick perimeter of the component with a 3:1 contrast ratio between the same pixels in the focused and unfocused states. W3C names sticky footers, sticky headers and non-modal dialogs as the typical offenders, and cookie banners explicitly, so choosing persistent chrome creates the obligation.

**Confidence:** high · **Panel vote:** 3-0 across four merged claims (2, 9, 14, 15)

Normative text verified verbatim in the Recommendation for all three SCs; levels correct (2.4.13 at AAA is a frequent error point — drafts had it at AA). The Understanding doc (page footer "Updated 15 June 2026", i.e. current) states outright "this AA criterion allows for the component receiving focus to be partially obscured" and "Typical types of content that can overlap focused items are sticky footers, sticky headers, and non-modal dialogs" and "A notification implemented as sticky content, such as a cookie banner, will fail this success criterion if it entirely obscures a component receiving focus." W3C ships a dedicated failure technique F110 for sticky footers/headers. FOUR QUALIFIERS: (1) 2.4.11 has two normative notes — only the INITIAL position of user-repositionable content is tested, and content the user opened that can be revealed/dismissed without advancing focus does not count as obscuring; this means a user-opened chat panel can be exempt while a persistent or auto-opening bubble is not, so "floating chat widgets always fail" is wrong. (2) Properly constructed modal dialogs always pass, because they take focus. (3) The 2.4.13 contrast figure is 3:1 between focused and unfocused states of the same pixels, NOT 3:1 against the background — a very easy misquote. (4) W3C explicitly says sticky chrome "can be designed so that they pass", so the honest framing is that the overlay decision creates a paired obligation, not that sticky headers fail.

**Sources:**
- https://www.w3.org/TR/WCAG22/
- https://www.w3.org/WAI/WCAG22/Understanding/focus-not-obscured-minimum.html
- https://www.w3.org/WAI/WCAG22/Techniques/failures/F110
- https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/

### 5. For cookie banners and similar sticky notifications W3C names concrete passing designs decided at design time: make the banner modal so it must be dismissed before navigating the page, or use CSS scroll-padding so the banner never overlaps other content. A third named option is closing notifications on loss of focus. Scroll-padding is a formally listed Sufficient Technique (C43), not just prose advice.

**Confidence:** high · **Panel vote:** 3-0

Verbatim from the live Understanding page: "Ways of passing include making the banner modal so the user has to dismiss the banner before navigating through the page, or using scroll padding so the banner does not overlap other content." Corroborated in the same document's Examples section by both a full-width modal cookie dialog and a sticky-footer-plus-scroll-padding case, and formalized as Sufficient Technique C43 with F110 as the matching failure. TWO QUALIFIERS: the list is explicitly open ("Ways of passing include") and the very next sentence names a third route — "Notifications that do not require user action could also meet this criterion by closing on loss of focus" — so do not present two as exhaustive. Understanding docs are labelled informative; normative force here comes from the SC text plus C43. Of the three, only modal-vs-non-modal is a pure concept-time decision; scroll-padding's design-time counterpart is "reserve layout space for persistent sticky chrome."

**Sources:**
- https://www.w3.org/WAI/WCAG22/Understanding/focus-not-obscured-minimum.html
- https://www.w3.org/WAI/WCAG22/Techniques/css/C43
- https://www.w3.org/WAI/WCAG22/Techniques/failures/F110

### 6. SC 3.3.8 Accessible Authentication (Minimum), Level AA: a cognitive function test is not required for any step in an authentication process unless that step provides at least one of exactly four exceptions — Alternative (another method not relying on a cognitive function test), Mechanism (something assists the user in completing the test), Object Recognition, or Personal Content. The AAA sibling 3.3.9 keeps only Alternative and Mechanism. Supporting password managers and permitting copy-paste into username/password fields is the accepted way to satisfy Mechanism — and it is named in the NORMATIVE Note 2, not just guidance.

**Confidence:** high · **Panel vote:** 3-0 across merged claims 12 and 13 (two looser paraphrases of the same SC were voted 0-3 for misstating the exception set)

Verified against raw HTML of the 12 Dec 2024 Recommendation. Normative Note 2 reads: "Examples of mechanisms that satisfy this criterion include: support for password entry by password managers to reduce memory need, and copy and paste to reduce the cognitive burden of re-typing." The mechanism definition explicitly permits relying on the platform or user agent rather than building it: "The mechanism may be explicitly provided in the content, or may be relied upon to be provided by either the platform or by user agents, including assistive technologies." Only erratum touching 3.3.8 is #18 (2024-11-19), changing ordered lists to unordered — pure formatting. IMPORTANT PARAPHRASE TRAP: the SC says a cognitive function test "is not required", it does not forbid offering one — W3C's own Understanding page states it "does not forbid cognitive function tests outright." Writing "3.3.8 bans password fields" is a misreading; the Alternative exception is precisely what converts required into not-required. Two claims in the source set that stated the exceptions as "unless essential" or listed only object-recognition and personal-content were refuted 0-3 — there is no essentiality/security exception in 3.3.8. One verifier also caught a WebFetch summarizer inventing the wording "except where that test is essential to the security of the content", which appears nowhere in the spec.

**Sources:**
- https://www.w3.org/TR/WCAG22/
- https://www.w3.org/WAI/WCAG22/Understanding/accessible-authentication-minimum.html
- https://www.w3.org/WAI/WCAG22/Techniques/failures/F109

### 7. Actively blocking password managers from filling login fields, or blocking copy-and-paste, is a W3C-stated failure of 3.3.8 unless an alternative is provided — so the common security-team decision to disable paste on password fields is itself the accessibility defect. Requiring a password or code to be re-entered in a different format from the one it was created in (split OTP boxes, "enter the 2nd, 6th and last characters") is failure technique F109.

**Confidence:** high · **Panel vote:** 3-0 across merged claims 6 and 13

Verbatim from the Understanding page: "if user agents and password managers are actively blocked from filling in the fields (for instance, by a script that prevents form fields from being automatically populated), or users are prevented from copy and paste operations (as they may rely on standalone/external third party password managers), then the page would fail this criterion unless an alternative is provided." F109 (revised 27 April 2026, current) covers the format-change case and states "A service that requires manual transcription of a verification code is not compliant." ADVERSARIAL HISTORY WORTH KNOWING: w3c/wcag issue #1855 (Patrick Lauke, 2021) empirically showed across Win/mac/iOS/Android x four browsers x five password managers that "None of the tested combinations generate/trigger a paste event" — i.e. blocking paste does not actually block extension-based managers. Alastair Campbell conceded the point; the issue was closed via PR #1898 and the published text was rewritten to justify the paste clause independently (users of standalone/external managers). So the strongest counter-argument was adjudicated and folded in, not ignored. TWO QUALIFIERS: the failure is conditional on "unless an alternative is provided" — a site offering passkeys/WebAuthn or an email magic link alongside still conforms, which is why the alternative-method decision is architectural; and this specific case lives in the informative Understanding doc, so the accurate formulation is "W3C states this is a failure" rather than "the SC text names it."

**Sources:**
- https://www.w3.org/WAI/WCAG22/Understanding/accessible-authentication-minimum.html
- https://www.w3.org/WAI/WCAG22/Techniques/failures/F109
- https://github.com/w3c/wcag/issues/1855

### 8. SC 3.3.7 Redundant Entry is Level A — the lowest tier, not AA. Normative text: information previously entered by or provided to the user that is required to be entered again IN THE SAME PROCESS is either auto-populated or available for the user to select. Three exceptions: re-entering is essential, the information is required to ensure security of the content, or the previously entered information is no longer valid. This pushes multi-step flow and checkout design toward auto-population or offering prior values.

**Confidence:** high · **Panel vote:** 2-1 (the dissent was on quote fidelity, not substance)

Level A confirmed by both the Understanding heading and the WAI What's New page; every secondary source located independently agrees. THREE CORRECTIONS: (1) the claim's supplied quote is a paraphrase — the normative disjunction is "either: auto-populated, or available for the user to select", which maps exactly onto the design implication; (2) the claim named only two of three exceptions, dropping "previously entered information is no longer valid"; (3) the claim dropped the normative scoping "in the same process" (W3C defines process as a sequence of activities toward one goal). W3C's own plain-language summary loosely says "same session", which is looser than normative text — without "same process" a reader could over-apply this across unrelated visits. Open W3C issues (w3c/wcag #1660, #4210) debate how the security exception applies to password re-entry; that is edge-case interpretation, not a dispute about the level or the core requirement.

**Sources:**
- https://www.w3.org/TR/WCAG22/
- https://www.w3.org/WAI/WCAG22/Understanding/redundant-entry.html
- https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/

### 9. WCAG 3.0 is a W3C Working Draft dated 3 March 2026 whose own text states "it still has several years of work", it explicitly does not deprecate WCAG 2 ("WCAG 2 is used around the world and will still be required by different countries for a long time to come"), and WCAG 2.2 A+AA conformance is only "expected to meet MOST of the minimum conformance level" because WCAG 3 adds tests and different scoring mechanics. No 2026 design or procurement decision can be anchored to WCAG 3 conformance; WCAG 2.2 AA is the operative design target.

**Confidence:** high · **Panel vote:** 3-0 across three merged claims (17, 18, 19)

All three quotes verified verbatim in the live 3 March 2026 Working Draft; publication history checked April-July 2026 and no newer draft exists as of 28 July 2026. The draft self-labels "It is inappropriate to cite this document as other than a work in progress", which independently supports the procurement inference. WAI's WCAG 3 intro page corroborates: "WCAG 3 will not supersede WCAG 2 and WCAG 2 will not be deprecated for at least several years after WCAG 3 is finalized." THREE CAVEATS: (1) the March 2026 Conformance section does NOT itself name levels — it says only "several levels of conformance are available" and carries an editor's note that the conformance model was updated with open questions; the Bronze/Silver/Gold naming comes from prior drafts and secondary commentary, so the intro's phrase "different scoring mechanics" currently outruns the draft's own normative text. (2) The Working Group was chartered only through April 2026; secondary trackers put CR around Q4 2027 and REC no earlier than 2028. (3) "WCAG 2.2 is the operative target" is inference, not W3C wording — no major jurisdiction legally mandates 2.2 today. State it as "2.2 is the right design target; 2.1 AA is what the law currently names."

**Sources:**
- https://www.w3.org/TR/wcag-3.0/
- https://www.w3.org/WAI/standards-guidelines/wcag/wcag3-intro/
- https://www.w3.org/TR/2026/DNOTE-wcag-3.0-explainer-20260226/

### 10. Every legal instrument currently in force points at WCAG 2.x, never WCAG 3: DOJ's ADA Title II rule (28 CFR part 35 subpart H, 89 FR 31320, 24 Apr 2024) adopts WCAG 2.1 Level AA, and a DOJ interim final rule published 20 April 2026 pushed compliance dates from 24 Apr 2026 to 26 April 2027 for entities of 50,000+ population and from 26 Apr 2027 to 26 April 2028 for smaller entities and special districts. EN 301 549 v3.2.1 — the harmonised standard cited for the European Accessibility Act, applicable 28 June 2025 — incorporates WCAG 2.1, with v4.1.1 moving to WCAG 2.2 AA anticipated in the OJEU around October 2026. Section 508 still references WCAG 2.0 AA.

**Confidence:** medium · **Panel vote:** not independently voted — surfaced as corroborating evidence inside the 3-0 verifications of claims 17 and 18

This material was gathered by two verifiers while checking whether WCAG 3 had displaced WCAG 2 in any binding instrument; both independently reported the same dates and citations, and it is internally consistent across them. It is downgraded to MEDIUM because it was never itself put through the three-vote adversarial process, the Federal Register and ETSI URLs above are reconstructed from the verifiers' prose rather than fetched during synthesis, and the EN 301 549 v4.1.1 OJEU date is forward-looking. The load-bearing conclusion — that no in-force law names WCAG 3, and that the design target gap between the legally named 2.1 and the current 2.2 Recommendation is exactly the nine new SCs minus 4.1.1 — is solid. The specific dates and CFR/FR citations MUST be re-verified against the primary texts before any deliverable states them. The DOJ deadline extension in particular is recent and consequential enough that a stale figure would be actively misleading.

**Sources:**
- https://www.federalregister.gov/documents/2024/04/24/2024-07758
- https://www.federalregister.gov/documents/2026/04/20/2026-07663
- https://www.etsi.org/deliver/etsi_en/301500_301599/301549/
- https://www.w3.org/TR/wcag-3.0/

### 11. SC 3.2.6 Consistent Help is Level A, but nothing beyond its level and existence survived verification — its normative requirement, the help mechanisms it covers, and its design implications were never independently checked.

**Confidence:** low · **Panel vote:** level established only as a by-product of the 3-0 verification of the nine-SC list (claim 4)

3.2.6 appears in the verified nine-SC index at Level A and in the WAI What's New level table, and a 2025 erratum touching 3.2.6 was noted in passing on the errata page. No claim in the surviving set states what 3.2.6 actually requires (consistent relative order of help mechanisms across pages in a set of web pages), what counts as a help mechanism, or what it demands of a designer — which was an explicit ask in the brief. Treat this as a research gap, not a finding. Anyone writing the deliverable must fetch https://www.w3.org/WAI/WCAG22/Understanding/consistent-help.html directly.

**Sources:**
- https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/
- https://www.w3.org/WAI/WCAG22/Understanding/

### 12. Methodological warning that affects the whole deliverable: WebFetch-style summarization repeatedly returned FABRICATED normative text for WCAG success criteria, and several of the research claims' own "supporting quotes" turned out to be paraphrases that do not appear anywhere in the spec. Every quotation must be re-derived from raw W3C HTML (curl / raw.githubusercontent.com/w3c/wcag) before publication.

**Confidence:** high · **Panel vote:** 3-0 equivalent — independently reported by verifiers of claims 0, 1, 3, 10 and 12

Concrete instances caught: (a) for 2.5.8 a summarizer returned "A larger alternative target serving the same purpose and function is available" and "The target is an element in a continuous paragraph of text" — neither is W3C wording; (b) for 3.3.8 a summarizer invented "not required to authenticate a user, except where that test is essential to the security of the content", which appears nowhere in the spec and would have introduced a non-existent security exception; (c) the supplied supporting quotes for the 2.5.7, 2.5.8, 3.3.7 and 3.3.8 claims were all paraphrases, one of which conflated the Spacing and Inline exceptions of 2.5.8 into a single sentence that does not exist. Verifiers that used curl on the TR document or the w3c/wcag raw source got clean text every time. For a document whose value is quoting a standard accurately, this is the single highest-risk failure mode.

**Sources:**
- https://www.w3.org/TR/WCAG22/
- https://raw.githubusercontent.com/w3c/wcag/main/guidelines/sc/22/target-size-minimum.html

---

## Caveats

COVERAGE IS THE BIGGEST CAVEAT. Of the eight areas requested, only two are actually evidenced. All 20 surviving claims concern WCAG 2.2's new success criteria (area 1) and WCAG 3.0's status (area 2). NOTHING survived verification on: the ARIA Authoring Practices Guide and the "no ARIA is better than bad ARIA" rule (area 3); focus management on route change and view transitions in SPAs (area 4); live regions / aria-live failure modes across screen readers (area 5); accessible names for custom controls (area 6); the legal drivers in any detail — EAA, DOJ Title II, Section 508, EN 301 549 (area 7, partially covered only as incidental corroboration at medium confidence); and native iOS VoiceOver/Dynamic Type/traits vs Android TalkBack (area 8). These are unresearched, not settled. Do not let the depth on WCAG 2.2 imply the rest was checked.

SC 3.2.6 Consistent Help was in the brief's explicit list and is effectively unresearched beyond its Level A designation.

QUOTE INTEGRITY. Several claims carried "supporting quotes" that are paraphrases absent from the spec, and summarizer tools twice produced fabricated normative text including a non-existent security exception for 3.3.8. Nothing in the final deliverable should be quoted from this report without re-fetching raw W3C HTML.

FRAMING vs FACT. The recurring tail clause "this is a design-time decision, not a post-build audit item" is the brief's editorial framing, never W3C text, and is factually wrong in places: axe-core automates 2.5.8 detection, target size is routinely remediated with CSS padding, and the 2.5.7 fix for a custom slider is a pure implementation change. The defensible version is narrower — these criteria are cheapest and most reliably satisfied when decided in the comp, and several (equivalent-control IA, non-drag affordances, sticky-chrome geometry, auth method choice) require new UI or new architecture that cannot be bolted on.

INFORMATIVE vs NORMATIVE. Much of the most designer-useful material (the square-fit rule for 2.5.8, the sticky-header/cookie-banner naming, the paste-blocking failure case) lives in Understanding documents, which are explicitly labelled "Informative explanations, not required to meet WCAG." Attribute it as "W3C guidance states" rather than "the criterion requires."

TIME SENSITIVITY. WCAG 2.2 is stable — errata through 2025-10-28 are all editorial. WCAG 3.0 is not: the March 2026 draft's conformance model has open editor's questions, the Working Group's charter ran to April 2026, and any level naming (Bronze/Silver/Gold) is from older drafts. The legal timeline is the most volatile element here — DOJ deadlines moved in April 2026 and EN 301 549 v4.1.1 is expected in the OJEU around October 2026; re-verify all dates at time of writing.

PLATFORM SCOPE. Every number in this report is web/CSS-pixel scoped. Verifiers flagged in passing that Apple HIG (44x44 pt) and Material (48x48 dp) specify materially larger touch targets, so no WCAG figure transfers to native without restating it.

---

## Refuted — claims the panel killed

- **SC 3.3.8 Accessible Authentication (Minimum), Level AA, forbids requiring a cognitive function test (memorization, transcription, puzzle-solving) in any authentication step unless essential, with only object-recognition and personal-content exceptions — this rules out designs that mandate password memorization without paste/password-manager support, or traditional text CAPTCHAs, as the sole login path.**
  
- **SC 3.3.8 Accessible Authentication (Minimum), Level AA, prohibits any cognitive function test in an authentication step, and W3C explicitly defines that test to include remembering a password, transcribing characters, correct spelling, calculations, and solving puzzles — meaning conventional password-plus-CAPTCHA login flows fail unless one of four exceptions applies (alternative method, assistive mechanism, object recognition, or user-provided personal content).**
  
- **WCAG 2.2 adds exactly nine new success criteria over WCAG 2.1: 2.4.11 Focus Not Obscured (Minimum, AA), 2.4.12 Focus Not Obscured (Enhanced, AAA), 2.4.13 Focus Appearance (AAA), 2.5.7 Dragging Movements (AA), 2.5.8 Target Size (Minimum, AA), 3.2.6 Consistent Help (A), 3.3.7 Redundant Entry (A), 3.3.8 Accessible Authentication (Minimum, AA), 3.3.9 Accessible Authentication (Enhanced, AAA). Six of the nine are at level A or AA and therefore in scope for the AA conformance target used by EN 301 549 and Section 508.**
  
- **Undersized targets can still conform via the Spacing exception, evaluated by centering a 24 CSS pixel diameter circle on each undersized target's bounding box and confirming the circles do not intersect another target — making inter-target spacing (not just component size) a design-time decision.**
  
- **The prohibited 'cognitive function tests' are enumerated concretely and include memorization (username, password, characters, images, or patterns), transcription (typing in characters), performing calculations, and solving puzzles — which means a design that asks a user to read a one-time code on one device and retype it on another is a failing pattern absent an exception.**
  

---

## Open questions

- What does SC 3.2.6 Consistent Help actually require — what counts as a help mechanism, what "same relative order" means across a set of web pages, and what it forces a designer to decide about global nav and footer placement? It was in the brief and only its Level A designation was established.
- Areas 3-6 of the brief (ARIA APG patterns as design decisions, the "no ARIA is better than bad ARIA" rule with concrete wrong-answer cases, SPA route-change focus management and the View Transitions API, aria-live failure modes across NVDA/JAWS/VoiceOver, and accessible-name computation for custom controls) produced zero verified claims. Was this a scoping decision by the research pass, or did those claims fail verification? They need a dedicated research round against W3C ARIA APG, WAI-ARIA 1.2/1.3, and screen-reader support tables.
- How do the native platforms map onto these web criteria — does Apple's 44x44 pt / Material's 48x48 dp guidance satisfy or exceed 2.5.8 in a legal sense under EN 301 549 clauses 11.x, and what are the iOS/Android equivalents of 2.5.7 (drag alternatives), 2.4.11 (focus obscuring under sticky nav bars) and 3.3.8 (biometric/passkey auth as the Alternative exception)?
- Which of the nine new WCAG 2.2 criteria are actually enforceable today, given that DOJ Title II names WCAG 2.1 AA and Section 508 names 2.0 AA — i.e. is designing to 2.2 a legal requirement anywhere in 2026, or purely anticipatory of EN 301 549 v4.1.1? The report establishes that 2.2 is not currently mandated but does not resolve whether any procurement regime already requires it.
- Does the 2.4.11 note exempting user-opened dismissible content extend to the common pattern of an auto-opening chat widget that the user can close, or only to content the user explicitly invoked? This determines whether a very widespread commercial pattern conforms.

---

## Sources

- [primary] https://www.w3.org/TR/WCAG22/ — 5 claims
- [primary] https://www.w3.org/WAI/WCAG22/Understanding/ — 5 claims
- [primary] https://www.w3.org/WAI/standards-guidelines/wcag/new-in-22/ — 5 claims
- [primary] https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum.html — 5 claims
- [primary] https://www.w3.org/WAI/WCAG22/Understanding/accessible-authentication-minimum.html — 5 claims
- [primary] https://www.w3.org/WAI/WCAG22/Understanding/focus-not-obscured-minimum.html — 5 claims
- [primary] https://www.w3.org/TR/wcag-3.0/ — 5 claims
- [primary] https://www.w3.org/WAI/standards-guidelines/wcag/wcag3-intro/ — 5 claims
- [primary] https://www.w3.org/TR/2026/DNOTE-wcag-3.0-explainer-20260303/ — 5 claims
- [primary] https://www.w3.org/WAI/ARIA/apg/practices/read-me-first/ — 5 claims
- [blog] https://adrianroselli.com/2026/01/live-region-support.html — 5 claims
- [primary] https://www.w3.org/WAI/ARIA/apg/practices/names-and-descriptions/ — 5 claims
- [primary] https://webaim.org/articles/label-name/ — 5 claims
- [primary] https://webaim.org/projects/million/ — 5 claims
- [blog] https://www.deque.com/blog/accessibility-tips-in-single-page-applications/ — 5 claims
- [primary] https://www.federalregister.gov/documents/2026/04/20/2026-07663/extension-of-compliance-dates-for-nondiscrimination-on-the-basis-of-disability-accessibility-of-web — 5 claims
- [primary] https://www.ada.gov/resources/2024-03-08-web-rule/ — 5 claims
- [primary] https://eur-lex.europa.eu/eli/dir/2019/882/oj/eng — 5 claims
- [primary] https://www.etsi.org/deliver/etsi_en/301500_301599/301549/03.02.01_60/en_301549v030201p.pdf — 5 claims
- [secondary] https://www.taylorwessing.com/en/insights-and-events/insights/2026/06/the-eaa-and-bfsg-recap-and-update — 5 claims
- [primary] https://www.w3.org/TR/wcag2mobile-22/ — 5 claims
- [primary] https://developer.apple.com/design/human-interface-guidelines/accessibility — 5 claims
- [primary] https://developer.android.com/guide/topics/ui/accessibility/principles — 5 claims
- [primary] https://developer.apple.com/help/app-store-connect/manage-app-accessibility/voiceover-evaluation-criteria/ — 5 claims
