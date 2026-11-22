---
name: lifecycle-close
description: Verify complete outcomes, audit code quality, assess improvement opportunities, synchronize permanent docs, synthesize friction logs, and complete handover (Lifecycle: Phase 5 — Close).
---

# Phase 5 — Lifecycle Close

## 1. Purpose

> **Core Mental Model:** Verify the whole picture against `01-discover.md`. Clean up orphans. Document verified truth. Hand over a ready-to-paste PR summary.

Independently verify the complete integrated implementation against its original Goal and `F-N` features, audit code hygiene and security seams, assess improvements (change only with approval), synchronize permanent documentation, review 100% of `lifecycle/refine.md`, and execute the user's cleanup choice for `lifecycle/`.

---

## 2. Core Rules

- **Verify Integrated Outcomes With Real Evidence (Not Checklists):** Phase 4 verified individual tasks; Phase 5 verifies the complete system against the Goal and exact `F-N` features in `lifecycle/01-discover.md` using actual code, analyzer, and test runs. Report every check honestly as `Passed`, `Failed`, or `Not Run` (distinguishing pre-existing baseline failures from new regressions).
- **Orphan Hunter & Link Parity Audit:** Grep for lingering exports, dead routes, dangling imports, stale test mocks, or debug logs after any rename/delete, and confirm `00-status.md` task titles and anchor links match `03-plan.md` and final screen/module names.
- **Improve Proactively, Never Change Without Approval:** Identify deduplication, modernization, or quality improvements across touched files and present recommendations with trade-offs in chat, but never implement any extra change — even minor — without explicit user approval. Never edit shared cross-module infrastructure without permission.
- **Narrow Mechanical Fixes vs. Returning to Build:** Trivial typos or unused imports on touched files may be fixed in-place and re-verified; any behavioral, architectural, data-integrity, or security defect must return to Phase 4 — Build as a formal task.
- **Document Verified Truth Only:** Permanent docs in `docs/modules/` and root `GLOSSARY.md` must reflect the final verified implementation — never temporary plans or abandoned ideas. Always copy `**Deferred:**` items from `01-discover.md` into `docs/modules/<module>/README.md`.
- **100% Friction Log Accountability:** Account for every `Entry #` in `lifecycle/refine.md` under `## 4. Friction Log Review` (zero entries silently skipped).
- **Preserve `lifecycle/` Until Explicit User Choice:** Never delete or move `lifecycle/` without the user's explicit choice (`Delete`, `Archive`, or `Keep`) at the Artifact Cleanup Gate. No new feature exploration or scope expansion in Phase 5.

---

## 3. Execution Sequence

### 3.1 Step 1 — Verify Integrated Outcomes & Technical Code Audit

1. **Verify Intended Outcomes & Exact `F-N` Traceability:**
   - Trace each Target Feature from `lifecycle/01-discover.md` into the implementation and automated tests using its exact `F-N` IDs — never invent new prefix schemes during Close.
   - Verify the core Goal and critical user journeys (including empty, validation, permission, concurrency, and failure paths) work end-to-end.
2. **Audit Seams, Security & Orphans:**
   - Check routes, navigation, state contracts, and authorization checks at the enforcement boundary (not merely hiding UI).
   - Run dedicated `grep` searches for orphaned exports, dead routes, dangling imports, stale test mocks, and debug statements (`console.log`, `print`, `debugger`).
   - Verify `lifecycle/00-status.md` task titles and anchor links match `lifecycle/03-plan.md` headings and final screen/module names.
3. **Run Global Verification Suite:**
   - Run the project linter/analyzer and full relevant test suites, recording exact commands and honest results (`Passed`, `Failed`, `Not Run`) in `lifecycle/05-close.md` under `## 1. At a Glance`.
   - Fix trivial mechanical typos/unused imports in-place; halt and return to Phase 4 — Build for any behavioral or security defect.

### 3.2 Step 2 — Improvement Assessment & Smart Deduplication

1. **Identify Opportunities:** Search touched files for intra-module duplication or modernization opportunities (never touch shared cross-module files without permission).
2. **Recommend Without Editing:** Record every opportunity in `lifecycle/05-close.md` under `## 3. Quality & Audit Evidence` (Assessed Improvements) and present worthwhile items in chat with **Location**, **Proposed Change**, and **Recommendation** (implement now via Phase 4, plan follow-up, or defer). Wait for explicit approval before implementing; record declined/deferred choices in `05-close.md`.

### 3.3 Step 3 — Permanent Documentation, Friction Review & Handover

1. **Synchronize Permanent Documentation (`docs/` & `GLOSSARY.md`):**
   - **Module README (`docs/modules/<module>/README.md`):** Purpose, core models, schemas, feature index, boundaries, and all `**Deferred:**` items copied from `lifecycle/01-discover.md` (`## 3`) under `Deferred (Future Backlog)`.
   - **Feature Doc (`docs/modules/<module>/feature_<name>.md`):** Verified primary workflow, alternate/failure paths, Business Rules (`BR-X`), file touchpoints, security constraints, and consequential Decisions (`DEC-X`).
   - **Root Updates (`README.md` / `GLOSSARY.md`):** Update root `README.md` if setup/commands changed; promote new or updated terms from `## 5. Glossary (Core Terms)` in `lifecycle/01-discover.md` into root `GLOSSARY.md` (creating it from the `§5` template if missing).
