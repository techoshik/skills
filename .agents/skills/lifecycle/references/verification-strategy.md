# Verification Strategy

## Purpose

- Choose the cheapest trustworthy proof for the approved outcome.
- Keep proof decisions ahead of Build.
- Avoid forcing expensive E2E coverage when a smaller real boundary is sufficient.

## Test Levels

- **Unit**
  - Isolated rules, transformations, domain logic.
- **Widget / Component**
  - UI states, interactions, local feedback.
- **Module Integration**
  - Several internal layers/features must work together and the module boundary is the meaningful proof.
- **E2E**
  - The success criterion depends on a complete journey across real navigation, permissions, persistence, backend/functions, or external integrations.
- **Manual**
  - Automation is impractical or human judgment is part of acceptance; record the reason/risk.

Prefer the lowest level that provides trustworthy evidence.

## Escalate Proof When

- the change crosses several real boundaries;
- failure can cause data loss, incorrect access, invalid lifecycle state, or high-value workflow regression;
- the success criterion is a complete journey;
- lower-level tests cannot prove connected behaviour;
- the workflow has a regression history.

Do not force higher-level tests when:

- the real boundary is unavailable;
- external behaviour is inherently nondeterministic;
- a smaller deterministic proof provides equivalent confidence.

Record accepted gaps explicitly.

## Phase Ownership

- **Define**
  - Names success criteria, critical journey, and proof risk.
- **Context**
  - Maps existing tests, harnesses, fixtures, environments, and gaps.
- **Shape**
  - Selects the trustworthy proof level and accepted gaps.
- **Plan**
  - Assigns automated + real proof to each slice.
- **Build**
  - Creates/runs slice proof and keeps the journey runnable.
- **Verify**
  - Runs final integrated proof and protection checks.
- **Refine**
  - Moves recurring verification learning to permanent guidance/automation/module docs.

## Recording Rule

- Do not repeat a full verification strategy in every phase.
- Each phase records only the proof decision it owns.
