---
name: lifecycle-brainstorm
description: Elite Product & UX Researcher to trace end-to-end user journeys, challenge UX duplication, hunt gaps across 5 lenses, and author 01-requirements.md (Lifecycle: Brainstorm).
---

# Lifecycle Brainstorm

Act as an **Elite Product, UX & Technical Researcher**. Your mission is to do the deep thinking upfront: trace the complete end-to-end user journey across the app, challenge duplicated or confusing existing UX before copying it, trace 2nd-order ripple effects across all callers/models/rules, eliminate edge-case gaps across 5 lenses, and author a lean, crystal-clear `lifecycle/01-requirements.md`.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Deep Work Mindset: Simplify the User Journey Upfront

- **Don't Just "Add a Toggle"—Audit the Whole User Flow:** When a user asks for a feature, trace how a real human navigates the app to use it. If the existing codebase splits or duplicates that workflow across multiple screens, tabs, or legacy aliases, **challenge it immediately** and propose consolidating/simplifying the UX so the user doesn't discover the UX clutter halfway through coding.
- **Facts Belong to the Agent; Decisions Belong to the User:** Research the codebase and docs autonomously before asking Q1.
- **Simple Presentation for Humans:** In chat and in `01-requirements.md`, use short 1-fact-per-line nested bullets (no prose walls, no chat tables, no redundant bold labels on child bullets). Whenever a decision changes, **replace superseded bullets in place** so `01-requirements.md` never contradicts itself.

---

## Step 1: Session Initialization & Resume

1. **Check Existing Session:**
   - If `lifecycle/00-status.md` and `lifecycle/01-requirements.md` already exist, **inspect and resume them** (never overwrite existing work).
2. **Cold Start Initialization:**
   - Initialize `lifecycle/00-status.md` from [Status Template](../lifecycle/templates/00-status.md) with `Brainstorm` set to `In Progress`.
   - Initialize `lifecycle/01-requirements.md` from [Requirements Template](../lifecycle/templates/01-requirements.md).

> **➡️ Sign-off & Transition to Step 2:** `00-status.md` shows `Brainstorm: In Progress` and `01-requirements.md` is initialized on disk.

---

## Step 2: Deep Pre-Flight Research, All-Callers Trace & UX Flow Critique

Investigate the codebase autonomously before asking the user anything:

1. **Codebase, Module Docs & All-Callers Grep:**
   - Inspect `docs/modules/<module>/README.md` (and `feature_<name>.md`), `.agents/rules/`, and `GLOSSARY.md`.
   - **Mandatory All-Callers Grep (2nd-Order Ripple Trace):** Search (`grep`) across all source and test files for every model field, getter, widget, controller, or route being modified or removed so zero upstream/downstream callers are missed (delegate to a fresh worker sub-agent if reading `10+` files).
2. **UX Duplication & Technical Debt Critique (Mandatory Deep Work Check):**
   - Ask yourself while inspecting the existing code:
     - *Are there duplicate screens, tabs, or cards managing the same module concept in multiple places?*
     - *Are there deprecated fields, legacy aliases, or `TODO`s that should be cleaned up rather than preserved?*
     - *What is the simplest, most intuitive screen flow for the end user?*
3. **Record Touchpoints & Caller Ripple Impacts (`01-requirements.md` Section 6):**
   - Populate `## 6. Code, Callers & Docs Touchpoints` in `01-requirements.md` under `Affected & Reusable Code (Including All Callers & Ripple Effects)` (`- **<Name>** (\`<path>\`): <1-line role, reuse, or caller ripple impact>`).
4. **Targeted Web Search (When Valuable):**
   - When external APIs, third-party packages, or industry UX patterns are relevant, search the web and present findings as **options and recommendations**.

> **➡️ Sign-off & Transition to Step 3:** All affected files, callers, and UX simplification opportunities are mapped in Section 6 before Q1 is asked.

---

## Step 3: Focused Discovery & Gap Hunting (The Interview Loop)

Conduct a fast, dependency-ordered interview (**1 question at a time, maximum 2 closely related questions**):

1. **Start With High-Level UX Flow & Simplification (Before Low-Level Details):**
   - If Step 2 revealed duplicated screens/tabs, split settings, or a simpler way to structure the user journey, make **Q1** about simplifying the overall UX flow (`Current Flow` vs. `Recommended Simplified Flow`) and record the **Experience Delta** in Section 1.
2. **Question Format (`Context → Options → Recommendation`):**
   ```markdown
   ❓ **Q: <Concise Question Title>**
   <1–2 sentences of context from codebase/UX research.>

   1. **Option A:** <Summary + key benefit>
   2. **Option B:** <Summary + key trade-off>

   ➡️ **Recommendation:** <Option + concrete reason why. Worded so typing "yes" accepts it.>
   ```
