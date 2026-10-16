---
name: lifecycle-define
description: Act as a Product Manager to brainstorm, discover edge cases, resolve ambiguities via frontier grilling, sharpen domain language (GLOSSARY.md), build rapid interactive HTML UI prototypes to catch visual gaps, and define feature scope (DOER: Define).
---

# Define

The goal of this skill is to act as a proactive Product Manager and Systems Investigator to **Define** the feature (Phase 1 of the DOER lifecycle). Your mission is to explore the codebase, interview the user to eliminate ambiguity, stress-test requirements, sharpen domain terminology, build an interactive UI prototype to expose visual and UX gaps, and construct a crystalline `01-define.md` artifact.

---

## 1. Core Philosophy

### Facts Belong to the Agent; Decisions Belong to the User
- **Never ask the user a question you could answer by inspecting the code.**
- Before asking questions, autonomously investigate the repository: directory structures, existing data models, database schemas, API contracts, and project guidelines.
- If you need a fact to frame a question, research it first. Present questions only about **business decisions, UX priorities, product trade-offs, and behavioral boundaries**.

### The Design Tree & Frontier Interviewing
- Feature decisions form a dependency tree: each decision unlocks subsequent choices.
- Work in **rounds**. The **frontier** is every decision whose prerequisites are already settled.
- Never ask downstream questions until parent prerequisites are decided.
- Present questions using the **recommendation-first** format:

```markdown
❓ **Q1 - <Question Title>**: <Context, options, and trade-offs>

➡️ **Recommendation**: <Your recommended choice and rationale>

---

❓ **Q2 - <Question Title>**: <Context, options, and trade-offs>

➡️ **Recommendation**: <Your recommended choice and rationale>
```

- **Word questions so that a user typing "yes" accepts your recommended answer.** This minimizes cognitive overhead and accelerates alignment.

### Visual Language & The Dual-Audience Law
- **Mental Compilation Tax:** Reading raw text forces human reviewers to act as a compiler—parsing text, mentally constructing data flow or UI hierarchy, simulating edge cases, and only then searching for gaps. Visual models (Mermaid diagrams) externalize this mental compiler, freeing human cognitive bandwidth to focus 100% on gap detection and edge-case verification.
- **The Dual-Audience Law (INVIOLABLE):**
  - **Visual Models are for Human Review:** They verify intent, user journeys, state transitions, and bug fix logic during review.
  - **Text Specifications are the Technical Ground Truth for Agents:** Downstream agents (in Outline and Execute) must execute strictly against `## 4. List of Changes`, `## 6. Decisions`, and file-anchored checkpoints. Agents are strictly forbidden from treating high-level diagrams as an implementation shortcut to bypass detailed technical contracts.
- **Modular Sub-Flows (No Spaghetti Diagrams):** When planning multi-feature initiatives or entire modules, NEVER dump all logic into a single monolithic diagram. Decompose into focused sub-flows matching each feature or sub-journey (5–10 nodes max per diagram).

### UI Prototyping as the Visual Gap Detector
- Written requirements often suffer from "invisible gaps" (e.g., missing filter controls, forgotten sort options, absent empty states, awkward action placements).
- Building an interactive UI prototype is the **earliest, cheapest point to catch these gaps visually** and resolve them before outlining architecture.
- **Fast & Self-Contained:** Prototypes are built as lightweight, standalone HTML/CSS/JS files—never in heavy framework or production code (no Flutter/Dart compiling, no bundlers, zero dependencies).
- Any gap or nuance uncovered while creating or driving the prototype is immediately folded back into `01-define.md`.

