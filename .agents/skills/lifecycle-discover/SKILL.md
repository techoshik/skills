---
name: lifecycle-discover
description: Explore the problem or opportunity, challenge weak assumptions, surface blind spots and consequences, define screen-anchored target features, and produce an approved Discovery document (Lifecycle: Phase 1 — Discover).
---

# Phase 1 — Lifecycle Discover

## 1. Purpose

> **Core Mental Model:** Every user request is a starting signal, never a complete specification. Act as a trusted product advisor — not an order-taker. Research first, surface blind spots and downstream consequences the user has not yet seen, turn vague asks into concrete proposals, and confirm one decision at a time until zero open questions remain.

The output is an approved **Discovery document** (`lifecycle/01-discover.md`) defining *what* to build (goal, screen-anchored features, edge cases, scope, trade-off decisions, glossary, and evidence) — never *how* to design or code it.

---

## 2. Core Rules

- **Research Before Asking (Zero Guesswork):** Search the codebase (entities, policies, tests, logs, root `GLOSSARY.md`) or research domain patterns (for greenfield) *before* asking the user anything. Existing code proves *current behavior*, never *desired behavior*. Never ask a question the repo can answer.
- **Advise, Don't Just Order-Take (Consequence Thinking):** Never blindly transcribe a proposed solution. Play the user's idea forward 6 months to spot hidden operational burden, data-model traps, or UX fragility. Warn plainly about consequences and propose stronger alternatives alongside their idea.
- **Turn Weak Requirements Into Concrete Proposals:** When a requirement is vague (e.g. *"add filters"* or *"make it customizable"*), never ask an open-ended *"What do you want?"* Inspect the codebase's real fields and propose a concrete starter set for the user to confirm or tweak in one turn.
- **Generalize Beyond Sample Artifacts:** Treat user-provided examples, screenshots, or sample files as *illustrative test cases*, not hardcoded domain constraints. Confirm what is a universal default vs. a per-item configurable setting.
- **One Question Per Turn & Warm Collaborative Tone:** Ask one focused decision at a time in plain, 5th-grade English (zero corporate/technical jargon). Briefly show what you found before asking, reflect the user's answer back in one sentence before advancing, and lead with empathy on fuzzy or frustrating problems.
- **Zero Silent Assumptions (`ASM-N` Queue):** Never treat an unconfirmed inference or a recommended default as an approved requirement. Log every unconfirmed assumption, gap, or `[High Risk]` unknown in `**Open Questions (ASM-N):**` under `## 6. Current System & Evidence` and clear each item into `## 2`, `## 3`, or `## 4` once explicitly decided.
- **User-Owned Scope & Live Document:** Explore broadly without filtering early; let the user own all `Deferred` vs. `Out of Scope` triage late in the phase. Update `lifecycle/01-discover.md` in place after every turn (never batch updates), and immediately append any skill/workflow friction to `lifecycle/refine.md`.
- **Strict Phase Boundaries:** No UI flows or prototypes (Phase 2 — Design), no technical architecture or task slices (Phase 3 — Plan), and no production code or test runs (Phase 4 — Build).

---

## 3. Execution Sequence

Follow these steps strictly in order:

### Step 0 — Session Check (Resume vs. New)

Check whether `lifecycle/01-discover.md` already exists with content:
- **If resuming:** Read the file as your working map. State the `**Goal:**` aloud in chat, scan `**Open Questions (ASM-N):**` in `## 6` for unresolved `ASM-N` items, and ask: *"Shall we continue from [last open branch], or has anything changed since we last spoke?"* Do not restart intake.
- **If new:** Proceed to Step 1.

### Step 1 — Pre-Flight Research (Before Asking Anything)

