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
- **Mandatory Assumption Register (with Sharpness & HITL/AFK Classification):** Every inference, guess, or plausible-but-unconfirmed belief must be recorded in `## 5. Open Assumptions` with two mandatory tags:
  - **Sharpness:** `[Sharp]` if the question can be precisely stated right now (even if unanswerable yet) → surface immediately as a `❓ Decision Needed` card to the user. `[Foggy]` if it cannot yet be precisely phrased because upstream decisions are still open → record in `Fog (Not Yet Specifiable)` and do NOT ask the user yet; it graduates to Sharp as the Decision Frontier advances.
  - **Resolution Owner:** `[HITL]` if only the user can resolve it (business intent, priority judgment, domain authority) → must be surfaced as a user question. `[AFK]` if the agent can resolve it independently through codebase search, documentation, or tooling → agent must resolve it without asking the user.
  - **Format:** Each `ASM-X` entry uses three lines — no bullet on the title line, details and status as sub-bullets:
    ```
    **ASM-N (Topic) [Sharp/Foggy] [HITL/AFK]:** [The assumption]
    - _Basis:_ [Why this was inferred, not confirmed]
    - _Status:_ ⚠️ Pending / ✅ Confirmed / ❌ Rejected
    ```
  - **Relationship to `## 0. Research Summary`:** The Research Summary is the *inbox* — raw inferences captured during fact-finding, written as evidence narrative. `## 5. Open Assumptions` is the *action register* — structured, tagged, and tracked to resolution. Every inference from `## 0` must be immediately promoted to an `ASM-X` entry in `## 5`. The two sections mirror each other but serve different purposes: one is evidence record, the other is resolution tracker.
  - An assumption register may never be empty on the first pass of a non-trivial request. No assumption may be promoted to a requirement until its sharpness is confirmed and it has been explicitly resolved (HITL: user confirms; AFK: agent verifies).
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
> - **If resuming (file exists):** Load the document as the working map. Re-read the **Destination** statement aloud in chat ("Resuming discovery — our destination is: [X]"). Scan `## 5. Open Assumptions` for any `⚠️ Pending` items and identify the current Decision Frontier position (the last confirmed branch). Ask the user: "Shall we continue from [last open branch], or is there anything that has changed since we last spoke?" Do not restart the intake process.
> - **If new session (file absent or empty):** Proceed normally with Step 1 below.

1. **Adaptive Entry & Problem Framing (Classify the Request First):**
   Read and classify the incoming request before doing anything else. This determines how much is already known vs. must be researched.
   - *If brief or fuzzy:* State the apparent underlying objective, highlight the most critical missing context, and ask the single root framing question that unlocks the most unknowns.
   - *If a rough idea:* Separate the core problem from the proposed solution, surface unseen angles, and explore possibilities collaboratively without judging.
   - *If an existing detailed spec:* Do NOT skip intake. Treat the detailed spec as a rich starting point and independently verify every stated assumption, identify what is _not_ stated (missing states, missing roles, missing failure modes), and surface gaps the spec author may not have considered. A detailed spec shifts the probe effort from "what do you want?" to "is this complete and correct?"
   - *Distinguish Problem vs. Solution:* Separate the **Underlying Problem** (what hurts or fails), the **Desired Outcome** (what becomes true), and the **Proposed Solution** (one suggested path to get there). Ensure requirements solve the underlying problem rather than mechanically transcribing a suggested implementation.
2. **Name the Destination (Before Any Research or Vocabulary Work):**
   The destination is the first committed output of this phase. It anchors every subsequent scoping decision — what goes In Scope, what is Fog, and what is Out of Scope are all defined relative to it.
   - Produce a 1–2 line **Destination Statement** and write it into `## 1. At a Glance` as `**Destination:** [What reaching the end of this discovery looks like — the approved feature, resolved problem, or confirmed change]`.
   - **Destination vs. Desired Goal — Key Distinction:** The *Destination* is the exit condition for Phase 1 — it describes what a successfully completed Discovery looks like (e.g. "An approved discovery doc covering user logout with session revocation"). The *Desired Goal* (also in `## 1. At a Glance`) describes what the product/feature must achieve for users once built (e.g. "Users can log out from any device and all active sessions are immediately invalidated"). The Destination tells the agent when to leave Phase 1; the Desired Goal tells Phase 4 — Build what to deliver.
   - If brief or fuzzy: state the most plausible destination as a hypothesis and ask the user to confirm or correct it in one sentence. Do not proceed to research until the destination is acknowledged.
   - If a detailed spec: extract the destination from the spec's stated goal and write it explicitly. Even if obvious, naming it creates a shared anchor.
   - *Rule:* No item may be declared Out of Scope, Deferred, or Fog unless it has first been tested against the destination. The destination is the boundary — not the agent's judgment.
