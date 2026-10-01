# Lifecycle Code Review

## When and Scope

- **Build:** Review the current step's complete changes before presenting it.
- **Finalize:** Review the complete development change against its verified base.
- Include staged, unstaged, and relevant untracked files.
- Inspect surrounding code and affected callers when needed.
- Keep unrelated pre-existing work separate and preserved.

Use [Branch Reconciliation](completeness.md#branch-reconciliation) for Finalize scope.

## Review Sources

Before reviewing:

- Read applicable `AGENTS.md` instructions.
- Read relevant project guidelines and module docs.
- Read the approved Specification and Verify checks.
- Inspect established implementations in the affected area.
- Identify the intended ownership and dependency direction.

Project rules determine conformance.

If examples conflict with documented rules, surface the conflict.

## Standards Review

Inspect every changed or new file for:

- **Path:** Correct module, folder, and layer.
- **Name:** File, class, function, and identifier conventions.
- **Structure:** Required internal organization and responsibilities.
- **Dependencies:** Allowed imports and dependency direction.
- **Reuse:** Existing implementation considered before adding another.
- **Necessity:** Each new file or abstraction serves an approved responsibility.
- **Consistency:** Changed contracts propagated to affected callers and tests.

For each new file, establish why an existing owner cannot sensibly hold the responsibility.

A smaller file or a generic best-practice preference alone does not justify a new abstraction.

Keep project-mandated separation even when it creates additional files.

Assess applicable duplication, misleading names, pass-through layers, and speculative flexibility.

Treat design preferences as judgment calls, not undocumented mandatory standards.

## Specification Review

Check:

- Every requirement assigned to the step is implemented.
- The stated capability is runnable through its Test Now path.
- It does not depend on unimplemented future steps.
- Preview or prerequisite limitations match the approved exception.
- Behavior matches the approved contract.
- Normal, failure, and affected boundary scenarios are handled.
- Necessary safeguards from [Minimum Complete Solution](completeness.md#minimum-complete-solution) are implemented.
- No unsupported capability or unapproved behavior was added.
- Tests observe required behavior and establish the relevant claim.

Passing tests do not replace reading the implementation.

## Checks and Findings

Run applicable existing format, lint, architecture, and naming checks.

Inspect conformance that tooling does not enforce.

For each actionable finding, record:

- **Location:** File and relevant line, or intended path for a missing file.
- **Basis:** Project rule reference or approved requirement.
- **Impact:** What is wrong and why it matters.
- **Correction:** Smallest conforming change.

Keep Standards and Specification findings distinct.

Fix in-scope defects before presenting completion.

Route consequential scope or architectural changes to the owning phase.

Rerun checks affected by corrections.

Record unresolved findings as blockers, not a clean review.

Do not claim full conformance when required sources or review scope were unavailable.

## Workflow Feedback

After correcting an avoidable finding:

- Check whether unclear requirements contributed.
- Check whether validation could have caught it sooner.
- Check whether missing domain language or instructions contributed.
- Check whether architecture made the correct path difficult to find or test.
- Distinguish observed causes from untested explanations.

Use the [Cycle Log feedback loop](cycle-log.md#feedback-loop) for reusable findings.

A mistake does not automatically justify a new rule or refactor.

## Record

Record the review scope and outcome briefly in Build or Finalize.

Link material findings or relevant check evidence.

Keep the full inspection checklist out of the review document.

A clean analyzer proves only the rules it actually checks.
