---
name: lifecycle-context
description: "Use after Define to gather the minimum existing-system context that constrains the change."
---

## Phase Question

> **What existing reality must this change respect?**

- Use this question as the delete test for phase work and artifact content.
- Follow the shared **Decide → Work → Resolve** frame without renaming the phase-specific sections.

- Read:
  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/questioning.md`
  - `../lifecycle/references/context.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`

- Load approved Define plus relevant permanent module docs, code, configuration, and tests.

- Investigate **Global → Module → Feature**, but do not use that as the artifact structure.
- For every affected module:
  - read `docs/modules/<module>.md` when it exists;
  - record the path or missing-doc gap in `02-context.md`.

- Find repository/system facts yourself.
- Ask the user only for product authority/decisions the environment cannot answer.
- Use `research` or `domain-modeling` when useful.
- Do not rerun general `grill-with-docs` by default.

- Write/update `02-context.md` using:
  - Decision
  - Affected
  - Current
  - Reuse
  - Constraints
  - Verification
  - Open

- Record only change-relevant facts.
- Put evidence beside the claim when needed.

- If reality invalidates Define:
  - block Context;
  - return to Define;
  - do not silently adapt the requirement.

- Complete when the Context gate passes.
- Apply approval mode and update `00-lifecycle.md`.
