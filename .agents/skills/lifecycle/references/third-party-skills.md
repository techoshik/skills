# Required Companion Skills

The Lifecycle system can use the companion skills in
[mattpocock/skills](https://github.com/mattpocock/skills). A skill installed in
Codex (for example, under `~/.agents/skills`) or in the repository's
`.agents/skills/` is available; install the missing skills before using a
phase that requires them:

```bash
npx skills@latest add mattpocock/skills
```

Select the skills referenced below, including `setup-matt-pocock-skills`, and
run `/setup-matt-pocock-skills` once per project. These skills provide
techniques and setup; they never replace the Lifecycle phase outputs or exit
gates.

## Recommended Mapping

### Define

- **grill-with-docs** — Human-in-the-loop requirement interview that composes
  grilling and domain modeling; use it for every non-trivial change to resolve
  requirements, terminology, constraints, decisions, and concrete scenarios.
- **wayfinder** — Breadth-first map of a large decision tree; name the
  destination first, resolve one decision at a time, and return decisions to
  the lifecycle artifacts.

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
