---
name: lifecycle-plan
description: Convert approved designs and prototypes into an actionable implementation plan with feature-mapped tasks, task-specific rules, and two-tier verification (Lifecycle: Phase 3 — Plan).
---

# Phase 3 — Lifecycle Plan

## 1. Purpose

> **Core Mental Model:** Map target features to verifiable tasks. Assign rules where the code changes. Specify what the agent verifies first, then how the user verifies.

Convert approved Designs and Prototypes from Phase 2 into a complete, technically clear, and actionable **Implementation Plan** (`lifecycle/03-plan.md`).

This phase ensures that before Phase 4 — Build begins, the Agent and User have total alignment on:
- Target features divided into logical, independently verifiable vertical tasks.
- Dependency ordering and execution sequence (Steel Thread first, then hardening).
- Atomic changes (`C1`, `C2`...), file targets, and schemas introduced directly within their owning tasks.
- Applicable project rules assigned individually by name and file path under Agent Verification.
- Two-Tier verification: automated checks and rule compliance the Agent verifies first, followed by clear Setup, Action, and Expected steps for the User.

---

## 2. Guiding Principles

- **Feature-Driven Breakdown & Task Treeing:** Directly map the Discover requirement tree into a task tree: Goal (Trunk) → Target Features (Branches) → Steel Thread and Edge Tasks (Leaves). The numbered **`F-N.x` items** and **`F-N-Ex` Edge Cases** in `lifecycle/01-discover.md` are the authoritative source of what every feature contains — Plan's job is to assign implementation order and file targets to each item, not to rediscover or reinterpret what to build.
- **Feature Item → Task Traceability (Mandatory):** Every `F-N.x` item and `F-N-Ex` edge case from Discover must map to at least one task change (`C1`, `C2`...). No item may be silently skipped, collapsed, or reworded. If an item cannot map to a concrete task, it must be flagged and returned to Discover for clarification before Plan proceeds.
- **Small, Reviewable Feature-Scoped Tasks (3–6 Files Target):** Keep every task small enough for a 5-minute review (roughly **3–6 files**, max ~8). Never stuff an entire multi-stack feature (backend + rules + models + UI + routing = 20+ files) into one mega-task. Instead, split each feature cleanly in dependency order so every task compiles, passes its own rule/test checks, and stops for user approval.
- **Blast Radius Tagging:** Tag every task with its blast radius to govern execution risk:
  - `🟢 Low (<5 words reason):` e.g., `🟢 Low (isolated component)`
  - `🔴 High (<5 words reason):` e.g., `🔴 High (shared database schema)`
- **Task-Level Architecture:** Concrete changes (`C1`, `C2`...), target file mappings, schemas, and logic are defined directly inside the tasks responsible for them, eliminating duplicate documentation.
- **Prefactoring Check (Rule Thresholds — 900/1000 lines):** Inspect existing target files before planning feature changes. If a target file already exceeds the 900-line evaluate threshold, or the planned change would push it past the 1000-line hard limit, schedule an upfront `Prefactor <Target>` task (*"Make the change easy, then make the easy change"*) to extract sub-components or helpers before feature implementation begins.
- **Compile-Clean Slices & Temporary Alias Cleanup:** Every task must leave the codebase in a compile-clean, testable state. If an early task renames or removes a symbol needed by later tasks, either update all callers in that task or introduce a temporary compatibility alias that is explicitly scheduled for deletion in the task that migrates the final caller.
- **Backward Compatibility & Live Data Fallbacks:** When modifying database schemas, storage collections, or API contracts across independently deployed layers (e.g., client apps vs. backend cloud functions/microservices), tasks must explicitly account for live data coexistence. Readers must include fallback handling for legacy fields or unmigrated documents, guaranteeing zero disruption for active sessions or older client versions during phased rollouts.
- **Task-Specific Rule Enforcement:** Assign relevant rules individually inside the task's **Agent Verification** section with explicit rule names and file paths (`- Rule [<Rule Name>]: <path/to/rule.md>`) so the agent has semantic clarity and verifies compliance where the code changes.
- **Two-Tier Verification:** Separate Agent Verification (automated tests and rule compliance checks the agent must run first) from User Verification (clear Setup, Action, and Expected steps for the user).
- **Verifiable Execution Order (Producer-Before-Consumer Invariant):** Sequence capabilities so every task is verifiable with real state—never hypothetical guesswork. Producers (Create/Ingest) must precede Consumers (Read/List), and Consumers must precede Modifiers/Teardown (Update/Delete). You cannot verify a list without data, and you cannot verify an edit or deletion without seeing state before and after.
- **Producer-Consumer Wire Invariant:** Every boundary crossing (URL query param, webhook, emitted event, job queue) MUST have a 1:1 pair of scheduled tasks: exactly one Producer task (emits/redirects) and exactly one Consumer task (ingests/persists). Planning an emitter without its receiver, or a consumer without its extractor, is strictly prohibited.
- **Dependency-Aware Sequencing:** Foundational slices (migrations, core domain utilities) must be sequenced before dependent feature and UI tasks.
- **No Unnecessary Fragmentation:** Tasks must be small enough to implement and verify easily, without creating unnecessary handoffs or trivial one-line tasks.
- **Strict Phase Boundaries (Negative Constraints):**
  - **No Production Code:** Writing or modifying application source code, tests, or database schemas belongs to Phase 4 — Build.
  - **No Test Execution:** Executing test suites or verifying code compliance belongs to Phase 4 — Build.
  - **No Layer-Cake Batching:** Ban horizontal batching (all DB, then all API, then all UI). Tasks must remain vertical slices.
  - **No Unilateral Scope Changes:** Never invent new capabilities or reopen settled scope; always trace directly to `lifecycle/01-discover.md`.
