# Finalize

Reconcile → Verify → Synchronize → Improve → Clean → Close.

## Required reading

Read [Coverage and Completion](completeness.md), [Code Review](code-review.md), [Project Rules](guidelines.md), and [Cycle Log](cycle-log.md). The agent running Finalize owns reconciliation and completion assessment.

- **Full lifecycle input**
  - Idea: Goal, What Will Change, Expected Outcomes, and scope decisions.
  - Existing cycles: Key Results remain the earlier acceptance source.
  - Prototype: decisions and assets.
  - Plan: every step and check.
  - Build: results and evidence.
  - Cycle Log: all entries.
- **Full project input**
  - Complete branch/worktree diff.
  - Relevant permanent documentation.

This phase requires complete intent and change coverage, not only the current step.

## Reconcile

Apply Branch Reconciliation in completeness.md. Create a compact Change Inventory: verified base, changed behaviors/areas, owning work, exclusions, and consequential unplanned changes. Resolve unplanned changes through their owning phase before closure; checklist inclusion does not approve them.

## Verify

- **Checklist:** Create one complete Verification Checklist in `05-finalize.md`.
- **Sources**
  - Approved Expected Outcomes and proposed changes.
  - Prototype decisions and every Plan check.
  - Build evidence, actual changes, and resulting regressions.
- **Usability:** The user can exercise the whole development change from this file without reopening earlier artifacts.

Each item identifies module/feature, actor/setup, action, expected outcome, proof method, actual result/status, and evidence. Group by area if useful. Cover applicable UI, access/revocation, cross-module flows, compatibility/migration, integrations/dependencies, and documentation. Use authorized isolated/staging data for destructive or stateful checks.

Carry valid step proof forward. Rerun only invalidated proof/relevant regressions; add whole-change checks that step proof cannot establish. Build remains responsible for immediate capability testing. Include special Test Setup only when needed. Apply Evidence, Proof Limits, and Gap Acceptance; pending/accepted-gap checks remain unchecked.

Keep development-time checks within the framework's Development Boundary; deployment/release/post-merge work is external, not a development proof gap. Use Diagnosis for unexplained failures and Return to the owner for defects. Complete full-change Code Review before closure.

## Synchronize

After sufficient verification, update module, support/user, and other permanent sources to current verified behavior; remove obsolete claims. Accepted proof gaps must remain explicit where relevant.

## Improve

Review all reusable Cycle Log, implementation, environment, and verification friction. Promote through Rule Promotion, intentionally defer, or dismiss with a reason. Preserve only evidence-backed reusable learning; no improvement is required merely to fill this section.

### Architecture improvements

For observed ownership/navigation/caller-complexity/testability friction, inspect code, history, domain language, and prior decisions. Propose the smallest improvement with affected responsibility/files, evidence, change, compatibility/migration risk, and verification of benefit. Check whether removing an abstraction spreads complexity. Flag established-decision conflicts; consequential refactors require approval and an owning Plan. Broader work belongs to a separate lifecycle.

## Clean

Apply Safe Cleanup only after decisions and evidence are preserved. Remove owned temporary code/assets and obsolete leftovers. Retain the active workspace through Finalize review; its later archive/removal requires explicit confirmation.

## Close

Ready for Finalize approval only when intent/diff are reconciled, consequential unplanned changes resolved, required checks passed or gaps explicitly accepted, permanent truth synchronized, useful learning disposed of, owned temporary work cleaned, and no consequential development issue remains.

Record readiness or blockers in `05-finalize.md`; update index to Awaiting Approval when ready, Blocked otherwise. Present Finalize through the phase handoff. Mark the lifecycle Complete only after explicit Finalize approval.
