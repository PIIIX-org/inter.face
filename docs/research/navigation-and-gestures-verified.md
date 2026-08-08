# Research — navigation, safe areas, gestures, canonical layouts

**Date:** 2026-08-08
**Method:** headless Chromium against rendered primary sources — Apple HIG and Material 3 are
both JS-rendered, so nothing here came from raw HTML or a summarizer.

Same three tiers as `construction-verified.md`: **SPEC** (quoted off the rendered source, with
its date), **MEASURED**, **CRAFT** (labeled, never dressed as spec).

Two of the four topics here existed as open items: Material's canonical layouts came back
`"quality":"unreliable","claimCount":0` in the tablet/desktop pass, and Android 15 edge-to-edge
had never been read at all.

---

## 1. Navigation: the two platforms disagree about whether the count is a rule

### Apple — no maximum, and the "five tabs" folklore is not what the page says

Source: `developer.apple.com/design/human-interface-guidelines/tab-bars`, page updated
**June 8, 2026** ("Updated terminology and art").

Apple states no maximum number of tabs. The only number on the page is conditional and is an
aim rather than a limit:

> If you let people **select their own tabs**, aim for a default list of **five or fewer** to
> preserve continuity between compact and regular view sizes.

That is guidance about *customizable* tab bars. Anything of the form "iOS allows a maximum of
five tabs" does not come from this page. It belongs in the same category as "Apple's minimum
target is 44×44 pt" — a real number, remembered with the wrong scope.

What the page does state as rules:

- **A tab bar is navigation, not actions.** "If you need to provide controls that act on
  elements in the current view, use a toolbar instead."
- **Keep it visible.** "If you hide the tab bar, people can forget which area of the app
  they're in." The one exception is a modal covering it, "because a modal is temporary and
  self-contained."
- **Avoid overflow tabs.** When horizontal space limits visible tabs, "the trailing tab becomes
  a **More** tab in iOS and iPadOS, revealing the remaining items in a separate list. The More
  tab makes it harder for people to reach and notice content on tabs that are hidden, so limit
  scenarios in your app where this can happen." So the real constraint is not a count — it is
  that the *device and orientation* decide how many are visible, and the design owns what
  happens when they do not all fit.
- **Never disable or hide tab bar buttons**, even when their content is unavailable: doing so
  "makes your app's interface appear unstable and unpredictable. If a section is empty, explain
  why its content is unavailable." That is an empty-state obligation arriving through the
  navigation door.
- **Labels, single words where possible.** For complex information structures, "consider a
  sidebar or a tab bar that adapts to a sidebar."

### Material — three to five, stated as a rule

Source: `m3.material.io/components/navigation-bar/guidelines`.

> Navigation bars provide access to **three to five destinations**.

Repeated as "Navigation bars can have three to five destinations" and "Three to five main pages
in the product". Also: **mobile and tablet only**; not for single tasks ("such as viewing one
email"); one destination is always active; **vertical items in compact windows, horizontal items
in medium windows**.

Combined with the per-breakpoint navigation already recorded in `construction-verified.md`
(bar in Compact, rail from Medium up, expanded rail suiting Extra-large), Material gives a
complete ladder and a count. Apple gives a ladder and refuses the count. **A cross-platform
design that picks one number and ships it to both has followed neither.**

### Predictive back is now the default on Android

Source: `developer.android.com/about/versions/16/behavior-changes-16`.

> For apps targeting Android 16 (API level 36) or higher and running on an Android 16 or higher
> device, the predictive back system animations (back-to-home, cross-task, and cross-activity)
> are enabled by default. Additionally, **`onBackPressed` is not called and
> `KeyEvent.KEYCODE_BACK` is not dispatched anymore.**

Opting out is `android:enableOnBackInvokedCallback="false"` and is described as temporary. The
design consequence: back is no longer an event an app intercepts at the last moment — the
system needs to know *in advance* where back goes, because it animates the destination during
the gesture. A back destination that is computed at press time cannot be previewed.

### Sheets

Source: `developer.apple.com/design/human-interface-guidelines/sheets`.

- **Modality is platform-determined.** "In macOS, tvOS, visionOS, and watchOS, a sheet is always
  modal." In iOS and iPadOS a sheet can be modal or nonmodal, where a nonmodal sheet lets people
  "affect the parent view without dismissing the sheet."
