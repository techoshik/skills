---
name: lifecycle-context
description: "Use after Define to gather the minimum Global → Module → Feature context needed to shape the change correctly."
---

- Read:

  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/questioning.md`
  - `../lifecycle/references/context.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`

- Load the approved Define artifact and relevant permanent module docs and code.
- For every bug fix, existing-functionality change, or new functionality:
  - Identify the affected modules.
  - Read each existing `docs/modules/<module>.md` before completing Context.
  - Record the paths read and any missing module document in `02-context.md`.
- Gather only context that improves decision quality.

- Run the questioning protocol for context decisions that could change the solution.
- Find repository and system facts yourself.
- Ask the user only for product authority, priorities, or decisions the environment cannot answer.
- Record consequential context gaps instead of treating them as facts.

- Use `research` or `domain-modeling` when helpful.
- Keep lifecycle Context authoritative.

- Write/update `02-context.md`.

- If discovered reality invalidates Define, return to Define.
- Do not silently adapt the solution.

- Complete only after the Context Exit gate passes.
- Apply the approval mode.
- Update `00-lifecycle.md` before handing off to Shape.
