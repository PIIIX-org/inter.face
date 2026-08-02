# Tools

Designing for the operator's day.

`STYLES.md` is what an interface looks like; `CRAFT.md` is how you render it. This file is
what it must **do** when it is used for hours, every day, by the same person — the one
place in the plugin where **tool-shaped** is not a fork, it is the whole subject.

Read row 1 of `TRANSLATE.md` first. If it reads **page-shaped** — read for seconds, once —
this file has nothing to add past what `STYLES.md` and `CRAFT.md` already carry: stop here.
If it reads **tool-shaped** — read for hours, daily — everything below is for you, and it
is the only file in the plugin that is.

`§11` buys the budget; `§15` spends it here. A system's interface is used for hours, not
seconds, which inverts nearly every rule a marketing site follows: density is a feature,
keyboard beats pointer, and delight is measured in keystrokes removed rather than in
animation.

The generic admin template is the failure mode. An operator can tell inside a minute
whether anyone thought about their job.

---

## 1. Design the day, not the screen

Before any screen, write the operator's day as a sequence with counts:

> Opens the queue at 08:00. 40 new jobs. Assigns each to a technician — reads the
> address, checks who is nearest, drags or types a name. Two minutes each, interrupted
> constantly by the phone. At 11:00, three jobs come back rejected and have to be
> re-scheduled. At 16:30 she runs the day's completion report and emails it.

That paragraph decides everything. Assignment happens 40 times, so it gets the design
attention and it does not open a modal. The report happens once, so it can be plain.
"Interrupted constantly" means the screen must survive being left and returned to, which
means state in the URL and no unsaved work in a modal.

Do this per role. Three days written out are worth more than twenty wireframes.

### The three questions to ask the operator

At Gate A, and again at Gate B:

1. What do you do most often?
2. What takes the longest and shouldn't?
3. What do you do when it goes wrong?

The third finds the states nobody designs (below).

## 2. Density is a feature

An operator wants to see forty rows, not six cards with generous whitespace. A marketing
site's spacing scale applied to an operations table is actively hostile: it turns one
screen of work into six scrolls.

- Tight, consistent row heights with a comfortable option for people who need it
- Real tables for tabular data — semantic, sortable, with sticky headers
- Numbers right-aligned and tabular-figure aligned so columns compare at a glance
- Truncation with the full value available, never a layout that reflows on content
- Column choice belongs to the operator: which columns, what width, what order,
  remembered

Density is not clutter. Clutter is undifferentiated density — everything the same
weight. Hierarchy is what makes forty rows readable.

## 3. Keyboard completeness (`§15`, hard)

Every primary workflow completable by keyboard alone. Not as an accessibility checkbox —
though it is that — but because the person who has done this job for eleven years types
faster than any pointer.

- Tab order follows the visual order, and focus is always visible
- The primary action of a form is `Enter`; the escape from anything is `Escape`
- A command palette or a "go to" shortcut once the system has more than a handful of
  screens
- Shortcuts for the top three actions of each screen, discoverable rather than secret —
  a `?` overlay, and hints on the buttons themselves
- Search focusable with one key from anywhere
- In a table: arrow keys move, `Enter` opens, `Space` selects, `Shift` extends
- Never trap focus except in a modal, and a modal always returns focus where it came
  from

Watch a fast operator use the old system. If they are using keyboard shortcuts there and
your version does not have them, you have made their day slower and no feature list will
compensate.

## 4. The nine states

Every view, every time. Designed, not defaulted.

| State | What it must do | The failure |
|---|---|---|
| **Empty** | Teach what this is and offer the first action | "No records found" on a brand-new system, so nobody knows what to do |
| **Loading** | Preserve layout. Skeletons over spinners on anything structured | Content jumping when it arrives |
| **Partial** | Show what loaded, name what did not | One failing widget blanking the page |
| **Error** | What happened, whether their work was saved, what to do next | "Something went wrong" |
| **Permission denied** | A designed state explaining who can do this, not a crash | Looks like a bug, generates a ticket every time |
| **Offline / degraded** | Say what still works, queue what can be queued | Silent failures that look like success |
| **Stale** | Say when data was fetched, offer refresh | Somebody acting on a number from twenty minutes ago |
| **Conflict** | Somebody else changed this. Show both, let the human choose | **Silently overwriting somebody's work**, which they will never know about |
| **Bulk** | Progress, partial success, and what failed and why | "12 of 400 failed" with no list |

