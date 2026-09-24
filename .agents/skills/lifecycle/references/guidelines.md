# Engineering Guidelines

## Source of Truth

- Project-specific engineering standards live under `docs/guidelines/`.
- The Lifecycle owns when they must be loaded.
- The project owns what they say.
- Do not assume fixed filenames, technologies, or conventions.

## Rule Promotion

When Build or Verify finds a **rule gap**, do not close with a local fix alone.

1. Classify it:
   - process → lifecycle skill;
   - project standard → project guideline;
   - deterministic rule → project checker;
   - temporary lesson → Cycle Log.
2. Record and update the authoritative source according to approval mode.
3. If safety or correctness requires it, apply the smallest immediate fix; keep promotion open.
4. Add or extend a checker when practical.
5. Apply the promoted rule to current code.
6. Rerun affected checks, analyzer, tests, and journey.
7. Log the decision, owner, scope, and evidence.

Shared skills define portable process only. Project names, paths, conventions, commands, and lifecycle records stay project-owned. Synchronization replaces portable skill content only.

## Build — Before Editing

1. Identify affected technologies, layers, and areas.
2. Discover every applicable guideline.
3. Read them before editing.
4. Inspect nearby established code patterns.
5. Treat applicable guidance as mandatory.

If guidance is missing, unclear, or contradictory:

- do not invent a project-wide convention;
- use a clear local established pattern only for routine local choices;
- surface consequential gaps to the owning phase/user.

## Build — While Creating

Before creating an important file/class/interface/abstraction/folder, check:

- placement;
- naming;
- layer;
- dependencies;
- internal structure;
- nearest established pattern.

## Build — Slice Audit

After implementation, run the full Slice Conformance Review and fix drift before continuing.

## Verify

- Load the applicable guidelines again.
- Perform final integrated conformance checks after all slices are combined.

## Refine

When the cycle exposes a recurring engineering rule:

- propose and, when approved, apply the smallest guideline improvement;
- add or extend enforcement and reverify current code;
- move the learning out of temporary lifecycle files/Cycle Log.

Keep durable information in its proper home:

- `docs/modules/` — module knowledge and future/deferred module work;
- `docs/guidelines/` — engineering standards;
- lifecycle skills — lifecycle/process guidance;
- codebase — implemented behaviour.
