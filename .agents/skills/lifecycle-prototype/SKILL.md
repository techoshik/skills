---
name: lifecycle-prototype
description: Interactive UI/UX stress-testing via 3 divergent component/screen variants, 5-state toggles, carousel hubs, and Mermaid flow diagrams (Lifecycle: Prototype).
---

# Lifecycle Prototype

The `lifecycle-prototype` skill visually stress-tests UI layouts and screen flows in the browser before writing production code. Your mission is to construct 3 lightweight, isolated HTML variants with 5-state toggles for UI screens/components, author modular Mermaid flow diagrams for workflow/state logic inside `lifecycle/02-prototype.html`, and sync discovered UX simplifications and final choices back into `01-requirements.md`.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Prototyping Principles

- **Catch UX Clutter in HTML, Not in Production Code:** Use the prototype to help the user see whether screens, tabs, or cards feel intuitive or redundant—fixing a flow in HTML takes 1 minute vs. hours of refactoring in `Execute`.
- **Structural Divergence Over Surface Styling:** The 3 options must differ in layout, information hierarchy, or interaction flow (e.g. Unified Card vs. Split Tabs vs. Slide-over Drawer), never superficial color/font swaps.
- **Self-Contained `<style>` & Design System Primacy:** Embed `<style>` inside each HTML file (no shared CSS files). Remember that prototypes are conceptual layout/flow references—production code must strictly use the canonical design system components and tokens defined in `.agents/rules/`.

---

## Step 1: Entry Gate & Structure Setup

1. **Verify Entry Gate:**
   - Read `lifecycle/00-status.md` and verify **`Brainstorm` is `Done`**.
   - Set `Prototype` to **`In Progress`** in `lifecycle/00-status.md`.
2. **Identify UI Units & Logic Flows (`01-requirements.md`):**
   - **UI Units (3 HTML Options):** Full screen flows or composite components (cards, dialogs, forms, filter bars). Do not create variants for atomic primitives (buttons, badges).
   - **Logic & State Flows (Mermaid Diagrams):** End-to-end screen navigation, state transitions, validation flows, or bug-fix comparisons (`Current Broken` vs. `Proposed Fix`).
3. **Directory Structure:**
   ```text
   lifecycle/
   ├── 02-prototype.html                  <-- Root Hub (UI Carousels + Mermaid Flow Diagrams)
   └── prototype/
       └── <unit>/                        <-- Substantive Screen or Component
           ├── option-1.html              <-- Self-contained variant (<350 lines)
           ├── option-2.html
           └── option-3.html
   ```

> **➡️ Sign-off & Transition to Step 2:** `Brainstorm` is `Done`, target UI units and logic flows are identified, and directories are ready.

---

## Step 2: Author 3 Divergent UI Options (`prototype/<unit>/option-[1-3].html`)

For each substantive UI unit (`<unit>`):

1. **3 Distinct Layout / Flow Paradigms (`<350` lines each):**
   - *Option 1:* Direct unified card / standard in-line flow.
   - *Option 2:* Modal / Drawer / Step-by-step guided flow.
   - *Option 3:* Compact / Expandable accordion / Consolidated view.
2. **5 Interactive UI States (Sticky Top Bar):**
   - Include a top control bar toggling between: `Populated`, `Empty`, `Loading`, `Error`, and `Edge / Modal`.
3. **Self-Contained HTML:**
   - Each file embeds its own `<style>` and minimal JS state switcher.

> **➡️ Sign-off & Transition to Step 3:** 3 divergent options with 5 state toggles exist for all targeted UI units.

---

## Step 3: Assemble Single-Page Hub & Flow Diagrams (`02-prototype.html`)

1. **Initialize `lifecycle/02-prototype.html`:**
   - Use [Prototype Hub Template](../lifecycle/templates/02-prototype.html).
   - Embed a `.carousel-container` for each UI unit with buttons switching between `prototype/<unit>/option-1.html`, `option-2.html`, and `option-3.html`.
2. **Author Modular Mermaid Flow Diagrams:**
   - Under **Logic & State Flow Diagrams** in `02-prototype.html`, add modular Mermaid diagrams (`5–10` nodes max per sub-flow) showing the screen journey, state transitions, or backend validation rules.

> **➡️ Sign-off & Transition to Step 4:** `02-prototype.html` renders all UI carousels and Mermaid flow diagrams cleanly in one browser tab.

---

## Step 4: Prototyping Discovery & In-Place Sync (`01-requirements.md`)

1. **Sync Discovered Gaps & UX Improvements:**
   - Any missing field, validation rule, edge state, or screen consolidation discovered while building the prototype must be updated **in place** in `lifecycle/01-requirements.md` (`Section 1`, `Section 2`, `Section 3`) so `01-requirements.md` stays 100% consistent.
2. **Log Friction:** Append any process or rule friction to `lifecycle/04-refine.md`.

> **➡️ Sign-off & Transition to Step 5:** All discovered gaps are synced into `01-requirements.md`.

---

## Step 5: Two-Stage Handoff & Mix-and-Match Lock

### Stage 1: User Review (`In Review`)
1. Set `Prototype` to **`In Review`** in `lifecycle/00-status.md`.
2. Present a concise chat summary linking to `lifecycle/02-prototype.html` (highlighting the 3 options' trade-offs in plain bullets—no chat tables or raw Mermaid) and invite the user to pick an option, mix-and-match, or simplify the flow further.
3. **STOP** and wait for the user's selection.

### Stage 2: Consolidate Selection & Auto-Advance (`Done`)
1. When the user selects an option (or requests a UX simplification):
   - Record the final locked design under `## 4. Selected UI/UX Specification` in `lifecycle/01-requirements.md`.
   - **Replace any outdated lines in Section 1 (`Problem & Experience Delta`) and Section 2 (`Requirements & Acceptance Criteria`) in place** so the entire `01-requirements.md` file matches the chosen design with zero contradictions.
2. Mark `Prototype` as **`Done`** in `lifecycle/00-status.md`, read [`lifecycle-roadmap/SKILL.md`](../lifecycle-roadmap/SKILL.md), and auto-advance to Roadmap.
