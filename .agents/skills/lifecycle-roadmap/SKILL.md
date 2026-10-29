---
name: lifecycle-roadmap
description: Architect tracer-bullet vertical slices, verify canonical file placement, specify binary verification oracles, and author 03-roadmap.md (Lifecycle: Roadmap).
---

# Lifecycle Roadmap

Act as a **Principal Technical Architect**. Your mission is to translate the approved `01-requirements.md` and `02-prototype.html` into priority-ordered, small vertical tasks in `lifecycle/03-roadmap.md`, verifying that every file path obeys project architecture rules and every task compiles cleanly and is independently testable.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Architectural Mindset: Vertical Slices & Canonical Placement

- **Vertical Slices Only (No Horizontal Layers):** Every task must deliver an observable, testable outcome touching **~2–5 related files** (never *"Task 1: All Models, Task 2: All UI"*).
- **Canonical File Placement Check (Before Writing Touchpoints):** Never invent ad-hoc helper filenames inside feature folders. Cross-check every proposed file path against `.agents/rules/` folder and naming conventions (e.g. module validators in `modules/<module>/<module>_validator`, 4-tier widget placement) and existing module structure.
- **One Fact Per Line:** Format `03-roadmap.md` using short nested sub-bullets (`1 line = 1 atomic detail`) with zero prose walls and zero header boilerplate.

---

## Step 1: Entry Gate & Pre-Flight Code Audit

1. **Verify Entry Gate:**
   - Read `lifecycle/00-status.md` and verify **`Prototype` is `Done` or `Skipped`**.
   - Set `Roadmap` to **`In Progress`** in `lifecycle/00-status.md`.
2. **Ingest Specification & Verify Rules:**
   - Read `lifecycle/01-requirements.md` and `lifecycle/02-prototype.html` (if created).
   - Read `.agents/rules/` to verify exact folder structure, state management, and naming conventions for all planned files.
3. **500-Line Ceiling & Prefactoring Check:**
   - Check line counts of all target files. If any file to be modified is already **>400–500 lines**, schedule an upfront **`Task 1: Prefactor <Target>`** (*"Make the change easy, then make the easy change"*) before feature tasks.

> **➡️ Sign-off & Transition to Step 2:** Spec is ingested, canonical file paths are verified against `.agents/rules/`, and file line counts are checked.

---

## Step 2: Priority-Ordered Vertical Slicing & Compile-Clean Rule

Order tasks by priority and dependency:
1. **`P0: Foundation / Prefactoring` (Only if a target file exceeds ~400 lines):** Extract sub-widgets/helpers with zero behavior change.
2. **`P1: Core End-to-End Slice (Primary Flow)`:** Cuts through model/data, state/validator, and primary UI with unit/controller tests.
3. **`P2: Secondary Screens / Component Reuse`:** Extracts shared widgets or wires secondary screens/flows.
4. **`P3: Edge Cases, Permissions & Cleanup`:** Enforces remaining edge invariants and removes any deprecated aliases/screens.
5. **Compile-Clean Slice & Temporary Alias Cleanup Rule:**
   - Every task must leave static analysis (`flutter analyze` / linter) at **`0` issues**.
   - If an early task renames or removes a model field/getter used by screens in later tasks, either update those callers in the same task OR add a temporary compatibility alias in Task 1 and **explicitly list `Delete: <temporary alias>` in the `Touchpoints` of the task that migrates the final caller** so zero temporary aliases survive the roadmap.

> **➡️ Sign-off & Transition to Step 3:** Every task is a compile-clean vertical slice (~2–5 files) mapped to `AC-X.Y` and `BR-X` items.

---

## Step 3: Author `03-roadmap.md` (5-Part Task Anatomy)

Initialize `lifecycle/03-roadmap.md` from [Roadmap Template](../lifecycle/templates/03-roadmap.md). List `- **Applicable Project Rules:** .agents/rules/<rule>.md` once at the top, and structure every task with the **5-Part Anatomy**:

1. **Outcome:** 1 crisp sentence stating what works when this task finishes.
2. **Touchpoints:**
   - List each target file path (including **explicit test file paths**) as a parent bullet.
   - Start each child sub-bullet with an imperative verb (`Create:`, `Add:`, `Update:`, `Delete:`). Omit `Delete` if no files/symbols are deleted.
3. **Acceptance Criteria (Binary Verification):**
   - Binary pass/fail `- [ ] **AC-X.Y:**` conditions mapped directly from `01-requirements.md`.
   - Exact static analysis command (`0` issues) and fast unit/controller test command (banning shallow static-widget UI tests).
4. **Rules & Constraints:**
   - 1 line per `BR-X` module rule from `01-requirements.md` enforced in this task.
   - 1 line per architectural constraint specific to the touched files (e.g. `<module>_validator.dart` placement, `<500` lines).
5. **Human Verification Gate:**
   - Include `Prerequisites:` only when emulator, seed data, or role setup is needed (omit if none).
   - Numbered `Action:` steps and 1-line `Expected:` result.

> **➡️ Sign-off & Transition to Step 4:** `03-roadmap.md` is complete and 100% aligned with `01-requirements.md` and `.agents/rules/`.

---

## Step 4: Synchronize `00-status.md`

Replace the placeholder `| Execute | Todo |` row in `lifecycle/00-status.md` with concise task rows (`| Task 1: <Short Slug> | Todo |`, `| Task 2: <Short Slug> | Todo |`, ...) and set `Roadmap` to **`In Review`**.

> **➡️ Sign-off & Transition to Step 5:** All roadmap tasks are synced into `00-status.md`.

---

## Step 5: Exit Gate & Human Handoff

Verify the **Roadmap Checklist**:
- [ ] Every `REQ-X`, `AC-X.Y`, and `BR-X` in `01-requirements.md` is covered by a task.
- [ ] Every new/modified file path follows `.agents/rules/` folder and naming conventions (`<module>_validator`, 4-tier widget placement).
- [ ] Any temporary compatibility alias created in an early task has an explicit `Delete:` touchpoint in a later task.
- [ ] Every task includes explicit test touchpoints and binary verification commands.
- [ ] All tasks are listed in `00-status.md` with short slugs.

### Handoff Protocol
1. Log any friction in `lifecycle/04-refine.md`.
2. Present a concise chat summary linking to `lifecycle/03-roadmap.md` (no chat tables) and **STOP** for user approval.
3. **On User Approval:** Mark `Roadmap` as **`Done`** in `00-status.md`, read [`lifecycle-execute/SKILL.md`](../lifecycle-execute/SKILL.md), and auto-advance to Task 1.
