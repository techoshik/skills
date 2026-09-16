---
name: lifecycle-verify
description: "Run the Verify phase of the development lifecycle: prove the completed feature/module fulfills the original Define promise as an integrated whole and still conforms to applicable project guidelines."
---

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/questioning.md`
- `../lifecycle/references/verify.md`
- `../lifecycle/references/guidelines.md`
- `../lifecycle/references/approval.md`
- `../lifecycle/references/cycle-log.md`

Load Define, Context, Shape, Plan, Build results, applicable Engineering Guidelines from `docs/guidelines/`, and the running integrated system.

Use `code-review` for independent Guidelines + Spec review. Use `diagnosing-bugs` for hard verification failures.

Use the questioning protocol when acceptance, expected behaviour, or a
regression boundary is ambiguous. Route unresolved requirement or solution
decisions back to Define or Shape rather than silently choosing an answer.

Write/update `06-verify.md`.

Route failures to the phase that owns them. Verification is not permission to patch around an earlier mistake.

Do not complete until the Verify Exit gate passes. In `guided` or `strict` mode,
stop with `Awaiting Developer Approval` before Refine or cycle closure; in
`auto`, mark the transition `Auto-approved` and continue.
