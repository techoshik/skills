---
name: lifecycle-roadmap
description: Turn approved requirements into dependency-aware, independently testable vertical tasks with explicit touchpoints and verification (Lifecycle: Roadmap).
---

# Lifecycle Roadmap

Translate the approved requirements and any chosen prototype into an implementation plan that preserves the intended outcome, project architecture, and critical constraints. The roadmap should be detailed enough that an implementer can start without guessing, but not overloaded with low-level details that do not affect execution.

## 0. Phase Rules & Guardrails

- **Plan outcomes, not file batches:** Each task should deliver an observable behavior or a coherent enabling change. Avoid horizontal plans such as “all models, then all UI” when an end-to-end slice is feasible.
- **Use the smallest safe vertical slice:** Group related files by a verifiable outcome. Two to five files is a rough heuristic, not a hard limit; keep a task smaller or larger when dependencies, atomicity, or project constraints justify it.
- **Inspect before promising paths:** Confirm proposed paths and names against `.agents/rules/`, the current module structure, and comparable files. Never invent a file location based solely on habit.
- **Prefactor only when it reduces risk:** A large or crowded file is a signal to inspect, not an automatic reason to create a refactoring task. Plan behavior-preserving extraction first when it is needed to make the requested change safe, reviewable, or consistent with a hard project rule.
- **Verification must be honest:** Set exact relevant commands and expected outcomes. If the baseline already has issues or the environment cannot run a check, record that distinction rather than promising an impossible “zero issues” result.

## Step 1: Entry Gate and Pre-Flight

1. Read `00-status.md`, the Resume Checkpoint, `01-requirements.md`, and `02-prototype.html` if it exists. Confirm Prototype is `Done` or `Skipped`.
2. Set Roadmap to `In Progress`.
3. Read the relevant `.agents/rules/` files, module docs, and existing examples for folder placement, naming (e.g. `<module>_validator` placement, 4-tier widget placement), state management, validation, security, and testing.
4. **500-Line Ceiling & Prefactoring Check:** Inspect target files and important callers to verify likely change points and check line counts. If any file to be modified is already `>400–500` lines, evaluate scheduling an upfront `P0: Prefactor <Target>` task (*"Make the change easy, then make the easy change"*) before feature tasks.
5. Identify dependencies, data/schema/rule/index changes, feature flags, migration or backfill needs, compatibility concerns, rollback needs, and approval gates when relevant.
6. If the spec and code appear to disagree, return to Brainstorm or raise the conflict; do not plan implementation around an unapproved interpretation.

**Gate:** Requirements, project constraints, architecture touchpoints, and material risks are understood well enough to sequence the work.

## Step 2: Reason Through the Implementation Strategy & Vertical Slice Priority

Before writing the task list, compare plausible implementation approaches when the choice affects architecture, behavior, cost, safety, or long-term maintenance.

For consequential choices, record a concise comparison covering:

- The desired outcome and fixed constraints.
- Credible alternatives and whether an existing capability can be reused.
- Important benefits, costs, operational effects, failure modes, and migration/rollback implications.
- Downstream callers, data integrity, permissions/tenancy, concurrency, performance, testing, and future maintenance as applicable.
- The recommendation and evidence that supports it.
- Any user-owned decision still unresolved.

Challenge the preferred approach with a likely edge case or counterexample. If a consequential choice remains user-owned, pause the plan at that point and ask the user; do not silently convert a recommendation into an approved decision.

Order vertical slices using this priority progression:
1. **`P0: Foundation / Prefactoring` (When a target file exceeds ~400–500 lines):** Behavior-preserving extraction of sub-widgets or helpers.
2. **`P1: Core End-to-End Slice (Primary Flow)`:** Cuts through model/data, state/validator, and primary UI with unit/controller tests.
3. **`P2: Secondary Screens / Component Reuse`:** Extracts shared widgets or wires secondary screens and flows.
4. **`P3: Edge Cases, Permissions & Cleanup`:** Enforces remaining edge invariants and removes deprecated aliases or screens.

## Step 3: Create the Roadmap

Initialize `lifecycle/03-roadmap.md` from [Roadmap Template](../lifecycle/templates/03-roadmap.md). Include the **Quick read** summary and a scannable **Roadmap Overview** (`1. [Task 1: <Short Slug>](#task-1...) \`[<Scope Badge>]\` — <1-line outcome>`) before task details, and label every task heading with a scope badge (`## Task N: <Name> [<Scope Badge>]`).

