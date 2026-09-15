---
name: lifecycle-build
description: "Run the Build phase of the development lifecycle: implement one approved vertical slice at a time with test-first feedback, mandatory project guidelines, real verification, and slice conformance review."
---

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/build.md`
- `../lifecycle/references/guidelines.md`
- `../lifecycle/references/cycle-log.md`

Load:

- active `00-lifecycle.md`
- approved `04-plan.md`
- the current slice
- relevant Shape/Context only as needed
- applicable Engineering Guidelines under `docs/guidelines/` before editing code

Use `tdd` for meaningful behaviour where available. Use `diagnosing-bugs` for difficult failures. Use `code-review` when useful for the mandatory slice standards/spec review.

Implement one slice only. Do not start the next slice until behavioural verification and Slice Conformance Review both pass.

Write/update the slice result in `05-build.md` and update `00-lifecycle.md` current slice/status.

Perform the Cycle Log check before closing every slice.
