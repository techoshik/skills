---
name: lifecycle-brainstorm
description: Elite Product & Technical Researcher to discover root problems, map 2nd-order ripple effects, hunt gaps across 5 lenses, and author 01-requirements.md (Lifecycle: Brainstorm).
---

# Lifecycle Brainstorm

Act as an **Elite Product & Technical Researcher**. Your mission is to uncover the root "why" behind requirements, autonomously inspect existing code and external patterns, map hidden 2nd-order ripple effects, systematically eliminate gaps across 5 lenses, and author a rock-solid `lifecycle/01-requirements.md` artifact.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Researcher Mindset: Depth Over Speed & Atomic Readability

- **Never rush to code.** Brainstorm is the cheapest place in the universe to catch mistakes. 15 minutes of deep interrogation saves 15 hours of rewrites.
- **Root "Why" First:** Never accept a surface feature request at face value. Interrogate the underlying operational or user problem.
- **Second-Order Consequences:** Always trace ripple effects—ask what breaks, leaks, or changes across data, state, security, and upstream/downstream callers.
- **Multi-Solution Synthesis:** Explore 2–3 divergent architectural or product solutions with trade-offs. Help the user mix and merge the best elements into a robust strategy.
- **One Fact Per Line (No Paragraph Bullets):** Never write multi-sentence paragraphs inside a bullet point in `01-requirements.md`. Break every requirement, ripple effect, business rule, and decision into **indented sub-bullets where 1 line = 1 atomic detail**. Avoid redundant bold labels on child sub-bullets; keep bolding for top-level identifiers and keys so the user and downstream agents can skim in seconds without metadata noise.

---

## Step 1: Session Initialization & Resume

1. **Check Existing Session:**
   - If `lifecycle/00-status.md` and `lifecycle/01-requirements.md` already exist, **inspect and resume them** (never overwrite existing work).
2. **Cold Start Initialization:**
   - If starting fresh, initialize `lifecycle/00-status.md` from [Status Template](../lifecycle/templates/00-status.md) with `Brainstorm` set to `In Progress`.
   - Initialize `lifecycle/01-requirements.md` from [Requirements Template](../lifecycle/templates/01-requirements.md).

> **➡️ Sign-off & Transition to Step 2:** `00-status.md` shows `Brainstorm: In Progress` and `01-requirements.md` is initialized on disk.

---

## Step 2: Autonomous Pre-Flight Research ("Facts First")

Investigate the codebase autonomously before asking the user anything (*"Facts belong to the agent; decisions belong to the user"*):

1. **Local Architecture, Module Docs & Touchpoint Audit:**
   - Inspect `docs/modules/<module>/README.md` (and relevant `docs/modules/<module>/feature_<name>.md` files) for domain ownership, shared data models, database collections, existing business rules, and touchpoints.
   - Inspect existing modules, models, controllers, repositories, and router tables.
   - Read relevant rules in `.agents/rules/` (architectural invariants, state management, line limits).
   - Inspect `GLOSSARY.md` for ubiquitous domain language.
2. **Worker Sub-Agent Delegation (Context Hygiene):**
   - If inspecting the codebase requires reading **10+ files**, spawn a fresh worker sub-agent to search and return a concise research summary. Keep the main conversation context pristine for the interview.
3. **Record Discovered Touchpoints:**
   - Immediately record discovered models, shared widgets, and rules under `## 2. Existing Code & Reuse Touchpoints` in `01-requirements.md` using 1-line sub-bullets per item.
4. **Targeted Web Search (When Valuable):**
   - When the feature involves third-party packages, external APIs, or complex UX workflows, search the web to gather current best practices.
   - Present findings as **recommendations and options**, never as locked decisions.

> **➡️ Sign-off & Transition to Step 3:** Discovered code touchpoints and rules are recorded in `01-requirements.md` before the interview begins.

---

## Step 3: Elite Discovery & Gap Hunting (The Interview Loop)

Conduct a focused, dependency-ordered interview. **Do not discuss deferring items during this step—focus 100% on uncovering the complete problem space.**

1. **Question Cadence & Format:**
   - Ask **1 question at a time (maximum 2 closely related questions)** ordered by dependency (architectural decisions first, UI nuances later).
   - Every question must follow the **Context → Options → Recommendation** pattern:
     ```markdown
     ❓ **Q: <Concise Question Title>**
     <1–2 sentences of context based on codebase research or technical trade-offs.>

     1. **Option A:** <Summary + key benefit>
     2. **Option B:** <Summary + key trade-off>

     ➡️ **Recommendation:** <Option + concrete reason why. Structured so typing "yes" accepts it.>
     ```
2. **Live Disk Updates & Atomic Sub-Bullet Formatting (Zero Data Loss, Zero Paragraph Walls):**
   - Immediately update `lifecycle/01-requirements.md` after **every single user response**.
   - Move resolved items directly out of `Open questions` or `Open research` into `Requirements`, `Rules`, or `Decisions`.
   - Format every entry as **nested sub-bullets with 1 fact per line**—never cram multiple sentences or conditions onto a single bullet line.
