---
name: lifecycle-build
description: "Use after Plan to implement one approved slice at a time, keep the journey runnable, and enforce guideline conformance during development."
---

## Phase Question

> **Can we implement the current slice correctly and keep it runnable?**

- Use this question as the delete test for phase work and artifact content.
- Follow the shared **Decide → Work → Resolve** frame without renaming the phase-specific sections.

- Read:
  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/build.md`
  - `../lifecycle/references/guidelines.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`

- Load:
  - active `00-lifecycle.md`;
  - approved `04-plan.md`;
  - current slice;
  - relevant Shape/Context only as needed;
  - affected module docs;
  - all applicable Engineering Guidelines before editing.

- Before editing:
  - identify affected technologies/layers/areas;
  - map applicable placement, naming, architecture, dependency, structure, and test rules;
  - inspect nearby established patterns.

- Build outside-in.
  - State/models may come just before or alongside UI.
  - Make the frontend/application journey runnable early.
  - Use controlled/fake boundaries when they accelerate feedback.
  - Implement/connect the real backend afterward.
  - Exercise the same journey again.

- Before creating important files/classes/interfaces/abstractions/folders, check applicable conventions.
- Do not invent consequential project-wide conventions silently.
- If conformance finds a rule gap, apply **Rule Promotion** in `../lifecycle/references/guidelines.md` before closing the slice.
- Keep unrelated legacy violations out unless approved; record migration debt or future work.

- Use `tdd` for meaningful behaviour when useful.
- Use `diagnosing-bugs` for difficult failures.
- Use `code-review` as an aid when useful.

- Implement one slice only.
- Run the mandatory Slice Conformance Review before closing it.
- Fix drift and rerun affected checks/journey.
- Route upstream mismatches to their owner instead of improvising.

- Write/update `05-build.md` as a compact slice ledger:
  - Status
  - Result
  - Built
  - Proof
  - Conformance
  - Deviation only when relevant

- Run the Cycle Log sweep before closing each slice.
- Start the next slice only after the current slice passes.
- Apply approval mode and update `00-lifecycle.md`.
