# Changelog

All notable changes to inter.face. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] — 2026-08-14

The pipeline had been reviewed roughly twenty times and executed zero times. It was run once,
end to end, exactly as written; the run's 27 recorded observations drove everything else in
this release.

It caught itself four times, and none of the four is buried. A prototype worker fabricated a
screenshot mid-run; the run's own integrity rule cut the surface, and the fabricated file shipped
to this public repo anyway, under a page whose copy claimed it was photographed. The pass that
backfilled citations onto the research docs asserted it had re-fetched every quote and had not —
two Apple quotes were wrong, one of them reversed in meaning, in the file whose entire subject is
a quote Apple never wrote. The correction then landed in `docs/research/` and stopped there,
leaving the reference file agents actually read a pass behind. And the pass that repaired that
reference file cited a fourth Apple page, wrote that it had been read, and left no record of the
reading anywhere in the repo — a verification asserted and not recorded, which is the second
failure wearing a fourth hat. That one was settled by doing the work: the page was fetched and
both quotes held. All four are written up below rather than into quiet fix commits.

### Added

- **The first full run, shipped as a worked example.**
  [`runs/taha-portfolio/`](./runs/taha-portfolio/) carries the filled six-row table, both loop
  drafts, the signed `DIRECTION.md`, `tokens.json`, and seven prototypes — six shipped, one cut
  on integrity after a worker fabricated a screenshot the page copy claimed was photographed off
  a running build. [`RUN-NOTES.md`](./runs/taha-portfolio/RUN-NOTES.md) is the ledger, written
  during the run rather than after it.
- **Coded comps as a first-class Loop 1 mode**, and the default when the gate is presented on a
  rendered board; image generation becomes the opt-in.
  [`agents/surface-designer.md`](./agents/surface-designer.md) gains the mode with the same
  one-surface-one-concept rule, the same two token menus, and the same anti-slop copy rules
  binding in both. [`loops/01-direction.md`](./loops/01-direction.md) forks for it end to end —
  the surface-class read, the `ACCESS.md` ordering, N and its labels, the detail request, the set
  check, and all three Gate A rejection routes — where it had forked only at §8. A coded-comp gate
  package states that its contrast ratios were computed, not observed.
- **How to construct the numbers the plugin has always demanded.**
  [`STYLES.md`](./STYLES.md) gains ramp construction in OKLCH (coordinate anchors, a
  hold-hue / hold-lightness / cut-chroma priority, the measured sRGB and P3 chroma ceilings per
  lightness and hue, a three-line in-gamut check), the type scale as a named choice between
  ratio-derived and role-indexed, and the spacing scale — one base, ratio naming, a token only
  for the values with a job. [`CRAFT.md`](./CRAFT.md) gains elevation as a distance rather than a
  shadow (six levels in dp, four of them places a thing can rest), the layout grid where margins
  cap at 24dp and pane structure carries the adaptation above that, the baseline grid finally
  defined, and fluid `clamp()` with both bounds in `rem`. Loop 1 §5–§6 and Loop 2's `DIRECTION.md`
  schema now point at these methods instead of assuming the numbers exist.
