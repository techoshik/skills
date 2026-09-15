---
name: lifecycle-define
description: "Run the Define phase of the development lifecycle: decide whether the work is worth doing and establish the minimum valuable outcome, scope, and success criteria."
---

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/define.md`
- `../lifecycle/references/approval.md`
- `../lifecycle/references/cycle-log.md`
- `../lifecycle/references/third-party-skills.md` when deep discovery is useful

Work only on Define concerns. Do not design detailed UI, data models, APIs, architecture, or code.

For unclear requirements, prefer `grill-with-docs`. For very large/high-uncertainty work, use `wayfinder` to explore the decision space. Translate discoveries into the lifecycle Define structure rather than adopting a competing monolithic spec.

Write/update `01-define.md` in the active lifecycle workspace.

When Define ends in Defer or reduces release scope, preserve worthwhile future product work in `docs/backlog/`.

Do not complete until the Define Exit gate passes. Apply the approval mode: in
`guided` or `strict`, stop with `Awaiting Developer Approval`; in `auto`, mark
the transition `Auto-approved` and continue.
