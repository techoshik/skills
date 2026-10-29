---
name: lifecycle
description: Master orchestrator for the six-phase development lifecycle (Brainstorm → Prototype → Roadmap → Execute → Review → Finalize).
---

# Lifecycle — Master Orchestrator

The orchestrator routes work through the existing six phases: **Brainstorm → Prototype → Roadmap → Execute → Review → Finalize**. Keep these phase names and their approval gates. Load the active phase skill rather than loading all phase skills at once.

## 0. Global Rules & Guardrails

These rules apply in every phase. Phase-specific skills add detail; they do not override these guardrails.

### Think carefully where it matters

Before a consequential decision or implementation, work through this sequence:

1. **Restate the outcome:** Identify the user's actual problem, desired result, scope, and constraints. Do not confuse the requested implementation with the underlying need.
2. **Gather evidence:** Inspect relevant code, tests, module docs, project rules, callers, and prior approved decisions before deciding. Use external research when the answer depends on current or specialist information.
3. **Consider credible options:** Include reuse or simplification of the existing system where relevant. Compare the options that could realistically work; do not invent alternatives just to fill a quota.
4. **Compare consequences:** Evaluate the dimensions that matter for this decision, such as user experience, correctness, permissions, data integrity, failure recovery, concurrency, migration, performance, maintainability, compatibility, scope, and reversibility.
5. **Stress-test the leading option:** Look for a counterexample, failure path, edge case, or downstream caller that could make the preferred solution wrong.
6. **Recommend or ask:** Recommend the best-supported option when the decision is within the agent's authority. Ask the user when a material user-owned decision remains unresolved.
7. **Record only useful reasoning:** Show the evidence, important trade-offs, key risks, recommendation, and unresolved decision in concise language. Do not output long internal monologues or claim certainty without evidence.

Apply depth proportionally. A small, reversible change does not need a formal alternatives report; a change involving money, permissions, personal or tenant data, destructive actions, migrations, concurrency, security, or architecture deserves stronger analysis.

### Research facts; do not assume user decisions

- **Investigate before asking:** Find facts that can be established from the codebase, tests, project rules, documentation, or reliable external sources yourself.
- **Ask before deciding material behavior:** Ask the user when plausible interpretations would change business behavior, UX expectations, authorization, data retention, financial results, migration/destructive behavior, compatibility promises, or significant scope/cost.
- **Do not hide assumptions:** For low-impact, reversible choices that follow established project conventions, proceed only when necessary, mark the assumption clearly in the relevant artifact, and explain it briefly at handoff.
- **Pause on unsafe uncertainty:** Do not implement a consequential assumption simply to keep moving. Present the specific unknown, why it matters, viable options with trade-offs, and your recommendation; ask one focused question at a time (or at most two tightly linked questions).
- **Respect approvals:** Approval of a phase or plan does not automatically approve a materially changed scope, a risky behavior change, or destructive cleanup.

### Make documents fast to comprehend without losing engineering depth

- Put a **quick read** first: problem, intended outcome, and scope or key decision.
- Present findings to the user in chat using short, plain, scannable bullets—never dump prose walls, markdown tables, or raw Mermaid syntax in chat.
- Across all `lifecycle/` and `docs/modules/` files, use scannable nested sub-bullets (`1 line = 1 atomic detail`) rather than multi-sentence prose paragraphs inside bullets.
- Make requirements, invariants, decisions, task outcomes, and acceptance criteria precise and independently understandable.
- Keep each fact's detailed authoritative version in one place. Summaries may point to it but should not reproduce it.
- Omit sections that are genuinely irrelevant or empty. Do not omit a relevant risk, requirement, dependency, edge case, or decision merely to make a document shorter.
- Prefer meaningful headings, descriptive labels, and examples only when they prevent ambiguity. Avoid boilerplate, repeated explanations, empty placeholder sections, and decorative process text.
- Every important claim should be identifiable as **verified fact, user decision, assumption, recommendation, or unresolved question** where that distinction matters.

### Source of truth for lifecycle artifacts

- `lifecycle/00-status.md`: authoritative phase/task status and compact resume checkpoint ([Status Template](templates/00-status.md)).
- `lifecycle/01-requirements.md`: authoritative user/system behavior, acceptance-criteria definitions, business rules, scope, and important decisions ([Requirements Template](templates/01-requirements.md)). Keep AC IDs stable; do not use it as an execution checklist.
- `lifecycle/02-prototype.html` and `lifecycle/prototype/`: visual exploration and chosen interaction reference when prototyping is appropriate ([Prototype Hub Template](templates/02-prototype.html)).
- `lifecycle/03-roadmap.md`: authoritative task breakdown, task-level verification checkboxes, dependencies, and execution plan ([Roadmap Template](templates/03-roadmap.md)).
- `lifecycle/04-refine.md`: process friction and verified lessons for possible rule/skill improvement ([Refine Template](templates/04-refine.md)).
- Permanent `docs/modules/` ([Module README Template](templates/module_readme.md), [Feature Template](templates/module_feature.md)) and `GLOSSARY.md`: final, reviewed project documentation after Review.

