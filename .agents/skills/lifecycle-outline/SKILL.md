---
name: lifecycle-outline
description: After Define approval, act as a Technical Architect to research codebase patterns, resolve technical ambiguities, and outline vertical story slices into reviewable checkpoints (DOER: Outline).
---

# Outline

The goal of this skill is to act as a Principal Architect and Technical Lead to **Outline** the approved requirements into granular, reviewable, vertically-sliced implementation checkpoints (Phase 2 of the DOER lifecycle). Your mission is to research codebase conventions, resolve technical ambiguities, and author a rock-solid `02-outline.md` artifact.

---

## 1. Entry Gate (Strict Status Check)

Before generating or modifying the outline:
1. Open `lifecycle/03-execute.md`.
2. Verify that **`Phase 1: Define` is marked `Done`**.
3. Verify that both `lifecycle/01-define.md` and the settled UI prototype (`lifecycle/prototype/index.html` or `prototype.html`) exist.
4. **STOP if unapproved:** If `Phase 1: Define` is not `Done`, do not proceed. Instruct the user to complete and approve the Define phase first.

---

## 2. Autonomous Architectural Research

Before asking questions or drafting the outline, autonomously investigate the codebase:
- **Existing Architecture & Patterns:** Inspect existing modules, state management patterns (controllers, providers, stores), data repositories, and router tables.
- **Guideline Audit:** Read relevant project guidelines in `.agents/guidelines/` (e.g., framework conventions, state management rules, security rules).
- **Domain Ubiquitous Language:** Read `GLOSSARY.md` to ensure all new class names, enums, DTOs, and functions strictly adhere to established project terminology.
- **Visual Models vs. Technical Ground Truth (Dual-Audience Law):** Inspect any Mermaid diagrams in `01-define.md` to quickly grasp the overarching behavioral intent and edge-case boundaries. However, remember the **Dual-Audience Law**: the diagram is a human review aid. Your architectural checkpoints must be grounded strictly in `## 4. List of Changes`, `## 6. Decisions`, and codebase patterns—never assume implementation details solely from high-level diagram boxes.
- **Grounded in the Prototype:** Inspect the settled prototype in `lifecycle/prototype/`. Every screen, filter, drawer, button, and state that was visually validated in Define must map directly to concrete architectural components.
- **Research Sub-Agent (Context Hygiene):** If investigating existing architecture requires reading 10+ files or tracing complex dependency graphs, delegate the search to a `research` subagent. The subagent inspects the files and returns a concise brief, keeping the main context pristine for high-precision outlining.

---

## 3. Technical Alignment (Frontier Questions)

- **Facts Belong to the Agent:** If an established codebase pattern or guideline clearly dictates how the feature must be built, **apply it directly**. Do not ask redundant questions.
- **Decisions Belong to the User:** If the research reveals multiple valid technical approaches or trade-offs (e.g., client-side filtering vs. server-side query, cached state vs. live stream, Cloud Function mutation vs. direct write):
  - Formulate targeted questions using the **recommendation-first** format:

```markdown
❓ **Q1 - <Technical Decision Topic>**: <Context, options, and trade-offs>

➡️ **Recommendation**: <Your recommended architectural approach and rationale>
```

  - **Word each question so that typing "yes" accepts the recommendation.**

---

## 4. Vertical Story Slicing & Tracer Bullets (MANDATORY)

### The Death of Horizontal Layering
- **Strictly Forbidden:** Never slice work into horizontal technical layers (e.g., "Checkpoint 1: Models & DTOs", "Checkpoint 2: Mocked UI", "Checkpoint 3: Repositories & Real Data").
- Horizontal layering forces throwaway mock code, creates untestable intermediate states, and delays human verification.

### Tracer-Bullet Vertical Slices
Break the implementation down into **Sequential Milestones** (`## Milestone X`), each delivering an independent capability. Inside each Milestone, construct **Vertical Story Slices** (`### Checkpoint X.Y`):
- **Cuts Through All Layers:** Every checkpoint cuts a narrow but COMPLETE path through all layers (models, state/controller, UI widgets, and repository/API calls). Data flows end-to-end; no temporary mock layers.
- **Sized for a Single Context Window:** Each checkpoint must be sized so that an agent can implement, analyze, test, and self-review it within a **single turn / context window** (typically touching 2 to 5 related files). If a slice touches too many files or spans multiple complex behaviors, split it into smaller vertical checkpoints.
- **Ordered by Dependency:** Checkpoints must be ordered sequentially so that blockers complete first.

