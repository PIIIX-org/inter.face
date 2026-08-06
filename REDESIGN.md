# Redesign

Every other file in this plugin assumes a blank surface. This one does not.

A redesign arrives with a rendered system already in place — a set of decisions somebody
made, some deliberate, some inherited from a template, and nothing on the screen says which
is which. The greenfield path answers *what should this be*. A redesign has to answer *what
is this now* before it earns the right to ask, and the two questions have different failure
modes. Skip the first and every existing decision becomes a defect by default, including the
ones that were the point.

Read row 1 of `TRANSLATE.md` before anything below. A redesign means two different things.

On a **page-shaped** surface — read for seconds, once — nobody is owed a transition. The
viewer arriving next week has never seen the old version, so the cost of change is only ever
the cost of being wrong about the new direction. Almost all the risk sits in step 3 below,
and almost none in the sequencing.

On a **tool-shaped** surface — read for hours, daily — the operator has muscle memory, and
the muscle memory was earned on your predecessor's layout. A moved control costs a habit that
was worth real keystrokes, and it costs it on the first day, to everyone, at once. The
extraction step matters more here and the fix ladder inverts (§4 below): the change with the
biggest visual delta is not the change with the biggest impact on somebody's shift. The
failure mode is a redesign that reads as an improvement in screenshots and as a bad week in
the queue.

`loops/01-direction.md` reads this file when the ask is a redesign, and branches at its top
on the classification made in §3 below. This is not a second pipeline. It is four steps in
front of the existing one, one of which is a fork.

---

## 1. Extract the rendered system

**Output: `CURRENT.md` — what this surface is today, measured, not described.**

The distinction is the whole step. Everyone involved already has a description of the
surface, and the description is wrong in one specific direction: it names what was intended.
The DOM names what shipped. Where they disagree, the DOM is the input.

`redesign-existing-projects` goes straight from framework detection to a defect list, and
never asks what the current position is. gstack `design-review` has the extraction and no
repositioning story. The extraction primitive below is that skill's Phase 2, generalized off
its binary so any agent with a browser can run it — one query per thing worth recovering,
plus a performance read.

| Recover | What the answer tells you |
|---|---|
| **Fonts actually in use** | How many families are really on the page, and which one sets the most text. Three is a system; nine is an accumulation |
| **The real palette, ranked by occurrence** | What the surface is actually colored with. The token file is a claim; the ranked list is the palette |
| **The heading scale as rendered** | Whether it is a scale at all. Three levels within 2px of each other is not a hierarchy, whatever the markup says |
| **Interactive elements under the target floor** | Where the surface is already failing `SURFACES.md`, before anything moves |
| **The two-tier performance read (`§11`)** | What the budget already spends: shell weight, LCP, and what is sitting in the LCP path |

The one query worth carrying verbatim is gstack's, because the 500-element slice is a
deliberate cost control on a large DOM:

```
$B js "JSON.stringify([...new Set([...document.querySelectorAll('*')].slice(0,500).map(e => getComputedStyle(e).fontFamily))])"
```

Portable equivalents, for an agent without that binary — any headless browser or devtools
console will run them:

```js
// fonts in use
[...new Set([...document.querySelectorAll('*')].map(e => getComputedStyle(e).fontFamily))]

// the real palette, ranked by how often each value is actually painted
Object.entries([...document.querySelectorAll('*')].flatMap(e => { const s = getComputedStyle(e);
  return [s.color, s.backgroundColor,
          parseFloat(s.borderTopWidth) > 0 ? s.borderTopColor : null]; })
  .filter(v => v && v !== 'rgba(0, 0, 0, 0)')
  .reduce((m, v) => (m[v] = (m[v] || 0) + 1, m), {}))
  .sort((a, b) => b[1] - a[1])

// the heading scale, as rendered
[...document.querySelectorAll('h1,h2,h3,h4,h5,h6')].map(e => {
  const s = getComputedStyle(e); return [e.tagName, s.fontSize, s.fontWeight, s.lineHeight]; })

// interactive elements under the net
[...document.querySelectorAll('a,button,input,select,textarea,[role=button],[tabindex]')]
  .map(e => [e.tagName, e.getBoundingClientRect()])
  .filter(([, r]) => r.width < 44 || r.height < 44)
```

**The queries assume a rendered site; local source without one changes the tool, not the
step.** When no live URL exists but the source does, grep the source instead — custom
properties for the palette, `@font-face` for the type — and skip the browser; there is no
DOM to ask, and the stylesheet the subject actually wrote is the shipped record here.

