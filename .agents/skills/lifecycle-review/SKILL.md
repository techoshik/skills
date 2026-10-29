---
name: lifecycle-review
description: Independently audit the integrated change against requirements, project rules, callers, risks, and actual verification evidence (Lifecycle: Review).
---

# Lifecycle Review

Audit the entire change as one integrated system, not as a set of individually completed tasks. Verify the approved requirements against the actual code, inspect integration seams and risks, and ensure the final state is supported by evidence. Review is an audit phase; it must not become an unplanned second implementation phase.

## 0. Phase Rules & Guardrails

- **Fresh eyes:** When sub-agents are available, an independent auditor may review the changes using a task packet and relevant rules. The main agent must inspect the evidence and remains accountable.
- **Verify facts, not checklists alone:** A checked box or task-completion report is a clue, not proof. Trace important behaviors through actual code and tests.
- **Review the final state:** Any fix after a test run invalidates affected earlier evidence; rerun the relevant checks.
- **Respect scope:** Make only narrow, mechanical fixes that are clearly in scope and cannot change behavior. Route behavioral, architectural, cross-module, security, or data-integrity changes back through an approved roadmap task.
- **Never invent a clean baseline:** Establish or discover the actual base branch and baseline. If a full comparison or test suite cannot run, explain the limitation.

## Step 1: Entry Gate and Change Discovery

1. Read `00-status.md`, the Resume Checkpoint, `01-requirements.md`, `03-roadmap.md`, and applicable `.agents/rules/`. Confirm all roadmap tasks are `Done`, then set Review to `In Progress`.
2. Run read-only `git status --short` and relevant diffs. Identify modified, renamed, deleted, and untracked files. Read the full contents of relevant untracked files; they may not appear in a regular diff.
3. Determine the correct base branch from repository context. Do not assume `origin/main` exists or is the correct comparison target. If no reliable base is available, state what portion of the change can be reviewed.
4. Map the actual change scope against the roadmap touchpoints and inspect files that may be impacted indirectly (callers, exports, routes, shared components, rules, schemas, tests, and docs).

**Gate:** The complete review scope and any limitation are understood.

## Step 2: Integrated Audit

### A. Requirements and behavior

- Trace each relevant `REQ-X`, `AC-X.Y`, and `BR-X` from `01-requirements.md` into implementation and tests.
- Confirm mid-flight changes were reflected in the authoritative artifacts and no superseded behavior remains described as current.
- Check the primary user flow plus relevant edge cases, invalid input, empty/loading/error states, permission denial, retry, and recovery.

### B. Integration seams and data lifecycle

- Trace end-to-end paths across input/UI, validation, state/controller, repository/data layer, persistence, and UI refresh as relevant.
- Check routes, navigation, exports, cache invalidation, event/stream listeners, resource disposal, and callers of changed public symbols.
- Inspect create/update/delete side effects, consistency across related records, duplicate submissions, concurrency, idempotency, and migration/rollback implications when relevant.

### C. Security, privacy, and performance

- Verify authorization at the relevant enforcement boundary, not only by hiding UI controls.
- Check tenant/resource scoping on reads and writes, sensitive-data handling, audit history, and fail-closed behavior.
- Look for avoidable N+1 queries, repeated expensive work, leaked subscriptions/controllers, and broad shared changes with unintended effects.

### D. Architecture, Code Hygiene & Two-Tier Smart Deduplication

- Compare changed paths, names, and component placement with applicable `.agents/rules/` (e.g. `<500` lines guide, `<module>_validator` placement, 4-tier widget placement) and existing architecture.
- **Orphaned Exports & Routes Check:** Verify that any deleted or consolidated screens/widgets are cleanly removed from barrel `index.dart` exports, route constants, `<module>_navigation.dart`, callers, and tests.
- Remove dead code, unused imports, debug output (`print`, `debugPrint`, `console.log`), and temporary compatibility aliases where evidence supports removal.
- **Two-Tier Smart Deduplication:**
  - **Tier 1 (Intra-Module):** Consolidate duplicated widgets, validation helpers, or logic across touched files into module `widgets/` or `utils/`.
  - **Tier 2 (Cross-Module / `core/`):** Reuse existing shared components first; ask the user before modifying shared `core/` files used by unrelated modules.
- Do not trigger a broad refactor simply to improve aesthetics or reach an arbitrary file count/line count.

### E. Decision and scope quality

- Confirm implementation matches approved decisions, not merely the easiest interpretation.
- Search for hidden assumptions, unexplained behavior changes, omitted failure paths, or deferred work that is actually required for correctness.
- Check the roadmap did not omit a material requirement or create an unjustified task.

**Gate:** Each applicable audit dimension has been checked against actual artifacts; findings are classified by severity and evidence.

## Step 3: Classify Findings and Correct Safely

Classify each finding before acting:

- **Blocker / material behavior / security / data integrity:** Stop advancement. Explain the evidence and options. Add or revise a roadmap task and return to Execute; obtain user approval when the change alters an approved decision or scope.
- **In-scope mechanical defect:** A narrow fix (or safe intra-module Tier 1 deduplication / dead-code cleanup) may be made only when the intended behavior is unambiguous and the change cannot reasonably alter product behavior. Record the change and rerun affected verification.
- **Out-of-scope cleanup or architectural improvement:** Record/defer it or propose a new task; do not silently expand scope.
- **Unverified concern:** Investigate enough to confirm or dismiss it. If it remains uncertain and materially affects safety/correctness, report it as unresolved rather than claiming the audit passed.

Update roadmap acceptance checkboxes based on evidence. Do not add execution checkboxes to `01-requirements.md`. If a capability is missing, add a numbered roadmap task and a matching status row, mark the relevant phase/task appropriately, and return to Execute.

**Gate:** No known blocker remains hidden, and any fixes are in scope and re-verified.

## Step 4: Global Verification

1. Run the project-level analyzer and relevant full test suite when available, plus any integration/security checks justified by risk.
2. Record exact commands and actual results. Use `Passed`, `Failed`, or `Not Run` with a reason; do not equate an unavailable environment with success.
3. Distinguish pre-existing baseline failures from regressions introduced by this feature. The desired project standard may be zero issues, but the report must accurately describe the observed baseline.
4. After any fix, rerun all checks affected by that fix. Inspect the final diff and `git status --short` again.

**Gate:** The final state has current evidence, and every failed/not-run check or residual risk is disclosed.

## Step 5: Review Handoff

1. Add meaningful new lessons to `04-refine.md`.
2. Update the Resume Checkpoint in `00-status.md` and set Review to `In Review`.
3. Present a concise 5-bullet review summary in chat (linking to `01-requirements.md` and `03-roadmap.md`, no chat tables):
   - **Spec-to-code:** What was checked and confirmation that `01-requirements.md` and final code match with zero stale contradictions.
   - **Integration and rules:** Important caller, route/export cleanup, architecture, permission, tenancy, or performance findings.
   - **Corrections & Deduplication:** Narrow fixes or intra-module deduplications made, or tasks returned to Execute.
   - **Verification evidence:** Exact global analyzer and test suite commands and outcomes.
   - **Remaining limitations:** Failed/not-run checks or unresolved risks, if any.
4. Stop for user sign-off. On approval, mark Review `Done` in `00-status.md`, update the checkpoint, read [`lifecycle-finalize/SKILL.md`](../lifecycle-finalize/SKILL.md), and auto-advance to Finalize.