3. **Domain Vocabulary Settle (Before Research Begins):**
   Pin core terms *before* codebase search so that all research, findings, and documents use agreed-upon language from the start.
   - Check the project root `GLOSSARY.md` (if present) to reuse established terminology.
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
   Only after steps 1–4 are complete, document the research output in `## 0. Research Summary` of `lifecycle/01-discover.md`. This block must include:
   - **Verified Facts:** Concrete things confirmed from codebase, logs, or referenced docs (cite file + line or source).
   - **Plausible Inferences (→ Open Assumptions):** Things deduced but not confirmed — each promoted immediately to an `ASM-X` entry in `## 5. Open Assumptions`.
   - **Identified Gaps:** Dimensions of the request not yet addressed by any evidence.
   - **High-Risk Unknowns:** Questions where the wrong assumption could cause security, data integrity, or UX failures.
   Only after this block is populated may the agent begin presenting findings or decision cards to the user.

### 3.2 Step 2 — Uncover Requirements & Probe Blind Spots

1. **Breadth-First Surface Map (Before Any Depth-First Probing):**
   Before going deep on any single feature or question, fan out breadth-first across the *entire* problem space. This surfaces unknown unknowns — features, roles, states, integrations, constraints — that depth-first probing on any single branch would miss entirely.
   - Scan the full request (and codebase if applicable) and list *every* dimension at the surface level: candidate features, actors/roles, system states, external integrations, implicit constraints, and open questions — without resolving any of them yet.
   - Write these as **stub entries** under `## 2. Target Features` (feature name + one-line description only). No sub-features, no edge probing yet.
   - Review the stub list against the Destination Statement. Anything clearly beyond the destination → flag immediately as `Out of Scope (Beyond Destination)`. Anything that can be felt but not yet precisely stated → flag as `Fog (Not Yet Specifiable)`.
   - Only after the full surface map is complete does depth-first probing of individual branches begin (item 2 below).
   - *Anti-tunnel Rule:* If depth-first probing on any branch reveals a new surface dimension not yet in the stub list, pause, add it to the surface map, and re-check against the destination before continuing depth probing.

2. **Progressive Requirement Treeing (Depth & Breadth):**
   - **Level 1 (Trunk — At a Glance):** Formulate the core foundation under `## 1. At a Glance` with bold paragraph headers (*The Problem*, *Current System*, *Desired Goal*, *Core Terms*) followed by flat, single-level bullets.
   - **Level 2 (Branches — Target Features):** List each feature as a bold bullet with an `F-N` prefix — no heading, no leading bullet on the name line itself, just bold text (e.g. `**F1 — Feature Name**`). Capture all user-requested capabilities without premature filtering. Under each feature, produce a **Feature Includes list** (see rule below) followed by the five edge-case lenses.
   - **Level 3 — Feature Includes List (Mandatory, Concrete, Complete):** For every feature, produce a flat, plain-English list of **every element, action, interaction, state, and navigation** the feature must contain. Each bullet must be specific enough that a developer can derive a build task directly from it — if a bullet is too vague to generate a task, it must be split into more specific bullets. This list is the single source of truth for what the feature includes; it must be confirmed by the user during Discovery and must not change between phases without an explicit scope decision.
     - Examples of **too vague** (never acceptable): `- User can manage the list`, `- Filter options available`
     - Examples of **concrete** (required level): `- Role dropdown filter with options: Admin, Editor, Viewer`, `- Search by username text input`, `- Active / Inactive status dropdown`, `- Edit action button on each user card`, `- Delete action button on each user card`, `- Tapping a user card navigates to User Detail screen`
   - **Horizontal Breadth (Mandatory 5 Edge Lenses — Inline per Feature):** Cover ALL 5 edge dimensions (*Zero State, Validation & Recovery, Permissions & Access, State & Concurrency, Data Lifecycle*) for every feature **inside that feature's block** (not in a separate section). Each lens must produce at least one confirmed finding or an explicit "not applicable — rationale" entry. A feature may not be promoted to `In Scope` until all 5 lenses are addressed.
