# Verification Strategy

## Purpose

- Choose the cheapest trustworthy proof for the approved outcome.
- Make module-level and end-to-end testing an explicit risk-based decision rather than a default requirement.
- Keep test planning ahead of Build while keeping whole-solution execution and evidence in Verify.

## Decision Rules

- Use **unit tests** for isolated rules, transformations, and domain logic.
- Use **widget/component tests** for screen states, interactions, and local feedback.
- Use **module integration tests** when several internal layers or features must work together and the real module boundary is the important proof.
- Use **end-to-end tests** when an approved success criterion depends on a complete user/system journey across real navigation, permissions, persistence, backend/functions, or external integrations.
- Use **manual verification** only when automation is not yet practical or when human judgment is part of the acceptance criterion; record the reason and remaining risk.
- Prefer the lowest test level that gives trustworthy evidence. Do not add E2E tests for isolated behavior already adequately proven by faster tests.
- A proposed test level is not automatically new product scope. If it requires meaningful infrastructure, environment, fixture, CI, or maintenance cost, surface it for approval in the current phase.
- In `auto` mode, routine test selection may proceed from approved success criteria and risk, but infrastructure expansion, new requirements, and unresolved consequential tradeoffs still require explicit handling.

## E2E / Module-Test Triggers

Recommend module integration or E2E coverage when one or more of these are true:

- The change crosses navigation, state management, repository/API, database, function, or permission boundaries.
- A failure would cause data loss, incorrect access, an invalid lifecycle transition, or a high-value workflow regression.
- The success criterion is expressed as a complete user journey rather than an isolated component behavior.
- Existing lower-level tests cannot prove that the connected parts work together.
- The workflow has previously regressed or is difficult to verify manually.

Do not force the test when the real boundary is unavailable, the external dependency is inherently nondeterministic, or a smaller deterministic test provides equivalent confidence. Record the gap and risk instead.

## Required Record

- **Outcome to prove:** …
- **Critical journey or module flow:** …
- **Recommended proof level:** Unit / Widget / Module Integration / E2E / Manual
- **Real boundaries involved:** …
- **Existing coverage:** …
- **Missing coverage:** …
- **Why this level is sufficient:** …
- **Cost / determinism / environment risks:** …
- **Approval or accepted gap:** …

## Phase Ownership

- **Define** identifies the outcome, critical journey, and risk that must be proven.
- **Context** verifies existing test coverage, harnesses, boundaries, fixtures, and environment constraints.
- **Shape** selects the cheapest trustworthy proof level and validates important testability assumptions.
- **Plan** assigns automated proof and real verification to slices, including any test infrastructure needed before Verify.
- **Build** creates or updates executable proof with the behavior and runs slice-level verification.
- **Verify** runs the complete feature/module flow through the required real boundary and records evidence.
- **Refine** proposes durable guidance, automation, or backlog work when verification gaps or flakiness recur.
