# Access

**This file exists because of a counted absence.**

The three parent pipelines all marked accessibility a hard rule. Across roughly 5,000 lines of
combined instruction they contained **zero** mentions of ARIA, focus management, live regions, or
accessible names. Not one. That is not an oversight, and it is not a gap you close by being more
careful next time — it is the structural consequence of only ever *checking* accessibility in a
final pass and never *designing* it. A checklist can ask "is the contrast 4.5:1?" A checklist
cannot ask "should this be a grid or a table?", because by the time anyone runs it the answer is
already in the code.

So `§10` is a hard rule, and this is the file that makes it enforceable. **Everything below is a
Loop 1 decision — made in `loops/01-direction.md`, written into `DIRECTION.md`, before a single
image is generated.** Not because auditing later is impossible; several of these are trivially
automatable, and `axe-core` will find them. Because the ones that matter are not defects to be
found. They are *shapes*: a non-drag affordance occupies layout space, a grid and a table are two
different keyboard experiences of the same visual, a VoiceOver grouping is a decision about what
is next to what. You do not fix those in Loop 8. You redraw.

The `§16` rule applies here in one direction only. The human may skip any non-hard step at a
stated cost. `§10` is **[HARD]**. What is negotiable is *how much* of this file a given surface
needs — a static one-page portfolio does not owe a combobox decision. What is not negotiable is
deciding rather than discovering.

---

## The fork

Read row 1 of `TRANSLATE.md` first. Both branches owe everything in this file. They owe it in a
different order, and they fail differently.

**Page-shaped** — read for seconds, once. The failure mode is **structure**: no landmarks, a
heading order that follows visual weight instead of meaning, an icon-only social row with no
accessible names, motion nobody art-directed a still frame for. Almost always web, so WCAG binds
directly and `§10`'s keyboard-reachable-everything is the floor. The reader arrives once, from a
search result or a link, and either the page announces its own shape in the first three seconds
of screen-reader output or it does not. Sections 2, 3, 6, 8, 9 and 11 below are the ones that
decide it.

**Tool-shaped** — read for hours, daily. The failure mode is **widgets**. Every hard problem in
this file lives here: a data grid, a combobox that filters 40,000 rows, a modal that has to
return focus to the row it came from, a queue that updates while the operator is typing
somewhere else. `§15` already demands full keyboard workflow completion and `TOOLS.md` spends
the budget — this file is where that same commitment gets its ARIA contract, because **picking a
widget pattern *is* picking a keyboard model** (§4 below), and the person who does this job eight
hours a day with a screen reader is the same person `§15` was written for. Sections 4, 5, 6 and
7 are the ones that decide it.

**One asymmetry worth naming before you start.** A page-shaped surface can be made accessible
with almost no ARIA — native elements, real headings, `main`, `nav`, `alt`. A tool-shaped
surface cannot; composite widgets have no native equivalent. That is exactly why §5 below
matters more to the tool: the surface that *needs* ARIA is the surface where bad ARIA does the
most damage.

---

## 1. The operative target is WCAG 2.2 AA

WCAG 2.2 is a W3C Recommendation (published 5 October 2023, republished 12 December 2024). It
adds nine success criteria over 2.1 and removes one — 4.1.1 Parsing — for **87 SCs against 2.1's
78**. Quoting "adds nine" without the removal produces a wrong count.

WCAG 3.0 is a **Working Draft dated 3 March 2026**. Its own text says it "still has several years
of work" and that "It is inappropriate to cite this document as other than a work in progress."
It does not deprecate WCAG 2 — WAI's own intro page states WCAG 3 "will not supersede WCAG 2 and
WCAG 2 will not be deprecated for at least several years after WCAG 3 is finalized." No design
or procurement decision in 2026 anchors to WCAG 3.

**And no law verified here names 2.2 either** (§12 below). Section 508 names WCAG 2.0. The ADA Title
II rule names WCAG 2.1. The European Accessibility Act names no WCAG version at all. So designing
to 2.2 is **anticipatory, not compliance** — which is the honest framing and also the right
decision, because the gap between 2.1 and 2.2 is precisely the six new A/AA criteria in §2 below,
and every one of them is cheaper to decide in a comp than to retrofit into a shipped layout.

Two version traps that catch people who half-remember the spec:

- Earlier 2.2 drafts numbered 2.4.11 and 2.4.12 as "Focus Appearance (Minimum/Enhanced)". The
  final Recommendation uses **Focus Not Obscured** for 2.4.11 and 2.4.12, and a single **2.4.13
  Focus Appearance** at AAA. Drafts also had 2.4.13 at AA; it is not.
- **2.4.7 Focus Visible remains AA.** A persistent myth moves it to A. It did not move.

One framing correction this file holds itself to. "These criteria cannot be retrofitted" is
overstated and this project has already caught itself saying it. `axe-core` ships an automated
`target-size` rule that measures both the size and the spacing routes; padding remediation is
routine; the 2.5.7 fix for a custom slider is click-anywhere-on-track, a pure implementation
change with no new UI. The defensible claim is narrower and it is the one that justifies Loop 1:
**several of these require new UI or new architecture** — an equivalent-control affordance, a
sticky-chrome geometry, an authentication method — **and those cannot be bolted on.** The rest
are simply cheapest when decided in the comp.

---

## 2. The six new A/AA criteria, as design decisions

Six of WCAG 2.2's nine additions land at A or AA and are therefore in scope for an AA target:
2.4.11, 2.5.7, 2.5.8, 3.2.6, 3.3.7, 3.3.8. Each converts something that used to be implicit into
a measurable spec item. Each is answered in `DIRECTION.md`.

A note on attribution that runs through this whole section: much of the most designer-useful
material lives in **Understanding** documents, which W3C labels "Informative explanations, not
required to meet WCAG." Where that is the case the phrasing below is "W3C guidance states"
rather than "the criterion requires." The distinction is not pedantry — a claim about what a
standard *requires* is checkable, and this project has already caught a summarizer inventing
normative wording twice.

### 2.5.8 Target Size (Minimum), AA — 24×24 CSS px of *effective* area

The measurement rule, from the Understanding doc's "Size requirement" section: a solid 24×24 CSS
px axis-aligned square must fit entirely inside the target. (Informative, not normative.)

There are exactly five exceptions, and their names are worth knowing because summarizers
routinely merge two of them into a sentence that does not exist: **Spacing, Equivalent, Inline,
User Agent Control, Essential.**

**"A hard 24px floor" is wrong.** The floor is on *effective, spacing-inclusive activation area*,
and it is satisfiable by size **or** by spacing.

#### The spacing exception, with the geometry — the piece `SURFACES.md` defers here

`SURFACES.md` names the second route and hands the geometry to this file. Here it is.

Center a **24 CSS px diameter circle** on the bounding box of each undersized target. The target
passes the Spacing exception when that circle **does not intersect** either (a) another target,
or (b) the circle of another undersized target.

Three consequences that fall straight out of the geometry and belong in the layout, not the QA:

1. **Two adjacent undersized targets need 24 px centre-to-centre**, because two 24 px-diameter
   circles are disjoint exactly when their centres are 24 px apart. Not 24 px of gap — 24 px of
   *centre separation*. A 16 px icon with 8 px of gap between icons gives you 24 px centre to
   centre and passes; the same 16 px icon with 6 px of gap fails, and the visual difference is
   two pixels.
2. **The measurement is centre-to-centre in the plane, not per-axis.** A tightly packed grid of
   small controls can satisfy horizontal spacing and fail diagonally. Toolbars are safe; icon
   grids are where this bites.
3. **The circle is not the target.** A larger neighbour's actual bounding box counts against
   you even if that neighbour is comfortably over 24 px. A small close button tucked against a
   large primary action fails on the *primary action's* edge.

This is a token decision and a layout decision, taken together, and it is why it lives in Loop 1:
it fixes a minimum spacing unit in the scale before any component is drawn.

**The Inline exception is the one that gets over-specced.** It exempts links inside a sentence
and targets whose size is constrained by the line-height of non-target text. Applying a 24 px
minimum to prose links is not conformance, it is damage to the typography — and it is also the
part of 2.5.8 no automated checker can decide, because a checker cannot prove that line-height
constrains a target.

**And the numbers do not transfer to native.** 24 CSS px is web- and pointer-scoped. Apple
publishes 44×44 pt *default* with a 28×28 pt *minimum*; Material publishes 48×48 dp for touch and
a separate, smaller 44×44 dp for pointer; WCAG's own AAA criterion 2.5.5 is 44×44. `SURFACES.md`
owns the full tables and the decision procedure. Do not carry 24 into a native design.

### 2.5.7 Dragging Movements, AA — the affordance occupies layout space

Normative text:

> All functionality that uses a dragging movement for operation can be achieved by a single
> pointer without dragging, unless dragging is essential or the functionality is determined by
> the user agent and not modified by the author.

**Satisfying the keyboard criteria does not satisfy this.** 2.1.1 and 2.1.3 are separate
obligations. The conforming fix is a *pointer-operable* control — a visible affordance that takes
up room in the layout — which is exactly why it is a concept-stage decision rather than a code
fix, for the class of interaction W3C itself names:

