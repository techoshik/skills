---
name: lifecycle-build
description: Implement approved tasks incrementally, enforce rule compliance, perform risk-based verification, and present task completion reports for user review (Lifecycle: Phase 4 — Build).
---

# Phase 4 — Lifecycle Build

## 1. Purpose

> **Core Mental Model:** One task at a time. Follow the rules. Verify with evidence. Ship only what was approved.

Implement the approved Implementation Plan from Phase 3 (`lifecycle/03-plan.md`) by following the defined technical approach, project conventions, and assigned Rule Files.

The Agent must re-anchor to the active task, inspect existing callers and code before writing, implement focused slices incrementally, maintain code hygiene, and verify all automated checks before presenting work for human review.

Tasks are executed strictly one task at a time. The Agent must stop for explicit human review and approval after every individual task before starting the next.

---

## 2. Guiding Principles

- **Follow the Approved Plan:** Implement only the approved scope, changes (`C1`, `C2`...), and file targets from `lifecycle/03-plan.md`. Do not silently add files or change architecture. If an architectural flaw or vulnerability is uncovered, follow the In-Flight Plan Amendment Protocol.
- **System Ownership (No Speculative Forks):** When encountering an architectural gap or unexpected seam mid-build, the agent must NEVER present open-ended speculative forks (*"We could either do A or B"*). The agent must internally evaluate trade-offs, take ownership, and present **one concrete, settled proposal** with clear rationale via the In-Flight Plan Amendment Protocol.
- **Instruction Re-Anchoring:** Before editing, re-read the active task in `lifecycle/03-plan.md`, its assigned Rule Files, and its verification criteria. Never rely on conversational memory across multi-task sessions.
- **Understand Before Changing (Caller & Seam Inspection):** Read target files and trace callers via read-only search (`grep`) before writing code. Know why the change is needed, what contracts must remain unbroken, and how success will be verified.
- **Rule Compliance Is Mandatory:** Inspect each individual `Rule [<Rule Name>]` declared under Agent Verification before writing code and before requesting review. Verify strict compliance against its documented invariants.
- **Red-Green Seam Proof (Proof of Cause):** For bugfixes and new logic, prove the seam: verify the failing behavior or error log before editing (Red), implement the targeted change, and prove the automated check passes after (Green). Never claim a fix works without proving the causal link.
- **Implement the Smallest Coherent Slice:** Keep changes focused, minimal, and compile-clean. Avoid horizontal fragmentation or sweeping refactors that touch unrelated files.
- **Pre-Handoff Diff Scrub (Hypo-Allergenic Diffs):** Audit `git diff` line-by-line before requesting review: ensure zero accidental whitespace modifications to untouched code, zero leftover `console.log`, `debugger`, or temporary shims, zero orphaned imports, zero hardcoded design literals (magic numbers on padding, margins, icon sizes, spacers, or raw colors) bypassing canonical design system tokens, and clear plain-language copy. Every line in the diff must directly serve the task.
- **Honest Evidence Reporting (`Passed` / `Failed` / `Not Run`):** Never claim a check passed unless it was actually executed. Distinguish pre-existing baseline test failures from new regressions; never silently broaden scope to fix unrelated baseline issues.
- **Improve Proactively, Change Only With Approval:** Actively spot opportunities to improve code quality, performance, or security, but present them as recommendations in chat. Never implement extra changes without explicit user approval.
- **Strict Phase Boundaries (Negative Constraints):**
  - **No Task Batching:** Implement strictly one task at a time. Never touch files or write code for subsequent tasks while the current task is awaiting review.
  - **No Silent Plan Divergence:** Never alter requirements, flows, or task scope unilaterally; follow the In-Flight Plan Amendment Protocol for mid-build discoveries.
  - **No Unapproved Improvements:** Spot improvement opportunities proactively, but never implement extra changes without explicit user approval.
  - **No Unverified Handoffs:** Never mark an agent check passed without executing it; never present unverified work.

