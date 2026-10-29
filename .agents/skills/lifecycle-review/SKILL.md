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
- **Trace in writing:** Record every spec-to-code trace in `lifecycle/05-traceability.md`. A trace that is not written down did not happen, and implementer reports are leads, not evidence.

## Step 1: Entry Gate and Change Discovery

1. Read `00-status.md`, the Resume Checkpoint, `01-requirements.md`, `03-roadmap.md`, `05-traceability.md`, and applicable `.agents/rules/`. Confirm all roadmap tasks are `Done`, then set Review to `In Progress`.
2. Run read-only `git status --short` and relevant diffs. Identify modified, renamed, deleted, and untracked files. Read the full contents of relevant untracked files; they may not appear in a regular diff.
3. Determine the correct base branch from repository context. Do not assume `origin/main` exists or is the correct comparison target. If no reliable base is available, state what portion of the change can be reviewed.
4. Map the actual change scope against the roadmap touchpoints and inspect files that may be impacted indirectly (callers, exports, routes, shared components, rules, schemas, tests, and docs).

**Gate:** The complete review scope and any limitation are understood.

## Step 2: Integrated Audit

### A. Requirements and behavior

- Trace each in-scope `AC-X.Y` and `BR-X` from `01-requirements.md` into implementation and tests, and complete its row in `lifecycle/05-traceability.md`:
  - `Implemented at` / `Enforced at`: `path:line` found by reading the code.
  - `Verified by`: the test or manual step plus `Passed` / `Failed` / `Not Run`.
  - `Result`: `Verified` only when the check actually ran and passed; otherwise `Not Verified` or `Gap`.
- Fill those cells from the code and from checks you can confirm; use the implementer’s reports only as leads.
- At `Deep` tier, mark each `PM-n` pre-mortem item as covered with evidence, or flag it as a finding.
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

### D. Architecture, Code Hygiene & Deduplication

- Compare changed paths, names, and component placement with applicable `.agents/rules/` and existing architecture. Run each applicable rules file’s **Review hygiene checklist**, including the file-size hard limit.
- **Orphaned Exports & Routes Check:** Verify that any deleted or consolidated screens, widgets, or symbols are cleanly removed from public exports, route definitions, callers, and tests. The rules file’s checklist names the exact places.
- Remove dead code, unused imports, debug output, and temporary compatibility aliases where evidence supports removal.
- **Smart Deduplication:**
  - **Intra-module:** Consolidate duplicated helpers or logic across touched files into the module’s shared location, as the rules file specifies.
  - **Cross-module / shared infrastructure:** Reuse existing shared components first; ask the user before modifying shared files used by unrelated modules.
- Do not trigger a broad refactor simply to improve aesthetics or reach an arbitrary file count/line count.

### E. Decision and scope quality

- Confirm implementation matches approved decisions, not merely the easiest interpretation.
- Search for hidden assumptions, unexplained behavior changes, omitted failure paths, or deferred work that is actually required for correctness.
- Check the roadmap did not omit a material requirement or create an unjustified task.

**Gate:** Each applicable audit dimension has been checked against actual artifacts; findings are classified by severity and evidence.

## Step 3: Classify Findings and Correct Safely

Classify each finding before acting:

- **Blocker / material behavior / security / data integrity:** Stop advancement. Explain the evidence and options. Add or revise a roadmap task and return to Execute; obtain user approval when the change alters an approved decision or scope.
- **In-scope mechanical defect:** A narrow fix (or safe intra-module deduplication / dead-code cleanup) may be made only when the intended behavior is unambiguous and the change cannot reasonably alter product behavior. Record the change and rerun affected verification.
- **Out-of-scope cleanup or architectural improvement:** Record/defer it or propose a new task; do not silently expand scope.
- **Unverified concern:** Investigate enough to confirm or dismiss it. If it remains uncertain and materially affects safety/correctness, report it as unresolved rather than claiming the audit passed.

Update roadmap acceptance checkboxes based on evidence. Do not add execution checkboxes to `01-requirements.md`. If a capability is missing, add a numbered roadmap task and a matching status row, mark the relevant phase/task appropriately, and return to Execute.

Every traceability row whose `Result` is `Not Verified` or `Gap` must be classified above and listed with a disposition under `Gaps & dispositions` in `05-traceability.md`.

**Gate:** No known blocker remains hidden, and any fixes are in scope and re-verified.

## Step 4: Global Verification

1. Run the project-level analyzer and relevant full test suite when available, plus any integration/security checks justified by risk.
2. Record exact commands and actual results. Use `Passed`, `Failed`, or `Not Run` with a reason; do not equate an unavailable environment with success.
3. Distinguish pre-existing baseline failures from regressions introduced by this feature. The desired project standard may be zero issues, but the report must accurately describe the observed baseline.
4. After any fix, rerun all checks affected by that fix. Inspect the final diff and `git status --short` again.

**Gate:** The final state has current evidence, and every failed/not-run check or residual risk is disclosed.

## Step 5: Review Handoff

**Exit check first:** Every in-scope `AC-X.Y` and `BR-X` row in `05-traceability.md` has a `Result` (no `Planned` rows remain), every row that is not `Verified` or `Superseded` has a disposition (task added, user-accepted with date, or deferred with reason), and every `PM-n` (Deep tier) is covered or flagged. Do not set Review to `In Review` until this holds.

1. Add meaningful new lessons to `04-refine.md`.
2. Update the Resume Checkpoint in `00-status.md` and set Review to `In Review`.
3. Present the review using the Approval Request block (Section 4 of [`lifecycle/SKILL.md`](../lifecycle/SKILL.md)), linking `01-requirements.md`, `03-roadmap.md`, and `05-traceability.md`, no chat tables. **What I did** = Spec-to-code + Corrections & Deduplication + Verification evidence; **What to check** = Integration and rules findings plus the `Gaps & dispositions` list; **What I need from you** = sign-off plus any remaining limitation that needs a decision:
   - **Spec-to-code:** The coverage count from `05-traceability.md` (for example `AC 14/16 Verified; BR 5/5 Verified`), and confirmation that `01-requirements.md` and final code match with zero stale contradictions.
   - **Integration and rules:** Important caller, route/export cleanup, architecture, permission, tenancy, or performance findings.
   - **Corrections & Deduplication:** Narrow fixes or intra-module deduplications made, or tasks returned to Execute.
   - **Verification evidence:** Exact global analyzer and test suite commands and outcomes.
   - **Remaining limitations:** Failed/not-run checks or unresolved risks, if any.
4. Stop for user sign-off. On approval, mark Review `Done` in `00-status.md`, update the checkpoint, read [`lifecycle-finalize/SKILL.md`](../lifecycle-finalize/SKILL.md), and auto-advance to Finalize.
