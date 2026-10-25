# Roadmap: <Feature Name>

<!-- 
DOCUMENT FORMATTING RULE (STRICT):
- ONE FACT PER LINE: Never write multi-sentence paragraphs inside a bullet point.
- Break every file change, rule, guideline, and verification step into short nested sub-bullets (1 line = 1 atomic detail).
- Touchpoints: List target file paths directly as parent bullets. Start each child sub-bullet with an imperative action verb and colon (e.g. Create:, Add:, Update:, Remove:, Delete:, Fix:).
- Avoid redundant bold labels on child sub-bullets; keep bolding for top-level identifiers and section keys.
-->

## Overview & Execution Strategy
- **Total Tasks:** <Number of vertical tasks (sized at ~2–5 related files per task)>
- **Prefactoring Required?** <Yes/No — if any target file >400 lines>
- **Core Seams:**
  - UI / Views: `<target pages/widgets>`
  - State / Controllers: `<target controllers/providers/use cases>`
  - Data / Persistence: `<target repositories/models/rules>`

---

## Task 1: <P1 Core Tracer Bullet / Outcome Name>

### 1. Outcome
- <Single crisp sentence stating the observable capability that works when this task finishes.>

### 2. Touchpoints
- `<path/to/new_file.dart>`:
  - Create: <Class, widget, or service to create>
- `<path/to/existing_file.dart>`:
  - Add: <Specific method or state property to add>
  - Update: <Specific wiring, callback, or logic change>
  - Remove: <Deprecated helper or dead code, if applicable>
- `<path/to/deprecated_file.dart>`:
  - Delete: <1-line reason for file removal, or omit bullet if no files deleted>

### 3. Acceptance Criteria (Binary Verification)
- [ ] **AC-1:** <Single binary testable condition>
- [ ] **AC-2:** <Single binary testable condition>
- [ ] **Static Analysis:** `<command, e.g. flutter analyze path/>` reports 0 issues.
- [ ] **Automated Tests:** `<command, e.g. flutter test path/>` passes 100% cleanly (fast logic/controller seam tests; no shallow UI tests).

### 4. Business Rules
- **BR-1 (`<Rule Name>`):** <Single-line domain or validation constraint for this slice>
- **BR-2 (`<Rule Name>`):** <Single-line permission or state constraint for this slice>

### 5. Code Guidelines
- **Rule Files:**
  - `.agents/rules/<rule>.md`
- **Task-Specific Invariants:**
  - <1-line constraint 1, e.g. `StatelessWidget` / `HookWidget` only>
  - <1-line constraint 2, e.g. Direct Client SDK First; keep file under ~500 lines>

### 6. Human Verification Gate
- **Action:**
  1. <Step 1 to trigger in app/browser>
  2. <Step 2 to trigger in app/browser>
- **Expected:**
  - <Single-line observable outcome 1>
  - <Single-line observable outcome 2>

---

## Task 2: <P2 Secondary Flows & Interactions>

### 1. Outcome
- <Single crisp sentence stating the secondary flow or sub-component capability delivered.>

### 2. Touchpoints
- `<path/to/new_file.dart>`:
  - Create: <Class/widget/method to add>
- `<path/to/existing_file.dart>`:
  - Update: <Specific symbol or behavior change>

### 3. Acceptance Criteria (Binary Verification)
- [ ] **AC-1:** <Single binary testable condition>
- [ ] **Static Analysis:** `<command>` reports 0 issues.
- [ ] **Automated Tests:** `<command>` passes cleanly.

### 4. Business Rules
- **BR-1 (`<Rule Name>`):** <Single-line domain rule>

### 5. Code Guidelines
- **Rule Files:**
  - `.agents/rules/<rule>.md`
- **Task-Specific Invariants:**
  - <1-line constraint>

### 6. Human Verification Gate
- **Action:**
  1. <Step 1>
- **Expected:**
  - <Single-line observable result>
