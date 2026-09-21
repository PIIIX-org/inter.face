# Antigravity Workflow: Interface Art Direction

This workflow guides an Antigravity multi-agent team through the three design loops of `inter.face`.

## Prerequisite Checks
1. Ensure the workspace root is loaded.
2. Settle the surface class (page-shaped vs tool-shaped).
3. Set run directory: `runs/<slug>/`.

## Phase 1: Direction Loop
- Subagent: `direction-conductor`
- Tasks:
  - Derive 3 distinct design concepts matching TRANSLATE.md.
  - Apply ACCESS.md §13 accessibility decisions before rendering comps.
  - Dispatch `surface-designer` subagents in parallel to create coded or image comps.
  - Generate `design/board.html` linking all concepts.
- Verification:
  - Run `node teamwork/verification/verify-loop1.js <slug>`
- Human Checkpoint:
  - Present `design/board.html`
  - Await Gate A concept selection

## Phase 2: Craft Loop
- Subagent: `craft-conductor`
- Tasks:
  - Assign technique per surface satisfying the three-question test.
  - Dispatch `technique-prototyper` subagents to create standalone runnable HTML prototypes.
  - Author motion spec with reduced-motion support.
  - Complete `tokens.json`.
- Verification:
  - Run `node teamwork/verification/verify-loop2.js <slug>`
- Human Checkpoint:
  - Present prototype links and frame rate measurements
  - Await Gate B technique approval

## Phase 3: System Loop
- Subagent: `system-builder`
- Tasks:
  - Build `system/sheet.html` purely from `tokens.json` and `DIRECTION.md`.
  - Conduct keyboard walk for tool-shaped surfaces (§15).
  - Document all missing values in `system/gaps.md` (never invent values).
- Verification:
  - Run `node teamwork/verification/verify-loop3.js <slug>`
- Human Checkpoint:
  - Present `system/sheet.html` and `system/gaps.md`
  - Await Gate C sign-off