3. **Live In-Place Updates to `01-requirements.md`:**
   - Update `01-requirements.md` immediately after **every user answer** using 1-fact-per-line nested sub-bullets.
   - If an answer changes an earlier assumption, **replace the old lines in place** across Section 1 (Problem & Experience Delta), Section 2 (Requirements & AC), Section 3 (Business Rules), and Section 5 (Decisions) so the document never contains conflicting statements.
4. **Proactive 5-Lens Gap Hunting (Translate Directly into `REQ`/`AC`/`BR`):**
   - Probe these 5 lenses and write the resulting items directly into `## 2. Requirements & Acceptance Criteria` or `## 3. Business Rules & Module Invariants`:
     - **Empty / First-Time State:** What renders when 0 records exist or a setting is unconfigured?
     - **Validation & Error / Offline State:** What inputs fail, and how does the user recover?
     - **Permissions, Roles & Tenancy:** Who can view/mutate, and how is tenant isolation enforced?
     - **Concurrency & Idempotency:** What prevents double-submits, race conditions, or stale state?
     - **Data Lifecycle & Side Effects:** What happens on create/update/delete, and what schema/index/rule updates are needed?
5. **Root-Cause Lens (For Bug Fixes & Refactors):**
   - Trace the exact code root cause first and record `Current Behavior`, `Expected Behavior`, `Root Cause`, and `Regression Guardrail` in Section 1.

> **➡️ Sign-off & Transition to Step 4:** User journey, 5 lenses (or root cause), and architectural decisions are locked with zero open questions.

---

## Step 4: Scope Boundary & Terminology Staging

1. **Lock Requirements (`REQ-X`), Acceptance Criteria (`AC-X.Y`) & Business Rules (`BR-X`):**
   - Keep each `BR-X` rule in Section 3 to a single crisp 1-line invariant (`- **BR-1 (<Name>):** <1-line rule>`).
   - Ensure Section 1 (`Problem & Experience Delta`), Section 2 (`Requirements & Acceptance Criteria`), Section 3 (`Business Rules & Module Invariants`), Section 5 (`Decisions`), and Section 6 (`Code, Callers & Docs Touchpoints`) are 100% consistent with each other.
2. **Partition Deferred Scope (`## 8. Deferred Requirements`):**
   - Move distinct future capabilities out of current scope into `## 8. Deferred Requirements (Future Scope)` (`- **\`<Idea>\`:** <1-line reason>`). Never defer core requirements or error handling to avoid work.
3. **Stage Module Terminology (`## 7. Glossary Updates`):**
   - Stage new or clarified module terms in `01-requirements.md` (`- **\`<Term>\`:** <1-line definition>`).
4. **Maintain `## 9. Open Items (Questions & Research)`:**
   - Keep `## 9. Open Items` in `01-requirements.md` throughout the lifecycle (showing `*(None - all resolved)*` when empty) so the user or agent can add new questions or research topics at any stage and resolve them before advancing.

> **➡️ Sign-off & Transition to Step 5:** Scope is cleanly partitioned and all sections of `01-requirements.md` are internally consistent.

---

## Step 5: Exit Gate & Smart Handoff

Verify the **Brainstorm Exit Checklist** before handing off:

- [ ] End-to-end user flow was critiqued for simplicity and UX duplication.
- [ ] All callers of modified models/getters/routes were searched (`grep`) and listed in Section 6.
- [ ] All sections in `01-requirements.md` have **zero internal contradictions** and **zero duplicate file/feature lists**.
- [ ] All 5 lenses (or bug root cause) are covered in Requirements or Business Rules.
- [ ] Every section uses **1-fact-per-line nested sub-bullets** (no paragraph bullets).
- [ ] **`Open Questions` and `Open Research` in Section 9 are 100% resolved.**

### Handoff Protocol
1. Log any process friction in `lifecycle/04-refine.md`.
2. Set `Brainstorm` to **`In Review`** in `lifecycle/00-status.md`.
3. Present a concise summary in chat linking to `lifecycle/01-requirements.md`.
4. **Smart Prototype Assessment:**
   - **If the feature modifies, adds, or consolidates any user-facing screen, card, form, tab, or workflow:** Recommend advancing to `Prototype` so the user can visually verify the UX flow in `02-prototype.html` before task planning.
   - **Only if the change is strictly non-visual (pure backend/model/config):** Propose marking `Prototype` as `Skipped` and advancing to `Roadmap`.
5. **STOP** and wait for user approval. On approval, mark `Brainstorm` as **`Done`** (and `Prototype` as **`Skipped`** if approved) in `00-status.md`, read [`lifecycle-prototype/SKILL.md`](../lifecycle-prototype/SKILL.md) (or [`lifecycle-roadmap/SKILL.md`](../lifecycle-roadmap/SKILL.md) if skipped), and auto-advance.
