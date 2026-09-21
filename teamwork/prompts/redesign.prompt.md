# Teamwork Project Prompt: Interface Redesign & Art Direction

Execute an art direction and system redesign run for an existing live interface.
This project begins with an automated brownfield extraction (scout phase) and proceeds through the three design loops.
Deliverables include CURRENT.md, DIRECTION.md, tokens.json, comps, a navigable board, measured prototypes, and a component sheet.

Working directory: runs/<slug>
Integrity mode: development

## Requirements

### R1. Brownfield Extraction and Proposed Fork (Scout Phase)
Inspect the live rendered surface in headless browser.
Measure shipped styles, typography, actual color usage frequency, touch target compliance, and performance metrics.
Write the measured findings into `CURRENT.md` without subjective adjudication.
Propose a classification fork: correction path, reposition path, or design system conformance path.
Present findings and proposed fork to the human user; human selects the path.

### R2. Direction Loop and Navigable Board (Gate A)
Derive three visual design concepts aligned with the chosen fork and brief.
Enforce §10 accessibility upfront with WCAG AA contrast validation.
Generate comps for each concept and compile them into `design/board.html`.
Present Gate A package to the human user and await concept selection.

### R3. Craft Prototyping and Tokens (Gate B)
Assign techniques serving the selected concept against the three-question test.
Build standalone runnable HTML prototypes in `prototypes/`.
Include explicit `@media (prefers-reduced-motion)` fallback styling.
Generate `tokens.json` capturing complete design tokens.
Present Gate B package to the human user and await approval.

### R4. Component Sheet and Gap Report (Gate C)
Assemble a navigable component sheet in `system/sheet.html` strictly from tokens.
Document any missing tokens in `system/gaps.md`.
If tool-shaped, verify §15 keyboard completeness in `system/keyboard-walk.md`.
Present Gate C package to the human user and await sign-off.

## Acceptance Criteria

### Scout Readiness
- [ ] `runs/<slug>/CURRENT.md` exists with measured values from the live interface.
- [ ] Classification fork is documented with clear trade-offs.
- [ ] Human user has chosen the redesign path.

### Gate A Readiness
- [ ] `runs/<slug>/DIRECTION.md` contains concept direction sections.
- [ ] `runs/<slug>/design/board.html` exists and links to all concept comps.
- [ ] Verification script `node teamwork/verification/verify-loop1.js <slug>` exits with code 0.
- [ ] Human user has confirmed concept choice.

### Gate B Readiness
- [ ] `runs/<slug>/tokens.json` parses as valid JSON.
- [ ] `runs/<slug>/prototypes/` contains standalone runnable HTML prototypes.
- [ ] Verification script `node teamwork/verification/verify-loop2.js <slug>` exits with code 0.
- [ ] Human user has confirmed technique approval.

### Gate C Readiness
- [ ] `runs/<slug>/system/sheet.html` exists and displays components in light and dark modes.
- [ ] `runs/<slug>/system/gaps.md` catalogs all gaps found during token construction.
- [ ] Verification script `node teamwork/verification/verify-loop3.js <slug>` exits with code 0.
- [ ] Human user has signed off on component set.
