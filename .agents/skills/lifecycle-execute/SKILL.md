---
name: lifecycle-execute
description: Execute one vertical task from 03-roadmap.md at a time, sync checkboxes across 03-roadmap.md and 01-requirements.md, enforce the 5-gate self-review, and stop for human approval (Lifecycle: Execute).
---

# Lifecycle Execute

The `lifecycle-execute` skill builds the feature one isolated vertical task at a time from `lifecycle/03-roadmap.md`. Your mission is to read target files and callers deeply before editing, implement strictly one task, pass all 5 self-review gates, sync checkboxes in both `03-roadmap.md` and `01-requirements.md`, and hand off a concise 4-bullet summary for human verification.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Execution Rules

- **One Task at a Time:** Execute only the single active task from `00-status.md`.
- **Mid-Flight UX / Requirement Changes (Never Hack Directly):** If the user spots a UX simplification or requests a requirement change while reviewing or running the app, **pause coding immediately** and follow Section 7 of `lifecycle/SKILL.md`:
  1. Run a quick micro-brainstorm to confirm the cleanest flow.
  2. **Update `01-requirements.md` in place** (replacing superseded outcomes, requirements, and UI specs so the file never contradicts itself).
  3. Update `03-roadmap.md` and `00-status.md` with a proper numbered `Task N` (marking any superseded task lines with `~(Superseded by Task N)~`—never dump untracked work into an unstructured footer).
- **Design System & Architecture Primacy:** Follow `.agents/rules/` strictly (canonical design system components/tokens, folder/naming conventions, `<500` lines, manual git boundary, no watchers).

---

## Step 1: Select Active Task & Lock Status

1. Read `lifecycle/00-status.md`, verify `Roadmap` is `Done`, and find the first `Todo` (or `In Progress`) task.
2. Set that task to **`In Progress`** in `00-status.md`.
3. Read the task's specification in `lifecycle/03-roadmap.md` and its mapped `REQ-X` / `BR-X` items in `lifecycle/01-requirements.md`.

> **➡️ Sign-off & Transition to Step 2:** Active task is marked `In Progress` in `00-status.md`.

---

## Step 2: Deep Pre-Edit Inspection & Worker Delegation

1. **Read Before You Write:** Inspect the full target files under `Touchpoints`, their immediate callers, and the referenced `.agents/rules/<rule>.md` file.
2. **Worker Sub-Agent Delegation:** When sub-agent tools are available, delegate multi-file coding and test execution to a fresh worker sub-agent (`Role: 'Task Worker'`) to keep raw compiler/test output out of the main chat.

> **➡️ Sign-off & Transition to Step 3:** Target files, callers, and rules are inspected.

---

## Step 3: Implement Active Touchpoints Only

1. Modify **only** the files and symbols listed under `### 2. Touchpoints` for the active task (never jump ahead to future tasks).
2. Keep all touched files under the `~500-line` ceiling and follow canonical `.agents/rules/` folder/component conventions.

> **➡️ Sign-off & Transition to Step 4:** Code and unit/controller tests for the active slice are implemented.

---

## Step 4: Mandatory 5-Gate Self-Review & Checkbox Sync

Verify all 5 gates and fix any failure before handoff:

1. **Gate 1 — Outcome Gate:** Changes deliver the exact capability in `### 1. Outcome`.
2. **Gate 2 — Acceptance Criteria Gate:** Every condition in `### 3. Acceptance Criteria` holds.
3. **Gate 3 — Business Rules Gate:** All mapped `BR-X` rules hold true.
4. **Gate 4 — Code Guidelines Gate:** Touched files obey `.agents/rules/` (`<500` lines, canonical naming/placement, zero dead code or debug logs).
5. **Gate 5 — Automated Verification Gate:**
   - Run the task's static analysis command (`0` issues) and test command (`100%` pass).
6. **Sync Checkboxes in Both `03-roadmap.md` and `01-requirements.md`:**
   - Mark the task's `### 3. Acceptance Criteria` checkboxes as `- [x]` in `03-roadmap.md`.
   - Also mark the corresponding `- [x] AC-X.Y` (and `- [x] REQ-X` once all its ACs are complete) in `lifecycle/01-requirements.md` so both files stay in lockstep.
7. **Log Friction (`04-refine.md`):** Record any rule gap or mistake encountered during the task.

> **➡️ Sign-off & Transition to Step 5:** All 5 gates pass and checkboxes are synced in `03-roadmap.md` and `01-requirements.md`.

---

## Step 5: Skimmable Handoff & Approval Gate

1. Set the active task to **`In Review`** in `lifecycle/00-status.md`.
2. Present a concise 4-bullet summary in chat (linking to `lifecycle/03-roadmap.md`, no chat tables):
   - **Changed Files:** Exact source and test files created/updated.
   - **5-Gate Status:** Confirmation that Outcome, AC, Business Rules, Guidelines, and Analyzer/Tests passed.
   - **Verification Proof:** Analyzer (`0` issues) and test pass results.
   - **Human Verification Steps:** Exact `Action` → `Expected` steps for the user to test.
3. **STOP** and wait for user approval.
4. **On User Approval:** Mark the task **`Done`** in `00-status.md`. If more tasks remain, start the next `Todo` task; if all tasks are `Done`, read [`lifecycle-review/SKILL.md`](../lifecycle-review/SKILL.md) and auto-advance to Review.