2. **Prepare Copyable PR Summary (`## 2. Pull Request Summary` in `05-close.md`):**
   - Place directly after `## 1. At a Glance` for instant copy-paste into GitHub/GitLab: PR Title (`feat(<module>): ...`), Outcome Summary, Key Changes & Touchpoints, Verification Evidence, and Known Limitations (if any).
3. **Review Upstream Friction (`lifecycle/refine.md`) — 100% Entry Coverage:**
   - Review every entry in `lifecycle/refine.md` (if empty, explicitly note it was checked and empty).
   - Account for **every Entry #** under `## 4. Friction Log Review`: group `One-off` and `Project-specific` entries by Entry # (e.g. `Entries 8–12, 14`), and list every `Framework-wide` entry individually with its Entry # and concrete Preventive Change (target skill/rule file and exact update).
4. **Execute the Artifact Cleanup Gate (Delete, Archive, or Keep):**
   - Run read-only `git status` and ask the user to choose for `lifecycle/`: **1. Delete**, **2. Archive** (e.g. `docs/archive/<feature-name>/`), or **3. Keep** *(Default)*.
   - Stop and wait for explicit authorization; execute only the authorized choice.

---

## 4. Exit Gate & Completion Criteria

### Pre-Flight Checklist

Before requesting final approval, verify:
- **Outcomes & Seams Verified:** Goal and every exact `F-N` feature verified against real code/tests; Orphan Hunter and `00-status.md` anchor audit clean.
- **Global Checks Documented:** Analyzer/linter and test suites run and honestly recorded (`Passed` / `Failed` / `Not Run`).
- **Improvements Decided:** All identified opportunities presented and decided by the user.
- **Permanent Docs & Glossary Synced:** `docs/modules/` updated with `Deferred` backlog items copied; `Glossary (Core Terms)` promoted to root `GLOSSARY.md`.
- **100% Friction Log Accounted For:** Every `Entry #` in `lifecycle/refine.md` classified and every `Framework-wide` entry given a concrete Preventive Change in `05-close.md`.
- **PR Summary & Cleanup Ready:** Copyable PR summary prepared in `## 2` of `05-close.md`; user's `lifecycle/` cleanup choice authorized and executed.

### Requesting User Approval (Phase 0 Protocol)

1. Set Phase 5 to `In Review` in `lifecycle/00-status.md`.
2. Output a concise 1–2 sentence summary linking `[05-close.md](05-close.md)` and ask the user to choose whether to **Delete**, **Archive**, or **Keep** `lifecycle/`.
3. Stop calling tools and wait for the user's explicit response (`Approved` → mark Phase 5 `Done`; working tree ready for manual git commit).

---

## 5. Output Templates

### Recommended Structure for `lifecycle/05-close.md`

```markdown
# Close: [Requirement / Feature Name]

## 1. At a Glance

**Outcome:**
✅ All target features verified against code and test evidence.

**Global Checks:**

| Suite / Command | Result | Notes |
| :--- | :--- | :--- |
| `npm test` | `Passed` | 42 passed, 0 failed |
| `flutter analyze` | `Passed` | 0 issues found |

**Permanent Docs:**
- Updated [`docs/modules/<module>/README.md`](../docs/modules/<module>/README.md)
- Updated [`docs/modules/<module>/feature_<name>.md`](../docs/modules/<module>/feature_<name>.md)
- Updated [`GLOSSARY.md`](../GLOSSARY.md)

## 2. Pull Request Summary

**PR Title:** `feat(<module>): <concise summary of delivered change>`

````markdown
### Summary
[1–2 concise paragraphs describing delivered capability]

### Key Changes & Touchpoints
- `path/to/file1.ext`: [1-line change description]
- `path/to/file2.ext`: [1-line change description]

### Verification
- [Passing automated test suites]
- [User verification confirmed]
````

## 3. Quality & Audit Evidence

**Feature Traceability (`F-N` from `01-discover.md`):**
- `F1 — [Feature 1 Name]`: Verified against unit tests and manual steps.
- `F2 — [Feature 2 Name]`: Verified against integration tests and manual steps.

**Code Hygiene, Orphans & Links:**
- 0 orphaned routes/exports, 0 temporary mocks, 0 debug logs; `00-status.md` anchors verified.

**Assessed Improvements:**
- `[Opportunity 1]`: [Brief note + Decision: Approved (Task 4.x) / Deferred / Declined]

## 4. Friction Log Review

- **One-off / Project-specific:** Entries [list Entry #s] — [1-line summary].
- **Framework-wide:**
  - **Entry [N] (`<Target rule/skill>`):** [Concrete preventive rule/skill update].

## 5. Artifact Cleanup Decision

Awaiting user choice for `lifecycle/`:
1. **Delete** — remove `lifecycle/` (permanent docs already in `docs/`).
2. **Archive** — move `lifecycle/` to `docs/archive/<feature-name>/`.
3. **Keep** *(Default)* — keep `lifecycle/` in place.
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

### Decision 1 (`<Topic>`)
- **Chosen:** <1-line confirmed approach>
- **Why:** <Evidence and main trade-off>
- **Alternative rejected:** <Meaningful alternative and why it was not selected>
- **Consequences / revisit trigger:** <Risk or condition that would justify revisiting>
```

### Recommended Structure for `GLOSSARY.md` (Project Root — Required)

```markdown
# Domain Glossary

Core business and domain terms used across code, UI copy, and documentation.

- **[Term]:** [1-line plain-English definition] *(Module: `<module>`)*
```
