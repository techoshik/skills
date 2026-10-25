---
name: lifecycle-roadmap
description: Architect tracer-bullet vertical slices, 6-part task anatomy, binary verification oracles, and author 03-roadmap.md (Lifecycle: Roadmap).
---

# Lifecycle Roadmap

Act as a **Principal Technical Architect**. Your mission is to take approved requirements and prototype designs, investigate codebase line limits, slice the work into priority-ordered, small vertical tasks, specify binary verification oracles, and author the execution blueprint in `lifecycle/03-roadmap.md`.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Architectural Mindset: Vertical Slicing & Atomic Readability

- **Death to Horizontal Layering:** Never slice work into horizontal technical layers (*"Task 1: Models & DTOs, Task 2: Mocked UI, Task 3: API Integration"*). Horizontal layering creates untestable intermediate states and delays human verification.
- **Tracer-Bullet Slices:** Every task must cut end-to-end through data, state/logic, and UI, delivering an observable, testable behavior change.
- **Single Turn Sizing:** Size each task by scope and reviewability—touching only **~2–5 related files per task** so it can be implemented, tested, and reviewed within a single context window.
- **One Fact Per Line (No Paragraph Bullets):** Never cram multiple file changes, constraints, or verification steps into a single multi-sentence bullet in `03-roadmap.md`. Use **nested sub-bullets where 1 line = 1 atomic detail**.

---

## Step 1: Entry Gate & Architectural Ingestion

1. **Verify Entry Gate:**
   - Read `lifecycle/00-status.md`.
   - Verify that **`Prototype` is marked `Done` or `Skipped`**.
   - If not, STOP—instruct the user to complete the preceding phase first.
2. **Ingest Specification & Design:**
   - Read `lifecycle/01-requirements.md` in full: Requirements, AC, Business Rules, Decisions, and `Selected UI/UX Specification`.
   - Inspect `lifecycle/02-prototype.html` (and feature carousels / flow diagrams) if `Prototype` was completed.
3. **Pre-Flight Line-Count & Refactor Audit:**
   - Check the line counts of all existing files scheduled to be modified.
   - **The 500-Line Soft Ceiling Trigger:** If any target file is already **>400–500 lines** (or this feature will push it over 500 lines), flag it for an upfront **Prefactoring Task** (*"Make the change easy, then make the easy change"*).

> **➡️ Sign-off & Transition to Step 2:** Spec is ingested, entry gate is verified, and target file line counts are audited.

---

## Step 2: Tracer-Bullet Slicing & Priority Flow

Organize the implementation into small, reviewable vertical tasks ordered by priority and dependency:

1. **`P0: Foundation / Prefactoring` (If Triggered):**
   - Scheduled *only* if target files exceed ~400 lines or an existing class must be split.
   - **Zero Behavior Changes:** Refactoring must extract sub-widgets, helpers, or split controllers into adjacent files without altering existing behavior. All existing tests must pass before feature work begins.
2. **`P1: Core Tracer-Bullet (Happy Path)`:**
   - Cuts end-to-end through models, state/controller, UI, and data/repository calls.
   - Delivers the primary working capability (the core happy path) with real data flow.
3. **`P2: Secondary Flows & Component Interactions`:**
   - Sub-forms, filter bars, action dialogs, or secondary user journeys building on P1.
4. **`P3: Edge Cases, Error Recovery & Invariants`:**
   - Validation failures, offline retry mechanisms, empty states, and tenant/permission boundaries.
5. **Wide Refactor Pattern (Expand–Contract):**
   - If changing a shared data contract used across multiple modules, use **Expand → Migrate → Contract** across tasks to prevent breaking the build.

> **➡️ Sign-off & Transition to Step 3:** Tasks follow a strict dependency flow; each task represents an observable behavior touching ~2–5 files.

---

## Step 3: Concrete 6-Part Task Authoring (`03-roadmap.md`)

Initialize `lifecycle/03-roadmap.md` from [Roadmap Template](../lifecycle/templates/03-roadmap.md) using **1-fact-per-line nested sub-bullets** across all 6 parts:

1. **Outcome:** A single crisp sentence stating what observable capability works when this task completes.
2. **Touchpoints:**
   - List each target file path directly as a top-level bullet (reusing items from `Existing Code & Reuse Touchpoints` in `01-requirements.md`).
   - Underneath each file path, list 1-line sub-bullets starting with an imperative action verb and colon (`Create:`, `Add:`, `Update:`, `Remove:`, `Delete:`, `Fix:`).
3. **Acceptance Criteria (Binary Verification Oracles):**
   - Binary pass/fail conditions (Exit Code 0 vs 1; True vs False; no subjective opinions).
   - **Static Analysis Command:** Exact command (e.g. `flutter analyze`, `npm run lint`, `ruff check`) reporting 0 issues.
   - **Fast Automated Tests:** Exact test command (e.g. `flutter test`, `npm test`, `pytest`) executing fast logic/controller tests.
   - **Strict Ban on Shallow UI Tests:** Ban brittle tests that merely assert static text or widget presence (`find.text('Submit')`). Tests must verify business logic, state transitions, and dynamic conditions.
4. **Business Rules:** One bullet per domain, validation, or permission invariant from `01-requirements.md` governing this slice.
5. **Code Guidelines (Exception-Only):**
   - Reference specific `.agents/rules/<rule>.md` files under `Rule Files`.
   - Under `Task-Specific Invariants`, list 1 constraint per sub-bullet for rules at risk in this slice (e.g. hook-only, server-side only, immutability, 500-line ceiling).
6. **Human Verification Steps:**
   - **`Action:`** Numbered step-by-step instructions (1 action per line) for the user to trigger or test this slice in the running app.
   - **`Expected:`** 1-line sub-bullets stating the exact observable result confirming success.

> **➡️ Sign-off & Transition to Step 4:** Every task in `03-roadmap.md` is fully defined across all 6 sections with binary verification gates and 1-fact-per-line formatting.

---

## Step 4: Status Dashboard Synchronization (`00-status.md`)

When `03-roadmap.md` is drafted, synchronize `lifecycle/00-status.md`:

1. Keep the standard phase rows (`Brainstorm`, `Prototype`, `Roadmap`).
2. Replace the generic placeholder `| Execute | Todo |` row with a dedicated row for every roadmap task using a **concise task title** (2–4 words; keep table cells compact so tables don't wrap):
   ```markdown
   # Status Dashboard: <Feature Name>

   | Step / Task | Status |
   | :--- | :--- |
   | Brainstorm | Done |
   | Prototype | Done |
   | Roadmap | In Review |
   | Task 1: <Short Title> | Todo |
   | Task 2: <Short Title> | Todo |
   | Task 3: <Short Title> | Todo |
   | Review | Todo |
   | Finalize | Todo |
   ```

> **➡️ Sign-off & Transition to Step 5:** All roadmap tasks are synchronized into `00-status.md` as `Todo`.

---

## Step 5: Exit Gate & Human Handoff

Before handing off, verify the **Roadmap Quality Checklist**:

- [ ] Every task cuts end-to-end as a small, reviewable vertical slice (~2–5 related files per task, zero horizontal layers).
- [ ] Any file near >400 lines has an upfront Prefactoring task.
- [ ] Every task has binary pass/fail verification commands.
- [ ] All sections use **1-fact-per-line nested sub-bullets** (zero paragraph walls).
- [ ] All tasks are populated in `00-status.md`.

### Handoff Protocol
1. Record any tooling or process friction in `lifecycle/04-refine.md`.
2. Update `lifecycle/00-status.md`: set `Roadmap` to **`In Review`**.
3. Present a concise review summary in chat:
   - Highlight the task sequence, file touchpoints, and verification steps.
   - Provide the file link to `lifecycle/03-roadmap.md`.
4. **STOP.** Do not start executing Task 1 until the user explicitly approves the roadmap in chat.
5. **On User Approval:**
   - Mark `Roadmap` as **`Done`** in `00-status.md`.
   - Read [`lifecycle-execute/SKILL.md`](../lifecycle-execute/SKILL.md) and auto-advance to start Task 1.
