# Loop 3 — System

**Goal:** build the components the approved direction describes, in every state they owe, from
the tokens that were written for them — and find out which of those tokens were specified and
which were only asserted, while it still costs one line to fix.

**Input:** a signed Gate B. `DIRECTION.md` written to every row of `loops/02-craft.md` §5's
schema, `tokens.json` beside it, the approved comps, and the technique verdicts.

**Output:** `runs/<slug>/system/sheet.html` — one standalone, navigable component sheet — its
screenshots, the gap report of every value the sheet could not get from the handoff, those gaps
closed in `DIRECTION.md` and `tokens.json`, and a signed Gate C.

**Timing:** run `date` at each phase boundary into the run ledger, as both loops before this
one do.

```text
1 inventory ─► 2 state matrix ─► 3 build ─► 4 gap report ─► 5 write it down ─► Gate C
from the       per component,    one agent,  every invented   DIRECTION.md's      human
comps, not     n/a with a        from        value, named     system section,     signs the
a checklist    reason            tokens      and priced       tokens closed       set
```

---

## The fork

**Page-shaped** — read for seconds, once. The component set is small and the states that
matter are the ones a stranger hits on a first visit with no account: the primary action, the
one form, the failed submission, the 404. A page-shaped surface that ships fourteen components
has invented most of them. This class owes `CRAFT.md`'s three render states, crossed with the
two colour modes.

**Tool-shaped** — read for hours, daily, by the same person. The component set is large, it
repeats, and it is where the whole surface actually lives: the operator meets the same row, the
same field, and the same confirm dialog four hundred times. This class owes `TOOLS.md`'s nine
data states on every component that holds data, and `§15` binds **[HARD]**, which makes the
keyboard walk in §3 below a deliverable rather than a check.

Both classes run every step. The state matrix in §2 is where they diverge hardest, and it is
the step that decides how large this loop is.

---

## 1. Inventory the component set — from the comps, not from a checklist

**A component enters the set because an approved comp contains it.** Walk the comps surface by
surface and list what is actually on them. That is the whole derivation, and it is deliberately
not a list of the components an interface usually has: a checklist produces a modal nobody
asked for, a toast nothing fires, and four button variants where the design has two — which is
`§1`'s failure mode wearing a design system's clothes.

Run it in both directions, because both directions find something:

- **In the comps and not in the set** — the thing that got drawn once and never named. It is a
  component, and it needs its states like everything else.
- **In the set and not in any comp** — cut it. If it turns out to be needed during the build, it
  gets designed then, against a system that exists. A speculative component designed here is
  designed against nothing and it shows.

**Name each component for what it does in this direction, not for its category.** `STYLES.md`'s
cliché fence and `§3` both land here: a run that ships *card*, *modal*, *badge*, *chip* has
imported someone else's system and renamed nothing. The component that holds one item of the
primary content is whatever this concept made it — and the name is how the build step knows the
difference between the thing the design invented and the framework default it would otherwise
reach for.

**One line per component: what it is, which comps it appears on, and what `§3`'s reinvention
did to it.** That third clause is the receipt for the run's central claim, and Gate C reads it
against the sheet.

## 2. Build the state matrix

Every component × every state it owes. **Write the matrix before building anything**, because
the matrix is where the size of this loop is decided and where a state gets forgotten silently.

**The base set every interactive component owes**, from `loops/02-craft.md` §5's controls row:
default, hover, focus-visible, active, disabled, error, loading. Crossed with the two colour
modes, per `loops/01-direction.md` §5's rule that a foreground legal on the light swatch tells
you nothing about the dark one.

**A state that does not apply is written down as `n/a`, with its reason on the same line.**
Never omitted. *"loading — n/a, this control resolves locally and never waits"* is a decision
anybody can check; a blank cell is indistinguishable from an oversight, which is the same
argument `BREAKING.md` makes about an unrecorded break, one artifact down.

Four crossings are not optional and each of them catches something a flat list does not:

- **Touch has no hover.** Every affordance whose only signal is a hover state does not exist
  for a phone user. The matrix names the touch equivalent per component or states that the
  component is pointer-only and why.
- **`focus-visible` is not one render.** The ring has to be legible on every background it can
  land on, and `ACCESS.md`'s focus decisions from Loop 1 already named those backgrounds.
  A ring rendered once, on the substrate, is a ring that was never tested against the accent
  fill it will sit on.
- **Error is a component state and a content state.** The field in its error styling, and the
  message that goes with it, at a realistic length rather than at "Error".
- **Tool-shaped: `TOOLS.md`'s nine data states, on every component that holds data.** They
  cross with the seven above rather than concatenating — a table in its empty state still has a
  focus ring, and the empty state's primary action still has all seven of its own.

### What gets rendered, and what stays a token row

The matrix multiplies fast enough to swallow the loop, so the rule that bounds it is a real
one rather than a quota:

