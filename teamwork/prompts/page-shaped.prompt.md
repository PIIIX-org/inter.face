# Teamwork Project Prompt: Page-Shaped Art Direction

Execute an art direction run for the page-shaped surface described below.
This project stops before building application code — deliverables are DIRECTION.md, tokens.json, comps, a navigable board, measured prototypes, and a component sheet.

Working directory: runs/<slug>
Integrity mode: development

## Requirements

### R1. Concept Derivation and Board (Gate A)
Derive three distinct visual design directions from the brief and inbox evidence.
Enforce §10 accessibility upfront: verify contrast ratios against WCAG AA and specify reduced-motion states.
Generate one comp per concept for the surface.
Assemble all three concepts into a navigable `design/board.html` file.
Present Gate A package to the human user and await selection.

### R2. Technique Prototyping and Tokens (Gate B)
Assign one visual or interactive technique serving the selected concept against the three-question test.
Build a standalone runnable HTML prototype in `prototypes/` that executes in any browser without build tools.
Include explicit `@media (prefers-reduced-motion)` fallback styling.
Generate `tokens.json` containing complete color, typography, spacing, radius, and motion tokens.
Present Gate B package to the human user and await approval.

### R3. Component Sheet and Gap Report (Gate C)
Extract component inventory from the signed comps and assemble a navigable component sheet in `system/sheet.html`.
Construct the sheet strictly from `tokens.json` values without inventing unrecorded styling values.
Document any missing values as findings in `system/gaps.md`.
Present Gate C package to the human user and await sign-off.

## Acceptance Criteria

### Gate A Readiness
- [ ] `runs/<slug>/DIRECTION.md` contains concept direction sections for all 3 directions.
- [ ] `runs/<slug>/design/` contains at least 3 concept directories with valid comps.
- [ ] `runs/<slug>/design/board.html` exists and links to all concepts.
- [ ] Verification script `node teamwork/verification/verify-loop1.js <slug>` exits with code 0.
- [ ] Human user has confirmed concept choice.

### Gate B Readiness
- [ ] `runs/<slug>/tokens.json` parses as valid JSON.
- [ ] `runs/<slug>/prototypes/` contains standalone runnable HTML prototypes with reduced-motion fallback.
- [ ] Verification script `node teamwork/verification/verify-loop2.js <slug>` exits with code 0.
- [ ] Human user has confirmed technique approval.

### Gate C Readiness
- [ ] `runs/<slug>/system/sheet.html` exists and demonstrates all components in light and dark modes.
- [ ] `runs/<slug>/system/gaps.md` catalogs all gaps found during token construction.
- [ ] Verification script `node teamwork/verification/verify-loop3.js <slug>` exits with code 0.
- [ ] Human user has signed off on component set.
