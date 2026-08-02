# Breaking

`§1` says the obvious answer is the failure mode. `§2` makes out-of-the-box the floor. `§3`
says ship a named style unmodified and the run failed. Then the rest of this plugin is a
rulebook: platform tables with published numbers, contrast floors, a keyboard path, a cliché
fence, two budget tiers, nine states.

Both halves are right, and they collide on every surface worth designing. A pipeline that
says *be bold* and then hands over a rulebook without saying which rules bend has not
resolved that; it has moved the decision somewhere unrecorded, where it gets made at build
time by whoever is least accountable, silently. This file is where it gets made instead.

**This is authored, not sourced.** Nobody publishes "when to violate design conventions" as a
primary source. Platform vendors publish their own guidelines and their own reasons; the
usability literature argues for consistency; neither writes the inverse, because neither has
a reason to. So this file carries almost no citations — there are almost none to carry. Its
authority is the rules it reasons about, and those are in `PRINCIPLES.md` where anybody can
check them.

Read row 1 of `TRANSLATE.md` before anything below. The economics of a break invert on it.

On a **page-shaped** surface — read for seconds, once — the cost is paid once, by a stranger,
with no second exposure to learn from. There is no amortization term at all, which means a
break that has to be *learned* is simply not available here: the viewer leaves before the
learning happens. What is available is a break that lands instantly or not at all.
Distinctiveness is worth more on this surface than anywhere else, and learnability is worth
less — but only because nothing here can demand learning in the first place.

On a **tool-shaped** surface — read for hours, daily — the same person pays the cost and
collects the gain, every day. That is the only place a learning curve is an investment rather
than a tax: a control that removes two seconds from an action performed forty times a day
repays a day of confusion inside a week and keeps paying for years. The same arithmetic runs
the other way and is the reason the never-breakable list below matters most here. A bad break
is also absorbed daily, by the same person, who did not choose this interface and cannot
leave it.

---

## The shape of a break

Every entry below has the same five fields, and so does every break not listed here:

1. **What the rule is** — named, by its number where it has one.
2. **What breaking it buys** — the specific gain, not "it's more interesting."
3. **What it costs** — who pays, in what units.
4. **The conditions that make the trade honest** — the test, stated so it can fail.
5. **How to record it** — the row in `DIRECTION.md`.

Field 3 is the one that does the work. **If you cannot write the cost line, you have not
found a break — you have found a preference you have not examined yet.** Every real rule in
this plugin is there because something goes wrong without it, and if you cannot say what that
is, you do not yet know enough about the rule to be breaking it.

## Platform convention

**What it is.** The platform's published pattern and everything that rides on it: a native
navigation model, a system control, a standard gesture, the OS's own back behavior. On the
web, the conventions that behave like a platform — a link that looks like a link, a form that
submits on `Enter`, a browser back button that goes back.

**What breaking it buys.** Distinctiveness at the level people actually remember. Navigation
and controls are what a surface is recognized by, and a native nav is the most recognizable
thing about ten thousand other surfaces. Second, and less often argued: fit. A platform
control is designed for the general case, and the general case is sometimes genuinely wrong
for the specific job in front of you.

**What it costs.** Everything the platform gave you free, and the list is longer than it
looks. Learnability first — a native control is understood before it is examined. Then the
accessibility contract: the native control ships a role, an accessible name, state, keyboard
behavior, and assistive-technology support at no cost, and a custom one ships none of that
until you build it. `§10` is **[HARD]** and does not bend to make room for a custom control,
so that work is not optional, it is only *unbudgeted*. Then platform updates, which the native
control inherits and yours does not. Then input breadth — touch, pointer, keyboard, voice
control, switch access, trackpad gestures — each of which the native control already handles.
Then every habit the user built in every other application.

**When the trade is honest.**

- **The audience uses this daily and the gain compounds.** Two seconds × forty times a day is
  the trade, and it is a real one. A one-visit surface has no compounding term at all, so the
  identical break there is pure cost with the gain removed.
- **You can name what the native control cannot express.** Not "it looks generic" — that is a
  styling problem with a styling answer, and the styling answer keeps every affordance.
- **The budget exists to rebuild the whole behavior set**, not the visual layer: role, name,
  state, keyboard, focus management, and the reduced-motion and high-contrast variants.
  `ACCESS.md` is where that list lives, and it is decided at Loop 1, before the custom control
  is expensive to abandon. If the budget is not there, the honest move is to keep the native
  control and spend the distinctiveness somewhere that does not cost an affordance.