- **Three buttons with fixed meanings**: Cancel/Close dismisses without saving; Done dismisses
  after completing or explicitly saving; **Back moves within the flow and "isn't intended to
  dismiss a sheet."** Placement varies by platform.
- **A sheet is for a scoped task.** "For complex or prolonged user flows, consider alternatives"
  — full-screen modal presentation on iOS/iPadOS, a separate window or full screen on macOS.

---

## 2. Safe areas and edge-to-edge: no longer optional on Android, still unnumbered on Apple

### Android 15 made it default; Android 16 removed the escape hatch

Source: `developer.android.com/about/versions/15/behavior-changes-15`.

> Apps are edge-to-edge by default on devices running Android 15 if the app is targeting
> Android 15 (API level 35). ... **This is a breaking change that might negatively impact your
> app's UI.**

What changes, verbatim in structure:

| Area | Behavior when targeting API 35 |
|---|---|
| Gesture handle navigation bar | Transparent by default; bottom offset disabled so content draws behind it unless insets are applied. `setNavigationBarColor` deprecated and has no effect on gesture navigation |
| 3-button navigation | 80% opacity by default; bottom offset disabled; `setNavigationBarContrastEnforced` true by default, adding an 80% opaque background |
| Status bar | Transparent by default; top offset disabled; `setStatusBarColor` deprecated and has no effect |
| Display cutout | `layoutInDisplayCutoutMode` must be `ALWAYS`; `SHORT_EDGES`, `NEVER`, and `DEFAULT` are all interpreted as `ALWAYS` |

Source: `developer.android.com/about/versions/16/behavior-changes-16`.

> For apps targeting Android 16 (API level 36), `R.attr#windowOptOutEdgeToEdgeEnforcement` is
> **deprecated and disabled, and your app can't opt-out of going edge-to-edge.**

So on Android this is now a design premise, not a design option: **every surface is drawn under
the system bars and the design owns the insets.** A layout whose bottom action sits at the
window edge is a layout with a system gesture handle through it.

### Apple names safe areas and publishes no numbers

Source: `developer.apple.com/design/human-interface-guidelines/layout`. The page instructs
"respecting system-defined safe areas, margins, and guides (where available)" among the
adaptability practices, and lists the variations to handle — screen sizes, orientation, "system
features like Dynamic Island and camera controls", external displays, Display Zoom, resizable
windows on iPad, Dynamic Type, locale.

There is **no published inset table**, which is consistent with the Phase 3 finding that Apple
publishes no spacing scale or grid module. Insets are read from the system at runtime. Any
fixed number attributed to an Apple safe area is invention.

### The web has the same concept, plus one variable most designs are missing

Source: CSS Environment Variables Module Level 1 (`drafts.csswg.org/css-env-1/`).

- `safe-area-inset-top` / `-right` / `-bottom` / `-left` define "a rectangle by its top, right,
  bottom, and left insets from the edge of the viewport... such that all content inside the
  rectangle is visible." **"For rectangular displays, these must all be zero"** — so
  `padding: env(safe-area-inset-bottom)` collapses to nothing on a desktop, and the usable
  pattern is `max(<your spacing token>, env(safe-area-inset-bottom))`.
- **`safe-area-max-inset-*`** is the one worth knowing: the same four insets as **static** values
  "that represent the maximum value of their dynamic counterpart when dynamic UA interfaces are
  retracted." The dynamic insets change as browser chrome retracts on scroll; the max variants do
  not. A layout that jumps when a mobile toolbar hides is a layout using the dynamic value where
  it wanted the static one.
- `viewport-segment-*` exists for foldables, indexed by segment.

The insets only become non-zero with `viewport-fit=cover` in the viewport meta. Per CSS Round
Display Level 1, `cover` sets "the initial layout viewport and the visual viewport ... to the
circumscribed rectangle of the physical screen of the device", where the default `auto` leaves
the layout viewport untouched.

---

## 3. Gesture conflicts: one edge is negotiable, the other is not

Source: `developer.android.com/develop/ui/views/touch-and-input/gestures/gesturenav` and the
`View.setSystemGestureExclusionRects` reference.

**Back — negotiable.** "The new system gesture for back is an inward swipe from **either the
left or the right edge** of the screen. This might interfere with app navigation elements in
those areas." An app opts out selectively by passing a `List<Rect>` to
`View.setSystemGestureExclusionRects()` (API 29+, and in `ViewCompat` from androidx.core
1.1.0-dev01). `DrawerLayout` and `SeekBar` do it automatically.

