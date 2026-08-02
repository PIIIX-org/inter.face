# Principles

These are the rules that separate a distinctive interface from a templated one. Every
loop enforces them.

Three of them are **hard** (`§10`, `§15`, `§16`) — they cannot be skipped, waived, or
traded away, because they are about integrity rather than quality. They are marked
**[HARD]**. Everything else in this pipeline is skippable by the human, at a stated
cost — see `§16`.

---

## 1. Creativity is the baseline, not a mode you switch on.

At every design decision, in every loop, **the obvious answer is the failure mode.**
The expected hero, the default card grid, the seen-it-before scroll — those are
bugs. Generate genuinely novel options and choose the boldest one that still serves
the subject or product. A safe, predictable choice anywhere is a rule violation.

## 2. Think out of the box — as a hard rule, everywhere.

At each point, ask "what would nobody expect here, that would still be *right*?" —
and reach for that. Out-of-the-box is the floor, not the ceiling.

## 3. Reinvent every component, every run. Nothing is a template.

The styles in `STYLES.md` and the techniques in `CRAFT.md` are a **starting
position, never a destination.** Ship a named style unmodified and the run failed.

- Invent this subject or product's **navigation**, **content presentation**, and
  **section or screen transitions** fresh. Do not reuse a previous run's answer.
- Every run states in `DIRECTION.md` **what it did to the style that nobody else
  does** — the collision, subversion, or invention applied.
- If someone could pattern-match your output to a previous run, it failed.

## 4. Propose; don't just execute. Offer ideas they didn't ask for.

You are a creative partner, not a template-filler. At each design point, surface
**2–3 out-of-the-box ideas the human wouldn't have thought to request**, and let
them pick or riff. Bring options to every gate.

---

## 5. The work is the hero.

Chrome, motion, and clever navigation lose to the work itself every time. If the
technique is more memorable than the content or product it frames, the technique is
wrong. This is the constraint that keeps `CRAFT.md` honest.

## 6. Sample the brand color from reality.

Pull the accent from the subject or product's real work, logo, site, or brand —
sample the pixels, don't invent a hex. No existing brand? Choose deliberately (write
one sentence of physical scene that forces the choice) and say why. Then reconcile
with the three-second feel from `TRANSLATE.md`.

## 7. Own every asset.

Self-host fonts. Vendor and commit every library. No CDN in production, no
third-party analytics by default, no hotlinked stock photography ever. Free rein to
pull from a CDN while prototyping (`CRAFT.md`); it gets downloaded, committed, and
self-hosted before ship. Public endpoints go down and leave a broken interface
forever.

## 8. Generate your visuals; never drop raw output on the page.

Anything visual you need — generate it: CSS, SVG, canvas, WebGL, procedural. You may
also generate imagery with an image tool and then **treat it in-browser** (duotone,
grain, displacement, dithering) rather than placing raw output. This is deliberate:
it forces the visuals to be yours.

## 9. Anti-slop, aimed at what the images say.

This pipeline writes almost no prose — but every design image renders text, and an
unconstrained image model writes "Elevate your workflow" over an invented logo.
Realistic copy lengths. Minimal text per image. No invented brand names. No hollow
superlatives. No "not X, but Y." Where real copy exists, use it; where it does not,
use plausible-length lorem-free placeholder drawn from the subject's actual domain.

## 10. Accessible by default. **[HARD]**

Accessibility is decided in Loop 1, not audited in a final pass. Across the three
parent pipelines there were zero mentions of ARIA, focus management, or live regions
while this same rule was marked hard — because every one of those is *designed*, and
the pipelines only ever *checked*. A hard rule enforced only after the build is a
hard rule in name.

Semantic structure or platform-native components. Keyboard-reachable everything,
visible focus. Descriptive alt text on every image. Body contrast ≥ 4.5:1. Every
animation ships a **designed** `prefers-reduced-motion` state — a still frame
someone art-directed, not `animation: none`. Every WebGL surface ships a no-WebGL
fallback for context loss and old GPUs.

The full decision list — target sizes, ARIA pattern choice, focus order, native
platform divergences — lives in `ACCESS.md`, run at Loop 1, before a single image
generates. Flawless includes the person who gets motion sick and the person on a
five-year-old Android; neither is a thing you discover in Loop 8.

## 11. Performance is a design constraint, in two tiers.

**Shell** — HTML, CSS, fonts, critical JS — stays under 100KB and paints something
real on its own. **Heavy layer** — shaders, 3D, physics — lazy-loads after first
paint, declares its budget at Gate B, and never sits in the LCP path. A 600KB shader
stack is fine if nothing is waiting on it. LCP < 1.5s on the shell.

## 12. Verify live. Never assume.

Screenshot the *rendered* surface — mobile, tablet, and desktop where the surface
class applies — and look at it. "It builds" is not "it renders." Confirm with your
eyes.

## 13. Respect the subject or product's language and script.

If it is presented in a non-Latin script or an RTL language, handle it properly:
`dir="rtl"`, CSS logical properties, a font that actually renders the script,
mirrored layout, and never transliterate or mangle a name to make it fit.

## 14. A real person's likeness is the one image you do not generate.

`§8` says generate every visual. A photograph of a real person is the exception. Use
the photo supplied. Never generate, synthesize, or face-swap a photograph of a real
human being — the subject, their team, their customers, or anyone else who appears
in the interface.

Treatment in-browser is allowed and usually right: duotone, grain, halftone,
dithering, a hard crop, a masked shape. That pulls the photo into the design system
while the face stays theirs.

No photo supplied means design around its absence. An interface with no face is a
decision someone can defend. An interface with an invented one is a fake person
appearing on it.

Alt text applies here as everywhere (`§10`): describe the person and the treatment,
and use the name they go by.

---

## 15. Keyboard completeness. **[HARD for tool-shaped surfaces]**

Every primary workflow completable by keyboard alone. Not as an accessibility
checkbox — though `§10` covers that too — but because the person who does this job
for eight hours a day types faster than any pointer, and a workflow that drops into
the mouse partway through has failed them.

- Tab order follows the visual order; focus is always visible.
- The primary action of a form is `Enter`; the escape from anything is `Escape`.
- A command palette or a "go to" shortcut once the surface has more than a handful
  of screens.
- In a table: arrow keys move, `Enter` opens, `Space` selects, `Shift` extends.
- Never trap focus except in a modal, and a modal always returns focus where it
  came from.

Page-shaped surfaces still owe `§10`'s keyboard-reachable-everything. This rule is
the harder claim — full workflow completion, not just reachability — and it is hard
specifically where the surface is tool-shaped. The full state and shortcut set lives
in `TOOLS.md`.

## 16. Human gates are real stops. **[HARD]**

Gate A (direction) and Gate B (craft). Neither is a status update: the written
output is the OUTPUT of the interactive review, not a substitute for it. If there is
any non-trivial finding, the path to proceeding goes through the human.

Skipping is allowed, silent degradation is not. The human may skip any non-**[HARD]**
step. When they do, record it in `DIRECTION.md` as a decision, not an omission:

| decision needed | if deferred, what happens |
|---|---|
| reduced-motion still frame not art-directed | ships as `animation: none`, a plain freeze instead of a designed state |

State the cost once, accept the answer, carry it into the run's confidence, and do
not raise it again.
