---
name: lifecycle-plan
description: "Use after Idea/Prototype to inspect the existing project and create small reviewable Build Steps, each with its own Specification, Build actions, and Verify checks."
---

# Plan

## Phase Question

> **How exactly will we build and verify this change in the existing system?**

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/artifacts.md`
- `../lifecycle/references/plan.md`
- `../lifecycle/references/guidelines.md`
- `../lifecycle/references/cycle-log.md`

Before presenting a document, complete the [required compactness pass](../lifecycle/references/artifacts.md#required-compactness-pass).

Load:

- approved `01-idea.md`;
- approved/not-needed `02-prototype.md`;
- only relevant project sources.

First understand the existing system:

- inspect code/docs/config/tests/guidelines;
- discover reuse, constraints, dependencies, patterns.

Apply [Minimum Complete Solution](../lifecycle/references/completeness.md#minimum-complete-solution).

Then create small reviewable Build Steps.

For every Build Step use:

> **Specification → Build → Verify**

- **Specification**
  - what must be true when this step is complete;
  - keep each technical truth with one owning step;
  - reference earlier steps instead of duplicating rules.
- **Build**
  - concrete implementation actions;
  - one action per line.
- **Verify**
  - concrete checks that establish the step;
  - one check per line;
  - choose the cheapest trustworthy verification.

Do not create:

- a separate Context artifact;
- a top-level Specification section;
- a top-level Proof/Verification Plan section;
- a separate Build Plan heading;
- a `Review` subsection.

When meaningful UI exists:

- prefer an early UI + presentation-state Build Step;
- use fake/dummy data when useful.

If meaningful UI is not separated:

- record one short reason in the relevant step.

Do not hard-code a universal layer order.

Ask the user only for consequential choices/trade-offs not resolved by:

- approved decisions;
- project facts;
- established rules.

If planning invalidates behaviour:

- return to Prototype.

If planning invalidates Goal/Key Results:

- return to Idea.

Complete [Requirement Coverage](../lifecycle/references/completeness.md#requirement-coverage).

Run the Cycle Log sweep.

Update `00-lifecycle.md`.

Present the Plan.

Apply the [approval gate](../lifecycle/references/framework.md#approval-gate).