---

## 3. Responsibilities & Sequence

Implementation follows three disciplined chronological steps for each task:

### 3.1 Step 1 — Re-Anchor, Inspect & Verify Baseline

1. **Re-Anchor to the Active Task:**
   - Read `lifecycle/00-status.md` and `lifecycle/03-plan.md`. Identify the active `In Progress` task (or next `Todo` task).
   - Re-read the task's **Blast Radius**, **Changes** (`C1`, `C2`...), **Files** (mapped targets with action verbs), **Agent Verification** (assigned rules & automated checks), and **User Verification**.
2. **Inspect Callers & Target Files:**
   - Read target files in full—not just snippets.
   - Inspect immediate callers, routes, and data models via read-only searches (`grep`) to prevent broken contracts or unexpected side effects.
3. **Verify Baseline & Working Tree:**
   - Run read-only `git status` to ensure no uncommitted or conflicting user edits exist.
   - Run relevant baseline tests if existing test suite failures are suspected, distinguishing prior failures from new regressions.

### 3.2 Step 2 — Implement Slice & Enforce Rules

1. **Write Minimal Coherent Changes:**
   - Implement only what is required to satisfy the active task's scope.
   - Reuse existing application utilities and established patterns rather than duplicating logic.
2. **Maintain a Compile-Clean Slice:**
   - Keep the codebase buildable and testable after each task.
   - If an early task renames a shared symbol, either update callers in the same task or introduce a temporary compatibility alias explicitly scheduled for removal in a subsequent task.
3. **Enforce Named Rules:**
   - Inspect each `Rule [<Rule Name>]: <file>` declared under **Agent Verification**. Follow every invariant strictly without exception.
4. **In-Flight Plan Amendment Protocol (Mid-Build Discoveries):**
   When an architectural defect, security flaw, race condition, or broken contract is discovered during implementation:
   - *Halt Coding Immediately:* Stop writing code that implements an unworkable design. Never silently diverge from `lifecycle/03-plan.md`.
   - *Formulate Correction Proposal:* State the verified finding with concrete evidence, explain why the plan fails, and outline the adjustment.
   - *Obtain Explicit Human Approval:* Present the proposal in chat. Stop and wait for explicit user approval before modifying the plan or proceeding.
   - *Update Upstream Source of Truth in Place:* Update the affected task in `lifecycle/03-plan.md`, realign `lifecycle/01-discover.md` / `lifecycle/02-design.md` if core flows changed, and update `lifecycle/00-status.md` if tasks were added/split.
   - *Resume Implementation:* Proceed under the updated specification.

### 3.3 Step 3 — Verification, Diff Scrub & Serial Task Handoff

1. **Execute Agent Verification (Named Rules & Automated Proof):**
   - Verify modified files against each individual `Rule [<Rule Name>]` listed under **Agent Verification** in `lifecycle/03-plan.md` (e.g. file size thresholds, idempotent migration rollback).
   - Run the exact automated test and verification commands declared under **Agent Verification** in `lifecycle/03-plan.md`.
   - For bugfixes or logic changes, verify the Red-Green evidence (failing before, passing after).
