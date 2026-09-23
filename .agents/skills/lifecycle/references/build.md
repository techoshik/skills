# Build

## Purpose

- Implement one approved slice at a time.
- Keep the journey runnable early.
- Conform while creating, then audit the completed slice.

## Inputs

- Approved `04-plan.md`.
- Current slice.
- Relevant Shape/Context only as needed.
- Applicable permanent module docs.
- Applicable Engineering Guidelines.

## Core Principle

> **Build outside-in. Keep the journey runnable. Conform while creating. Audit before continuing.**

## Before Editing

1. Identify the technologies, layers, and areas the slice touches.
2. Discover and read all applicable files under `docs/guidelines/`.
3. Build an internal applicability map:
   - placement;
   - naming;
   - architecture/layer;
   - dependency direction;
   - internal structure;
   - test conventions.
4. Inspect nearby established code patterns.
5. If guidance is missing, unclear, or contradictory and the choice is consequential, surface it instead of inventing a project-wide convention.

Do not add the guideline map to `05-build.md` unless a gap matters to the result.

## Slice Build Path

For normal user-facing work:

```text
Journey
  ↓
State / Models ↔ UI
  ↓
Application path
  ↓
Controlled boundary
  ↓
Early journey check
  ↓
Backend / real implementation
  ↓
Real connection
  ↓
Same journey check
  ↓
Conformance review
```

- State/models may come just before or alongside UI.
- Use only the layers the project actually needs.
- Backend-only/technical slices use the shortest relevant path.

## During Build

Before creating an important file, class, interface, abstraction, or folder, check:

- placement;
- naming;
- layer;
- dependencies;
- internal structure;
- nearest established pattern.

> **Prevent continuously → audit completely.**

Do not silently invent a new project-wide convention.

## TDD

Use `tdd` for meaningful behaviour when practical:

```text
Specify → Red → Green → Refactor
```

TDD proves pieces. The slice journey proves the pieces work together.

## Slice Conformance Review

Before closing a slice, verify:

- folder/file placement;
- naming;
- class/interface/type structure;
- architectural layer and dependency direction;
- reuse of established patterns;
- test placement/style;
- no temporary shortcuts remain unintentionally;
- no unnecessary abstractions;
- no unrelated changes;
- formatter/lint/type/architecture checks required by the project.

If a deviation is found:

```text
Fix → rerun affected checks → rerun affected journey → close
```

## Mismatch Routing

- Requirement/value/scope problem → Define.
- Existing-system misunderstanding → Context.
- Wrong solution/domain/seam → Shape.
- Wrong implementation approach/slicing → Plan.
- Implementation defect/conformance → Build.

Build must not improvise an upstream decision.

## Companion Skills

- `tdd` — meaningful behaviour.
- `diagnosing-bugs` — difficult failures.
- `code-review` — useful aid for the mandatory standards/spec review.

Conformance Review is mandatory even if `code-review` is unavailable.

## Output — `05-build.md`

The code is the primary output. Keep the artifact as a compact slice ledger.

### Status
- State: In Progress / Complete / Blocked.
- Current slice.
- Next.

### Slice N — <name>

- **Result**
  - Pass / Blocked.

- **Built**
  - Only meaningful implementation groups.

- **Proof**
  - Automated result.
  - Real journey/boundary result.

- **Conformance**
  - Guidelines: Pass / Blocked.
  - Deterministic checks: Pass / Blocked.

Optional:
- **Deviation**
  - Only when a discovery/deviation matters.
  - Name owner/return phase when blocked.

## Phase Gate

A slice passes only when:

- its approved outcome is implemented;
- required proof passes;
- the real/meaningful boundary has been exercised;
- conformance review passes;
- any deviation is resolved or routed to its owner.

Start the next slice only after the current slice passes.