3. **The Decision Frontier, Fog Graduation & Anti-Popcorn Rule:**
   - Track open decisions as a tree: Trunk $\to$ Branches $\to$ Leaves. The **Frontier** consists of decisions whose parent prerequisites are confirmed.
   - *Depth-First Branch Continuity:* Stay on the active branch until resolved into a confirmed decision or explicitly parked question; ban jumping randomly across topics.
   - *Cross-Feature Dependency Exception:* If resolving a branch reveals an impact on a shared entity, permission, or state (e.g. user deactivation affecting active sessions, billing, or ownership transfer), immediately identify and note the dependent capability in the requirement tree before resuming depth-first resolution.
   - **Fog Graduation Trigger (mandatory after every ASM-X resolution):** Immediately after any `ASM-X` entry is resolved (HITL confirmed by user OR AFK verified by agent), the agent MUST pause and scan `## 5. Open Assumptions` for any `🌫 In Fog` entries whose graduation condition is now met. For each one that can now be precisely stated:
     1. Change its tag from `[Foggy]` to `[Sharp]`.
     2. Update its Status from `🌫 In Fog` to `⚠️ Pending`.
     3. Remove it from the `Fog (Not Yet Specifiable)` bucket in `## 3`.
     4. Surface it immediately as a `❓ Decision Needed` card (if HITL) or resolve it silently (if AFK).
   - *Never let a Fog item sit stale after its blocking dependency has resolved.* A Fog item that could graduate but hasn't is a hidden assumption — treat it with the same urgency as a pending ASM-X.
4. **Interactive Option Card Pattern:**
   - Present exactly **one** decision per turn (or at most two tightly coupled choices).
   - Search the codebase before asking; if facts exist in code, state them as verified context.
   - Provide 2–3 concrete choices with trade-offs, and offer a recommended default. The recommended default is a _suggestion only_ — it must receive explicit user acknowledgment before being treated as a confirmed decision. Never carry a recommendation forward without an explicit user response in chat:

   ```markdown
   ❓ **Decision Needed: <Short Title>** [HITL]
   **Context:** <1 sentence of verified facts from codebase search or logs, and the specific uncertainty.>
   **Why HITL:** <1 phrase — why only the user can resolve this, not the agent>

   - **Option A:** <Description, primary benefit, and key trade-off>
   - **Option B:** <Description, primary benefit, and key trade-off>

   👉 **Recommendation:** <Option A + 1-sentence rationale.>
   ```

   > **[AFK] Rule:** If a question is tagged AFK, the agent must NEVER present it as a Decision Needed card. It must be resolved silently through research or codebase search and recorded as a Verified Fact in `## 0. Research Summary`.

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

1. **Document Edge Cases (Before Triage — User Needs Full Picture First):**
   Before presenting scope options to the user, complete the edge case record for every discovered feature under `## 3. Scope & Edge Cases`. The user cannot make informed triage decisions without knowing the edge behaviors each feature carries. Document all 5 dimensions in plain, non-academic language:
   - **Zero / Empty State:** Behavior on first use, when 0 records exist, or when unconfigured.
   - **Validation & Recovery:** Invalid input handling, timeout/network drops, and user failure recovery.
   - **Permissions & Access:** Who is authorized, resource isolation, and access denied behavior.
   - **State & Concurrency:** Rapid double-submits, debouncing, and conflicting update guards.
   - **Data Lifecycle:** Cascade deletions, retention rules, persistence, and cleanup.
2. **User-Owned Scope Triage (After Full Picture is Visible):**
   Present the complete scope — features, sub-features, edge cases, and technical trade-offs — to the user, then ask them to triage into **four** clearly distinct buckets. Before presenting any item for triage, the agent must run the **Destination Check**: *"Does this item sit beyond the stated Destination, or is it simply not yet fully understood?"* Only items confirmed to be beyond the destination may be proposed as Out of Scope. Everything else stays in-scope as Fog or Deferred until the user explicitly decides otherwise.

   - **In Scope:** The essential core to deliver in this lifecycle cycle.
   - **Fog (Not Yet Specifiable):** In-scope requirements the agent *can tell are coming* but cannot yet precisely define, because they depend on upstream decisions still open. **Fog ≠ Unknown:** a Fog item is *known to exist* — the agent is certain it will need to be addressed — but it cannot yet be precisely stated because an upstream decision blocks it. These are NOT deferred — they are actively in-scope and will graduate to sharp requirements as the Decision Frontier advances. The agent must never ask the user to decide on Fog items — they must first be made sharp.
   - **Deferred:** Requirements the user has explicitly reviewed, understood, and consciously chosen not to include in this lifecycle cycle. Preserved for future cycles — never deleted.
   - **Out of Scope:** Work that sits *beyond the stated Destination*. This is a scope boundary ruling, not a priority judgment. The agent proposes candidates; the user makes the final call. Rationale must be recorded.
   - *Strict Rules:*
     - The User has 100% final authority on all triage decisions.
     - The Agent must never move Fog into Deferred or Out of Scope unilaterally — Fog must first be made sharp through probing.
     - Before proposing any item as Out of Scope, the agent must verify it sits beyond the Destination, not merely that it's unknown or complex.
     - Items that are "not yet understood" are always Fog, never Out of Scope.