**When it is not.** A one-visit surface. A rebuild that stops at appearance. And the specific
self-deception of a custom control that is *nearly* the native one — near-misses are the worst
of both, since they inherit none of the affordances and still trigger every existing habit.

**How to record it.** Name the control, the native pattern it replaces, the compounding gain
in the operator's own units, and the affordance list you rebuilt by hand. If that list is not
written down, `§10` and `§15` have nothing to check.

## The category cliché fence

**What it is.** `STYLES.md` treats the category's expected look as a fence rather than a
field — the gradient B2B hero, the padlock-and-blue fintech page, the dark terminal for a
developer tool. The fence rule is that none of them is available unmodified.

But sometimes the cliché is load-bearing. A padlock on a bank is a cliché because it works:
it is the fastest available signal for something the viewer genuinely needs signaled, and
every alternative is slower. The convention is doing a job, and the job does not stop being
real because the form is tired.

**What breaking the fence buys.** Comprehension speed, in the one place where being understood
beats being distinctive — the moment somebody decides whether to hand over money, data, or
trust. That decision is made faster than a novel signal can be decoded.

**What it costs.** Exactly the position `§1` and `§2` exist to protect. Every element spent on
the expected form is an element not spent on being memorable. Worse, clichés cluster: a
surface that reaches for one has usually reached for four by the end of the page, and each one
makes the next feel normal.

**When the trade is honest.** This is where the real distinction sits, and it is not about the
output. **Breaking the fence means using the expected form deliberately, and that is a
different act from reaching for it reflexively.** The rendered result can be identical. The
difference is whether anybody can say why.

The test that separates the two acts: *can you state what the expected form buys, in this
exact place, that the alternatives do not?* If the answer is "it is what people expect," with
no mechanism named, that is the reflex. Beyond that:

- The convention carries meaning at a speed nothing else matches — a trust mark, a safety
  signal, a legal requirement, a payment method's own logo.
- It appears **once**, at the moment it is needed, and is not treated as an aesthetic.
- The surface holds its position everywhere else. A deliberate cliché inside an otherwise
  unmistakable surface reads as a decision; the same cliché inside a generic surface is
  invisible, and correctly so.

**And row 5 outranks this entirely.** If the cliché is the thing `TRANSLATE.md` row 5 named as
what this must not look like, the fence is not breakable — see the never-breakable list below.

**How to record it.** Record which act it was. "Padlock, used once, at the card form, because
the trust signal has to land in under a second and every alternative we tested took longer" is
a decision. Silence is a reflex, and it reads as one to everybody who sees the surface.

## Density norms

**What it is.** Page-shaped surfaces are spacious — whitespace is the luxury. Tool-shaped
surfaces are dense — rows per screen is the luxury. `TRANSLATE.md` row 2 sets the call and
`STYLES.md`'s style-under-density section asks whether the chosen family can survive it.

**What breaking it buys.** A page that goes dense signals it has something to say and is not
padding it, which for a reader who came to compare is the strongest possible signal. A tool
that goes spacious slows the operator down deliberately, which is the right move when slowing
down is the job.

**What it costs.** Density on a page costs the scanner, and the scanner is most of the
traffic; it also collapses hardest at the narrowest viewport, where the same information
becomes a wall. Space in a tool costs scrolls, and a scroll on a screen somebody opens two
hundred times a day is a measurable tax on a real person's day.

**When the trade is honest.** When the content genuinely inverts the usual read pattern, and
you can name the pattern and count something:

- **Page-shaped going dense** — the audience is technical and came to compare. A spec table, a
  changelog, a pricing matrix with real numbers, documentation serving as the marketing site.
  These readers came to read, and thinning the information insults them.
- **Tool-shaped going spacious** — the task is low-volume and high-stakes. An approval that
  happens six times a day and cannot be undone, a clinical entry, a financial confirmation.
  Rows per screen is the wrong luxury when the operator should be slowing down, and `TOOLS.md`
  will tell you the volume because the operator's day was written out with counts.

**When it is not.** When density substitutes for editing — a dense page is not automatically a
substantive one; it can be the same padding at a smaller size. And when spacious is a way to
avoid designing the density problem at all, which is the failure `STYLES.md` asks about at
Gate A precisely so that a family incapable of holding forty rows is caught before the images
are signed off rather than during the build.

