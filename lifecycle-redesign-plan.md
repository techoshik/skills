# Lifecycle Skills Redesign Plan

> **Working Principle:** Discuss one phase at a time, evaluate whether each point is genuinely needed (or belongs in a different phase / should be dropped to avoid creating problems), ask **1 question at a time (max 2)** with a clear recommendation, and update finalized points here only after agreed.
> **Writing Standard (For Skills & Generated Docs):** Every sentence must be **short, crisp, and instantly skimmable for humans**, yet **100% explicit and complete for agents** (no prose walls, no vague filler).
> **Core Mindset (Depth Over Speed in Brainstorm & Engineering):** Never rush. In Brainstorm, act as an elite researcher who uncovers the root "why", maps ripple effects, and stress-tests edge cases before writing specs. In Execute, always read full files and inspect immediate callers before editing.

---

## 0. High-Level Architecture Shift (Old DOER vs. New 7-Skill Flow)

| Old DOER Skill (To Delete) | New Skill | Why Better for Humans & Agents |
| :--- | :--- | :--- |
| [`lifecycle`](.agents/skills/lifecycle/SKILL.md) | **Lifecycle** (`/lifecycle`) | Tracks progress in `00-status.md` from the very start of Brainstorm. |
| [`lifecycle-define`](.agents/skills/lifecycle-define/SKILL.md) | **Lifecycle Brainstorm** (`/lifecycle-brainstorm`) + **Lifecycle Prototype** (`/lifecycle-prototype`) | Clarifies requirements *before* building prototypes; uses prototypes to catch visual/flow gaps and sync them back into `01-requirements.md`. |
| [`lifecycle-outline`](.agents/skills/lifecycle-outline/SKILL.md) | **Lifecycle Roadmap** (`/lifecycle-roadmap`) | Priority-ordered, small vertical tasks with Outcome, Touchpoints, Acceptance Criteria, Rules, Guidelines, and Verification. |
| [`lifecycle-execute`](.agents/skills/lifecycle-execute/SKILL.md) | **Lifecycle Execute** (`/lifecycle-execute`) | Executes one task at a time and verifies Outcome, Acceptance Criteria, Business Rules, Code Guidelines, and Linter/Tests. |
| [`lifecycle-refine`](.agents/skills/lifecycle-refine/SKILL.md) | **Lifecycle Review** (`/lifecycle-review`) + **Lifecycle Finalize** (`/lifecycle-finalize`) | Separates full-branch audit & deduplication (**Review**) from docs, rule updates, PR summary, and cleanup (**Finalize**). |

---

## 1. Phase 1: Lifecycle (Master Orchestrator — `/lifecycle`) — ✅ FINALIZED

1. **Sequential Pipeline & Entry Gates:**
   - Route strictly: `Brainstorm` → `Prototype` → `Roadmap` → `Execute` → `Review` → `Finalize`.
   - **Cold Start:** If `lifecycle/00-status.md` is missing, route immediately to `Lifecycle Brainstorm`.
   - **Entry Gate:** Next phase starts only when the previous phase in `00-status.md` is `Done` or `Skipped`.
2. **Single-Skill Context Hygiene:**
   - Read `00-status.md` first and load **only** the active phase's `SKILL.md` (never load all 7 skills at once).
3. **User Handoff, Approval & Auto-Advance:**
   - Set completed step to `In Review` in `00-status.md` and **STOP**.
   - Only user approval marks a step `Done` or `Skipped`.
   - **Auto-Advance:** On approval, mark `Done`, load the next phase's `SKILL.md`, and start it immediately.
   - **Rejection Loop:** On user change requests, set status back to `In Progress`, fix, re-verify, and return to `In Review`.
4. **Mistake & Friction Logging (`04-refine.md`):**
   - Log any mistake, ambiguity, or rule gap immediately in `04-refine.md` (`Phase/Task`, `Problem`, `Cause`, `Solution`) without stopping active work.