3. **Record Key Decisions (`DEC-X`):**
   In `## 4. Key Decisions & Rationale`, record each consequential decision using this format — the title line has **no bullet**, and the detail + rationale appear as sub-bullets on separate lines:
   ```
   **DEC-N — Topic Title**
   - [The decision made and what it means]
   - _Rationale:_ [Why this option was chosen and what trade-offs were accepted]
   ```
   > **Note:** `01-discover.md` is the single home for ALL decisions across the lifecycle. If Phase 2 — Design uncovers a new decision during flow modeling or prototyping, it is recorded here as `DEC-N`, not in `02-design.md`. The Discover document is updated in place and remains the source of truth.
4. **Handle Non-Blocking Questions:**
   Non-blocking technical investigations are either recorded under `Deferred` in `01-discover.md` or handed off as open investigations for Phase 3 Plan (never left dangling without an owner). Once the Decision Frontier is empty, proceed directly to Section 4 for user approval.

## 4. Exit Gate & Completion Criteria

Phase 1 can transition to Phase 2 — Design only when the completion checklist is fully satisfied and the user grants explicit approval in chat.

### Completion Checklist (Pre-Flight Gate)

Before requesting user approval, verify that:
- **Destination Confirmed:** A 1–2 line Destination Statement is recorded in `## 1. At a Glance` and has been explicitly acknowledged by the user. All scope decisions reference it.
- **Evidence-Based Problem:** Grounded in concrete codebase facts (for existing workflows/bugs) or explicit user business goals and constraints (for greenfield capabilities).
- **Trunk Goal:** The Desired Goal clearly defines the intended outcome and preserved boundaries.
- **Domain Terms:** Core Terms (domain vocabulary) are settled under `## 1. At a Glance`.
- **No AFK Items Asked of User:** Every AFK-tagged assumption has been resolved by the agent through research; none were surfaced as user questions.
- **No Foggy Items in Triage:** Every item in Deferred or Out of Scope was Sharp (precisely statable) before the user triaged it. No Foggy items were presented for triage without first being made Sharp.
- **Fog Section Current:** All remaining Foggy items are explicitly recorded in the `Fog (Not Yet Specifiable)` bucket with their graduation condition stated.
- **Hierarchical Tree:** Target features and sub-features are structured hierarchically (Trunk $\to$ Branches $\to$ Leaves) without premature filtering.
- **User-Triaged Scope:** Requirements are triaged by the user into **In Scope**, **Deferred**, and **Out of Scope**.
- **Edge Cases:** Documented across all 5 dimensions (Zero State, Validation & Recovery, Permissions & Access, State & Concurrency, Data Lifecycle).
- **Consequential Decisions:** All `DEC-X` decisions are recorded with their reasoning and trade-offs.
- **Resolved High-Impact Uncertainties:** All critical questions (security, authorization, data integrity, session lifecycle) are verified from code facts or confirmed by the user, with zero concealed assumptions.
- **Assumption Register Cleared:** Every `ASM-X` entry in `## 5. Open Assumptions` has been either (a) explicitly confirmed by the user and promoted to a confirmed requirement, or (b) explicitly resolved as "not applicable" with the user's reasoning recorded. No assumption may remain at `⚠️ Pending` status at the time of exit-gate review.
- **Block-Level Confirmation:** At least once during the discovery phase, the agent presented the current state of `lifecycle/01-discover.md` to the user and received explicit per-feature-block confirmation before requesting final approval.
- **Document Hygiene:** `lifecycle/01-discover.md` is concise, consistent, and up to date.

### Requesting User Approval (Phase 0 Protocol)
1. Update Phase 1 status to `In Review` in `lifecycle/00-status.md`.
2. Before the final approval request, present a block-level confirmation summary in chat: for each major feature block, state what was confirmed, what assumptions were resolved, and ask the user to explicitly affirm or correct each block. A single "looks good overall" at the end is NOT sufficient if individual feature blocks were never reviewed by the user.
3. Only after block-level confirmation is complete, output a concise 1–2 sentence summary linking `[01-discover.md](01-discover.md)` and ask for explicit approval to advance to Phase 2 — Design.
4. Stop calling tools immediately and wait for the user's explicit response.

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
- **[file:line or source]:** [What was confirmed and what it means for the request]

**Plausible Inferences (→ Open Assumptions):**
- **ASM-1:** [What was inferred] — [Evidence basis] — ⚠️ Needs user confirmation