**The border gate in the palette query is load-bearing.** `borderTopColor` computes to the
element's own `color` whenever no border is set, which is nearly every element on a page —
ungated, it double-counts every text color and body text out-ranks the page background even
where the background paints a thousand times the area. Even gated, the count is a census of
computed values rather than painted pixels: every element carries a `color` whether or not it
paints any text. Read the ranking as *what this surface is made of*, never as coverage.

**44 is a net, not the law.** It catches everything worth adjudicating and it is not itself a
standard. `SURFACES.md` holds the law and it is not one number: WCAG 2.5.8's 24×24 CSS px
with its geometric spacing exception on the web, 48dp / 44pt as the cross-platform-neutral
pair, and Apple's 28pt control minimum which is a different quantity from the 44pt hit
region. Sweep wide, then adjudicate each hit against `SURFACES.md`. Reporting a 44px sweep as
a count of WCAG failures is a fabricated finding, and it will be believed.

**And the sweep returns noise by construction.** `getBoundingClientRect()` reports 0×0 for
anything `display: none`, so every closed dropdown, every hidden menu item, and every control
inside an unmounted modal lands in the results at zero by zero. `[tabindex]` adds a second
source: `tabindex="-1"` programmatic focus targets, which are not interactive elements at all.
On a real application those two together are usually the majority of the hits. Drop everything
that is not visibly rendered before you count, and never report the raw length as a finding.

**Run every query at the viewports the surface actually gets.** Computed styles are viewport
dependent. A heading scale read at 1440px is not the one most of the traffic sees, and a
target sweep at desktop width misses the one place targets are actually tight.

### The absence sweep

A defect scan sees what is on the screen. It cannot see what was never built, because nothing
on the screen prompts the question. That is a separate axis and it needs its own pass:

- **The state set.** Page-shaped: `CRAFT.md`'s three render states — full, reduced motion, no
  GPU — for any technique already on the surface. Tool-shaped: `TOOLS.md`'s nine
  data states — empty, loading, partial, error, permission denied, offline, stale, conflict,
  bulk. Reach each one deliberately and record which do not exist. "Permission denied"
  rendering as a crash is not a defect anybody will file; it generates a support ticket every
  time instead.
- **The structural omissions**, which `redesign-existing-projects` lists and which are
  invisible by construction: no custom 404, no "skip to content" link, no back navigation out
  of a flow, no form validation, no legal links, no cookie consent.

### CURRENT.md is not a judgment

Nothing in it is a defect yet. The temptation is to write the audit while extracting, and it
has to be resisted for one specific reason: step 2 changes what counts as a defect. System
fonts and default link blue are a defect on most surfaces and are the literal definition of
`STYLES.md`'s Brutalism entry on others. Measure first. Adjudicate after you know what you
are looking at.

## 2. Position it against `STYLES.md`

Which family is this closest to — and then the question that actually matters: **is that a
choice or an accident?**

Three readings come out of the measurement, and they are different problems with different
fixes:

| What `CURRENT.md` shows | What it is | What it needs |
|---|---|---|
| **~80% of one family** | That family, with drift | Convergence. The position exists; naming the family gives you the standard to fix toward |
| **~30% of six families** | No position at all | Nothing to converge on. This is a reposition wearing a defect list — there is no "correct" state to restore |
| **100% of one family, unmodified** | A shipped template | A position, but the vendor's. Treat as no position, and `§3` says so already |

The DOM cannot answer "choice or accident" on its own. Three checks that can:

1. **Is it consistent where nobody enforces consistency by accident?** The 404, the error
   state, the print stylesheet, the transactional emails. A deliberate system reaches those.
   Drift never does.
2. **Does the position cost anything?** A real one refuses something — a palette held to four
   values, a pattern the category uses that this surface does not. Drift refuses nothing,
   because nothing was ever decided to refuse.
3. **Ask.** Row 6 of `TRANSLATE.md` exists for exactly this and on a greenfield run it is
   filled in from memory. Here it is filled in from `CURRENT.md` and then confirmed by a
   human, which is one question and the fastest route to an answer.

This step is the only thing standing between a defect list and the most expensive failure in
the redesign path: a ~120-item audit run against a deliberate brutalist site will cheerfully
"fix" raw system fonts, default link blue, and unstyled controls into a premium template, and
every individual fix will be defensible. The audit is not wrong about any single line. It is
wrong about what it is looking at.