Every task uses the same **five-part anatomy**:

1. **Outcome and dependency:** The observable 1-sentence result and the prior task(s) required, or `None`.
2. **Touchpoints:** Exact files and symbols to `Create / Add`, `Update`, or `Delete`, including explicit test file paths. Validate every path against `.agents/rules/`.
3. **Acceptance criteria and verification:** Separate **Behavioral Criteria** (mapped to stable `AC-X.Y` IDs in `01-requirements.md`) from **Automated Verification Gates** (exact static analysis and unit/controller/integration test commands and expected outcomes).
4. **Rules and constraints:** The applicable `BR-X` IDs and project-specific architectural constraints for the touched files (e.g. `<module>_validator.dart` placement, `<500` lines).
5. **Human verification gate:**
   - `Prerequisites / Environment Setup:` Required emulator/server, test account/role, seed data, or starting state (or `"None — standard logged-in session"`).
   - Numbered `Action:` steps and 1-line `Expected:` observable result.

Task design rules:

- Sequence prerequisites before dependent work; identify parallel tasks only when they truly can proceed independently.
- **Compile-Clean Slice & Temporary Alias Cleanup Rule:** Prefer a compile-clean, testable state (`0` new analyzer issues) after each task. If an early task renames or removes a model field/getter used by callers in later tasks, either update those callers in the same task OR add a temporary compatibility alias in the early task and **explicitly list `Delete: <temporary alias>` in the `Touchpoints` of the task that migrates the final caller** so zero temporary aliases survive the roadmap.
- Include tests at the correct boundary: fast unit/controller/repository seam tests for logic and data behavior, plus integration or UI tests when the interaction itself needs verification. Justify the test by the risk it covers rather than writing shallow static-widget boilerplate tests.
- Cover each relevant requirement, business rule, permission boundary, and edge case in at least one task. Do not duplicate every detailed requirement into each task; reference its ID and specify what the task verifies.
- State exact commands and distinguish the expected result from baseline conditions. If existing warnings/failures are known, document the baseline and the requirement for no new regressions.
- Do not split work solely to meet a fixed file count or to pre-refactor all files above a preferred size.

**Gate:** Every task has an observable outcome, necessary touchpoints, dependencies, testable criteria, applicable constraints, and a verification plan.

## Step 4: Synchronize the Status Dashboard

1. Replace the placeholder `| Execute | Todo |` row in `00-status.md` with concise task rows (`| Task 1: <Short Slug> | Todo |`, `| Task 2: <Short Slug> | Todo |`, ...).
2. Keep phase and task statuses in `00-status.md`; keep task-level acceptance checkboxes in `03-roadmap.md` only. Do not duplicate checkboxes in `01-requirements.md`.
3. Add or update the Resume Checkpoint with the approved outcome, task order, key constraints, blockers, and next action.
4. Set Roadmap to `In Review`.

**Gate:** Every roadmap task has one matching status row and the source-of-truth locations are unambiguous.

## Step 5: Exit Check and Approval

Verify:

- [ ] All in-scope `REQ-X`, `AC-X.Y`, and `BR-X` items are covered by the roadmap.
- [ ] Task ordering (`P0` → `P1` → `P2` → `P3`) and dependencies are coherent.
- [ ] Every new/modified file path is consistent with `.agents/rules/` folder and naming conventions (`<module>_validator`, 4-tier widget placement).
- [ ] Any temporary compatibility alias created in an early task has an explicit `Delete:` touchpoint in a later task.
- [ ] Material risks, migration/data effects, permissions, failure handling, and external dependencies have a task or explicit reason they do not apply.
- [ ] Relevant tests, exact verification commands, and `Prerequisites / Environment Setup` under Human Verification Gate are specified.
- [ ] User-owned unresolved decisions are not silently assumed.
- [ ] Task rows exist in `00-status.md` with short slugs.

Log meaningful friction in `04-refine.md`. Present a concise summary in chat linking `lifecycle/03-roadmap.md` (no chat tables), identify the largest trade-off or risk, note any verification limitation, and stop for plan approval. On approval, mark Roadmap `Done` in `00-status.md`, update the checkpoint, read [`lifecycle-execute/SKILL.md`](../lifecycle-execute/SKILL.md), and auto-advance to Task 1.
