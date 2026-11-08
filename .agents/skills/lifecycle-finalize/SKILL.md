---
name: lifecycle-finalize
description: Verify complete outcomes, audit code quality, assess application-wide improvement opportunities, and complete documentation and handover (Lifecycle: Phase 5 — Finalize).
---

# Phase 5 — Lifecycle Finalize

## 1. Purpose

> **Core Mental Model:** Verify the whole picture. Clean up the codebase. Document the verified truth. Hand over with confidence.

Complete the development lifecycle by independently verifying the complete integrated implementation against its original goals and requirements, reviewing code quality and architecture, identifying improvement opportunities across the application, synchronizing permanent documentation, and delivering a clean handover.

The Agent should continuously look for opportunities to improve the implementation, but must obtain user approval before making any improvement beyond what is required by the approved task—even a minor one.

---

## 2. Guiding Principles

- **Verify Outcomes, Not Just Tasks:** Phase 4 verified individual implementation tasks. Phase 5 verifies the complete integrated system against the original Goal and Target Features from `lifecycle/01-discover.md`.
- **Audit Facts, Not Checklists:** A checked box in `lifecycle/03-plan.md` is a clue, not proof. Verify important behaviors through actual code, tests, and running system evidence.
- **Improve Proactively, Change Only With Approval:** Actively spot opportunities to improve code quality, performance, deduplication, and architecture across the feature and connected modules. Present recommendations with evidence and trade-offs. Never implement an improvement beyond the approved scope—even a minor one—without explicit user approval.
- **The Orphan Hunter Audit:** When screens, endpoints, or helpers are deleted, renamed, or consolidated, conduct a dedicated grep audit to ensure zero orphaned exports, dead route registrations, dangling imports, stale test mocks, or unused CSS linger in the project.
- **Smart Deduplication (Intra-Module vs. Cross-Module):**
  - *Intra-Module:* Consolidate duplicated helpers across touched files within the module's shared directory.
  - *Cross-Module:* Reuse existing shared components, but **never** edit shared infrastructure used by unrelated modules without explicit user permission.
- **Narrow Mechanical Fixes vs. Returning to Build:**
  - Narrow, mechanical defects on touched files (e.g., removing an unused import or fixing a typo) may be resolved in-place during Finalize.
  - Any behavioral, architectural, data-integrity, or security defect **must** return to Phase 4 — Build as a formal task.
- **Document Verified Truth Only:** Permanent documentation in `docs/` must represent the final verified implementation, not temporary plans or abandoned ideas.
- **Honest Global Evidence:** Distinguish pre-existing baseline test failures from regressions introduced by this feature. Report all test results honestly as `Passed`, `Failed`, or `Not Run`.
- **Preserve Lifecycle Artifacts by Default:** Never delete or move the `lifecycle/` directory without an explicit choice from the user at the Artifact Cleanup Gate.
- **Strict Phase Boundaries (Negative Constraints):**
  - **No New Features or Scope Expansion:** Feature exploration and scope boundaries belong to Phase 1 — Discover.
  - **No Unapproved Improvements:** Never implement refactors, performance tweaks, or deduplication without explicit user approval.
  - **No Direct Structural Refactoring:** Any substantive behavioral, architectural, or security defect must return to Phase 4 — Build as a formal task.
  - **No Cross-Module Modification Without Approval:** Never edit shared infrastructure or files consumed by unrelated modules without explicit user permission.
  - **No Unilateral Lifecycle Deletion:** Never delete or move the `lifecycle/` directory without an explicit choice from the user at the Artifact Cleanup Gate.

---

## 3. Responsibilities & Sequence

Finalize progresses through three disciplined chronological steps:

### 3.1 Step 1 — Verify Integrated Outcomes & Technical Code Audit

1. **Verify Intended Outcomes & Requirements:**
   - Trace each Target Feature from `lifecycle/01-discover.md` into the implementation and automated tests.
   - Verify that the core Goal is achieved and that critical user journeys function end-to-end.
   - Confirm edge cases (empty states, invalid inputs, network failures, session expirations) behave as designed.
2. **Audit Seams, Security & Invariants:**
   - Check routes, navigation, state stores, and caller contracts across module boundaries.
   - Verify authorization and permission checks at the enforcement boundary (not merely hiding UI elements).
   - Check sensitive data handling, fail-closed behavior, and transaction integrity.