**And the exclusion has a ceiling:**

> the system will put a limit of **200dp on the vertical extent** of the exclusions it takes
> into account. The limit does not apply while the navigation bar is stickily hidden, nor to the
> input method and home activity.

The reference is equally clear about when *not* to use it: "It is not necessary for an app to
register exclusion rects for broadly spanning regions such as the entirety of a `ScrollView` or
for simple press and release click targets such as `Button`. Mark an exclusion rect when
interacting with a view requires a **precision touch gesture in a small area** in either the X
or Y dimension, such as an edge swipe or dragging a `SeekBar` thumb."

**Home and quick switch — not negotiable.** "Apps **can't opt out** of these gestures as they
can with the back gesture." The only mitigation is
`WindowInsets.getMandatorySystemGestureInsets()`, "which informs apps of the touch recognition
thresholds." Games without a view hierarchy can use `Window.setSystemGestureExclusionRects()` or
request immersive mode, "only when necessary, such as during gameplay."

**The design rule this produces**, and it is a design rule rather than an implementation note: a
horizontal swipe placed within a screen edge is competing with system back, and it can win only
inside a 200dp-tall band that the design has to nominate. A vertical swipe at the bottom of the
screen is competing with home, and it **cannot** win. Carousels, swipe-to-delete rows, sliders,
and drawing canvases are the four that keep colliding here, and the decision belongs in
`DIRECTION.md` next to the navigation model, not in the build.

---

## 4. Canonical layouts — the source that failed, retried and resolved

The tablet/desktop pass recorded `m3.material.io/foundations/layout/canonical-layouts/overview`
as `"quality":"unreliable","claimCount":0`. It resolves now, via a **rename**: that URL
redirects to `foundations/layout/canonical-examples/overview`, titled "Canonical layout
examples". Same pattern as *window size class* → *breakpoint*. There are three, each with
configurations for compact, medium, and expanded:

**Feed** — "arrange elements like cards in a configurable grid for a quick, convenient view of a
large amount of content." Android's guide adds the mechanics: "Size and position establish
relationships among the content elements. Content groups are created by making elements the same
size and positioning them together. Attention is drawn to elements by making them larger than
nearby elements." Adapts from a single scrolling column to a multi-column feed.

**List-detail** — "divides the window into two side-by-side panes: one for the list, one for the
detail." The state rules are the useful part, and they are a design decision most runs never
make explicitly:

> If an expanded-width display showing both the list and detail panes narrows to medium or
> compact, **the detail pane remains visible and the list pane is hidden.**
>
> If a medium- or compact-width display has just the detail pane visible and the window widens to
> expanded, the list and detail are shown together, **and the list indicates that the item
> corresponding to the content in the detail pane is selected.**
>
> If a medium- or compact-width display has just the list pane visible and widens to expanded, the
> list and a **placeholder detail pane** are shown together.

Also: on small windows showing only the detail, back returns to the list, and that back handler
"is not part of the overall app navigation since the handler is dependent on the window size
class and selected detail state."

**Supporting pane** — primary area "occupies the majority of the app window (typically about
two thirds)"; the secondary pane takes the remainder. On medium or compact it can hide in a
bottom or side sheet behind a control. The distinguishing test is stated explicitly and is the
reason this is a different layout rather than a narrower list-detail:

> **Secondary pane content is meaningful only in relation to the primary content**; for example,
> a supporting pane tool window is irrelevant by itself. The supplementary content in the detail
> pane of a list-detail layout, however, **is meaningful even without the primary content**, for
> example, the description of a product from a product listing.

Named use cases: list-detail for messaging, contacts, media browsers; feed for news and social;
supporting pane for document-plus-comments, video-plus-related, editor-plus-palettes.

---

## 5. Still open

- **Whether Apple publishes any per-device safe-area inset values anywhere.** Not found on the
  Layout page; not searched exhaustively. The runtime-read rule stands either way.
- **iOS screen-edge gesture conflicts** — Apple's equivalent of `setSystemGestureExclusionRects`
  (the `preferredScreenEdgesDeferringSystemGestures` family) was not read this pass. The Android
  half is verified; the iOS half is not, and a cross-platform gesture claim should not be made
  from one side.
- **Material's expanded navigation rail specifics** (widths, when it collapses) beyond the
  per-breakpoint recommendation already recorded.