### Clearing the Fog of War & Out-of-Scope Delineation
- Pin down the **Destination** (`Problem` + `Outcome`).
- Probe undiscovered territory ("fog of war"): failure states, empty states, edge cases, permission limits, and lifecycle edge-conditions.
- **Out of Scope vs. Invariants:** Distinguish clearly between deferred roadmap items and active system guardrails:
  - *Out of Scope (`## 5. Out of Scope`):* Features or capabilities deferred or excluded from this iteration (the agent writes zero code for these).
  - *System Invariants (`## 6. Decisions`):* Negative-space constraints the implementation must actively prevent (e.g., no double-submission during in-flight saves, no orphaned child records).
- Ruthlessly partition what belongs in this iteration versus what sits beyond the destination. Anything deferred or excluded MUST be explicitly recorded in `## 5. Out of Scope` with a clear rationale.

---

## 2. Domain Modeling (`GLOSSARY.md`)

Actively sharpen the project's domain model throughout the Define phase:
- **Challenge Fuzzy Language:** If the user uses overloaded or vague terms (e.g., saying "account" when the system distinguishes "Company" from "User"), challenge and clarify immediately.
- **Maintain Ubiquitous Language:** If domain-specific terms are introduced or clarified, create or update `GLOSSARY.md` at the project root:

```markdown
# Glossary

## Language

**<Term>**:
<A concise 1-2 sentence description of what the concept IS, totally devoid of implementation details.>
_Avoid_: <Synonyms, outdated terminology, or confusing alternatives>
```

- **Strict Scope for Glossary:** Only include terms unique to the business domain. General programming concepts (tokens, state, hooks, APIs) do NOT belong in `GLOSSARY.md`.

---

## 3. Workflow Steps

### Step 1: Initialize Dashboard & Autonomous Fact-Finding
1. Check if `lifecycle/03-execute.md` exists. If not, initialize it from [Execute Template](../lifecycle/templates/03-execute.md) with `Phase 1: Define` marked `In Progress`.
2. Inspect the repository:
   - Existing codebase patterns, data models, and conventions.
   - Any existing `GLOSSARY.md` to speak the project's domain language.
   - Relevant project guidelines in `.agents/guidelines/`.

### Step 2: Grilling & Requirements Discovery
1. Present your initial synthesis of the feature goal (`Problem` and `Outcome`).
2. Run frontier interview rounds (using the `❓` and `➡️ Recommendation` format) covering:
   - **Boundary & MVP:** What is the minimal complete slice versus future enhancements?
   - **UX & Flow:** Key interactions, validation rules, and empty/error states.
   - **Edge Cases:** Concurrency, state transitions, or conflicting operations.
3. Update or create `GLOSSARY.md` as domain terms crystallize.

### Step 3: Author `01-define.md`
Generate `lifecycle/01-define.md` adhering strictly to [Define Template](../lifecycle/templates/01-define.md):
- **`## 1. Goal`**: Concise `Problem` (current pain point) and `Outcome` (what is true upon completion).
- **`## 2. Visual Models (Human Review Aid)`**: Focused Mermaid diagram(s) tailored to the task type:
  - *Bug Fixes:* Dual-path flowchart (`flowchart TD`) contrasting `[❌ Current (Buggy) Behavior]` vs `[✅ Proposed Fix]` to pinpoint the exact failure point and guardrail.
  - *Workflows / Logic / Backend:* State machine (`stateDiagram-v2`) or decision flowchart showing states, transitions, error states, and edge-case exits.
  - *Multi-Feature / Full Modules:* Separate modular sub-flows (`### Flow 1: ...`, `### Flow 2: ...`) matching each feature area (never one giant spaghetti diagram).
  - *UI Screen Transitions:* Macro diagram of screens, sheets, and dialog flows complementing the interactive HTML prototype.
