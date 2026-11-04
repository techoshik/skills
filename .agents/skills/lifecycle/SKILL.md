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
- **Silence Is Never Approval:** The Agent cannot declare its own work approved or assume consent from the absence of feedback. Explicit user approval is mandatory at every phase exit gate (and at every task/feature gate in Phase 4).
- **Non-Negotiable Git Safety Boundary:** The Agent is permitted to execute **read-only** Git commands (`git status`, `git diff`, `git log`). **NEVER** run mutating Git commands (`git commit`, `git push`, `git checkout`, `git reset`, `git restore`, `git branch`). All commits, pushes, and branch modifications belong exclusively to the user.
- **No Persistent Watchers or Daemons:** Never launch long-running watchers, daemon code generators, or persistent dev servers in background processes without explicit user direction.
- **Single Live Dashboard (`lifecycle/00-status.md`):** All phase progress, sub-stages, and Phase 4 implementation tasks are tracked strictly in `lifecycle/00-status.md`. The legacy `05-traceability.md` file is retired.
- **Cross-Phase Friction Logging (`lifecycle/04-refine.md`):** Never edit `.agents/skills/` or framework rules inside consumer projects. Instead, **any active phase (Phases 1–5)** can append entries to `lifecycle/04-refine.md` whenever workflow friction, prompt ambiguity, tool limitations, or repeatable defects occur. Phase 5 Finalize systematically reviews these entries at handover.
- **Mid-Flight Scope Changes:** If requirements change mid-flight, update the upstream specification in place (`lifecycle/01-discover.md`, `lifecycle/02-flows.md`, or `lifecycle/03-plan.md`), inspect `git status` for discarded code, and realign `lifecycle/00-status.md` before writing new code.
- **Context Hygiene:** Load **only** the active phase's skill file into context. Never load all skills simultaneously.
- **The Universal Treeing Principle:** Decompose complex systems hierarchically: Trunk (Core Purpose / Happy Path) $\to$ Branches (Capabilities / Seams) $\to$ Leaves (Edge Cases, Invariants, Rules). In planning, tree tasks (Steel Thread $\to$ Feature Slices $\to$ Edge Hardening). In bug triage, tree root causes (Symptom $\to$ System Seams $\to$ Root Cause Line). In documentation, tree knowledge (Module $\to$ Features $\to$ Business Invariants).

---

## 3. Responsibilities & Sequence

### 3.1 Initialize the Status Dashboard (Cold Start)

If `lifecycle/00-status.md` does not exist:
1. Create `lifecycle/00-status.md` using the standard structure in Section 7.
2. Initialize all phases to `Todo`.
3. Set `Phase 1 — Discover` to `In Progress`.
4. Load `lifecycle-discover` into context and begin discovery.

### 3.2 Route Work via the Phase Routing Matrix

When starting a session or resuming work, read `lifecycle/00-status.md` first to determine the active phase and skill to load:

| Condition in `00-status.md` | Active Phase | Next Action | Skill to Load |
| :--- | :--- | :--- | :--- |
| `00-status.md` does not exist | **Cold Start** | Initialize `00-status.md`; start discovery | `lifecycle-discover` |
| `Phase 1 — Discover` is `Todo` / `In Progress` | **Discover** | Investigate problem, define target features, author `01-discover.md` | `lifecycle-discover` |
| `Phase 1 — Discover` is `In Review` | **Discover Gate** | Stop and wait for user approval | `lifecycle-discover` |
| `Phase 1` is `Done`; `Phase 2` is `Todo` / `In Progress` | **Flows** | Model flows (side-by-side diff) & modular prototype (if UI) | `lifecycle-flows` |
| `Phase 2 — Flows` is `In Review` | **Flows Gate** | Stop and wait for user approval | `lifecycle-flows` |
| `Phase 2` is `Done` (or `Skipped`); `Phase 3` is `Todo` | **Plan** | Break down target features into verifiable tasks; populate `00-status.md` | `lifecycle-plan` |
| `Phase 3 — Plan` is `In Review` | **Plan Gate** | Stop and wait for user approval | `lifecycle-plan` |
| `Phase 3` is `Done`; any Phase 4 task is `Todo` / `In Progress` | **Build** | Implement active task or feature; verify tests & rules | `lifecycle-build` |
| Phase 4 task/feature is `In Review` | **Build Gate** | Stop and wait for task or feature approval | `lifecycle-build` |
| All Phase 4 tasks are `Done`; `Phase 5` is `Todo` | **Finalize** | Verify outcomes, review quality, assess improvements, sync docs | `lifecycle-finalize` |
| `Phase 5 — Finalize` is `In Review` | **Final Gate** | Stop and wait for final handover & cleanup decision | `lifecycle-finalize` |
| All phases are `Done` | **Complete** | Lifecycle finished; ready for user git commit | *(None)* |

