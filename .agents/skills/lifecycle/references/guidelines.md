# Engineering Guidelines

## Source of Truth

Project-specific engineering standards live under `docs/guidelines/`.

The Lifecycle system owns when these guidelines must be loaded. The project
owns what the guidelines say.

Guideline files are project-specific. Do not assume a fixed set of filenames
or technologies, and do not invent a guideline when one is absent.

## Before Build or Verify

1. Identify the technologies, layers, and project areas affected by the work.
2. Discover the applicable files under `docs/guidelines/`.
3. Read every relevant guideline before editing code or reviewing the result.
4. Treat applicable guidelines as mandatory conformance requirements.
5. If applicable guidance is missing, unclear, or contradictory, surface the
   gap and pause the affected decision rather than inventing a convention.

Use the affected paths, technology configuration, existing code patterns, and
the change scope to determine applicability. A broad project guideline and
more specific guidelines may both apply; load both when relevant.

## During Refine

When completed work exposes a recurring engineering rule or correction,
propose an update to the appropriate project guideline in `07-refine.md`.
Apply it only after user approval; do not leave approved learning only in a
Cycle Log or lifecycle artifact.

Keep product knowledge, stable factual references, and active-cycle memory in
their own homes:

- `docs/modules/` — what the product and system are now.
- `docs/lifecycle/` — temporary active-cycle work.
- `docs/backlog/` — future product opportunities.