5. **Smart Skip Confirmation (`Skipped` Status):**
   - Never skip a phase silently. Propose skipping in the handoff question when appropriate (e.g., no UI → propose skipping `Prototype`).
6. **Requirement Change & Dirty Tree Protocol:**
   - If requirements change mid-stream, update `01-requirements.md` first and reset affected downstream steps in `00-status.md` to `Todo` or `In Progress`.
   - **Dirty Tree Check:** Run read-only `git status`/`git diff`; if uncommitted code conflicts with a rollback, ask the user to stash/discard it manually.
7. **Targeted Sub-Agent Worker Delegation:**
   - Keep user interviews, roadmap planning, and handoffs in the **main chat**.
   - Delegate heavy work to **fresh sub-agents**:
     1. Codebase/doc research (`10+` files) in `Brainstorm`.
     2. Single task implementation + test runs in `Execute`.
     3. Full-branch static audit and deduplication scan in `Review`.
8. **100% Manual Git Mutation Boundary:**
   - Never run `git add`, `git commit`, `git reset`, `git restore`, or `git checkout`.
   - Read-only `git status`, `git diff`, and `git log` are allowed and encouraged.
9. **Watchers & Codegen Ban:**
   - Never run long-running watchers or codegen (e.g., `build_runner`). Ask the user to run watchers in their terminal.
10. **Session Resumption & Crash Recovery:**
    - On fresh start or restart, read `00-status.md` + run `git status`/`git diff`, summarize state in 2 sentences, and resume the active step.
11. **Skimmable & Complete Document Standard:**
    - Write all `lifecycle/` artifacts (`00`–`04`) using short, scannable bullets and tables—zero walls of text for humans, zero missing technical specifics for agents.

---

## 2. Phase 2: Lifecycle Brainstorm (`/lifecycle-brainstorm`) — ✅ FINALIZED

1. **Initialize or Resume (`00-status.md` & `01-requirements.md`):**
   - Resume existing files if present; otherwise create both with `Brainstorm` set to `In Progress`.
2. **Research First & Save Touchpoints (`01-requirements.md`):**
   - Inspect codebase, `.agents/rules/`, `docs/modules/`, and `GLOSSARY.md` first (use a worker sub-agent for `10+` files).
   - Save discovered models, shared widgets, utilities, and rules under `Existing Code & Reuse Touchpoints` in `01-requirements.md`.
   - Run targeted web search when external APIs or industry UX patterns help, presenting findings as **options/recommendations**.
3. **Elite Researcher Interview Loop (1 Question Preferred, Max 2):**
   - **Act as a Principal Product & Technical Researcher:** Never accept surface requests at face value. Probe the root "why", map hidden 2nd-order ripple effects (what breaks, leaks, or changes across data, state, security, and upstream/downstream callers), and explore 2–3 divergent solutions with trade-offs.
   - Ask dependency-ordered questions **1 at a time (max 2)** with: **Brief Context** (1–2 lines) + **2–3 Options** + **`➡️ Recommendation`** (helping the user synthesize, mix, or merge the best parts).
   - **Live Update Rule:** Update `01-requirements.md` after **every single user answer** (moving items from `Open questions` / `Open research` into `Requirements`, `Rules`, or `Decisions`).
4. **Proactive 5-Lens Gap Hunting (Turning Vague Ideas into Concrete Specs):**
   - **New Features (5 Lenses):** Systematically interrogate `Empty`, `Error/Offline`, `Permissions/Tenancy`, `Concurrency/Idempotency`, and `Data Lifecycle` (including schema/migration impact).
   - **Bug Fixes / Refactors (Root-Cause Lens):** Trace code root cause first and define `Current (Broken) vs. Expected (Fixed) Behavior`, `Blast Radius`, and `Regression Guardrail`.
5. **Stage Domain Terms (`Glossary Updates`):**
   - Challenge vague terms and stage new/updated domain definitions in `01-requirements.md` under `Glossary Updates` (sync to `GLOSSARY.md` in `Finalize`).
