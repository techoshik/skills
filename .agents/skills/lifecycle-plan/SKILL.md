---
name: lifecycle-plan
description: "Use after Idea/Prototype to inspect the existing project, specify the technical solution, choose proof, and create small reviewable Build Steps."
---

# Plan

## Phase Question

> **How exactly will we build and prove this correctly in the existing system?**

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/artifacts.md`
- `../lifecycle/references/plan.md`
- `../lifecycle/references/guidelines.md`
- `../lifecycle/references/cycle-log.md`
- `../lifecycle/references/companion-skills.md`

Load:

- approved `01-idea.md`;
- approved/not-needed `02-prototype.md`;
- only relevant project sources.

Use:

> **Understand → Specify → Prove → Plan**

- **Understand**
  - inspect code/docs/config/tests/guidelines;
  - discover reuse, constraints, dependencies, patterns.
- **Specify**
  - define the technical result.
- **Prove**
  - choose the cheapest trustworthy proof;
  - record real proof gaps.
- **Plan**
  - create small reviewable Build Steps;
  - give each step `Done When`.

Do not create a separate Context artifact.

Do not repeat product decisions owned by Idea/Prototype.

When meaningful UI exists:

- prefer an early UI + presentation-state Build Step;
- use fake/dummy data when useful.

Do not hard-code a universal layer order.

Ask the user only for consequential choices/trade-offs not resolved by:

- approved decisions;
- project facts;
- established rules.

If planning invalidates behaviour:

- return to Prototype.

If planning invalidates Goal/Key Results:

- return to Idea.

Run the Cycle Log sweep.

Update `00-lifecycle.md`.

Present the Plan.

Wait for explicit user approval before Build.
