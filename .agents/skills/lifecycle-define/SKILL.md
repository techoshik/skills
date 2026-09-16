---
name: lifecycle-define
description: "Run the Define phase of the development lifecycle: decide whether the work is worth doing and establish the minimum valuable outcome, scope, and success criteria."
---

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/questioning.md`
- `../lifecycle/references/define.md`
- `../lifecycle/references/approval.md`
- `../lifecycle/references/cycle-log.md`
- `../lifecycle/references/third-party-skills.md` when deep discovery is useful

Work only on Define concerns. Do not design detailed UI, data models, APIs, architecture, or code.

Before completing `01-define.md`, run the Questioning and Decision Discovery
protocol. Walk the complete Define question set in rounds; do not stop after a
fixed number of questions or merely because the request sounds clear. Continue
until every consequential requirement is known, verified, explicitly accepted
as an assumption/risk, or recorded as a blocker.

Use `grill-with-docs` for every non-trivial change before accepting Define. It
must interview the user in rounds until consequential requirement branches are
resolved, accepted as risks, or recorded as blockers. For very
large/high-uncertainty work, use `wayfinder` to name the destination and map
the decision frontier before resolving it. Translate discoveries into the
lifecycle Define structure rather than adopting a competing monolithic spec.

For a trivial mechanical change, skip a full interview only when the request,
scope, acceptance, and implementation path are all unambiguous; record why no
user questions were needed.

Write/update `01-define.md` in the active lifecycle workspace.

When Define ends in Defer or reduces release scope, preserve worthwhile future product work in `docs/backlog/`.

Do not complete until the Define Exit gate passes. Apply the approval mode: in
`guided` or `strict`, stop with `Awaiting Developer Approval`; in `auto`, mark
the transition `Auto-approved` and continue.
