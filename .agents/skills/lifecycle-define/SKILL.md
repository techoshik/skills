---
name: lifecycle-define
description: "Use before Context to decide whether work is worth doing and define its value, minimum outcome, boundaries, rules, and success."
---

## Phase Question

> **What change is worth making and why?**

- Use this question as the delete test for phase work and artifact content.
- Follow the shared **Decide → Work → Resolve** frame without renaming the phase-specific sections.

- Read:
  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/questioning.md`
  - `../lifecycle/references/define.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`
  - `../lifecycle/references/third-party-skills.md`

- Work only on Define concerns.
- Do not design detailed UI, data models, APIs, architecture, storage, or code.

- For non-trivial work:
  - run the questioning protocol;
  - use `grill-with-docs`;
  - use `wayfinder` only when the decision tree is large/foggy.

- Resolve only Define-owned uncertainty.
- Classify later-phase uncertainty as Assumption / Question / Research / Blocker with `Resolve: <phase>` when useful.
- Never invent answers merely to complete the artifact.

- Write/update `01-define.md` using:
  - Decision
  - Problem
  - Outcome
  - Boundaries
  - Rules
  - Success
  - Open

- Record conclusions, not question history.

- When a worthwhile idea is deferred, keep it as temporary context for Refine; Refine transfers durable future work to the affected module document.

- Complete when the Define gate in `../lifecycle/references/define.md` passes.
- Apply approval mode and update `00-lifecycle.md`.