2. **Pre-Handoff Diff Scrub:**
   - Run read-only `git diff` line-by-line to verify:
     - Zero accidental whitespace modifications to untouched code, zero debug statements (`console.log`, `print`, `debugger`), zero unused imports, and zero temporary mocks.
     - **Design System Token & Component Primacy:** Zero raw numeric padding/insets (`EdgeInsets.all/symmetric/only(<number>)`), zero raw integer sizes on icons (`Icon(size: <number>)`), zero ad-hoc spacers (`SizedBox(width/height: <number>)`), zero raw color literals, and zero manual alpha overlays (`.withValues(alpha: ...)`, `.withOpacity(...)`). All UI must strictly consume the project's canonical design system library (widgets, spacing tokens, typography, theme colors, dialogs, toasts, loaders). If any widget, spacing guideline, icon size token, or style appears to be missing in the design system library, **ask the user first** for direction rather than creating ad-hoc custom solutions, raw literals, or bespoke widgets.
     - **Centralized Constants & Zero Raw Query Literals:** Zero raw string literals in database query filters (`.where(col, "==", "raw_string")`, `.orderBy()`) or transport payloads. All collection paths, field names, and status/type values MUST reference canonical runtime constants from the module's dedicated `<module>_constants` file (`<module>_constants.ts` or `<module>_constants.dart`).
     - **Plain-Language Copy Audit (5th-Grade Standard):** Audit all user-facing text (dialog titles, buttons, form hints, descriptions, toasts, and error messages). Zero developer or corporate jargon allowed (e.g. no "synchronize", "manage tiers", "submitting payload"). Text MUST be simple, clear, everyday English that a 5th-grade student can easily read, understand, and use without confusion.
4. **Halt for Human Review (Strictly Serial Gate):**
   - Keep the main task checkbox unchecked (`- [ ]`) in `lifecycle/03-plan.md` (only the user checks this upon approval).
   - Update the task status to `In Review` in `lifecycle/00-status.md`.
   - Stop calling tools immediately and output the lean chat completion report:

   ```markdown
   **Task 4.X: [Task Title] Complete**
   - **Changes:** [1-sentence summary of implemented slice]
   - **Automated Checks:** [Commands run] -> `Passed`
   - **User Verification:**
     - **Setup:** [Prerequisite or None]
     - **Action:** [Exact steps to test]
     - **Expected:** [Observable result]

   *Ready to proceed to Task 4.Y? Please confirm.*
   ```

---

## 4. Exit Gate & Completion Criteria

Phase 4 operates strictly **Task-by-Task**. A task is complete only when the pre-flight checklist is satisfied and the user grants explicit approval in chat.

### Task Completion Checklist (Pre-Flight Gate)

Before requesting user review for any task, verify that:
- **Scope Implemented:** Approved changes (`C1`, `C2`...) across target files have been implemented cleanly.
- **Rule Compliance Verified:** Every `Rule [<Rule Name>]` listed under **Agent Verification** is satisfied with zero unapproved deviations.
- **Automated Checks Passed:** All **Agent Verification** commands have been executed and passed.
- **Pre-Handoff Diff Scrubbed:** `git diff` is clean (no debug logs, dead code, secrets, accidental whitespace edits, raw design literals, or jargon copy).
- **Task Checkbox Unchecked:** Main task checkbox remains `- [ ]` in `lifecycle/03-plan.md` while awaiting review.
- **Status Dashboard Updated:** Task row in `lifecycle/00-status.md` is set to `In Review`.
- **User Verification Actionable:** Setup, Action, and Expected instructions are clear and testable.

### Gate Outcomes

- **Approved:** Mark the active task `- [x]` in `lifecycle/03-plan.md` and set its status to `Done` in `lifecycle/00-status.md`. Proceed to the next `Todo` task, or advance to Phase 5 — Close if all tasks are complete.
- **Changes Requested:** Mark active task `In Progress`, implement corrections, re-run verification and diff scrub, and present the updated handoff.
- **Blocked:** An unpredicted architectural conflict or broken dependency halts progress. Follow the In-Flight Amendment Protocol or return to earlier phases.

---

## 5. Phase Output

The deliverables of Phase 4 are:

1. **Implemented Source Code:** Clean, compile-tested application code, tests, and configuration changes adhering to project rules.
2. **Updated Implementation Plan:** Completed tasks marked `- [x]` in `lifecycle/03-plan.md` upon user approval.
3. **Updated Status Dashboard:** Completed tasks marked `Done` in `lifecycle/00-status.md`.
4. **Verification Evidence:** Passing automated test logs and verified User Verification steps.
5. **Upstream Lessons (Optional):** Any friction or rule improvements recorded in `lifecycle/refine.md` for review in Phase 5 Close.
