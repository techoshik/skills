---
name: lifecycle-discover
description: Explore the problem or opportunity, challenge assumptions, define target features and sub-features, and produce an approved Discovery document (Lifecycle: Phase 1 — Discover).
---

# Phase 1 — Lifecycle Discover

## 1. Purpose

> **Core Mental Model:** Understand the problem. Challenge the assumptions. Define target features. Agree on scope boundaries. Record what we know.

Understand what deserves attention, why it matters, what we want to achieve, and how we will recognize success.

The Agent must explore the initial idea, request, problem, bug, improvement, or opportunity through meaningful discussion and investigation until its underlying purpose and intended outcomes are sufficiently clear.

The goal is to produce a concise, agreed-upon **Discovery document** (`lifecycle/01-discover.md`) that captures the validated problem or opportunity, desired goal, target features and sub-features, important decisions, and scope boundaries.

This phase establishes what we want to achieve, not how we will design or implement it.

## 2. Guiding Principles

- **Understand Before Solving:** Investigate the actual problem, affected users, and root causes before proposing features or solutions.
- **Outcomes Over Implementation:** Define what should become true and what capabilities are needed, not the underlying technical implementation.
- **Evidence Over Guesswork:** Ground existing behavior, bugs, and workflows in concrete code searches (`grep`), error logs, and tests. Facts belong to the Agent; decisions belong to the User.
- **Progressive Treeing over Flat Catalogs:** Structure requirements hierarchically from Goal (trunk) to Target Features (branches) and Sub-features (leaves), covering breadth via the 5 edge lenses.
- **Zero Decision Fatigue:** Ask one focused question at a time in dependency order, providing viable options and a recommended default. Never dump open-ended questionnaires.
- **Live Document, Not Transcript:** Capture confirmed goals, target features, and decisions directly in `lifecycle/01-discover.md`; avoid conversational transcripts.
- **Explicit Scope Boundaries:** Clearly separate what is in scope from what is explicitly out of scope or non-goals.

## 3. Responsibilities & Sequence

### 3.1 Investigate Problem & Current System Through Evidence

- Understand what is broken, missing, or needed, and who is affected.
- For existing workflows, bugs, or feature extensions, use concrete evidence (code search via `grep`, tests, error logs) to discover facts independently rather than asking the user to supply discoverable details.
- Clearly separate the human/business **Problem** (what hurts) from the **Current System** (the technical schema, code seams, and business policies causing it).
- Challenge assumptions: look for unnecessary complexity, duplicate screens or endpoints, and simpler ways to achieve the goal.
- Focus on what needs to be solved, not how to implement it.

### 3.2 Progressive Requirement Treeing (Depth & Breadth)

Instead of a flat catalog of requirements, build a structured requirement tree that captures both **Depth** (vertical fidelity) and **Breadth** (horizontal coverage across the problem space):

#### Vertical Depth (Trunk to Leaves)
1. **Level 1 — At a Glance (Trunk):** Formulate the core foundation under `## 1. At a Glance` using three structured anchor blocks with bold sub-bullet hooks:
   - **The Problem:** Distinct sub-bullets (`- **[Pain / Symptom]:**`) capturing observable user pain and operational friction.
   - **Current System:** Distinct sub-bullets (`- **[Schema / Seam]:**`) capturing existing data schemas, code seams, and historical policies.
   - **Desired Goal:** Distinct sub-bullets (`- **[Outcome / Scope]:**`) capturing target outcomes and preserved system invariants.
2. **Level 2 — Target Features (Branches):** Structure each feature as a distinct top-level bullet (`- **<Feature Name>:**`), avoiding noisy `###` headings to eliminate visual heading fatigue and keep document outlines scannable.
3. **Level 3 — Sub-Features & Acceptance Anchors (Leaves):** Break down each feature into crisp, atomic sub-bullets using **bold leading hooks** (`- **[Dimension / Hook]:** [Specific requirement detail]`) so reviewers can scan criteria in seconds without reading unstructured sentence soup.
4. **Level 4 — Key Decisions & Invariants:** Document critical constraints, trade-offs, and non-negotiables attached to each feature.

