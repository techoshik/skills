# Lifecycle code review

## Scope and sources

Review the current Build step before presentation; review the full reconciled development diff during Finalize. Include staged, unstaged, and relevant untracked files. Preserve unrelated pre-existing work. Read applicable instructions, project rules/module docs, approved Specification/Verify checks, surrounding implementations, callers, and ownership/dependency direction.

## Standards review

Inspect every changed/new file for governing path, names, internal structure, dependency direction, reuse, necessity, and contract propagation to callers/tests. Establish why a new file/abstraction cannot sensibly use an existing owner. Check duplication, misleading names, pass-through layers, and speculative flexibility. Generic preferences are judgment, not undocumented standards; project-mandated structure governs. Surface conflicts between examples and documented rules.

## Specification review

Establish that assigned requirements and safeguards are implemented; behavior, failure, and affected boundary cases match the approved contract; Test Now works before future steps; approved exceptions retain their stated limits; tests support the actual claim. Identify unapproved behavior or unsupported capabilities. Read implementation even when tests pass.

## Findings and correction

Run applicable format/lint/architecture/naming checkers and inspect rules they do not enforce. Keep Standards and Specification outcomes separate. For each actionable finding record Location, Basis (rule/requirement), Impact, and smallest Correction. Fix in-scope defects; route consequential changes to their owner; rerun affected checks. Unresolved findings are blockers. Missing sources/scope limit the review claim.

## Record and feedback

Record scope and concise outcomes in Build/Finalize; link material findings/evidence rather than copying this checklist. For avoidable failures, evaluate requirement, validation, language, instruction, or architecture gaps through the [Cycle Log feedback loop](cycle-log.md#feedback-loop). Observed mistakes justify improvements only when evidence supports them.