3. **Execute the Orphan Hunter Audit & Code Hygiene Check:**
   - Run dedicated grep searches to ensure deleted or renamed screens, components, or API endpoints have zero lingering exports, dead route registrations, dangling imports, or orphaned test mocks.
   - Check modified files against assigned Rule Files (folder placement, naming conventions, file-size limits).
   - Ensure diff hygiene: verify zero leftover `console.log`, `debugger`, or temporary test shims.
4. **Global Verification Suite & Audit Record:**
   - Run the project-level analyzer, linter, and full test suite.
   - Record exact commands and outcomes honestly (`Passed`, `Failed`, `Not Run`) in `lifecycle/05-finalize.md` under `## 1. At a Glance` (Global Checks table). Distinguish pre-existing baseline issues from new code.
5. **Handle Findings:**
   - *Narrow mechanical fix:* Fix trivial typos or unused imports in-place and re-verify.
   - *Behavioral or security defect:* Halt Finalize, record the finding, return to Phase 4 — Build, and implement a proper task.

### 3.2 Step 2 — Improvement Assessment & Smart Deduplication

1. **Identify Deduplication & Modernization Opportunities:**
   - Search for duplicated logic across touched files that can be consolidated into module-level shared utilities.
   - Identify inconsistent patterns, deprecated dependencies, or unnecessary complexity introduced or exposed by the change.
2. **Apply the Smart Deduplication Boundary:**
   - **Intra-Module:** Safe consolidation of helpers or sub-components within the active module.
   - **Cross-Module:** Never touch shared infrastructure or files consumed by unrelated modules without explicit user permission.
3. **Classify, Document & Recommend (Never Change Without Approval):**
   - Record every identified opportunity in `lifecycle/05-finalize.md` under `## 2. Quality & Audit Evidence` (Assessed Improvements).
   - For every worthwhile opportunity, present a concise recommendation in chat:
     - **Location:** Affected files and current behavior.
     - **Proposed Change:** What should change and expected benefit.
     - **Recommendation:** Implement now (returns to Phase 4), plan as a follow-up task, or defer to future backlog.
   - **Wait for explicit user approval.** If approved, update `lifecycle/03-plan.md` and return to Phase 4 — Build to implement and verify the change. If declined or deferred, record the user's decision in `lifecycle/05-finalize.md` and proceed without editing.

### 3.3 Step 3 — Permanent Documentation & Handover

1. **Synchronize Permanent Documentation via Documentation Treeing:**
   Structure permanent project knowledge hierarchically from Trunk to Leaves:
   - **Level 1 (Trunk — Module README at `docs/modules/<module>/README.md`):** Module orientation page summarizing business purpose, core data models, feature directory index, and cross-module boundaries.
   - **Level 2 (Branches — Feature Document at `docs/modules/<module>/feature_<name>.md`):** Deep feature specification describing end-to-end primary workflows, alternate paths, and component touchpoints.
   - **Level 3 (Leaves — Invariants & Decisions):** Scoped non-negotiable Business Rules (`BR-X`) and Consequential Architectural Decisions (`DEC-X`).
   - **Root Updates (`README.md` / `GLOSSARY.md`):** Update root `README.md` if setup or commands changed; promote new or updated `Core Terms` from `lifecycle/01-discover.md` into the root `GLOSSARY.md` so domain vocabulary is permanently preserved after `lifecycle/` cleanup.
   - *Format Rule:* Document verified truth with scannable nested sub-bullets. Link rather than duplicate.
2. **Review Upstream Friction (`lifecycle/refine.md`):**
   - Review entries recorded in `lifecycle/refine.md` across earlier phases (or append any Finalize-specific friction) to synthesize actionable framework or project rule recommendations.
3. **Prepare Copyable PR Summary:**
   Author a clean, evidence-based PR summary directly in `lifecycle/05-finalize.md` under `## 3. Pull Request Summary` and present it in chat for the user to copy into GitHub/GitLab:
   - **Outcome Summary:** Problem solved and delivered user capability.
   - **Key Changes & Files:** Core files created or modified with 1-line descriptions.
   - **Verification Evidence:** Exact test runner commands, results, and manual check proofs.
   - **Known Limitations:** Any unrun checks or explicitly deferred edge cases.
