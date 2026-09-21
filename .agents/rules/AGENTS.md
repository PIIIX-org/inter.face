# Antigravity Multi-Agent Router Rules

1. Route by phase per `AGENTS.md §3`.
2. Do not read across phases.
3. In Antigravity, initialize subagents via `define_subagent` and dispatch conductors via `invoke_subagent`.
4. Conductors assemble gate packages and stop. The main session holds Gate A, Gate B, and Gate C with the human user.
5. All three gates are hard stops (§16). Never bypass a gate without explicit human decision.
