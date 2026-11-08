---
name: lifecycle
description: Master orchestrator and status router for the five-phase development lifecycle (Discover → Flows → Plan → Build → Finalize). Maintains lifecycle/00-status.md, enforces approval gates, and guarantees session resumption.
---

# Phase 0 — Lifecycle Orchestrator

## 1. Purpose

> **Core Mental Model:** Route through the phases. Load one skill at a time. Track everything in `00-status.md`. Advance only with explicit approval.

The Orchestrator manages the end-to-end development pipeline across the five phases: **Discover → Flows → Plan → Build → Finalize**.

It maintains a single source of truth for all progress at `lifecycle/00-status.md`, routes execution sequentially, enforces context hygiene by loading only the active phase's skill into the context window, and guarantees that no work advances without explicit human approval.

---

## 2. Guiding Principles & Global Guardrails

These rules apply universally across every phase of the lifecycle. Phase skills add detail; they never override these global guardrails:

- **Facts Belong to the Agent; Decisions Belong to the User:** Investigate discoverable facts from the codebase, tests, documentation, and logs independently. Ask the user when a decision requires their judgment, preferences, priorities, or business intent.
- **Silence Is Never Approval:** The Agent cannot declare its own work approved or assume consent from the absence of feedback. Explicit user approval is mandatory at every phase exit gate and after every individual task in Phase 4.
- **Non-Negotiable Git Safety Boundary:** The Agent is permitted to execute **read-only** Git commands (`git status`, `git diff`, `git log`). **NEVER** run mutating Git commands (`git commit`, `git push`, `git checkout`, `git reset`, `git restore`, `git branch`). All commits, pushes, and branch modifications belong exclusively to the user.
- **No Persistent Watchers or Daemons:** Never launch long-running watchers, daemon code generators, or persistent dev servers in background processes without explicit user direction.
- **Single Live Dashboard (`lifecycle/00-status.md`):** All phase progress, sub-stages, and Phase 4 implementation tasks are tracked strictly in `lifecycle/00-status.md`.
- **Cross-Phase Friction Logging (`lifecycle/refine.md`):** Never edit `.agents/skills/` or framework rules inside consumer projects. Instead, **any active phase (Phases 1–5)** can append entries to `lifecycle/refine.md` whenever workflow friction, prompt ambiguity, tool limitations, or repeatable defects occur. Phase 5 Finalize systematically reviews these entries at handover.
- **Context Hygiene:** Load **only** the active phase's skill file into context. Never load all skills simultaneously.
- **The Universal Treeing Principle:** Decompose complex systems hierarchically: Trunk (Core Purpose / Happy Path) $\to$ Branches (Capabilities / Seams) $\to$ Leaves (Edge Cases, Invariants, Rules).
- **Strict Phase Boundaries (Negative Constraints):**
  - **No Mutating Git Operations:** Never run `git commit`, `git push`, `git checkout`, `git reset`, or `git restore`. All Git state mutations belong to the user.
  - **No Phase Skipping:** Never advance to subsequent phases without explicit human approval in chat.
  - **No Multi-Skill Context Bloat:** Never load multiple phase skills into context simultaneously; unload prior skills and load only the active phase skill.
  - **No Direct Implementation in Phase 0:** The Orchestrator routes work; it never investigates requirements, designs flows, writes plans, or implements application code directly.

---

## 3. Responsibilities & Sequence

Phase 0 orchestrates work through four core execution steps:

### 3.1 Step 1 — Initialize Status Dashboard (Cold Start)

If `lifecycle/00-status.md` does not exist:
1. Create `lifecycle/00-status.md` using the standard structure in Section 5.
2. Initialize all phases to `Todo`.
3. Set `Phase 1 — Discover` to `In Progress`.
4. Load `lifecycle-discover` into context and begin discovery.

### 3.2 Step 2 — Route Work via Phase Routing Matrix

When starting a session or resuming work, read `lifecycle/00-status.md` first to determine the active phase and skill to load:

| Condition in `00-status.md` | Active Phase | Next Action | Skill to Load |
| :--- | :--- | :--- | :--- |
| `00-status.md` does not exist | **Cold Start** | Initialize `00-status.md`; start discovery | `lifecycle-discover` |
| `Phase 1 — Discover` is `Todo` / `In Progress` | **Discover** | Investigate problem, define target features, author `01-discover.md` | `lifecycle-discover` |
| `Phase 1 — Discover` is `In Review` | **Discover Gate** | Stop and wait for user approval | `lifecycle-discover` |
| `Phase 1` is `Done`; `Stage 2.1` is `Todo` / `In Progress` | **Flows (2.1)** | Model flows (side-by-side diff & Mermaid diagrams); author `02-flows.md` | `lifecycle-flows` |
| `Stage 2.1 — Flow Design` is `In Review` | **Flow Gate** | Stop and wait for user approval of flow diagrams | `lifecycle-flows` |
| `Stage 2.1` is `Done`; `Stage 2.2` is `Todo` / `In Progress` | **Prototype (2.2)** | Build modular interactive prototype in `02-prototype.html` (or mark `Skipped` if non-UI) | `lifecycle-flows` |
| `Stage 2.2 — Interactive Prototype` is `In Review` | **Prototype Gate** | Stop and wait for user prototype option selection and approval | `lifecycle-flows` |
| `Phase 2` is `Done` (or `Skipped`); `Phase 3` is `Todo` | **Plan** | Break down target features into verifiable tasks; populate `00-status.md` | `lifecycle-plan` |
| `Phase 3 — Plan` is `In Review` | **Plan Gate** | Stop and wait for user approval | `lifecycle-plan` |
| `Phase 3` is `Done`; any Phase 4 task is `Todo` / `In Progress` | **Build** | Implement active task strictly one at a time; verify tests & rules | `lifecycle-build` |
| Phase 4 task is `In Review` | **Task Gate** | Stop and wait for explicit human task approval | `lifecycle-build` |
| All Phase 4 tasks are `Done`; `Phase 5` is `Todo` | **Finalize** | Verify outcomes, review quality, assess improvements, sync docs | `lifecycle-finalize` |
| `Phase 5 — Finalize` is `In Review` | **Final Gate** | Stop and wait for final handover & cleanup decision | `lifecycle-finalize` |
| All phases are `Done` | **Complete** | Lifecycle finished; ready for user git commit | *(None)* |

### 3.3 Step 3 — Enforce Chat Approval Protocol (Human-First Gate)

Whenever any phase, sub-stage, or implementation task reaches an exit gate:
1. Update its status to `In Review` in `lifecycle/00-status.md`.
2. Stop calling tools immediately.
3. In chat, output a brief, high-signal 1–2 sentence summary linking the deliverable or artifact, include concrete testing steps (if in Phase 4 Build), and ask for explicit approval to advance.
4. **Never output robotic multi-section forms, boilerplate templates, or repeat context the user already knows.**
5. Wait for explicit user response:
   - **If Approved:** Mark item `Done` in `lifecycle/00-status.md`, load the next skill, and advance.
   - **If Changes Requested:** Mark item `In Progress`, address feedback, re-verify, and present again.
   - **If Blocked:** Mark item `Blocked`, resolve the blocker with the user before proceeding.

### 3.4 Step 4 — Mid-Flight Scope Realignment & Session Resumption

1. **Mid-Flight Scope Changes Across Any Phase:**
   When new requirements emerge, scope expands, or direction changes in ANY active phase:
   - *Pause Current Activity:* Stop coding or generating downstream artifacts immediately.
   - *Update Upstream Source of Truth in Place:* Realign `01-discover.md`, `02-flows.md`, or `03-plan.md` in place.
   - *Realign Dashboard:* Update `lifecycle/00-status.md` so active rows accurately reflect the revised plan.
   - *Working Tree Safety Check:* Run read-only `git status` to identify any uncommitted, discarded code so the user can stash or discard it.