- **Friction Logging (`lifecycle/refine.md`):** Whenever an `F-N.x` item cannot be directly mapped to a task (indicating a gap in Discover), a sequencing rule produces an unworkable order, a skill instruction is ambiguous, or any planning friction arises that would recur on the next project — immediately append an entry to `lifecycle/refine.md`. Do not wait until phase exit.

---

## 3. Responsibilities & Sequence

Phase 3 progresses through three natural chronological steps:

### 3.1 Step 1 — Input Review & Prefactoring Inspection

1. **Review Approved Upstream Deliverables:**
   - For each feature in `lifecycle/01-discover.md`, extract its **`F-N.x` items** and **`F-N-Ex` Edge Cases** — the complete, user-confirmed list of every element, action, interaction, and navigation the feature must contain. This list is the non-negotiable scope input for Plan; do not reinterpret or expand it.
   - Review approved visual flows and prototypes from `lifecycle/02-design.md` (and `lifecycle/02-prototype.html` if UI). Every interactive element in the prototype must trace back to an `F-N.x` item.
   - Understand existing architecture, dependencies, and constraints via read-only searches.
2. **File-Size & Prefactoring Inspection:**
   - Check line counts of target files likely to be modified against Rule File thresholds.
   - If any target file exceeds the 900-line evaluate threshold (or planned changes would push it past the 1000-line hard limit), plan an upfront extraction task before adding feature logic.
3. **Map Target Features 1:1 (Keep `F-N` IDs Visible):**
   - Start `lifecycle/03-plan.md` directly with `## Coverage Map (Discover → Plan)` followed immediately by the feature sections (`## F1 — [Feature Name]`, or `## F1 & F3 — ...` if two features share one end-to-end flow).
   - Every task title must describe a clear, reviewable goal in plain English.
   - Do not create intermediate "Outcomes" layers or narrative architecture preambles before the Coverage Map.

### 3.2 Step 2 — Task Treeing & Full Task Anatomy

1. **Decompose Features into Small Reviewable Slices (3–6 Files Each):**
   - **Step A — Prefactoring (if needed):** Split any existing file near the 900/1000-line limit before adding new code.
   - **Step B — Backend + Security Rules (per feature):** Server functions, third-party adapters, and database/storage security rules + rules tests.
   - **Step C — Models, Repository & State (per feature):** Data models, Direct SDK repository, and state providers.
   - **Step D — UI & Route (per feature):** Screens, dialogs, `design_system.md` compliance, and router/sidebar entry point (wired in the first UI task so it is immediately reachable).
   - **Step E — Secondary Flows & Hardening:** Remaining list/edit/delete slices, empty/error states, and edge-case tests.
