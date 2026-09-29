# Phase 3 — Plan

## Responsibility

Understand the existing system, specify the technical change, choose trustworthy proof, and create the safest reviewable build sequence.

## Principle

> **Understand → Specify → Prove → Plan**

Inspect before deciding.

Specify before sequencing.

Choose proof before Build.

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
- Do not create a separate Context artifact.
- Record project facts only when they affect:
  - specification;
  - build order;
  - risk;
  - proof.

## 2. Specify

Write the technical summary of what must be true when the change is complete.

Include only what Build needs without guessing:

- responsibilities/ownership;
- state/data changes;
- flows/interactions;
- interfaces/contracts;
- important edge cases;
- existing reuse;
- migration/compatibility/rollout when relevant.

Specification is the finished technical picture.

It is not the implementation order.

## 3. Prove

Choose the **cheapest trustworthy proof** before Build.

For each important Goal, Key Result, contract, or risky behaviour:

- state the proof;
- use the lowest-cost proof that can actually establish it;
- record any proof gap that cannot be closed reasonably.

Examples:

- pure behaviour → unit test;
- state/UI behaviour → widget/component test;
- cross-layer contract → integration test;
- complete user journey → end-to-end/integration test;
- visual/experience match → human acceptance;
- performance → measurement against an agreed threshold.

A cheaper proof is not acceptable when it cannot establish the claim.

A proof gap must be explicit.

Do not silently treat an unproved claim as verified.

## 4. Plan

Break the specification into **Build Steps**.

A Build Step is one coherent responsibility that can be:

- implemented;
- reviewed;
- independently checked.

Rules:

- several tightly related files may belong to one step;
- do not use one-file-per-step mechanically;
- do not generate the full feature in one giant step;
- prefer early reviewable feedback.

### UI-first default

When meaningful UI exists:

- prefer the first Build Step as UI + presentation contract;
- use fake/dummy/in-memory data when useful;
- include relevant visible states;
- avoid premature backend integration.

Do not force backend/domain/database models into the first step unless the UI truly requires them.

A common later order is:

- application logic;
- data/infrastructure;
- server/API;
- integration.

Use project reality and dependencies to decide the actual order.

## Build Step Reviewability

Each Build Step should have one primary review question.

Ask:

> **What is the main thing the user needs to judge after this step?**

If one step requires independent review of several responsibilities:

- split the step;
- keep tightly coupled files together when they represent one responsibility.

Do not split mechanically by:

- file;
- layer;
- frontend/backend boundary.

Split by reviewable responsibility.

## UI-first Deviation

When meaningful UI exists but a separate UI-first step is not appropriate:

- record one short reason in the Plan.

Example:

```md
- **UI-first:** Not separated.
  - Existing control depends directly on established application state.
```

Do not add this note when no meaningful UI exists.

## Proof Changes During Build

If planned proof becomes impossible or materially different:

- stop before treating the affected Build Step as complete;
- return to Plan;
- update the Proof section;
- record:
  - unavailable proof;
  - reason;
  - substitute proof, if any;
  - remaining gap.
- present the updated Plan;
- wait for explicit user approval;
- then continue Build.

Never silently replace planned proof with weaker evidence.

## Done When

Every Build Step has an observable `Done When`.

It proves the step is complete enough to continue.

It does not replace Finalize's whole-change proof.

## Artifact

Use:

```md
# Plan

## Specification
- ...

## Proof
- **<Outcome>**
  - Proof: ...
  - Gap: ...  # only when real

## Build Plan

### 1. <Build Step>
- **Build:** ...
- **Done When:**
  - ...

## Open Questions
- ...
```

Use `Depends` or `Risk` only when useful.

Use Mermaid only when dependencies are clearer visually.

## Complete When

- Technical solution is clear.
- Proof is defined for important claims.
- Real proof gaps are explicit.
- Build order is clear.
- Every Build Step is reviewable.
- Every Build Step has useful `Done When`.
- No consequential technical/build-sequence question remains.

Present Plan.

Wait for explicit user approval before Build.
