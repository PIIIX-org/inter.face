# Research — web accessibility patterns as design-time decisions
**Date:** 2026-08-01  
**Method:** deep-research harness, resumed twice after a session-boundary death and an org-access outage. Final run: 104/104 agents, 0 errors, full synthesis.

## Coverage warning

Two of the four requested topics returned **zero surviving claims**: SPA route-change / View Transitions API focus management, and live regions / aria-live. Treat as unresearched, not as 'no such pattern exists.' ARIA Authoring Practices Guide patterns and the WebAIM Million data are the two topics that landed.

---

## Summary

Verified evidence strongly supports treating a specific slice of the APG as design-time commitments rather than developer plumbing: grid-vs-table locks in a roving-tabindex/single-tab-stop keyboard model versus every-widget-tabbable; treegrid adds a hierarchy/expand-collapse contract on top of grid; combobox forces a choice among exactly four popup roles (listbox/tree/grid/dialog) each with distinct keyboard and focus semantics, plus a mandatory aria-expanded state that must mirror visible open/closed state; menu/menubar commits to arrows-navigate/Tab-exits roving focus plus a fixed open→first-item and Escape→return-focus contract; and modal dialog bundles a focus trap, bidirectional focus transfer, content-dependent initial-focus placement, and a conditional aria-modal that only applies when the design truly enforces modality both behaviorally and visually. WebAIM Million (2026) supplies the clearest quantitative backing for "no ARIA is better than bad ARIA": pages with ARIA average 59.1 detected errors versus 42 without (~41% more, scaling with ARIA attribute count), and of the 5.7% of home pages using role="menu", 22% actively introduce barriers from incomplete markup — concrete measured harm from half-implemented patterns, consistent with the APG's own framing that a role is "a promise" carrying no native keyboard behavior. Critically, the adversarial verification process produced zero surviving, source-backed claims on the other two requested topics — SPA route-change/View-Transitions-API focus management, and live regions/aria-live behavior — so this report cannot answer those two topics at all and that gap should be treated as unresearched rather than as evidence of no pattern.

## Caveats — read before citing anything below

Two of the four requested topics returned zero surviving claims: (1) SPA route-change/View-Transitions-API focus management and (2) live regions/aria-live are entirely unaddressed by verified evidence — treat as "not researched," not as "no such pattern exists." Several plausible claims were explicitly refuted by 3-vote panels and must not be reused even though they sound right: the dialog-vs-alertdialog distinguishing criterion (0-3); combobox's defining criterion vs listbox/select (0-3); combobox virtual-focus/aria-activedescendant claim (0-3); grid's "arrow-key-only navigation is non-negotiable" claim (0-3); grid's "application-mode silently skips content" harm claim (1-2, closest refuted vote); menu submenu aria-haspopup+aria-expanded requirement (0-3); disclosure's "exactly two elements" structural definition (1-2); disclosure's "minimal keyboard model, must be a button not a link" claim (0-3). The disclosure-vs-accordion boundary claim that did survive (2-1) is itself contested — a W3C GitHub issue (aria-practices #2445) is open with no editor resolution, and third-party guidance conflicts with APG's own FAQ example on the "count of sections" criterion. The two dialog focus-contract claims (focus trap, focus transfer) survived only 2-1; Scott O'Hara's published dissent argues focus-trapping isn't strictly normative in WCAG and native <dialog>+inert is a valid alternative — this challenges implementation technique, not the behavioral contract itself. WebAIM Million's ARIA-vs-error-rate figures are explicitly correlational per the source's own framing, not causal. Several verification passes (WebAIM claims, the "role is a promise" claim) had WebSearch budget exhausted and relied on primary-source WebFetch alone rather than cross-source triangulation. No TPGi or Deque source survived verification despite being named as fallback sources, and no claim directly cites the "five rules of ARIA use" document itself.

---

## Findings

### 1. Disclosure vs accordion vs tabs is a content-structure decision, not an implementation detail. A disclosure controls one collapsible region and only requires that its trigger's aria-expanded be kept in sync with visibility (aria-controls is optional wiring, not the required deliverable); an accordion is APG's name for a vertically-stacked SET of interactive headings each owning a section, and headedness/information-architecture is the discriminating signal APG actually encodes in required markup (mandatory heading-wrapped buttons for accordion, no such requirement for disclosure).

**Confidence:** medium · **Panel vote:** 2-1 (boundary claim) + 3-0 (aria-expanded requirement claim)

