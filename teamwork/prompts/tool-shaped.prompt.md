# Teamwork Project Prompt: Tool-Shaped Art Direction

Execute an art direction run for the tool-shaped surface described below.
This project stops before building application code — deliverables are DIRECTION.md, tokens.json, comps, a navigable board, measured prototypes, and a component sheet with §15 keyboard completeness walk.

Working directory: runs/<slug>
Integrity mode: development

## Requirements

### R1. Density and Concept Derivation (Gate A)
Derive three distinct visual design directions suitable for high-density, multi-hour daily usage.
Enforce §10 accessibility and §15 keyboard reachability upfront.
Generate one comp per concept addressing primary views, empty states, and density rules.
Assemble concepts into a navigable `design/board.html`.
Present Gate A package to the human user and await selection.

### R2. Interactive Technique Prototyping (Gate B)
Assign techniques serving high-density workflow efficiency against the three-question test.
Build standalone runnable HTML prototypes in `prototypes/` demonstrating load handling and key navigation.
Include explicit `@media (prefers-reduced-motion)` fallback styling.
Generate `tokens.json` containing complete styling tokens for tool palettes and state indicators.
Present Gate B package to the human user and await approval.

### R3. Component Sheet, Keyboard Walk, and Gap Report (Gate C)
Assemble a navigable component sheet in `system/sheet.html` covering the nine data states.
Execute a keyboard completeness walk (§15) proving every primary action is reachable without a mouse.
Document the keyboard walk in `system/keyboard-walk.md`.
Construct the sheet strictly from `tokens.json` values and document gaps in `system/gaps.md`.
Present Gate C package to the human user and await sign-off.

## Acceptance Criteria

### Gate A Readiness
- [ ] `runs/<slug>/TRANSLATE.md` confirms tool-shaped surface class.
- [ ] `runs/<slug>/DIRECTION.md` contains concept direction sections for all 3 directions.
- [ ] `runs/<slug>/design/` contains at least 3 concept directories with valid comps.
- [ ] `runs/<slug>/design/board.html` exists and is navigable.
- [ ] Verification script `node teamwork/verification/verify-loop1.js <slug>` exits with code 0.
- [ ] Human user has confirmed concept choice.

### Gate B Readiness
- [ ] `runs/<slug>/tokens.json` parses as valid JSON.
- [ ] `runs/<slug>/prototypes/` contains standalone runnable HTML prototypes with reduced-motion fallback.
- [ ] Verification script `node teamwork/verification/verify-loop2.js <slug>` exits with code 0.
- [ ] Human user has confirmed technique approval.

### Gate C Readiness
- [ ] `runs/<slug>/system/sheet.html` exists and displays tool components across states.
- [ ] `runs/<slug>/system/keyboard-walk.md` proves §15 keyboard completeness.
- [ ] `runs/<slug>/system/gaps.md` catalogs all gaps found during token construction.
- [ ] Verification script `node teamwork/verification/verify-loop3.js <slug>` exits with code 0.
- [ ] Human user has signed off on component set.
