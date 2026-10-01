# Phase 4 — Build

## Responsibility

Execute the approved Plan one small, reviewable Build Step at a time.

For each step:

> **Build → Verify → Record → Approve**

## Approval Rule

Follow the [approval gate](framework.md#approval-gate).

Before presenting a completed step, update `04-build.md`.

## Principles

> **Follow the plan. Follow the project. Never silently invent.**

> **Deliver one small, immediately testable capability at a time.**

> **Test first when behaviour is testable.**

> **The agent may suggest beyond the Plan, but must not implement beyond the Plan without approval.**

## Preflight — Before Every Build Step

Complete [Impact Preflight](completeness.md#impact-preflight).

Before writing code, answer:

1. What Build Step am I executing?
2. What does its Specification require?
3. What Build actions are approved?
4. What Verify checks are planned?
5. Which project rules apply?
6. Which established implementation am I following?
7. What files/classes/components should change?
8. Is there a consequential choice I would have to guess?

If #8 is yes:

> **Stop and ask before coding.**

### Hard Gates

- Missing consequential rule → ask.
- Consequential rule conflict → ask.
- Missing convention with consequential impact → ask.
- Ordinary local choice → use inspected patterns and implementation judgment.
- New architectural decision → ask.
- Extra requirement → suggest and ask.
- Unrelated improvement → suggest; do not implement.
- Plan conflicts with project reality → stop and surface it.

Do not invent project-wide conventions.

## Build Unit

A Build Step delivers one narrow behavior under [Small-Step Boundary](plan.md#small-step-boundary).

It may contain several tightly related files.

It must remain reviewable as one unit.

Do not build the whole feature in one giant step.

## Immediately Testable Delivery

Follow the approved [Vertical Build Step](plan.md#vertical-build-steps).

Run the step's Test Now path before presenting its outcome.

Record actual results and evidence beside that step.

When human interaction is needed, present the exact Test Now instructions.

Keep the human check pending until observed or explicitly accepted as a gap.

Do not implement a later step to make the current capability testable.

If the step depends on unfinished future work, return to Plan.

Honor explicit preview and prerequisite exceptions without claiming connected feature proof.

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

Tests must:

- Observe behavior through the relevant supported interface.
- Use expected outcomes independent of the implementation.
- Catch a plausible behavioral regression.
- Follow project fixture, mock, placement, and naming rules.

Work one behavior through RED and GREEN before starting the next.

Avoid tests that merely mirror implementation structure.

Use project-approved mocks or local substitutes at boundaries that need isolation.

Prefer real behavior at the interface under test.

A mocked integration does not prove the real service or permission boundary.

Avoid adding dependency injection or wrappers solely to follow a generic preference.

Do not force meaningless tests for purely decorative details.

If test placement/naming/mock conventions are unclear:

- inspect existing examples;
- if still consequentially unclear, ask.

## Build Process

### 1. Prepare

- Read the current Plan step.
- Read:
  - Specification;
  - Build;
  - Verify.
- Read applicable rules.
- Inspect nearby patterns.
- Complete Preflight.

### 2. Test First

For testable behaviour:

- create the smallest useful failing test;
- confirm RED.

### 3. Implement

- Execute only the current step's Build actions.
- Follow its Specification.
- Follow project conventions.
- Reuse established patterns.
- Do not implement future steps early.
- Do not add unrelated refactors.

### 4. Refactor

- Improve only within the approved responsibility.
- Keep tests green.
- Do not broaden scope.

### 5. Verify

Run every planned Verify check that can be completed now.

Apply [Proof Limits](completeness.md#proof-limits) and [Gap Acceptance](completeness.md#gap-acceptance).

Record results using [Evidence](artifacts.md#evidence):

- passed checks;
- pending human checks;
- blocked checks and their reason.

If the planned verification itself must materially change:

- return to Plan;
- update the owning `Verify` section;
- get explicit approval;
- then resume Build.

Do not silently downgrade verification.

### 6. Conformance Check

Complete [Lifecycle Code Review](code-review.md).

Before presenting the step:

- planned implementation is complete;
- applicable Verify checks pass or remain visibly pending;
- completion requires explicit acceptance of any required verification gap;
- project conventions are followed;
- no unrelated code changed;
- no unapproved behaviour/architecture appeared;
- app remains compilable/runnable when practical.

If implementation expanded into multiple independent responsibilities:

- stop;
- return to Plan;
- split the remaining work appropriately.

### 7. Record

Update `04-build.md`.

Record only actual outcome:

- Result;
- Verification;
- Code Review scope and outcome;
- Changes from Plan, only when relevant;
- Gaps, only when relevant.

Do not copy the Plan into Build.

### 8. Approval Gate

Finish implementation, Test Now verification, review, and recording for the current step only.

Keep pending checks visible under the gap acceptance rules.

Present the completed Build Step.

Wait for explicit user approval.

Do not start the next Build Step before approval.

After approval:

- start the next planned step directly;
- do not ask for another pre-step approval.

## Diagnosis

For unresolved bugs or performance regressions, use [Diagnosis](diagnosis.md).

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

## Build Artifact Purpose

`04-build.md` answers:

> **What actually happened in each completed Build Step, and what was verified?**

It is not another Plan.

Do not add planned work before it has been built.

## Build vs Finalize

Build asks:

> **Is this Build Step implemented, verified, and conforming?**

Finalize asks:

> **Does the complete branch match the approved lifecycle, and is development complete?**

## Complete When

- Every Build Step is approved.
- Every Build Step satisfies its Specification.
- Planned Build actions are complete.
- Verify checks pass or have explicitly accepted verification gaps.
- Testable behaviour used TDD.
- Project conventions are followed.
- No consequential unapproved decision remains.

Present Build completion.

Wait for explicit user approval before Finalize.