## 3. Classify the ask — a fork, not a slider

There is no "mostly a correction." The two paths run different loops, produce different
artifacts, and answer different questions. Averaging them produces a redesign that neither
fixes the execution nor changes the position, at the cost of both.

| | **Correction** | **Reposition** |
|---|---|---|
| **What is wrong** | The position is right; execution drifted | The position itself |
| **Evidence from §2 above** | ~80% of one family, with the family defensible for this intake | No position, or a position that is wrong for `TRANSLATE.md` rows 2–5 |
| **What it runs** | The audit, ordered by the ladder in §4 below, against the extracted system | Loop 1 in full, with `CURRENT.md` as an input constraint rather than a blank page |
| **The question it must answer** | Which fixes, in what order, at what risk | What is load-bearing and must survive |
| **Output** | An ordered fix list, each fix classified (§5 below) | `DIRECTION.md`, as greenfield, plus a survival list |
| **Gate** | No new Gate A — the per-fix discipline in §5 below is the stop, and anything touching position escalates to Gate A | Gate A in full, then Gate B. It is a new direction |

### The question greenfield never asks

**What is load-bearing and must survive?** A greenfield run has nothing to preserve, so
nothing in the greenfield path asks. On a reposition it is the first question, and it is
`TRANSLATE.md` row 6 — the row that already exists for this and that, on a redesign, is
answered from measurement rather than recall.

**Load-bearing is not the same as liked.** The test is what breaks *outside this surface* if
it changes: a logo that also prints on invoices, a color that exists in a physical product, a
nav label the support documentation cites by name, a URL somebody bookmarked, a control the
training video shows. "The logo survives" and "the logo, two brand colors, the nav order forty
operators memorized, and the URL structure survive" are different constraints and produce
different designs. Write the list before Loop 1, not during it.

### The third exit

If row 6 names a design system the surface must conform to — GOV.UK, Material, a corporate
DS — `TRANSLATE.md`'s escape hatch fires and neither path above applies. Route to conformance
and say so plainly. That is a common redesign ask and it is not a failure of this fork; it is
the case where invention is the wrong answer, and `BREAKING.md` covers recording it.

### The classification is falsifiable

Classify once, at the start, from the evidence. Then let the gates check it: **three Gate A
rejections on a correction path means the ask was a reposition all along.** A rejected
execution, a rejected concept, and a rejected brief are already three different diagnoses in
this pipeline; correction-versus-reposition is the same distinction one level up.

The escalation runs one way only. A correction can turn out to be a reposition. A reposition
never becomes a correction, because the question of whether the position is right cannot be
un-asked once it has been put to a human.

## 4. Fix Priority — order by impact ÷ risk

An audit without an order is a backlog. With an order it is a plan.

Category order — all typography, then all color, then all spacing — sequences the work by the
auditor's filing system. It is the default and it is wrong, because it says nothing about what
the surface gets back per unit of danger. `redesign-existing-projects` is the only skill in
the audited corpus that ships an ordering, and its two endpoints name the axis exactly:

> 1. **Font swap** — biggest instant improvement, lowest risk

> 7. **Polish typography scale and spacing** — the premium final touch

Largest visible delta for the smallest blast radius first; smallest delta at the highest
fiddliness last.

This is not `CRAFT.md`'s cheap wins with different words. That list ranks what to **add** to a
surface being designed. This one ranks what to **change** on a surface that already exists and
already has users, and the risk term means something else: not "could this break" but "who is
holding this while I change it." The two coincide at the top and diverge completely at the
bottom.

**Page-shaped**, where nobody is owed a transition:

1. **Font swap.** Changes every screen, can break no layout that a measure and `text-wrap`
   cannot repair. Self-hosted per `§7`, which is also when the CDN dependency leaves.
2. **Palette convergence.** The ranked list from §1 above collapsed to a real set, shipped as
   `STYLES.md`'s paired tokens, which makes contrast structural in the same move.
3. **Hierarchy.** Rebuild the heading scale as an actual scale with a stated ratio. Nothing
   moves; everything reads differently.
4. **The states that do not exist** — hover, active, focus, empty, error. Pure addition, and
   the focus state is `§10`, which is **[HARD]** and does not wait for its turn on this list.
5. **The structural omissions** from §1 above. Each is small, none is visible until it is
   needed, all of them are cheap.
