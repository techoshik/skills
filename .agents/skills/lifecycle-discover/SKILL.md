---
name: lifecycle-discover
description: Explore the problem or opportunity, challenge assumptions, define target features and sub-features, and produce an approved Discovery document (Lifecycle: Phase 1 — Discover).
---

# Phase 1 — Lifecycle Discover

## 1. Purpose

> **Core Mental Model:** Every user request is a starting signal, never a complete specification. The agent's job is to surface the full problem space — including dimensions the user has not yet thought of — through exhaustive research, structured probing, and evidence-grounded investigation. No block of requirements may advance until it has been explicitly confirmed by the user in chat.

Explore the initial problem, opportunity, or request through evidence-based investigation until the Decision Frontier is empty (zero unexamined assumptions). The output is an approved **Discovery document** (`lifecycle/01-discover.md`) establishing what to achieve (target features, settled core terms, scope, and edge cases)—not how to design or implement it.

## 2. Guiding Principles

- **Treat Every Request as Incomplete Until Proven Otherwise:** No matter how detailed a request appears, treat it as a starting signal. The agent must independently identify gaps, unstated constraints, implicit assumptions, and overlooked domains before triaging. A request that _sounds_ complete is often the most dangerous — it hides missing edge behaviors behind apparent clarity.
- **Research Before Surfacing (Mandatory Pre-Flight):** Before presenting any finding, decision card, or feature block to the user, the agent MUST conduct exhaustive pre-flight research: (a) search the codebase for every related entity, event, and policy; (b) cross-check related modules and tests; (c) enumerate all plausible interpretations of the request. Only after this pre-flight is complete may the agent surface findings. Never ask the user for a fact that code, logs, or existing documentation can supply.
- **Expansive Exploration First:** Collect and uncover all requirements, possibilities, edge cases, and user desires without premature filtering. Never act as a critic or dismiss ideas in early stages.
- **User-Owned Scope Prioritization:** Triage into *In Scope* vs. *Deferred* occurs late in the phase, and is 100% owned by the user. The agent never assumes, filters, or drops requirements unilaterally.
- **Adaptive Entry Matching User Starting Point:** Meet the user where they start (brief thought, rough idea, or detailed spec) instead of forcing a rigid intake questionnaire.
- **Problem vs. Solution Framing:** Distinguish the underlying problem (what hurts) and desired outcome (what becomes true) from the proposed solution (the user's suggested mechanism). Solve the real problem, not just a suggested symptom.
- **Never Convert Inferences into Requirements:** A plausible inference or reasonable guess is never an established requirement. If not backed by codebase facts or explicit user confirmation, it remains an open question. Every inference must be logged as `ASM-X` in the Assumption Register and explicitly confirmed by the user before it may be treated as a requirement.
- **Mandatory Assumption Register (Temporary Inbox inside `## 0. Research Summary`):** Resolve any codebase-answerable questions yourself during research and record them under `**Verified Facts:**`. Only log inferences that require the user's judgment in `**Open Assumptions:**` inside `## 0. Research Summary`, using this scannable sub-bullet format:
  ```
  - **ASM-N — [Short Topic Title]**
    - **Assumption:** [What was assumed]
    - **Basis:** [Why this was inferred, not confirmed]
    - **Status:** Ready to ask / Waiting on ASM-X
  ```
  - **Readiness Rule:** Ask assumptions whose `Status` is `Ready to ask` immediately as `❓ Decision Needed` cards. Keep blocked assumptions (`Waiting on ASM-X`) in `**Open Assumptions:**` in `## 0` until their dependency resolves.
  - **Move-and-Clear Lifecycle:** `**Open Assumptions:**` is a temporary queue, not a permanent log. Once an assumption is confirmed, promote it to `## 4. Key Decisions & Rationale` (`DEC-N`) or `## 2. Target Features` and **remove** the `ASM-N` item from `## 0`. If rejected, remove it from `## 0` (recording a `DEC-N` or `Out of Scope` entry if the rejection rationale matters later). Keep the `**Open Assumptions:**` heading in place and set its value to `- None.` once all items are cleared.
- **Domain Vocabulary Settle:** Pin exact domain concepts and terms early so everyone speaks the exact same language from Day 1.
- **Evidence Over Guesswork — Zero Tolerance:** Ground existing behavior, bugs, and workflows in concrete code searches (`grep`), error logs, and tests. Facts belong to the Agent; decisions belong to the User. Existing code proves how the system *currently behaves*, never what the user *wants*; never assume legacy implementation represents desired requirements. When evidence is missing, the agent must state: "I could not confirm this from the codebase — logging it as ASM-X for your review" and never proceed on the unconfirmed assumption.
- **The Decision Frontier & Risk Priority:** Map open decisions whose prerequisites are confirmed. Prioritize high-impact uncertainties (security, permissions, data integrity, session lifecycle) over low-impact cosmetic choices; exit only when the frontier is empty.
- **Depth-First Continuity (Anti-Popcorn Rule):** Resolve one branch deeply before moving to another; ban jumping randomly across unrelated topics on consecutive turns.
- **Self-Challenge Before Settling:** Actively probe for blind spots. Do not accept the first happy-path interpretation as complete; verify failure modes, role boundaries, and collateral effects.
- **Zero Decision Fatigue — No Silent Assumptions:** Ask one focused decision at a time in dependency order, providing viable options and a recommended default. The recommended default is a _suggestion_, never a decision: even a `"yes"` or Enter from the user counts as an explicit confirmation of that specific option only — it never grants permission to advance unrelated or unchosen assumptions. Never dump open-ended questionnaires.
- **Warm Collaborative Tone (Anti-Interrogation Rule):** Discovery conversations must feel like a thoughtful colleague exploring a problem together — not an audit or a form to fill in. Concretely:
  - **One human question per turn:** Never ask more than one question at a time, even when multiple are ready. The user's answer to one question frequently renders others unnecessary.
  - **Show your thinking before asking:** Before asking a question, briefly share what you found and why the question matters ("I found X in the codebase, which means Y — I'm unsure whether you want to preserve that or change it"). Users answer better when they understand the context.
  - **Acknowledge before advancing:** After a user answers, reflect the answer back in one sentence ("Got it — so the session token should expire immediately on logout, not lazily") before moving to the next question. This confirms understanding and builds trust.
  - **Never use corporate or technical jargon in user-facing questions.** Ask in the same language the user used. If they said "users can't log out properly", don't ask about "session revocation lifecycle events."
  - **For fuzzy or emotional requests:** Lead with empathy before structure. "It sounds like this is causing real friction for your users — let's make sure we understand the full picture before deciding anything." Then ask the single most important clarifying question.
- **Live Document, Not Transcript:** Capture confirmed goals, target features, and decisions directly in `lifecycle/01-discover.md` after every turn; avoid conversational transcripts.
- **Strict Phase Boundaries (Negative Constraints):**
  - **No UI Design or Visual Flows:** Screen flows, Mermaid sequence diagrams, and interactive prototypes belong to Phase 2 — Design.
  - **No Technical Architecture or Slices:** Database schemas, API endpoints, file modifications, and task breakdowns belong to Phase 3 — Plan.
  - **No Production Code:** Writing or modifying application source code and running test suites belongs to Phase 4 — Build.
  - **Never Filter Scope Unilaterally:** The agent must never declare features out of scope or not worth doing without explicit user direction during late-stage triage.

## 3. Responsibilities & Sequence

### 3.1 Step 1 — Intake, Fact-Finding & Vocabulary

> **Standing Rule — Live Document:** Update `lifecycle/01-discover.md` in place after every agent turn throughout Steps 1, 2, and 3. Never batch updates to the end of a step.

> **Standing Rule — Friction Logging:** Whenever a skill instruction is ambiguous, a tool forces an unintended workaround, or a workflow step causes unnecessary back-and-forth during discovery, immediately append an entry to `lifecycle/refine.md`. Do not wait until phase exit. If `lifecycle/refine.md` does not yet exist, create it using the standard structure from the lifecycle orchestrator skill.

> **Standing Rule — Session Resumption:** At the start of every agent session, before taking any action, check whether `lifecycle/01-discover.md` already exists and contains content.
> - **If resuming (file exists):** Load the document as the working map. Re-read the **Goal** statement aloud in chat ("Resuming discovery — our goal is: [X]"). Scan `**Open Assumptions:**` in `## 0. Research Summary` for any unresolved `ASM-N` items and identify the current Decision Frontier position (the last confirmed branch). Ask the user: "Shall we continue from [last open branch], or is there anything that has changed since we last spoke?" Do not restart the intake process.
> - **If new session (file absent or empty):** Proceed normally with Step 1 below.

1. **Adaptive Entry & Problem Framing (Classify the Request First):**
   Read and classify the incoming request before doing anything else. This determines how much is already known vs. must be researched.
   - *If brief or fuzzy:* State the apparent underlying objective, highlight the most critical missing context, and ask the single root framing question that unlocks the most unknowns.
   - *If a rough idea:* Separate the core problem from the proposed solution, surface unseen angles, and explore possibilities collaboratively without judging.
   - *If an existing detailed spec:* Do NOT skip intake. Treat the detailed spec as a rich starting point and independently verify every stated assumption, identify what is _not_ stated (missing states, missing roles, missing failure modes), and surface gaps the spec author may not have considered. A detailed spec shifts the probe effort from "what do you want?" to "is this complete and correct?"
   - *Distinguish Problem vs. Solution:* Separate the **Underlying Problem** (what hurts or fails), the **Desired Outcome** (what becomes true), and the **Proposed Solution** (one suggested path to get there). Ensure requirements solve the underlying problem rather than mechanically transcribing a suggested implementation.
2. **Name the Goal (Before Any Research or Vocabulary Work):**
   The goal is the first committed output of this phase. It anchors every subsequent scoping decision — what goes In Scope, Deferred, or Out of Scope is tested against it.
   - Produce a **single 1–2 line outcome statement** and write it into `## 1. At a Glance` as `**Goal:** [What becomes true for users once built — e.g. "Users can log out from any device and all active sessions are immediately invalidated"]`. Never list features here; feature details belong in `## 2. Target Features`.
   - If brief or fuzzy: state the most plausible goal as a hypothesis and ask the user to confirm or correct it in one sentence before proceeding to research.
   - If a detailed spec: extract the core outcome from the spec and write it explicitly.
   - *Rule:* No item may be declared Out of Scope or Deferred unless it has first been tested against the Goal.
3. **Domain Vocabulary Settle (Before Research Begins):**
   Pin core terms *before* codebase search so that all research, findings, and documents use agreed-upon language from the start.
   - Read the project root `GLOSSARY.md` to reuse established terminology (if it does not exist yet, initialize it or create it in Phase 5 Close).
   - Identify and settle key domain concepts (e.g. user roles, session entities, state transitions, revocation actions) apparent from the request and record them under `## 1. At a Glance` as **Core Terms**.
   - Express all user-facing concepts in simple, everyday English (5th-grade reading standard), strictly avoiding technical or abstract corporate jargon.
   - Terms may be refined during codebase search (step 4) if the code reveals a different or more precise concept; update `Core Terms` accordingly.
4. **Fact-Finding (Evidence Gathering — Two Tracks):**
   Conduct the full research pass using the pinned vocabulary from step 3. Apply the correct track based on whether a codebase exists.

   **Track A — Existing Codebase:**
   - Use concrete evidence (code search via `grep`, tests, error logs) to discover facts independently before asking questions.
   - Clearly separate the human/business **Problem** (what hurts) from the **Current System** (the technical schema, code seams, and business policies causing it).
   - *Existing Code $\ne$ Desired Behavior:* Codebase search confirms current state, not user intent. Never assume legacy logic or schemas are what the user wants to preserve without confirmation.
   - If a fact can be determined from the repo, verify it yourself; never ask the user for discoverable codebase facts.

   **Track B — Greenfield (No Codebase):**
   Greenfield requests have no code to grep — but they are not fact-free. The agent must substitute structured domain research with equal rigor:
   - **User Goals & Constraints:** Extract every explicit goal, constraint, non-negotiable, and anti-goal the user has stated. Record each as a Verified Fact (source: "user stated in [turn X]").
   - **Comparable Domain Patterns:** Identify 2–3 well-understood systems or patterns in the same domain (e.g. "auth flows in SaaS products", "pagination conventions in REST APIs"). Note which patterns are relevant to the destination and why — these form the baseline for sensible defaults.
   - **Implicit Industry Constraints:** Research known constraints the domain imposes regardless of user preference (e.g. OAuth token lifetimes, GDPR retention rules, mobile platform push notification limits). Record each as a Verified Fact with its source.
   - **Technology & Integration Constraints:** If a tech stack has been mentioned or implied, research its known limitations, conventions, and sharp edges relevant to the destination. Record findings; mark gaps as ASM-X.
   - **What "Current System" Means for Greenfield:** For a greenfield project, the "Current System" section documents the *absence* of a system: what manual process, workaround, or competing tool the user currently uses, and what its pain points are. Never leave "Current System" blank on a greenfield request — there is always a status quo.
   - *Greenfield ≠ Assumption-Free:* Greenfield requests often carry the most hidden assumptions, because nothing in code exists to contradict them. The Assumption Register (step 5) is especially critical on greenfield work.
5. **Mandatory Research Summary (Populate After Search, Surface Before Questions):**
   Only after steps 1–4 are complete, document the research output in `## 0. Research Summary` of `lifecycle/01-discover.md`. `## 0` must include:
   - **Verified Facts (Permanent):** Concrete things confirmed from codebase, logs, or referenced docs (cite file + line or source).
   - **Open Assumptions (Temporary Queue):** User-facing inferences logged as `ASM-N` sub-bullets (cleared to `- None.` once resolved into `## 2`, `## 3`, or `## 4`).
   - **Identified Gaps (Temporary Queue):** Dimensions of the request not yet addressed by any evidence (cleared to `- None.` once converted to `ASM-N`, `## 2`, `## 3`, or `## 4`).
   - **High-Risk Unknowns (Temporary Queue):** Questions where the wrong assumption could cause security, data integrity, or UX failures (cleared to `- None.` once resolved into `ASM-N` / `DEC-N`).
   Only after `## 0` is populated may the agent begin presenting findings or decision cards to the user.

### 3.2 Step 2 — Uncover Requirements & Probe Blind Spots

1. **Breadth-First Surface Map (Before Any Depth-First Probing):**
   Before going deep on any single feature or question, fan out breadth-first across the *entire* problem space. This surfaces unknown unknowns — features, roles, states, integrations, constraints — that depth-first probing on any single branch would miss entirely.
   - Scan the full request (and codebase if applicable) and list *every* dimension at the surface level: candidate features, actors/roles, system states, external integrations, implicit constraints, and open questions — without resolving any of them yet.
   - Write these as **stub entries** under `## 2. Target Features` (feature name + one-line description only). No sub-features, no edge probing yet.
   - Review the stub list against the Goal. Anything clearly beyond the goal → flag as `Out of Scope`.
   - Only after the full surface map is complete does depth-first probing of individual branches begin (item 2 below).
   - *Anti-tunnel Rule:* If depth-first probing on any branch reveals a new surface dimension not yet in the stub list, pause, add it to the surface map, and re-check against the Goal before continuing depth probing.

2. **Progressive Requirement Treeing (Depth & Breadth):**
   - **Level 1 (Trunk — At a Glance):** Formulate the core foundation under `## 1. At a Glance` with a 1–2 line `**Goal:**` and bold paragraph headers (*The Problem*, *Current System*, *Core Terms*) followed by flat, single-level bullets.
   - **Level 2 (Branches — Target Features):** Write each feature as a level-3 heading with an `F-N` prefix (`### F1 — Feature Name`) so it appears in document outlines and matches `02-design.md` and `03-plan.md`. Capture all user-requested capabilities without premature filtering.
   - **Level 3 — Feature Items (`F1.1`, `F1.2`... — Mandatory, Concrete, Complete):** Directly under `### F1 — Feature Name`, produce a flat, plain-English list of numbered items (`- **F1.1:** ...`, `- **F1.2:** ...`) covering **every element, action, interaction, state, and navigation** the feature must contain. Each item must be specific enough that a developer can derive a build task directly from it — if an item is too vague to generate a task, split it into more specific items. These `F1.x` items are the single source of truth for what the feature contains; they must be confirmed by the user during Discovery and must not change between phases without an explicit scope decision.
     - Examples of **too vague** (never acceptable): `- User can manage the list`, `- Filter options available`
     - Examples of **concrete** (required level): `- Role dropdown filter with options: Admin, Editor, Viewer`, `- Search by username text input`, `- Active / Inactive status dropdown`, `- Edit action button on each user card`, `- Delete action button on each user card`, `- Tapping a user card navigates to User Detail screen`
   - **Horizontal Breadth (Mandatory 5 Edge Lenses — Inline per Feature):** Cover ALL 5 edge dimensions (*Zero State, Validation & Recovery, Permissions & Access, State & Concurrency, Data Lifecycle*) for every feature **inside that feature's block** (not in a separate section). Each lens must produce at least one confirmed finding or an explicit "not applicable — rationale" entry. A feature may not be promoted to `In Scope` until all 5 lenses are addressed.
3. **The Decision Frontier, Unblocking & Anti-Popcorn Rule:**
   - Track open decisions as a tree: Trunk $\to$ Branches $\to$ Leaves. The **Frontier** consists of decisions whose parent prerequisites are confirmed.
   - *Depth-First Branch Continuity:* Stay on the active branch until resolved into a confirmed decision or explicitly parked question; ban jumping randomly across topics.
   - *Cross-Feature Dependency Exception:* If resolving a branch reveals an impact on a shared entity, permission, or state (e.g. user deactivation affecting active sessions, billing, or ownership transfer), immediately identify and note the dependent capability in the requirement tree before resuming depth-first resolution.
   - **Unblocking Trigger (mandatory after every ASM-X resolution):** Immediately after any `ASM-X` entry is resolved, pause and scan `**Open Assumptions:**` in `## 0` for any `Waiting on ASM-X` entries that are now unblocked. Update their `Status` to `Ready to ask` and surface them immediately as `❓ Decision Needed` cards so no blocked item sits stale.
4. **Interactive Option Card Pattern:**
   - Present exactly **one** decision per turn (or at most two tightly coupled choices).
   - Search the codebase before asking; if facts exist in code, state them as verified context, and never ask the user a question that can be answered from the codebase.
   - Provide 2–3 concrete choices with trade-offs, and offer a recommended default. The recommended default is a _suggestion only_ — it must receive explicit user acknowledgment before being treated as a confirmed decision. Never carry a recommendation forward without an explicit user response in chat:

   ```markdown
   ❓ **Decision Needed: <Short Title>**
   **Context:** <1 sentence of verified facts from codebase search or logs, and the specific uncertainty.>

   - **Option A:** <Description, primary benefit, and key trade-off>
   - **Option B:** <Description, primary benefit, and key trade-off>

   👉 **Recommendation:** <Option A + 1-sentence rationale.>
   ```

5. **Blind-Spot & Self-Challenge Probe (with Inline Contradiction Surfacing):**
   Before considering a feature capability understood, internally probe all functional completeness, resilience, and extended lenses. **If any lens reveals a contradiction between the user's stated intent and existing system behavior, surface it immediately as a `❗ Conflict Found` card** (see format below) and pause depth-first probing on that branch until the user resolves the conflict. Never silently pick one side of a contradiction and continue.

   ```markdown
   ❗ **Conflict Found: <Short Title>**
   **What You Asked:** <User's intent>
   **What the System Currently Does:** <Evidence from codebase — cite file:line>
   **Why These Conflict:** <1–2 sentence explanation>

   Please clarify which behavior should win, or whether a migration/transition approach is needed.
   ```

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
   - **Extended Discovery Lenses (apply to every feature branch):**
     - *External Dependency:* Does this feature depend on a third-party API, service, or platform? What happens if that dependency is unavailable, rate-limited, or returns unexpected data?
     - *Rollout & Migration:* Is there existing data, users, or state that this change affects retroactively? What is the migration or backward-compatibility strategy?
     - *Observability:* How will the team know if this feature is working correctly in production? What logging, monitoring, or alerting does it require?
     - *Internationalization & Locale:* Does this feature involve user-visible text, dates, currencies, or time zones that must behave differently across locales?

### 3.3 Step 3 — Late-Stage Scope Triage & Document Decisions

1. **User-Owned Scope Triage (After Full Picture is Visible):**
   Before presenting scope options to the user, verify all 5 edge-case lenses are documented inside each feature in `## 2. Target Features` and all `Open Assumptions` are resolved. Since `## 2. Target Features` already lists everything we are building now, `## 3. Deferred & Out of Scope` holds only **two** excluded buckets. Before proposing any item as Out of Scope, run the **Goal Check**: *"Does this item sit beyond the stated Goal?"*

   - **Deferred:** Items the user reviewed and chose to save for a later cycle. Never delete them — they are copied to `docs/modules/<module>/README.md` (`Deferred (Future Backlog)`) during Phase 5 Close.
   - **Out of Scope:** Items that sit *beyond the stated Goal*, with a short plain-English reason.
   - *Strict Rules:*
     - The User has 100% final authority on all triage decisions.
     - Before proposing any item as Out of Scope, the agent must verify it sits beyond the Goal, not merely that it's unknown or complex.
2. **Record Key Decisions (`DEC-X`):**
   In `## 4. Key Decisions & Rationale`, record each consequential decision using this format — the title line has **no bullet**, and the detail + rationale appear as sub-bullets on separate lines:
   ```
   **DEC-N — Topic Title**
   - [The decision made and what it means]
   - _Rationale:_ [Why this option was chosen and what trade-offs were accepted]
   ```
   > **Note:** `01-discover.md` is the single home for ALL decisions across the lifecycle. If Phase 2 — Design uncovers a new decision during flow modeling or prototyping, it is recorded here as `DEC-N`, not in `02-design.md`. The Discover document is updated in place and remains the source of truth.
3. **Handle Non-Blocking Questions:**
   Non-blocking technical investigations are either recorded under `Deferred` in `01-discover.md` or handed off as open investigations for Phase 3 Plan (never left dangling without an owner). Once the Decision Frontier is empty, proceed directly to Section 4 for user approval.

## 4. Exit Gate & Completion Criteria

Phase 1 can transition to Phase 2 — Design only when the completion checklist is fully satisfied and the user grants explicit approval in chat.

### Completion Checklist (Pre-Flight Gate)

Before requesting user approval, verify that:
- **Goal Confirmed:** A 1–2 line outcome-focused `**Goal:**` (without feature details) is recorded in `## 1. At a Glance` and acknowledged by the user. All scope decisions reference it.
- **Evidence-Based Problem:** Grounded in concrete codebase facts (for existing workflows/bugs) or explicit user business goals and constraints (for greenfield capabilities).
- **Domain Terms:** Core Terms (domain vocabulary) are settled under `## 1. At a Glance`.
- **No Codebase-Answerable Questions Asked:** Every fact answerable from the repo or docs was resolved by the agent and logged under `**Verified Facts:**`.
- **No Unclear Items in Triage:** Every item in `Deferred` or `Out of Scope` was clearly defined before the user triaged it.

- **Hierarchical Tree:** Target features and sub-features are structured hierarchically (Trunk $\to$ Branches $\to$ Leaves) without premature filtering.
- **User-Triaged Scope:** Features to build now are confirmed in `## 2. Target Features`, and remaining items are triaged into **Deferred** or **Out of Scope** in `## 3. Deferred & Out of Scope`.
- **Edge Cases:** Documented across all 5 dimensions (Zero State, Validation & Recovery, Permissions & Access, State & Concurrency, Data Lifecycle).
- **Consequential Decisions:** All `DEC-X` decisions are recorded with their reasoning and trade-offs.
- **Internal Consistency (`§2` vs. `§4`):** No `DEC-X` decision contradicts any `F-N.x` item or `F-N-Ex` Edge Case bullet in `## 2. Target Features`.
- **Resolved High-Impact Uncertainties:** All critical questions (security, authorization, data integrity, session lifecycle) are verified from code facts or confirmed by the user, with zero concealed assumptions.
- **Research Inbox Cleared (`## 0`):** Every item in `**Open Assumptions:**`, `**Identified Gaps:**`, and `**High-Risk Unknowns:**` has been resolved into `## 2`, `## 3`, or `## 4`, leaving each of those three headings set to `- None.` at exit-gate review.
- **Block-Level Confirmation:** At least once during the discovery phase, the agent presented the current state of `lifecycle/01-discover.md` to the user and received explicit per-feature-block confirmation before requesting final approval.
- **Document Hygiene:** `lifecycle/01-discover.md` is concise, follows the global Scannable Bullets rule (one fact/rule per bullet), and is up to date.

### Requesting User Approval (Phase 0 Protocol)
1. Update Phase 1 status to `In Review` in `lifecycle/00-status.md`.
2. Ensure each major feature block in `lifecycle/01-discover.md` was explicitly confirmed during discovery, then output a concise 1–2 sentence summary linking `[01-discover.md](01-discover.md)` and ask for explicit approval to advance to Phase 2 — Design.
3. Stop calling tools immediately and wait for the user's explicit response.

### Gate Outcomes
- **Approved:** Mark Phase 1 `Done` in `lifecycle/00-status.md` and proceed to Phase 2 — Design.
- **Changes Requested:** Mark Phase 1 `In Progress`, address feedback, re-verify, and present again.
- **Blocked:** Mark Phase 1 `Blocked` if a strategic unknown or external blocker prevents alignment.

## 5. Phase Output

The final output of Phase 1 is an approved **Discovery document** saved to `lifecycle/01-discover.md`.

### Recommended Structure for `lifecycle/01-discover.md`

```markdown
# Discover: [Requirement / Feature Name]

## 0. Research Summary

**Verified Facts:**
- **`[file:line or source]`**
  - [One short confirmed fact]
  - [Second confirmed fact from this source, if any]

**Open Assumptions:** *(replace items with `- None.` once resolved into §2/§3/§4)*
- **ASM-1 — [Short Topic Title]**
  - **Assumption:** [What was assumed]
  - **Basis:** [Why inferred, not confirmed]
  - **Status:** Ready to ask *(or "Waiting on ASM-X")*

**Identified Gaps:** *(replace items with `- None.` once resolved)*
- [Dimension not yet addressed by any evidence]

**High-Risk Unknowns:** *(replace items with `- None.` once resolved)*
- [Question whose wrong answer could cause security / data integrity / UX failure]

## 1. At a Glance

**Goal:** [1–2 short lines in plain English describing what users can do once built — no feature list here]

**The Problem:**
- **[Short Label]:** [One short sentence explaining what breaks or hurts today]
- **[Short Label]:** [One short sentence explaining operational or user friction]

**Current System:**
- **[Area / Layer]:** [One short fact about how it works today]
- **[Area / Layer]:** [Second short fact, if needed]

**Core Terms:**
- **[Term 1]:** [Simple, everyday definition]
- **[Term 2]:** [Simple, everyday definition]

## 2. Target Features

### F1 — [Feature 1 Name]

- **F1.1:** [One UI element, action, or navigation per line — e.g. "Role filter dropdown: Admin, Editor, Viewer"]
- **F1.2:** [e.g. "Search box to filter by username"]
- **F1.3:** [e.g. "Edit and Delete buttons on each user card"]
- **F1.4:** [e.g. "Tapping a card opens the User Detail screen"]
- **Edge Cases:**
  - **F1-E1 (Zero / Empty State):** [Short plain-English note on what shows when empty]
  - **F1-E2 (Validation & Recovery):**
    - [One input rule or error message per sub-bullet]
    - [One retry or recovery path per sub-bullet]
  - **F1-E3 (Permissions & Access):** [Who can view or act, in plain English]
  - **F1-E4 (State & Concurrency):** [Double-tap, loading lock, or conflict rule]
  - **F1-E5 (Data Lifecycle):** [What is saved, updated, or deleted]

### F2 — [Feature 2 Name]

- **F2.1:** [One element or action per line]
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
- [What was decided, in 1–2 short plain-English bullets]
- _Rationale:_ [Why this choice was made, in ≤ 20 words]
```