**How to record it.** The count that forced it, at the target viewport — "this audience
compares three products across nine dimensions and the comparison has to be on one screen" is
an inversion; "it feels more premium" is not. Plus the fallback at the narrowest viewport
where the count stops fitting, because that is where an inverted density actually fails.

## A style's own guardrails

**What it is.** `§3`, and `STYLES.md`'s guardrails restating it: *ship a named style
unmodified and the run failed*. Every run states what it did to the style that nobody else
does.

**What breaking it buys.** There is exactly one case, and it is narrow. When the collision
**is** the near-pure style, placed where it does not belong. A style left unmodified in itself
but structurally alien to its context is not the catalog reflex — the invention has moved from
the surface level to the placement level. A terminal that is exactly a terminal, framed by an
editorial shell that treats it as a plate with a caption and a running head. Nothing was done
to the terminal. Everything was done to where it sits.

**What it costs.** It is indistinguishable from the failure it resembles. A run that ships a
pure style deliberately looks precisely like a run that reached for the catalog and stopped,
and nobody downstream can tell from the artifact. That cost is paid whether or not the intent
was real. Purity is also a one-shot move: two unmodified styles on one surface and neither
reads as a decision, they read as a moodboard.

**When the trade is honest.**

- The purity is doing a job the modified version cannot — usually a fidelity claim that a
  subversion would undercut. A terminal that has to *actually* be a terminal.
- It appears in one region, once, and is not the surface's whole treatment.
- The invention is stated at the level where it actually lives: the placement, the framing,
  or the collision, in one sentence a stranger can check the built surface against.

