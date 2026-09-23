# Plan

## Purpose

- Turn the approved Shape into the smallest dependency-aware sequence Build can execute without guessing.
- Optimize for early runnable journeys, not horizontal technical layers.

## Inputs

- Approved Shape.
- Context facts needed for dependencies/reuse.
- Define only when success criteria need traceability.

## Core Principle

> **Build outside-in: make the journey runnable early, then replace controlled boundaries with real ones.**

- Do not build all server layers first and leave the feature untestable until the end.
- UI state/models may be created just before or alongside UI.
- The exact order depends on what the UI/journey needs.
- Do not prescribe project layers that do not exist.

## Default User-Facing Slice Path

```text
Journey
  ↓
State / Models ↔ UI
  ↓
Frontend / Application path
  ↓
Controlled / fake boundary
  ↓
Exercise the journey early
  ↓
Backend / real implementation
  ↓
Real connection
  ↓
Exercise the same journey
  ↓
Conformance
```

- Backend-only, migration, or infrastructure slices use the shortest relevant path.
- The governing rule is: **keep the slice runnable as early and as often as possible.**

## Rules

- Plan behaviour and boundaries, not every coding step.
- Each slice should produce one understandable outcome.
- Each user-facing slice should expose a journey the developer can exercise.
- Each slice carries its own proof.
- Resolve anything that could materially change:
  - slice boundaries;
  - architecture/contracts;
  - dependency order;
  - migrations/rollout;
  - proof.
- Build should not have to invent these.
- Do not plan routine local implementation mechanics already governed by engineering guidelines.
- Do not copy naming/folder/class conventions into Plan; Build loads the applicable guidelines.
- Do not force `Model / UI / Backend / Connect / Verify` headings or `Not applicable`.
- Write only the implementation areas that contain work.

## Questions

- What is the smallest useful build order?
- What genuine prerequisite exists?
- What can become runnable before backend completion?
- Which controlled/fake boundary can unlock early interaction?
- What real boundary must replace it?
- What journey proves the slice before and after real connection?
- What regression or rollout risk changes the sequence?

## Companion Skills

- `wayfinder` — large/dependency-heavy planning.
- `to-tickets` — only when external execution tracking is useful.

## Output — `04-plan.md`

### Decision
- Result: Plan approved / Needs revision.
- Status: Pass / Blocked.
- Blockers.
- Next.

### Build Order
- Ordered slice names.
- Add a short reason only when order is non-obvious.
- Add genuine prerequisites only.

### Slices
For each slice:

#### Slice N — <name>

- **Journey**
  - The developer-visible user/system path to exercise.

- **Build**
  - Ordered implementation groups needed for this slice.
  - Group related work together.
  - Include state/models, UI, application path, controlled boundary, backend, real connection, migrations, etc. only when applicable.

- **Proof**
  - Automated proof.
  - Real journey/boundary proof.

Optional only when they matter:
- **Depends**
- **Boundary**
- **Risk**

### Open
- Research/questions/blockers that Plan still owns.
- Build must not start with a critical Plan-owned unknown.

## Delete Test

- If removing a planned item does not prevent the slice outcome or its proof, remove it from the Plan.

## Phase Gate

Pass when:

- Build order is clear;
- each slice has an observable journey/outcome;
- each slice has a proof path;
- required dependencies and real boundaries are known;
- no critical implementation/slicing decision is left for Build to invent.

Do not add a second Exit section to the artifact.