6. **Partition Scope (Build Now vs. Deferred):**
   - Split immediate items (`Requirements` / `Acceptance Criteria`) from future items (`Deferred requirements` + reason).
7. **Exit Gate & Smart Handoff:**
   - Verify all 5 lenses (or root cause), touchpoints, and scope are set, and `Open questions` / `Open research` are **100% empty**.
   - Log any friction in `04-refine.md`, set `Brainstorm` to `In Review` in `00-status.md`, and **STOP** (recommending `Prototype` skip if non-UI).

---

## 3. Phase 3: Lifecycle Prototype (`/lifecycle-prototype`) — ✅ FINALIZED

1. **Screen-or-Component Hierarchy & Self-Contained Styles:**
   - Root hub: `lifecycle/02-prototype.html` linking all feature hubs and flow diagrams.
   - Feature hub: `lifecycle/prototype/<feature>/index.html` showing screen/component carousels and user flow connections.
   - Variants: `lifecycle/prototype/<feature>/<unit>/option-[1-3].html` (`<350` lines each, where `<unit>` is a Full Screen/Flow or Focused Component).
   - **Inline `<style>` Only:** Embed `<style>` inside each HTML file—no shared CSS files, zero cross-variant style bleed.
2. **Structural Divergence + 5 UI States:**
   - The 3 options must use distinct layouts/flows (not color/font tweaks) and include toggles for `Populated | Empty | Loading | Error | Edge/Modal`.
3. **Logic & Flow Diagrams:**
   - Write modular Mermaid diagrams (`5–10` nodes max per sub-flow) in `01-requirements.md` and embed/link them in `02-prototype.html`.
4. **Gap Sync (`01-requirements.md` & `04-refine.md`):**
   - Immediately add any missing fields, filters, actions, or rules discovered while prototyping into `01-requirements.md`, and log friction to `04-refine.md`.
5. **Two-Stage Handoff & Mix-and-Match Lock:**
   - **Stage 1 (`In Review`):** Set `Prototype` to `In Review` in `00-status.md`, present `02-prototype.html`, and ask the user to pick or mix-and-match options. **STOP.**
   - **Stage 2 (`Done`):** Consolidate the user's chosen design into `Selected UI/UX Specification` in `01-requirements.md`, mark `Prototype` as `Done`, and auto-advance to `Roadmap`.

---

## 4. Phase 4: Lifecycle Roadmap (`/lifecycle-roadmap`) — ✅ FINALIZED

1. **Priority-Ordered Vertical Slicing (No Horizontal Layer Tasks):**
   - Group tasks in `03-roadmap.md` by priority: `P0: Foundation / Prefactoring` → `P1: Core End-to-End Flows` → `P2: Secondary Flows & Edge Polish`.
   - Each task must cut a **small, vertical, testable slice (`~2–5` files)**—never horizontal layers (*"all models, then all UI"*).
2. **Upfront Prefactoring Rule (`~500-Line` Ceiling):**
   - If a target file is already near/over `~500` lines, schedule a dedicated **Prefactoring Task** first (*"Make the change easy, then make the easy change"*).
3. **Skimmable, Complete 6-Part Task Anatomy (`03-roadmap.md`):**
   - **Outcome:** 1 sentence stating what works when this task finishes.
   - **Touchpoints (`Add` / `Update` / `Delete`):** Exact file paths and symbol changes, reusing items from `01-requirements.md` (including any schema migrations, security rules, or indexes).
   - **Acceptance Criteria (Binary Pass/Fail):** Testable conditions + exact analyzer and fast logic/controller test commands (no shallow static-widget UI tests).
   - **Business Rules:** Domain, validation, and permission rules from `01-requirements.md` for this slice.
   - **Code Guidelines:** Specific `.agents/rules/` files and constraints governing the touched files.
   - **Human Verification (`Action` → `Expected`):** 1–2 concise steps for the user to verify the slice.
