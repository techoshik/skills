---
name: lifecycle-prototype
description: Interactive UI/UX stress-testing via 3 divergent component/screen variants, 5-state toggles, carousel hubs, and Mermaid flow diagrams (Lifecycle: Prototype).
---

# Lifecycle Prototype

The `lifecycle-prototype` skill visually stress-tests both UI and workflow logic in the browser before writing production code. Your mission is to construct 3 lightweight, isolated HTML variants with 5-state toggles for UI requirements, author modular Mermaid flow/state diagrams for logic and non-UI requirements inside `lifecycle/02-prototype.html`, and sync any discovered gaps and final design choices back into `01-requirements.md`.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Prototyping Mindset: Throwaway Visual Stress-Testing

- **Prototypes are Disposables, Not Production Code:** Fast, isolated HTML/JS mockups and Mermaid flow diagrams designed solely to expose visual and logic gaps before writing production code.
- **Structural Divergence Over Surface Styling:** UI options must differ in interaction paradigm and layout (e.g. Drawer vs. Dedicated Page vs. In-line Accordion), never superficial font or color swaps.
- **Self-Contained Styling (Zero Cross-Bleed):** Always use embedded `<style>` blocks inside each HTML file. Never share an external CSS file across variants.
- **Conceptual References Only (Design System Primacy):** Prototypes are conceptual visual references for layout and workflow alignment. Production code must strictly consume the canonical design system components, theme tokens, and spacing constants defined in `.agents/rules/`. Never copy inline HTML/CSS styling, hardcoded pixel margins, or ad-hoc alpha values from prototypes into production code.

---

## Step 1: Entry Gate & Structure Setup

1. **Verify Entry Gate:**
   - Read `lifecycle/00-status.md`.
   - Verify that **`Brainstorm` is marked `Done`**.
   - If `Prototype` is already marked `Skipped`, STOP—advance to Roadmap.
   - If `Brainstorm` is `In Progress` or `In Review`, STOP—instruct user to complete Brainstorm first.
   - Set `Prototype` to **`In Progress`** in `lifecycle/00-status.md`.
2. **Identify UI Units & Logic Flows:**
   - Read `lifecycle/01-requirements.md`.
   - **UI Units (for 3 HTML Options):** Primary Screen/Flow, or key composite components (cards, dialogs, forms, lists, filter bars). *Do NOT create variants for atomic primitives (buttons, labels, badges).*
   - **Logic & State Flows (for Mermaid Diagrams):** Non-UI requirements, state transitions, backend/validation flows, or bug-fix comparisons (`Current Broken` vs. `Proposed Fix`).
3. **Directory Structure Setup:**
   ```text
   lifecycle/
   ├── 02-prototype.html                  <-- Root Hub (UI Carousels + Mermaid Flow Diagrams)
   └── prototype/
       └── <unit>/                        <-- Substantive Component or Screen
           ├── option-1.html              <-- Self-contained variant (<350 lines)
           ├── option-2.html
           └── option-3.html
   ```

> **➡️ Sign-off & Transition to Step 2:** `Brainstorm` is `Done`, target UI units and logic flows are identified, and directories are initialized.

---

## Step 2: Component & Screen Variant Authoring (The 3 UI Options)

For each substantive UI unit (`<unit>`):

1. **Author 3 Divergent Variants:**
   - Create `option-1.html`, `option-2.html`, and `option-3.html` under `lifecycle/prototype/<unit>/`.
   - Keep files lightweight (`<350` lines each).
   - Ensure true layout/workflow divergence:
     - *Option 1:* Direct in-line / standard flow.
     - *Option 2:* Modal / Drawer / Step-by-step wizard.
     - *Option 3:* Dense / Expandable accordion / Compact view.
2. **Embed 5 Interactive UI States:**
   - Include a sticky top control bar with buttons to toggle between 5 states via simple JS/CSS:
     - `Populated`: Standard working view with realistic mock data.
     - `Empty`: 0 records exist; friendly first-time onboarding/CTA.
     - `Loading`: Skeleton loaders, shimmer, or disabled inputs.
     - `Error`: Validation failure banners, network disconnect, retry button.
     - `Edge / Modal`: Maximum character counts, long names, confirmation sheets.
3. **Self-Contained Styling:**
   - Every file must be a complete HTML document containing its own `<style>` block.
   - Zero external CSS files; zero relative link resolution issues.

> **➡️ Sign-off & Transition to Step 3:** 3 divergent options with 5 state toggles exist for all targeted UI units (or skipped if the task only requires logic flow diagrams).

---

## Step 3: Hub Assembly & Flow Diagram Authoring (`02-prototype.html`)

1. **Root Hub Assembly (`lifecycle/02-prototype.html`):**
   - Initialize `lifecycle/02-prototype.html` from [Prototype Hub Template](../lifecycle/templates/02-prototype.html).
   - For each targeted UI unit, embed a `.carousel-container` with tab buttons that switch the preview iframe between `prototype/<unit>/option-1.html`, `option-2.html`, and `option-3.html`.
2. **Modular Mermaid Flow Diagrams:**
   - Under **Logic & State Flow Diagrams** in `02-prototype.html`, author modular Mermaid diagrams (`5–10` nodes max per sub-flow) for non-UI requirements, state machines, and bug-fix comparisons (`[❌ Current Behavior]` vs. `[✅ Proposed Fix]`).
   - The user reviews both interactive UI carousels and logic flows in a single browser window.

> **➡️ Sign-off & Transition to Step 4:** `02-prototype.html` opens cleanly in any browser with all UI carousels and Mermaid flow diagrams rendered in one tab.

---

## Step 4: Prototyping Discovery & Gap Sync

While building and testing the UI variants and flow diagrams, actively hunt for unstated requirements:
- *Did you realize an input needs a character counter or instant debounce?*
- *Did you discover an edge case where an item has no title or avatar?*
- *Did a flow diagram expose a missing error transition or permission check?*

**Action:**
1. Immediately append any discovered fields, edge cases, or validation rules to `## 3. Requirements & Acceptance Criteria` or `## 4. Business Rules & Domain Invariants` in `lifecycle/01-requirements.md`.
2. Log any workflow friction into `lifecycle/04-refine.md`.

> **➡️ Sign-off & Transition to Step 5:** Gaps discovered during prototyping are synced back into `01-requirements.md`.

---

## Step 5: Two-Stage Handoff & Mix-and-Match Lock

### Stage 1: Presentation & User Review (`In Review`)
1. Update `lifecycle/00-status.md`: set `Prototype` to **`In Review`**.
2. Present a concise review summary in chat:
   - Provide the file link to `lifecycle/02-prototype.html`.
   - Never output markdown tables or raw Mermaid code blocks in chat.
   - Present a concise, scannable summary highlighting the core trade-offs across options and key flow diagrams.
   - Invite the user to test states and pick or mix-and-match:
     > *"Please review `02-prototype.html`. You can pick a winning option or mix-and-match (e.g. 'Option 1 Card + Option 3 Filter')."*
3. **STOP.** Do not proceed to Roadmap until the user responds.

### Stage 2: Decision Consolidation on Approval (`Done`)
1. When the user approves or selects choices:
   - Consolidate the winning combination and confirmed flow behavior under `## 6. Selected UI/UX Specification` in `lifecycle/01-requirements.md`.
2. Update `lifecycle/00-status.md`: mark `Prototype` as **`Done`**.
3. Read [`lifecycle-roadmap/SKILL.md`](../lifecycle-roadmap/SKILL.md) and auto-advance to Roadmap.