> A sortable list of elements may, after tapping or clicking on a list element, provide adjacent
> controls for moving the element up or down

> A task board that allows users to drag and drop items between columns also provides an
> additional pop-up menu after tapping or clicking

> A map allows users to drag the view of the map around, and the map has up/down/left/right
> buttons.

Reorder lists, kanban, map panning. If the design has any of those, the comp shows the buttons.

**Two scope corrections, because this criterion is routinely over-claimed.** The user-agent
exception means native `<input type="range">` and native file-input drop behaviour are exempt —
only *custom* pointer-event sliders and *author-built* dropzones are in scope, and a drag-to-upload
zone usually already ships its alternative as the file input's Browse button. And for a custom
slider the conforming alternative is click-anywhere-on-track: a pure implementation change, no
new UI. Do not confuse 2.5.7 with 2.5.1 Pointer Gestures, which is about path-based gestures.

W3C notes there are "very few situations in which dragging movements are essential." Assume yours
is not one of them.

### 2.4.11 Focus Not Obscured (Minimum), AA — sticky chrome creates an obligation

At AA, the focused component must not be **entirely** hidden by author-created content. Partial
obscuring passes — the Understanding doc says so outright: "this AA criterion allows for the
component receiving focus to be partially obscured." The AAA sibling 2.4.12 forbids any part
being hidden.

W3C names the offenders: "Typical types of content that can overlap focused items are sticky
footers, sticky headers, and non-modal dialogs" — and cookie banners explicitly: "A notification
implemented as sticky content, such as a cookie banner, will fail this success criterion if it
entirely obscures a component receiving focus." There is a dedicated failure technique, **F110**,
for sticky footers and headers.

**The honest framing is not "sticky headers fail."** W3C says outright they "can be designed so
that they pass." The framing is: *choosing persistent chrome creates a paired geometric
obligation*, and the pair is decided together or not at all. The named passing designs:

- Make the banner **modal**, so it must be dismissed before navigating the page.
- Use **CSS `scroll-padding`** so the banner never overlaps other content — this is a formally
  listed Sufficient Technique, **C43**, not prose advice.
- Close the notification **on loss of focus**.

The list is explicitly open ("Ways of passing include"), so do not present it as exhaustive. Of
the three, only modal-versus-non-modal is a pure concept-time choice; `scroll-padding`'s
design-time counterpart is **"reserve layout space for persistent sticky chrome"** — which means
the sticky header's height is a number in the spacing scale, not a value someone picks in CSS
later.

Two normative notes that cut the other way, and matter because they exempt a very common pattern:
only the **initial** position of user-repositionable content is tested, and content the user
opened that can be revealed or dismissed **without advancing focus** does not count as obscuring.
So a user-opened chat panel can be exempt while a persistent or auto-opening bubble is not.
"Floating chat widgets always fail" is wrong. Properly constructed modal dialogs always pass,
because they take focus.

If a design goes for 2.4.13 Focus Appearance at AAA, note the number: an indicator at least as
large as a 2 CSS px thick perimeter of the component, with **3:1 contrast between the same pixels
in the focused and unfocused states** — not 3:1 against the background. That is an easy and
consequential misquote.

### 3.3.8 Accessible Authentication (Minimum), AA — the auth method is an architecture decision

A cognitive function test is **not required** for any step in an authentication process unless
that step provides at least one of exactly four exceptions: **Alternative** (another method not
relying on a cognitive function test), **Mechanism** (something assists the user in completing
it), **Object Recognition**, or **Personal Content**. The AAA sibling 3.3.9 keeps only Alternative
and Mechanism.

**Read that verb carefully.** The SC says such a test *is not required*; it does not forbid
offering one. W3C's Understanding page states it "does not forbid cognitive function tests
outright." "3.3.8 bans passwords" is a misreading — the Alternative exception is precisely what
converts *required* into *not required*. There is **no essentiality or security exception** in
3.3.8; a research summarizer once invented the wording "except where that test is essential to
the security of the content", which appears nowhere in the spec, and two claims stating the
exceptions that way were refuted outright.

Normative **Note 2** — normative, not guidance — names the accepted Mechanism:

> Examples of mechanisms that satisfy this criterion include: support for password entry by
> password managers to reduce memory need, and copy and paste to reduce the cognitive burden of
> re-typing.

And the mechanism definition explicitly permits relying on the platform: "The mechanism may be
explicitly provided in the content, or may be relied upon to be provided by either the platform
or by user agents, including assistive technologies." You do not have to build it. You have to
not break it.

**Which produces the rule with the sharpest edge in this entire file.** W3C guidance states:

> if user agents and password managers are actively blocked from filling in the fields (for
> instance, by a script that prevents form fields from being automatically populated), or users
> are prevented from copy and paste operations (as they may rely on standalone/external third
> party password managers), then the page would fail this criterion unless an alternative is
> provided.

**The security team's decision to disable paste on the password field is itself the accessibility
defect.** That argument was had and adjudicated: a 2021 W3C issue showed empirically, across four
operating systems, four browsers and five password managers, that "None of the tested combinations
generate/trigger a paste event" — blocking paste does not actually block extension-based managers.
The point was conceded and the published text was rewritten to justify the paste clause
independently, on behalf of users of standalone external managers. So this is not a live dispute
you can appeal to.

Failure technique **F109** covers re-entry in a different format from creation — split OTP boxes,
"enter the 2nd, 6th and last characters" — and states that "A service that requires manual
transcription of a verification code is not compliant."

The design decision, then, is architectural and it is made once: **offer passkeys, WebAuthn, or an
email link alongside the password path**, and the Alternative exception is satisfied for
everything downstream. Decide it in Loop 1 or discover it in a security review after the login
screen is built.

### 3.3.7 Redundant Entry, Level A — multi-step flows

**Level A, the lowest tier**, which routinely surprises people who assume the newer criteria are
all AA. Information previously entered by or provided to the user, required again **in the same
process**, is either **auto-populated or available for the user to select**. Three exceptions:
re-entering is essential, the information is required for security, or the previously entered
information is no longer valid.

Two scoping precisions. The normative disjunction is *auto-populate or offer* — offering a prior
value to select is conforming, so this does not force autofill everywhere. And the scope is "in
the same process", where W3C defines a process as a sequence of activities toward one goal. W3C's
own plain-language summary loosely says "same session", which is looser than the normative text;
without "same process" a reader over-applies this across unrelated visits.

For a tool-shaped surface this is the checkout criterion generalized: any multi-step flow, any
wizard, any create-then-configure sequence.

### 3.2.6 Consistent Help, Level A — relative order, not position

An earlier research pass established only this criterion's level and flagged the rest as an open
gap. Filled.

What counts as a help mechanism, from the Understanding doc:

> Typical help mechanisms include: Human contact details such as a phone number, email address,
> hours of operation. Human contact mechanism such as a messaging system, chat client, contact
> form, social media channel. Self-help option such as an up-to-date Frequently Asked Questions,
> How Do I page, Support page. A fully automated contact mechanism such as a chatbot.

The requirement is **relative order across the set of pages**, not pixel position:

> Regardless of which approach is used, the mechanism must be located in the same relative order
> on each page within the set of pages.

> If the help item is visually in a different location, but in the same serial order, that is not
> helpful from a user's point of view, but it would not fail this criterion.

It does **not** require help to exist: "It is not the intent of this success criterion to require
authors to provide help or access to help. The Criterion only requires that when one of the
listed forms of help is available across multiple pages that it be in a consistent location."

The responsive exception is explicit and narrow — "This exception allows the location in a smaller
viewport to be different than in a larger viewport" — and **navigating between pages does not
qualify**: "merely navigating between pages within a set of web pages is not a 'change initiated
by the user' for the purposes of this exception."

Sufficient technique **G220**, a contact-us link in a consistent location. Failure: *Inconsistent
Help Location*.

The design consequence is small and specific: **help gets a fixed slot in the global template**,
decided once, and a mobile layout may move it as long as it stays in the same serial order.

---

## 3. Contrast — and the boundary that moves between platforms

`§10` sets body contrast at **≥ 4.5:1**. That is WCAG 1.4.3 at AA and it is the floor, not the
target.

The full AA set:

| What | Ratio |
|---|---|
| Body text | **4.5:1** |
| Large text | **3:1** |
| UI components and graphical objects (1.4.11) | **3:1** |

1.4.11 is the one design systems forget: an input border, a focus ring, a chart series, an
icon-only control's glyph, a toggle's off state. A 4.5:1 body rule with 1.5:1 input borders is a
common and complete failure — the text passes and the form is invisible.

### The web/native boundary mismatch

`SURFACES.md` flags this and hands it here.

**The web's "large text" boundary is 18 px or 14 pt bold. Apple's is 17 pt.** Apple's own
Accessibility page cites both WCAG and APCA, then states what its tooling enforces:

> Two popular standards of measure for color contrast are the Web Content Accessibility Guidelines
> (WCAG) and the Accessible Perceptual Contrast Algorithm (APCA). Accessibility Inspector uses the
> following values from WCAG Level AA.