#### Horizontal Breadth (The 5 Universal Edge Lenses)
Probe the requirement tree across these 5 essential dimensions and record them directly under `## 3. Scope & Operating Boundaries` as **Operating Invariants (Resilience Boundaries)**:
- **1. Zero / Empty State:** What happens on first use, when 0 records exist, or when unconfigured?
- **2. Validation & Errors:** What constitutes invalid input? How does the user recover from network drops or service errors?
- **3. Permissions & Access:** Who is authorized to view, create, edit, or delete? What happens when access is denied?
- **4. State & Concurrency:** What happens on rapid double-submits, debouncing, or conflicting updates?
- **5. Data Lifecycle:** What are the cascade effects, persistence requirements, audit trails, and cleanup rules?

### 3.3 Focused Questioning Protocol (Eliminating Decision Fatigue)

To keep alignment fast, engaging, and frictionless:

1. **Top-Down Dependency Order:**
   - Always ask questions from **Trunk $\to$ Branches $\to$ Leaves**.
   - Confirm the Problem & Goal first $\to$ align on Target Capabilities & Scope second $\to$ resolve critical edge cases or UX trade-offs third.
   - *Strict Rule:* Never ask detailed leaf/edge-case questions before trunk goals and scope are established.
2. **One Decision at a Time:**
   - Present exactly **one** decision per turn (or at most two tightly coupled choices).
   - Never present a laundry list or questionnaire of open-ended questions.
3. **Interactive Option Card Pattern:**
   State the verified codebase context, provide 2–3 concrete choices with trade-offs, and offer a recommended default worded so that typing `"yes"` or pressing Enter immediately accepts it:

   ```markdown
   ❓ **Decision Needed: <Short Title>**
   **Context:** <1 sentence of verified facts from codebase search or logs, and the specific uncertainty.>

   - **Option A:** <Description, primary benefit, and key trade-off>
   - **Option B:** <Description, primary benefit, and key trade-off>

   👉 **Recommendation:** <Option A + 1-sentence rationale. Worded so typing "yes" accepts it.>
   ```

4. **Update `01-discover.md` Immediately:**
   As each decision is confirmed, immediately record it in `lifecycle/01-discover.md`. Do not wait until the end of the conversation.

### 3.4 Establish Scope & Operating Boundaries

In `## 3. Scope & Operating Boundaries`, use structured bullet blocks with bold leading hooks to maintain visual consistency and outline hygiene (avoiding unnecessary `###` sub-headings):
- **In Scope:** Distinct sub-bullets (`- **[Deliverable / Layer]:**`) defining core implementation, touched layers, and verification scope.
- **Out of Scope / Non-Goals:** Distinct sub-bullets (`- **[Excluded Item]:**`) highlighting explicitly excluded features, deferred functionality, or untouched business workflows with concise reasoning.
- **Operating Invariants (Resilience Boundaries):** Distinct sub-bullets capturing the 5 Universal Edge Lenses: Zero / Empty State, Validation & Recovery, Permissions & Security, State & Concurrency, and Data Lifecycle.

### 3.5 Record Key Decisions & Resolve Blockers

In `## 4. Key Decisions & Rationale`:
- Record consequential product or technical decisions (`- **DEC-X (<Topic>):** ...`) along with their rationale and trade-offs.
- Distinguish between **Blocking Questions** (strategic decisions that materially alter the problem, goal, or scope, which must be resolved with the user now) and **Non-Blocking Questions** (details that can legitimately be explored during Design or Plan).

### 3.6 Maintain `lifecycle/01-discover.md` & Request Approval

- Initialize and update `lifecycle/01-discover.md` continuously as information is confirmed.
- When ready, follow the Phase 0 Chat Approval Protocol to present `lifecycle/01-discover.md` and request approval to proceed to Phase 2 — Flows.

## 4. Completion Criteria

Phase 1 is ready for user approval when:

- The underlying Problem or Opportunity is understood based on concrete evidence.
- The Goal clearly describes the intended outcome (trunk).
- Target features and sub-features are structured hierarchically under `### <Feature Name>` and tested across the 5 breadth lenses (branches & leaves).
- Scope boundaries (In Scope vs. Out of Scope) are explicitly established.
- Consequential decisions are recorded with their reasoning.
- No unresolved blocking questions remain; user decisions were resolved via the Focused Questioning Protocol.
- The Discovery document (`lifecycle/01-discover.md`) is concise, consistent, and understandable.
- The user has reviewed and explicitly approved the document.