The empty state is the first thing every user sees on a new system and it is the most
neglected. The conflict state is the one that destroys work.

### Desktop window states

A different axis from the nine above — those answer what the data is doing; this answers
what the window is doing, and it only exists on a desktop-shaped surface. A web page has
no concept of being visible but not focused, with a different chrome treatment; a desktop
window does, and a desktop-shaped tool is designed against three of them, not one:

| State | What it must do | The failure |
|---|---|---|
| **Main** | Distinct from Key. Controls render in color only when this window is also Key — the common case. When Main but not Key, controls gray, the same rendering as Inactive | Assuming Main alone means colored, "live" chrome — a document window that stays Main while a floating inspector or Find panel holds Key still renders gray, and coloring every Main window regardless of Key ships backwards from what macOS actually shows |
| **Key** | Receives keyboard input right now. Window controls (close, minimize, zoom) render in color; a window becomes key only when someone clicks its title bar or a component that requires keyboard input | A custom title bar that never changes, so an operator with several windows open cannot tell which one their next keystroke lands in |
| **Inactive** | Window chrome — including those same controls — grays out, signaling "not receiving input" without hiding content | Content that dims or disables along with the chrome, so a background window an operator is monitoring goes unreadable |

If the window is custom-chromed rather than system-default, these three states have to be
hand-implemented — the system does not update a custom title bar's appearance for you.
Window controls sit at the leading edge of the toolbar, and critical information or
actions never sit where that chrome can cover them.

## 5. Forms

Where an operator spends most of the day.

- **Label above the field.** Always visible, never placeholder-only
- Group by the mental model of the task, not by the table's columns
- Sensible defaults, and remember the last value where the same value repeats
- Required marked, and optional marked too when most fields are required
- Validate on blur, not per keystroke. Errors next to the field, in words, announced
- **Never lose what they typed.** Not on validation error, not on session expiry, not on
  a failed save. This is the fastest way to lose an operator's trust and it is
  unforgivable when their input took four minutes
- Autosave on long forms, with visible state, or a warning before leaving
- `Enter` submits; the primary button says what it does — "Create order", not "Save"
- Inline creation for the referenced thing that does not exist yet. Making someone
  abandon a form to create a customer, then start again, is a design failure that costs
  minutes forty times a day
- Big number entry gets the right keyboard and the right input mode on mobile
- Duplicate detection before submission where duplicates matter, not a unique-constraint
  error afterward

## 6. Tables and lists

- Filter, sort, and search state **in the URL**, so it can be bookmarked, shared with a
  colleague, and survives a reload — this is the single highest-value detail in an
  operations interface
- Pagination that survives inserts (cursor-based) on anything long
- Row actions reachable without a hover-only menu; hover-only is unusable by touch and
  by keyboard
- Bulk selection with a real count, a select-all-matching option distinct from
  select-all-on-page, and a confirmation that names what will happen to how many
- Saved views per operator for the filters they use every day
- Export from the current filtered view, not the whole table, and say which it is
- Empty-after-filter is a different state from empty-overall, with a different message
  and a clear-filters action

## 7. Navigation and information architecture

- Structured by the operator's tasks, not by the database schema. "Today's jobs" is a
  navigation item; `job_assignments` is not
- The five most-used destinations reachable in one action from anywhere
- Current location always obvious, and deep pages breadcrumbed
- Search that spans entities and understands identifiers — pasting an order number
  should find the order
- Role-shaped navigation: an operator does not see admin sections they cannot use, and
  hiding is in addition to the server-side check, never instead of it

**The trunk test**, from gstack's design-review: cover everything but the navigation
chrome and look at what's left. Can you still answer what site or system this is, what
page you're on, what sections exist, and where you are inside them? If blocking out the
nav erases the answer, the content and hierarchy were leaning on the chrome to do work
they should be doing themselves — and a tool-shaped surface pays for that gap every day,
not once, the way a page-shaped visitor who bounces after one confused look does not.

