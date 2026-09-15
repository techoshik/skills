---
name: lifecycle-verify
description: "Run the Verify phase of the development lifecycle: prove the completed feature/module fulfills the original Define promise as an integrated whole and still conforms to applicable project guidelines."
---

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/verify.md`
- `../lifecycle/references/guidelines.md`
- `../lifecycle/references/cycle-log.md`

Load Define, Context, Shape, Plan, Build results, applicable Engineering Guidelines from `docs/guidelines/`, and the running integrated system.

Use `code-review` for independent Standards + Spec review when available. Use `diagnosing-bugs` for hard verification failures.

Write/update `06-verify.md`.

Route failures to the phase that owns them. Verification is not permission to patch around an earlier mistake.

Do not complete until the Verify Exit gate passes.