4. **Sync to `00-status.md` & Handoff:**
   - Add every task row (`Task 1: ...`, `Task 2: ...`) to `00-status.md` as `Todo`, log any friction in `04-refine.md`, set `Roadmap` to `In Review`, and **STOP** for user approval.

---

## 5. Phase 5: Lifecycle Execute (`/lifecycle-execute`) — ✅ FINALIZED

1. **Strict Single-Task Execution (`00-status.md` & Worker Sub-Agent):**
   - Pick only the first `Todo` (or `In Progress`) task in `00-status.md` and mark it `In Progress`.
   - Read the full target files and their immediate callers before editing; implement **only** that task's touchpoints from `03-roadmap.md` (delegating multi-file execution and test runs to a fresh worker sub-agent).
2. **5-Gate Pre-Handoff Self-Review (Fix Failures Before Handoff):**
   - Before handing off, verify and check off in `03-roadmap.md`:
     1. **Outcome Gate:** Changes deliver the exact task outcome.
     2. **Acceptance Criteria Gate:** Every AC item for the task is met.
     3. **Business Rules Gate:** All domain, validation, and permission rules hold.
     4. **Code Guidelines Gate:** Touched files obey `.agents/rules/` (`<500` lines, `StatelessWidget`/`HookWidget` only, `Direct Client SDK First`).
     5. **Automated Check Gate:** Linter/analyzer reports `0` issues and fast unit/controller tests pass.
3. **Mistake & Friction Logging (`04-refine.md`):**
   - If any rule was unclear or caused a rework loop during execution, log `Phase/Task`, `Problem`, `Cause`, and `Solution` in `04-refine.md`.
4. **Skimmable Handoff & Approval Gate:**
   - Set the task to `In Review` in `00-status.md`, present a 4-bullet summary (**Changed Files**, **5-Gate Check Status**, **Test/Analyzer Proof**, and **`Action` → `Expected` Verification**), and **STOP** for user approval before starting the next task.

---

## 6. Phase 6: Lifecycle Review (`/lifecycle-review`) — ✅ FINALIZED

1. **Complete Scope Discovery (Committed + Uncommitted + Untracked):**
   - Verify all roadmap tasks in `00-status.md` are `Done`, set `Review` to `In Progress`, and spawn a fresh auditor sub-agent to inspect `git status --short`, `git diff HEAD`, `git diff <base>...HEAD`, and all `03-roadmap.md` touchpoints.
2. **5-Point Full-Branch Audit:**
   1. **Global AC & Scope (`01-requirements.md`):** Every requirement, acceptance criterion, and business rule holds end-to-end with zero scope creep.
   2. **Cross-Task Seam & Integration Check:** Trace `Input → Validation → State/Repo → UI Refresh` across tasks; verify navigation arguments, provider/cache invalidation, and end-to-end flow tests work seamlessly together.
   3. **Guidelines & Diff Hygiene (`.agents/rules/`):** Touched files obey all rules (`<500` lines, `StatelessWidget`/`HookWidget` only, `Direct Client SDK First`, no raw contract strings) with zero debug logs or dead code.
   4. **Security, Tenancy & Performance Check:** Tenant/auth filters enforced on all queries/mutations, zero N+1 queries in loops, and no leaked subscriptions/controllers.
   5. **Two-Tier Smart Deduplication (`widgets/components/utils/commons`):**
      - Auto-wire to existing shared helpers and auto-extract intra-feature/intra-module duplication.
      - Propose cross-module/`core/` extractions to the user before modifying shared files used outside the module.
3. **Fix Policy & Global Verification:**
   - Apply safe fixes/deduplications directly and run full static analysis (`0` issues) + full test suites (`100%` pass).
   - Route any major missing requirement or large architectural rework into a new task in `03-roadmap.md` and `00-status.md`.
4. **Refinement Logging & Handoff (`In Review`):**
   - Log any recurring mistakes or rule gaps into `04-refine.md`, set `Review` to `In Review` in `00-status.md`, present a concise **5-Point Review Summary**, and **STOP** for user approval.