6. **Spacing rhythm and optical alignment.** Real delta, high fiddliness, touches layout — the
   first rung that can actually break something.
7. **The signature move**, prototyped: the one collision-carrying moment nobody else has.
   Highest impact on this list and the highest risk, which is why it sits last on a correction
   and first on a reposition. That inversion is the difference between the two paths in one
   line.

**Tool-shaped**, where the risk term changes meaning — risk is not "does it break," it is
"does it cost an operator a habit":

1. **Tabular figures and hairline discipline.** Every screen, every day, breaks nothing, costs
   no habit.
2. **Density — rows per screen.** The largest real impact in a tool (`TOOLS.md`), and it costs
   nothing behavioral: same controls, same order, more of them visible at once.
3. **Keyboard completion of the top three verbs** (`§15`, **[HARD]** here). Pure addition; the
   pointer path still works for anyone who never notices.
4. **The missing data states** from the absence sweep. Mostly absence, mostly invisible to the
   people who signed off on the redesign, and the reason a support queue exists.
5. **Font and palette.** The same visual delta as page-shaped, ranked far lower, because it
   changes nothing about anybody's day.
6. **Moving a control the operator touches forty times a day.** The only rung here that can
   cost a habit. Last, gated, announced ahead of time, and never bundled with anything else on
   this list — if it lands with four other changes, nobody can tell you which one made the
   day worse.

## 5. The discipline: one fix at a time

`redesign-existing-projects` scans, diagnoses, and fixes in one uninterrupted pass on
somebody's live site. It has no gate, no verification step, and no rollback. Its rules say

> Do not break existing functionality. Test after every change

and supply neither a test nor a definition of broken. gstack `design-review`, operating on the
same territory, commits one fix at a time, re-screenshots, classifies each as `verified` /
`best-effort` / `reverted`, and self-regulates against a risk score with a hard cap of 30
fixes. **A redesign in this pipeline inherits gstack's discipline, not the small skill's.**

Per fix, without exception:

1. **One fix, one commit.** Two findings in one change is not a fix, because it cannot be
   reverted alone. This is the rule the other five depend on.
2. **Re-screenshot the rendered result** at the viewports that matter, and read the console.
   `§12`: "it builds" is not "it renders."
3. **Classify it, in writing, as exactly one of three.** `verified` — re-rendered, looks
   right, console clean. `best-effort` — applied, could not be confirmed, and the reason is
   stated. `reverted` — tried, made something worse, rolled back. A fix with no classification
   is an unverified claim, and a list of them is worse than no list because it reads as
   completed work.
4. **A hard cap, written down before the first fix.** gstack's numbers are a defensible
   default: recompute a risk score every 5 fixes (+15% per revert, +5% per component-file
   change, +20% for touching unrelated files), stop above 20%, hard cap 30. Take those or set
   your own; the load-bearing part is that the cap exists in advance, because a fix pass with
   no cap ends when the agent runs out of attention, and that is not a stopping rule.
5. **Start from a clean tree.** gstack refuses to run otherwise, and the reason is that
   "reverted" has to mean something.
6. **Anything that changes position leaves the pass and goes to Gate A.** A fix that needs a
   new direction is a reposition arriving one commit at a time, and it is the way a correction
   silently becomes a rewrite nobody approved.

And the host rules, which the small skill gets exactly right and which survive intact:

> - Work with the existing tech stack. Do not migrate frameworks or styling libraries.
> - Before importing any new library, check the project's dependency file first.
> - If the project uses Tailwind, check the version (v3 vs v4) before modifying config.
> - Keep changes reviewable and focused. Small, targeted improvements over big rewrites.

A scan-diagnose-fix pass with no gate and no revert path is more dangerous than the problem it
solves. The surface was working when you found it, and somebody is using it right now.

## Where this came from

Neither source has the whole method. This file is the composite, and the seam is worth being
able to see:

| Step | Source |
|---|---|
| Extraction queries, the perf read, the per-fix loop, the risk cap, the clean-tree precondition | gstack `design-review` — Phase 2 and its fix loop |
| The three-move spine, the symptom-with-remedy audit format, the structural omissions axis, the Fix Priority ordering, the four host rules | `redesign-existing-projects` |
| Position before diagnosis, the correction/reposition fork, the load-bearing question, the tool-shaped re-ranking, the falsifiable classification | Neither. Assembled here, from the gap between them |
