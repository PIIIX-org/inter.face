# Design Spec: Google Antigravity, Gemini & /teamwork-preview Multi-Agent Execution

**Status:** Shipped (branch `gemini-antigravity`)  
**Date:** 2026-09-21  
**Author:** Antigravity / Gemini Engineering  
**System:** inter.face  

---

## 1. Context & Motivation

The `inter.face` art direction pipeline originally developed its multi-agent capabilities around Claude Code's dynamic harness features (`model: fable`, `tools: Agent`). For environments outside Claude Code, the repository included an inline execution fallback:

> *"An agent that cannot spawn subagents reads agents/*.md and works inline — same steps, same order, same reading list — at two costs: the reading lands in this context, so §3's budget becomes a manual discipline, and the checks that existed because no worker sees its neighbors become checks against your own output."*

When executed under Google Antigravity or Gemini CLI, this assumption caused Antigravity to fall back to inline execution. The consequence was severe:
1. **Context Window Saturation**: Reading the 13 reference files (6,705 lines) into the main conversation context consumes the budget needed for thoughtful aesthetic derivation.
2. **Loss of Worker Isolation**: Workers (`surface-designer`, `technique-prototyper`) could observe previous outputs and neighbor concepts, compromising the set-level distinctness check and leading to self-certification.
3. **Loss of Gate Formality**: The three human gates (Gate A, Gate B, Gate C) became blurred into conversation turns rather than stopping points with rendered artifacts.

Google Antigravity natively supports hierarchical multi-agent orchestration (`define_subagent`, `invoke_subagent`, `manage_subagents`, `send_message`) and features a dedicated autonomous team system (`/teamwork-preview`).

This specification documents the architecture and changes introduced on the permanent branch `gemini-antigravity`.

---

## 2. Antigravity Native Multi-Agent Topology

Antigravity operates a conductor-worker hierarchy with human gates held at the top level:

```text
Human User
    │
    ▼ (Interactive checkpoints via ask_question)
Main Session (Conductor & Gate Holder)
    │
    ├── Step 0: Registers subagents via define_subagent (antigravity/subagents.json)
    │
    ├── Loop 1: invoke_subagent(direction-conductor)
    │     │
    │     └── Dispatches surface-designer (in parallel, one per surface per concept)
    │     │
    │     └── Returns Gate A package: DIRECTION.md (half), comps, design/board.html
    │
    ├── [GATE A]: Halts. Human reviews design/board.html and selects concept
    │
    ├── Loop 2: invoke_subagent(craft-conductor)
    │     │
    │     └── Dispatches technique-prototyper (in parallel, one per technique)
    │     │
    │     └── Returns Gate B package: runnable HTML prototypes, tokens.json, motion spec
    │
    ├── [GATE B]: Halts. Human reviews prototypes and approves technique set
    │
    ├── Loop 3: invoke_subagent(system-builder)
    │     │
    │     └── Builds system/sheet.html strictly from tokens; runs §15 keyboard walk
    │     │
    │     └── Returns Gate C package: sheet.html, system/gaps.md, keyboard-walk.md
    │
    ├── [GATE C]: Halts. Human signs off on component set
    │
    └── Close: IMPROVE.md harvest and opt-in reporting
```

### Subagent Capabilities in Antigravity

| Subagent Name | Role | Antigravity Permissions | Model |
|---|---|---|---|
| `direction-conductor` | Loop 1 Conductor | `enable_subagent_tools: true`, `enable_write_tools: true`, `enable_mcp_tools: true` | `pro` |
| `surface-designer` | Loop 1 Worker | `enable_write_tools: true`, `enable_mcp_tools: true` | `pro` |
| `craft-conductor` | Loop 2 Conductor | `enable_subagent_tools: true`, `enable_write_tools: true`, `enable_mcp_tools: true` | `pro` |
| `technique-prototyper` | Loop 2 Worker | `enable_write_tools: true` | `pro` |
| `system-builder` | Loop 3 Worker | `enable_write_tools: true` | `pro` |
| `redesign-scout` | Brownfield Scout | `enable_write_tools: true`, `enable_mcp_tools: true` | `pro` |

Conductors are equipped with `enable_subagent_tools: true`, enabling them to spawn and supervise worker subagents directly in Antigravity.

---

## 3. Teamwork-Preview Multi-Agent Architecture

When executed under `/teamwork-preview`, the project aligns with Antigravity's autonomous teamwork methodology:

### Team Roles in Teamwork
- **Lead / Conductor**: Translates user brief, holds Gate A, B, and C with the human user using `ask_question`.
- **Implementers**: Conductor agents and workers executing derivation, prototyping, and token construction.
- **Verifiers / Auditors**: Dedicated agents running objective test scripts before advancing through gates.

### Programmatic Verification as a Forcing Function
Teamwork Principle #2 requires an objective verification mechanism independent of the implementing agent's self-assessment:
- **Gate A Verification (`teamwork/verification/verify-loop1.js`)**:
  Programmatically validates:
  - `DIRECTION.md` direction section exists.
  - At least 3 distinct concept directories in `design/`.
  - Comps exist in every concept folder.
  - `design/board.html` exists and is valid navigable HTML.
- **Gate B Verification (`teamwork/verification/verify-loop2.js`)**:
  Programmatically validates:
  - `tokens.json` parses and contains all standard token groups.
  - Standalone runnable HTML prototypes exist in `prototypes/`.
  - `@media (prefers-reduced-motion)` is implemented for all animated prototypes (§10).
  - WebGL context loss or fallback handling is present (§10).
  - `.verdict.md` files declare evidence labels (`TESTED`, `PARTIAL`, `INFERRED`).
- **Gate C Verification (`teamwork/verification/verify-loop3.js`)**:
  Programmatically validates:
  - `system/sheet.html` exists and displays components in light and dark modes.
  - `system/gaps.md` catalogs every missing token value.
  - `system/keyboard-walk.md` verifies §15 keyboard completeness on tool-shaped surfaces.
- **Master Verification Runner (`teamwork/verification/verify-all.js`)**:
  Provides an all-in-one audit runner for all three loops.

---

## 4. Antigravity Customizations (`.agents/`)

Antigravity auto-discovers customizations rooted at `.agents/`:
- `.agents/skills/inter.face/SKILL.md`: Progressive disclosure skill defining subagent registration, workflow loops, and gate protocol.
- `.agents/rules/GEMINI.md`: Contextual rules enforcing multi-agent execution and prohibiting inline fallback.
- `.agents/rules/AGENTS.md`: Router rules maintaining phase isolation.
- `.agents/plugins/inter.face/plugin.json`: Plugin manifest.
- `.agents/workflows/interface.md`: Antigravity IDE workflow definition.
- Root `GEMINI.md`: Project-level runtime guide.