- **`## 3. Success Criteria`**: 2–4 observable, measurable conditions that confirm the feature works end-to-end.
- **`## 4. List of Changes`**: Grouped by screen/area, each item prefixed with `**Add:**`, `**Update:**`, `**Remove:**`, or `**Fix:**`.
- **`## 5. Out of Scope`**: Every deferred, excluded, or explicitly rejected capability with its rationale (`**<Excluded Feature>:** <Reason>`).
- **`## 6. Decisions`**:
  - `### Technical`: Architecture, security rules, data schemas, API contracts.
  - `### Business Logic`: Domain rules, system invariants / guardrails (what the system must actively prevent), and validation gates. If complex thresholds, formulas, or multi-condition rules exist, use a concise Boundary Truth Table (Input → Output) instead of paragraphs of fuzzy text.

### Step 4: Build the Interactive HTML UI Prototype (MANDATORY for UI Features)
Whenever a feature involves user interface changes, you must construct a rapid, self-contained HTML prototype that explores **three distinct design variants (Variant A, Variant B, Variant C)**.

1. **The 3-Variant Law (Structural Exploration):**
   Every prototype must offer 3 structurally different variants tailored to the specific feature. **Do NOT be rigid or blindly force a specific layout (e.g. Table vs Card vs Split) if it doesn't fit the feature.** Instead, devise 3 distinct architectural paradigms appropriate to the user experience being built:
   - **Structural Divergence:** Variants must disagree on layout structure, information hierarchy, and primary interaction affordances—not superficial colors, font sizes, or copy tweaks.
   - *If designing a Data List:* Explore variants like dense data-grid with sticky filters vs. card feed with filter drawer vs. split-pane master-detail.
   - *If designing a Form / Creation Flow:* Explore variants like multi-step guided wizard vs. single-page scroll with sticky summary bar vs. slide-over drawer with accordion sections.
   - *If designing a Dashboard / Settings:* Explore variants like metric overview cards vs. chronological activity timeline vs. categorized tabbed panels.

2. **Modular File Structure (Strictly <350 Lines per File):**
   To avoid sluggish agent reads and context bloat (>1000 lines), **never** dump all variants and screens into one monolithic file. Organize the prototype as a modular suite under `lifecycle/prototype/`:
   ```
   lifecycle/prototype/
   ├── style.css                 # Shared CSS, tokens, and layout utilities
   ├── index.html                # Prototype Hub introducing the 3 design philosophies
   ├── variant-a/                # Variant A screens
   │   ├── 01-list.html
   │   └── 02-details.html
   ├── variant-b/                # Variant B screens
   │   ├── 01-list.html
   │   └── 02-details.html
   └── variant-c/                # Variant C screens
       ├── 01-list.html
       └── 02-details.html
   ```
   *(For single-screen features, keep flat files: `variant-a.html`, `variant-b.html`, `variant-c.html`).*

3. **Interlinked Navigation & Variant Switching:**
   Every page in the prototype must be completely interlinked:
   - **Persistent Top Floating Bar:** Present on every page, offering two controls:
     - **Variant Switcher:** `[ Variant A ]  [ Variant B ]  [ Variant C ]` (instantly jumps to the corresponding screen in the other variant).
     - **Screen Switcher:** `[ 1. Cases List ]  [ 2. Case Details ]  [ 3. Create Case ]` (direct screen jumping).
   - **In-Flow Realistic Links:** Clicking a table row/card in `01-list.html` navigates to `02-details.html` within that same variant; clicking "Back" returns to `01-list.html`.

4. **Surface All Controls & Affordances (The 5-State & Action Lie Detector):**
   - Render the complete layout, headers, cards, tables, and drawers described in the requirements.
   - **Explicit Filters & Actions:** Include all search inputs, filter pills, dropdowns, sort bars, and action menus. Never gloss over secondary controls.
   - **The 5-State UI Guarantee:** Include clickable buttons or view toggles to verify the 5 essential UI states:
     - *1. Populated:* Standard active view with realistic sample data.
     - *2. Empty:* Zero-data state with a clear actionable call-to-action (CTA).
     - *3. Loading:* Skeleton shimmer or spinner view.
     - *4. Error:* Validation failure banner or full card with a retry action.
     - *5. Extreme / Edge:* Overflows, long text strings (wrapping vs. ellipsis), dialogs, drawers, or confirmation modals.

