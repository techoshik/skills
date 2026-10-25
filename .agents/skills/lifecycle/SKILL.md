---
name: lifecycle
description: Master orchestrator and router for the 6-phase development lifecycle (Brainstorm → Prototype → Roadmap → Execute → Review → Finalize).
disable-model-invocation: true
---

# Lifecycle (Master Orchestrator)

The `lifecycle` skill is the master router for feature development. It drives work through a disciplined 6-phase sequential pipeline: **Brainstorm → Prototype → Roadmap → Execute → Review → Finalize**.

---

## 0. Core Mindset: Depth Over Speed & Atomic Readability

- **Never rush.** Speed comes from zero rework, not fast typing.
- **In Brainstorm:** Act as an elite researcher. Interrogate the root "why", map hidden 2nd-order ripple effects, and explore multiple solutions before writing specs.
- **In Engineering & Execute:** Always inspect full target files and immediate callers before proposing or writing code.
- **One Fact Per Line (No Paragraph Bullets):** Across all `lifecycle/` documents (`01-requirements.md`, `03-roadmap.md`, `04-refine.md`, `docs/modules/`), never write multi-sentence paragraphs inside a bullet point. Break every concept into short, nested sub-bullets (1 line = 1 atomic detail) so humans can skim instantly without losing any technical depth.
- **Zero-Duplication Chat Protocol:** Link directly to artifacts. Never dump full specifications or duplicate tables into chat. Keep chat responses concise and scannable, focusing on key decisions, verification proof, and approval questions.
- **Chat Formatting Invariants:** Never output markdown tables or raw Mermaid code blocks directly in chat responses (tables wrap awkwardly in narrow chat panels and Mermaid renders as raw plaintext syntax). Format comparisons and summaries as clean nested bullets in chat; keep tables and Mermaid diagrams strictly inside artifacts (`.md`, `.html`).

---

## 1. Status Dashboard (`lifecycle/00-status.md`)

All lifecycle progress and task statuses are tracked exclusively in **`lifecycle/00-status.md`**:
- Do **not** look for or invent status tables in other files.
- **Concise Task Slugs:** When replacing `Execute` with roadmap tasks, use concise, scannable task slugs (avoid long multi-word titles that force table columns to wrap in narrow panels).
- Table cells use 5 exact plain-text statuses:
  - `Todo`: Not started yet.
  - `In Progress`: Actively being worked on or self-reviewed by the agent.
  - `In Review`: Agent completed work and verification gates; **STOPPED for user review**.
  - `Done`: User explicitly approved in chat.
  - `Skipped`: Explicitly skipped with user approval (when neither UI prototypes nor flow diagrams are needed).

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

1. **`00-status.md`:** The status dashboard tracking all 6 phases and roadmap tasks.
2. **`01-requirements.md`:** Problem, outcome, existing code touchpoints, requirements, AC, business rules, decisions, staged glossary terms, and selected UI/UX specs.
3. **`02-prototype.html` & `prototype/`:** Root launcher, interactive 3-option UI carousels with inline styles, and Mermaid logic/flow diagrams.
4. **`03-roadmap.md`:** Priority-ordered vertical slices with Touchpoints, AC, Business Rules, Code Guidelines, and Human Verification.
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
- If a change requires **neither UI prototypes nor logic/state flow diagrams** (e.g. a minor backend tweak, config update, or simple copy change), proactively propose skipping `Prototype` inside the Brainstorm handoff question (while asking if the user still wants a flow diagram or prototype).
- When approved, mark `Prototype` as **`Skipped`** in `00-status.md`.
- Downstream entry gates treat `Skipped` as valid completion to proceed to `Roadmap`.

---

## 7. Requirement Change & Mid-Flight Insertion Protocol

If the user changes requirements, alters design decisions, or proposes an entirely new capability mid-stream (e.g. during Execute or Review):

### 1. Mid-Flight Interception (Never Jump Straight to Code)
- **Direct Coding Ban:** When a new requirement or feature is requested while tasks are in progress, the agent is **strictly forbidden from immediately modifying code**.
- **The Recency Bias Trap:** Agents must resist the urge to immediately write code for new requests. Any new requirement must be vetted through a micro-brainstorm to prevent uninspected edge cases and architectural drift.

### 2. Fast Micro-Brainstorm Sequence
1. **Acknowledge & Pause:** Acknowledge the user's request and state that it requires a fast, focused micro-brainstorm before execution.
2. **Context & Root Problem:** Quickly evaluate the root problem, operational need, and trade-offs of the proposed solution.
3. **Rapid 5-Lens Check:** Probe for failure modes, offline/error behavior, permission boundaries, concurrency/race conditions, and edge states.
4. **Spec Update (`01-requirements.md`):** Append the problem/outcome to Section 1, add `REQ-X`, `AC-X.Y`, and `BR-X` to Sections 3 and 4, and record trade-offs under Section 5 (Architectural Decisions).
5. **Roadmap & Overview Update (`03-roadmap.md`):** Append the new vertical slice task with full 6-part anatomy (Outcome, Touchpoints including tests, AC, Business Rules, Guidelines, Verification with Prerequisites), and update the task count and priority sequence in the Roadmap Overview.
6. **Status Dashboard Sync (`00-status.md`):** Insert `| Task N: <Short Slug> | Todo |` in its proper priority sequence.
7. **Human Approval Gate:** Present the concise micro-brainstorm summary in chat and **STOP** for user approval before writing any code.

### 3. Dirty Tree Check
- Run read-only `git status` and `git diff`.
- If uncommitted code from discarded or modified tasks exists, list the affected files and ask the user to manually stash or discard them before writing new code.
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
- Immediately append an entry to **`lifecycle/04-refine.md`** (initializing from [Refine Template](templates/04-refine.md) if not created yet):
  ```markdown
  ### Refinement Entry 1: <Short Issue Title>
  - **Phase / Task:** `<Active Phase or Task Name>`
  - **Problem:** <1-line description of what went wrong or caused friction>
  - **Cause:** <1-line root cause, e.g. missing rule, ambiguous instruction, framework quirk>
  - **Solution:** <1-line concrete rule or instruction update to prevent recurrence>
  - **Target File Updated:** `<Pending Finalize>`
  ```
- Continue active work. Phase 6 (`Finalize`) will permanently apply these lessons to `.agents/rules/` and upstream skill improvements.

---

## 11. Targeted Sub-Agent Worker Delegation

To prevent context rot and maintain high reasoning precision across long sessions:
- **Main Agent (Orchestrator):** Conducts interactive user interviews (`Brainstorm`), handles roadmap review (`Roadmap`), and manages human approval gates.
- **Worker Sub-Agents (Fresh Context Isolation):**
  - *Brainstorm Research:* Spawns a fresh research sub-agent to inspect 10+ codebase files/docs, returning a concise summary.
  - *Execute Task:* Spawns a fresh worker sub-agent per roadmap task to write code and run tests, returning only a diff summary and test proof.
  - *Review Audit:* Spawns a fresh auditor sub-agent to scan the full-branch diff against rules with unbiased eyes.
*(When running in environments without sub-agent delegation tools, execute directly in the main session while maintaining strict context discipline).*