### Prefactoring: "Make the Change Easy, Then Make the Easy Change"
If implementing a feature requires refactoring messy existing code, splitting a congested controller, or reorganizing shared utilities:
- **The 500-Line Ceiling Trigger:** When inspecting existing files to modify, if a target file is already **>400–500 lines** (or adding this feature will push it past 500 lines), do NOT pile more code into it. Schedule an explicit **Prefactoring Checkpoint** at the start of the milestone to split it along natural domain/widget seams *before* building the new capability.
- **Do NOT bundle heavy refactoring into the feature slice.**
- Create an explicit **Prefactoring Checkpoint** at the beginning of the milestone to clean the path *before* building the new capability.

### Wide Refactors: The Expand–Contract Pattern
If an architectural change has a wide blast radius (e.g. renaming a core database field, changing a shared model consumed across 20+ files, or updating a global API contract):
- Never attempt to migrate the entire codebase in a single massive slice.
- Sequence it using **Expand–Contract**:
  1. **Expand:** Add the new field/class/method beside the old one so nothing breaks.
  2. **Migrate:** Update call sites in focused batches across checkpoints.
  3. **Contract:** Remove the deprecated legacy code once no callers remain.

---

## 5. Checkpoint Anatomy (`02-outline.md`)

Every checkpoint must adhere strictly to [Outline Template](../lifecycle/templates/02-outline.md):

1. **`Goal`**: A single clear sentence defining the observable outcome of the slice.
2. **`Changes` (File-Anchored Checklist)**:
   - List every file to be created or modified using `- [ ] <file_path>:`.
   - Specify exact class names, methods, enums, parameters, or schema changes.
   - **Inline Decisions from Prototypes:** If the interactive prototype (`lifecycle/prototype/`) settled exact state shapes, enum values, validation regexes, or calculation logic, inline those exact code shapes directly into the Changes section.
3. **`Self-Review` (Automated & Guideline Verification)**:
   - `- [ ] **Guidelines:** Verified against .agents/guidelines/<guideline>.md:` (2–3 explicit architectural constraints to verify).
   - `- [ ] **Static Analysis:** <command, e.g. flutter analyze path/>` reports 0 issues.
   - `- [ ] **Tests (Highest Natural Seam):** <command, e.g. flutter test path/>` passes cleanly.
     - **Strict Ban on Shallow UI Tests:** NEVER write tests that merely assert static widget existence, static labels, colors, or layout positioning (`find.text('Submit')`, `find.byType(Container)`). They are brittle, slow, and provide zero regression protection. Only write UI-level tests when there is genuine **dynamic UI logic** (e.g. conditional rendering based on state, form validation triggers, disabled button states during loading).
     - **Checkpoint Testing Seam (Fast & Headless):** Checkpoint tests must execute in sub-seconds at the controller/state/viewmodel seam with mocked I/O. Visual appearance and layout are verified by the human at the `Verification` gate.
     - **Milestone-Level Instrumented/Integration Tests:** Heavy UI flow tests, widget pump integration, or instrumented device tests belong at the **end of the Milestone** (as a dedicated final checkpoint or milestone verification). Waiting until the milestone is complete prevents brittle test rewrites while intermediate checkpoints mutate the UI.
4. **`Verification` (Human Testing Gate)**:
   - **`Action:`** Step-by-step instructions for the user to trigger or test this slice in the running app/browser.
   - **`Expected:`** Exact observable result or behavior confirming success.

---

## 6. Synchronizing the Execute Dashboard (`03-execute.md`)

When `02-outline.md` is drafted, you MUST immediately populate `lifecycle/03-execute.md`:
1. Set `Phase 2: Outline` status to **`User Review`**.
2. Add every checkpoint from `02-outline.md` into the dashboard table with status **`Todo`**:

```markdown
# Execution Dashboard: <Feature Name>

| Task / Checkpoint | Status |
| :--- | :--- |
| Phase 1: Define | Done |
| Phase 2: Outline | User Review |
| Checkpoint 1.1: <Vertical Slice 1 Name> | Todo |
| Checkpoint 1.2: <Vertical Slice 2 Name> | Todo |
| Checkpoint 2.1: <Vertical Slice 3 Name> | Todo |
| Phase 4: Refine | Todo |
```

---

## 7. Friction Logging

If you encounter conflicting architectural guidelines, missing documentation, or tooling quirks during Outline:
- Do not stop outlining to rewrite global rules.
- Append the issue immediately to `lifecycle/04-refine.md` under `## 3. Friction & Lessons Learned`.

---

## 8. Human Handoff (Approval Gate)

1. Save `02-outline.md` in the `lifecycle/` directory.
2. Present `02-outline.md` to the user in chat, highlighting key architectural decisions and the milestone sequence.
3. **STOP.** Do not start executing Checkpoint 1.1 or modify any production code until the user explicitly approves in chat.
4. Once the user approves:
   - Update `Phase 2: Outline` status in `lifecycle/03-execute.md` to **`Done`**.
   - Read the master [`lifecycle`](../lifecycle/SKILL.md) skill to route to Phase 3: Execute.
