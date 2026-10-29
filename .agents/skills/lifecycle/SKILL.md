---
name: lifecycle
description: Master orchestrator and router for the 6-phase development lifecycle (Brainstorm → Prototype → Roadmap → Execute → Review → Finalize).
---

# Lifecycle (Master Orchestrator)

The `lifecycle` skill is the master router for product and feature development. It drives work through a disciplined 6-phase sequential pipeline: **Brainstorm → Prototype → Roadmap → Execute → Review → Finalize**.

---

## 0. Core Working Principles (Global Rules for All Phases)

- **Deep Work for Agents, Simple Presentation for Humans:**
  - Do the heavy lifting (tracing end-to-end user flows, questioning UX duplication, checking callers and rules) autonomously so the user doesn't have to catch gaps mid-coding.
  - Present findings to the user in short, plain, scannable bullets—never dump walls of text, markdown tables, or raw Mermaid syntax in chat.
- **One Fact Per Line in Artifacts:**
  - Across all `lifecycle/` and `docs/modules/` files, never write multi-sentence paragraphs inside a bullet. Break every topic into nested sub-bullets (`1 line = 1 atomic detail`) without redundant bold labels on child lines.
- **Single-Truth Synchronization (Zero Contradictions):**
  - `01-requirements.md`, `03-roadmap.md`, and `00-status.md` must stay 100% synchronized. Whenever a decision or UX flow changes, **replace superseded lines in place** rather than appending conflicting notes at the bottom.
- **Inviolable Safety Boundaries:**
  - **100% Manual Git:** Never run `git add`, `git commit`, `git reset`, `git restore`, or `git checkout`. Read-only `git status`, `git diff`, and `git log` are encouraged.
  - **No Watchers / Daemon Codegen:** Never run long-running watchers or background compilers (e.g. `build_runner watch`, dev servers). Ask the user to run watchers in their terminal when needed.

---

## 1. Status Dashboard (`lifecycle/00-status.md`)

All lifecycle progress and task statuses are tracked exclusively in **`lifecycle/00-status.md`**:
- Features direct links to active artifacts (`01-requirements.md`, `02-prototype.html`, `03-roadmap.md`) at the top for one-click navigation.
- Use concise, scannable task slugs (`Task 1: <Short Slug>`) so table columns never wrap.
- Table cells strictly use 5 plain-text statuses: `Todo`, `In Progress`, `In Review`, `Done`, `Skipped`.

---

## 2. Context Hygiene & Sub-Agent Delegation

- **Single-Skill Loading:** Check `lifecycle/00-status.md` first and load **only** the active phase's `SKILL.md` (never load all 7 skills at once).
- **Worker Sub-Agent Delegation:** Keep interviews, roadmap alignment, and approval handoffs in the main chat. When sub-agent tools are available, delegate heavy research (`10+` files in `Brainstorm`), single-task coding/testing (`Execute`), and full-branch auditing (`Review`) to fresh worker sub-agents.

---

## 3. Phase Routing Matrix

| Condition in `00-status.md` | Active Phase | Next Action | Skill to Load |
| :--- | :--- | :--- | :--- |
| `00-status.md` does not exist | **Cold Start** | Initialize `00-status.md` & brainstorm | [`lifecycle-brainstorm`](../lifecycle-brainstorm/SKILL.md) |
| `Brainstorm` is `Todo` or `In Progress` | **Brainstorm** | Research, critique UX flow, interview, write spec | [`lifecycle-brainstorm`](../lifecycle-brainstorm/SKILL.md) |
| `Brainstorm` is `In Review` | **Brainstorm** | **STOP**; wait for user approval | [`lifecycle-brainstorm`](../lifecycle-brainstorm/SKILL.md) |
| `Brainstorm` is `Done`; `Prototype` is `Todo` | **Prototype** | Build UI carousels & flow diagrams | [`lifecycle-prototype`](../lifecycle-prototype/SKILL.md) |
| `Prototype` is `In Review` | **Prototype** | **STOP**; wait for user variant/flow sign-off | [`lifecycle-prototype`](../lifecycle-prototype/SKILL.md) |
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