APG: 'A disclosure is a widget that enables content to be either collapsed (hidden) or expanded (visible)... two elements: a disclosure button and a section of content.' vs 'An accordion is a vertically stacked set of interactive headings that each contain a title... representing a section of content,' with a mandatory heading-role wrapper on each accordion button. Disclosure: 'When the content is visible, the element with role button has aria-expanded set to true... Optionally, the element with role button has a value specified for aria-controls.' Downgraded to medium: the boundary claim survived only 2-1 and a W3C issue (aria-practices #2445) is open on exactly this line; a stronger competing claim asserting disclosure = 'exactly two elements' as the structural distinguisher was refuted 1-2, and a claim asserting disclosure's keyboard model (no arrows, must-be-button) was refuted 0-3.

**Sources:**
- https://www.w3.org/WAI/ARIA/apg/patterns/
- https://www.w3.org/WAI/ARIA/apg/patterns/disclosure/
- https://www.w3.org/WAI/ARIA/apg/patterns/accordion/

### 2. Grid vs table vs treegrid is fundamentally a keyboard-interaction-model and tab-sequence decision, not a visual/styling one. A grid is a composite widget exposing exactly one focusable element to the page tab sequence (arrow keys move within it), while every focusable element in a table stays in the tab sequence and a table is explicitly 'not an interactive widget.' Treegrid is a further specialization requiring hierarchy (expandable/collapsible rows via aria-expanded, Left/Right Arrow to collapse/expand) plus editable/interactive cell content. Any grid cell containing an arrow-key-driven control (combobox, slider, radio group) forces an explicit Enter-to-enter/Escape-to-restore mode switch because navigation arrows and in-widget arrows cannot coexist.

**Confidence:** high · **Panel vote:** unanimous 3-0 across 4 merged claims

'A grid widget is a container that enables users to navigate the information or interactive elements it contains using directional navigation keys... using the grid role does not necessarily imply that its visual presentation is tabular.' 'A WAI-ARIA table is a static tabular structure... it is not an interactive widget.' Grid: 'Only one of the focusable elements contained by the grid is included in the page tab sequence' vs Table: 'All focusable elements contained in a table are included in the page tab sequence.' Treegrid (spec): 'A grid whose rows can be expanded and collapsed in the same manner as for a tree.' Grid mode-switch: 'While navigation keys... are moving focus from cell to cell, they are not available to do something like operate a combobox... Enter: Disables grid navigation... Escape: restores grid navigation.' All four underlying claims unanimous 3-0 across multiple primary W3C pages; a related claim about a specific documented screen-reader harm from grid's application mode was refuted 1-2 and should not be reused.

**Sources:**
- https://www.w3.org/WAI/ARIA/apg/patterns/grid/
- https://www.w3.org/WAI/ARIA/apg/patterns/table/
- https://www.w3.org/TR/wai-aria-1.2/

### 3. Combobox forces two separate design-time decisions: which of exactly four popup roles to use (listbox, tree, grid, or dialog — a closed list per the normative spec, not illustrative), each carrying a distinct keyboard model and focus mechanism (e.g. dialog popups move real DOM focus in, unlike the other three which use aria-activedescendant-style patterns); and keeping aria-expanded on the combobox element in sync with the popup's visible open/closed state, which is a required state per the normative ARIA spec, not just APG guidance.

**Confidence:** high · **Panel vote:** unanimous 3-0 on both surviving sub-claims

'The popup is an element that has role listbox, tree, grid, or dialog' — confirmed as a MUST in normative spec via W3C issue w3c/aria#2132/#2134. Per-popup divergence: listbox 'Down Arrow moves focus to and selects the next option'; grid 'Down Arrow moves focus one cell down'; tree 'Right Arrow... opens the node'; dialog 'Unlike other combobox popups, dialogs do not support aria-activedescendant so DOM focus moves into the dialog.' State sync: 'When the combobox popup is not visible... aria-expanded set to false. When the popup element is visible, aria-expanded is set to true' — required state per ARIA 1.2/1.3, corroborated by MDN. Note: two adjacent claims attempting to name combobox's defining criterion vs listbox/select, and to assert a virtual-focus/aria-activedescendant model as universal to combobox, were both refuted 0-3 — the popup can in fact use real DOM focus (dialog case), so 'virtual focus always' is false.

**Sources:**
- https://www.w3.org/WAI/ARIA/apg/patterns/combobox/
- https://www.w3.org/TR/wai-aria-1.2/

### 4. Choosing the menu/menubar pattern commits the design to a roving-tabindex keyboard model where Tab is NOT the intra-widget navigation key (arrows move between items; Tab enters/exits the whole widget as one stop — incompatible with a plain list of independently-tabbable links or buttons), plus a fixed, non-optional focus-management contract: opening a menu places focus on the first item, and Escape closes the menu and returns focus to the invoking control (menu button or parent menuitem).

**Confidence:** high · **Panel vote:** unanimous 3-0 on both merged claims

'Tab and Shift + Tab do not move focus among the items in the menu... Each item in the menu has tabindex set to -1, except in a menubar, where the first item has tabindex set to 0.' 'When a menu opens, or when a menubar receives focus, keyboard focus is placed on the first item.' 'Escape: Close the menu that contains focus and return focus to the element or context, e.g., menu button or parent menuitem, from which the menu was opened.' Both claims unanimous 3-0 on the same primary page. A related claim asserting that any submenu-opening item must expose a persistent visible aria-haspopup/aria-expanded affordance (a design-time visual-affordance requirement) was refuted 0-3 and should not be cited.

**Sources:**
- https://www.w3.org/WAI/ARIA/apg/patterns/menubar/

### 5. Choosing the modal dialog pattern (as distinct from a non-modal dialog) obliges a bundled contract: Tab/Shift+Tab must cycle within the dialog and never escape it except via Escape (a focus trap), focus moves in on open and returns to the invoking element on close (unless it no longer exists), initial-focus placement is content-dependent (a static heading/first-paragraph via tabindex=-1 for long/semantic content; the least-destructive action for irreversible operations; the most-frequently-used action otherwise), and aria-modal="true" should only be applied when the design actually enforces modality both behaviorally (no interaction with outside content) and visually (outside content obscured) — because the attribute can hide outside content from assistive technology and a false claim of modality has severe consequences.

**Confidence:** medium · **Panel vote:** 2-1, 2-1, 3-0, 3-0 across 4 merged claims

'Tab and Shift + Tab do not move focus outside the dialog... modal dialogs do not provide means for moving keyboard focus outside the dialog window without closing the dialog.' 'When a dialog opens, focus moves to an element inside the dialog... When a dialog closes, focus returns to the element that invoked the dialog unless... the invoking element no longer exists.' Initial focus: 'add tabindex="-1" to a static element at the top of the dialog, such as the dialog title or first paragraph... it may be advisable to set focus on the least destructive action, especially if undoing the action is difficult or impossible.' aria-modal: 'marking a dialog modal by setting aria-modal to true can prevent users of some assistive technologies from perceiving content outside the dialog... mark a dialog modal only when both: Application code prevents all users from interacting... Visual styling obscures the content outside of it.' Downgraded to medium: the focus-trap and focus-transfer sub-claims survived only 2-1 each; a dissenting accessibility practitioner (Scott O'Hara) argues focus-trapping is not strictly a WCAG normative requirement and native <dialog>+inert achieves equivalent containment without hand-rolled trap code — a critique of implementation technique, not of the behavioral contract itself. Separately, a claim attempting to distinguish dialog from alertdialog specifically by communicative intent was refuted 0-3, so no surviving claim in this research differentiates the two roles.

**Sources:**
- https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/

### 6. ARIA roles carry no native keyboard behavior or styling — applying a role is, in APG's own words, a 'promise' that the author has separately implemented the expected interaction — which is the underlying reason every pattern above (disclosure, grid, combobox, menu, dialog) encodes a specific required keyboard model rather than being a cosmetic labeling choice.

**Confidence:** high · **Panel vote:** unanimous 3-0

'<div role="button">Place Order</div> Is a promise that the author of that div has also incorporated JavaScript that provides the keyboard interactions expected for a button. Unlike HTML input elements, ARIA roles do not cause browsers to provide keyboard behaviors or styling. Using a role without fulfilling the promise of that role is similar to making a "Place Order" button that abandons an order and empties the shopping cart.' Same page states APG's objective is 'to define expected behaviors for each ARIA role,' which matches how every surviving pattern-specific finding above is structured (a distinct Keyboard Interaction section per pattern). This is the closest surviving evidence to the research question's 'five rules of ARIA use' framing, though no claim directly quoting that specific named document survived.

**Sources:**
- https://www.w3.org/WAI/ARIA/apg/practices/read-me-first/

### 7. WebAIM Million (2026, ~1,000,000 home pages scanned) gives concrete, measured support for 'no ARIA is better than bad ARIA': pages containing ARIA average 59.1 detected accessibility errors versus 42 on pages without ARIA (roughly 41% more), with error count scaling as more ARIA attributes are present; and for one specific named pattern, role="menu" (present on 5.7% of home pages), 22% of those implementations actively introduce accessibility barriers due to missing required ARIA menu markup and keyboard interactions.

**Confidence:** high · **Panel vote:** unanimous 3-0 on both merged claims

'Home pages with ARIA present had significantly more errors (59.1 on average) than pages without ARIA (42 on average)... Increased ARIA usage on pages was associated with higher detected errors. The more ARIA attributes that were present, the more detected accessibility errors could be expected.' '5.7% of home pages had an ARIA menu (role="menu"), but 22% of those ARIA menus introduced accessibility barriers due to the lack of necessary ARIA menu markup and interactions.' Both unanimous 3-0 against the primary source explicitly prioritized by the research brief. Caveat carried from the source itself: this is correlational, not a controlled causal test — ARIA-heavy pages also tend to be more complex overall. This is the only surviving evidence addressing topic 2's request for named concrete cases and measured harm; no claim survived naming a specific case where a native element/layout change is the objectively correct substitute for ARIA (the closest candidate — disclosure trigger must be a button, not a link — was refuted 0-3).

**Sources:**
- https://webaim.org/projects/million/

### 8. No verified evidence survived on either of the two remaining requested topics: (a) focus management on route change / View Transitions API in SPAs — correct focus destination, the role of skip links and page-title announcements, View Transitions API interaction with focus and prefers-reduced-motion, and the known focus-lost-to-body failure; and (b) live regions for async results — aria-live polite vs assertive, role=status vs role=alert, aria-atomic/aria-relevant, the DOM-must-exist-before-injection requirement, and documented NVDA/JAWS/VoiceOver failure modes. Zero claims on either topic appear in either the confirmed or refuted lists, indicating this research pass did not produce citable material for them at all.

**Confidence:** low · **Panel vote:** no claims to vote on — 0 of 0 for these two topics

Absence check against both the confirmed-claims list and the refuted-claims list provided: no claim, quote, or source addresses SPA route-change focus, skip links, page-title announcement, the View Transitions API, prefers-reduced-motion interaction, aria-live, role=status/alert, aria-atomic, aria-relevant, or cross-screen-reader live-region failure modes anywhere in the synthesis input. This should be read as an unresearched gap requiring a dedicated follow-up pass against W3C ARIA APG's live-region guidance, WHATWG/W3C View Transitions spec, and WebAIM/TPGi/Deque technical writeups on SPA focus management — not as evidence that no authoritative guidance exists on these topics.

---

## Refuted — plausible-sounding claims the panel killed

Do not reuse these even though they sound right.

- **The APG distinguishes alert dialog from modal dialog by communicative intent and required user response rather than by markup: a dialog is defined merely as an overlaid window, while an alert dialog is a modal dialog that interrupts the user's workflow to convey an important message AND acquire a response.**  
  vote: 0-3
- **The APG defines combobox by a design-level distinguisher, not an implementation detail: unlike listbox or menu button, the chosen value is presented in an editable field that the user can select and copy. This is the deciding criterion when a designer picks combobox vs listbox vs a native select.**  
  vote: 0-3
- **Combobox obliges a specific, non-obvious focus model: DOM focus never leaves the input while the user navigates the popup; the active option is conveyed only via aria-activedescendant. A design that shows a visually 'focused' option in the list is therefore committing to virtual focus, not real focus.**  
  vote: 0-3
- **Picking grid obliges a specific, non-negotiable arrow-key navigation model — cell-to-cell movement with Right/Left/Up/Down that stops at edges, Home to the first cell in the row, and Control+Home to the first cell of the first row — which is an interaction contract the design must visibly support (visible focus per cell, not per control).**  
  vote: 0-3
- **The grid choice carries a documented harm: it puts screen readers into application mode, so users hear only focusable elements and the content labeling them, meaning any non-focusable cell content the designer places in the grid can be silently skipped. This is a concrete case where the more 'ARIA-rich' pattern is the wrong answer for content-heavy tabular data.**  
  vote: 1-2
- **Any menu item that opens a submenu must expose two separate state/affordance attributes — aria-haspopup (menu or true) and aria-expanded toggled false/true in sync with actual visibility — meaning the design must include a persistent visible 'has submenu' affordance and a visible open/closed state, not just a hover reveal.**  
  vote: 0-3
- **The APG defines a disclosure as exactly two elements — a trigger button and one section whose visibility it controls — which is the structural commitment that distinguishes it from accordion (multiple coordinated panels) and tabs (mutually exclusive panels sharing one region). Choosing 'disclosure' at design time therefore commits the design to independent, individually-toggled sections with no single-open constraint.**  
  vote: 1-2
- **The disclosure pattern obliges a specific and minimal keyboard model: Enter and Space both toggle the control, and no arrow-key navigation is specified. This is the concrete behavioral difference from tabs (arrow-key roving tabindex) and menu/menubar patterns, and it is why a disclosure trigger must be an actual button, not a link or a div.**  
  vote: 0-3

---

## Open questions

- What is the accepted correct focus target and mechanism (e.g., focus a heading/landmark with tabindex=-1, move focus to main content, or leave focus alone) when an SPA route changes, and how specifically does the View Transitions API interact with focus restoration and prefers-reduced-motion? This entire sub-topic needs a fresh, dedicated research pass — nothing survived from this run.
- What do WebAIM, TPGi, or Deque document about aria-live polite/assertive, role=status vs role=alert, aria-atomic/aria-relevant, the requirement that a live region exist in the DOM before content is injected, and cross-screen-reader (NVDA/JAWS/VoiceOver) failure modes? Also unresearched — needs a dedicated pass with working WebSearch access.
- Where exactly does APG (or a future ARIA spec revision) resolve the open disclosure-vs-accordion boundary question raised in W3C issue aria-practices #2445, given that APG's own FAQ example contradicts the 'accordion = 2+ disclosures' count-based heuristic used by some secondary sources?
- Does the W3C 'five rules of ARIA use' document (as a named, standalone source distinct from individual APG pattern pages) add further concrete named cases where ARIA is the wrong answer versus a native element or layout change — this specific source was referenced in the research brief but never directly quoted or confirmed in the surviving claim set.

---

## Sources

- [primary] https://www.w3.org/WAI/ARIA/apg/patterns/ — 5 claims
- [primary] https://www.w3.org/WAI/ARIA/apg/patterns/combobox/ — 5 claims
- [primary] https://www.w3.org/WAI/ARIA/apg/patterns/grid/ — 5 claims
- [primary] https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/ — 5 claims
- [primary] https://www.w3.org/WAI/ARIA/apg/patterns/menubar/ — 5 claims
- [primary] https://www.w3.org/WAI/ARIA/apg/patterns/disclosure/ — 5 claims
- [primary] https://webaim.org/projects/million/ — 5 claims
- [primary] https://www.w3.org/WAI/ARIA/apg/practices/read-me-first/ — 5 claims
- [primary] https://www.w3.org/TR/using-aria/ — 5 claims
- [primary] https://www.w3.org/TR/html-aria/ — 5 claims
- [primary] https://webaim.org/techniques/aria/ — 5 claims
- [secondary] https://www.deque.com/blog/aria-spec-for-the-uninitiated-part-1/ — 5 claims
- [blog] https://marcysutton.com/prototype-testing-accessible-clientside-routing/ — 4 claims
- [primary] https://www.gatsbyjs.com/blog/2019-07-11-user-testing-accessible-client-routing/ — 5 claims
- [blog] https://www.deque.com/blog/accessibility-tips-in-single-page-applications/ — 5 claims
- [secondary] https://developer.mozilla.org/en-US/docs/Web/API/View_Transition_API — 5 claims
- [primary] https://w3c.github.io/aria/#aria-live — 5 claims
- [primary] https://adrianroselli.com/2026/01/live-region-support.html — 5 claims
- [secondary] https://www.tpgi.com/screen-reader-support-aria-live-regions/ — 5 claims
- [primary] https://www.w3.org/WAI/WCAG22/Techniques/aria/ARIA19 — 5 claims
- [primary] https://www.w3.org/WAI/ARIA/apg/about/at-support-tables/ — 5 claims
- [primary] https://tetralogical.com/blog/2024/05/01/why-are-my-live-regions-not-working/ — 5 claims
