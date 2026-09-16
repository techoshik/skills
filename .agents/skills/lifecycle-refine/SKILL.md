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

Do not abstract merely because duplication exists. Prefer an existing abstraction; create a shared abstraction only when real repeated usages represent the same responsibility and sharing reduces complexity.

Write/update `07-refine.md`.

Promote durable product/module knowledge into `docs/modules/<module>.md`. If the module document does not exist, create it from `../lifecycle/templates/module.md`; otherwise update the existing document in place. Promote process/standards learning into the appropriate permanent source. Reverify any implementation changes.

Process every Cycle Log entry, then archive the completed Cycle Log/workspace according to project policy.

Before closing the cycle, ensure worthwhile postponed product work has been transferred to `docs/backlog/`.

Do not complete until the Refine Exit gate passes. Apply the approval mode and
update `00-lifecycle.md` before archiving the lifecycle workspace.
