---
name: lifecycle-build
description: "Use after Plan to implement approved vertical slices with tests, guideline conformance, and real verification."
---

- Read:

  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/questioning.md`
  - `../lifecycle/references/build.md`
  - `../lifecycle/references/guidelines.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`

- Load:

  - active `00-lifecycle.md`
  - approved `04-plan.md`
  - the current slice
  - relevant Shape/Context only as needed
  - canonical module documents for affected modules under `docs/modules/<module>.md`; confirm they were read during Context before editing code
  - applicable Engineering Guidelines under `docs/guidelines/` before editing code

- Use `tdd` for meaningful behaviour where available.
- Use `diagnosing-bugs` for difficult failures.
- Use `code-review` for the mandatory slice standards/spec review when useful.

- Use the questioning protocol for slice mismatches or implementation uncertainty.
- Ask the user when a decision is needed.
- Route earlier-phase uncertainty back to its owner instead of guessing.

- Implement one slice only.
- Start the next slice only after behavioural verification and Slice Conformance Review pass.

- Write/update the slice result in `05-build.md`.
- Update the current slice/status in `00-lifecycle.md`.

- Perform the Cycle Log check before closing every slice.

- Apply the approval mode after each slice.
  - `strict`: stop for approval.
  - `guided`: continue within the approved Plan unless a deviation is discovered.
  - `auto`: continue without a phase-approval prompt.
