---
name: lifecycle-refine
description: "Run the Refine phase of the development lifecycle: process the Cycle Log, review the branch, improve reuse/architecture/standards/process, promote durable module knowledge, and close the cycle."
---

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/guidelines.md`
- `../lifecycle/references/approval.md`
- `../lifecycle/references/refine.md`
- the **complete** `../lifecycle/references/cycle-log.md` guidance
- the active lifecycle's complete `cycle-log.md`

Load the completed branch diff, Verify result, Build results, relevant permanent docs, and applicable Engineering Guidelines.

Use `improve-codebase-architecture`, `writing-for-agents`, and `code-review` when useful.

Write/update `07-refine.md`.

Run the detailed review and proposal process in
`../lifecycle/references/refine.md`. Record the Codebase Review, proposed
knowledge promotions, proposed backlog items, and proposed cleanup in
`07-refine.md`.

Ask the user to review `07-refine.md` before applying any Refine changes. Wait
for the user's decision, record it, and apply only approved code,
documentation, guideline, automation, or backlog changes. Reverify approved
implementation changes.

After approved changes pass their checks, ask whether to retain, archive, or
remove the completed lifecycle workspace. Record the choice before performing
archive/removal.

Do not complete until the Refine Exit gate passes. Apply the approval mode and
update `00-lifecycle.md` with the cleanup decision before archive/removal.
