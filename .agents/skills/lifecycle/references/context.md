# Context

## Purpose

- Find the existing facts that constrain the change.
- Give Shape the minimum sufficient map of current reality.

## Inputs

- Approved `01-define.md`.
- Canonical module documents for every affected module.
- Relevant code, configuration, tests, integrations, and engineering guidance.

## Investigation Strategy

> **Global → Module → Feature**

Use this as a research path, not as the artifact structure.

- **Global**
  - Architecture, platforms, shared constraints, project conventions.
- **Module**
  - Purpose, boundary, rules, dependencies, integrations.
- **Feature**
  - Current behaviour, implementation, data, tests, gaps.

Investigate deeply enough to understand the change. Record only change-relevant facts.

## Rules

- Identify every affected module.
- Read each existing `docs/modules/<module>.md`.
- Record the module document path or a missing-document gap.
- Find repository/system facts yourself.
- Do not restate stable module documentation.
- Put evidence beside claims when evidence matters.
- If reality contradicts Define, block and return to Define.
- Do not silently adapt the requirement.

## Questions

- What parts of the system are affected?
- How do those parts work today?
- What existing behaviour, components, contracts, or infrastructure can be reused?
- What technical/product facts constrain Shape?
- What verification infrastructure already exists?
- What consequential facts are still unknown?

## Actions

- Use repository inspection as the default.
- Use `research` for external/technical facts when needed.
- Use `domain-modeling` when terminology/domain concepts are unclear.
- Do not run `grill-with-docs` again by default; use it only if a new product/domain decision appears.

## Output — `02-context.md`

### Decision
- Result: Context sufficient / Define mismatch / More context required.
- Status: Pass / Blocked.
- Blockers.
- Next.

### Affected
For each affected module:
- module name;
- canonical docs path or missing-doc gap;
- one-line role in this change.

### Current
- Only current behaviour relevant to the change.
- Group by affected responsibility/module.

### Reuse
- Existing UI, domain logic, contracts, services, infrastructure, or tests that Shape should build on.

### Constraints
- Only facts that can constrain the solution.
- Examples: mutable data, ownership, permissions, architecture, integration limits, platform constraints.

### Verification
- Existing unit/widget/integration/E2E harnesses, fixtures, environments, or important gaps.
- Do not choose the future proof strategy here.

### Open
- Assumptions.
- Questions.
- Research.
- Blockers.
- Add `Resolve: <phase>` where useful.

## Phase Gate

Pass when:

- affected modules and current behaviour are understood;
- relevant reusable pieces and constraints are known;
- the verification landscape is known enough for Shape;
- no Context-owned blocker remains;
- Define still matches reality.

Do not add a second Exit section to the artifact.
