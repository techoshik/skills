# Plan

Inspect the existing system and define the smallest safe sequence of reviewable delivery.

## Required reading

Read [Project Rules](guidelines.md) and [Coverage and Completion](completeness.md).

- **Approved input**
  - Idea: What Will Change, Expected Outcomes, and relevant decisions.
  - Existing cycles: Key Results remain the earlier acceptance source.
  - Prototype: approved decisions or approved Not needed verdict.
- **Project context:** Relevant code, docs, config, tests, dependencies, and integrations.

## Research and design

Record only facts affecting design, sequence, risk, or proof. For external technical dependencies, use primary docs/source/specifications for the relevant version and environment; link consequential findings and separate fact from inference.

Keep caller requirements explicit, responsibility with its owner, and internal complexity hidden. Add abstraction only for an approved need or project rule. Plan approval includes the testing boundary; no second approval is needed for that settled choice.

## Vertical Build Steps

Each step delivers one narrow observable user/caller outcome through all necessary layers, including applicable access and failure handling. Split independently exercisable capabilities even when they share a screen/module. Reduce scope while preserving a complete supported journey; reuse earlier approved capabilities.

### Small-step boundary

The outcome must be runnable before later steps exist. A step may touch several tightly related files; splitting by file or layer is not the default. Multiple independent test journeys signal a split. Keep related denial/failure cases with the behavior they protect. There is no target step count.

### Explicit exceptions

A UI Preview may use fake data; an unavoidable Prerequisite may enable later delivery. For either, record Type, Reason, Testable Now, Unavailable, and Enables (the completing capability step). Plan approval must explicitly cover the exception. A preview proves neither connection nor authorization; a prerequisite does not deliver the later capability.

## Step structure

Every step contains Outcome, Covers links, then:

- **Specification:** What must be true: ownership, data/state, interactions, interfaces, edge cases, compatibility, and reuse as applicable. Each contract has one owning step; later steps link it.
- **Build:** Concrete changes, one action per line. Add dependency/deferred/risk detail only when execution needs it.
- **Verify:** Concrete check and expected result per line. Choose the cheapest trustworthy proof: unit for pure logic, component for UI/state, integration for real boundaries, end-to-end for justified journeys, observation for experience, measurement for performance.

Use the [Plan template](../templates/03-plan.md) and the [required artifact format](artifacts.md#required-format) for every step. Keep Specification and Verify within steps; omit separate Context, top-level Specification/verification plan, Build Plan, and Review sections.

### Focused test selection

- **Select:** Identify meaningful tests for changed business logic, access/data boundaries, and credible failure paths.
- **Reuse:** Prefer existing coverage; add tests only when they protect a plausible regression.
- **Timing:** Plan implementation first, then focused tests within the same step before approval, following [step-end testing](build.md#implement-then-test-the-step).
- **Simple changes:** Use suitable existing tests, build/static checks, or observation when new tests add no meaningful proof.

### Test Now

Within each Verify section provide Setup (actor/permissions, fixtures, environment), exact Open / Run entry point, Action, Expected outcome, and applicable automated/denial/failure checks. Provision needed fixtures/environment in this step or an approved prerequisite. For app capabilities, use the app with connected development services; for backend/tools, use the supported API/command. Static checks alone do not prove an app capability.

Before presentation, verify that every capability can be exercised before later work. If not, reduce/split it or identify an explicit exception. Keep instructions beside the step, never deferred to Finalize.

## Verification changes during Build

When planned verification becomes impossible or materially different, return to this step before claiming completion. Record unavailable check, reason, substitute, and remaining gap; obtain approval for the updated Plan before resuming. Preserve the original claim's proof boundary.

## Complete when

Existing constraints and sequence are understood; every step has a narrow outcome, Specification, Build actions, concrete Verify/Test Now path, and explicit exceptions. Apply Requirement Coverage from completeness.md. Resolve consequential choices or return to their owning phase, then finish the [phase handoff](framework.md#phase-handoff).