Do not duplicate execution checkboxes between `01-requirements.md` and `03-roadmap.md`. Keep requirements stable and track completion in the roadmap and status dashboard.

### Non-negotiable safety boundaries

- **Manual Git only:** Never run `git add`, `git commit`, `git push`, `git reset`, `git restore`, or `git checkout`. Read-only `git status`, `git diff`, and `git log` are allowed.
- **No long-running watchers or background code generation:** Do not launch watchers, persistent dev servers, or daemon code generators (e.g. `build_runner watch`). Ask the user to run these in their terminal when needed.
- **Preserve user work:** Never overwrite existing lifecycle work on resume. Inspect the working tree before cleanup or scope changes. Do not delete or discard user changes.
- **Follow the repository's actual rules:** Read applicable `.agents/rules/` files and existing patterns. If two rules conflict or a required rule file is missing, report the conflict/blocker instead of silently inventing a resolution.

---

## 1. Status Dashboard and Resume Checkpoint

Read `lifecycle/00-status.md` first when resuming or routing an existing lifecycle. Use concise, scannable task slugs (`Task 1: <Short Slug>`) so table columns never wrap. Status values are strictly: `Todo`, `In Progress`, `In Review`, `Done`, `Skipped`.

Keep a compact `Resume Checkpoint` in `00-status.md`, updated at task/phase boundaries and before handoff:

- **Current Phase / Task:** Active step in `00-status.md`.
- **Approved Outcome:** What is being completed and why.
- **Decisions & Constraints to Preserve:** Only those necessary to resume safely; link to the requirements/roadmap for detail.
- **Current State & Verification:** Files changed, what was verified, and actual command outcomes.
- **Open Blockers / Uncertainties:** State `None` when there is none; do not bury material uncertainty.
- **Next Action:** One concrete next step.

The checkpoint is a navigation aid, not another copy of the spec. Keep details in their authoritative artifacts.

## 2. Context Hygiene and Delegation

- Load only the active phase's `SKILL.md` in addition to the orchestrator and relevant artifacts/rules (never load all 7 skills at once).
- Use sub-agents only when supported and useful (for example, broad research across `10+` files in `Brainstorm`, one isolated coding task in `Execute`, or an independent audit in `Review`).
- Give every delegated worker a task packet containing: approved outcome, exact scope, relevant REQ/AC/BR IDs, applicable project rules, known decisions/assumptions, files/callers to inspect, required tests, and boundaries.
- The parent agent remains accountable. Review delegated diffs and evidence; do not accept “done” or “tests passed” without inspecting what changed and what actually ran.
- Keep interviews, consequential decisions, and approval handoffs in the main conversation.

## 3. Phase Routing Matrix

| Condition in `00-status.md` | Active Phase | Next Action | Skill to Load |
|---|---|---|---|
| `00-status.md` does not exist | Cold Start | Initialize status and requirements; begin discovery | [`lifecycle-brainstorm`](../lifecycle-brainstorm/SKILL.md) |
| `Brainstorm` is `Todo` or `In Progress` | Brainstorm | Investigate, clarify, and write the requirements | [`lifecycle-brainstorm`](../lifecycle-brainstorm/SKILL.md) |
| `Brainstorm` is `In Review` | Brainstorm | Stop and wait for approval | [`lifecycle-brainstorm`](../lifecycle-brainstorm/SKILL.md) |
| `Brainstorm` is `Done`; `Prototype` is `Todo` | Prototype | Assess whether a prototype is useful; prototype when warranted | [`lifecycle-prototype`](../lifecycle-prototype/SKILL.md) |
| `Prototype` is `In Review` | Prototype | Stop and wait for UX/flow sign-off | [`lifecycle-prototype`](../lifecycle-prototype/SKILL.md) |
| `Prototype` is `Done` or `Skipped`; `Roadmap` is `Todo` | Roadmap | Plan vertical tasks and verification | [`lifecycle-roadmap`](../lifecycle-roadmap/SKILL.md) |
| `Roadmap` is `In Review` | Roadmap | Stop and wait for plan approval | [`lifecycle-roadmap`](../lifecycle-roadmap/SKILL.md) |
| `Roadmap` is `Done`; any roadmap task is `Todo` or `In Progress` | Execute | Implement the active task only | [`lifecycle-execute`](../lifecycle-execute/SKILL.md) |
| Any roadmap task is `In Review` | Execute | Stop and wait for task verification/approval | [`lifecycle-execute`](../lifecycle-execute/SKILL.md) |
| All roadmap tasks are `Done`; `Review` is `Todo` or `In Progress` | Review | Audit integrated implementation | [`lifecycle-review`](../lifecycle-review/SKILL.md) |
| `Review` is `In Review` | Review | Stop and wait for audit sign-off | [`lifecycle-review`](../lifecycle-review/SKILL.md) |
| `Review` is `Done`; `Finalize` is `Todo` or `In Progress` | Finalize | Sync final docs, process lessons, prepare handoff | [`lifecycle-finalize`](../lifecycle-finalize/SKILL.md) |
| `Finalize` is `In Review` | Finalize | Stop and wait for handoff/cleanup decision | [`lifecycle-finalize`](../lifecycle-finalize/SKILL.md) |

