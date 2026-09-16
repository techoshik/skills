---
name: lifecycle-context
description: "Run the Context phase of the development lifecycle: gather the minimum sufficient Global → Module → Feature understanding needed to shape the change correctly."
---

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/questioning.md`
- `../lifecycle/references/context.md`
- `../lifecycle/references/approval.md`
- `../lifecycle/references/cycle-log.md`

Load the approved Define artifact and relevant permanent module docs/code. For
every bug fix, existing-functionality change, or new functionality, identify
the affected modules and read each existing `docs/modules/<module>.md` before
completing Context. Record the paths read and any missing module document in
`02-context.md`. Gather only context that improves decision quality.

Run the questioning protocol for context decisions that could change the
solution. Find repository and system facts yourself; ask the user only for
product authority, priorities, or decisions that the environment cannot answer.
Do not proceed while a consequential context gap is silently being treated as
fact.

Use `research` or `domain-modeling` when helpful, but keep lifecycle Context authoritative.

Write/update `02-context.md`.

If discovered reality invalidates Define, return to Define rather than silently adapting the solution.

Do not complete until the Context Exit gate passes. Apply the approval mode and
update `00-lifecycle.md` before handing off to Shape.