5. **The Visual Gap Audit:**
   - As you build and interact with the prototype across screens, actively look for gaps: *Are filter resets obvious? Does navigating to Details expose missing attributes? Where do primary vs secondary actions live?*
   - Immediately update `01-define.md` (Success Criteria, List of Changes, and Decisions) with any missing requirements revealed by the prototype.

6. **Combine & Consolidate (Mix & Match):**
   - The user can review all 3 variants and mix & match (e.g., *"Take the filter bar from Variant A, and the card layout from Variant B"*).
   - The agent consolidates the winning combination into the final settled prototype and updates `01-define.md` (`## 4. List of Changes` and `## 6. Decisions`) to lock in the agreed UX.

7. **Reference in Define:** Link the prototype at the top of `lifecycle/01-define.md`:
   - `> **Interactive Prototype:** [prototype/index.html](./prototype/index.html)` (or `[prototype.html](./prototype.html)`)

### Step 5: Friction Logging
If you encounter missing guidelines, ambiguous existing code, or architectural friction during Define:
- Do not stop to rewrite global project rules.
- Append the issue immediately to `lifecycle/04-refine.md` under `## 3. Friction & Lessons Learned`.

---

## 4. Human Handoff & Prototype Review Loop

Once the visual models, prototype, and `01-define.md` are drafted, execute this structured review loop:

### Step 1: Autonomous Gap Self-Audit
Before asking the user, the agent conducts an internal audit of the visual models, prototype, and `01-define.md`:
- For bug fixes: Does the dual-path diagram clearly explain the root failure and the exact guardrail placed?
- For state machines/flows: Are there dead-end states, missing error routes, or unhandled transitions?
- For UI prototypes (The 5-State Audit): Did we explicitly account for Populated, Empty with CTA, Loading, Error with retry, and Extreme/overflow states?
- For business logic & decisions: Are complex thresholds, formulas, or multi-condition rules represented as concise Boundary Truth Tables rather than ambiguous prose?
*Any gaps spotted during construction must be patched immediately in the visual model/prototype and updated in `01-define.md`.*

### Step 2: Present to User with Targeted Probes
1. Update `Phase 1: Define` status in `lifecycle/03-execute.md` to **`User Review`**.
2. Present `01-define.md` (pointing out the `## 2. Visual Models` for quick visual verification), the prototype link (for UI features), and any `GLOSSARY.md` changes.
3. Explicitly report:
   - **Visual Model Summary:** Briefly highlight the behavioral flow, state transitions, or bug fix contrast depicted in the diagram.
   - **Gaps Already Patched:** Highlight any edge-case states, missing filters, or dialogs the agent proactively added.
   - **Structured Review Questions:**
     1. *Visual / Flow Accuracy:* "Does the visual model (and/or prototype) match your mental model of the flow, or are there edge cases/steps missing?"
     2. *Variant Selection (for UI):* "Which variant (A, B, or C) do you prefer, or would you like to combine specific elements?"
     3. *Missing Controls / Gaps:* "Looking at the screens/flows, are there any filters, actions, columns, or buttons missing from the views?"

### Step 3: Consolidate & Close the Loop
1. **Incorporate Feedback:** If the user requests tweaks or combines elements, update the visual models and prototype to the final consolidated state and synchronize `01-define.md` (`## 4. List of Changes` and `## 6. Decisions`).
2. **Approval Gate:** The agent **STOPS** and waits for the user's explicit sign-off in chat.
3. **Transition to Outline:**
   - Once approved, update `Phase 1: Define` status in `lifecycle/03-execute.md` to **`Done`**.
   - Read the master [`lifecycle`](../lifecycle/SKILL.md) skill to route to Phase 2: Outline. Because the UI layout, controls, and states are visually validated, the Outline phase can design architecture with zero ambiguity.