> **Render what a token cannot express. Leave the rest as a row.**

A disabled variant that is the default at a stated opacity is a token row — the value says
everything the render would. A focus ring that must clear 3:1 against five different fills is
five renders, because the thing being checked is a relationship between two colours and no
single token holds it. A hover that changes only a background token is a row; a hover that
moves something is a render.

Every row that stays a row still carries its value. **A state is never dropped, only rendered
or written**, and the sheet shows which of the two happened so nobody later reads a row as a
missing render.

## 3. Dispatch `system-builder`

**One agent, one sheet.** It writes `runs/<slug>/system/sheet.html` — standalone, vendored per
`§7`, faces self-hosted from the run's own font directory, no CDN — holding every component
from §1 in every state from §2, in both colour modes, walkable by keyboard.

**The sheet is built from `tokens.json` and `DIRECTION.md`. Nothing else.** That constraint is
the entire reason this loop exists, so it is stated as a rule rather than as a preference:

> **The test.** `loops/02-craft.md` §5 asks whether a build agent could execute the handoff
> without making a single aesthetic decision. Here that question stops being rhetorical and
> gets *run*. Every value the builder cannot find in the handoff is a hole in it — found now,
> by an agent whose job is to report it, at the cost of one line. Found later, it is filled
> silently by whoever is writing the component that day, and nobody ever learns a decision was
> made.

So the builder does not improvise. Where a value is missing it uses a visibly wrong stand-in,
logs it, and moves on — the sheet is allowed to look broken in the exact places the handoff is
broken, and that is the sheet doing its job. **A builder that quietly picks a sensible value
has destroyed the finding**, and a sensible value is the easiest thing in the world to pick.

**Interactivity is by construction, not by script.** Hover, focus-visible, and active are CSS
states on real elements; the mode toggle flips a class. What the sheet does not do is implement
behaviour — no routing, no data, no form that submits. `§10`'s reduced-motion state ships on the
sheet beside the motion it reduces, because a reduced state nobody has looked at is the state
`loops/02-craft.md` §3 says is most often faked.

**Screenshot every state, both modes**, per `§12`: it builds is not it renders, and the sheet is
the one artifact in this pipeline where that distinction is cheap to check and expensive to miss.

**Walk it by keyboard and record the walk** — tab order, what the ring looks like at each stop,
where focus goes when a state opens and where it returns to. On a tool-shaped surface `§15` is
**[HARD]** and this walk is the deliverable that satisfies it; page-shaped, it is `§10`'s
reachability, and it still gets walked.

**The file on disk is the record.** Where the harness can publish the sheet as a shareable page,
publish it — a human reviewing a rendered sheet is the point of Gate C. But this repo's first
real run built its Gate A package as an external artifact and committed nothing, which is why
that run has zero comps in it. A published copy is a convenience. `runs/<slug>/system/` is the
deliverable.

## 4. The gap report

Everything the builder had to invent, in one list, with what it would have cost to leave.

**This is the most valuable thing Loop 3 produces**, and it will not read like it — it is a
short list of small values: a hairline weight in dark mode, the disabled foreground, the gap
between an icon and its label, the error message's line-height, what the focus ring does on the
accent fill. Each one is a decision the direction was supposed to have made, and each one would
otherwise have been made forty minutes into a build by whoever hit it first.

Sort it by what the gap decides, not by what it is:

| Gap | What fills it if nobody does | Where it goes back to |
|---|---|---|
| A value the schema has a row for | The build step's default | `DIRECTION.md`, that row |
| A value with no row anywhere | Whatever the first component to need it picked | `DIRECTION.md`, plus a new row, plus `tokens.json` |
| A relationship, not a value — a ring on a fill, a hairline on a gradient | Nothing. It renders wrong and passes review | `DIRECTION.md`, as a pair with its measured ratio |
| A state the matrix marked `n/a` that turned out to apply | The component ships without it | §2's matrix, corrected, then rebuilt |

**Close the gaps, then rebuild the sheet.** A gap report presented alongside a sheet that still
has the stand-ins in it is a to-do list; a gap report presented alongside a rebuilt sheet is a
record of what this loop caught. Gate C reads both — the list of what was missing, and the sheet
with nothing missing.

## 5. Write it down

The system section of `DIRECTION.md`, which is where the sheet stops being a file somebody has
to open:

- **The component set from §1**, each with its one line, its comps, and its reinvention clause
- **The state matrix from §2**, complete, with every `n/a` carrying its reason
- **Every gap from §4 and the value that closed it** — kept, not summarised. A gap list that
  gets deleted once it is fixed loses the only evidence of where this handoff was thin, and the
  next run of this loop has nothing to be sharper about
- **The keyboard walk** — order, ring, focus movement, return
- **The touch statement** — every pointer-only affordance, named, with what a phone user gets
  instead

