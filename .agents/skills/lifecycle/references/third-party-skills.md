# Specialist Skills

This lifecycle can use specialist skills from `mattpocock/skills` when available.

Repository: https://github.com/mattpocock/skills

These skills are **supporting techniques**. They never replace the lifecycle's phase outputs or exit gates.

## Recommended Mapping

### Define

- **grill-with-docs** — Deep questioning when requirements, terminology, constraints, or decisions are unclear.
- **wayfinder** — Large or highly uncertain modules/features where many decisions must be discovered and sequenced before the destination is clear.

Discovery may be broad, but store findings in the correct lifecycle artifact. A large third-party-generated spec must not become a competing source of truth.

### Context

- **research** — Investigate external or technical questions using high-trust sources.
- **domain-modeling** — Sharpen terminology and domain concepts when existing product language is unclear.

### Shape

- **prototype** — Cheaply validate important experience/state/logic assumptions.
- **domain-modeling** — Stress-test concepts, ownership, lifecycle, and business rules.
- **codebase-design** — Explore clean module seams and interfaces when architecture affects the shaped solution.

### Plan

- **wayfinder** — Resolve large decision trees and long-horizon work.
- **to-tickets** — Optional decomposition into tracer-bullet work items when an external issue tracker is useful. The lifecycle Plan remains authoritative.

### Build

- **tdd** — Test-first development for meaningful behaviour.
- **diagnosing-bugs** — Disciplined diagnosis when a slice fails in a non-obvious way.
- **code-review** — Review changed code against documented standards and the approved specification/slice.

### Verify

- **code-review** — Independent standards + spec review of the completed change.
- **diagnosing-bugs** — Use when verification exposes hard failures that require diagnosis.

### Refine

- **improve-codebase-architecture** — Survey the codebase/branch for worthwhile design improvements.
- **code-review** — Re-check code quality and standards after refinement changes.
- **writing-for-agents** — Improve lifecycle skills, AGENTS.md/CLAUDE.md, pointers, or agent-facing standards when the Cycle Log shows instruction problems.

## Conflict Rule

If a specialist skill conflicts with:

1. approved lifecycle artifacts,
2. this lifecycle framework,
3. project Engineering Guidelines under `docs/guidelines/`,

then the lifecycle/project rule wins.

Example: if an external TDD skill uses a different refactoring cadence, the current Lifecycle — Build instructions control the work.
