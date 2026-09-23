# Engineering Guidelines

## Source of Truth

- Project-specific engineering standards live under `docs/guidelines/`.
- The Lifecycle owns when they must be loaded.
- The project owns what they say.
- Do not assume fixed filenames, technologies, or conventions.

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

- propose the smallest guideline improvement;
- apply it when approved;
- move the learning out of temporary lifecycle files/Cycle Log.

Keep durable information in its proper home:

- `docs/modules/` — module knowledge and future/deferred module work;
- `docs/guidelines/` — engineering standards;
- lifecycle skills — lifecycle/process guidance;
- codebase — implemented behaviour.
