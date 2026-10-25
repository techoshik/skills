---
name: lifecycle-execute
description: Execute exactly one vertical task from 03-roadmap.md at a time, enforce the 5-gate self-review, and stop for human approval (Lifecycle: Execute).
---

# Lifecycle Execute

The `lifecycle-execute` skill builds the software one isolated vertical task at a time as defined in `lifecycle/03-roadmap.md`. Your mission is to implement strictly one slice, enforce the 5-gate self-review (fixing all issues before handoff), and present a skimmable 4-bullet summary for human verification.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Execution Mindset: Single-Task Isolation

- **One Slice at a Time:** Strictly forbidden from executing multiple roadmap tasks in the same turn. Treat each task as an isolated, reviewable unit of delivery.
- **Depth Over Speed:** Never rush to edit. Read the full target files and their immediate callers before writing code.
- **Inviolable Boundaries:**
  - **100% Manual Git:** Strictly forbidden from running `git add`, `git commit`, `git reset`, `git restore`, or `git checkout`.
  - **Watchers Ban:** Never run long-running watchers or daemonized codegen (e.g. `build_runner`).

---

## Step 1: Task Selection & Status Lock

1. **Verify Entry Gate:**
   - Read `lifecycle/00-status.md`.
   - Verify that **`Roadmap` is marked `Done`**.
   - Locate the first task in `00-status.md` with status **`Todo`** (or `In Progress`).
2. **Lock Status to In Progress:**
   - Update that specific task's row in `lifecycle/00-status.md` to **`In Progress`**.
   - Do **not** touch subsequent tasks.
3. **Ingest Task Definition:**
   - Open `lifecycle/03-roadmap.md` and read the exact specification for this active task: Outcome, Touchpoints, AC, Business Rules, Guidelines, and Human Verification.

> **➡️ Sign-off & Transition to Step 2:** Active task is marked `In Progress` in `00-status.md` and its roadmap section is ingested.

---

## Step 2: Pre-Edit Inspection & Worker Sub-Agent Delegation

1. **Pre-Edit Inspection ("Read Before You Write"):**
   - Fully inspect all target files listed under `Touchpoints` and their immediate callers.
   - Read any specific rule files referenced under `Code Guidelines` (e.g. `.agents/rules/<rule>.md`).
2. **Worker Sub-Agent Delegation (Context Hygiene):**
   - For multi-file changes or test executions, spawn a fresh worker sub-agent (`TypeName: 'self'`, `Role: 'Task Worker'`).
   - Pass the exact task specification, touchpoint list, guidelines, and safety boundaries (`no git add/commit`, `no watchers`).
   - The worker sub-agent writes code, runs analyzer and tests, checks off the task's `Acceptance Criteria` boxes in `03-roadmap.md`, and returns a clean report.
   - Raw compiler logs, repeated linter runs, and file churn stay quarantined inside the sub-agent.

> **➡️ Sign-off & Transition to Step 3:** Target files and caller contexts are understood; implementation begins.

---

## Step 3: Implement Active Touchpoints Only

1. **Strict Touchpoint Discipline:**
   - Modify **only** the files and symbols explicitly declared under `### 2. Touchpoints` for this active task in `03-roadmap.md`.
   - Never implement features, UI elements, or models belonging to future roadmap tasks.
2. **Code Guidelines Compliance:**
   - **500-Line Ceiling:** Keep files under ~500 lines. Extract cohesive sub-widgets or helper functions into adjacent files if nearing the limit.
   - **Framework Invariants:** Respect project rules (e.g. `StatelessWidget`/`HookWidget` only, `Direct Client SDK First`, zero raw contract strings).

> **➡️ Sign-off & Transition to Step 4:** Code changes are complete and scoped strictly to active touchpoints.

---

## Step 4: Mandatory 5-Gate Self-Review

Before presenting ANY task to the user, you MUST verify all 5 gates. Fix all issues silently before handoff:

1. **Gate 1: Outcome Gate:**
   - Verify that the code delivers the exact working capability stated in `### 1. Outcome`.
2. **Gate 2: Acceptance Criteria Gate:**
   - Verify every condition listed under `### 3. Acceptance Criteria`.
3. **Gate 3: Business Rules Gate:**
   - Verify that all domain, validation, and permission rules from `01-requirements.md` (and task `### 4. Business Rules`) strictly hold true.
4. **Gate 4: Code Guidelines Gate:**
   - Verify adherence to `.agents/rules/` (500-line limit, architecture invariants, zero dead code or debug logs).
5. **Gate 5: Automated Verification Gate:**
   - Run the exact static analysis command from the task (e.g. `flutter analyze <path>`). Must report **0 issues**.
   - Run the exact test command from the task (e.g. `flutter test <path>`). Must pass **100% cleanly** (fast logic/controller seam tests).
   - Once verified, mark the task's `### 3. Acceptance Criteria` checkboxes as `- [x]` in `03-roadmap.md`.
6. **Log Friction (`04-refine.md`):**
   - If any rule was ambiguous, compiler error was deceptive, or rework occurred, log `Phase/Task`, `Problem`, `Cause`, and `Solution` in `lifecycle/04-refine.md`.

> **➡️ Sign-off & Transition to Step 5:** All 5 self-review gates pass 100% cleanly and AC checkboxes are checked off in `03-roadmap.md`.

---

## Step 5: Skimmable Handoff & Human Approval Gate

1. **Update Task Status:**
   - Update the active task in `lifecycle/00-status.md` to **`In Review`**.
2. **Present 4-Bullet Review Summary in Chat:**
   Present an instantly skimmable summary:
   - **Changed Files:** Exact paths created or modified.
   - **5-Gate Status:** Confirmation that Outcome, AC, Business Rules, Guidelines, and Analyzer/Tests passed.
   - **Verification Evidence:** Proof of analyzer (0 issues) and test pass.
   - **Human Verification Steps:** The exact `Action` → `Expected` steps from the task so the user can test in the running app/browser.
3. **STOP.** Do not start the next task. Wait for explicit human approval in chat.
4. **On User Approval:**
   - Update that task's row in `lifecycle/00-status.md` to **`Done`**.
   - Check `00-status.md` for remaining tasks:
     - **If more tasks remain:** Pick the next `Todo` task, mark it `In Progress`, and return to Step 1.
     - **If ALL roadmap tasks are `Done`:** Read [`lifecycle-review/SKILL.md`](../lifecycle-review/SKILL.md) and auto-advance to Review.
