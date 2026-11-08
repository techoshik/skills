---
name: lifecycle-discover
description: Explore the problem or opportunity, challenge assumptions, define target features and sub-features, and produce an approved Discovery document (Lifecycle: Phase 1 — Discover).
---

# Phase 1 — Lifecycle Discover

## 1. Purpose

> **Core Mental Model:** Uncover the requirements. Clarify the problem through codebase facts. Settle core terms. Triage scope with the user.

Explore the initial problem, opportunity, or request through evidence-based investigation until the Decision Frontier is empty (zero unexamined assumptions). The output is an approved **Discovery document** (`lifecycle/01-discover.md`) establishing what to achieve (target features, settled core terms, scope, and edge cases)—not how to design or implement it.

## 2. Guiding Principles

- **Expansive Exploration First:** Collect and uncover all requirements, possibilities, edge cases, and user desires without premature filtering. Never act as a critic or dismiss ideas in early stages.
- **User-Owned Scope Prioritization:** Triage into *In Scope* vs. *Deferred* occurs late in the phase, and is 100% owned by the user. The agent never assumes, filters, or drops requirements unilaterally.
- **Adaptive Entry Matching User Starting Point:** Meet the user where they start (brief thought, rough idea, or detailed spec) instead of forcing a rigid intake questionnaire.
- **Problem vs. Solution Framing:** Distinguish the underlying problem (what hurts) and desired outcome (what becomes true) from the proposed solution (the user's suggested mechanism). Solve the real problem, not just a suggested symptom.
- **Never Convert Inferences into Requirements:** A plausible inference or reasonable guess is never an established requirement. If not backed by codebase facts or explicit user confirmation, it remains an open question.
- **Domain Vocabulary Settle:** Pin exact domain concepts and terms early so everyone speaks the exact same language from Day 1.
- **Evidence Over Guesswork:** Ground existing behavior, bugs, and workflows in concrete code searches (`grep`), error logs, and tests. Facts belong to the Agent; decisions belong to the User. Existing code proves how the system *currently behaves*, never what the user *wants*; never assume legacy implementation represents desired requirements.
- **The Decision Frontier & Risk Priority:** Map open decisions whose prerequisites are confirmed. Prioritize high-impact uncertainties (security, permissions, data integrity, session lifecycle) over low-impact cosmetic choices; exit only when the frontier is empty.
- **Depth-First Continuity (Anti-Popcorn Rule):** Resolve one branch deeply before moving to another; ban jumping randomly across unrelated topics on consecutive turns.
- **Self-Challenge Before Settling:** Actively probe for blind spots. Do not accept the first happy-path interpretation as complete; verify failure modes, role boundaries, and collateral effects.
- **Zero Decision Fatigue:** Ask one focused decision at a time in dependency order, providing viable options and a recommended default. Never dump open-ended questionnaires.
- **Live Document, Not Transcript:** Capture confirmed goals, target features, and decisions directly in `lifecycle/01-discover.md` after every turn; avoid conversational transcripts.
- **Strict Phase Boundaries (Negative Constraints):**
  - **No UI Design or Visual Flows:** Screen flows, Mermaid sequence diagrams, and interactive prototypes belong to Phase 2 — Flows.
  - **No Technical Architecture or Slices:** Database schemas, API endpoints, file modifications, and task breakdowns belong to Phase 3 — Plan.
  - **No Production Code:** Writing or modifying application source code and running test suites belongs to Phase 4 — Build.
  - **Never Filter Scope Unilaterally:** The agent must never declare features out of scope or not worth doing without explicit user direction during late-stage triage.

## 3. Responsibilities & Sequence

### 3.1 Step 1 — Intake, Fact-Finding & Vocabulary

1. **Adaptive Entry & Problem Framing:**
   - *If brief or fuzzy:* State the apparent underlying objective, highlight the most critical missing context, and ask the root framing question.
   - *If a rough idea:* Separate the core problem from the proposed solution, surface unseen angles, and explore possibilities collaboratively without judging.
   - *If an existing detailed spec:* Skip intake questioning and proceed directly to branch mapping, edge lenses, and trade-off analysis.
   - *Distinguish Problem vs. Solution:* Separate the **Underlying Problem** (what hurts or fails), the **Desired Outcome** (what becomes true), and the **Proposed Solution** (one suggested path to get there). Ensure requirements solve the underlying problem rather than mechanically transcribing a suggested implementation.
2. **Fact-Finding via Codebase Search (Pre-Flight Rule):**
   - For existing workflows, bugs, or feature extensions, use concrete evidence (code search via `grep`, tests, error logs) to discover facts independently before asking questions.
   - Clearly separate the human/business **Problem** (what hurts) from the **Current System** (the technical schema, code seams, and business policies causing it).
   - *Existing Code $\ne$ Desired Behavior:* Codebase search confirms current state, not user intent. Never assume legacy logic or schemas are what the user wants to preserve without confirmation.
   - If a fact can be determined from the repo, verify it yourself; never ask the user for discoverable codebase facts.
3. **Domain Vocabulary Settle (Early Alignment):**
   - Check the project root `GLOSSARY.md` (if present) to reuse established terminology.
   - Settle any new or clarified domain terms (e.g. user roles, session entities, revocation actions) early and record them under `## 1. At a Glance` as **Core Terms**. Pinned vocabulary prevents subtle semantic bugs across downstream phases, and will be promoted to the project's root `GLOSSARY.md` during Phase 5 Finalize. Express all user-facing concepts in simple, everyday English (5th-grade reading standard), strictly avoiding technical or abstract corporate jargon.

### 3.2 Step 2 — Uncover Requirements & Probe Blind Spots

1. **Progressive Requirement Treeing (Depth & Breadth):**
   - **Level 1 (Trunk — At a Glance):** Formulate the core foundation under `## 1. At a Glance` with bold sub-bullet hooks (*The Problem*, *Current System*, *Desired Goal*, *Core Terms*).
   - **Level 2 (Branches — Target Features):** Structure each feature as a distinct top-level bullet (`- **<Feature Name>:**`). Capture all user-requested capabilities without premature filtering.
   - **Level 3 (Leaves — Sub-Features & Acceptance Anchors):** Break down each feature into crisp, atomic sub-bullets using **bold leading hooks** (`- **[Dimension / Hook]:** [Specific requirement detail]`) for instant readability.
   - **Horizontal Breadth (The 5 Edge Lenses):** Probe requirements across all 5 edge dimensions (*Zero State, Validation & Recovery, Permissions & Access, State & Concurrency, Data Lifecycle*).
2. **The Decision Frontier & Anti-Popcorn Rule:**
   - Track open decisions as a tree: Trunk $\to$ Branches $\to$ Leaves. The **Frontier** consists of decisions whose parent prerequisites are confirmed.
   - *Depth-First Branch Continuity:* Stay on the active branch until resolved into a confirmed decision or explicitly parked question; ban jumping randomly across topics.
   - *Cross-Feature Dependency Exception:* If resolving a branch reveals an impact on a shared entity, permission, or state (e.g. user deactivation affecting active sessions, billing, or ownership transfer), immediately identify and note the dependent capability in the requirement tree before resuming depth-first resolution.
3. **Interactive Option Card Pattern:**
   - Present exactly **one** decision per turn (or at most two tightly coupled choices).
   - Search the codebase before asking; if facts exist in code, state them as verified context.
   - Provide 2–3 concrete choices with trade-offs, and offer a recommended default worded so that typing `"yes"` or pressing Enter immediately accepts it:

   ```markdown
   ❓ **Decision Needed: <Short Title>**
   **Context:** <1 sentence of verified facts from codebase search or logs, and the specific uncertainty.>

   - **Option A:** <Description, primary benefit, and key trade-off>
   - **Option B:** <Description, primary benefit, and key trade-off>

   👉 **Recommendation:** <Option A + 1-sentence rationale. Worded so typing "yes" accepts it.>
   ```

4. **Blind-Spot & Self-Challenge Probe:**
   Before considering a feature capability understood, internally probe both functional completeness and resilience blind spots:
   - **Functional Completeness Lenses:**
     - *Trigger & Entry Event:* What exact event, action, or schedule initiates this behavior?
     - *Mandatory vs. Optional Inputs:* What data is strictly required, what has defaults, and what is rejected?
     - *Business Rules & Calculations:* What explicit calculations, state conditions, or policies govern the output?
     - *Downstream Notifications & Recipients:* Who or what must be notified, audited, or synchronized when this occurs?
   - **Resilience Lenses:**
     - *Role & Self Boundaries:* Can actors perform this on themselves or peers (e.g., an administrator deactivating another administrator or self)?
     - *In-Flight State & Sessions:* What happens to active tokens, cached client state, or running background jobs?
     - *Failure Halfway:* What happens if the operation fails midway, network drops, or validation rejects?
     - *Reversibility:* Is this a one-way or two-way door? What are the restoration/rollback rules?
     - *Collateral Impact:* What existing system behaviors or workflows could this unintentionally break?
5. **Continuous Document Update:**
   - Continuously update `lifecycle/01-discover.md` in place after every user turn. Never wait until the end of the phase.

### 3.3 Step 3 — Late-Stage Scope Triage & Document Decisions

1. **User-Owned Scope Triage (Never Filter Early):**
   - Present the full scope of discovered features to the user alongside honest technical trade-offs (effort, complexity, and dependencies).
   - Ask the **User** to triage requirements into three clear buckets:
     - **In Scope:** The essential core to deliver in this lifecycle cycle.
     - **Deferred:** Genuine requirements and ideas that are acknowledged and preserved for future cycles (never lost or deleted).
     - **Out of Scope:** Deliberately excluded items with concise rationale.
   - *Strict Rule:* The User has 100% final authority on priorities. The Agent provides technical trade-offs, but never assumes or filters requirements unilaterally.
2. **Document Edge Cases:**
   Under `## 3. Scope & Edge Cases`, document the 5 essential edge behaviors in plain, non-academic language:
   - **Zero / Empty State:** Behavior on first use, when 0 records exist, or when unconfigured.
   - **Validation & Recovery:** Invalid input handling, timeout/network drops, and user failure recovery.
   - **Permissions & Access:** Who is authorized, resource isolation, and access denied behavior.
   - **State & Concurrency:** Rapid double-submits, debouncing, and conflicting update guards.
   - **Data Lifecycle:** Cascade deletions, retention rules, persistence, and cleanup.
3. **Record Key Decisions (`DEC-X`):**
   In `## 4. Key Decisions & Rationale`, record consequential product or technical decisions (`- **DEC-X (<Topic>):** ...`) along with their rationale and trade-offs.
4. **Handle Non-Blocking Questions:**
   Non-blocking technical investigations are either recorded under `Deferred` in `01-discover.md` or handed off as open investigations for Phase 3 Plan (never left dangling without an owner). Once the Decision Frontier is empty, proceed directly to Section 4 for user approval.

## 4. Exit Gate & Completion Criteria

Phase 1 can transition to Phase 2 — Flows only when the completion checklist is fully satisfied and the user grants explicit approval in chat.

### Completion Checklist (Pre-Flight Gate)

Before requesting user approval, verify that:
- **Evidence-Based Problem:** Grounded in concrete codebase facts (for existing workflows/bugs) or explicit user business goals and constraints (for greenfield capabilities).
- **Trunk Goal:** The Desired Goal clearly defines the intended outcome and preserved boundaries.
- **Domain Terms:** Core Terms (domain vocabulary) are settled under `## 1. At a Glance`.
- **Hierarchical Tree:** Target features and sub-features are structured hierarchically (Trunk $\to$ Branches $\to$ Leaves) without premature filtering.
- **User-Triaged Scope:** Requirements are triaged by the user into **In Scope**, **Deferred**, and **Out of Scope**.
- **Edge Cases:** Documented across all 5 dimensions (Zero State, Validation & Recovery, Permissions & Access, State & Concurrency, Data Lifecycle).
- **Consequential Decisions:** All `DEC-X` decisions are recorded with their reasoning and trade-offs.
- **Resolved High-Impact Uncertainties:** All critical questions (security, authorization, data integrity, session lifecycle) are verified from code facts or confirmed by the user, with zero concealed assumptions.
- **Document Hygiene:** `lifecycle/01-discover.md` is concise, consistent, and up to date.

### Requesting User Approval (Phase 0 Protocol)
1. Update Phase 1 status to `In Review` in `lifecycle/00-status.md`.
2. In chat, output a concise 1–2 sentence summary linking `[01-discover.md](01-discover.md)` and ask for explicit approval to advance to Phase 2 — Flows.
3. Stop calling tools immediately and wait for the user's explicit response.

### Gate Outcomes
- **Approved:** Mark Phase 1 `Done` in `lifecycle/00-status.md` and proceed to Phase 2 — Flows.
- **Changes Requested:** Mark Phase 1 `In Progress`, address feedback, re-verify, and present again.
- **Blocked:** Mark Phase 1 `Blocked` if a strategic unknown or external blocker prevents alignment.

## 5. Phase Output

The final output of Phase 1 is an approved **Discovery document** saved to `lifecycle/01-discover.md`.

### Recommended Structure for `lifecycle/01-discover.md`

```markdown
# Discover: [Requirement / Feature Name]

## 1. At a Glance

- **The Problem:**
  - **[Symptom / Pain 1]:** [What fails, breaks, or is blocked for the user]
  - **[Symptom / Pain 2]:** [Operational, UX, or business friction]
- **Current System:**
  - **[Data Schema / Models]:** [How the current database, collection, or state stores data]
  - **[Code Seam / Watcher]:** [Existing logic or triggers enforcing current behavior]
  - **[Policy Background]:** [Why the system was originally built this way]
- **Desired Goal:**
  - **[Target Outcome 1]:** [What should become true for primary users]
  - **[Scope / Boundary]:** [Key rule or role boundary preserved]
- **Core Terms:**
  - **[Domain Term 1]:** [Crisp definition of key business concept, entity, or role]
  - **[Domain Term 2]:** [Crisp definition of key business concept, entity, or role]

## 2. Target Features

- **[Feature 1 Name]:**
  - **[Key Dimension / Trigger]:** [Specific access rule, entry point, or trigger]
  - **[Expected Behavior / Data]:** [Expected system calculation, storage, or output]
  - **[User Interface / Interaction]:** [Presentation, feedback, or interactive controls]

- **[Feature 2 Name]:**
  - **[Key Dimension / Trigger]:** [Specific access rule, entry point, or trigger]
  - **[Expected Behavior / Data]:** [Expected system calculation, storage, or output]

## 3. Scope & Edge Cases

- **In Scope:**
  - **[Key Deliverable 1]:** [Specific capability, layer touched, or component for this cycle]
  - **[Key Deliverable 2]:** [Verification scope or security boundary]

- **Deferred:**
  - **[Future Feature 1]:** [Acknowledged requirement preserved for future iterations]
  - **[Future Feature 2]:** [Edge enhancement or secondary workflow planned for later]

- **Out of Scope:**
  - **[Excluded Item 1]:** [What will not be modified and concise rationale]
  - **[Excluded Item 2]:** [Untouched existing workflow or explicitly rejected path]

- **Edge Cases:**
  - **Zero / Empty State:** [Behavior on first use, 0 records, or unconfigured state]
  - **Validation & Recovery:** [Invalid input handling, network drop, service failure recovery]
  - **Permissions & Access:** [Role authorization, resource isolation, access denied behavior]
  - **State & Concurrency:** [Rapid double-action, debouncing, optimistic concurrency, conflict resolution]
  - **Data Lifecycle:** [Cascade deletions, retention rules, persistence, and cleanup]

## 4. Key Decisions & Rationale

- **DEC-1 ([Topic]):** [Decision made] — _Rationale / Trade-offs:_ ...
- **DEC-2 ([Topic]):** [Decision made] — _Rationale / Trade-offs:_ ...
```