---

## 7. Phase 7: Lifecycle Finalize (`/lifecycle-finalize`) — ✅ FINALIZED

1. **Permanent Project Documentation Sync:**
   - Update `docs/modules/<module>.md` with new features, models, endpoints, or state flows.
   - Flush staged domain terms from `01-requirements.md` into `GLOSSARY.md`.
   - Update `README.md` if public setup, env variables, or commands changed.
2. **Process Evolution ("Friction to Wisdom" from `04-refine.md`):**
   - Systematically review all `Phase/Task`, `Problem`, `Cause`, and `Solution` entries in `04-refine.md`.
   - **Dual-Target Evolution (Rules & Skills):**
     - **Target A (Project Rules):** Apply approved updates to `.agents/rules/*.md` for code conventions and invariants.
     - **Target B (Lifecycle Skills & Upstream Sync):** If friction was caused by a lifecycle skill ambiguity or gate flaw, apply updates directly to local skills, AND format an **"Upstream Skill Improvement Block"** in chat so the user can easily paste it into the central `skills` repository to upgrade the master skills across all projects.
3. **Copy-Paste PR Suite Generation:**
   - Generate a clean, complete PR summary in chat containing: **PR Title**, **Outcome Summary**, **File Changes**, and **Verification Evidence** (ready to paste directly into GitHub/GitLab).
4. **Handoff & Confirmed `lifecycle/` Cleanup:**
   - Set `Finalize` to `In Review` in `00-status.md`, present the doc/rule updates and PR summary, and **STOP** for user approval.
   - Upon final user approval (`Done`), ask whether to delete (`rm -rf lifecycle/`) or archive the temporary tracking directory, leaving the repository clean for manual git commit and push.

---

## 8. Lifecycle Files Needed (`lifecycle/` Directory) — ✅ FINALIZED

- **`00-status.md`:** 2-column table (`| Step / Task | Status |`) with statuses `Todo`, `In Progress`, `In Review`, `Done`, `Skipped`.
- **`01-requirements.md`:** Problem & Outcome, Existing Code & Reuse Touchpoints, Requirements, Acceptance Criteria, Rules, Decisions, Glossary Updates (staged), Deferred Requirements, Open Questions (empty at sign-off), Open Research (empty at sign-off), Selected UI/UX Specification, and Mermaid Flow Diagrams.
- **`02-prototype.html` & `prototype/`:** Root launcher (`02-prototype.html`), feature carousel hubs (`prototype/<feature>/index.html`), and self-contained variants (`prototype/<feature>/<unit>/option-[1-3].html` with inline `<style>`).
- **`03-roadmap.md`:** Priority-ordered vertical tasks with Outcome, Touchpoints (`Add`/`Update`/`Delete`), Acceptance Criteria, Business Rules, Code Guidelines, and Human Verification.
- **`04-refine.md`:** Entries with `Phase/Task:`, `Problem:`, `Cause:`, `Solution:`, and `Target File Updated:`.

---

## 9. Discussion Progress Tracker

| Section | Status | Current Discussion Focus |
| :--- | :--- | :--- |
| **1. Lifecycle** | `Done` | Finalized & locked (11 points) |
| **2. Lifecycle Brainstorm** | `Done` | Finalized & locked (7 points) |
| **3. Lifecycle Prototype** | `Done` | Finalized & locked (5 points) |
| **4. Lifecycle Roadmap** | `Done` | Finalized & locked (4 points) |
| **5. Lifecycle Execute** | `Done` | Finalized & locked (4 points) |
| **6. Lifecycle Review** | `Done` | Finalized & locked (4 points) |
| **7. Lifecycle Finalize** | `Done` | Finalized & locked (4 points) |
| **8. Files (`00` to `04`)** | `Done` | Aligned and locked |
| **9. Skill File Creation** | `Done` | All 7 skills and templates created and verified |