### 3.3 Enforce the Chat Approval Protocol (Human-First)

Whenever any phase, sub-stage, or implementation task reaches an exit gate:
1. Update its status to `In Review` in `lifecycle/00-status.md`.
2. Stop calling tools immediately.
3. In chat, output a brief, high-signal 1–2 sentence summary linking the deliverable or artifact, include concrete testing steps (if in Phase 4 Build), and ask for explicit approval to advance.
4. **Never output robotic multi-section forms, boilerplate templates, or repeat context the user already knows.**
5. Wait for explicit user response:
   - **If Approved:** Mark item `Done` in `lifecycle/00-status.md`, load the next skill, and advance.
   - **If Changes Requested:** Mark item `In Progress`, address feedback, re-verify, and present again.
   - **If Blocked:** Mark item `Blocked`, resolve the blocker with the user before proceeding.

### 3.4 Handle Mid-Flight Scope Changes Across Any Phase

When new requirements emerge, scope expands, or direction changes in ANY active phase:
1. **Pause Current Activity:** Stop coding or generating downstream artifacts immediately.
2. **Update Upstream Source of Truth in Place:**
   - If the change affects core problem, goal, or capabilities: Update `lifecycle/01-discover.md` (`## 3. Target Features`) in place.
   - If the change affects UX or screen journeys: Update `lifecycle/02-flows.md` in place.
   - If the change affects implementation tasks: Update `lifecycle/03-plan.md` in place.
   - Realign `lifecycle/00-status.md` so active rows accurately reflect the revised plan.
3. **Working Tree Safety Check:** Run read-only `git status` to identify any uncommitted, discarded code so the user can stash or discard it before new work begins.
4. **Resume:** Present a 1-sentence summary of the realignment and continue.

### 3.5 Manage Session Resumption via Dashboard Status

When resuming work after context compaction or a session break, the Agent simply inspects the status table in `lifecycle/00-status.md`. The active step is unambiguously indicated by the row marked `In Progress` or `In Review`, eliminating the need for duplicate prose notes.

---

## 4. Completion Criteria

The overall development lifecycle is considered complete only when:

- All five phases (`Discover`, `Flows`, `Plan`, `Build`, `Finalize`) are marked `Done` in `lifecycle/00-status.md`.
- All Phase 4 implementation tasks are verified and marked `Done`.
- Permanent documentation in `docs/modules/` is updated and verified.
- Upstream friction and lessons (if any) are recorded in `lifecycle/04-refine.md`.
- The user has executed the Phase 5 Artifact Cleanup Decision (Delete, Archive, or Keep `lifecycle/`).
- The working tree is clean and ready for the user's manual Git commit.

---

## 5. Exit Gate

The Orchestrator marks the entire lifecycle complete only when all five phase exit gates have been approved and the Phase 5 handover is accepted.

### Exit Gate Outcomes

- **Approved:** All phases are `Done`, permanent docs are synchronized, and the cleanup choice is executed. Lifecycle is officially complete.
- **Changes Requested:** Feedback on any deliverable returns that specific phase to `In Progress` in `lifecycle/00-status.md`.
- **Blocked:** If a critical dependency, architecture question, or user decision blocks progress, the active phase is marked `Blocked` in `lifecycle/00-status.md` until resolved.

---

## 6. Phase Boundary

