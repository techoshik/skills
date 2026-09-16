---
name: lifecycle-verify
description: "Use after Build to prove the completed feature fulfills Define and conforms to project guidelines."
---

- Read:

  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/questioning.md`
  - `../lifecycle/references/verify.md`
  - `../lifecycle/references/guidelines.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`

- Load Define, Context, Shape, Plan, and Build results.
- Load applicable Engineering Guidelines from `docs/guidelines/`.
- Use the running integrated system.

- Use `code-review` for independent Guidelines + Spec review.
- Use `diagnosing-bugs` for hard verification failures.

- Use the questioning protocol when acceptance, expected behaviour, or a regression boundary is ambiguous.
- Route unresolved requirement or solution decisions back to Define or Shape.

- Write/update `06-verify.md`.

- Route failures to the phase that owns them.
- Do not use verification to patch around an earlier mistake.

- Complete only after the Verify Exit gate passes.
- In `guided` or `strict` mode, stop with `Awaiting Developer Approval` before Refine or cycle closure.
- In `auto`, mark the transition `Auto-approved` and continue.
