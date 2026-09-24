---
name: lifecycle-plan
description: "Use after Shape to turn the approved solution into the smallest sequence of runnable, verifiable slices."
---

## Phase Question

> **What is the safest runnable build sequence?**

- Use this question as the delete test for phase work and artifact content.
- Follow the shared **Decide → Work → Resolve** frame without renaming the phase-specific sections.

- Read:
  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/questioning.md`
  - `../lifecycle/references/plan.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`

- Load approved Shape plus only the Context/Define details needed for dependencies and success traceability.

- Plan outside-in:
  - start from the journey;
  - create state/models just before or alongside UI when needed;
  - complete the frontend/application path;
  - use a controlled/fake boundary to make the journey runnable early when useful;
  - then implement/connect the real backend;
  - exercise the same journey again.

- Do not force project layers or `Not applicable` checkpoints.
- Write only implementation groups that contain real work.
- Keep naming/folder/class conventions out of Plan; Build loads the Engineering Guidelines.

- Use `wayfinder` for large/dependency-heavy plans.
- Use `to-tickets` only when external tracking helps.

- Write/update `04-plan.md` using:
  - Decision
  - Build Order
  - Slices
  - Open

- Each user-facing slice should contain:
  - Journey
  - Build
  - Proof
  - optional Depends / Boundary / Risk

- Add a Mermaid slice dependency graph when the build order branches or has multiple proof paths. Omit it for a simple linear plan.

- Resolve critical implementation/slicing questions before Build.

- Complete when the Plan gate passes.
- Apply approval mode and update `00-lifecycle.md`.