This section defines the responsibilities and strict boundaries of Phase 0.

### 6.1 What Belongs to Phase 0 (Orchestrator)

- Initializing and maintaining `lifecycle/00-status.md`.
- Reading `00-status.md` and routing work to the active phase skill.
- Enforcing context hygiene (loading only one phase skill at a time).
- Enforcing exit gates, gate transitions, and the chat approval protocol.
- Guaranteeing that no code or decisions advance without explicit user approval.

### 6.2 What Does NOT Belong to Phase 0

- Investigating requirements or defining target features (belongs to Phase 1 — Discover).
- Designing visual flows or creating HTML prototypes (belongs to Phase 2 — Flows).
- Defining technical architectures or writing task breakdowns (belongs to Phase 3 — Plan).
- Writing production code or running unit tests (belongs to Phase 4 — Build).
- Performing code audits, documenting modules, or executing cleanups (belongs to Phase 5 — Finalize).

---

## 7. Phase Output

The primary deliverable of Phase 0 is the **Status Dashboard** maintained at `lifecycle/00-status.md`.

### Lifecycle Artifact Architecture

All temporary development artifacts live in `lifecycle/` using crisp 1-word headings:

| Phase | Live Artifact | Format & Key Contents | Owning Skill |
| :--- | :--- | :--- | :--- |
| **Phase 0** | `lifecycle/00-status.md`<br>`lifecycle/04-refine.md` | 3-column live dashboard (`Phase`, `Stage / Task`, `Status`)<br>Cross-phase friction log (any phase appends; Phase 5 reviews) | `lifecycle` |
| **Phase 1** | `lifecycle/01-discover.md` | Desired Goal, Target Features (`### <Name>`), Scope Boundaries, Decisions | `lifecycle-discover` |
| **Phase 2** | `lifecycle/02-flows.md`<br>+ `02-prototype.html` | Visual diffs & sequences (Mermaid), Prototype Hub & Modular Variants (`prototype/`) | `lifecycle-flows` |
| **Phase 3** | `lifecycle/03-plan.md` | Feature tasks, assigned Rule Files, Two-Tier Verification (`Setup`, `Action`, `Expected`) | `lifecycle-plan` |
| **Phase 4** | *(None)* | Implements code, executes Agent Verification, marks checkboxes (`- [x]`) in `03-plan.md` | `lifecycle-build` |
| **Phase 5** | `docs/modules/<module>/` | Permanent architectural docs sync; PR summary (chat); reviews `04-refine.md` | `lifecycle-finalize` |

---

### Recommended Structure for `lifecycle/00-status.md`

```markdown
# Status: [Requirement / Feature Name]

- **Execution Mode:** [Task Mode / Feature Mode] (selected during Phase 3)

| Phase | Stage / Task | Status |
| :--- | :--- | :--- |
| **Phase 1 — Discover** | 1.1 Problem & Target Features ([01-discover.md](lifecycle/01-discover.md)) | `Todo` |
| **Phase 2 — Flows** | 2.1 Flow Design ([02-flows.md](lifecycle/02-flows.md)) | `Todo` |
| | 2.2 Interactive Prototype ([02-prototype.html](lifecycle/02-prototype.html)) | `Todo` |
| **Phase 3 — Plan** | 3.1 Technical Approach & Task Breakdown ([03-plan.md](lifecycle/03-plan.md)) | `Todo` |
| **Phase 4 — Build** | *(Populated directly by Phase 3 Plan)* | |
| | Task 4.1: [Task 1 Title] | `Todo` |
| | Task 4.2: [Task 2 Title] | `Todo` |
| | Task 4.3: [Task 3 Title] | `Todo` |
| **Phase 5 — Finalize** | 5.1 Outcome & Quality Verification | `Todo` |
| | 5.2 Application Improvements | `Todo` |
| | 5.3 Documentation & PR Summary | `Todo` |

<!-- Status Values: Todo, In Progress, In Review, Blocked, Done, Skipped -->
```

---

### Recommended Structure for `lifecycle/04-refine.md` (Optional)

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
