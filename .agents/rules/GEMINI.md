# Antigravity Rules for inter.face

When operating within this repository:

1. **Multi-Agent Runtime**: The inter.face design pipeline must run with isolated subagents. Do not read the reference files into the main conversation context.
2. **Subagents**: Register `direction-conductor`, `surface-designer`, `craft-conductor`, `technique-prototyper`, `system-builder`, and `redesign-scout` using `define_subagent` from the definitions in `antigravity/subagents.json`.
3. **Dispatch**: Conductors must be dispatched via `invoke_subagent`. Conductors have `enable_subagent_tools: true` so they can dispatch worker subagents concurrently.
4. **Gates**: Gate A, Gate B, and Gate C are real human stops (§16). The main session must halt execution at each gate, display the artifact links, and await user decision via `ask_question` or interactive input.
5. **Verification**: When running under teamwork or automated loops, execute the verification test scripts in `teamwork/verification/` to ensure objective verification of deliverables before presenting gates.