**When it is not.** When purity is what got shipped and the rationale was written afterward.
The tell is reliable: a retroactive sentence describes the *style* ("a clean, authentic
terminal aesthetic") where a real one describes the *decision* ("the terminal is unmodified
because the editorial frame around it is the whole move, and subverting both leaves neither
legible").

**How to record it.** `§3` already requires the "what this run did that nobody else does"
line. Here it names a placement rather than a modification, and it says out loud that the
style is near-pure — because a reviewer who has not been told is obligated to read it as a
`§3` failure, and should.

## The two-tier performance budget

**What it is.** `§11`. The shell — HTML, CSS, fonts, critical JS — stays under 100KB and paints
something real on its own, with LCP under 1.5s. The heavy layer lazy-loads after first paint,
declares its budget at Gate B, and never sits in the LCP path.

**What breaking it buys.** One thing, and it has to be named exactly: proving capability, when
the surface's entire job is proving capability. A studio whose work is real-time graphics, a
GPU product, a 3D tool, a physics engine. For those, the heavy hero *is* the demonstration, and
a fast shell showing a screenshot of the thing is a slower route to the same claim.

**What it costs.** The visitors on the wrong device, who are not a rounding error: a
five-year-old Android, a throttled connection, a locked-down corporate laptop, a WebGL context
that is lost and never restored. `§10` requires the no-WebGL fallback regardless, so the cost
is not that they see nothing — it is that they see the fallback, which is the ordinary version
of a surface whose entire argument was that it is not ordinary.

**When the trade is honest.**

- The capability being proven is the actual product. "We are a modern team" is not a
  capability.
- The break is **a stated number, decided in advance** — "the hero is 2.4MB and LCP is 3.1s on
  the target device" is a decision. An unmeasured heavy hero is not a break at all; it is
  negligence with the same footprint, and `§11` exists to make the difference visible.
- The heavy path was prototyped and measured before the design committed to it. `CRAFT.md`'s
  prototyping step returns ship / cut / ship-with-caveat for exactly this reason, and failing
  cheap there is the point.
- The fallback is art-directed and somebody has looked at it (`§12`). For a meaningful share of
  the audience, the fallback *is* the experience.

**When it is not.** On a tool-shaped surface, effectively never. The operator opens it thirty
times a day, and a heavy hero is thirty daily payments toward somebody else's demo. Tools prove
capability by being fast.

**How to record it.** Both numbers — the budget `§11` sets and the number actually shipped —
plus the device the measurement was taken on, and the fallback's own screenshot. One number is
a claim. Two numbers and a device is a trade.

## The one break that arrives with the ask

`TRANSLATE.md`'s escape hatch: if row 6 names a design system the subject must conform to —
GOV.UK, Material, a corporate DS — invention is the wrong answer and `§1`–`§3` are suspended
wholesale. That is the largest break in this plugin, and it is the only one the designer does
not choose; it comes attached to the ask.

Record it anyway, with the same fields. The cost line is real and specific: **this run will not
produce a distinctive interface, it will produce a correct one**, and conformance is a
different deliverable with a different definition of done. Writing that down is what stops a
later reader from grading a conformant surface against `§1` and calling the pipeline broken.

## What is never breakable

Four, and one line each on why.

- **`§10` — accessibility. [HARD]** Breaking it removes somebody's ability to use the surface
  at all, and removes it from the person least able to route around you.
- **`§15` — keyboard completeness on tool-shaped surfaces. [HARD there]** The person doing this
  job eight hours a day is faster than any pointer and did not choose this interface; a
  workflow that drops into the mouse partway through takes time from them every single day.
- **`§16` — the human gates. [HARD]** They are the only place a human can say no. Breaking a
  gate does not trade quality for boldness — it removes the mechanism by which every other
  trade on this page gets consented to, including the ones above it.
- **`TRANSLATE.md` row 5 — anti-positioning.** The one row with no ordinary escape. It is the
  subject's own statement of what this must not be, and overriding it substitutes the
  designer's taste for the client's stated position on the single axis where they were most
  explicit.

**The reason they are together, stated once.** Every break in this file transfers a cost onto
somebody. These four transfer it onto somebody who did not consent. A designer who breaks a
platform convention absorbs the risk personally — the run is theirs, it goes through a gate,
and if it fails it fails visibly to the person who approved it. The user who cannot operate a
control they cannot see, the operator who loses two hours a week, the human whose stop was
written past, the client whose one stated refusal was ignored: none of them were at the table.
That is not a more severe aesthetic risk. It is a different category, and the line is consent,
not magnitude.

**The corollary, because the list gets misread as a ceiling.** None of the four prevents a bold
surface. They prevent a bold surface that is inaccessible, unusable by keyboard, unreviewed, or
in violation of the one thing the subject explicitly refused — a much smaller set than it
sounds. Most of the breaks on this page are compatible with all four. "Accessibility would kill
this idea" is usually an untested assumption, and `ACCESS.md` runs at Loop 1 specifically so it
can be tested while the idea is still cheap to change.

## The recording rule

**A broken rule that is not written down is indistinguishable from a mistake.** Not similar to
— indistinguishable, in the strict sense: no property of the artifact separates them. A
reviewer sees a surface that violates a rule. Whether the violation was reasoned is not
recoverable from the pixels, and asking later gets you a rationalization, because by then that
is the only kind of answer available.

So every break gets one row in `DIRECTION.md`:

| rule broken | what it buys | what it costs | why the trade is honest here |
|---|---|---|---|
| `§11` shell budget — 2.4MB WebGL hero | The product is a real-time renderer; the hero is the demo | LCP 3.1s on the target mid-range Android; everyone below it gets the fallback | Capability is the whole claim, measured on device rather than assumed, and the fallback is art-directed and signed off |
| Platform convention — custom command surface replacing the native menu | Two keystrokes removed from an action performed roughly sixty times a day | Voice control and switch access needed hand-built support; a new operator loses most of a first day | Tool-shaped, daily audience, gain compounds; the full affordance set was rebuilt and is listed in `ACCESS.md` |
| Category fence — padlock at the card form | The trust signal lands in under a second, where nothing else tested did | One conventional element inside a surface built to avoid them | Used once, at the point of payment; the position holds everywhere else on the surface |

Three properties of that row matter more than its format:

- **It is written when the break is made, not at the end.** A retroactive rationale describes
  the result; a real one describes the choice. Everybody can tell the difference.
- **The cost column cannot be "none."** A break with no cost is not a break — it is a rule that
  was wrong, and the honest move is to say so and fix the rule.
- **It names the rule by its number.** "We took some liberties with the layout" is not a
  record. `§11` is.

`§3` already requires every run to state what it did to the style that nobody else does, and
`STYLES.md`'s subversion section already requires the broken rule to be stated explicitly,
because a subversion nobody can name is indistinguishable from an inconsistency. This file is
that requirement generalized past style — the same mechanism, applied to every rule the
pipeline holds rather than only the ones a style holds. `§3` was reaching for it. This is it
finished.

## The list is not closed

The five rules above are worked examples; the five fields are the mechanism. Any rule in this
plugin that is not on the never-breakable list is breakable under the same test — name what it
buys, name what it costs, state the condition that makes the trade honest, write the row.

Check the never-breakable list first. Then write the cost line. If the cost line will not come,
that is the answer.