## 5. Exit Gate

Phase 1 can transition to Phase 2 — Flows only when:

- All Completion Criteria are satisfied.
- The user has explicitly approved the Discovery document (`lifecycle/01-discover.md`).

### Exit Gate Outcomes

- **Approved:** All completion criteria are satisfied and explicit user approval is granted. Set Phase 1 status to `Done` in `lifecycle/00-status.md` and proceed to Phase 2 — Flows.
- **Changes Requested:** Feedback requires revisions. Update `lifecycle/01-discover.md`, resolve uncertainties, and present it again.
- **Blocked:** A critical blocker, dependency, or unresolved strategic decision remains. Seek the required user input before proceeding.

### Requesting User Approval

Follow the Phase 0 Chat Approval Protocol to present `lifecycle/01-discover.md` and request explicit approval to advance to Phase 2 — Flows.

## 6. Phase Boundary

This section defines the scope and limitations of Phase 1 to prevent performing work that belongs to other phases.

### 6.1 What Belongs to Phase 1 (Discover)

- Understanding the initial request, problem, bug, improvement, or opportunity.
- Investigating the underlying situation and relevant evidence.
- Identifying affected users, workflows, and important consequences.
- Challenging assumptions and discovering missing considerations.
- Establishing the Problem or Opportunity.
- Defining the desired Goal.
- Defining target features and sub-features.
- Identifying important boundaries and constraints.
- Recording confirmed decisions and unresolved blocking questions.
- Maintaining and obtaining approval of `lifecycle/01-discover.md`.

### 6.2 What Does NOT Belong to Phase 1

- Designing detailed user flows or interaction behavior (belongs to Phase 2 — Flows).
- Creating UI prototypes or visual designs (belongs to Phase 2 — Flows).
- Deciding detailed UX or presentation choices (belongs to Phase 2 — Flows).
- Defining technical architecture or database structures (belongs to Phase 3 — Plan).
- Specifying APIs, classes, interfaces, or implementation details (belongs to Phase 3 — Plan).
- Breaking work into development tasks (belongs to Phase 3 — Plan).
- Writing or modifying production code (belongs to Phase 4 — Build).
- Silently deciding on user-owned product preferences or priorities.

## 7. Phase Output

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
  - **[Scope / Invariant]:** [Key rule or role boundary preserved]

## 2. Target Features

- **[Feature 1 Name]:**
  - **[Key Dimension / Trigger]:** [Specific access rule, entry point, or trigger]
  - **[Expected Behavior / Data]:** [Expected system calculation, storage, or output]
  - **[User Interface / Interaction]:** [Presentation, feedback, or interactive controls]

- **[Feature 2 Name]:**
  - **[Key Dimension / Trigger]:** [Specific access rule, entry point, or trigger]
  - **[Expected Behavior / Data]:** [Expected system calculation, storage, or output]

## 3. Scope & Operating Boundaries

- **In Scope:**
  - **[Key Deliverable 1]:** [Specific capability, layer touched, or component]
  - **[Key Deliverable 2]:** [Verification scope or security boundary]

- **Out of Scope / Non-Goals:**
  - **[Excluded Item 1]:** [What will not be modified and concise why]
  - **[Excluded Item 2]:** [Deferred functionality or untouched existing workflow]

- **Operating Invariants (Resilience Boundaries):**
  - **Zero / Empty State:** [Behavior on first use, 0 records, or unconfigured state]
  - **Validation & Recovery:** [Invalid input handling, network drop, service failure recovery]
  - **Permissions & Security:** [Role authorization, resource isolation, access denied behavior]
  - **State & Concurrency:** [Rapid double-action, debouncing, optimistic concurrency, conflict resolution]
  - **Data Lifecycle:** [Cascade deletions, retention rules, persistence, and cleanup]

## 4. Key Decisions & Rationale

- **DEC-1 ([Topic]):** [Decision made] — _Rationale / Trade-offs:_ ...
- **DEC-2 ([Topic]):** [Decision made] — _Rationale / Trade-offs:_ ...
```
