---
name: lifecycle-shape
description: "Run the Shape phase of the development lifecycle: design and cheaply validate the smallest correct experience and domain solution before technical planning."
---

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/shape.md`
- `../lifecycle/references/approval.md`
- `../lifecycle/references/cycle-log.md`

Load approved Define and Context artifacts.

Use the cheapest medium that reduces important uncertainty. Invoke `prototype`, `domain-modeling`, or `codebase-design` when useful.

When UI, responsive behaviour, or interaction states are materially uncertain,
create a lifecycle-managed prototype at
`docs/lifecycle/<change-name>/prototype/index.html`. Keep it self-contained,
responsive, clearly labelled as throwaway, and runnable by opening the file
directly; use no server, external dependency, network request, or production
application code. Use the `prototype` companion skill for the prototype's
screens and interactions. If no meaningful visual uncertainty exists, record
`Prototype: Not needed` and the reason in `03-shape.md`.

For a prototype created inside an active Lifecycle workspace, this
lifecycle-managed location, retention, and cleanup rule takes precedence over
the companion skill's generic prototype-capture convention.

Write/update `03-shape.md`.

Record the prototype path, the question it answers, the screens/states it
covers, how to open it, the developer's validation verdict, and the decisions
that implementation must carry forward. Keep the prototype available through
Plan, Build, and Verify as a reference; Refine removes it after the validated
decisions have been captured in the lifecycle or permanent documentation.

If shaping invalidates Define or Context, loop back instead of hiding the mismatch.

Do not complete until the Shape Exit gate passes. Apply the approval mode: in
`guided` or `strict`, stop with `Awaiting Developer Approval`; in `auto`, mark
the transition `Auto-approved` and continue.
