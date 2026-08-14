# IMPROVE.md

How a run becomes evidence about the plugin, and how — only if the human says so — that
evidence gets back to the people maintaining it.

This file has two halves and they are independent. The first is a record every run keeps for
itself, whether or not anything is ever sent anywhere. The second is one question asked once, at
the end, with a default of no.

---

## 1. The run record

**`runs/<slug>/RUN-NOTES.md`, written during the run, not after it.** A note written afterwards
is a summary of what you remember, and what you remember is the version where it went well.

It travels with the project, not with the machine. Nothing here is written to the plugin's
install directory, to a home-directory cache, or to any per-device location — which is what
makes a run on a laptop, a run on a server, and a run in a container produce the same artifact
in the same place, readable by whoever picks the project up next. **A record only one device can
see is not a record.**

What goes in, appended as it happens:

- **The clock.** Each phase boundary, from the `date` calls the loops already order. This is the
  only source of how long anything actually took.
- **Every stumble, at the moment it happened** — the instruction that was ambiguous, the file
  that sent you somewhere unhelpful, the check that fired on something correct, the step whose
  order was wrong. Include the ones you worked around; a workaround is a defect with a
  successful outcome.
- **Every gate**: what was presented, what the human said, what they rejected, and — the half
  that gets thrown away — **what the rejection revealed** about the brief rather than about the
  work.
- **What the tools did.** An image model that would not hold a ratio, a screenshot that came
  back blank, a measurement whose instrument produced nothing usable. The first real run's
  frame-rate instrument is in the README because it was written down when it failed.
- **The thing that worked exactly as documented.** One per loop, deliberately, because a list of
  only defects gets read as a list of everything that happened.

`SKIPS.md` is beside it and is a different artifact: the append-only ledger of what the human
deferred, with its cost, appended at each gate. `RUN-NOTES.md` is about the plugin;
`SKIPS.md` is about this design. Do not merge them.

**The record is worth keeping even if nothing is ever sent.** It is what the next run of this
project reads, what a colleague inheriting the run reads, and what turns *"the design system
loop was awkward"* into a sentence somebody can act on.

---

## 2. The harvest

**At the end of the run, after Gate C closes and before the ask below**, read `RUN-NOTES.md`
back and turn it into findings about the plugin. This is a separate step from writing the notes,
and it is the step that makes them useful — notes are events, findings are claims.

Write them to `runs/<slug>/FEEDBACK.md`. Each finding gets:

- **What happened**, concretely, with the file and section it happened in
- **What it cost** — a wrong turn, a rebuild, a gate rejection, ten minutes, nothing measurable
- **What would have prevented it**, as a change to a named file, or the honest *"nothing; this
  was the run's own mistake"*

**Findings about the plugin, not about the design.** *"The client wanted a warmer palette"* is
not a finding; *"`loops/01-direction.md` §5 builds the palette per direction, but the inbox's
brand-book reconciliation lands in the same step and the order between them is unstated"* is.
The test: could this change a file in this repo?

**Include what worked.** A loop that ran clean tells the maintainers what not to touch, and it
is the half nobody ever sends.

---

## 3. The ask

**One question, once, at the very end. The default is no, and no is a complete answer.**

> This run produced a set of findings about the plugin itself — what was ambiguous, what cost
> time, what worked. Would you like to send them to PIIIX so the plugin improves?
> I will show you exactly what would be sent first. Nothing goes anywhere without you saying yes.

Three rules govern how that question is asked, and they exist because an opt-in that is
pre-checked, re-asked, or vague about its payload is not consent:

1. **Show the payload in full before anything is sent.** Not a summary of it — the actual text.
   The human reads what a stranger would read.
2. **Ask once.** A decline is recorded in `RUN-NOTES.md` and never raised again in the same
   run. Nagging converts a considered no into an unconsidered yes.
3. **Never send by default, never send silently, and never send on a timer.** There is no
   telemetry in this plugin, no background reporting, and no phone-home. If a future version
   adds one, it is a breaking change and it is announced as one.

### The redaction pass, before the payload is shown

Run this over `FEEDBACK.md` and show the result, not the original. A finding about the plugin
almost never needs the subject's business in it, and the small number that do can be rewritten:

- **The subject's identity** — company, client, product name, domain, the person — comes out.
  *"a hospitality client"* carries every bit of signal *"the Nomad Hotel Group"* does.
- **Brand assets and anything from `inbox/`** never go. Not the book, not the palette, not the
  logo, not the reference links. It is somebody else's intellectual property and it was handed
  over for one purpose.
- **Comps, screenshots, and the sheet** stay out of the feedback payload entirely. The gallery
  in §4 below is the one route for an image, and it has its own separate yes.
- **Paths, hostnames, and internal URLs** get stripped or generalised.
- **Anything under NDA, and anything unreleased**, is out regardless of how good a finding it
  would make.

Then read the redacted text once more as a stranger. **If any single line would embarrass the
subject if they read it in a public issue, cut the line** — a finding that cannot survive
redaction is a finding this plugin does without.

### How it is sent

`FEEDBACK.md`, redacted, as a GitHub issue on
[`PIIIX-org/inter.face`](https://github.com/PIIIX-org/inter.face) labelled `run-report`.

- **Where `gh` is available and authenticated**, `gh issue create` files it, and the human is
  shown the URL that comes back.
- **Where it is not**, hand the human a link that opens a new issue with the title and body
  prefilled, and let them press the button. They send it, from their own account, having read
  it. That is strictly better consent than an agent posting on their behalf, and it needs
  nothing installed.

Either way the run keeps its copy. `FEEDBACK.md` stays in `runs/<slug>/` whether it was sent,
declined, or never asked about, because it is the run's record first and a contribution second.

---

## 4. The gallery — a second, separate yes

**Only if the feedback question was answered yes, and only as its own question.** Consent to
send text findings is not consent to publish a picture of somebody's unreleased interface, and
collapsing the two into one prompt is how that happens by accident.

> Optional, and separate: would you like to share one screenshot of what you built with this,
> for the inter.face gallery? It would be public, with whatever credit line you want — or none.

What goes with it, and nothing else: **one image**, one line on what the surface is, and the
credit line the human chooses — a name, a company, an initial, or nothing at all. Same issue,
labelled `gallery`, or its own issue if the feedback was declined and only the gallery was not.

Four things this question owes the person answering it:

- **They are publishing their own client's work.** Say so plainly. Where the subject is somebody
  else's, the right answer is often *ask them first*, and suggesting that is not a way of
  talking them out of it.
- **The credit line is theirs**, including anonymous. Do not fill it in for them.
- **One image.** Not the board, not the sheet, not the run — the picture they would put in a
  portfolio.
- **It can be withdrawn.** Removal is one issue away, and this file says so before they decide,
  not after.

**Where the subject is a real person's likeness, `§14` applies here too**: the photograph is
theirs, and a gallery submission is a publication.

---

## 5. What this is for

The three sibling pipelines drifted for a year because nothing carried a finding from a run back
to the file that caused it. Each fork learned something real and none of them told the others.
This file is the return path, and its whole design is that the human owns it: they see the
payload, they choose twice, they can decline both and lose nothing but the contribution.

**A plugin that improves itself by watching people use it without asking has not improved
itself. It has just stopped asking.**