2. **Session Resumption via Dashboard:**
   When resuming work after context compaction or a session break, inspect `lifecycle/00-status.md`. The active step is unambiguously indicated by the row marked `In Progress` or `In Review`.

---

## 4. Exit Gate & Completion Criteria

The overall development lifecycle is complete only when all five phase exit gates are satisfied and approved.

### Lifecycle Completion Checklist

Before declaring the lifecycle complete, verify that:
- **All Phases Approved:** All phases (`Discover`, `Flows`, `Plan`, `Build`, `Finalize`) are marked `Done` in `lifecycle/00-status.md`.
- **All Build Tasks Verified:** Every Phase 4 task in `lifecycle/03-plan.md` is marked `- [x]` with passing automated verification.
- **Permanent Docs Synchronized:** Updated documentation in `docs/modules/` accurately reflects the final implementation.
- **Domain Terms Promoted:** Core terms from `01-discover.md` are promoted to root `GLOSSARY.md`.
- **Upstream Friction Logged:** Entries in `lifecycle/refine.md` (if any) are reviewed for central skill improvements.
- **Artifact Cleanup Executed:** User's decision (Delete, Archive, or Keep `lifecycle/`) is executed.
- **Clean Working Tree:** Working tree is clean and ready for the user's manual Git commit.

### Gate Outcomes

- **Approved:** All phases marked `Done` in `lifecycle/00-status.md`. Lifecycle is complete.
- **Changes Requested:** Feedback returns the specific phase to `In Progress` in `lifecycle/00-status.md`.
- **Blocked:** Strategic unknown or blocker halts progress; active row is marked `Blocked` until resolved.

---

## 5. Phase Output

The primary deliverable of Phase 0 is the **Status Dashboard** maintained at `lifecycle/00-status.md`.

### Recommended Structure for `lifecycle/00-status.md`

```markdown
# Status: [Requirement / Feature Name]

| Phase | Task | Status |
| :--- | :--- | :--- |
| **Phase 1 — Discover** | Problem, Target Features & Scope ([01-discover.md](01-discover.md)) | `Todo` |
| **Phase 2 — Flows** | Stage 2.1 — Flow Design ([02-flows.md](02-flows.md)) | `Todo` |
| | Stage 2.2 — Interactive Prototype ([02-prototype.html](02-prototype.html)) | `Todo` |
| **Phase 3 — Plan** | Task Breakdown & Verification Matrix ([03-plan.md](03-plan.md)) | `Todo` |
| **Phase 4 — Build** | [Task 4.1: Database Schema & Migration](03-plan.md) | `Todo` |
| | [Task 4.2: Core Endpoint & Logic](03-plan.md) | `Todo` |
| | [Task 4.3: UI Screen & State](03-plan.md) | `Todo` |
| **Phase 5 — Finalize** | Quality Audit, Improvements & Handover ([05-finalize.md](05-finalize.md)) | `Todo` |

<!-- Status Values: Todo, In Progress, In Review, Blocked, Done, Skipped -->
```

---

### Recommended Structure for `lifecycle/refine.md` (Optional)

```markdown
# Refine: [Requirement / Feature Name]

Use this log to capture friction, prompt ambiguity, tool limitations, or rule improvements observed during development. Any active phase can append entries; Phase 5 Finalize reviews this file to propose upstream enhancements.

## Active Friction & Lessons Learned

### Entry 1: [Short Title]
- **Phase / Task:** [Phase or Task where friction occurred]
- **Classification:** One-off / Project-specific / Framework-wide
- **Observed Failure:** [What actually happened; not a guess]
- **Root Cause / Evidence:** [Why current code, rule, or workflow allowed it]
- **Preventive Change:** [Specific change to an artifact, rule, template, or skill]
- **Target:** [File path or upstream skill/rule]
- **Status:** Proposed / Applied / Verified / Deferred
```
