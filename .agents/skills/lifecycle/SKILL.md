---
name: lifecycle
description: Master orchestrator and router for the development lifecycle (Define → Outline → Execute → Refine).
disable-model-invocation: true
---

# Lifecycle Orchestrator

The `lifecycle` skill is the master router for feature development. It ensures work progresses through a disciplined, reviewable pipeline: **Define (`01`) → Outline (`02`) → Execute (`03`) → Refine (`04`)**.

## 1. Single Source of Truth for Status
All project status and approvals are tracked exclusively in **`03-execute.md`**.
- Do NOT search for or add approval checkboxes in `01-define.md`, `02-outline.md`, or `04-refine.md`.
- `03-execute.md` is initialized at the start of the feature and tracks every phase and checkpoint using 4 allowed statuses:
  - ⚪ `Todo`: Not started yet.
  - 🟡 `In Progress`: Actively being worked on and self-reviewed by the agent.
  - 🟠 `User Review`: Agent completed the work and self-review; **waiting for user review & approval**.
  - 🟢 `Done`: User explicitly tested and approved in chat.

## 2. Context Hygiene
Do NOT load or read all phase skills at once. Check `03-execute.md` to determine the current state, then read **only** that specific phase's `SKILL.md` file.

## 3. Phase Routing

| Current Status in `03-execute.md` | Next Action | Phase Skill to Read |
| :--- | :--- | :--- |
| No `01-define.md` exists (Define is `Todo` or `In Progress`) | Work on feature definition | [`lifecycle-define`](../lifecycle-define/SKILL.md) |
| `Phase 1: Define` is `User Review` | **STOP**; wait for user approval | [`lifecycle-define`](../lifecycle-define/SKILL.md) |
| `Phase 1: Define` is `Done`; no `02-outline.md` exists | Work on architecture outline | [`lifecycle-outline`](../lifecycle-outline/SKILL.md) |
| `Phase 2: Outline` is `User Review` | **STOP**; wait for user approval | [`lifecycle-outline`](../lifecycle-outline/SKILL.md) |
| `Phase 2: Outline` is `Done`; checkpoints in `Todo`/`In Progress` | Execute next single checkpoint | [`lifecycle-execute`](../lifecycle-execute/SKILL.md) |
| Checkpoint is `User Review` | **STOP**; wait for user approval | [`lifecycle-execute`](../lifecycle-execute/SKILL.md) |
| All checkpoints are `Done`; `Phase 4: Refine` is `Todo`/`In Progress` | Run global review & handoff | [`lifecycle-refine`](../lifecycle-refine/SKILL.md) |
| `Phase 4: Refine` is `User Review` | **STOP**; wait for user sign-off | [`lifecycle-refine`](../lifecycle-refine/SKILL.md) |

## 4. The 4 Lifecycle Artifacts
All active tracking files live in `lifecycle/` at the project root and are safely deleted upon completing Refine:
- **`01-define.md`** (Define): Problem, Outcome, Success Criteria, List of Changes, Out of Scope, Decisions (accompanied by an interactive `prototype.html` for UI features).
- **`02-outline.md`** (Outline): Sequential Milestones, Vertical Slices, File Changes, Self-Review, Verification.
- **`03-execute.md`** (Execute): The single source of truth status dashboard.
- **`04-refine.md`** (Refine): Pull Request synthesis, permanent guideline updates, and friction log.

## 5. Human Approval Law (INVIOLABLE)
- **The user owns approval; the agent owns execution.**
- The agent is **strictly forbidden** from marking any phase or checkpoint as `Done` on its own.
- When an action is complete and self-reviewed, the agent updates status to `User Review` in `03-execute.md` and **STOPS**. It must wait for explicit human approval in chat before marking `Done` and advancing to the next task.

## 6. Approval Invalidation
If the user modifies an already-approved document (e.g. changing scope in `01-define.md` or architecture in `02-outline.md`):
- Reset dependent phase statuses in `03-execute.md` back to `In Progress` or `Todo`.
- Re-evaluate affected work and obtain explicit re-approval before continuing.

## 7. Continuous Friction Logging
If you encounter unexpected roadblocks, ambiguous guidelines, or technical bugs during **ANY phase**:
- Do not stop to rewrite global rules mid-task.
- Immediately append the issue to **`04-refine.md`** under `## 3. Friction & Lessons Learned`.
- Continue execution. The Refine phase will permanently resolve the issue.

## 8. Orchestrator–Worker Architecture (Context Hygiene)
To prevent context rot and maintain high reasoning precision throughout long tasks:
- **Main Agent (Orchestrator):** Preserves the overarching task narrative, interacts with the user, updates `03-execute.md`, and manages human approval gates.
- **Worker Sub-Agents (Fresh Context Execution):**
  - *Outline Research:* May spawn a `research` sub-agent to explore 10+ codebase files, returning a concise architectural summary without cluttering main context.
  - *Checkpoint Execution:* May spawn a `self` worker sub-agent with `Workspace: 'inherit'` to implement a specific vertical checkpoint, run static analysis and tests, and report back. The sub-agent's tool clutter is discarded upon completion.
  - *Refine Audit:* May spawn an auditor sub-agent to review the full-branch diff against guidelines with unbiased "fresh eyes".
- **Strict Boundary Inheritance:** All sub-agents strictly inherit the project boundaries: **NEVER run git staging/committing (`git add/commit`)** and **NEVER run `build_runner`**.