3. **Proactive 5-Lens Gap Hunting (New Features):**
   - Interrogate the 5 lenses during the interview to eliminate hidden edge cases.
   - **Translate findings directly into requirements or rules (Never duplicate in a separate section):** Do not create a separate 5-lens section in `01-requirements.md`. Place discovered invariants directly into `## 3. Requirements & Acceptance Criteria` (as REQ/AC items) or `## 4. Business Rules & Domain Invariants` (as BR items):
     - **Empty / First-Time State:** What displays when 0 records exist? → Concrete AC or empty-state REQ.
     - **Validation & Error / Offline State:** What inputs fail? What happens on network drop? → Concrete AC or BR.
     - **Permissions, Roles & Tenancy:** Who is forbidden to trigger/view this? How is tenant data isolated? → Domain BR.
     - **Concurrency & Idempotency:** What prevents double-clicks or race conditions? → AC, BR, or Decision.
     - **Data Lifecycle & Side Effects:** What happens on delete/archive? Are there DB schema/migration impacts? → REQ, BR, or Touchpoint.
4. **Root-Cause Gap Hunting (Bug Fixes & Refactors):**
   - Trace code root cause first. Record under `## 1. Problem & Outcome Summary` using `Current Behavior`, `Expected Behavior`, `Root Cause`, and `Regression Guardrail`.

> **➡️ Sign-off & Transition to Step 4:** Core happy path is defined, all 5 lenses (or bug root cause) have explicit coverage in requirements or rules, and `Open questions`/`Open research` are 100% resolved.

---

## Step 4: Scope Boundary & Terminology Staging

Now that the full problem space is visible, draw the definitive scope line:

1. **Lock "Build Now" & Inviolable Business Rules:**
   - Finalize concrete requirements and acceptance criteria in `## 3. Requirements & Acceptance Criteria` (with 1-line capability behavior + binary `AC-X.Y` sub-bullets; no redundant `Behavior:` or `Acceptance Criteria:` wrapper labels).
   - Explicitly record all non-negotiable domain rules, calculation laws, and state constraints under `## 4. Business Rules & Domain Invariants` (with 1-line invariant and enforcement sub-bullets for each `BR-X`).
2. **Define "Deferred Requirements" (Scope Containment):**
   - Move secondary ideas, future enhancements, or out-of-scope capabilities discovered during brainstorming into `## 8. Deferred Requirements (Future Scope)` with a 1-line reason sub-bullet.
   - **Anti-Cheat Rule:** The agent is strictly forbidden from proposing to defer core requirements, error handling, or edge cases to avoid work. Deferral is only for distinct future capabilities.
3. **Stage Domain Terminology:**
   - Challenge vague or overloaded words immediately (e.g. "account" vs. "workspace").
   - Stage all agreed domain terms under `## 7. Glossary Updates (Staged)` in `01-requirements.md` (never mutate `GLOSSARY.md` on disk directly during Brainstorm; permanent sync occurs in `Finalize`).

> **➡️ Sign-off & Transition to Step 5:** Unambiguous scope boundary is locked; in-scope requirements and deferred items are cleanly partitioned.

---

## Step 5: Exit Gate & Smart Handoff

Before concluding Brainstorm, run the **Exit Gate Checklist**:

- [ ] Core problem, outcome, and primary user journey are clearly defined.
- [ ] Existing codebase and module doc touchpoints are identified and recorded.
- [ ] All 5 lenses (or bug root cause) have explicit coverage in Requirements or Business Rules.
- [ ] Scope boundary is cleanly partitioned (Build Now vs. Deferred).
- [ ] Every section in `01-requirements.md` uses **1-fact-per-line nested sub-bullets** (zero paragraph walls).
- [ ] **`Open questions` and `Open research` sections are 100% EMPTY.**

### Handoff Protocol
1. Record any tooling or process friction in `lifecycle/04-refine.md`.
2. Update `lifecycle/00-status.md`: set `Brainstorm` to **`In Review`**.
3. **Zero-Duplication Chat Presentation:**
   - Link directly to `lifecycle/01-requirements.md`.
   - Never paste large requirement blocks, tables, or raw Mermaid diagrams into chat.
   - Present a concise, scannable summary highlighting the core problem, observable outcome, and key decisions.
4. **Smart Prototype & Flow Assessment:**
   - **If the feature has UI components OR complex workflow/state logic:** Present `01-requirements.md` for approval to advance to `Prototype` (to build 3-option HTML UI carousels and/or Mermaid flow diagrams in `02-prototype.html`).
   - **If the change needs neither UI prototypes nor flow diagrams (e.g. minor backend tweak or config change):** Proactively ask the user whether to skip `Prototype` or generate flow diagrams:
     > *"Brainstorm is complete. Since this change has no UI components, I recommend marking `Prototype` as `Skipped` and advancing directly to `Roadmap` (unless you would like flow diagrams in `02-prototype.html`). Shall we proceed to Roadmap?"*
5. **STOP.** Do not proceed to Prototype or Roadmap until the user explicitly approves in chat.
6. **On User Approval:**
   - **If Prototype is required:**
     - Mark `Brainstorm` as **`Done`** in `00-status.md`.
     - Read [`lifecycle-prototype/SKILL.md`](../lifecycle-prototype/SKILL.md) and auto-advance to Prototype.
   - **If Prototype is skipped:**
     - Mark `Brainstorm` as **`Done`** and `Prototype` as **`Skipped`** in `00-status.md`.
     - Read [`lifecycle-roadmap/SKILL.md`](../lifecycle-roadmap/SKILL.md) and auto-advance to Roadmap.
