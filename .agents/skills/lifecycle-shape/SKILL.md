---
name: lifecycle-shape
description: "Use after Context to shape and cheaply validate the smallest correct solution."
---

## Phase Question

> **What is the smallest correct solution?**

- Use this question as the delete test for phase work and artifact content.
- Follow the shared **Decide → Work → Resolve** frame without renaming the phase-specific sections.

- Read:
  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/questioning.md`
  - `../lifecycle/references/shape.md`
  - `../lifecycle/references/verification-strategy.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`

- Load approved Define and Context.

- Explore experience, domain, states, alternatives, seams, risks, and proof deeply.
- Do not treat the first plausible solution as complete.
- Resolve solution-changing uncertainty or accept/route it explicitly.

- Use:
  - `prototype` only for material UX/state uncertainty;
  - `domain-modeling` for difficult domain concepts;
  - `codebase-design` for material seams/interfaces.

- Prototype only when it materially reduces uncertainty.
  - If needed, use `docs/lifecycle/<change>/prototype/index.html`.
  - Keep it throwaway and self-contained.
  - Record the result beside the decision it validated.
  - If not needed, do not add a placeholder section.

- Write/update `03-shape.md` using:
  - Decision
  - Solution
  - Flow
  - Model
  - Seams
  - Proof
  - Open

- Record the compressed solution, not exploration history.
- If Shape invalidates Define or Context, route back.

- Complete when the Shape gate passes.
- Apply approval mode and update `00-lifecycle.md`.