**Identified Gaps:**
- [Dimension not yet addressed by any evidence]

**High-Risk Unknowns:**
- [Question whose wrong answer could cause security / data integrity / UX failure]

## 1. At a Glance

**Destination:** [What reaching the end of this discovery looks like — the approved feature, resolved problem, or confirmed change. 1–2 lines. Every scope decision is tested against this.]

**The Problem:**
- **[Symptom / Pain 1]:** [What fails, breaks, or is blocked for the user]
- **[Symptom / Pain 2]:** [Operational, UX, or business friction]

**Current System:**
- **[Data Schema / Models]:** [How the current database, collection, or state stores data]
- **[Code Seam / Watcher]:** [Existing logic or triggers enforcing current behavior]
- **[Policy Background]:** [Why the system was originally built this way]

**Desired Goal:**
- **[Target Outcome 1]:** [What should become true for primary users]
- **[Scope / Boundary]:** [Key rule or role boundary preserved]

**Core Terms:**
- **[Domain Term 1]:** [Crisp definition of key business concept, entity, or role]
- **[Domain Term 2]:** [Crisp definition of key business concept, entity, or role]

## 2. Target Features

**F1 — [Feature 1 Name]**
- [Specific element, action, or interaction — e.g. "Role dropdown filter with options: Admin, Editor, Viewer"]
- [Specific element — e.g. "Search by username text input"]
- [Specific action — e.g. "Active / Inactive status dropdown"]
- [Specific per-item action — e.g. "Edit action button on each user card"]
- [Specific per-item action — e.g. "Delete action button on each user card"]
- [Specific navigation — e.g. "Tapping a user card navigates to User Detail screen"]
- **Zero / Empty State:** [Behavior on first use or when no records exist]
- **Validation & Recovery:** [Invalid input handling, timeout / network failure recovery]
- **Permissions & Access:** [Who is authorized, resource isolation, access denied behavior]
- **State & Concurrency:** [Rapid double-submit, debouncing, conflict guards]
- **Data Lifecycle:** [Cascade deletions, retention rules, persistence, and cleanup]

**F2 — [Feature 2 Name]**
- [Specific element or action]
- [Specific element or action]
- [Specific navigation]
- **Zero / Empty State:** ...
- **Validation & Recovery:** ...
- **Permissions & Access:** ...
- **State & Concurrency:** ...
- **Data Lifecycle:** ...

## 3. Scope & Edge Cases

**In Scope:**
- **[Key Deliverable 1]:** [Specific capability, layer touched, or component for this cycle]
- **[Key Deliverable 2]:** [Verification scope or security boundary]

**Fog (Not Yet Specifiable):**
- **[Foggy Area 1]:** [In-scope requirement known to exist but can't yet be precisely stated — blocked by an upstream open decision. Will graduate to a sharp requirement as the Decision Frontier advances. Not unknown; just not yet specifiable.]

**Deferred:**
- **[Future Feature 1]:** [Explicitly reviewed requirement the user has chosen to exclude from this cycle, preserved for future iterations]
- **[Future Feature 2]:** [Edge enhancement or secondary workflow consciously parked for later]

**Out of Scope (Beyond Destination):**
- **[Excluded Item 1]:** [What sits beyond the stated Destination and will not be addressed — with rationale tied to scope boundary]
- **[Excluded Item 2]:** [Untouched existing workflow or explicitly rejected path — confirmed by user]

## 4. Key Decisions & Rationale

**DEC-1 — [Topic Title]**
- [The decision made and what it means]
- _Rationale:_ [Why this option was chosen and what trade-offs were accepted]

**DEC-2 — [Topic Title]**
- [The decision made and what it means]
- _Rationale:_ [Why this option was chosen and what trade-offs were accepted]

## 5. Open Assumptions

**ASM-1 ([Topic]) [Sharp] [HITL]:** [What was assumed]
- _Basis:_ [Why inferred, not confirmed]
- _Status:_ ⚠️ Pending → surface as ❓ Decision Needed card

**ASM-2 ([Topic]) [Sharp] [AFK]:** [What was assumed]
- _Basis:_ [Why inferred]
- _Status:_ ⚠️ Pending → agent resolves via codebase search

**ASM-3 ([Topic]) [Foggy] [HITL]:** [What was assumed]
- _Basis:_ [Why it can't yet be precisely stated — which upstream decision blocks it]
- _Status:_ 🌫 In Fog → graduates when upstream ASM-X resolves

**ASM-4 ([Topic]) [Sharp] [HITL]:** [What was assumed]
- _Basis:_ [Why inferred]
- _Status:_ ✅ Confirmed / ❌ Rejected
```