## 8. Feedback, confirmation, and undo

- Every action produces visible feedback within 100ms, even if only optimistic
- **Undo beats confirm.** A confirmation dialog is trained away in a week and clicked
  through; an undo works even after the mistake. Use undo for anything reversible
- Confirm only what cannot be undone, and make the dialog state the consequence
  specifically: "Delete 34 orders. This cannot be undone."
- Destructive actions are visually distinct and never the default focus
- Long operations run in the background with progress and a notification, not a frozen
  screen

## 9. The system's words

Labels, statuses, empty states, confirmations, and errors are deliberate copy in the
operator's vocabulary, using the operator's own nouns for their own concepts.

Errors especially. In a system the operator cannot go elsewhere; they file a ticket and
wait. Say what happened, whether their work was saved, and what to do next:

> **Couldn't save this order.** The customer's credit limit was reduced while you were
> editing. Your changes are still here — reduce the total to £4,200 or ask a manager to
> override.

No "Something went wrong". No exclamation marks in a status column. No cheerful copy in
front of a failed payment.

## 10. Mobile and field use

If any role works away from a desk, that is a different design, not a narrower one.

- Large touch targets, thumb-reachable primary actions, and no hover dependency
- Works in sunlight: contrast well above the minimum
- Works with gloves, in a warehouse, on a five-year-old Android with two bars
- Offline behavior explicit if it was decided at Gate B: what queues, what does not,
  what the conflict state is
- Camera, scanner, and signature where the work uses them
- Never require a desktop step in the middle of a field workflow

## 11. Performance as felt (`§11`)

The number that matters is the operator's task time, not the endpoint's p95.

- Optimistic UI for anything that almost always succeeds, with a real reconcile on
  failure
- Perceived speed: instant feedback, skeletons that match the final layout, prefetch on
  intent
- Test every list view against realistic volume. The table with 40 rows in development
  has 4 million in production, and the list view that was fast on seed data is the most
  common performance surprise there is
- No layout shift after load. An operator clicking where a button was is a real error
  with real consequences

## 12. The design system

Small and strict. Tokens for color, space, type, radius, and motion; one component per
job; every component with all its states designed — default, hover, focus-visible,
active, disabled, error, and loading.

Two things a system needs that a marketing site does not: a **status vocabulary** (a
fixed set of statuses with fixed colors *and* shapes or labels, never color alone
(`§10`)), and a **data display set** — currency, quantity, date, relative time, person,
identifier — each formatted one way everywhere, from one component.

None of this prescribes a look. "Small and strict" constrains the token set, not the
style — `STYLES.md`'s picking procedure applies here exactly as it does page-shaped, and
a tool-shaped surface earns a deliberate style the same as any other: chosen at Gate A,
checked against style-under-density before it is trusted with forty rows. The plainest
possible system is a choice like every other in `STYLES.md`, not the default a tool is
owed — the generic admin template is what happens when nobody makes it.

Dark mode is worth it for anyone working long hours or at night. Design it, do not
invert it.

## 13. The deliverable

For a tool-shaped surface, `DIRECTION.md` carries these nine things in addition to
whatever `loops/02-craft.md` already requires it to hit at rendered-style resolution,
decided across Gate A and Gate B:

1. **The day, per role** — the sequences with counts
2. **The screen inventory** and which task each serves
3. **Key flows** — designed, with all nine states per screen
4. **Keyboard map** — shortcuts per screen and the global ones
5. **The design system** — tokens, components, status vocabulary, data formats
6. **Density decisions** — row heights, table defaults, what is configurable
7. **Mobile and field** design if applicable
8. **Copy** — labels, statuses, empty states, error messages
9. **Accessibility notes** — focus order, announcements, anything unusual

## Skip cost

Skipping this — designing the operator's day rather than the screen — still produces a
working system with a generic admin interface. It passes every test, and the operator is
slower than they were with the spreadsheet. That is the most common way a technically
successful system fails, and it is discovered after go-live when the sunk cost makes it
hardest to fix.
