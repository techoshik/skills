---
name: lifecycle-build
description: Implement approved tasks one at a time, enforce actionable rule checks, perform active diff scrubs and risk-based verification, and halt for human review after every task (Lifecycle: Phase 4 — Build).
---

# Phase 4 — Lifecycle Build

## 1. Purpose

> **Core Mental Model:** One task at a time. Check every `Verify` rule actively. Prove with real test runs. Ship only what was approved.

Implement `lifecycle/03-plan.md` strictly **one task at a time**. Stop for explicit human review and approval after every individual task before starting the next.

---

## 2. Core Rules

- **Strict Single-Task Scope (No Batching, No Silent Divergence):** Implement only the approved changes (`C1`, `C2`...) and target files of the active task. Never touch files for later tasks while the current task awaits review. If a flaw or unexpected seam surfaces mid-build, halt and follow the In-Flight Plan Amendment Protocol.
- **System Ownership (No Speculative Forks):** When uncovering an architectural gap mid-build, never ask open-ended *"Should we do A or B?"* questions. Internally evaluate trade-offs and present **one concrete, settled proposal** with rationale via the In-Flight Plan Amendment Protocol.
- **Re-Anchor & Inspect Before Editing:** Re-read the active task in `lifecycle/03-plan.md`, read target files in full (not snippets), and `grep` immediate callers/routes before writing code. Never rely on conversational memory across multi-task sessions.
- **Actionable Rule Verification Is Mandatory:** Read and verify **every `- Verify <exact condition> (<file> — <Section>)` bullet** under `Agent Verification` before coding and again before handoff. Never treat rules as optional hints.
- **Red-Green Proof & Honest Evidence (`Passed` / `Failed` / `Not Run`):** For bugfixes and new logic, prove the failing seam first (Red) and the passing test after (Green). Never claim a check passed unless the runner actually executed and passed — report unexecuted suites honestly as `Not Run`, and distinguish pre-existing baseline failures from new regressions.
- **Active Pre-Handoff Diff Scrub:** Never eyeball `git diff` passively — actively scan the diff for banned primitives, raw design literals, raw query strings, debug logs, accidental whitespace edits, and jargon copy before requesting review.
- **Propose Improvements, Never Sneak Them In:** Spot code quality, performance, or security improvements proactively and share them in chat, but never implement extra changes without explicit user approval.
- **Mandatory Friction Logging (`lifecycle/refine.md`):** Immediately append an entry to `lifecycle/refine.md` (with `Classification: One-off | Project-specific | Framework-wide`) whenever a rule invariant conflicts with reality, a task spec is ambiguous, a repeatable defect pattern emerges, or an in-flight plan amendment is required.

---

## 3. Execution Sequence

### 3.1 Step 1 — Re-Anchor, Inspect & Pre-Flight Check

1. **Re-Anchor to Active Task:** Read `lifecycle/00-status.md` and `lifecycle/03-plan.md`. Identify the active `In Progress` (or next `Todo`) task and re-read its **Blast Radius**, **Changes** (`C1`, `C2`...), **Seam Note** (if any), **Agent Verification** (`- Verify ...` lines + commands), and **User Verification**.
2. **Inspect Callers & Baseline:** Read target files in full, `grep` callers/routes/models to protect existing contracts, and run read-only `git status` (plus baseline tests if pre-existing failures are suspected).
3. **Pre-Flight Failure-Mode Check (Complex UI, State Sync, or Dual-Engine Tasks):**
   Before writing code on interactive UI, state synchronization, or multi-engine tasks, briefly verify five predictable failure modes where applicable:
   - *Focus & Modal Lifecycle:* What happens to input focus and selection when a dialog/drawer opens, closes, or triggers a parent rebuild?
   - *Writer/Reader Contract Parity:* Do input writers, resolvers, and persistence layers use the exact same key format and enums?
   - *Closure & Ref Freshness:* Do event callbacks read live state/refs after add, reorder, or delete mutations?
   - *Widget Tree Stability:* Can typing or state updates filter out, re-key, or unmount the widget currently under the user's cursor?
   - *Cross-Engine Single Source of Truth:* When two engines render the same model (e.g. interactive UI + export/print), do both read from the same domain constants and enums?

### 3.2 Step 2 — Implement Minimal Compile-Clean Slice

