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

A Build Step is one coherent responsibility that can be:

- implemented;
- reviewed;
- independently checked.

Rules:

- several tightly related files may belong to one step;
- do not split mechanically by file;
- do not split mechanically by layer;
- do not generate the whole feature in one giant step;
- prefer early reviewable feedback.

Each step should have one primary review responsibility.

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

## UI-first Default

When meaningful UI exists:

- prefer an early Build Step with UI + presentation contract;
- use fake/dummy/in-memory data when useful;
- include relevant visible states;
- avoid premature backend integration.

Do not force backend/domain/database models into the first step unless the UI truly requires them.

When meaningful UI exists but a separate UI-first step is not appropriate:

- record one short reason in the relevant step.

Example:

```md
### Specification
- **UI-first:** Not separated.
  - Existing control depends directly on established application state.
```

Do not add this note when no meaningful UI exists.

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

Use:

```md
# Plan

## 1. <Build Step>

### Specification

- **<Requirement>:** <Short value>.

### Build
- ...

### Verify
- [ ] ...

## 2. <Build Step>

### Specification

- **<Requirement>:** <Short value>.

### Build
- ...

### Verify
- [ ] ...
```

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
- Approved requirements have complete step and check coverage.
- No consequential technical/build-sequence question remains.

Present Plan.

Wait for explicit user approval before Build.

Follow the [Build gate](framework.md#build-gate).