| Text size | Weight | Minimum ratio |
|---|---|---|
| Up to 17 pt | all | 4.5:1 |
| 18 pt | all | 3:1 |
| any | bold | 3:1 |

**A design system that carries one contrast rule across web and iOS is using the wrong breakpoint
on one of them.** iOS body text is 17 pt by default — which sits on the *strict* side of Apple's
line, at 4.5:1, while a naive port of the web rule ("18px and up is large text") would relax
exactly the type that carries the most content. Set the boundary per platform in `DIRECTION.md`
and say which one you are using.

### Contrast is a palette constraint, not a colour-picker step

`§6` says sample the accent from the subject's real brand. That colour then has to *work*, and
whether it can carry body text, or only a 3:1 graphical role, or only a background, is a fact
about the colour — determined before it is placed, not adjusted afterwards. A brand accent that
cannot reach 4.5:1 on either background is not a problem to solve at the end; it is a constraint
on where the accent is allowed to appear, and that is a Loop 1 answer.

Light and dark are two separate contrast systems. Verify both (`§12`). And the same icon needs a
different optical grade in each — Material publishes grade 0 for a dark icon on light, **−25** for
a light icon on dark, because of visual bleed. That is a light/dark obligation on the icon layer,
not just the colour layer.

---

## 4. ARIA pattern choice is a keyboard-model commitment

This is the section the parent pipelines did not have a single line of, and the reason is
structural: pattern choice does not look like an accessibility question. It looks like an
implementation detail. It is not. **Choosing a pattern chooses a keyboard model, and the keyboard
model is visible in the design** — a grid needs a visible per-cell focus state, a menu needs an
open/closed affordance, a modal needs somewhere sensible for focus to land.

The normative anchor, from WAI-ARIA 1.2 §4.3.1:

> Authors MUST manage focus on the following container roles: grid, listbox, menu, menubar,
> radiogroup, tree, treegrid, tablist

Eight roles. Reaching for any of them is signing up to write focus management. That is the cost
line, and it belongs in Gate B alongside the performance budget.

### grid vs table — the same visual, two different keyboard experiences

The single cleanest example in the APG, and the one most likely to be gotten wrong by a design
that never asked the question.

| | `table` | `grid` |
|---|---|---|
| APG's own words | "A WAI-ARIA table is a static tabular structure… it is not an interactive widget." | "A grid widget is a container that enables users to navigate the information or interactive elements it contains using directional navigation keys" |
| Tab sequence | "**All** focusable elements contained in a table are included in the page tab sequence." | "**Only one** of the focusable elements contained by the grid is included in the page tab sequence." |
| Arrow keys | Nothing. Native scrolling. | Move between cells. |

A 200-row table with a checkbox and two buttons per row is **600 tab stops** as a table and
**one** as a grid. Same pixels. That is not a code detail; it is the difference between a keyboard
user reaching row 200 in one keystroke and pressing Tab six hundred times.

**And it is not simply "grid is better."** A grid is a composite widget: it puts a whole
interactive contract on you, and a data display with no interaction inside the cells is a table,
correctly. The decision procedure:

- Cells contain **interactive controls** and the operator works *inside* the table for hours →
  **grid**. This is `TOOLS.md`'s data table. `§15` already demands arrows move, `Enter` opens,
  `Space` selects, `Shift` extends — that *is* the grid contract, so a tool-shaped surface has
  usually already committed.
- Cells are **read**, with at most a link per row → **table**. Reach for the native `<table>` and
  write no ARIA at all.
- Rows **expand and collapse** and cells are interactive → **treegrid**, which layers a hierarchy
  contract on top of grid: `aria-expanded` per row, Left/Right Arrow to collapse and expand.

**The mode-switch trap**, which is where grid designs actually break. Any grid cell containing an
arrow-key-driven control — a combobox, a slider, a radio group — forces an explicit mode switch,
because grid navigation arrows and in-widget arrows cannot both own the arrow keys:

> While navigation keys… are moving focus from cell to cell, they are not available to do
> something like operate a combobox… Enter: Disables grid navigation… Escape: restores grid
> navigation.

That mode has to be **visible**. A cell that behaves differently depending on invisible state is a
bug for everyone, not only for screen-reader users, and drawing that state is a design job. If
the comp shows a dropdown inside a grid cell, the comp owes the entered-cell state too.

*One claim deliberately not made here:* a plausible and frequently repeated line says grid puts
screen readers into application mode and therefore silently skips non-focusable cell content.
It was tested and did not survive verification. It is not in this file.

### combobox — a closed choice of four, made at design time

The popup is **not** an open design space. Per the normative spec it is one of exactly four
roles, and the choice is a `MUST`:

> The popup is an element that has role listbox, tree, grid, or dialog

Each carries a different keyboard contract, so the visual you draw determines the code:

| Popup role | Keyboard, per APG | When |
|---|---|---|
| `listbox` | "Down Arrow moves focus to and selects the next option" | The ordinary case. Flat list of options. |
| `tree` | "Right Arrow… opens the node" | Hierarchical values — a category picker, a file path. |
| `grid` | "Down Arrow moves focus one cell down" | Multi-column results. A person picker with name, role and avatar in columns. |
| `dialog` | "Unlike other combobox popups, dialogs do not support `aria-activedescendant` so **DOM focus moves into the dialog**" | A date picker. Anything with its own internal controls. |

The fourth row is the one that changes the design: **the dialog popup is the only one where real
focus leaves the input.** Draw a date picker inside a text field and you have committed to a focus
model different from the other three, including a return path.

Plus a state obligation that is required by the normative ARIA spec, not merely APG guidance:
`aria-expanded` on the combobox element **must mirror the popup's visible open/closed state**.
Which means the design owes a visible open state — if the only cue that the popup is open is the
popup itself, there is nothing for the attribute to mirror.

*Two adjacent claims were refuted 0-3 and are not repeated here:* that a combobox is defined by
presenting its value in an editable field the user can select and copy, and that combobox always
uses virtual focus via `aria-activedescendant`. The dialog case above disproves the second
outright.

### menu / menubar — Tab exits

> Tab and Shift + Tab do not move focus among the items in the menu… Each item in the menu has
> `tabindex` set to `-1`, except in a menubar, where the first item has `tabindex` set to `0`.

Arrows navigate; **Tab leaves the whole widget**. The entire menu is one tab stop.

Two more parts of the contract, non-optional: "When a menu opens, or when a menubar receives
focus, keyboard focus is placed on the first item", and "Escape: Close the menu that contains
focus and return focus to the element or context… from which the menu was opened."

**Which means most things called "menus" should not use these roles.** A site navigation bar is a
list of links, and links belong in the tab sequence — making it a `menubar` removes six or eight
navigation links from Tab and gains nothing. The `menu` and `menubar` roles are for
**application menus**: the File/Edit/View bar of a tool, a right-click context menu, an actions
menu on a row. §5 below has the measured cost of getting this wrong, and it is the single
worst-performing pattern in the data.

*One refuted claim, flagged because it sounds right:* that a submenu-opening item must expose a
persistent visible `aria-haspopup`/`aria-expanded` affordance. Voted down 0-3. Do not cite it.

### modal dialog — one choice, four obligations

Choosing "modal" bundles a contract:

1. **Focus containment.** "Tab and Shift + Tab do not move focus outside the dialog… modal dialogs
   do not provide means for moving keyboard focus outside the dialog window without closing the
   dialog."
2. **Bidirectional transfer.** "When a dialog opens, focus moves to an element inside the dialog…
   When a dialog closes, focus returns to the element that invoked the dialog unless… the invoking
   element no longer exists." That last clause is the one tools hit: a modal that deletes the row
   it was opened from has no invoker to return to, and the design has to say where focus goes
   instead. `§15` states the rule; this is the edge case it does not cover.
3. **Initial focus is content-dependent** — a genuine design decision with three published
   answers: "add `tabindex="-1"` to a static element at the top of the dialog, such as the dialog
   title or first paragraph" for long or semantic content; "set focus on the least destructive
   action, especially if undoing the action is difficult or impossible"; the most-frequently-used
   action otherwise. Confirmation dialogs get Cancel, not Delete.
4. **`aria-modal="true"` is conditional**, and this is the one with real downside. Apply it only
   when the design enforces modality **both** behaviourally and visually:

   > marking a dialog modal by setting `aria-modal` to true can prevent users of some assistive
   > technologies from perceiving content outside the dialog… mark a dialog modal only when both:
   > Application code prevents all users from interacting… Visual styling obscures the content
   > outside of it.

   A "modal" with no scrim, that the page still scrolls behind, that sets `aria-modal="true"`, has
   hidden the entire page from assistive technology while remaining fully operable for everyone
   else. **The scrim is not decoration.** It is half of what makes the attribute honest.

**One honest dissent to carry.** The focus-trap and focus-transfer items survived verification only
2-1. A published practitioner argument holds that focus-trapping is not strictly a WCAG normative
requirement and that the native `<dialog>` element plus `inert` achieves equivalent containment
without hand-rolled trap code. That challenges the *technique*, not the behavioural contract —
the user experience above is what has to happen either way, and the native route is very often
the right one. Which is `§10`'s "semantic structure or platform-native components", applied.

