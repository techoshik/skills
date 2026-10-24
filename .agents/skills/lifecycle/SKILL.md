---
name: lifecycle
description: Master orchestrator and router for the 7-phase development lifecycle (Brainstorm → Prototype → Roadmap → Execute → Review → Finalize).
disable-model-invocation: true
---

# Lifecycle (Master Orchestrator)

The `lifecycle` skill is the master router for feature development. It drives work through a disciplined 7-phase sequential pipeline: **Brainstorm → Prototype → Roadmap → Execute → Review → Finalize**.

---

## 0. Core Mindset: Depth Over Speed

- **Never rush.** Speed comes from zero rework, not fast typing.
- **In Brainstorm:** Act as an elite researcher. Interrogate the root "why", map hidden 2nd-order ripple effects, and explore multiple solutions before writing specs.
- **In Engineering & Execute:** Always inspect full target files and immediate callers before proposing or writing code.

---

## 1. Status Dashboard (`lifecycle/00-status.md`)

All lifecycle progress and task statuses are tracked exclusively in **`lifecycle/00-status.md`**:
- Do **not** look for or invent status tables in other files.
- Uses 5 allowed statuses:
  - ⚪ `Todo`: Not started yet.
  - 🟡 `In Progress`: Actively being worked on or self-reviewed by the agent.
  - 🟠 `In Review`: Agent completed work and verification gates; **STOPPED for user review**.
  - 🟢 `Done`: User explicitly approved in chat.
  - 🔵 `Skipped`: Explicitly skipped with user approval (e.g. non-UI features skipping Prototype).

---

## 2. Context Hygiene (Single-Skill Rule)

- **Never load all 7 skills at once.**
- Check `lifecycle/00-status.md` first to identify the active phase.
- Load and read **only** that specific phase's `SKILL.md` file.

---

## 3. Phase Routing Matrix

| Condition in `00-status.md` | Active Phase | Next Action | Skill to Load |
| :--- | :--- | :--- | :--- |
| `00-status.md` does not exist | **Cold Start** | Initialize `00-status.md` & brainstorm | [`lifecycle-brainstorm`](../lifecycle-brainstorm/SKILL.md) |
| `Brainstorm` is `Todo` or `In Progress` | **Brainstorm** | Research, interview, and write spec | [`lifecycle-brainstorm`](../lifecycle-brainstorm/SKILL.md) |
| `Brainstorm` is `In Review` | **Brainstorm** | **STOP**; wait for user approval | [`lifecycle-brainstorm`](../lifecycle-brainstorm/SKILL.md) |
| `Brainstorm` is `Done`; `Prototype` is `Todo` | **Prototype** | Build component carousels & stress-test | [`lifecycle-prototype`](../lifecycle-prototype/SKILL.md) |
| `Prototype` is `In Review` | **Prototype** | **STOP**; wait for user variant choices | [`lifecycle-prototype`](../lifecycle-prototype/SKILL.md) |
| `Prototype` is `Done` or `Skipped`; `Roadmap` is `Todo` | **Roadmap** | Plan vertical slices & verification gates | [`lifecycle-roadmap`](../lifecycle-roadmap/SKILL.md) |
| `Roadmap` is `In Review` | **Roadmap** | **STOP**; wait for user plan approval | [`lifecycle-roadmap`](../lifecycle-roadmap/SKILL.md) |
| `Roadmap` is `Done`; any Roadmap task is `Todo`/`In Progress` | **Execute** | Implement active single vertical slice | [`lifecycle-execute`](../lifecycle-execute/SKILL.md) |
| Any Roadmap task is `In Review` | **Execute** | **STOP**; wait for user verification | [`lifecycle-execute`](../lifecycle-execute/SKILL.md) |
| All Roadmap tasks are `Done`; `Review` is `Todo`/`In Progress` | **Review** | Run full-branch audit & deduplication | [`lifecycle-review`](../lifecycle-review/SKILL.md) |
| `Review` is `In Review` | **Review** | **STOP**; wait for audit sign-off | [`lifecycle-review`](../lifecycle-review/SKILL.md) |
| `Review` is `Done`; `Finalize` is `Todo`/`In Progress` | **Finalize** | Sync docs, evolve rules, and output PR | [`lifecycle-finalize`](../lifecycle-finalize/SKILL.md) |
| `Finalize` is `In Review` | **Finalize** | **STOP**; wait for user approval & cleanup | [`lifecycle-finalize`](../lifecycle-finalize/SKILL.md) |

---

## 4. The 5 Lifecycle Artifacts

All tracking artifacts live inside the temporary `lifecycle/` directory at the project root:

1. **`00-status.md`:** The true status dashboard tracking all 6 phases and roadmap tasks.
2. **`01-requirements.md`:** Problem, outcome, existing code touchpoints, requirements, AC, rules, decisions, staged glossary terms, and Mermaid diagrams.
3. **`02-prototype.html` & `prototype/`:** Root launcher and modular component variants with inline styles for UI stress-testing.
4. **`03-roadmap.md`:** Priority-ordered vertical slices with Touchpoints, AC, Guidelines, and Human Verification.
5. **`04-refine.md`:** Continuous mistake, ambiguity, and process refinement log.

---

## 5. Human Approval Law & Autonomous Advance

- **The user owns approval; the agent owns execution.**
- When any phase or task completes its work and verification gates:
  1. Set its status in `00-status.md` to **`In Review`**.
  2. Present the concise review summary in chat.
  3. **STOP.** The agent is strictly forbidden from marking any step `Done` without user approval.
- **Autonomous Auto-Advance:** Once the user explicitly approves in chat:
  1. Mark the current phase/task **`Done`** (or **`Skipped`**) in `00-status.md`.
  2. Immediately inspect the next phase in the routing matrix.
  3. Load that next phase's `SKILL.md` and start it autonomously (the user never needs to type another slash command).
- **Feedback & Rejection Loop:** If the user requests changes during `In Review`:
  1. Set status back to **`In Progress`**.
  2. Address feedback, re-run self-verification gates, and return to **`In Review`**.

---

## 6. Smart Skip Protocol (`Skipped` Status)

- Never silently skip a phase.
- If a feature has **zero UI components** (e.g. backend API, database schema, CLI tool), the agent must proactively propose skipping `Prototype` inside the Brainstorm handoff question.
- When approved, mark `Prototype` as **`Skipped`** in `00-status.md`.
- Downstream entry gates treat `Skipped` as valid completion to proceed to `Roadmap`.

---

## 7. Requirement Change & Dirty Tree Protocol

If the user changes requirements or design decisions mid-stream:
1. Update `01-requirements.md` first.
2. Reset affected downstream phases/tasks in `00-status.md` back to `Todo` or `In Progress`.
3. **Dirty Tree Check:** Run read-only `git status` and `git diff`.
   - If uncommitted code from discarded tasks exists, list the affected files and ask the user to manually stash or discard them before writing new code.
   - Never overwrite dirty, conflicting uncommitted code.

---

## 8. Session Resumption & Crash Recovery

When `/lifecycle` is invoked in a fresh chat, after an IDE restart, or mid-feature:
1. Read `lifecycle/00-status.md` to identify the first `In Progress` (or latest `Todo`) step.
2. Run read-only `git status` and `git diff` to inspect current working state.
3. Present a 2-sentence summary in chat explaining where work left off.
4. Load the active phase's `SKILL.md` and resume directly from that checkpoint.

---

## 9. Inviolable Safety Boundaries

- **100% Manual Git Mutation Boundary:**
  - **Strictly Forbidden:** `git add`, `git commit`, `git reset`, `git restore`, `git checkout`, or any staging/unstaging. Staging, committing, and pushing are 100% manual by the user.
  - **Allowed & Encouraged:** Read-only inspection commands (`git status`, `git diff`, `git log`) for self-review and diff hygiene.
- **Long-Running Watchers & Codegen Ban:**
  - **Strictly Forbidden:** Running long-running watchers, daemonized codegen, or background compilers directly (e.g., `build_runner watch`, nodemon, dev servers). Instruct the user to run watchers in their terminal when needed.

---

## 10. Mistake & Friction Logging (`04-refine.md`)

Whenever an agent makes a mistake, encounters an ambiguous rule, or causes friction in **any** phase:
- Do not stop active work to rewrite global rules.
- Immediately append an entry to **`lifecycle/04-refine.md`**:
  ```markdown
  ### Refinement Entry: <Date/Phase>
  - **Phase/Task:** <Active Phase or Task ID>
  - **Problem:** <What went wrong or caused friction>
  - **Cause:** <Why it happened, if known>
  - **Solution:** <Concrete fix for rules or skill instructions>
  - **Target File Updated:** <Pending Finalize>
  ```
- Continue active work. Phase 7 (`Finalize`) will permanently apply these lessons to `.agents/rules/` and upstream skill improvements.

---

## 11. Targeted Sub-Agent Worker Delegation

To prevent context rot and maintain high reasoning precision across long sessions:
- **Main Agent (Orchestrator):** Conducts interactive user interviews (`Brainstorm`), handles roadmap review (`Roadmap`), and manages human approval gates.
- **Worker Sub-Agents (Fresh Context Isolation):**
  - *Brainstorm Research:* Spawns a fresh research sub-agent to inspect 10+ codebase files/docs, returning a concise summary.
  - *Execute Task:* Spawns a fresh worker sub-agent per roadmap task to write code and run tests, returning only a diff summary and test proof.
  - *Review Audit:* Spawns a fresh auditor sub-agent to scan the full-branch diff against rules with unbiased eyes.
