---
name: lifecycle-plan
description: Convert approved flows and prototypes into an actionable implementation plan with feature-mapped tasks, task-specific rules, and two-tier verification (Lifecycle: Phase 3 — Plan).
---

# Phase 3 — Lifecycle Plan

## 1. Purpose

> **Core Mental Model:** Map target features to verifiable tasks. Assign rules where the code changes. Specify what the agent verifies first, then how the user verifies.

Convert the approved Flow Designs and Prototypes from Phase 2 into a complete, technically clear, and actionable Implementation Plan.

The purpose of this phase is to ensure that, before Phase 4 — Build begins, the Agent has sufficient clarity about:

- Which target features and execution flows are being implemented.
- How each feature is divided into logical, independently verifiable tasks.
- The dependencies and execution sequence of those tasks.
- How architecture, database schemas, and contracts are introduced directly within their respective tasks.
- Which specific project guidelines and Rule Files govern each task.
- How the agent will independently verify automated tests and rule compliance before requesting user approval.
- How the user will verify the delivered functionality through concise Setup, Action, and Expected steps.

## 2. Guiding Principles

- **Feature-driven Breakdown & Task Treeing:** Directly map the Discover requirement tree into a task tree: Goal (Trunk) $\to$ Target Features (Branches) $\to$ Steel Thread and Edge Tasks (Leaves).
- **Vertical "Steel Thread" Slicing:** Ban horizontal layer-cake task plans (e.g., Task 1: all DB models, Task 2: all API controllers, Task 3: all UI screens). Every task must implement a thin vertical slice through the stack. Task 1 is always the **Steel Thread** (the minimal end-to-end happy path from data to UI that compiles and runs immediately); subsequent tasks add edge recovery, validation, and hardening.
- **Blast Radius Tagging:** Tag every task with its blast radius to govern execution risk:
  - `🟢 Low (<5 words reason):` e.g., `🟢 Low (isolated component)`
  - `🔴 High (<5 words reason):` e.g., `🔴 High (shared database schema)`
- **Task-Level Architecture:** Architectural touchpoints, data schemas, and file modifications are defined directly inside the tasks responsible for them, eliminating duplicate documentation.
- **Prefactoring Check (Rule Thresholds — 900/1000 lines):** Inspect existing target files before planning feature changes. If a target file already exceeds the 900-line evaluate threshold, or the planned change would push it past the 1000-line hard limit, schedule an upfront `Prefactor <Target>` task (*"Make the change easy, then make the easy change"*) to extract sub-components or helpers before feature implementation begins.
- **Compile-Clean Slices & Temporary Alias Cleanup:** Every task must leave the codebase in a compile-clean, testable state. If an early task renames or removes a symbol needed by later tasks, either update all callers in that task or introduce a temporary compatibility alias that is explicitly scheduled for deletion in the task that migrates the final caller.
- **Backward Compatibility & Multi-Tier Fallback Invariant:** When modifying database schemas, storage collections, or API contracts across independently deployed layers (e.g., client apps vs. backend cloud functions/microservices), tasks must explicitly account for live data coexistence. Readers must include fallback handling for legacy fields or unmigrated documents, guaranteeing zero disruption for active sessions or older client versions during phased rollouts.
- **Task-Specific Rule Enforcement:** Assign relevant Rule Files (e.g., file creation thresholds, API conventions, database migration rules) directly to each task so the agent checks them where the code changes.
- **Two-Tier Verification:** Separate Agent Verification (automated tests and rule compliance checks the agent must run first) from User Verification (clear Setup, Action, and Expected steps for the user).
- **Dependency-aware Sequencing:** Foundation tasks (migrations, core domain utilities) must be sequenced before dependent feature and UI tasks.
- **No Unnecessary Fragmentation:** Tasks must be small enough to implement and verify easily, without creating unnecessary handoffs or trivial one-line tasks.
- **No Premature Implementation:** This phase defines the blueprint and verification contracts; actual coding belongs to Phase 4 — Build.

## 3. Responsibilities & Sequence

### 3.1 Review Approved Inputs

- Review confirmed Target Features from Phase 1 (`lifecycle/01-discover.md`).
- Review approved Flow Designs and Prototypes from Phase 2 (`lifecycle/02-flows.md` and `lifecycle/02-prototype.html` if UI).
- Understand the existing application architecture, project structure, and relevant modules.
- Understand existing functionality, data models, and implementation constraints.
- **File-Size & Prefactoring Inspection:** Check line counts of target files likely to be modified against Rule File thresholds. If any target file exceeds the 900-line evaluate threshold (or the change would push it past the 1000-line hard limit), plan an upfront extraction task before adding feature logic.
- Identify missing, conflicting, or ambiguous information.
- Do not finalize the plan based on assumptions when necessary clarification is still required.

### 3.2 Map Target Features Directly from Discover

