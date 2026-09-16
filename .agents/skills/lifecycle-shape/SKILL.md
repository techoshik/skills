---
name: lifecycle-shape
description: "Use after Context to shape and cheaply validate the smallest correct experience and domain solution."
---

- Read:

  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/questioning.md`
  - `../lifecycle/references/shape.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`

- Load approved Define and Context artifacts.

- Run the questioning protocol for experience, domain, state, alternative, and validation decisions.
- Ask in rounds until solution-changing uncertainty is resolved or accepted as a risk.
- Do not treat a plausible first solution as a complete Shape.

- Use the cheapest medium that reduces important uncertainty.
- Invoke `prototype`, `domain-modeling`, or `codebase-design` when useful.

- When UI, responsive behaviour, or interaction states are materially uncertain:
  - Create `docs/lifecycle/<change-name>/prototype/index.html`.
  - Keep it self-contained, responsive, clearly labelled as throwaway, and runnable by opening it directly.
  - Use no server, external dependency, network request, or production application code.
  - Use the `prototype` companion skill for its screens and interactions.
- If no meaningful visual uncertainty exists, record `Prototype: Not needed` and the reason in `03-shape.md`.

- For a prototype inside an active Lifecycle workspace, follow the lifecycle-managed location, retention, and cleanup rule.
- This rule takes precedence over the companion skill's generic capture convention.

- Write/update `03-shape.md`.

- Record the prototype path, question, covered screens/states, run instructions, validation verdict, and implementation decisions.
- Keep the prototype available through Plan, Build, and Verify.
- Refine removes it after its validated decisions are captured in lifecycle or permanent documentation.

- If shaping invalidates Define or Context, loop back.
- Do not hide the mismatch.

- Complete only after the Shape Exit gate passes.
- Apply the approval mode:
  - `guided` or `strict`: stop with `Awaiting Developer Approval`.
  - `auto`: mark the transition `Auto-approved` and continue.