1. **Write Minimal Coherent Changes:** Implement only the active task's `C-N` items, reusing existing project utilities and patterns. Keep the codebase buildable and testable after every task (if renaming a shared symbol early, update callers in the same task or schedule explicit alias removal).
2. **Enforce Every `Verify` Bullet:** Satisfy every `- Verify <exact condition> (<file> — <Section>)` line declared under `Agent Verification` in `03-plan.md` with zero unapproved deviations.
3. **In-Flight Plan Amendment Protocol (Mid-Build Discoveries):**
   When an architectural defect, security flaw, race condition, or broken contract is discovered:
   - *Halt Coding:* Stop immediately — never silently diverge from `03-plan.md`.
   - *Propose One Settled Correction:* Share verified evidence, why the plan fails, and one concrete adjustment in chat.
   - *Get Explicit Approval:* Wait for user approval before editing upstream docs or resuming.
   - *Update Upstream Docs in Place:* Update `03-plan.md` (plus `01-discover.md` / `02-design.md` if flows changed) and sync task titles and anchor links in `00-status.md`.

### 3.3 Step 3 — Active Verification, Diff Scrub & Serial Handoff

1. **Execute Every `Agent Verification` Item:**
   - Check every `- Verify <exact condition> (<file> — <Section>)` bullet in `03-plan.md` against the actual diff.
   - Run the project linter/analyzer (e.g. `flutter analyze`, ESLint) and fix all warnings/line-length issues — never disable lint rules to hide violations.
   - Run every automated test command listed under `Agent Verification` and confirm Red-Green proof for bugfixes/new logic.
2. **Active Pre-Handoff Diff Scrub (Scan, Don't Just Eyeball):**
   Run read-only `git diff` and **actively scan/search** the added lines for:
   - **Hygiene:** Accidental whitespace edits to untouched code, leftover `console.log`/`print`/`debugger`, unused imports, or temporary mocks.
   - **Design System Tokens (`.agents/rules/design_system.md`):** Raw numeric `EdgeInsets`, `SizedBox(width/height: <number>)`, `Icon(size: <number>)`, custom `TextStyle(...)`, raw `Color(0x...)`/`Colors.*`, or `.withValues(alpha:)`/`.withOpacity()`. If a token or widget is missing, **ask the user first**.
   - **Prohibited Primitives & Canonical Chrome:** Framework primitives linters miss — raw dialogs (`showDialog`, `AlertDialog`), raw navigation (`Navigator.of(context)`), raw buttons (`TextButton`, `ElevatedButton`, `FilledButton`), raw loading/empty/error widgets (`CircularProgressIndicator`, ad-hoc error/empty `Column`s), banned widget base classes (`StatefulWidget`, standalone `HookWidget`), bespoke scaffold top bars or inline body drawers, and action buttons placed inside dialog `content` instead of the canonical dialog `actions` slot.
   - **Centralized Constants:** Zero raw string literals in DB query filters or transport payloads — consume canonical `<module>_constants`.
   - **Plain-Language Copy (5th-Grade Standard):** Zero developer or corporate jargon in titles, buttons, hints, toasts, or errors.
3. **Halt for Human Review (Strictly Serial Gate):**
   - Set the task row to `In Review` in `lifecycle/00-status.md` (never `Done` before explicit user approval).
   - Stop calling tools and output a concise summary linking `[03-plan.md](03-plan.md)` confirming: (a) each `Verify` check & linter/test result, and (b) the exact `User Verification` steps to run. Wait for explicit approval before starting the next task.

---

## 4. Exit Gate & Completion Criteria

### Task Pre-Flight Gate

Before requesting user review, verify:
- **Scope Implemented:** All approved `C-N` changes across target files are complete and compile-clean.
- **Every `Verify` Check Confirmed:** Every `- Verify <exact condition> (<file> — <Section>)` bullet under `Agent Verification` is explicitly verified with zero unapproved deviations.
- **Linter & Tests Passed:** Project linter and all `Agent Verification` test commands executed and passed.
- **Active Diff Scrub Clean:** Diff actively scanned with zero banned primitives, raw design literals, debug logs, or jargon copy.
- **Status Updated:** Active task row in `lifecycle/00-status.md` is set to `In Review`.

### Gate Outcomes

- **Approved:** Mark active task `Done` in `lifecycle/00-status.md`. Advance to the next `Todo` task, or load `lifecycle-close` if all Phase 4 tasks are `Done`.
- **Changes Requested:** Set active task `In Progress`, apply fixes, re-run verification + diff scrub, and re-present.
- **Blocked:** Mark `Blocked` and resolve via In-Flight Plan Amendment Protocol before proceeding.

---

## 5. Phase Output

1. **Implemented Source Code & Tests:** Clean, verified code strictly adhering to project rules.
2. **Updated Status Dashboard:** Completed tasks marked `Done` in `lifecycle/00-status.md`.
3. **Friction Log (`lifecycle/refine.md`):** Any build friction, rule ambiguity, repeatable defect, or plan amendment logged immediately for Phase 5 Close.