Then `tokens.json`: every value the sheet uses, in it, aliased rather than repeated. **The sheet
and the token file agree by construction or the sheet was not built from the tokens** — and if
they have drifted, the sheet is wrong, because the token file is what the build step reads.

---

> ## Gate C — human decision. `§16` **[HARD]**
>
> **Presented:**
>
> - **The sheet**, rendered and navigable, both colour modes, with the screenshots for anything
>   the reviewer cannot open live
> - **The component set**, each with what `§3`'s reinvention did to it — the run's central claim,
>   in a form somebody can disagree with
> - **The state matrix**, complete, every `n/a` with its reason
> - **The gap report** from §4, and the values that closed each gap
> - **The focus ring on every background it lands on**, with the measured ratio per background
> - **The keyboard walk**, and on a tool-shaped surface the primary workflow completed by
>   keyboard alone, since `§15` is **[HARD]** there
> - **The touch statement** — what a phone user gets where the design used hover
> - **What was rendered and what stayed a token row**, per §2, so a row is never read as a
>   missing render
>
> **The anti-shortcut clause.** The written output is the OUTPUT of this review, not a
> substitute for it. This is the last gate before code, and the sheet is the last artifact
> anybody looks at before the components exist for real. A gate that becomes a document somebody
> reads later has been removed rather than satisfied.
>
> **They approve the set, send components back, or cut them.** Cutting is a real outcome here
> and usually a good one: a component nobody could say what it was for is a component the build
> would have had to support forever.
>
> **Deferrals get priced, in a table:**
>
> | decision needed | if deferred, what happens |
> |---|---|
> | The sheet not built | The handoff's completeness stays a claim. Every hole in it is found during the build, one at a time, by whoever hits it |
> | Gap report not kept after the gaps are closed | The record of where this handoff was thin is deleted, and the next run rediscovers the same holes |
> | Focus ring rendered once instead of per background | It is legible on the substrate and invisible on the accent fill, which is the fill the primary action uses |
> | Touch equivalents left unstated | Every hover-only affordance ships as nothing at all on a phone, and it renders correctly the whole time |
> | Dark mode states left to invert | Half the states are wrong in the mode a tool-shaped audience mostly lives in |
> | Empty and error states left to the framework | The two screens every new user and every unlucky user sees are the two the design never touched |
>
> **Then append to the ledger, before the gate closes.** Every deferral, cut component, and
> unclosed gap goes to `runs/<slug>/SKIPS.md` with its cost and the date, below Gate B's rows.
> This is the last gate, so that file is what the build inherits as the honest account of what
> the design does not cover. **A gate that closed without appending has recorded silence, and
> `§16` says silence is not a skip.**

---

## When Gate C rejects

**Three destinations, and they are not interchangeable.**

| What was rejected | Where it goes back to |
|---|---|
| **A component's execution** — the states are right, this one is drawn wrong | Rebuild that component on the sheet. Nothing else moves |
| **The system** — the spacing does not hold at component scale, the ramp has no step where one is needed, the type roles do not cover the set | Back to `loops/02-craft.md` §5 and §6. The values are wrong, and every component is built on them |
| **The direction** — the components are correct and the human does not want them | A Gate A finding arriving two gates late. Send it back to Loop 1 rather than restyling components until the direction accidentally changes |

The middle row is the one this loop exists to surface, and it is the one that looks like the
first row from the outside. **When several unrelated components are all slightly wrong in the
same way, it is the system, not the components.**

**Three rejections at this gate means the translation table is wrong, not the work** — the same
rule as Gate A and Gate B, and the same remedy.

## Skip costs

| Skipping | Costs |
|---|---|
| §1's inventory from the comps | A component set imported from a framework, with four button variants for a design that has two |
| §2's matrix | The states nobody thought of — touch with no hover, the ring on the accent fill, the empty state — discovered by users |
| §2's `n/a` reasons | The difference between a state that does not apply and one nobody considered, permanently |
| §3's sheet | The handoff's completeness stays an assertion. `loops/02-craft.md` §5's test is never actually run |
| §3's keyboard walk | On a tool-shaped surface, `§15` — which is **[HARD]** and does not have a skip row |
| §4's gap report | The finding. The gaps still get filled, silently, by the build step |
| Gate C | The last human look at the thing the build will copy a hundred times |
| The close in [`IMPROVE.md`](../IMPROVE.md) | The run's findings about the plugin, which is the only way any of this gets less wrong next time |

## Then close the run

Gate C is the last design decision. [`IMPROVE.md`](../IMPROVE.md) is what happens after it: read
`RUN-NOTES.md` back into findings about the plugin, then ask the human — once, with the payload
shown in full and the default set to no — whether any of it should go back to PIIIX, and
separately whether they want a screenshot in the gallery. Both answers are theirs and either can
be no.

The handoff itself is unchanged and is still the point: `DIRECTION.md`, `tokens.json`, the
comps, the board, the prototypes, and now the sheet, going to whoever builds it.