1. **Classify Request & Separate Problem vs. Solution:**
   - Separate the **Underlying Problem** (what hurts), **Desired Outcome** (what becomes true), and **Proposed Solution** (the user's suggested mechanism).
   - *Brief/fuzzy:* Identify the core missing context for Step 2.
   - *Detailed spec:* Treat it as a hypothesis to verify — check for missing states, roles, and failure modes.
2. **Gather Evidence (Two Tracks):**
   - **Track A — Existing Codebase:** Read root `GLOSSARY.md` (if present), then `grep` related modules, models, rules, routes, and tests to map how the system works today.
   - **Track B — Greenfield (No Codebase):** Extract stated user constraints, identify 2–3 comparable domain patterns, note implicit industry/platform constraints, and document the current manual workaround or status quo (never leave current system blank).
3. **Populate `## 6. Current System & Evidence` & Seed `## 5. Glossary`:**
   - Record concise, source-cited bullets (`file:line` or domain source) under `**Current System & Verified Facts:**` in `## 6`.
   - Log all unconfirmed inferences, gaps, and `[High Risk]` unknowns (security, permissions, data integrity, UX blockers) in `**Open Questions (ASM-N):**` in `## 6` with `Status: Ready to ask` or `Waiting on ASM-X`.
   - Seed `## 5. Glossary (Core Terms)` with key domain terms in plain English (reusing `GLOSSARY.md` where available).

### Step 2 — Confirm Goal, Surface Map & "Broader Picture" Pass

1. **Name the Goal & Problem (`## 1. At a Glance`):**
   - Write a crisp 1–2 sentence `**Goal:**` (**≤ 30 words**, outcome-focused, zero feature lists) and flat bullets under `**The Problem:**`.
   - If the request was brief or fuzzy, confirm this `**Goal:**` with the user before going deeper. Every later scope decision is tested against it.
2. **Breadth-First Surface Map (`## 2. Target Features` Stubs):**
   - Fan out across the entire problem space and list every candidate screen or user flow as a stub heading (`### F1 — [Screen/Flow Name]`) with a 1-line description — no deep probing yet.
   - If later probing uncovers a new screen/flow, pause, add it to the surface map, and check it against the Goal.
3. **Proactive "Broader Picture" & Consequence Pass (Before Locking Features):**
   - **Consequence & Ripple Check:** Evaluate the user's proposed approach 6 months out. If it risks repetitive manual work, rigid/unsearchable data models, or fragile UX for non-technical users, flag the consequence plainly and offer a better alternative.
   - **Blind-Spot Scan:** Proactively surface **2–4 high-value considerations the user hasn't mentioned yet**, checking:
     - *Day-2 Operations:* How will users edit, duplicate, archive, or undo this later?
     - *Other Roles & Devices:* Who else touches this (viewer vs. editor vs. admin, mobile vs. desktop)?
     - *Existing Data & Migration:* What happens to records that already exist before this ships?
     - *Simpler Workflows:* Is there a cleaner UX pattern (smart defaults, live preview, two-stage split) that achieves the same goal with less friction?

### Step 3 — Deepen Each Feature Branch (Depth-First, One Decision at a Time)

Work through one feature branch completely (`### F1` → `### F2`) before moving to the next (no random topic jumping; note cross-feature dependencies if a branch affects a shared entity):

1. **Write Screen-Anchored, Flat User-Capability Items (`F-N.x`):**
   - Anchor each `### F-N` heading to a concrete screen or user flow (e.g. `### F1 — User List Screen`) so large modules correlate 1:1 with flows and prototypes in `02-design.md` and tasks in `03-plan.md` — no extra `_Outcome:_` or `_Why:_` filler lines beneath headings.
   - Write `F-N.x` items as a **strictly flat** 1-line list in **user-capability / outcome phrasing** (**5–15 words each, zero nested sub-bullets, zero corporate prose**). Never use developer task verbs (`Create`, `Build`, `Implement`) or repeated `"Able to..."` filler — start directly with what the user sees or can do so a junior developer can read it in seconds and spot any missing screen, button, filter, or rule. Split any multi-part capability (3+ parts) into separate `F-N.x` items.
   - *Avoid:* `- Create a dropdown to filter user list by role` / `- Able to manage the list`
   - *Require:* `- Show user list (name, role, status)` / `- Filter users by role dropdown (Admin, Editor, Viewer)` / `- Search users by name` / `- Add new user via "+ Add User" button (Admin only)`
2. **Resolve Open Questions One by One (Prioritize `[High Risk]` First):**
   - Present **one** decision per turn using this card (always include **Why It Matters** so the user sees the real consequence):

   ```markdown
   ❓ **Decision Needed: <Short Title>**
   **Context:** <1 sentence of verified facts from codebase/research.>
   **Why It Matters:** <1 sentence on the downstream consequence or what gets locked in.>

   - **Option A:** <Concrete choice, benefit, and trade-off>
   - **Option B:** <Concrete choice, benefit, and trade-off>

   👉 **Recommendation:** <Option A + 1-sentence plain-English rationale.>
   ```

   - **Contradiction Surfacing:** If user intent conflicts with existing system behavior, pause and surface it immediately:

   ```markdown
   ❗ **Conflict Found: <Short Title>**
   **What You Asked:** <User's intent>
   **What the System Currently Does:** <Codebase evidence — file:line>
   **Why These Conflict:** <1–2 sentence explanation>

   Which behavior should win, or do we need a migration path?
   ```

   - **Move-and-Clear + Unblock:** After every resolved `ASM-N`, promote it to `## 2`, `## 3`, or `## 4`, **remove** it from `**Open Questions (ASM-N):**` in `## 6`, and immediately mark any newly unblocked `Waiting on ASM-X` items as `Ready to ask`.
3. **Cover All 5 Edge-Case Lenses Inline Per Feature (`F-N-E1`–`F-N-E5`):**
   - Document all 5 lenses directly under each feature as **flat 1-line bullets**: *Zero/Empty State*, *Validation & Recovery*, *Permissions & Access*, *State & Concurrency*, and *Data Lifecycle* (each confirmed or marked `N/A — reason`).
   - Internally sanity-check relevant resilience angles (role/self boundaries, halfway failure, reversibility, external dependencies, rollout/migration, observability, locale) and surface any gap as an `ASM-N` question.

### Step 4 — Scope Triage, Trade-Off Decisions & Block Confirmation

1. **User-Owned Scope Triage (`## 3. Deferred & Out of Scope`):**
   - Once all features and edge cases are clear, let the user triage excluded items against the `**Goal:**`:
     - **Deferred:** Reviewed items saved for a later cycle (copied to `docs/modules/<module>/README.md` in Phase 5 Close).
     - **Out of Scope:** Items sitting beyond the stated Goal, with a 1-line reason.
2. **Record Trade-Off Decisions Only (`## 4. Key Decisions & Rationale`):**
   - **Only log a `DEC-N` when a real alternative was considered and rejected** (e.g. Client-side vs. Server-side, `snake_case` vs. `camelCase`). Never create a `DEC-N` just to restate an `F-N.x` feature already in `## 2`.
   - Keep every `DEC-N` to a tight 2-line block (`**Choice:**` ≤ 20 words, `**Why:**` ≤ 15 words). `01-discover.md` remains the single home for all lifecycle decisions (including any uncovered in Phase 2 — Design).
3. **Per-Feature-Block Confirmation:**
   - Present the current `01-discover.md` feature blocks and receive explicit confirmation before requesting final Gate 1 approval.

---

## 4. Exit Gate & Completion Criteria

### Pre-Flight Checklist

Before requesting Phase 1 approval, verify:
- **Goal & Problem Settled:** `**Goal:**` (≤ 30 words, no feature list) and `**The Problem:**` are confirmed in `## 1. At a Glance`.
- **Screen-Anchored Features & Edge Cases Complete:** Every `### F-N` has flat 1-line `F-N.x` checklist items and all 5 `F-N-E1`–`F-N-E5` edge-case bullets confirmed by the user.
- **Broader Picture & Consequences Explored:** Blind spots (Day-2 ops, roles/devices, existing data, simpler workflows) and downstream consequences were surfaced and decided.
- **User-Triaged Scope & Trade-Off Decisions:** `## 3` holds user-confirmed `Deferred` / `Out of Scope` items; `## 4` holds trade-off `DEC-N` entries with zero contradictions against `## 2`.
- **Glossary & Evidence Current:** `## 5. Glossary (Core Terms)` is populated; `## 6. Current System & Evidence` has verified facts (`file:line` or source) and `**Open Questions (ASM-N):**` is cleared to `- None.`.

### Requesting User Approval (Phase 0 Protocol)

1. Set Phase 1 to `In Review` in `lifecycle/00-status.md`.
2. Output a concise 1–2 sentence summary linking `[01-discover.md](01-discover.md)` and ask for explicit approval to advance to Phase 2 — Design.
3. Stop calling tools and wait for the user's response (`Approved` → mark `Done` and load `lifecycle-design`; `Changes Requested` → return to `In Progress`; `Blocked` → mark `Blocked`).

---

## 5. Output Template (`lifecycle/01-discover.md`)

```markdown
# Discover: [Requirement / Feature Name]

## 1. At a Glance

**Goal:** [1–2 short sentences (≤ 30 words) in plain English describing what users can do once built — no feature list here]

**The Problem:**
- **[Short Label]:** [One short sentence explaining what breaks or hurts today]
- **[Short Label]:** [One short sentence explaining operational or user friction]

## 2. Target Features

### F1 — [Screen or Flow Name, e.g. User List Screen]

- **F1.1:** Show user list (name, role, status)
- **F1.2:** Filter by role dropdown (Admin, Editor, Viewer)
- **F1.3:** Search by name text box
- **F1.4:** "+ Add User" button (Admin only)
- **F1.5:** Edit and Delete buttons on each user card
- **F1.6:** Tap a user card to open User Detail screen
- **Edge Cases:**
  - **F1-E1 (Zero / Empty State):** [Short 1-line note on what shows when empty]
  - **F1-E2 (Validation & Recovery):** [Short 1-line input validation and retry/recovery rule]
  - **F1-E3 (Permissions & Access):** [Short 1-line rule on who can view or act]
  - **F1-E4 (State & Concurrency):** [Short 1-line loading lock, double-tap, or sync rule]
  - **F1-E5 (Data Lifecycle):** [Short 1-line rule on what is saved, updated, or deleted]

### F2 — [Screen or Flow Name]

- **F2.1:** [One concrete element, action, or rule per line (5–15 words)]
- **Edge Cases:**
  - **F2-E1 (Zero / Empty State):** ...
  - **F2-E2 (Validation & Recovery):** ...
  - **F2-E3 (Permissions & Access):** ...
  - **F2-E4 (State & Concurrency):** ...
  - **F2-E5 (Data Lifecycle):** ...

## 3. Deferred & Out of Scope

**Deferred:**
- [Reviewed item saved for a later cycle — one short line]

**Out of Scope:**
- [Item beyond the Goal, with short reason — one line]

## 4. Key Decisions & Rationale

**DEC-1 — [Topic Title]**
- **Choice:** [What was decided, in ≤ 20 words]
- **Why:** [Trade-off accepted / alternative rejected, in ≤ 15 words]

## 5. Glossary (Core Terms)

| Term | Meaning |
| :--- | :--- |
| **[Term 1]** | [Simple, everyday definition (≤ 15 words)] |
| **[Term 2]** | [Simple, everyday definition (≤ 15 words)] |

## 6. Current System & Evidence

**Current System & Verified Facts:**
- **[Area / Module]** (`file:line` or source): [One short confirmed fact about how it works today]
- **[Area / Module]** (`file:line` or source): [Second confirmed fact, if needed]

**Open Questions (ASM-N):** *(replace items with `- None.` once resolved into §2/§3/§4; prefix critical items with `[High Risk]`)*
- **ASM-1 — [Short Topic Title]**
  - **Assumption / Question:** [What was inferred or remains unknown]
  - **Basis:** [Why not confirmed from evidence]
  - **Status:** Ready to ask *(or "Waiting on ASM-X")*
```
