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

- **Feature-Driven Breakdown & Task Treeing:** Directly map the Discover requirement tree into a task tree: Goal (Trunk) $\to$ Target Features (Branches) $\to$ Steel Thread and Edge Tasks (Leaves).
- **Vertical "Steel Thread" Slicing:** Ban horizontal layer-cake task plans (e.g., Task 1: all DB models, Task 2: all API controllers, Task 3: all UI screens). Every task must implement a thin vertical slice through the stack. Task 1 is always the **Steel Thread** (the minimal end-to-end happy path from data to UI that compiles and runs immediately); subsequent tasks add edge recovery, validation, and hardening.
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

---

## 3. Responsibilities & Sequence

Phase 3 progresses through three natural chronological steps:

### 3.1 Step 1 — Input Review & Prefactoring Inspection

1. **Review Approved Upstream Deliverables:**
   - Review confirmed Target Features and Core Terms from `lifecycle/01-discover.md`.
   - Review approved visual flows and prototypes from `lifecycle/02-design.md` (and `lifecycle/02-prototype.html` if UI).
   - Understand existing architecture, dependencies, and constraints via read-only searches.
2. **File-Size & Prefactoring Inspection:**
   - Check line counts of target files likely to be modified against Rule File thresholds.
   - If any target file exceeds the 900-line evaluate threshold (or planned changes would push it past the 1000-line hard limit), plan an upfront extraction task before adding feature logic.
3. **Map Target Features 1:1:**
   - Structure `lifecycle/03-plan.md` around the exact **Target Features** from Discover.
   - Each top-level feature heading in `03-plan.md` must match the corresponding feature in Discover and Design **1:1** as a level-2 header (e.g. `## User Sign Up & Verification`).
   - Do not create intermediate "Outcomes" layers, Section 1 architecture preambles, or prefix headings with `Feature 1:`.

### 3.2 Step 2 — Task Treeing & Full Task Anatomy

1. **Decompose Features via Task Treeing:**
   - **Level 1 (Trunk — The Steel Thread):** Task 1 for any feature must be the minimal end-to-end slice across all layers (DB $\to$ API $\to$ UI) that handles the simplest happy path. It must compile and run immediately.
   - **Level 2 (Branches — Feature Slices):** Subsequent tasks branch out into full business logic, multi-step actions, and secondary workflows.
   - **Level 3 (Leaves — Hardening & Edge Tasks):** Translate the 5 edge lenses (*Zero State, Validation & Recovery, Permissions & Access, State & Concurrency, Data Lifecycle*) into concrete hardening tasks.
2. **Author Explicit Task Anatomy:**
   Every task in `lifecycle/03-plan.md` must adhere to this standardized structure:

   ```markdown
   - [ ] **Task 4.1: Database Schema & Session Models**

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

     **User Verification:**
     - **Setup:** Ensure local PostgreSQL service is running (`pg_isready`).
     - **Action:** Run `psql -d app_dev -c "\d users"` in terminal.
     - **Expected:** Displays `users` table schema showing expected columns and index.
   ```

3. **Assign Individual Named Rules Under Agent Verification:**
   - Assign every relevant rule as its own dedicated bullet (`- Rule [<Rule Name>]: <path/to/rule.md>`). Never use vague section numbers (e.g. "Section 2"); explicit rule names activate the agent's semantic attention and provide exact, drift-proof guidance.
4. **Define Two-Tier Verification Contracts:**
   - **Agent Verification (Automated Pre-Flight & Rule Compliance):** Dedicated bullets for each applicable named rule followed by automated test and verification commands. In Phase 4 Build, the agent must execute these and include passing evidence in the chat completion report before requesting human review.
   - **User Verification (Human Testing Guide):** Foolproof 3-line guide (`Setup`, `Action`, `Expected`) enabling the user to validate the feature in seconds.

### 3.3 Step 3 — Sequencing, Compatibility & Dashboard Population

1. **Sequence Tasks by Verifiable Dependency Order:**
   - `Task 4.0 (Prefactoring):` Behavior-preserving extraction if files breach line thresholds (*"Make the change easy, then make the easy change"*).
   - `Foundational Slices:` Database migrations, core data schemas, cryptographic/domain utilities.
   - `Verifiable CRUD & Feature Slices (The Producer-Before-Consumer Order):`
     1. *Create / Ingest (The Producer):* Minimal vertical Steel Thread that creates real records and handles the primary happy path.
     2. *Read / List / Detail (The Consumer):* Screens and queries that render the real data produced in Step 1.
     3. *Update / Edit (The Modifier):* Edits existing verified records and verifies changes persist.
     4. *Delete / Revoke (The Teardown):* Removes or archives records cleanly and verifies absence.
   - `Hardening & Edge Recovery:` Concurrency guards, debouncing, cascade policies, error banners, and end-to-end regression test suite.
2. **Enforce Backward Compatibility & Live Data Fallbacks:**
   - Verify that readers handle legacy fields and unmigrated documents gracefully during phased rollout.
3. **Populate Status Dashboard Upon Approval:**
   - When the plan is approved, populate all planned tasks into `lifecycle/00-status.md` under Phase 4 Build with status `Todo` and direct links: `[Task 4.1: <Title>](03-plan.md)`.

---

## 4. Exit Gate & Completion Criteria

Phase 3 can transition to Phase 4 — Build only when the completion checklist is fully satisfied and the user grants explicit approval in chat.

### Completion Checklist (Pre-Flight Gate)

Before requesting user approval, verify that:
- **1:1 Feature Mapping:** All Target Features from Discover are mapped directly as `## <Feature Name>` headings.
- **Vertical Steel Thread First:** The primary task for every feature is a thin, end-to-end slice compiling immediately.
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

- **Approved:** Mark Phase 3 as `Done` in `lifecycle/00-status.md`, populate all planned tasks under Phase 4 as `Todo` (with hyperlinks `[Task 4.X: ...](03-plan.md)`), load `lifecycle-build`, and advance to Phase 4 — Build.
- **Changes Requested:** Mark Phase 3 `In Progress`, revise tasks in `lifecycle/03-plan.md`, and re-present.
- **Blocked:** An architectural unknown or requirement conflict prevents planning. Return to Discover or Design for clarification.

---

## 5. Phase Output

The primary deliverable of Phase 3 is the **Centralized Implementation Plan** saved to `lifecycle/03-plan.md`.

### Recommended Structure for `lifecycle/03-plan.md`

```markdown
# Plan: [Requirement / Feature Name]

## [Feature 1 Name]

- [ ] **Task 4.1: [Task Title]**

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

  **User Verification:**
  - **Setup:** [Prerequisite state or server command]
  - **Action:** [Exact steps to test]
  - **Expected:** [What to observe]

- [ ] **Task 4.2: [Task Title]**
  - ...

## [Feature 2 Name]

- [ ] **Task 4.3: [Task Title]**
  - ...
```