1. **`00-status.md`:** Status dashboard tracking all 6 phases and roadmap tasks with direct links to feature specs and prototypes.
2. **`01-requirements.md`:** Progressive-disclosure specification placing Problem, User Flow, and Experience Delta upfront, followed directly by visible Requirements/AC, Business Rules, UI Specs, and Code Touchpoints.
3. **`02-prototype.html` & `prototype/`:** Single-page launcher containing interactive 3-option UI carousels and Mermaid flow diagrams.
4. **`03-roadmap.md`:** Priority-ordered vertical slices preceded by a scannable Roadmap Overview, with Touchpoints, AC, Business Rules, and Human Verification.
5. **`04-refine.md`:** Continuous mistake, ambiguity, and process refinement log.

---

## 5. Human Approval Law & Autonomous Advance

- **The user owns approval; the agent owns execution.**
- When any phase or task completes its work and verification gates:
  1. Set its status in `00-status.md` to **`In Review`**.
  2. Present a concise review summary in chat and **STOP**.
- **Autonomous Auto-Advance:** Once the user approves in chat, mark the step **`Done`** (or **`Skipped`**) in `00-status.md`, load the next phase's `SKILL.md`, and start it immediately.
- **Feedback & Rejection Loop:** If the user requests changes during `In Review`, set status back to **`In Progress`**, address feedback, re-verify, and return to **`In Review`**.

---

## 6. Smart Skip Protocol (`Skipped` Status)

- **Never Skip `Prototype` When Modifying User-Facing Screens or Flows:** Anytime a feature adds, rearranges, or consolidates screens, cards, forms, tabs, or user flows—even when reusing existing UI widgets—run `Prototype` so the user can see and simplify the UX before coding starts.
- Only propose marking `Prototype` as **`Skipped`** when the task is strictly non-visual (e.g. pure backend, model/schema, or config change) and requires neither UI options nor flow diagrams.

---

## 7. Mid-Flight UX Improvement & Requirement Change Protocol

When the user spots a better UX flow, changes a requirement, or adds scope mid-stream (during `Prototype`, `Roadmap`, `Execute`, or `Review`):

1. **Pause & Micro-Brainstorm (Never Jump Straight to Code):**
   - Do **not** immediately write code. Quickly evaluate the root UX/technical goal, ripple effects, and edge cases with the user.
2. **Update `01-requirements.md` In Place (Single Coherent Truth):**
   - **Replace or remove superseded requirements, outcomes, and UI specs in place** so `01-requirements.md` never contradicts itself.
   - Add any new `REQ-X`, `AC-X.Y`, `BR-X`, and `Decision` items.
3. **Update `03-roadmap.md` & `00-status.md` (No Unstructured Amendment Footers):**
   - Never dump new scope into an untracked footer at the bottom of `03-roadmap.md`.
   - If an earlier task was superseded, mark its replaced lines as `~(Superseded by Task N)~` and add a proper numbered **`Task N: <Short Slug>`** with full 6-part anatomy to `03-roadmap.md` and `00-status.md`.
4. **Dirty Tree Check:**
   - Run read-only `git status` and `git diff`. If uncommitted code from a discarded approach conflicts with the new direction, list the affected files and ask the user to stash/discard them manually before writing new code.
5. **Confirm & Resume:** Present the updated plan concisely in chat and **STOP** for user approval before executing the new/updated task.

---

## 8. Session Resumption & Crash Recovery

When `/lifecycle` is invoked in a fresh chat or after an IDE restart:
1. Read `lifecycle/00-status.md` to locate the active step (`In Progress` or first `Todo`).
2. Run read-only `git status` and `git diff`, summarize where work left off in 2 sentences, load the active phase's `SKILL.md`, and resume.

---

## 9. Mistake & Friction Logging (`04-refine.md`)

Whenever an agent makes a mistake, encounters an ambiguous rule, or causes rework in **any** phase:
- Immediately append an entry to **`lifecycle/04-refine.md`** (initializing from [Refine Template](templates/04-refine.md) if needed) with `Phase / Task`, `Problem`, `Cause`, `Solution`, and `Target File Updated`.
- Phase 6 (`Finalize`) converts these lessons into permanent `.agents/rules/` and upstream skill improvements.