- Structure the implementation plan around the exact **Target Features** established in `lifecycle/01-discover.md`.
- Each top-level feature heading in `lifecycle/03-plan.md` must match the corresponding feature in Discover and Design **1:1** as a level-2 header (e.g. `## User Sign Up & Verification`).
- Do not create an artificial intermediate "Outcomes" layer, Section 1 architecture preamble, or prefix headings with `Feature 1:`. Maintain direct, intuitive naming across all lifecycle documents.

### 3.3 Decompose Features via Task Treeing

Divide each target feature into small, logically independent implementation tasks following the **Task Treeing Methodology**:

1. **Level 1 (Trunk — The Steel Thread / Walking Skeleton):**
   - The primary task for any feature MUST be the **Steel Thread**: the minimal end-to-end slice across all layers (database schema $\to$ API route/controller $\to$ minimal UI component) that handles the simplest happy path.
   - It must compile, run, and be verified immediately. Banning horizontal layer cakes (all DB first, all API second, all UI third) ensures architectural assumptions are proven on Task 1.
2. **Level 2 (Branches — Feature Capabilities):**
   - Subsequent tasks branch out into full business logic, multi-step actions, and secondary workflows.
3. **Level 3 (Leaves — The 5 Breadth Lens Hardening Tasks):**
   - Systematically translate the 5 Breadth Lenses from Phase 1 Discover into concrete hardening tasks:
     - *Validation & Error Recovery:* Input validators, timeout/retry logic, user-facing error banners.
     - *Permissions & Tenancy:* Route guards, role-based checks, tenant isolation enforcement.
     - *State & Concurrency:* Double-submit guards, debouncing, optimistic locking.
     - *Data Lifecycle & Migration Fallbacks:* Cascading deletes, retention policies, audit logging, cleanup, and explicit read fallbacks for unmigrated legacy records during schema transitions.

To ensure maximum clarity for the implementer and user, every task must follow this explicit anatomy:

```markdown
- [ ] **Task 4.1: Database Schema & Migration**
  - **Blast Radius:** 🔴 High (shared database schema & models)
  - **Touchpoints:**
    - `src/migrations/001_auth_tables.sql`:
      - Add: Create `users` and `tokens` tables with unique lowercase index on `email`.
    - `src/models/user.ts`:
      - Update: Add `sessionCount` and `activeDeviceIds` fields with fallback defaults.
  - **Applicable Rules:**
    - `.agents/rules/database_migrations.md`:
      - Section 2: Idempotent Migration Guidelines
      - Section 4: Safe Rollback Verification
    - `.agents/rules/security_invariants.md`:
      - Section 3: Token Validation & Expiry Invariants
  - **Agent Verification:**
    - [ ] Run `npm run migrate:up` -> tables created cleanly.
    - [ ] Run `npm run migrate:down` -> rollback drops tables cleanly.
  - **User Verification:**
    - **Setup:** Ensure local PostgreSQL service is running (`pg_isready`).
    - **Action:** Run `psql -d app_dev -c "\d users"` in terminal.
    - **Expected:** Displays `users` table schema showing expected columns and index.
```

### 3.4 Sequence Tasks by Dependency & Priority

Organize tasks according to their logical dependencies:

0. **Prefactoring Tasks (When Target File > 900 Lines / Approaching 1000-Line Limit):** Upfront behavior-preserving extraction of sub-components or utilities (*"Make the change easy, then make the easy change"*).
1. **Foundational Slices:** Database migrations, cryptographic utilities, and core data models.
2. **Backend & Business Logic:** API endpoints, services, middleware, and domain validations.
3. **Frontend & Interactions:** UI components, form state management, and prototype alignment.
4. **Integration & Regression Suite:** End-to-end integration tests verifying the completed feature.

Foundational tasks must be completed and verified before dependent UI or integration tasks begin.

### 3.5 Assign Task-Specific Rule Files

Assign applicable project Rule Files directly to each task rather than relying on a vague global declaration. List the rule file as a bullet, and list the specific relevant section(s) as sub-bullets so the agent knows precisely which rules to inspect:

```markdown
  - **Applicable Rules:**
    - `.agents/rules/database_migrations.md`:
      - Section 2: Idempotent Migration Guidelines
      - Section 4: Safe Rollback Verification
    - `.agents/rules/security_invariants.md`:
      - Section 3: Token Validation & Expiry Invariants
```

This ensures that during Phase 4 — Build, the agent checks the exact rule sections governing the specific files and changes being made without ambiguity.

### 3.6 Define Two-Tier Verification Criteria (Agent vs. User)

Every task must establish clear, separated verification expectations:

1. **Agent Verification (Automated Pre-Flight Gate):**
   - The automated tests, CLI commands, build checks, and rule validations the Agent **must** run and pass before declaring the task ready for review.
   - Format each check as a markdown checkbox (`- [ ]`). During Phase 4 — Build, the Agent must execute each check and check it off (`- [x]`) upon passing before handing off to the user.
   - The Agent must never claim a task is complete based on assumptions; all commands under Agent Verification must be executed.
