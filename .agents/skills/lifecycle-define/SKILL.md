---
name: lifecycle-define
description: "Use before Context to decide whether work is worth doing and define its value, minimum outcome, scope, and success criteria."
---

- Read:

  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/questioning.md`
  - `../lifecycle/references/define.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`
  - `../lifecycle/references/third-party-skills.md` when deep discovery is useful

- Work only on Define concerns.
- Do not design detailed UI, data models, APIs, architecture, or code.

- Before completing `01-define.md`:
  - Run the Questioning and Decision Discovery protocol.
  - Walk the complete Define question set in rounds.
  - Continue until every consequential requirement is known, verified, accepted as an assumption/risk, or recorded as a blocker.

- Use `grill-with-docs` for every non-trivial change before accepting Define.
  - Interview the user in rounds until consequential requirement branches are resolved, accepted as risks, or recorded as blockers.
  - For very large or uncertain work, use `wayfinder` to name the destination and map the decision frontier.
  - Translate discoveries into the lifecycle Define structure; do not create a competing monolithic spec.

- For a trivial mechanical change, skip the full interview only when request, scope, acceptance, and implementation path are unambiguous.
- Record why no user questions were needed.

- Write/update `01-define.md` in the active lifecycle workspace.

- When Define ends in Defer or reduces release scope, preserve worthwhile future work in `docs/backlog/`.

- Complete only after the Define Exit gate passes.
- Apply the approval mode:
  - `guided` or `strict`: stop with `Awaiting Developer Approval`.
  - `auto`: mark the transition `Auto-approved` and continue.
