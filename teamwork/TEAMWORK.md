# Running inter.face under Google Antigravity /teamwork-preview

This document provides the complete architecture and operational runbook for executing the **inter.face** design pipeline using Antigravity's multi-agent **/teamwork-preview** system.

---

## 1. Architectural Alignment

Claude Code relied on dynamic subagent spawning via single agent tools. In Google Antigravity, multi-agent collaboration reaches full strength through `/teamwork-preview` — an autonomous multi-agent teamwork architecture featuring dedicated implementers, adversarial verifiers, and objective criteria guardrails.

The inter.face pipeline maps cleanly into the teamwork system:

| inter.face Concept | Teamwork Equivalent | Role & Behavior |
|---|---|---|
| Main Session Conductor | Team Lead / Conductor | Holds human gates (Gate A, B, C), manages human interaction via `ask_question` |
| Direction Conductor | Lead Visual Implementer | Derives 3 concepts, checks distinctness, creates `design/board.html` |
| Surface Designers | Parallel Comp Workers | Generates individual surface comps across concepts |
| Craft Conductor | Craft & Motion Lead | Selects techniques, authors motion specs, completes `tokens.json` |
| Technique Prototypers | Parallel Prototypers | Builds standalone runnable HTML prototypes, measures frame rates |
| System Builder | System Implementer | Builds `system/sheet.html`, walks keyboard, catalogs gaps in `system/gaps.md` |
| Gates (A, B, C) | Teamwork Gates | Hard human decision stops (§16); cannot be self-certified |
| Phase Checks | Objective Verifiers | Automated verification suites in `teamwork/verification/` |

---

## 2. The Verification Forcing Function

In teamwork-preview, agents must never self-certify their own work. Programmatic verification scripts act as an objective forcing function, requiring iterative build-test-debug cycles before deliverables are presented to the human:

1. **Gate A Verification (`teamwork/verification/verify-loop1.js`)**:
   - Verifies `DIRECTION.md` direction section exists.
   - Asserts at least 3 distinct concept directories in `design/`.
   - Asserts comps exist in each concept.
   - Asserts `design/board.html` exists and contains valid navigable markup.
   - Validates surface class settlement in `TRANSLATE.md`.

2. **Gate B Verification (`teamwork/verification/verify-loop2.js`)**:
   - Validates `tokens.json` parses and contains standard token groups.
   - Asserts standalone runnable `.html` files in `prototypes/`.
   - Audits `@media (prefers-reduced-motion)` implementations (§10).
   - Audits WebGL fallback and context-loss handling (§10).
   - Verifies technique verdict files with evidence labels.

3. **Gate C Verification (`teamwork/verification/verify-loop3.js`)**:
   - Asserts `system/sheet.html` exists and displays components in light and dark modes.
   - Verifies `system/gaps.md` documents all values not present in `tokens.json`.
   - If tool-shaped: Asserts `system/keyboard-walk.md` proves §15 keyboard completeness.

---

## 3. Teamwork Execution Flow

```text
1. Prompt Crafting
   └── Define requirements (R1, R2, R3) and acceptance criteria
   └── Settle surface class (page-shaped vs tool-shaped)
   └── Delegate to teamwork_preview via invoke_subagent

2. Loop 1 (Direction)
   ├── Teamwork implementers generate 3 concept directions + comps
   ├── Verifier runs: node teamwork/verification/verify-loop1.js <slug>
   └── GATE A: Team pauses. Human selects winning concept via ask_question

3. Loop 2 (Craft)
   ├── Teamwork implementers build runnable HTML prototypes + tokens.json
   ├── Verifier runs: node teamwork/verification/verify-loop2.js <slug>
   └── GATE B: Team pauses. Human approves technique set via ask_question

4. Loop 3 (System)
   ├── Teamwork implementers build sheet.html strictly from tokens
   ├── Verifier runs: node teamwork/verification/verify-loop3.js <slug>
   └── GATE C: Team pauses. Human signs off on component set via ask_question

5. Close Run
   └── Findings presented per IMPROVE.md
```

---

## 4. Prompt Templates

Pre-structured prompt templates calibrated for Antigravity's `/teamwork-preview` are located in `teamwork/prompts/`:
- `page-shaped.prompt.md`: Optimized for marketing, landing pages, and campaign surfaces.
- `tool-shaped.prompt.md`: Optimized for consoles, dashboards, and internal tools with §15 keyboard completeness.
- `redesign.prompt.md`: Optimized for brownfield extractions with scout phase.