2. **User Verification (Human Testing Guide):**
   - A foolproof 3-line testing guide enabling the user to immediately validate the deliverable without guessing:
     - **Setup:** Starting environment state, running dev server, URL, or test account credentials.
     - **Action:** Exact steps the user takes in the browser or terminal.
     - **Expected:** Observable behavior or output that confirms success.

### 3.7 Review Plan Completeness

Review the complete Implementation Plan and ensure that:

- All Target Features from Discover are covered.
- Task Blast Radius, Touchpoints (with explicit action verbs), and Applicable Rules (with sections) are explicitly defined.
- Backward compatibility and live data fallbacks are accounted for if storage schemas or contracts are altered.
- Agent and User verification steps are complete and actionable.
- Dependencies and execution sequence are logical.
- No unresolved technical questions remain.

## 4. Completion Criteria

Phase 3 is considered complete only when:

- All Target Features from Discover are mapped into the Implementation Plan as `## <Feature Name>` headings.
- Features are divided into logical, independently verifiable tasks.
- Every task includes Blast Radius (<= 5 words reason), Touchpoints (files with action sub-bullets), Applicable Rules (with sections), Agent Verification checkboxes, and User Verification (`Setup`, `Action`, `Expected`).
- Schema, collection, or contract changes include explicit backward-compatibility fallbacks for unmigrated data and live client rollout.
- Task dependencies and execution sequences are established.
- The complete plan has passed completeness review.
- The Implementation Plan (`lifecycle/03-plan.md`) has been explicitly approved by the user.

## 5. Exit Gate

Phase 4 — Build may begin only when:

- All Phase 3 Completion Criteria have been satisfied.
- The complete Implementation Plan (`lifecycle/03-plan.md`) has received explicit user approval.
- All tasks are populated into `lifecycle/00-status.md` under Phase 4 as `Todo`.

### Exit Gate Outcomes

- **Approved:** All completion criteria are satisfied and the plan is approved. Populate all planned tasks into `lifecycle/00-status.md` under Phase 4 as `Todo`, mark Phase 3 as `Done`, and proceed to Phase 4 — Build.
- **Changes Requested:** Feedback requires revisions. Update `lifecycle/03-plan.md`, re-check task breakdown, and present it again.
- **Blocked:** A critical architectural unknown, missing requirement, or dependency remains unresolved. Return to the owning earlier phase (Discover or Design) or seek the required user input.

### Requesting User Approval

Follow the **Phase 0 Chat Approval Protocol** to present `lifecycle/03-plan.md` and request explicit approval to begin Phase 4 — Build.

## 6. Phase Boundary

This section defines the scope and limitations of Phase 3 to prevent performing work that belongs to other phases.

### 6.1 What Belongs to Phase 3 (Plan)

- Review of approved target features, flows, and prototypes (`lifecycle/01-discover.md`, `lifecycle/02-flows.md`).
- Feature and verifiable task breakdown.
- Task dependency sequencing and priority ordering.
- Task-specific Rule File assignments.
- Defining two-tier verification contracts (Agent Verification vs. User Verification with `Setup`, `Action`, `Expected`).
- Implementation Plan review, refinement, and user approval in `lifecycle/03-plan.md`.

### 6.2 What Does NOT Belong to Phase 3

- Writing or modifying production source code, tests, or database schemas (belongs to Phase 4 — Build).
- Executing tests or verifying implementation code compliance (belongs to Phase 4 — Build).

## 7. Phase Output

The primary deliverable of Phase 3 is the **Centralized Implementation Plan** saved to `lifecycle/03-plan.md`.

### Recommended Structure for `lifecycle/03-plan.md`

```markdown
# Plan: [Requirement / Feature Name]

## [Feature Name]

- [ ] **Task 4.1: [Task Title]**
  - **Blast Radius:** [🟢 Low (<5 words reason) / 🔴 High (<5 words reason)]
  - **Touchpoints:**
    - `path/to/file1.ts`:
      - [Add / Update / Delete / Refactor / Fix]: [Specific change description]
    - `path/to/file2.ts`:
      - [Add / Update / Delete / Refactor / Fix]: [Specific change description]
  - **Applicable Rules:**
    - `.agents/rules/rule1.md`:
      - Section X: [Specific rule/topic]
      - Section Y: [Specific rule/topic]
    - `.agents/rules/rule2.md`:
      - Section Z: [Specific rule/topic]
  - **Agent Verification:**
    - [ ] [Specific automated test command or build verification check]
    - [ ] [Rule compliance check]
  - **User Verification:**
    - **Setup:** [Prerequisite state or server command]
    - **Action:** [Exact steps to test]
    - **Expected:** [What to observe]

- [ ] **Task 4.2: [Task Title]**
  - ...
```