## 4. Phase Approval and Advancement

- The agent owns research, implementation, and evidence. The user owns approval and material product/business decisions.
- At a phase/task approval gate, set status to `In Review`, summarize the outcome, important evidence, open risks (if any), and the requested decision; then stop.
- After explicit approval, set the status to `Done` (or `Skipped` if explicitly accepted), load the next phase's `SKILL.md`, and auto-advance immediately.
- If the user requests changes, set the item to `In Progress`, update the authoritative artifacts in place, verify the revision, and return it to `In Review`.
- Do not ask for approval again on unchanged decisions already explicitly approved. Do ask when new evidence materially changes the decision or scope.

## 5. Smart Prototype Assessment

- Anytime a feature adds, rearranges, or consolidates user-facing screens, navigation, cards, forms, tabs, or multi-step flows—even when reusing existing UI widgets—run `Prototype` so the user can visually verify and simplify the UX before coding starts.
- For tiny, reversible UI changes that clearly follow an approved existing pattern, the agent may recommend `Prototype: Skipped` with a one-line reason.
- Pure backend/model/config work may also skip Prototype when no visual decision or user-flow diagram would reduce risk.
- The user can override the recommendation. Never skip a phase solely to save time when uncertainty about the UX is material.

## 6. Mid-Flight Requirement or UX Change

When the user changes scope or a better solution is discovered during Prototype, Roadmap, Execute, or Review:

1. **Pause & Micro-Brainstorm:** Pause implementation of the affected work. Clarify the underlying goal, inspect consequences and callers, compare plausible options, and ask about any material unresolved decision.
2. **Update `01-requirements.md` In Place:** Replace superseded statements in place so `01-requirements.md` expresses one coherent current truth; preserve stable IDs where behavior remains the same and retire superseded requirements clearly.
3. **Update `03-roadmap.md` & `00-status.md` (No Unstructured Amendment Footers):** Never dump new scope into an untracked footer at the bottom of `03-roadmap.md`. If an earlier task was superseded, mark its replaced lines as `~(Superseded by Task N)~` (or collapse a fully superseded task heading to `## Task X: <Name> — ~(Superseded by Task N)~`) and add a proper numbered `Task N: <Short Slug>` using the canonical five-part task anatomy in `03-roadmap.md` and a matching row in `00-status.md`.
4. **Dirty Tree Check:** Inspect read-only `git status` and `git diff`. If uncommitted code from a discarded approach conflicts with the new direction, list the affected files and ask the user to stash or discard them manually before writing new code.
5. **Confirm & Resume:** Summarize the change and revised plan concisely in chat and stop for user approval before implementing newly scoped work.

## 7. Session Resumption and Crash Recovery

1. Read `00-status.md` and its Resume Checkpoint.
2. Inspect read-only `git status --short` and `git diff` before changing files.
3. Re-read the active task, its acceptance criteria, the relevant requirements/business rules, and applicable `.agents/rules/` files.
4. Summarize in two short sentences what is complete and what remains; correct the checkpoint if stale.
5. Resume the active phase without repeating completed work, and without treating an assumption as an approved decision.

## 8. Process Refinement (`04-refine.md`)

Whenever a meaningful mistake, recurring ambiguity, rule conflict, or avoidable rework occurs in any phase, immediately append an entry to `lifecycle/04-refine.md` (initializing from [Refine Template](templates/04-refine.md) if needed). Avoid promoting every one-off mistake into a permanent rule. During Finalize, classify each lesson, apply only generalizable improvements, and record whether the change was actually verified.