2. **Author Explicit Task Anatomy:**
   Every task in `lifecycle/03-plan.md` must adhere to this standardized structure:

   ```markdown
   ### Task 4.1: Database Schema & Session Models

   **Blast Radius:** 🔴 High (shared database schema & user models)

   **Changes:**
   - **C1:** Create `users` table with unique lowercase index on `email`.
   - **C2:** Create `tokens` table with foreign key cascade to `users.id`.
   - **C3:** Add session tracking fields to User model:
     - Add `sessionCount` integer defaulting to 0 for unmigrated records.
     - Add `activeDeviceIds` array with null-safe fallback to `[]`.
     - Enforce max 5 concurrent devices limit.

   **Files:**
   - C1, C2: `src/migrations/001_auth_tables.sql` (Add)
   - C3: `src/models/user.ts` (Update)

   **Agent Verification:**
   - Rule [Idempotent Migrations]: `.agents/rules/database_migrations.md`
   - Rule [Safe Rollback Verification]: `.agents/rules/database_migrations.md`
   - Rule [Token Validation & Expiry Invariant]: `.agents/rules/security_invariants.md`
   - Run `npm run migrate:up` -> tables created cleanly.
   - Run `npm run migrate:down` -> rollback drops tables cleanly.

   > **User Verification**
   > - **Setup:** Ensure local PostgreSQL service is running (`pg_isready`).
   > - **Action:** Run `psql -d app_dev -c "\d users"` in terminal.
   > - **Expected:** Displays `users` table schema showing expected columns and index.
   ```

3. **Assign Individual Named Rules Under Agent Verification:**
   - Assign every relevant rule as its own dedicated bullet (`- Rule [<Rule Name>]: <path/to/rule.md>`). Never use vague section numbers (e.g. "Section 2"); explicit rule names activate the agent's semantic attention and provide exact, drift-proof guidance.
4. **Define Two-Tier Verification Contracts:**
   - **Agent Verification (Automated Pre-Flight & Rule Compliance):** Dedicated bullets for each applicable named rule followed by automated test and verification commands. In Phase 4 Build, the agent must execute these and include passing evidence in the chat completion report before requesting human review.
   - **User Verification (Human Testing Guide):** Foolproof 3-line guide (`Setup`, `Action`, `Expected`) enabling the user to validate the feature in seconds.
5. **Populate the Coverage Map (`Discover → Plan`):**
   - Fill in `## Coverage Map (Discover → Plan)` at the top of `lifecycle/03-plan.md` so every `F-N.x` item and `F-N-Ex` Edge Case from `lifecycle/01-discover.md` maps explicitly to a planned `Task 4.x (CN)` with zero `⚠️ Missing` rows.

### 3.3 Step 3 — Sequencing, Compatibility & Dashboard Population

1. **Sequence Tasks by Verifiable Dependency Order:**
   > **This is Plan's primary contribution:** Discover defines *what* each feature contains (`F-N.x` items). Plan defines *in what order* small, reviewable tasks are built and *which files* they live in:
   - `Task 4.0 (Prefactoring — if needed):` Split existing files near 900/1000 lines before adding code.
   - `Per Feature (`F-N`), Producer-Before-Consumer Order:`
     1. **Backend + Security Rules:** Cloud Functions / API + DB security rules + rule tests (so live UI testing never hits `PERMISSION_DENIED`).
     2. **Models, Repository & State:** Data models, repository queries/mutations, and state providers.
     3. **UI & Route:** Screen/dialog components + router/sidebar wiring (compiles cleanly with real models/state and is testable in the app immediately).
     4. **Modifiers, Teardown & Hardening:** Cancel/delete actions, empty/error views, and edge-case checks.
   - **Mandatory Review Gate:** Every task pauses at `In Review` for user approval before the next task starts.
2. **Enforce Backward Compatibility & Live Data Fallbacks:**
   - Verify that readers handle legacy fields and unmigrated documents gracefully during phased rollout.
3. **Populate Status Dashboard Upon Approval:**
   - When the plan is approved, populate all planned tasks into `lifecycle/00-status.md` under Phase 4 Build with status `Todo` and section anchor links: `[Task 4.1: <Title>](03-plan.md#task-41-title)`.

---

## 4. Exit Gate & Completion Criteria

Phase 3 can transition to Phase 4 — Build only when the completion checklist is fully satisfied and the user grants explicit approval in chat.

### Completion Checklist (Pre-Flight Gate)

