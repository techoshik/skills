---
name: lifecycle-plan
description: "Use after Shape to turn the approved solution into the smallest sequence of verifiable vertical slices."
---

- Read:

  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/questioning.md`
  - `../lifecycle/references/plan.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`

- Load approved Define, Context, and Shape artifacts.

- Run the questioning protocol for slice boundaries, dependencies, reuse, rollout, regression risk, and proof.
- Continue through dependent decision rounds until no critical implementation question would force Build to guess.

- Plan one module in one Plan file by default.
- Organize by Feature → Slice.
- Use Model → UI → Backend → Connect → Verify when applicable.

- Use `wayfinder` for large, decision-heavy planning.
- Use `to-tickets` only when external execution tracking is useful.

- Write/update `04-plan.md`.

- Complete only after the Plan Exit gate passes.
- In `guided` or `strict` mode, wait for developer approval before Build.
- In `auto`, mark the transition `Auto-approved` and continue.
