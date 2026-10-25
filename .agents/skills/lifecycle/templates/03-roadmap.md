# Roadmap: <Feature Name>

<!-- 
DOCUMENT FORMATTING RULE (STRICT):
- ONE FACT PER LINE: Never write multi-sentence paragraphs inside a bullet point.
- Break every file change, rule, guideline, and verification step into short nested sub-bullets (1 line = 1 atomic detail).
- Touchpoints: List target file paths directly as parent bullets. Start each child sub-bullet with an imperative action verb and colon (e.g. Create:, Add:, Update:, Remove:, Delete:, Fix:).
- Test Touchpoints: Explicitly list newly authored or updated test files under Touchpoints.
- Verification Gates: Mandate Prerequisites / Environment Setup whenever backend, emulator, seed data, or build setup is required.
- Dashboard Synchronization: Use concise, scannable task slugs in 00-status.md (avoid long titles that wrap table columns).
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
- **Requirements Covered:** `<REQ-1, REQ-2>`
- **Mapped Criteria:** `<AC-1.1..AC-1.5, AC-2.1..AC-2.3>`

### 1. Outcome
- <Single crisp sentence stating the observable capability that works when this task finishes.>

### 2. Touchpoints
- `<path/to/new_file.ext>`:
  - Create: <Class, widget, or service to create>
- `<path/to/existing_file.ext>`:
  - Add: <Specific method or state property to add>
  - Update: <Specific wiring, callback, or logic change>
  - Remove: <Deprecated helper or dead code, if applicable>
- `<path/to/deprecated_file.ext>`:
  - Delete: <1-line reason for file removal, or omit bullet if no files deleted>
- `<path/to/test_file_test.ext>`:
  - Create: <Seam, unit, or widget test verifying state transitions or business rules>

### 3. Acceptance Criteria (Binary Verification)
- [ ] **AC-1:** <Single binary testable condition>
- [ ] **AC-2:** <Single binary testable condition>
- [ ] **Static Analysis:** `<command, e.g. flutter analyze, npm run lint, ruff check>` reports 0 issues.
- [ ] **Automated Tests:** `<command, e.g. flutter test, npm test, pytest>` passes 100% cleanly (fast logic/controller seam tests; no shallow UI tests).

### 4. Business Rules
- **BR-1 (`<Rule Name>`):** <Single-line domain or validation constraint for this slice>
- **BR-2 (`<Rule Name>`):** <Single-line permission or state constraint for this slice>

### 5. Code Guidelines
- **Rule Files:**
  - `.agents/rules/<rule>.md`
- **Task-Specific Invariants:**
  - <1-line constraint 1, e.g. hook-only, server-side only, StatelessWidget/HookWidget>
  - <1-line constraint 2, e.g. direct client SDK first, immutability; keep file under ~500 lines>

### 6. Human Verification Gate
- **Prerequisites / Environment Setup:**
  - <Emulator, backend deploy, seed data, or build setup required before testing>
- **Action:**
  1. <Step 1 to trigger in app/browser>
  2. <Step 2 to trigger in app/browser>
- **Expected:**
  - <Single-line observable outcome 1>
  - <Single-line observable outcome 2>

---

## Task 2: <P2 Secondary Flows & Interactions>
- **Requirements Covered:** `<REQ-3>`
- **Mapped Criteria:** `<AC-3.1..AC-3.4>`

### 1. Outcome
- <Single crisp sentence stating the secondary flow or sub-component capability delivered.>

### 2. Touchpoints
- `<path/to/new_file.ext>`:
  - Create: <Class/widget/method to add>
- `<path/to/existing_file.ext>`:
  - Update: <Specific symbol or behavior change>
- `<path/to/test_file_test.ext>`:
  - Create: <Seam test verifying secondary flow>

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
- **Prerequisites / Environment Setup:**
  - <Prerequisites if applicable, or 'None'>
- **Action:**
  1. <Step 1>
- **Expected:**
  - <Single-line observable result>