### disclosure vs accordion — contested, and named as contested

A disclosure controls one collapsible region and needs its trigger's `aria-expanded` kept in sync
with visibility (`aria-controls` is optional wiring, not the deliverable). An accordion is APG's
name for "a vertically stacked set of interactive headings that each contain a title", with a
**mandatory heading-role wrapper** on each button — so the discriminating signal APG actually
encodes in markup is *headedness*, meaning information architecture, meaning a design decision
about whether these sections are peers in a document outline.

**The boundary is contested.** The claim above survived only 2-1, a W3C issue (`aria-practices`
#2445) is open on exactly this line with no editor resolution, and APG's own FAQ example
contradicts the "accordion = two or more disclosures" count-based heuristic that third-party
guidance uses. Two competing structural claims were refuted outright.

So the rule here is not a boundary. It is: **pick one, and pick it for the content-structure
reason.** If the sections are peers in an outline, they are headed, and that is an accordion. If
one region toggles and owes nothing to a document structure, that is a disclosure. If a later
reader asks why, `DIRECTION.md` answers with the structure, not with a rule number — because the
rule number is not settled.

---

## 5. The measured case for restraint

Everything in §4 above argues that ARIA is a design decision. This section is why the default
answer to that decision is *less*.

**WebAIM Million, 2026, approximately 1,000,000 home pages:**

> Home pages with ARIA present had significantly more errors (**59.1** on average) than pages
> without ARIA (**42** on average)… Increased ARIA usage on pages was associated with higher
> detected errors. The more ARIA attributes that were present, the more detected accessibility
> errors could be expected.

Roughly **41% more detected errors**, scaling with attribute count. And for one named pattern:

> 5.7% of home pages had an ARIA menu (`role="menu"`), but **22% of those ARIA menus introduced
> accessibility barriers** due to the lack of necessary ARIA menu markup and interactions.

More than one in five uses of `role="menu"` in the wild makes the page actively worse than doing
nothing. That is the pattern §4 above says is almost always the wrong choice for site navigation.

**Cite this correctly.** WebAIM's own framing is that the relationship is **correlational, not
causal** — ARIA-heavy pages also tend to be more complex overall. The honest reading is not "ARIA
causes errors." It is that *ARIA is a promise, and promises are broken at scale.* APG puts it
directly:

> `<div role="button">Place Order</div>` Is a promise that the author of that div has also
> incorporated JavaScript that provides the keyboard interactions expected for a button. Unlike
> HTML input elements, ARIA roles do not cause browsers to provide keyboard behaviors or styling.
> Using a role without fulfilling the promise of that role is similar to making a "Place Order"
> button that abandons an order and empties the shopping cart.

**No ARIA is better than bad ARIA.** Which is a design rule, not a code rule, because the way a
design accumulates ARIA is by drawing things that have no native equivalent — a custom select
because the native one cannot be styled, a nav that looks like an application menu, a div that
looks like a button.

The operating procedure, in order:

1. **Can a native element do this?** `<button>`, `<a>`, `<details>`, `<dialog>`, `<table>`,
   `<input type="date">`. Free keyboard behaviour, free focus, free semantics, free platform
   updates. Every rung you climb from here costs a promise.
2. **Can a layout change remove the need?** Two disclosures instead of one tab widget. A visible
   filter row instead of a combobox. A second page instead of a modal. This rung is invisible to
   developers and available only at Loop 1 — which is the entire argument of this file in one
   line.
3. **Only then, a documented APG pattern**, with its keyboard contract written into
   `DIRECTION.md` as a cost.

And the corollary that makes it enforceable: **an ARIA pattern in the design is a line item at
Gate B**, exactly like a shader's byte budget under `§11`. If it is not worth writing down, it is
not worth committing to.

---

## 6. Focus

`§15` owns the keyboard workflow. This section owns where focus *is*, which is a narrower and
harder problem.

### The visible part

Tab order follows visual order. Focus is always visible. Never trap focus except in a modal, and a
modal returns focus where it came from. All of that is `§15` and it is not restated here.

What is added: **the focus indicator is a designed state, not `outline: auto`.** Removing the
default outline without replacing it is the most common single accessibility defect in
professionally designed interfaces, and it happens because the default is ugly and the replacement
was never drawn. Draw it. It needs 3:1 against adjacent colours (1.4.11), it must be visible on
every background it can land on including inside a dark modal over a light page, and if the design
goes to 2.4.13 at AAA it needs 3:1 between the focused and unfocused states of the same pixels.

**`:focus-visible`, not `:focus`.** A mouse click on a button should not leave a ring; a Tab to it
must. The browser makes that distinction natively. Using it is one selector and it removes the
entire "the focus ring looks bad on click" argument that leads people to delete the ring.

### Focus after the DOM changes — what the spec says, and where it stops

WAI-ARIA 1.2 §4.3.1, normative:

> If the author removes the element with focus, the author SHOULD move focus to a **logical
> element**. Similarly, authors SHOULD not scroll the element with focus off screen unless the
> user performed a scrolling action.

That covers the tool-shaped cases directly, and each has a design answer that has to be written
down because "logical" is doing all the work:

| The element with focus disappears because… | Where focus goes |
|---|---|
| The row it was in was deleted | The next row; the previous row if it was last; the table itself if empty |
| A modal closed | The invoker — and if the invoker is gone, a named fallback (see §4 above) |
| A filter emptied the list | The filter input, not the empty list |
| A step in a wizard advanced | The new step's heading, not the page top |
| An async load replaced the region | The region, if the user asked for it; nowhere, if they did not |

For composite widgets there is a further normative-adjacent rule: when a previously focused
container is refocused, the active descendant should be **the same element** as when it was last
focused — with named exceptions for changed content and for menubar, "where the user expects to
always return to the first item."

### The SPA route change — a specification gap, named as one

A client-side route change is exactly the case the quote above describes: the element with focus
is removed. So the obligation applies.

**What no W3C normative text specifies is the destination.** This was researched directly against
the primary sources rather than recalled, and the finding is that the specification is silent —
not that the lookup failed. There is no normative answer to where focus goes on a route change,
whether the new title must be announced, or how the View Transitions API interacts with focus
restoration.

The consequence is not "so it does not matter." It is the opposite: **it is a decision, it is
yours, and it goes in `DIRECTION.md`** rather than being inherited from whatever the router does
by default. The widely reported default is that focus falls to `<body>` — which means the next Tab
starts at the top of the browser chrome and a screen reader announces nothing at all. An
interface where every navigation silently resets a keyboard user to zero has failed `§15`
completely, and no automated checker will report it, because nothing is technically wrong.

**The four destinations that actually get used**, and what each costs. This is practitioner
consensus, not specification — it is offered as an option space to choose from, and none of it
should be cited as a standard:

| Destination | What the user gets | What it costs |
|---|---|---|
| The new page's `<h1>`, made programmatically focusable | The title is announced; Tab continues into content | A focus ring lands on a heading, which has to be **designed** rather than suppressed |
| The `<main>` landmark or a wrapper | The region is announced; Tab starts at the top of content | Some screen readers announce little more than "main" |
| A visually hidden live region announcing the route | Nothing visual changes | Inherits every reliability problem in `§7` — and leaves the Tab position wrong anyway |
| Nothing — the router's default | Focus falls to `<body>` | The failure described above, in full |

The first two are the real choice. The third is the weakest and should only be picked knowing
that. The fourth is not a choice, it is the absence of one.

Whatever you choose, choose it once and apply it to every route. And verify it the way `§12`
demands — navigate, then Tab, and watch where the ring appears.

---

## 7. Live regions

The pattern nobody draws, because there is nothing to draw: **a message that arrives when the
user is looking somewhere else.** WAI-ARIA's own definition makes the design problem explicit:

> Live regions are perceivable regions of a web page that are typically updated as a result of an
> external event **when user focus may be elsewhere**.

Every tool-shaped surface has them. Saved. Sync failed. Three new jobs in the queue. 40 results.
Every one of those is visible to a sighted operator by peripheral vision and invisible to everyone
else unless a designer decided it should be announced.

### The three values, verbatim, and the one that is dangerous

> **assertive** — Indicates that updates to the region have the highest priority and should be
> presented the user immediately.
>
> **off (default)** — Indicates that updates to the region should not be presented to the user
> unless the user is currently focused on that region.
>
> **polite** — Indicates that updates to the region should be presented at the next graceful
> opportunity, such as at the end of speaking the current sentence or when the user pauses typing.

The restraint clause is normative, with a `SHOULD NOT`:

> Because an interruption may disorient users or cause them to not complete their current task,
> authors **SHOULD NOT use the assertive value unless the interruption is imperative**.

`assertive` may also destroy queued speech: "User agents or assistive technologies MAY choose to
clear queued changes when an assertive change occurs." An assertive toast firing while a screen
reader is mid-sentence in a form field does not add a message. It **deletes** one.

### `alert` vs `status` — the roles, and what they already imply

| | `role="alert"` | `role="status"` |
|---|---|---|
| Spec description | "A type of live region with important, and usually time-sensitive, information." | "A type of live region whose content is advisory information for the user but is not important enough to justify an alert, often but not necessarily presented as a status bar." |
| Implicit `aria-live` | `assertive` | `polite` |
| Implicit `aria-atomic` | `true` | `true` |

Both roles bring their politeness with them, so `role="alert" aria-live="assertive"` is redundant
and `role="alert" aria-live="polite"` is a contradiction someone will eventually have to debug.

`status` carries one extra normative obligation, and it is a *design* one: "Authors SHOULD ensure
an element with role `status` does not receive focus as a result of change in status." A status
message that steals focus is a status message that interrupts the task it is reporting on.

Two more live-region roles exist and are almost always misapplied: `log` ("new information is
added in meaningful order and old information may disappear" — a chat transcript, a build output)
and `marquee` ("non-essential information changes frequently" — a ticker). `timer` is one too.

### The design decision, which is a triage

For every asynchronous state change the surface can produce, decide once:

| Class | Announcement | Example |
|---|---|---|
| Silent | none | Hover previews, purely cosmetic transitions, anything the user is already looking at |
| Advisory | `status` / polite | Saved. 40 results. Copied. Uploading, 60%. |
| Imperative | `alert` / assertive | Session expiring in 60 seconds. Payment failed. Data loss imminent. |

The list is short on purpose. **The default is silent.** A surface that announces everything is a
surface a screen-reader user turns off, and there is no setting between "all of it" and "none of
it" that they control.

`TOOLS.md` sets the visual side of this — where toasts appear, how long they persist. This is the
audio side, and the two are decided together: a toast that vanishes in three seconds and a polite
live region that waits for a graceful pause can miss each other entirely.

### Where this stops being verified

The politeness values are **"a strong suggestion"**, per the spec: "The value may be overridden by
user agents, assistive technologies, or the user." So the behaviour above is what you are asking
for, not what will happen.

**And there is now observed data for how far apart those two things are.** The support table this
file previously lacked is `a11ysupport.io`'s — **practitioner test results, not a specification**,
carrying the site's own caution that its results for this feature "range from 4 years ago to 6
years ago" and may be out of date. Read it as evidence with a date on it, not as a rule:

| Expectation | JAWS (Cr/Ed/FF) | Narrator | NVDA (Cr/Ed/FF) | Orca | TalkBack | VO iOS | VO macOS |
|---|---|---|---|---|---|---|---|
| Announce changes at all | ✓ ✓ ✓ | ✓ | ✓ ✓ ✓ | ✓ | ✓ | ✓ | ✓ |
| `off` stays silent | ✓ ✓ ✓ | ✓ | ✓ ✓ ✓ | ✓ | ✓ | ✓ | ✓ |
| `polite` does not interrupt | ✓ ✓ ✓ | ✓ | ✓ ✓ ✓ | ✓ | ✓ | ✓ | **none** |
| **`assertive` interrupts** | **none ×3** | ✓ | ✓ ✓ ✓ | **none** | **none** | ✓ | ✓ |

The bottom row is the design finding. **`assertive` does not interrupt in JAWS, Orca, or
TalkBack** — the region announces, but the interruption, which is the entire reason a designer
reaches for `assertive`, does not happen. And `polite` is not uniformly gentle either: VoiceOver
on macOS is recorded as not honouring it.

So: **urgency that exists only in an `aria-live` value is urgency that may never be delivered.**
If something must be noticed, it needs a second channel — focus moved to it, or a modal that
takes focus by contract (`§4`). Choosing `assertive` and stopping there is choosing a behaviour a
large share of users will not get.

One thing you may have read that this file still does **not** assert: that a live region must
exist in the DOM before content is injected into it. Widely repeated; searched again in WAI-ARIA
1.2 on **2026-08-08**, at every occurrence of "live region" in the rendered spec, and not found.
It stays marked *not established — verify before relying on it*, which is also the reason the
same rule applies as everywhere: `§12`, test it with an actual screen reader.

---

## 8. Accessible names

`§10` demands descriptive alt text on every image. This is the general case, and it is broader
than images: **every interactive element has a name, whether or not anyone chose it.** If nobody
chose it, the browser computes one from whatever is lying around, and the result is usually the
file name of an icon.

The APG's five rules compress to three that are design decisions:

> **Rule 2: Prefer Visible Text.** In addition to serving as a more robust source for an accessible
> name, visible text labels enhance accessibility for many people with disabilities who do not use
> assistive technologies that present invisible accessible names. In most circumstances, visible
> text labels also make the user interface easier to understand for all users.

> **Rule 4: Avoid Browser Fallback.** … the HTML `title` and `placeholder` attributes are used as
> last resort sources of content for accessible names. Because the purpose of these attributes is
> not naming, their content typically yields **low quality accessible names that are not
> effective**.

> **Rule 5: Compose Brief, Useful Names.** Similar to how visually crowded screens and ambiguous
> icons reduce usability, excessively long, insufficiently distinct, or unclear accessible names
> can make a user interface very difficult, or even impossible, to use for someone who relies on a
> non-visual form of the user interface.

Rule 2 is the design one and it points at a layout choice: **a visible label is the accessible
name.** Every time the design removes a visible label — a placeholder instead of a label, an icon
instead of a word, a tooltip instead of a caption — it creates an invisible-name obligation that
someone has to remember. The cheapest accessible name is the one that is already on the screen.

Rule 4 names the specific trap: `title`, "commonly presented visually as a tooltip when the user
hovers over the element with a pointing device, which is **not particularly discoverable, and is
also not accessible to visual users without a pointing device**." A tooltip is not a label. It is
invisible to touch, invisible to keyboard, and it disappears.

Rule 5 is why "Read more" repeated eleven times fails: names must be **distinct**, because a
screen-reader user can pull up a list of every link on the page and eleven identical entries is
eleven identical entries.

### The warning that silently deletes content

Eighteen roles take their accessible name from their own child content — `button`, `cell`,
`checkbox`, `columnheader`, `gridcell`, `heading`, `link`, `menuitem`, `menuitemcheckbox`,
`menuitemradio`, `option`, `radio`, `row`, `rowheader`, `switch`, `tab`, `tooltip`, `treeitem`. On
any of them:

> If an element with one of the above roles that supports naming from child content is named by
> using `aria-label` or `aria-labelledby`, content contained in the element and its descendants is
> **hidden from assistive technology users** unless the descendant content is referenced by
> `aria-labelledby`. It is strongly recommended to avoid using either of these attributes to
> override content of one of the above elements except in rare circumstances where hiding content
> from assistive technology users is beneficial.

A card that is one big `<a>` containing a heading, a summary and a date, given
`aria-label="Read the article"`, has just deleted the heading, the summary and the date. The
attribute does not add a label. It **replaces** the content.

### Icon-only controls — the most common icon accessibility failure

`icons-verified.md` flagged this explicitly as unchecked against a primary source. It is checked
now, and the rule is not the obvious one.

W3C's tutorial on functional images:

> Functional images are used to initiate actions rather than to convey information. They are used
> in buttons, links, and other interactive elements. **The text alternative for the image should
> convey the action that will be initiated (the purpose of the image), rather than a description
> of the image.**

> For instance … the text alternative should be “print this page” rather than “(image of a)
> printer”, “search” rather than “magnifying lens” …

**Name the action, not the picture.** A magnifying glass is not called "magnifying glass" or
"search icon" — it is called "Search". A trash can is "Delete", not "trash". A three-dot glyph is
"More actions for [the thing]", not "ellipsis" and not "menu".

And the failure mode, stated by W3C rather than inferred:

> Missing or empty alt values create significant problems for screen reader users because
> functional images are essential to the functionality of the content. Screen readers will
> typically announce the **image file name, the image URL, or the URL for the link destination**,
> which is unlikely to help users understand the action that will be initiated by the image.

A row of five unnamed icon buttons is announced as five file names. That is the actual output, and
it is worse than nothing because the user cannot tell it is broken.

Three more rules that come off the same sources:

- **An icon that duplicates adjacent text takes `alt=""`.** W3C's own example: a logo image inside
  a link whose text already says where it goes gets a null alt, "to avoid redundancy and
  repetition." Naming both produces doubled speech.
- **Below 20 dp, a complex or key-action icon owes a *visible* text label** — Material's rule, and
  it is a design-time rule rather than a screen-reader patch. Navigation items always need labels.
- **Every custom glyph needs an accessible name on native too.** Apple states it on both the SF
  Symbols and Icons pages: "Provide alternative text labels for custom interface icons.
  Alternative text labels — or accessibility descriptions — aren't visible, but they let VoiceOver
  audibly describe what's onscreen."

The Loop 1 output is small and concrete: **for every icon-only control in the design, the string.**
Not a note that says "add aria-labels" — the actual words, written next to the icon in the comp.

### Names are content, and content gets translated

Stated on the APG page itself: "When a user interface is translated into multiple languages, ensure
that `aria-label` values are translated." An accessible name is a string a human reads. It goes
through the same pipeline as every other string (§11 below), and an untranslated `aria-label` is a
control that speaks English inside a German interface.

---

## 9. Structure — the part that costs nothing and is skipped anyway

Landmarks and headings are the cheapest accessibility work available and the most commonly
missing, because they are invisible. A page-shaped surface lives or dies here.

From the APG's landmark practice, as design rules:

- **One `main` per page.** One `banner`, one `contentinfo`. Top-level.
- **"A region landmark must have a label."** It is the only landmark with a hard label
  requirement, and it exists to cover "content that named landmarks do not appropriately
  describe" — which means every time the design invents a major section that is not nav, main,
  aside or footer, that section owes a name.
- **More than one landmark of a type → each needs a unique label.** Two `nav` elements are "Main"
  and "Footer", not two anonymous navs.
- **And the inverse, which nobody encodes:** "If a navigation landmark has an identical set of
  links as another navigation landmark on the page, **use the same label** for each navigation
  landmark." A mobile nav and a desktop nav holding the same links share a name. Distinguishing
  them tells the user there are two navigations when there is one.
- A `form` landmark "should have a label … visible to all users (e.g. an `h1`–`h6` element)". Use
  `search`, not `form`, when it is a search.

**The nesting trap.** HTML `header` and `footer` are landmarks *only when their context is the body
element*. Inside `article`, `aside`, `main`, `nav` or `section` they are not. So a layout decision
— wrapping the page in a `<section>` for styling — silently deletes the banner and contentinfo
landmarks, with no visual change and no error anywhere.

**Headings are an outline, not a type scale.** `h1` through `h6` describe document structure;
`STYLES.md` describes size. A heading chosen because it is the right size is a broken outline, and
screen-reader users navigate by heading more than by any other mechanism. One `h1`. No skipped
levels. If the design needs a small heading in a prominent place, that is a CSS class, not an
`h5`.

**Skip link.** One "Skip to content" link, first in the tab order, visible on focus. It is four
lines and it is the difference between reaching the article in one keystroke and forty.

---

## 10. Native — and where a web checklist misses

`SURFACES.md` owns the platform tables. This section owns the places where a web-trained
accessibility instinct produces the **wrong answer** on native, which is a shorter and more useful
list.

### The cleanest divergence found: system zoom

Apple's guidance:

> Ideally, give people the option to enlarge text by at least **200 percent** (or **140 percent**
> in watchOS apps).

Apple's own word is "Ideally" — aspirational in the HIG. App Store Connect converts the same
numbers into pass/fail evaluation criteria for the Larger Text accessibility label, so it is a
shipping bar in practice.

**And Apple explicitly excludes system Zoom and Hover Text from counting toward it.** The app must
enlarge its own text, via Dynamic Type or custom UI. System magnification does not satisfy the
requirement.

**On the web, browser zoom does satisfy WCAG 1.4.4 Resize Text and 1.4.10 Reflow.** It is an
accepted mechanism.

Same user-facing feature. Opposite verdict, depending on platform. There is no principle that
reconciles them and no way to derive one from the other — you have to know which platform you are
on. This is the single clearest reason a web-derived accessibility checklist cannot be pointed at
a native app.

**What it costs the layout**, since 200% is not a font setting but a stack-axis change. Apple's
Dynamic Type ramp is 7 standard sizes plus 5 accessibility sizes, AX1 through AX5 — twelve sizes a
layout must survive. Body runs **17 pt to 53 pt**, roughly 3.1×, crossing 200% already at AX3.
Scaling is **non-uniform**: Large Title runs 34 pt to 60 pt, about 1.76×, so at the top of the ramp
Body nearly equals default-size Headline and *exceeds* default Large Title. Every size relationship
in the type scale inverts. Apple's stated remedies are layout instructions, not typography ones:
switch side-by-side layouts to a vertical stack so each element gets full width, let text wrap to
two or more lines rather than truncate, reduce multi-column text to fewer columns.

Android 14 raised its own maximum to 200% with a **non-linear** curve so large text scales less
aggressively than small text. The consequence has no CSS analogue: **`sp` values stop being
additive.** 4 sp + 20 sp may not equal 24 sp, so `sp` must not be used for padding or for view
heights that assume implicit padding — and an app must be explicitly retested at 200% even though
`sp` gets the improvement automatically.

### VoiceOver grouping is a layout-time decision

Reading order is derived from layout: top to bottom, left to right in the user's active locale.
Which means an ungrouped gallery of images with captions is read as **every image, then every
caption** — two disjoint streams.

Apple states this at the design-guideline level and defers the API to developer docs: "Specify how
elements are grouped, ordered, or linked." **Visual proximity encodes relationship silently.** A
sighted user sees the caption under the photo and the relationship is free. Nobody else gets it
unless a designer declared it.

The Loop 1 output: audit the comp for every relationship conveyed *only* by proximity or
alignment, and write down which elements are one unit. That is a design artefact — it is the same
grouping decision as `STYLES.md`'s spacing, made explicit.

### Label and value are separate channels

Apple's VoiceOver evaluation criteria require a label distinct from a control's value: the label
names the field ("phone number"), the value carries the content ("555-0100"). And separately,
control type and state — "checkbox", "checked" — belong in **traits**, never in the label, because
duplicating them produces doubled speech: *checkbox, checkbox*.

The web analogue is real and worth stating: an input's `<label>` is its name, its content is its
value, and `aria-label="Search field text input"` produces *search field text input, edit text*.
Name the thing. The platform announces what kind of thing it is.

### Reduce Transparency and Increase Contrast are designed states

`SURFACES.md` establishes that Liquid Glass re-renders under these settings and hands the
consequence here.

They are **designed states**, exactly the way `§10` treats `prefers-reduced-motion`: a still frame
someone art-directed, not a degradation discovered in QA. A design whose hierarchy depends on
translucency has no hierarchy under Reduce Transparency. A palette tuned for subtlety has no
distinctions under Increase Contrast.

So a native surface owes **three** designed states, not one, and `§12` applies to all of them —
screenshot each:

| State | What it changes | Who it is for |
|---|---|---|
| Reduced motion | Transitions, parallax, autoplay | Vestibular disorders, motion sensitivity |
| Reduce Transparency | Materials become opaque; blur is removed | Low vision, cognitive load |
| Increase Contrast | Borders appear, colours separate, subtlety is destroyed | Low vision |

Apple also names the reduced-motion techniques rather than just the setting, and they are design
instructions: tighten animation springs to reduce bounce; track animations directly with people's
gestures; avoid animating depth changes in z-axis layers; replace transitions in x-, y- and z-axes
with fades; avoid animating into and out of blurs. The last two are the ones that get missed, and
they are exactly what is fashionable.

### Four more native obligations with no web equivalent

- **Gesture alternatives are mandatory.** "If you use a swipe gesture to dismiss a view, also make
  a button available." A swipe-only interaction is a design defect. This is the native analogue of
  WCAG 2.5.7, and it is broader — it covers any gesture, not only dragging.
- **Time-boxed UI.** "Views and controls that auto-dismiss on a timer can be problematic… Prefer
  dismissing views with an explicit action." A three-second toast carrying the only copy of an
  Undo affordance is a defect.
- **Assistive Access** (iOS/iPadOS) is a distinct layout mode to plan for: identify core
  functionality, one interaction per screen, confirm twice on hard-to-recover actions.
- **Accessibility Nutrition Labels** exist on the App Store. Accessibility support is now publicly
  declared, which moves it from an internal quality bar onto a marketing surface — and makes an
  overclaim a different kind of problem.

One convenience worth knowing: SF Symbols "provides many variants for specific languages and
writing systems, including Latin, Arabic, Hebrew, Hindi, Thai, Chinese, Japanese, Korean, Cyrillic,
Devanagari, and several Indic numeral systems", and they "adapt automatically when the device
language changes." That is `§13` handled at the icon layer, for free, on one platform. Custom
glyphs get none of it — an arrow you drew yourself does not flip for RTL unless you draw the
flipped one, which Apple states directly: "include a flipped version of the icon to use when the
context is right-to-left."

---

## 11. Internationalization

`§13` is the hard part and it is already stated: if the subject is presented in a non-Latin script
or an RTL language, handle it properly — `dir="rtl"`, CSS logical properties, a font that actually
renders the script, mirrored layout, **and never transliterate or mangle a name to make it fit.**
That last clause is not a technical rule; it is the same respect `§14` extends to a face.

This section adds what the parents lacked, which is everything that breaks a layout *before*
anyone reaches a different script.

### Text expansion — a real table, and its actual provenance

W3C's i18n article republishes IBM's figures for English into European languages:

| No. of characters in English source | Average expansion |
|---|---|
| Up to 10 | **200–300%** |
| 11–20 | 180–200% |
| 21–30 | 160–180% |
| 31–50 | 140–160% |
| 51–70 | 151–170% |
| Over 70 | **130%** |

**Attribution matters here.** These are IBM's numbers, republished by W3C as "average expected
expansion rates" — not a W3C requirement and not a measurement of your strings. The 51–70 row is
reproduced as published, above the preceding row's ceiling; that is what the source shows, and
smoothing it would be inventing data.

The load-bearing sentence is not any single number:

> The general message is that text will normally expand, but note carefully how **the smaller the
> source message, the higher the likely translation length**.

**Which inverts the intuition.** The long paragraph is fine — 130%, and prose reflows. The
catastrophe is the short string, because short strings live in tight places:

> The problem tends to be that the smaller the English text, the more likely it is to be squeezed
> into a small space, such as alongside a form entry field, or inside a graphic, or a set of width
> restricted tabs, etc.

W3C's worked case: the word for "views" is one English word and `visualizzazioni` in Italian, a
ratio of **3.0**; German `-mal angesehen` is **2.8**. Now put that in a nav item, a tab, a button,
a table column header, a chart axis label, a badge — every place a design is proudest of its
tightness.

So the design rule is a **layout** rule, not a translation rule:

- **A tab bar, a nav, or a button row sized to its English content is a layout that breaks in
  German.** Design the tight version and check it at roughly triple the label width. If it cannot
  survive, the design is a fixed-width design and it does not ship multilingual.
- **Never build text into a graphic** if the interface will be translated. `§8` already says
  generate your visuals; this says keep the words out of them.
- Shorter is also a problem: "smaller translations can be as problematic as bigger ones if they
  leave too much white space on the page."
- One measurement note from the same source: "Because of the width of the glyphs involved, each
  Chinese and Korean character is counted as **two** English characters in width." A CJK string
  with half the character count is not half the width.

**One thing this file will not do is quote a percentage for a language it did not verify.** The
table above covers English into European languages and nothing else. If a run needs an expansion
figure for a language outside that set, it does not have one — describe the effect and design for
elasticity rather than to a number.

### CJK line breaking

The two parameters that decide everything, per W3C:

> whether 'words' or syllables are separated in the text, and if so, how, and
> whether the writing system wraps words, syllables, or characters to the next line.

Japanese and Vai wrap **individual characters**, "regardless of word or syllable boundaries" —
Japanese being mora-based rather than syllable-based, such that text can wrap *inside* a single
syllable. Chinese and Korean wrap syllables, unusual in that a syllable normally corresponds to a
single character. South-East Asian scripts including Thai and Khmer have **no word separator at
all**, and finding a break point requires analysing the text.

The rules that are not optional:

> It is common to most scripts that content should not start a line with a punctuation mark that
> shows the end of a phrase or section.

> Other punctuation marks are normally not expected to end a line. These include opening
> parentheses or brackets.

**What this means for a design.** Justification and ragged-right behave differently, because CJK
text can break almost anywhere and therefore justifies cleanly where Latin needs hyphenation.
Hanging punctuation outside the margin is a normal Japanese and Chinese strategy — and it "only
works if there is a visible margin available", so it is a layout decision made before the text
arrives. CSS exposes the Japanese-specific control directly: the `line-break` property's `strict`
and `loose` values decide whether a small kana may separate from its preceding character, useful
"for text in narrow columns, such as newspapers."

And the thing every Latin-first design gets wrong: **line-height tuned for Latin is too tight for
CJK**, which has no ascenders and descenders to create optical space and needs more leading, not
less.

### Plural rules are not a two-case `if`

Unicode CLDR:

> Languages vary in how they handle plurals of nouns or unit expressions (“hour” vs “hours”, and so
> on). Some languages have two forms, like English; some languages have only a single form; and
> some languages have multiple forms.

**Six categories:** `zero`, `one` (singular), `two` (dual), `few` (paucal), `many`, `other`
(required — the general plural form, also used if the language has only a single form).

And they are **not grammatical categories**: "the categories are determined by changes required in
a phrase or sentence if a numeric placeholder changes value." The mapping from number to category
is not a range check either — CLDR's own example has `few` covering 2–4, 22–24 and 32–34 while
`other` covers 0, 5–20 and 25–30.

CLDR's stated reason for the whole mechanism is a design one: it allows "more natural phrasing than
constructions like '1 hour(s)'." Which is exactly the design decision. **"3 item(s)" is a design
failure with a technical cause**, and the fix is not in the copy — it is deciding at Loop 1 that
every count-bearing string goes through a plural mechanism, so the design never contains a
hard-coded "s".

The design-visible consequence: a string with six possible forms has six possible widths, which
folds straight back into the expansion problem above.

### And the rest of `§13`, restated as decisions

- **Direction is a token, not a stylesheet.** CSS logical properties (`margin-inline-start`, not
  `margin-left`) means one layout, both directions. Deciding this at Loop 1 costs nothing; adding
  it later is a rewrite of every spacing rule in the system.
- **Mirroring is not universal.** Layout mirrors. Directional icons mirror. Clocks, media playback
  controls, and anything representing physical reality do **not**. Decide per icon.
- **The font is a script decision.** A typeface with no Arabic coverage renders Arabic in a
  fallback, and the design's whole typographic argument disappears — which under `§7` also means
  the fallback is not self-hosted and not owned.
- **Numerals are a locale decision** — Eastern Arabic numerals, Devanagari digits — and SF Symbols
  ships variants for several Indic numeral systems that adapt on device language.
- **Icons are localized too.** Material states it directly: "Translate icons for local markets. For
  example, different locales may prefer a cart, bag, or basket for checkout experiences", and
  colour carries cultural meaning — white is purity in some western cultures and mourning in some
  eastern ones, and red-versus-green as the warning colour is not universal.
- **And the name is the name.** `§13`'s last clause. Not transliterated, not truncated, not
  romanized to fit a layout. If the layout cannot hold it, the layout is wrong.

---

## 12. The law

Researched at the source, by browser, after three separate research passes returned zero surviving
claims on this topic. Everything below was read off the primary text. What was not verified is
named at the end of this section rather than guessed, because **a wrong compliance date in a design
tool is worse than an absent one** — someone could rely on it.

### The three-standard spread

| Instrument | Names | Binds |
|---|---|---|
| Section 508 (Revised), US | **WCAG 2.0** A + AA | US federal ICT procurement |
| ADA Title II rule, US | **WCAG 2.1** AA | US state and local government |
| European Accessibility Act | **no WCAG version at all** | EU products and services in its Article 2 scope |

**No instrument verified here names WCAG 2.2.** §1 above already drew the conclusion: 2.2 is the
right design target and it is anticipatory, not compliance.

### European Accessibility Act — Directive (EU) 2019/882

Article 31: Member States adopt by 28 June 2022 and **"shall apply those measures from 28 June
2025."** Article 2 scopes the same date to products "placed on the market after 28 June 2025" and
services "provided to consumers after 28 June 2025."

**In scope, verbatim from Article 2(2):** electronic communications services; services providing
access to audiovisual media services; named elements of air, bus, rail and waterborne passenger
transport (websites, mobile apps, e-tickets, travel information, self-service terminals);
**consumer banking services**; **e-books and dedicated software**; and **e-commerce services**.
Products in scope include consumer computer hardware and its operating systems, payment terminals,
ATMs, ticketing and check-in machines, e-readers, and consumer terminal equipment for electronic
communications and audiovisual media.

**The microenterprise exemption, with its real threshold.** Article 3 defines a microenterprise as
"an enterprise which employs **fewer than 10 persons** and which has an annual turnover **not
exceeding EUR 2 million** or an annual balance sheet total not exceeding EUR 2 million." Article
4(5): "Microenterprises providing services shall be exempt from complying with the accessibility
requirements." Note the asymmetry — the exemption is for microenterprises **providing services**.
Microenterprises **dealing with products** are not exempt; their obligations are lighter, and they
are excused only from documenting their disproportionate-burden assessment, not from making it.

**Article 32 is the part every summary drops.** There is a long tail: a transitional period ending
**28 June 2030** during which service providers may keep using products lawfully in use before
that date; service contracts agreed before 28 June 2025 continuing until they expire but no longer
than five years; and self-service terminals running "until the end of their economically useful
life, but no longer than 20 years after their entry into use." Content exemptions include
pre-recorded time-based media and office file formats published before 28 June 2025, and archives
not updated after that date.

**And the finding that matters most to a design tool: the EAA never names WCAG.** Not once in the
directive. The mechanism is Article 15 — conformity is *presumed* for products and services
conforming to harmonised standards whose references are published in the Official Journal. So the
chain is EAA → harmonised standard → WCAG, and the WCAG version is a property of the standard's
edition, not of the law. **Any sentence of the form "the EAA requires WCAG 2.1 AA" is a two-step
inference presented as a citation.**

### EN 301 549 — the harmonised standard, and where the chain actually stops

The missing link above is now read, from ETSI's own published PDFs. It does not lead where the
two-step inference assumes.

| Edition | Status on its cover page | WCAG | Directive it maps to |
|---|---|---|---|
| **V3.2.1 (2021-03)** | "HARMONISED EUROPEAN STANDARD" — **published** | **2.1** | **2016/2102** (Web Accessibility Directive, public-sector bodies), via Annex A |
| **V4.1.0 (2026-06)** | "**Final draft** EN 301 549 V4.1.0" — not published | **2.2** | 2016/2102 via Annex ZA **and 2019/882 (the EAA) via Annex ZB** |

V3.2.1: *"The present document reflects the content of the W3C WCAG 2.1 Recommendation."* Its
foreword names only Directive 2016/2102. **It contains no EAA annex.**

V4.1.0 is the first edition prepared for the EAA — under standardisation request M 587 / C(2022)
6456 final — and it says what publication would unlock:

> **Once the present document is cited in the Official Journal of the European Union** under that
> Directive, compliance with the normative clauses … confers … a **presumption of conformity**
> with the corresponding essential requirements of that Directive.

So, as of **2026-08-08**: the EAA has applied since 28 June 2025, and **there is no published
harmonised standard that maps to it.** The standard people reach for instead — V3.2.1 — carries
WCAG 2.1 and addresses a different directive. WCAG 2.2 enters the EAA chain only when V4.1.0 is
published and cited.

**What this settles for the plugin.** `§1`'s target of **WCAG 2.2 AA is stricter than the current
EU legal floor and forward-compatible with the draft that is coming.** That was previously an
accident and is now a position. It also sharpens the standing rule below: this is the most
volatile material here, and the citation status of V4.1.0 is exactly the kind of thing that
changes between a run and the next one.

### ADA Title II, United States

From DOJ's own guidance page, one sentence carrying three dates:

> On April 24, 2024, the Federal Register published the Department of Justice’s (Department) final
> rule updating its regulations for Title II of the Americans with Disabilities Act (ADA)… On
> April 20, 2026, the Federal Register published the Department’s Interim Final Rule (IFR)
> extending the compliance date for State and local government entities with a total population of
> 50,000 or more to **April 26, 2027**. The compliance date for public entities with a total
> population of less than 50,000, or any special district government, is extended to **April 26,
> 2028**.

The standard: "The Web Content Accessibility Guidelines (WCAG) Version **2.1, Level AA** is the
technical standard for state and local governments' web content and mobile apps."

**Title II binds state and local government, not private business.** And a contractor does not
escape it — DOJ's own example: "If a city lets people pay for public parking using a mobile app,
that mobile app must meet WCAG 2.1, Level AA even if the app is run by a private company."

The page also names WCAG 3.0 by name as a hypothetical acceptable *higher* standard, which
confirms §1 above from the regulator's side: 3.0 is a future alternative, not a current
requirement.

### Section 508, United States

E205.4: "Electronic content shall conform to Level A and Level AA Success Criteria and Conformance
Requirements in **WCAG 2.0**." The software provisions repeat the same bar. There is one exception
worth knowing because it is the one place a legal instrument *subtracts* criteria: non-Web
documents are not required to conform to 2.4.1 Bypass Blocks, 2.4.5 Multiple Ways, 3.2.3 Consistent
Navigation, or 3.2.4 Consistent Identification.

### Not established in this pass — verify before relying on any of it

Named explicitly so silence is not read as agreement.

- **Whether EN 301 549 V4.1.0 has been cited in the Official Journal** since the June 2026 final
  draft. EUR-Lex was not read. The editions and the WCAG versions they carry are now established
  above; the citation status is not, and it is the switch that turns the EAA chain on.
- **Whether any member state's transposition names a WCAG version directly.** Transposition is
  national and 27-way. None was read.
- **Whether the EAA reaches non-EU companies selling into the EU.** Territorial scope was not
  analysed and no quote supports either answer.
- **ADA Title III** — private business. There is no equivalent DOJ web regulation verified here.
  Private-sector US web accessibility liability is litigation history, not a named standard, and
  it was not researched.
- **Any jurisdiction outside the US and EU.** Not researched at all.

**And the standing rule.** None of this is legal advice, it is the design target's provenance. If a
run's answer depends on a compliance date, the run confirms that date at the primary source on the
day, because this is the most volatile material in the plugin — the US deadlines already moved once,
in April 2026.

---

## 13. The Loop 1 decision list

This is the output. It runs in `loops/01-direction.md` and lands in `DIRECTION.md` before an image
is generated. A skipped row is recorded as a decision with its cost, per `§16` — never as silence.
A row whose surface does not exist in the run — no login, so no authentication path to decide — is
recorded as **N/A with the reason**, which is distinct from a deferral: a deferral names a cost,
and a cost for a surface that does not exist would be a fabrication. Rows marked **⑂** fork per
concept — sticky chrome, the still frame, and the ring's backgrounds all change with the concept,
so each concept answers them itself; unmarked rows have one answer per run.

**Both surface classes:**

| # | Decision | Where it binds |
|---|---|---|
| 1 | Target size route: size, or the spacing exception with its 24 px centre-to-centre geometry | §2 above; spacing unit enters the scale |
| 2 | Contrast boundary — the web's 18 px / 14 pt bold, or Apple's 17 pt — stated, not assumed | §3 above |
| 3 | Whether the sampled brand accent can carry body text, a 3:1 graphical role, or neither | §3 above; constrains `§6` |
| 4 | ⑂ The focus indicator, drawn — with its ratio measured on every background it can land on, light and dark, including the accent itself, the background most likely to break it | §6 above |
| 5 | ⑂ Sticky chrome geometry: reserved layout space, or modal, or none | 2.4.11, §2 above |
| 6 | Every author-built drag gets a visible non-drag affordance, in the comp | 2.5.7, §2 above |
| 7 | Authentication path: the Alternative that makes 3.3.8 conform; paste and password managers unblocked | 3.3.8, §2 above |
| 8 | Help's fixed slot in the global template | 3.2.6, §2 above |
| 9 | Landmark map and heading outline — separate from the type scale | §9 above |
| 10 | The accessible name for every icon-only control, written as the actual string | §8 above |
| 11 | ⑂ Reduced-motion still frame, art-directed | `§10` |
| 12 | Script, direction, and the expansion budget on the tightest string in the design | §11 above |
| 13 | Where focus goes on route change, and on the removal of the focused element | §6 above |

**Additionally, tool-shaped:**

| # | Decision | Where it binds |
|---|---|---|
| 14 | grid or table, per tabular surface — and the entered-cell state if any cell holds an arrow-key control | §4 above |
| 15 | Combobox popup role, one of four, per combobox | §4 above |
| 16 | Modal initial focus per dialog, plus the fallback when the invoker is gone | §4 above |
| 17 | Whether anything is genuinely a `menu`/`menubar` — the answer is usually no | §4 and §5 above |
| 18 | Live-region triage: every async state change classed silent, advisory, or imperative | §7 above |
| 19 | Every ARIA pattern listed as a Gate B cost line, with its keyboard contract | §5 above |

**Additionally, native:**

| # | Decision | Where it binds |
|---|---|---|
| 20 | The layout at 200% text (140% watchOS) — a stack-axis change, not a font size | §10 above |
| 21 | VoiceOver grouping: every relationship currently carried only by proximity | §10 above |
| 22 | Reduce Transparency and Increase Contrast, art-directed as states | §10 above |
| 23 | A pointer alternative for every gesture; no timer-only dismissal | §10 above |

---

## What this file does not settle

Named so a later run does not read silence as agreement, and so nobody builds on sand.

- **Where focus goes on an SPA route change** is a genuine specification gap, confirmed against
  primary sources. This file requires the decision and does not supply the answer.
- **The View Transitions API's interaction with focus and `prefers-reduced-motion`** was not
  verified.
- **"A live region must exist in the DOM before content is injected"** is widely repeated and is
  not in the WAI-ARIA 1.2 text read for this file. Not established in this pass.
- **Cross-screen-reader behaviour for `aria-atomic` and `aria-relevant`** was not verified. The
  `aria-live` half now has observed data in `§7` — practitioner test results, 4–6 years old,
  labeled as such — but the two companion attributes have no table here.
- **The disclosure/accordion boundary** is contested at W3C with an open issue and no editor
  resolution. §4 above asks for a reason, not a rule.
- **Whether EN 301 549 V4.1.0 has been cited in the Official Journal.** The editions and their
  WCAG versions are established in `§12` above; the citation that would turn the EAA chain on is
  not, and neither is any national transposition.
- **Any measured figure for the cost of icon-only controls.** W3C states the requirement; no
  comprehension study, error rate, or task-time measurement was located. Material's "use caution if
  icons are displayed without labels" is guidance and must not be dressed up as a finding.
- **Text expansion outside English into European languages.** One table, one language pair
  direction, IBM's numbers. Nothing else.
- **APCA.** Apple names it alongside WCAG; WCAG 3.0's conformance model is a Working Draft with
  open editor's questions. Nothing here is designed to APCA and no APCA threshold appears in this
  file.

The rule that governs all of the above is the same one that produced this file. **Research it, or
mark it unverified. Do not recall it.** This project has already caught four instances of
plausible-but-wrong content — including one claim that contradicted its own cited source, and a
research harness that returned a stub which satisfied its output schema and so passed validation
without erroring. Accessibility content is where a fifth would do the most damage, and legal
content is where it would do more damage still.
