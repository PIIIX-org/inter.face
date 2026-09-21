# Google Antigravity & Gemini Runtime Guide for inter.face

This file defines the runtime guidelines for executing the **inter.face** design pipeline within **Google Antigravity** and the **Gemini** agent ecosystem.

## 1. Multi-Agent Execution Mandate

The inter.face pipeline is strictly a **multi-agent system**. The 13 reference files total 6,705 lines. An agent that reads the entire corpus inline in the main conversation session spends the context budget needed for architectural decisions and compromises worker isolation.

**In Google Antigravity, NEVER run the pipeline inline.**

Antigravity natively provides subagent lifecycle management:
- Subagent definition: `define_subagent`
- Subagent dispatch: `invoke_subagent`
- Background orchestration: `manage_subagents` and messaging
- Interactive human gates: `ask_question`

All conductors and workers must run in dedicated, isolated subagents.

---

## 2. Model & Tool Mapping

| Claude Artifact / Convention | Antigravity / Gemini Mapping | Notes |
|---|---|---|
| `model: fable` (`claude-fable-5`) | `pro` or `inherit` (Gemini Pro) | High-reasoning model for aesthetic derivation and judgment |
| `tools: Agent` | `define_subagent` + `invoke_subagent` | Conductor agents must have `enable_subagent_tools: true` |
| `tools: Bash, Read, Write` | `run_command`, `view_file`, `write_to_file`, `replace_file_content` | Standard file and command execution tools |
| `mcp__pollinations...` / image tools | Antigravity `generate_image`, Higgsfield AI skills, or Antigravity MCP | Image mode comp generation |
| Human gate review | Antigravity `ask_question` + rendered HTML artifacts (`design/board.html`, `system/sheet.html`) | Hard rule §16 enforcement |

---

## 3. The Multi-Agent Pipeline Flow

```text
Main Session (Conductor / Gate Holder)
  ├── 1. Register subagents via define_subagent (from antigravity/subagents.json)
  ├── 2. Settle surface class (page-shaped vs tool-shaped) & collect inbox
  ├── 3. Dispatch direction-conductor via invoke_subagent
  │        └── direction-conductor dispatches surface-designer (in parallel)
  ├── 4. [Gate A] Main session presents design/board.html → ask_question (Human picks concept)
  ├── 5. Dispatch craft-conductor via invoke_subagent
  │        └── craft-conductor dispatches technique-prototyper (in parallel)
  ├── 6. [Gate B] Main session presents prototypes → ask_question (Human approves technique set)
  ├── 7. Dispatch system-builder via invoke_subagent
  ├── 8. [Gate C] Main session presents system/sheet.html & gaps → ask_question (Human signs off)
  └── 9. Close run through IMPROVE.md
```

---

## 4. The Three Hard Rules in Antigravity

1. **§10 Accessible by Default**: Decided in Loop 1 before any comp is drafted. Contrast ratios checked against WCAG AA standards. Designed reduced-motion state for all animations.
2. **§15 Keyboard Completeness**: Hard constraint on tool-shaped surfaces. Every workflow walkable by keyboard alone, verified on the component sheet.
3. **§16 Human Gates are Real Stops**: Under no circumstances may an agent self-certify past Gate A, Gate B, or Gate C. The main session must halt, present the package, and receive an explicit decision from the human user.

---

## 5. Installation & Verification Report

For full setup details, verification logs, and environment confirmation across sessions, refer to [`docs/ANTIGRAVITY-INSTALLATION.md`](./docs/ANTIGRAVITY-INSTALLATION.md).
