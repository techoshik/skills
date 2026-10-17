---
name: lifecycle-execute
description: Execute exactly ONE checkpoint from 02-outline.md at a time, perform automated self-review, update 03-execute.md to User Review, and stop for human approval (DOER: Execute).
---

# Execute

The goal of this skill is to **Execute** the implementation outline precisely as designed in the `02-outline.md` artifact (Phase 3 of the DOER lifecycle). Your mission is to build one vertical story slice at a time, run automated self-review, update the status dashboard, and stop for human testing.

---

## 1. Entry Gate (Strict Status Check)

Before executing any code:
1. Open `lifecycle/03-execute.md`.
2. Verify that **`Phase 2: Outline` is marked `Done`**.
3. Verify that `lifecycle/02-outline.md` exists and contains defined checkpoints.
4. **STOP if unapproved:** If `Phase 2: Outline` is not `Done`, do not write any production code. Instruct the user to complete and approve Outline first.

---

## 2. Tool & Git Boundaries (INVIOLABLE)

- **Strict Git Ban:** The agent is **strictly forbidden** from running `git add`, `git commit`, `git reset`, `git restore --staged`, or any git staging/committing commands. The user owns 100% of git commits and staging!
- **Strict Build Tool Ban:** The agent is **strictly forbidden** from running `build_runner`. The user owns code generation.

---

## 3. The Single Checkpoint Law (Strict Isolation)

You are strictly forbidden from executing multiple checkpoints in the same turn. Behave like a senior engineer submitting granular, isolated, reviewable increments:

1. **Identify the Active Checkpoint:** In `lifecycle/03-execute.md`, find the first checkpoint with status `Todo` or `In Progress`.
2. **Set In Progress:** Update its status in `lifecycle/03-execute.md` to **`In Progress`**.
3. **Execute Only This Slice:** Implement *only* the file changes listed under `- [ ] <file_path>:` for this specific checkpoint in `02-outline.md`. Do not touch subsequent checkpoints.
4. **Execution Strategy (Context Hygiene):**
   - **Direct Execution:** For small slices (1–2 files), execute directly within the current context.
   - **Worker Sub-Agent Delegation (Recommended for multi-file slices or long sessions):**
     - Invoke a sub-agent (`TypeName: 'self'`, `Role: 'Checkpoint Worker'`, `Workspace: 'inherit'`).
     - Prompt includes: the exact checkpoint definition from `02-outline.md`, referenced guidelines, and strict bans (no `git add/commit`, no `build_runner`).
     - The sub-agent implements code, runs static analysis, runs tests, checks boxes in `02-outline.md`, and reports back.
     - The sub-agent terminates, keeping the main context clean.
5. **Check Implementation Boxes:** Once code changes are written, update `02-outline.md` to check the file change boxes (`- [x] <file_path>:`).

---

## 4. Active 3-Part Self-Review (MANDATORY AT EVERY CHECKPOINT)

Before presenting ANY checkpoint to the user, you MUST immediately execute the self-review steps specified in `02-outline.md` for this specific slice. Do NOT postpone rule verification to later checkpoints:

1. **Rule Compliance Verification:** Physically inspect the referenced `.agents/rules/<rule>.md` file. Verify that your implementation strictly satisfies all architectural invariants:
   - **Direct Client SDK First:** Direct Firestore/Storage Client SDK operations used; 0 Cloud Functions created for CRUD.
   - **500-Line Soft Ceiling:** No modified or created file balloons past ~500 lines without extracting natural sub-widgets or sub-controllers.
   - **Architecture Invariants:** Checkpoint-specific invariants verified (e.g. `StatefulWidget` is strictly prohibited; HookWidget/StatelessWidget only; display formatting in domain models; no DB primitives in UI).
   - If any violation is detected, **FIX IT IMMEDIATELY** within this checkpoint before proceeding.
2. **Static Analysis:** Run the exact command listed in the checkpoint (e.g., `flutter analyze <path>`). It must report **0 issues**. Fix any linter or compiler warnings silently before proceeding.
3. **Automated Tests (Highest Natural Seam):** Run the exact test command listed in the checkpoint (e.g., `flutter test <path>`). Tests must run fast at the logic seam and pass **100% cleanly**. Never write or maintain shallow UI tests that only assert static text or widget presence.
4. **Check Self-Review Boxes:** Once all pass, update `02-outline.md` to mark the self-review checkboxes:
   - `- [x] **Rules Compliance:**`
     - `- [x] **Direct Client SDK First:** ...`
     - `- [x] **500-Line Soft Ceiling:** ...`
     - `- [x] **Architecture Invariants:** ...`
   - `- [x] **Static Analysis:** ... reports 0 issues.`
   - `- [x] **Tests:** ... passes cleanly.`

---

## 5. Friction Logging

If you encounter unexpected bugs, ambiguous rules, or tooling quirks while executing:
- Do not stop executing to rewrite global project rules.
- Append the issue immediately to `lifecycle/04-refine.md` under `## 3. Friction & Lessons Learned`.
- **Exception:** If an unresolved technical blocker or impossible verification step completely halts progress, **STOP** and ask the user for clarification before continuing.

---

## 6. Human Handoff (Approval Gate)

1. Update the current checkpoint's status in `lifecycle/03-execute.md` to **`User Review`**.
2. Present a concise review summary in chat:
   - **What was built:** The specific files modified and capabilities delivered.
   - **Rule Compliance Check:** Explicitly confirm the verified rule checkboxes for this checkpoint (e.g., Direct Client SDK First confirmed, 500-Line ceiling respected, Framework invariants satisfied).
   - **Self-Review Proof:** Confirmation that static analysis has 0 issues and automated tests passed.
   - **Human Verification Steps:** Present the exact `Action` and `Expected` instructions from the checkpoint's `Verification` block so the user can test in the running app/browser.
3. **STOP AND WAIT.** The agent is strictly forbidden from marking any checkpoint `Done` on its own.
4. **On User Approval:**
   - When the user tests and explicitly approves in chat, update that checkpoint's status in `lifecycle/03-execute.md` to **`Done`**.
   - Check `lifecycle/03-execute.md` for remaining checkpoints:
     - If more checkpoints remain: Proceed to the next checkpoint (mark `In Progress` and repeat).
     - If all checkpoints are `Done`: Read the master [`lifecycle`](../lifecycle/SKILL.md) skill to route to **Phase 4: Refine**.