4. **Execute the Artifact Cleanup Gate (Delete, Archive, or Keep):**
   Because `lifecycle/` contains temporary development artifacts (`01-discover.md`, `02-flows.md`, `03-plan.md`, `refine.md`, `05-finalize.md`) and permanent knowledge is now in `docs/`:
   - Run read-only `git status` to inspect existing lifecycle files.
   - Ask the user in chat to make the **Artifact Decision for `lifecycle/`**:
     - **1. Delete:** Remove the temporary `lifecycle/` directory (cleanest; permanent docs already committed in `docs/`).
     - **2. Archive:** Move `lifecycle/` to an archive location (e.g. `docs/archive/<feature-name>/`).
     - **3. Keep:** Retain the `lifecycle/` directory in place (default).
   - **Stop and wait for the user's explicit choice.** Never delete or move `lifecycle/` without explicit user permission.
   - Execute only the authorized choice.

---

## 4. Exit Gate & Completion Criteria

Phase 5 marks the formal conclusion of the development lifecycle.

### Completion Checklist (Pre-Flight Gate)

Before requesting user approval, verify that:
- **Outcomes Verified:** All Target Features and the core Goal from `lifecycle/01-discover.md` are verified against actual code and test evidence.
- **Code Audit Passed:** Integrated system passes technical audit (seams, security invariants, diff hygiene).
- **Orphan Hunter Audit Clean:** Zero orphaned exports, dead route registrations, dangling imports, or stale mocks remain.
- **Global Checks Honestly Documented:** Project test suite and static analyzers run with results recorded (`Passed`, `Failed`, `Not Run`).
- **Improvement Assessment Complete:** All identified opportunities were presented and decided by the user (approved, declined, or deferred).
- **Permanent Docs Synchronized:** `docs/modules/` accurately reflects the final implementation.
- **Core Terms Promoted:** New domain vocabulary from `01-discover.md` promoted to root `GLOSSARY.md`.
- **Friction Log Reviewed:** `lifecycle/refine.md` reviewed for upstream skill or rule improvements.
- **PR Summary Ready:** Copyable PR summary prepared in `lifecycle/05-finalize.md`.
- **Artifact Cleanup Decision Authorized:** User's choice (Delete, Archive, or Keep) executed.

### Requesting User Approval (Phase 0 Protocol)

1. Follow the **Phase 0 Chat Approval Protocol** to present verified outcomes, updated permanent docs, the copyable PR Summary, and request the **Artifact Decision for `lifecycle/`** (Delete, Archive, Keep).
2. Stop calling tools immediately and wait for the user's explicit response.

### Gate Outcomes

- **Approved:** All phases in `lifecycle/00-status.md` are marked `Done`. The feature is officially complete and the working tree is ready for the user's manual git commit.
- **Changes Requested:** Narrow fixes are addressed in-place; substantive defects return to Phase 4 — Build.
- **Blocked:** A critical architectural invariant, security failure, or regression remains unresolved. Halt and escalate to the user with evidence.

---

## 5. Phase Output

The deliverables of Phase 5 are:

1. **Finalize Audit & Handover Document:** `lifecycle/05-finalize.md` capturing verification proof, assessed improvements, permanent doc links, and copyable PR summary.
2. **Synchronized Permanent Documentation:** Updated files under `docs/modules/<module>/README.md`, `docs/modules/<module>/feature_<name>.md`, root `README.md`, and root `GLOSSARY.md`.
3. **Completed Status Dashboard:** `lifecycle/00-status.md` showing all phases marked `Done`.
4. **Reviewed Refinement Log (`lifecycle/refine.md` — Optional):** Upstream friction reviewed for central skills improvement.

### Recommended Structure for `lifecycle/05-finalize.md`

