# Phase 3 — Plan

## Responsibility

Understand the existing system and create the safest reviewable build sequence.

Each Build Step owns:

> **Specification → Build → Verify**

## Principle

> **Plan by reviewable responsibility, not by document section or file.**

## 1. Understand

- Read Idea and Prototype.
- Inspect relevant:
  - code;
  - module docs;
  - configuration;
  - tests;
  - project rules;
  - integrations;
  - dependencies.
- Find reuse, constraints, and established patterns.
- Apply [Minimum Complete Solution](completeness.md#minimum-complete-solution).
- Do not create a separate Context artifact.
- Record project facts only when they affect a Build Step.

## Research and Design

When a step depends on external technical facts:

- Consult primary sources: official docs, source code, specifications, or first-party APIs.
- Check facts against the relevant version and environment.
- Link each consequential conclusion to its supporting source.
- Distinguish source facts from inference and assumptions.
- Record only findings that change the design, scope, risk, or verification.

When designing or restructuring an interface:

- Keep caller requirements small and explicit.
- Keep responsibility with its existing owner where practical.
- Hide internal complexity without adding unnecessary indirection.
- Add abstractions only for an approved need or applicable project rule.
- Choose a testing boundary that observes the required behavior.

Plan approval includes the step's testing boundary.

Do not ask for a second approval of the same settled choice.

## 2. Create Build Steps

A Build Step delivers one narrow behavior using [Vertical Build Steps](#vertical-build-steps).

It must be:

- implemented;
- reviewed;
- independently checked.

Rules:

- several tightly related files may belong to one step;
- do not split mechanically by file;
- do not split mechanically by layer;
- do not generate the whole feature in one giant step;
- prefer early reviewable feedback.

Each capability step must have one independently exercisable user or caller outcome.

If independently judging the step requires several unrelated responsibilities:

- split the step.

## 3. Specification

Inside each Build Step, `Specification` states:

> **What must be true when this step is complete?**

Include only technical truth Build needs without guessing.

Examples:

- ownership/responsibility;
- state/data behaviour;
- flows/interactions;
- interfaces/contracts;
- important edge cases;
- required compatibility;
- established reuse.

A specification has one owner.

If a later step depends on a rule established earlier:

- reference the owning step;
- do not repeat the same specification.

Specification is not a task list.

Use the [Specification example](artifacts.md#specification-example) for its writing format.

## 4. Build

Inside each Build Step, `Build` states:

> **What must the agent change?**

Rules:

- one action per line;
- use short bullets;
- keep tightly related actions in the same step;
- do not bury several changes in one sentence.

Use optional `Deferred`, `Depends`, or `Risk` only when they materially help execution.

## 5. Verify

Inside each Build Step, `Verify` states:

> **How will we know this step is correct?**

Rules:

- one check per line;
- make each check concrete;
- prefer observable outcomes;
- choose the cheapest trustworthy verification;
- use tests, static checks, measurements, or human verification as appropriate.

Examples:

- pure behaviour → unit test;
- state/UI behaviour → widget/component test;
- cross-layer contract → integration test;
- complete journey → integration/end-to-end test when justified;
- visual/experience behaviour → human verification;
- performance → measurement against an agreed threshold.

Do not use weaker evidence when it cannot establish the claim.

These checks become inputs to:

- Build Step verification;
- Finalize's complete verification checklist.

## Vertical Build Steps

Default to one small, complete capability per Build Step.

- State the observable outcome before listing implementation work.
- Include every layer required to exercise that outcome.
- Include applicable authorization and failure handling.
- Make the capability runnable without implementing a later step.
- For app features, verify through the application with connected development services.
- For backend or tooling work, verify through its supported API or command.
- Reuse capabilities completed in earlier approved steps.
- Reduce supported scope when a slice is too large.
- Preserve a complete journey within that reduced scope.

### Small-Step Boundary

- One step delivers one narrowly stated behavior.
- A shared screen, module, or deadline does not justify bundling capabilities.
- If behaviors can be exercised and accepted separately, split them into separate steps.
- Keep only cross-layer work needed for the current behavior.
- Add later behaviors through later approved steps.
- Split steps whose review requires several independent test journeys.
- Do not bundle work to reduce step count or finish coding faster.

Related failure and authorization cases belong with the behavior they protect.

There is no target or maximum number of steps.

Prefer many small testable steps over fewer steps with delayed verification.

Backend → rules → UI is a layer sequence, not a default capability sequence.

### Explicit Exceptions

- **UI Preview:** Fake data may support an interaction review.
- **Prerequisite:** Unavoidable technical groundwork may enable a later capability.

For either exception, record:

- step type;
- why it cannot sensibly be part of a complete capability;
- what is testable now;
- what remains unavailable;
- the capability step that completes the connection.

A preview does not prove connected behavior or authorization.

A prerequisite does not count as delivery of the later capability.

Plan approval must explicitly include these exceptions.

### Test Now

Inside each step's Verify section, provide:

- **Setup:** Actor, permissions, fixtures, and development environment needed.
- **Open / Run:** Exact entry point or command.
- **Action:** What the reviewer does.
- **Expected:** Observable outcome.
- **Checks:** Applicable denial, failure, and automated checks.

Provision the required environment or fixtures within this step or an already approved prerequisite.

Keep instructions beside the step; do not defer them to Finalize.

Static checks alone do not establish an app-testable capability.

Before presenting Plan, ask for every step:

> Can the user exercise this stated outcome before any later step is built?

If no, split by a smaller capability or identify an explicit exception.

Example sequence:

- **View team:** Connected list with assigned-shop access enforcement.
- **Change password:** Permitted password change with error handling.
- **Edit user:** Save supported edits and observe the result.
- **Remove access:** Remove membership and verify access revocation.

## Verification Changes During Build

If a planned `Verify` check becomes impossible or materially different:

- stop before treating the affected step as complete;
- return to Plan;
- update that step's `Verify`;
- record:
  - unavailable check;
  - reason;
  - substitute check, if any;
  - remaining gap.
- present the updated Plan;
- wait for explicit user approval;
- then resume Build.

Never silently replace planned verification with weaker evidence.

## Artifact

Use [the Plan template](../templates/03-plan.md).

Add optional subsections only when useful.

Add `## Open Questions` only while consequential planning questions remain.

Remove it when they are resolved.

## Proposed Additions

Apply the [Why Loop](questioning.md#why-loop) to consequential additions discovered during planning.

Route scope or behavior changes to their owning phase before approval.

## Coverage Check

Before presenting Plan, apply [Requirement Coverage](completeness.md#requirement-coverage).

## Complete When

- Existing-system constraints are understood.
- Build order is clear.
- Every Build Step is one reviewable responsibility.
- Every Build Step has a clear Specification.
- Every Build Step has readable Build actions.
- Every Build Step has concrete Verify checks.
- Every step has a Test Now path.
- Capability steps are runnable before later steps are built.
- Preview and prerequisite exceptions are explicit.
- Approved requirements have complete step and check coverage.
- No consequential technical/build-sequence question remains.

Present Plan.

Wait for explicit user approval before Build.

Follow the [Build gate](framework.md#build-gate).
