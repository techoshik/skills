---
name: lifecycle-execute
description: Implement the active roadmap task with instruction re-anchoring, focused verification, and evidence-based handoff (Lifecycle: Execute).
---

# Lifecycle Execute

Implement one active task from `lifecycle/03-roadmap.md` at a time. Follow approved behavior, preserve project conventions, and verify the result against the task's outcome and acceptance criteria. Do not let implementation momentum replace problem comprehension.

## 0. Phase Rules & Guardrails

- **One active task:** Work only on the task marked `In Progress` in `00-status.md`.
- **Re-anchor every task:** Before editing, reread the task outcome, mapped requirement/acceptance-criteria/business-rule IDs, applicable `.agents/rules/`, and the Resume Checkpoint. Do not rely only on conversational memory or what a prior task did.
- **Understand before editing:** Trace the existing behavior and relevant callers. Know why the change is needed, what must remain unchanged, and how success will be verified.
- **Approved scope is the boundary:** Do not jump ahead to future tasks. If implementation reveals a necessary unlisted file or behavior, inspect the need and update the roadmap/status before expanding scope. Ask the user before material behavior, architecture, data, security, or scope changes.
- **Never make consequential assumptions:** If missing information changes business behavior, permissions, financial/data results, deletion/migration, user experience, or irreversible behavior, pause and ask. For routine low-risk details, follow established project conventions.
- **Follow project rules:** Use canonical architecture, UI components/tokens, naming, file placement, and security rules. Treat hard limits in project rules as hard limits; treat general size guidance as a reason to evaluate, not to perform unrelated refactoring.

## Step 1: Select and Re-anchor the Active Task

1. Read `00-status.md`, its Resume Checkpoint, and `03-roadmap.md`. Confirm Roadmap is `Done` and identify the active `In Progress` task (or first `Todo` task).
2. Confirm the task's outcome, dependency, touchpoints, acceptance criteria, constraints, and verification steps. Trace them back to `01-requirements.md` by ID.
3. If the plan conflicts with approved requirements, current code, or a project rule, do not guess which source to prefer. Identify the conflict, gather the evidence, and route it back through the relevant phase before proceeding.
4. Set the selected task to `In Progress` and update the Resume Checkpoint with the immediate next action.

**Gate:** The intended result, non-negotiable constraints, and proof of success are clear.

## Step 2: Inspect Before Writing

1. Read the complete target files and the relevant tests—not only the lines mentioned in the task.
2. Inspect immediate callers, related state/controller/repository paths, model serialization, routes, permissions, validation, caches, and linked side effects as applicable.
3. Read the specific project rules referenced in the roadmap and discover any additional applicable rules.
4. Check the working tree using read-only Git commands so user changes are not overwritten. Never run prohibited Git commands.
5. Establish relevant baseline behavior or checks where practical, especially when a test/analyzer already has failures.
6. If delegating, give the worker the approved outcome, exact scope, REQ/AC/BR IDs, rules, files/callers, tests, and boundaries. Inspect the worker's diff and independently verify material results.

**Gate:** You can explain the code path being changed, the potential side effects, and the verification plan.

## Step 3: Implement the Task

1. Implement the smallest coherent change that satisfies the outcome and criteria. Prefer existing abstractions and patterns when they are appropriate; do not reuse a flawed pattern without examining its consequences.
2. Keep changes limited to the approved slice. If a necessary change exceeds the agreed scope, pause, explain why, update the roadmap/status, and get approval where the change is material.
3. Add/update tests for the actual risk: logic, validation, state transitions, permissions, data access, concurrency, or UI behavior as relevant.
4. Do not mark a requirement satisfied based on code appearance alone. Verify the observable behavior or provide a clear reason why it cannot be tested in the available environment.
5. Do not start watchers or long-running background generators. Do not perform prohibited Git operations.

**Gate:** The intended code/test changes are present and remain within the approved scope.

## Step 4: Verify, Correct, and Record Evidence

Evaluate the implementation against these gates and correct failures before handoff:

1. **Outcome:** The user's intended capability is actually delivered.
2. **Acceptance criteria:** Each applicable criterion for the task passes.
3. **Business rules and safety:** Relevant BRs, permissions, tenancy, validation, data integrity, lifecycle, and failure behavior remain correct.
4. **Architecture and scope:** File placement, naming, shared components, callers, and project rules are respected; no unintended behavior or unrelated cleanup was introduced.
5. **Automated verification:** Run the exact applicable test/analyzer commands from the roadmap and record the actual results.

### Evidence rules

- Report each check as **Passed**, **Failed**, or **Not Run**. If `Not Run`, state why and what remains unverified.
- Do not claim zero issues or a fully passing suite unless the command actually ran and showed that result.
- When the baseline already fails, distinguish pre-existing issues from new regressions. Do not silently broaden scope to repair unrelated baseline failures; report them and ask or create a task if they block safe completion.
- Rerun relevant checks after the final code change. Test results from before a later edit are not evidence for the final code.
- Inspect the final diff and changed-file list. Ensure there are no accidental edits, secrets, debug logs, or unnecessary compatibility shims.
- Mark task-level acceptance checkboxes only in `03-roadmap.md`. Keep `01-requirements.md` as the stable specification; do not mirror execution checkboxes there.
- Record meaningful mistakes or missing rules in `04-refine.md` with the cause and proposed prevention.

**Gate:** Actual verification evidence supports the result; limitations and remaining issues are explicit.

## Step 5: Human Review and Handoff

1. Update the Resume Checkpoint in `00-status.md` with files changed, checks and exact outcomes, known limitations, and next action. Set the active task to `In Review`.
2. Present a concise 4-bullet handoff in chat (linking to `lifecycle/03-roadmap.md`, no chat tables):
   - **Outcome:** What capability now works.
   - **Changed Files:** Exact source and test files created, updated, or deleted.
   - **Verification Evidence:** Exact analyzer and test commands run and their `Passed` / `Failed` / `Not Run` outcomes.
   - **Human Verification Gate:**
     - `Prerequisites / Environment Setup:` Required emulator/server, test role, seed data, or starting state.
     - `Action:` Numbered steps to trigger in the app/browser.
     - `Expected:` Observable outcome (plus any open risk or decision for the user).
3. Stop and wait for approval. Do not imply that an unrun test passed or that a user-facing change has been validated if the user has not verified it.
4. On approval, mark the task `Done` in `00-status.md`. Start the next `Todo` task if one remains; after all tasks are `Done`, read [`lifecycle-review/SKILL.md`](../lifecycle-review/SKILL.md) and auto-advance to Review.

### Mid-flight requirement or UX change

If the user changes a requirement or points out a better workflow, pause coding on the affected behavior and follow Section 6 of `lifecycle/SKILL.md`: run a quick micro-brainstorm to confirm the cleanest flow, update `01-requirements.md` in place, update `03-roadmap.md` and `00-status.md` with a proper numbered `Task N` (collapsing any fully superseded task heading to `## Task X: <Name> — ~(Superseded by Task N)~` rather than appending an unstructured footer), check for conflicting uncommitted changes, and stop for approval before implementing newly scoped work.