```markdown
# Finalize: [Requirement / Feature Name]

## 1. At a Glance
- **Outcome:** ✅ All target features verified against code and test evidence.
- **Global Checks:**
  | Suite / Command | Result | Notes |
  | :--- | :--- | :--- |
  | `npm test` | `Passed` | 42 passed, 0 failed |
  | `flutter analyze` | `Passed` | 0 issues found |
- **Permanent Docs:** Updated [`docs/modules/<module>/README.md`](../docs/modules/<module>/README.md) and [`docs/modules/<module>/feature_<name>.md`](../docs/modules/<module>/feature_<name>.md).

## 2. Quality & Audit Evidence
- **Feature Traceability:**
  - `[Feature 1]`: Verified against unit tests and manual steps.
  - `[Feature 2]`: Verified against Cloud Functions integration tests.
- **Code Hygiene & Orphans:** 0 orphaned routes/exports, 0 temporary mocks, 0 debug logs.
- **Assessed Improvements:**
  - `[Opportunity 1]`: [Brief note + Decision: Approved (created Task 4.x) / Deferred / Declined]

## 3. Pull Request Summary
```markdown
### Summary
[1-2 paragraph summary of delivered functionality]

### Key Changes & Touchpoints
- `path/to/file1.ext`: [Change description]
- `path/to/file2.ext`: [Change description]

### Verification
- [Passing automated test suites]
- [User verification confirmed]
\```
```

### Recommended Structure for `docs/modules/<module>/README.md`

```markdown
# Module: <Module Name>

## 1. At a Glance
- **Purpose:** <1-line summary of what business area this module owns>
- **Owns:** <Core responsibilities or data models>
- **Does not own:** <Important ownership boundary or delegated responsibilities>

## 2. Shared Concepts & Data Models
- **`<Core Model / Entity>`:** `<path/to/model.ext>` — <1-line purpose in this module>

## 3. Data & Storage Schemas
- **`<collection_or_table>`** (`key: <auto-id / userId>`): <1-line purpose, key fields, and consistency rules>

## 4. Feature Directory Index
- **[`feature_<name_1>.md`](feature_<name_1>.md):** <1-line capability summary>

## 5. Scope Boundaries & Cross-Module Dependencies
- **Consumes:** `<Module / Service>`: <Data or event read/consumed>
- **Exposes:** `<Service / Stream / Event>`: <Public API contract exposed to callers>
- **Delegated ownership:** `<Capability>`: <Which module owns this responsibility instead>
- **Deferred (Future Backlog):** `<Deferred Idea>`: <1-line summary and why deferred>
```

### Recommended Structure for `docs/modules/<module>/feature_<name>.md`

```markdown
# Feature: <Feature Name>

## At a Glance
- **Problem:** <1-line user or operational pain this feature addresses>
- **Capability:** <1-line summary of what this feature enables>
- **Entry point:** `<Route /items, button on FeatureCard, or background push event>`

## 1. Primary Workflow
1. <User action or trigger event>
2. <Validation, state transition, or controller/repository dispatch>
3. <Observable UI or persistence result>

## 2. Important Alternate & Failure Paths
- **Empty / first use:** <Behavior when 0 records exist or unconfigured>
- **Validation / error / offline:** <Failure behavior and recovery>
- **Permissions / tenancy:** <Allowed vs. denied behavior>
- **Concurrency / retry:** <Debounce, lock, idempotency, or stale-state guard>
- **Data lifecycle / side effects:** <Linked records, audit trail, migration, or cleanup>

## 3. Business Rules & Module Invariants
- **BR-1 (`<Rule Name>`):** <1-line state, calculation, or validation law>
- **BR-2 (`<Rule Name>`):** <1-line permission, lifecycle, or consistency law>

## 4. Architecture & File Touchpoints
- **Controllers & State:** `<path/to/file>` — <1-line responsibility>
- **Views & UI Components:** `<path/to/file>` — <1-line responsibility>
- **Data & Validators:** `<path/to/file>` — <1-line responsibility>
- **Routes & Integrations:** `<path/to/file>` — <1-line responsibility>

## 5. Security, Tenancy & Operational Constraints
- **Authorization:** <Permission or role required and where access is enforced>
- **Tenant / resource isolation:** <How tenant filtering is enforced on reads/writes>
- **Fail-closed policy & audit:** <What happens when credentials/permissions fail and what is logged>

## 6. Consequential Architectural Decisions
- **Decision 1 (`<Topic>`):**
  - Chosen: <1-line confirmed approach>
  - Why: <Evidence and main trade-off>
  - Alternative rejected: <Meaningful alternative and why it was not selected>
  - Consequences / revisit trigger: <Risk or condition that would justify revisiting>
```
