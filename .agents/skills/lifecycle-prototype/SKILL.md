---
name: lifecycle-prototype
description: Interactive UI/UX stress-testing via 3 divergent component/screen variants, 5-state toggles, and carousel hubs (Lifecycle: Prototype).
---

# Lifecycle Prototype

The `lifecycle-prototype` skill stress-tests user experience interactively in the browser before writing production code. Your mission is to construct lightweight, isolated HTML variants for substantive UI units, provide interactive state toggles, integrate logic flows, and consolidate final design decisions back into `01-requirements.md`.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Prototyping Mindset: Throwaway Exploration

- **Prototypes are Disposables, Not Production Code:** Fast, isolated HTML/JS mockups designed solely to eliminate ambiguity and stress-test UX before writing production code.
- **Structural Divergence Over Surface Styling:** Options must differ in interaction paradigm and layout (e.g. Drawer vs. Dedicated Page vs. In-line Accordion), never superficial font or color swaps.
- **Self-Contained Styling (Zero Cross-Bleed):** Always use embedded `<style>` blocks inside each HTML file. Never share an external CSS file across variants.

---

## Step 1: Entry Gate & Structure Setup

1. **Verify Entry Gate:**
   - Read `lifecycle/00-status.md`.
   - Verify that **`Brainstorm` is marked `Done`**.
   - If `Brainstorm` is `Skipped`, STOP—prototype is not required.
   - If `Brainstorm` is `In Progress` or `In Review`, STOP—instruct user to complete Brainstorm first.
2. **Identify UI Units to Prototype:**
   - Read `lifecycle/01-requirements.md`.
   - Identify substantive UI units: Primary Screen/Flow, or key composite components (cards, dialogs, forms, lists, filter bars).
   - *Do NOT create variants for atomic primitives (buttons, labels, badges).*
3. **Directory Structure Setup:**
   ```text
   lifecycle/
   ├── 02-prototype.html                  <-- Root Launcher Hub
   └── prototype/
       └── <feature>/
           ├── index.html              <-- Feature Carousel Hub
           └── <unit>/                 <-- Substantive Component or Screen
               ├── option-1.html       <-- Self-contained variant (<350 lines)
               ├── option-2.html
               └── option-3.html
   ```

> **➡️ Sign-off & Transition to Step 2:** `Brainstorm` is `Done`, target UI units are identified, and directories are initialized.

---

## Step 2: Component & Screen Variant Authoring (The 3 Options)

For each substantive UI unit (`<unit>`):

1. **Author 3 Divergent Variants:**
   - Create `option-1.html`, `option-2.html`, and `option-3.html` under `lifecycle/prototype/<feature>/<unit>/`.
   - Keep files lightweight (`<350` lines each).
   - Ensure true layout/workflow divergence:
     - *Option 1:* Direct in-line / standard flow.
     - *Option 2:* Modal / Drawer / Step-by-step wizard.
     - *Option 3:* Dense / Expandable accordion / Compact view.
2. **Embed 5 Interactive UI States:**
   - Include a sticky top control bar with buttons to toggle between 5 states via simple JS/CSS:
     - 🟢 `Populated`: Standard working view with realistic mock data.
     - ⚪ `Empty`: 0 records exist; friendly first-time onboarding/CTA.
     - 🟡 `Loading`: Skeleton loaders, shimmer, or disabled inputs.
     - 🔴 `Error`: Validation failure banners, network disconnect, retry button.
     - 🟣 `Edge / Modal`: Maximum character counts, long names, confirmation sheets.
3. **Self-Contained Styling:**
   - Every file must be a complete HTML document containing its own `<style>` block.
   - Zero external CSS files; zero relative link resolution issues.

> **➡️ Sign-off & Transition to Step 3:** 3 divergent options with 5 state toggles exist for all targeted UI units.

---

## Step 3: Hub Assembly & Flow Diagram Integration

1. **Feature Carousel Hub (`lifecycle/prototype/<feature>/index.html`):**
   - Embed the 3 options for each unit inside an interactive carousel using zero-dependency `<iframe>` containers:
     ```html
     <div class="carousel-container">
       <h3>Component: User Card</h3>
       <div class="controls">
         <button onclick="showOption(1)">Option 1</button>
         <button onclick="showOption(2)">Option 2</button>
         <button onclick="showOption(3)">Option 3</button>
         <button onclick="toggleSideBySide()">Compare Side-by-Side</button>
       </div>
       <iframe id="preview-frame" src="user-card/option-1.html"></iframe>
       <div class="tradeoff-summary">
         <p><strong>Option 1 Trade-off:</strong> Direct visibility, consumes more vertical space.</p>
       </div>
     </div>
     ```
2. **Root Launcher Hub (`lifecycle/02-prototype.html`):**
   - Provide a clean dashboard linking to all feature index files.
   - Include a **"Logic & Flows"** tab linking to or rendering the Mermaid diagrams authored in `01-requirements.md`.

> **➡️ Sign-off & Transition to Step 4:** `02-prototype.html` and feature `index.html` open cleanly via direct double-click in any browser with zero CORS errors.

---

## Step 4: Prototyping Discovery & Gap Sync

While building and testing the UI in browser, actively hunt for unstated requirements:
- *Did you realize an input needs a character counter or instant debounce?*
- *Did you discover an edge case where an item has no title or avatar?*
- *Is there a missing filter option or a tricky modal confirmation?*

**Action:**
1. Immediately append any discovered fields, edge cases, or validation rules to `## 3. Requirements & Acceptance Criteria` in `lifecycle/01-requirements.md`.
2. Log any workflow friction into `lifecycle/04-refine.md`.

> **➡️ Sign-off & Transition to Step 5:** Gaps discovered during prototyping are synced back into `01-requirements.md`.

---

## Step 5: Two-Stage Handoff & Mix-and-Match Lock

### Stage 1: Presentation & User Review (`In Review`)
1. Update `lifecycle/00-status.md`: set `Prototype` to **`In Review`**.
2. Present a concise review summary in chat:
   - Provide the file link to `lifecycle/02-prototype.html`.
   - List the 3 options for each component and summarize the core trade-offs.
   - Invite the user to test states and pick or mix-and-match:
     > *"Please review `02-prototype.html`. You can pick a winning option or mix-and-match (e.g. 'Option 1 Card + Option 3 Filter')."*
3. **STOP.** Do not proceed to Roadmap until the user responds.

### Stage 2: Decision Consolidation on Approval (`Done`)
1. When the user approves or selects choices:
   - Consolidate the winning combination under `## 9. Selected UI/UX Specification` in `lifecycle/01-requirements.md`.
2. Update `lifecycle/00-status.md`: mark `Prototype` as **`Done`**.
3. Read [`lifecycle-roadmap/SKILL.md`](../lifecycle-roadmap/SKILL.md) and auto-advance to Roadmap.