Before requesting user approval, verify that:
- **1:1 Feature Mapping (`F-N`):** All Target Features from Discover are mapped directly as `## F-N — <Feature Name>` headings.
- **Coverage Map Complete (`Discover → Plan`):** `## Coverage Map` at the top of `03-plan.md` accounts for every `F-N.x` item and `F-N-Ex` Edge Case from `01-discover.md` with zero `⚠️ Missing` rows.
- **Small Reviewable Tasks:** Each task targets roughly 3–6 files (never a 20+ file mega-task) and follows `Prefactoring → Backend + Rules → Models/Repo/State → UI + Route`.
- **Complete Task Anatomy:** Every task specifies Blast Radius ($\le 5$ words), Changes (`C1`, `C2`... with sub-bullets for multi-point details), Files (mapped to C-IDs with action verbs), Agent Verification (individual named rules `- Rule [<Rule Name>]: <path>` and automated test commands), and User Verification (`Setup`, `Action`, `Expected`).
- **Prefactoring Scheduled:** Any file approaching the 900/1000-line threshold has an upfront extraction task.
- **Backward Compatibility:** Schema and contract changes include live data fallback handling.
- **Logical & Verifiable Sequencing:** Foundation tasks precede dependent UI tasks, and Producer capabilities (Create/Ingest) precede consumers (Read/List) and modifiers (Update/Delete), guaranteeing testability with real state on every task without synthetic mocks.
- **Wire Completeness:** Every boundary crossing (URL query param, webhook, emitted event, job queue) has both an emitting task and an ingesting task explicitly scheduled.
- **Design-to-Plan Reconciliation:** Reconcile every interactive element, input field, and status badge from `02-design.md` against task changes. Zero visual or interactive elements may be silently omitted.
- **Zero Ambiguity:** No unresolved architectural questions or placeholder tasks remain.

### Requesting User Approval (Phase 0 Protocol)

1. Update Phase 3 status to `In Review` in `lifecycle/00-status.md`.
2. In chat, output a concise 1–2 sentence summary linking `[03-plan.md](03-plan.md)` with total task count, blast radius summary, and ask for explicit approval to advance to Phase 4 — Build.
3. Stop calling tools immediately and wait for the user's explicit response.

### Gate Outcomes

- **Approved:** Mark Phase 3 as `Done` in `lifecycle/00-status.md`, populate all planned tasks under Phase 4 as `Todo` (with section anchor links `[Task 4.X: ...](03-plan.md#task-4x-...)`), load `lifecycle-build`, and advance to Phase 4 — Build.
- **Changes Requested:** Mark Phase 3 `In Progress`, revise tasks in `lifecycle/03-plan.md`, and re-present.
- **Blocked:** An architectural unknown or requirement conflict prevents planning. Return to Discover or Design for clarification.

---

## 5. Phase Output

The primary deliverable of Phase 3 is the **Centralized Implementation Plan** saved to `lifecycle/03-plan.md`.

### Recommended Structure for `lifecycle/03-plan.md`

```markdown
# Plan: [Requirement / Feature Name]

## Coverage Map (Discover → Plan)

| ID | Item Summary from `01-discover.md` | Planned In |
| :--- | :--- | :--- |
| **F1.1** | [Short summary of `F1.1`] | Task 4.x (`C1`) |

## F1 — [Feature 1 Name]

### Task 4.1: [Task Title]

**Blast Radius:** [🟢 Low (<5 words reason) / 🔴 High (<5 words reason)]

**Changes:**
- **C1:** [Single atomic change description]
- **C2:** [Multi-point change description]:
  - [Specific constraint, field, or validation detail 1]
  - [Specific fallback, error handling, or lifecycle detail 2]

**Files:**
- C1: `path/to/file1.ts` ([Add / Update / Delete / Refactor / Fix])
- C2: `path/to/file2.ts` ([Add / Update / Delete / Refactor / Fix])

**Agent Verification:**
- Rule [<Rule 1 Name>]: `.agents/rules/rule1.md`
- Rule [<Rule 2 Name>]: `.agents/rules/rule2.md`
- [Specific automated test command or build verification check]
- [Second automated check if applicable]

> **User Verification**
> - **Setup:** [Prerequisite state or server command]
> - **Action:** [Exact steps to test in the running app]
> - **Expected:** [What to observe]

---

### Task 4.2: [Task Title]

## F2 — [Feature 2 Name]

### Task 4.3: [Task Title]
```
