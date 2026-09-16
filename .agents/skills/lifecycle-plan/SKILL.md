---
name: lifecycle-plan
description: "Run the Plan phase of the development lifecycle: translate approved Shape into the smallest sequence of verifiable vertical implementation slices."
---

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/questioning.md`
- `../lifecycle/references/plan.md`
- `../lifecycle/references/approval.md`
- `../lifecycle/references/cycle-log.md`

Load approved Define, Context, and Shape artifacts.

Run the questioning protocol for slice boundaries, dependencies, reuse,
rollout, regression risk, and proof. Continue through dependent decision rounds
until no critical implementation question would force Build to guess.

Plan one module in one Plan file by default. Organize by Feature → Slice and use Model → UI → Backend → Connect → Verify when applicable.

Use `wayfinder` for large decision-heavy planning and `to-tickets` only when external execution tracking is useful.

Write/update `04-plan.md`.

Do not complete until the Plan Exit gate passes. In `guided` or `strict` mode,
do not start Build until the developer approves the Plan; in `auto`, mark the
transition `Auto-approved` and continue.
