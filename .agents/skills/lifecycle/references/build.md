# Phase 4 — Build

## Responsibility

Implement the approved Plan one small, reviewable Build Step at a time while strictly following project rules and validated decisions.

## Principles

> **Follow the plan. Follow the project. Never silently invent.**

> **UI first when meaningful UI exists.**

> **Test first when behaviour is testable.**

> **The agent may suggest beyond the Plan, but must not implement beyond the Plan without approval.**

## Preflight — Before Every Build Step

Before writing code, answer:

1. What exactly am I building?
2. What is this step's `Done When`?
3. Which project rules apply?
4. Which established implementation am I following?
5. What files/classes/components should change?
6. Is there a consequential choice I would have to guess?

If #6 is yes:

> **Stop and ask before coding.**

### Hard Gates

- Missing consequential rule → ask.
- Conflicting rules → ask.
- Missing naming/placement/structure/test convention after inspection → ask.
- New architectural decision → ask.
- Extra requirement → suggest and ask.
- Unrelated improvement → suggest; do not implement.
- Plan conflicts with project reality → stop and surface it.

Do not invent project-wide conventions.

## Build Unit

A **Build Step** is one coherent responsibility.

It may contain several tightly related files.

It must remain reviewable as one unit.

Do not build the whole feature in one giant step.

## UI-first Default

For meaningful UI work, prefer an early Build Step containing:

- UI/component(s);
- presentation state/model;
- fake/dummy/in-memory data or provider;
- relevant visible states.

Use this only when it improves early review.

Backend-only work uses the shortest relevant path.

## TDD — Hard Rule for Testable Behaviour

Use:

> **RED → GREEN → REFACTOR**

For each testable behaviour:

1. Write the failing test.
2. Run it.
3. Confirm RED.
4. Write the minimum implementation.
5. Run it.
6. Confirm GREEN.
7. Refactor.
8. Keep tests green.

Typical mapping:

- pure logic → unit test;
- use cases/repositories/controllers → unit tests;
- state transitions → state/controller tests;
- UI behaviour → widget/component tests;
- complete journeys → integration tests when justified.

Do not force meaningless tests for purely decorative details.

If test placement/naming/mock conventions are unclear:

- inspect existing examples;
- if still consequentially unclear, ask.

## Build Process

### 1. Prepare

- Read the current Plan step.
- Read its `Done When`.
- Read applicable rules.
- Inspect nearby patterns.
- Complete Preflight.

### 2. Test First

- Create the smallest useful failing test.
- Confirm RED.

### 3. Implement

- Implement only the approved Build Step.
- Follow project conventions.
- Reuse established patterns.
- Do not implement future steps early.
- Do not add unrelated refactors.

### 4. Refactor

- Improve only within the approved responsibility.
- Keep tests green.
- Do not broaden scope.

### 5. Check

Before presenting the step:

- relevant tests/checks pass;
- `Done When` passes;
- project conventions are followed;
- no unrelated code changed;
- no unapproved behaviour/architecture appeared;
- app remains compilable/runnable when practical.

### 6. Reviewability Check

Before presenting a Build Step:

- confirm it still has one primary review question;
- if implementation expanded into multiple independent responsibilities:
  - stop;
  - return to Plan;
  - split the remaining work appropriately.

If planned proof cannot be executed:

- return to Plan;
- update the Proof strategy;
- get explicit approval before continuing.

Do not silently downgrade proof inside Build.

### 7. Approval Gate

Present the completed Build Step.

Wait for explicit user approval.

Do not start the next Build Step before approval.

## Discoveries

When implementation exposes a consequential unknown:

1. state the discovery;
2. explain why it matters;
3. recommend options when useful;
4. wait for approval before implementing the choice.

Route invalidated decisions back to:

- Idea;
- Prototype;
- Plan.

## Mechanical Consequences

Do not interrupt for deterministic consequences such as:

- required imports;
- compiler-required wiring;
- obvious call-site updates;
- boilerplate governed by a clear project convention.

The gate is for consequential choices.

## Build vs Finalize

Build asks:

> **Is this Build Step correct and conforming?**

Finalize asks:

> **Does the complete change fulfil the original promise?**

## Complete When

- Every Build Step is approved.
- Every Build Step satisfies `Done When`.
- Testable behaviour used TDD.
- Relevant tests/checks pass.
- Project conventions are followed.
- No consequential unapproved decision remains.

Present Build completion.

Wait for explicit user approval before Finalize.