- **[`SURFACES.md`](./SURFACES.md) §6–§8**: canonical layouts (feed, list-detail, supporting pane,
  with Material's own way of telling which one a concept is), navigation, and safe areas with
  system gestures. Android 15 draws under the system bars by default and Android 16 removes the
  opt-out, so `env(safe-area-inset-*)` inside `max()` is the working pattern; gesture exclusion
  caps at 200dp vertically and can never cover home or quick-switch. Apple publishes no tab
  maximum — its "five" is an aim, and only for user-customizable bars.
- **[`ACCESS.md`](./ACCESS.md)**: the EN 301 549 chain, the live-region support table it
  previously said it lacked, and the four SPA focus destinations as an option space with costs.
- **A writer for `SKIPS.md`.** It had a definition and nothing that appended to it. Both gates now
  do, with the cost and the date — written by the session holding the gate, not by the phase
  conductor, which cannot attend one.
- **Four checks in [`scripts/check.sh`](./scripts/check.sh)**: cross-file section pointers
  resolve, loop and conductor do not restate each other, the routing table's line counts match
  `wc -l`, and the two counts the router writes as prose instead of as a table entry — the
  `ACCESS.md` §13 and `SURFACES.md` §1–§3 spans, each printed as *N of M* — are recomputed from
  the section headings and the file total. Those are the drift-prone pair: a span moves whenever
  any section above it is edited, and `SURFACES.md` §4 was edited three times this release. The
  second check normalizes every sentence of 60 characters or more in a loop file and fails on any
  that also appears in its conductor.
- **[`.github/workflows/check.yml`](./.github/workflows/check.yml)** runs `scripts/check.sh` on
  pushes to `main` and on pull requests targeting it. The checks existed; nothing ran them.

### Changed

- **Every agent's tool fence is now stated with its reason, and two of them widened.** Both
  conductors go from `Read, Write, Agent` to **`Bash, Read, Write, Agent`** — on Claude Code the
  fence is enforced, so that is a real capability change to two shipped subagents. Each carries its
  reason: the clock reading both loops demand at every phase boundary, which nothing else gives a
  subagent; Loop 1's rendered advance-width check, which is what catches a font missing the weights
  its scale names; Loop 2's serialized-screenshot fork, which without a shell gets decided by the
  fence instead of on the merits. Neither gains permission to build.
  `technique-prototyper` moved the other way and stops naming `python3` as *the* way to serve a
  prototype whose proof reads pixels back — any static server already on the machine, named in the
  verdict. A dependency removed, not added.
- **Image mode has a prerequisite this plugin does not ship.** `surface-designer`'s two image
  entries are MCP servers that must already be connected; installing the plugin does not install,
  configure, or authenticate either, and nothing in the repo checks. With neither reachable, image
  mode cannot run at all — the file now says fall back to coded comps and report image mode as
  **unavailable rather than unchosen**. Its `tools:` line does not shrink in coded mode either:
  frontmatter is static, nothing rewrites it per run, and the restraint is written down because no
  wall enforces it. The description said otherwise and was wrong.
- `PRINCIPLES.md` §9 aims anti-slop at the comp rather than at the image, because a coded comp is
  mostly words too. Coded mode raises the stakes: a hollow superlative in a render still reads as a
  sketch of a headline, while the same words in a spec block are a string somebody builds from.
- The correction fork belongs to the main session. `REDESIGN.md`'s fix ladder is one fix, one
  commit, re-screenshot — N=1 work editing shipped code, past where the rest of this plugin stops —
  so no phase agent owns that branch.
- Row 6's accent is a required field — filled or explicitly declared absent — and Loop 1
  re-samples the source directly instead of trusting the row's summary. Its type audit enumerates
  actual `@font-face` declarations, not family names: the run wrote a scale against weights that
  were not in the vendored files, and every face rendered from its nearest neighbour.
- A refusal to answer is treated as an answer: [`TRANSLATE.md`](./TRANSLATE.md) extracts the
  stance from it. [`REDESIGN.md`](./REDESIGN.md) greps local source when a subject has no live URL.
- N — the surface count — is set once, before concepts are developed, and is identical across
  them. A concept proposes content for N slots, never its own N.
- The surface list is a path, not an inventory: page-shaped it is the scroll order, tool-shaped it
  is the operator's traversal of the primary workflow with the failure branch on it.
- Gate A presents the family-pass labels **before** the concepts and asks the human to match them.
  The distinctness test that used to grade itself now has a fresh judge at no cost.
- `ACCESS.md` §13 gains an N/A state distinct from deferred-with-cost, marks the three rows that
  fork per concept, and requires the focus ring's contrast measured on every background it can
  land on — including the accent itself, the case that failed in the run at 2.59:1.
- Loop 2 names its instrument: the throttle is CDP `Emulation.setCPUThrottlingRate` at 4×. Without
  CDP there is no throttled number, the evidence label caps at PARTIAL, and a synthetic
  main-thread burn is banned as a substitute — it reads as a throttle while measuring nothing. The
  worked TESTED example in [`loops/02-craft.md`](./loops/02-craft.md) and
  [`technique-prototyper`](./agents/technique-prototyper.md) went on printing *"6× CPU throttle"*,
  a different instrument from the one the rule names; both now read 4×, so the example a worker
  copies is the instrument the release specifies.
- A prototype may use a stand-in and may never make a provenance claim about one. Breaking that is
  a cut.
- **Every worker writes its result to disk before it returns, and every dispatch names the
  absolute path it writes to.** Comps and their two tokens, prototype verdicts with label and
  measurements, the scout's package, and both conductors' running drafts. The set-level check
  reads the tokens off those files rather than out of the replies.
  [`loops/01-direction.md`](./loops/01-direction.md) §9–§10,
  [`loops/02-craft.md`](./loops/02-craft.md) §2, both conductors,
  [`surface-designer`](./agents/surface-designer.md) and
  [`redesign-scout`](./agents/redesign-scout.md) carry it. A session boundary in the run killed
  both conductors and all seven worker
  return messages at once; the conductors resumed from their own drafts and the verdicts were
  reconstructed from artifacts, because those were the only things still on disk.
- Conductors stopped restating their loop files. Where a conductor and its loop disagreed, the
  loop file now wins by rule, and only the conductor's own additions stay inline.
- The phone comp stays 4:5, with the reasoning written down and labelled as reasoning rather than
  evidence — the run shipped no phone surfaces, so no data settled it.
- `SURFACES.md` §1 states the 200% / 140% scaling as Apple's "ideally", not as an obligation.
- Line counts recounted everywhere, and the two denominators separated: the corpus is 6,056 lines
  across the eleven reference files, 6,250 with the 194-line router that a phase actually loads.
  The worked example loads 1,992 of that 6,250 in Loop 1 and 1,358 in Loop 2. `scripts/check.sh`
  now recomputes both kinds of count, so the next edit that moves one fails the build instead of
  ageing quietly.
- Version 0.2.0 in the Claude Code plugin and marketplace entries, the Codex plugin, and the
  Gemini extension. Those descriptions and the skill's now say one comp per surface — coded by
  default, a generated image on opt-in — where they said one design image.
- `README.md` is rewritten around what the repo can actually show. It gains the run: what it
  produced, the three findings worth reading it for — the integrity cut, the vendored fonts that
  were the wrong weights while the browser reported success, the frame-rate instrument that
  measured nothing — and the two advertised deliverables **missing** from it, since no comps and no
  verdict files were ever committed. Its enforcement section is rewritten against the real
  frontmatter: all five agents hold `Bash`, `Bash` is an unrestricted shell, and the repo therefore
  ships **zero shell-fenced agents** — what a `tools:` list still fences on Claude Code is what it
  omits (`Agent` on the two conductors only, the image tools on `surface-designer` only), and
  subagent context isolation is the enforcement that actually holds. The one real run never tested
  the wall: that harness had no registered agent types, so the conductor ran general-purpose with
  every tool granted.
- **Its corrections sit together instead of through the pitch.** Six figures on that page differ
  from an earlier draft of it, from a source document, or from the run's own log; each is now one
  line in a `Corrections` section at the foot, and the pitch prints the current number and points
  there. A page arguing that the files say what did not verify does not get to quietly renumber
  itself, and it also does not get to be half asides.
- **Two claims the README made about everything, narrowed to what it can show.** *Every number in
  the reference files traces to `docs/research/`* was wrong twice: numbers lifted from someone
  else's skill trace to `docs/audit/`, where the audited file **is** the primary source, and two
  figures traced to neither. One of those two stopped being an exception by being corrected —
  the *six of seven audited skills* tally in `loops/01-direction.md` §7 is now *four of the five*,
  re-derived against the skills themselves and printed under `docs/audit/` where anyone can rerun
  it. **One standing exception is left**, named on the page and one grep from anyone checking:
  `CRAFT.md`'s fourteen approximate library weights, which that file already tells you to
  re-measure. And *one measured prototype per technique* becomes one prototype **required to
  measure itself**: the demand is unconditional, the number coming back is not, and where the
  instrument fails the label caps at PARTIAL or INFERRED and says why. The first real run is that
  case.
- The install instructions stopped describing adapters nobody tested. Codex needs none — it walks
  `AGENTS.md` natively from the project root, and the 13KB router fits its 32KiB budget — while
  `.codex-plugin/plugin.json`'s `contextFile` key appears in no documented manifest and is now
  labelled untested. The Gemini manifest binds only for a directory installed as an extension, so
  the command to install it is written down, and the fact that it has never been run against this
  repo is written down beside it.

### Fixed

- **The fourth catch — a verification asserted and never recorded.** The pass that repaired
  `SURFACES.md` §4 replaced an unsourced hard rule with two Apple block quotes attributed to a page
  called **Adopting Liquid Glass**, and wrote in two places that three Apple pages had been *"read
  on 2026-08-14."* **No file in this repo recorded any of it**: the pages-read table in
  `mobile-native-verified.md` listed three URLs and that page was not one of them, and the string
  *Adopting Liquid Glass* appeared nowhere under `docs/` except inside those `SURFACES.md`
  parentheticals. A claim to have checked something, with no receipt, is exactly the failure these
  files exist to catch — the same one the citation backfill below committed. It was then actually
  checked. Adopting Liquid Glass and Applying Liquid Glass to custom views were fetched from
  Apple's rendered documentation data and read end to end, 26,172 and 7,545 characters, and
  Materials was re-read the same day by a second independent path; **both quotes are on the page,
  verbatim.** The URLs, the date, the fetch method, both quotes in context and the phrase-occurrence
  counts are now in
  [`mobile-native-verified.md`](./docs/research/mobile-native-verified.md), which `SURFACES.md` §4
  cites. Three things fell out of doing it properly: a **fifth** unmarked trailing cut — the
  custom-backgrounds quote stopped at *"let the system determine the background appearance"* where
  the page continues *", especially for the following elements:"*, now marked; Apple's *"highly
  translucent"* confirmed as Apple's wording and given the row it never had — `SURFACES.md` had
  been quoting it with nothing verified behind it, its only trace under `docs/` a raw-claims file
  this project classifies as a lead, and it is on **Materials**, not on Adopting Liquid Glass; and
  the two unconfirmed rules below searched across all three pages and still absent, with the
  occurrence counts printed. One method note is recorded because the next reader will hit it: the plain HTML
  of an HIG page is a 158-character JS shell, so an empty `curl` is not evidence a phrase is
  missing.
- OKLCH gradients: right behaviour, wrong attribution. CSS Images 4 makes Oklab the default with
  no legacy exception, and the sRGB fallback for legacy colour stops is browser behaviour measured
  in Chromium 145. The instruction changed from "write one endpoint in `oklch()`" to "declare the
  interpolation space".
- EN 301 549 does not lead where the plugin assumed. Published V3.2.1 carries WCAG 2.1 and maps to
  the Web Accessibility Directive, not the European Accessibility Act; V4.1.0 adds the EAA annex
  and aligns to WCAG 2.2 but is still a final draft. The WCAG 2.2 AA target is now stricter than
  the current EU floor on purpose rather than by accident.
- Nested spacing units are every non-multiple of the base, not only the four the page happens to
  show as examples.
- `runs/taha-portfolio/prototypes/p5-duotone-detail.html` asserted its plate was *"photographed
  off the running build"* and that *"Nothing here is a mock"* — the exact sentences T5 was cut
  for, still shipping under them. It loads no image now: the plate frame holds a schematic drawn
  inline in the file, and the sheet prints the fabrication and the removal as Rev. C.
- `ACCESS.md` §12 quoted EN 301 549 V4.1.0's presumption-of-conformity sentence with its last
  clause dropped. It now ends where the source ends — "that Directive and associated EFTA
  regulations" — matching
  [`docs/research/en301549-and-live-regions-verified.md`](./docs/research/en301549-and-live-regions-verified.md).
- **Citations backfilled onto the two research docs that shipped without them — and the fabrication
  the backfill itself committed.**
  [`platform-numbers-verified.md`](./docs/research/platform-numbers-verified.md) and
  [`mobile-native-verified.md`](./docs/research/mobile-native-verified.md) had no URLs at all —
  including for the fabrication finding that is this project's flagship catch. Both now carry a
  source table naming the page behind every quote. The backfill then wrote that each quote had been
  re-fetched and confirmed present, **and that assertion was false**: a reviewer refetching by two
  independent paths found two Apple quotes that do not match the Materials page. One was
  **reversed** — overuse of Liquid Glass distracting from *important functional elements*, where
  Apple says it distracts from the *content*. The other collapsed Apple's distinction between
  *interactive elements and content* into one *between the functional layer and the content layer*,
  dropping the named exception for transient content-layer controls with it. In the file whose
  subject is a quote Apple never wrote, the backfill added two more of the same kind. A second pass
  re-read every block quote live: two wrong and corrected, six elided or spliced without marking and
  now marked, one unreproducible number dropped (a `"vibrancy"` occurrence count no stated method
  yields), and **the four zeros of the original finding reproduce exactly**. A third pass then
  checked the file's claims about itself: the second pass's own tally said five where six were
  annotated, and four quotes it had just called complete were still cut a sentence short of where
  the page ends. `platform-numbers-verified.md` took the same treatment — **every number on it holds
  and none moved**, and four quotations spliced or truncated without an ellipsis are repaired, the
  load-bearing one being Apple's Accessibility Inspector using WCAG AA values *"as guidance"* where
  this repo had printed a flat statement of what the tool enforces. Every correction is annotated in
  place with what the earlier text claimed — a verification claim that was not performed is the
  failure these files exist to catch. A Material 3 Expressive takeaway also moves from *"score
  higher on user attention"* to the page's *"user attributes like playfulness, energy, creativity,
  and friendliness."* Each of the first three passes declared a file clean and each was followed by
  one that found more of the same defect — the fourth found the fifth unmarked trailing cut, this
  time in `SURFACES.md` — so both files now say to read their counts as floors.
- **The reference file was a pass behind its own research, and the reference file is what an agent
  reads.** `SURFACES.md` §1 sends Loop 1 into **§4** on any iOS-native surface. For the length of
  one pass the corrected Liquid Glass quotes sat in `docs/research/` while §4 went on shipping the
  retracted ones as Apple's words — the inverted sentence included — out of the file whose job is
  platform law. Both block quotes are now the full Materials wording, and four more defects went
  with them, each named in the research doc's findings list and disclosed nowhere else.
  **"Never the content layer"** was an absolute Apple does not state, and it shipped in three
  files, not one. All three now carry the rule Apple does write with its named exception attached —
  a slider or toggle in the content layer *does* take the Liquid Glass appearance while a person is
  activating it, and that exception is the part a design decision turns on. `SURFACES.md` §4 states
  it in Apple's full wording; `STYLES.md`'s liquid-glass entry states it in a sentence and points at
  §4 for the source, and stopped saying the material *"is never stacked on itself"* — Apple's verb
  is *avoid*, not never; `agents/surface-designer.md`'s iOS-native row states it too, which is the
  one that matters most, because that card is what a Loop 1 worker reads **instead of** the
  reference section. A worker dispatched with the card and nothing else never opens `SURFACES.md`,
  so a correction that stops at the reference file leaves the shipping instruction wrong.
  Two more were bolded as hard rules and appear on none of the three Apple pages read on
  2026-08-14: **"never stack glass on glass"**, with its instruction to use fills,
  transparency and vibrancy on anything above the material, and **"the two variants are never mixed
  in the same interface."** Both are **demoted to unconfirmed in place rather than deleted**,
  because the evidence points two ways. The fills-transparency-vibrancy wording sits verbatim
  inside the fabricated quote this release exists to catch. But both rules also come from
  [`native-mobile-design-synthesized.md`](./docs/research/native-mobile-design-synthesized.md), an
  automated deep-research synthesis dated 2026-08-01 that reports them confirmed verbatim against
  WWDC25 session transcripts — and nobody opened a transcript this pass. So what the Adopting
  Liquid Glass page does say stands in for the first — avoid overcrowding or layering glass
  elements, reduce custom backgrounds on controls and navigation — and the second keeps only the
  part Apple states, that clear is for components over visually rich backgrounds. Consistency
  between variants is taste until someone opens the transcript. Last, the variants table called
  clear **non-adaptive**, which the page contradicts: the appearance of *both* variants changes
  under Reduce Transparency, Increase Contrast, and the Liquid Glass look setting. And the dimming
  rule is back as Apple's two bullets, with the 35% figure and the AVKit exception a bracketed
  paraphrase had swallowed.
  That synthesized doc now opens with a **dated retraction notice** naming all three withdrawn
  findings — never-stack, never-mixed, and clear-as-non-adaptive — while its body is left exactly
  as the 2026-08-01 automated run wrote it, because rewriting the body would destroy the evidence
  that the run was wrong. The notice says who withdrew them, tells you to read every 3-0 vote in
  the file as how that run's verifiers voted on that date rather than as current status, and
  falsifies the file's own cross-validation note, which had offered this document as independent
  confirmation of never-stack and claimed the two methods agree everywhere they overlap. It also
  says what the retraction does **not** say: the citations there are WWDC25 session transcripts,
  nobody opened one, so the finding is that these rules are not on the pages this project has read
  — not that Apple never said them. Opening sessions 219 and 356 is the outstanding work that
  would settle it either way, and it is named there as such.
- **`agents/surface-designer.md` had 28×28 pt as "the absolute minimum."** That is the collapse
  `SURFACES.md` §2 names and forbids, sitting in the one file a Loop 1 worker reads *instead of*
  §2. Its iOS-native row now draws 44×44 pt as Apple's **default**, under Apple's own verb
  *"strive to meet"*; 28×28 pt is the published minimum control size, and a control drawn there
  carries its reason in writing. The like-for-like answer to Android's 48 dp is the 44 pt hit
  region, not the 28 pt floor. The Android row stopped reading as though 44×44 dp were a smaller
  touch target — it is the **pointer** spec, a different measurement.
- **`AGENTS.md` §3 contradicted itself about `CRAFT.md`.** One paragraph said Loop 1 never opens it;
  the next said both conductors read it by named section. Section entry is now scoped to the phase
  that owns the file — `TOOLS.md` by named section in either loop but only when row 1 is
  tool-shaped, `CRAFT.md` by named section in Loop 2 alone.
- **The audit doc's own numbers.** `docs/audit/competitor-small-skills.md` carried portfolio.me's
  `STYLES.md` at 389 lines where `wc -l` returns **388**. Its variance-instruction finding said
  *six of the seven* fail while leaving the seventh — `design-shotgun`, the one it calls the
  success — outside the seven it was counting. Re-checked against the files: five skills carry a
  between-runs variance instruction and four of them fail. The count moved; the finding did not.
  Because the re-check is written down where the audit lives, `loops/01-direction.md` §7 and
  `README.md` now print that number over a receipt — which is why the sourcing section above has
  one standing exception instead of two.
- Published counts recomputed with their method written beside them. The lineage and audit
  line-overlap figures are now counted on **non-blank** lines, which moved both — blank lines match
  each other by the dozen and say nothing. And `STYLES.md` carries **32** style entries, not the 34
  the README and an audit doc had been repeating; the audit predates the file's first commit, so
  where 34 came from is unverified and is recorded as unverified. The counting rule that yields 32
  is printed beside it, so the number can be rerun instead of believed.
- **The count of caught-on-the-way-in claims was five and is four.** The fifth, *"a claim that
  contradicted its own cited source"*, has no receipt anywhere in `docs/`. Its only trace is the
  method preamble at `docs/research/legal-and-focus-verified.md:7`, which names no claim, no doc
  and no source — and counts four instances, treating that description as one *of* the four rather
  than as a fifth. `README.md` cuts it and says so; the 0.1.0 entry below is written to four. A
  paragraph arguing that assertions need receipts cannot carry one that has none. The run ledger's
  *"sixth plausible-but-wrong instance"* is annotated in place rather than renumbered — it was a
  running tally taken at the time, not a fixed ordinal.
- The run's *"paints something real with no JS at all"* claim named T3 and T4 as its proof. The
  JS-off screenshots actually on disk are T1's at both widths in both modes, T2's at both widths in
  light, and one pass of the title-block sheet; T4 has none. `DIRECTION.md` now names what is there
  and dates the correction.
- `.gitignore` no longer swallows run artifacts. It carried `runs/*/` from portfolio.me, where
  runs are private client work; here the runs are the showcase.

### Removed

- **The fabricated screenshot, and everything that still showed it.** The image a prototype
  worker invented mid-run was cut on integrity — and shipped to this public repo anyway, in
  commit `7b5c024`, still referenced by the page whose copy claimed it was photographed.
  `runs/taha-portfolio/prototypes/detail-atlas-login.webp` is deleted. So are the six
  `p5-duotone-detail-*` screenshots that had the same fabricated plate and the same false
  provenance copy baked into their pixels; the run ships 110 screenshots, not 116. The colour
  measurements in the run's `DIRECTION.md` §18 stand as taken and are no longer reproducible
  from this repo, because the image they were read off is gone. That is recorded rather than
  quietly repaired, alongside the dated correction at the foot of
  [`RUN-NOTES.md`](./runs/taha-portfolio/RUN-NOTES.md).

## [0.1.0] — 2026-08-06

Initial release. The design halves of three PIIIX pipelines — portfolio.me, webcrab, systemcicy —
merged into one cross-agent plugin, with the drift between them resolved rather than averaged.

- **One resident router.** [`AGENTS.md`](./AGENTS.md) is the only always-loaded file, budgeted at
  200 lines: routing table, a phase × surface-class × platform context protocol, and the run
  layout. Everything else is read on demand.
- **The reference corpus.** [`PRINCIPLES.md`](./PRINCIPLES.md) (16 rules, 3 hard),
  [`TRANSLATE.md`](./TRANSLATE.md) (the six-row input contract, every row naming what it changes
  downstream), [`STYLES.md`](./STYLES.md) (seven families, derivation before the list, style under
  density, collision), [`CRAFT.md`](./CRAFT.md) (technique arsenal, information design, motion,
  budgets, icons), [`TOOLS.md`](./TOOLS.md) (tool-shaped surfaces: nine data states, desktop
  window states, keyboard, forms, tables), [`SURFACES.md`](./SURFACES.md) (platform law),
  [`ACCESS.md`](./ACCESS.md) (accessibility as Loop 1 decisions, plus internationalization),
  [`REDESIGN.md`](./REDESIGN.md) (brownfield: extract, position, then fork on correction versus
  reposition), [`BREAKING.md`](./BREAKING.md) (what breaking a rule buys, what it costs, and the
  four rules that never break).
- **Two loops, two human gates.** [`loops/01-direction.md`](./loops/01-direction.md) runs palette,
  type, concepts and images to Gate A; [`loops/02-craft.md`](./loops/02-craft.md) runs technique,
  measured prototypes, motion and budget to Gate B.
- **Five agents:** `direction-conductor` and `craft-conductor`, plus `redesign-scout`,
  `surface-designer` and `technique-prototyper`. Neither conductor can hold a gate — a subagent
  cannot talk to the human, so both gates stay in the main session.
- **Seven agents' worth of packaging**, all pointing at the one router: Claude Code plugin and
  marketplace entry with the `/interface` command and the skill, Codex, Cursor, Cline, Windsurf,
  Gemini, opencode.
- **[`scripts/check.sh`](./scripts/check.sh)**: placeholder scan, resident-line budget, JSON
  validity, skill frontmatter, relative links resolve, every reference file forks on surface
  class, and Apple's numbers ship as default-and-minimum pairs — never 44pt alone.
- **Numbers trace to a dated verification doc.** Facts about the world go to `docs/research/`,
  read off rendered primary sources with a headless browser; numbers taken from someone else's
  skill go to `docs/audit/`, where the audited file is the primary source. Four plausible-but-wrong
  claims were caught on the way in and are documented where they were caught. *(Written as "every
  number traces to `docs/research/`" at the time. 0.2.0 found two figures that trace to neither and
  names them in `README.md`.)*
