# Roadmap: <Feature Name>

<!-- 
DOCUMENT FORMATTING & SYNC RULES (STRICT):
- ONE FACT PER LINE: Never write multi-sentence paragraphs inside a bullet point. Break details into short nested sub-bullets (1 line = 1 atomic detail).
- CANONICAL FILE PLACEMENT: Verify every new file path under Touchpoints against `.agents/rules/` folder/naming conventions (e.g. `<module>_validator.dart`) before finalizing.
- MID-FLIGHT PIVOTS: Never dump new scope into an untracked footer. Collapse any fully superseded task to a single heading line (`## Task X: <Name> — ~(Superseded by Task N)~`) and add a numbered `Task N` here and in `00-status.md`.
-->

- **Applicable Project Rules:** `.agents/rules/<rule>.md`

---

## Task 1: <P1 Core Tracer Bullet / Short Name>

### 1. Outcome
- <Single crisp sentence stating the observable capability that works when this task finishes.>

### 2. Touchpoints
- `<path/to/new_or_existing_file>`:
  - Create / Add: <Class, widget, or method to add>
  - Update: <Specific symbol, state field, or wiring to update>
- `<path/to/test_file>`:
  - Create / Update: <Fast unit or controller seam tests verifying the slice>

### 3. Acceptance Criteria (Binary Verification)
- [ ] **AC-1.1:** <Single binary testable condition mapped from 01-requirements.md>
- [ ] **AC-1.2:** <Single binary testable condition mapped from 01-requirements.md>
- [ ] **Static Analysis:** `<analyzer command>` reports 0 issues.
- [ ] **Automated Tests:** `<test command>` passes 100% cleanly (fast logic/controller seam tests; no shallow UI tests).

### 4. Rules & Constraints
- **BR-1 (`<Rule Name>`):** <Single-line module, validation, or permission rule enforced in this slice>
- **Constraint:** <1-line architectural constraint specific to the touched files, e.g. `<module>_validator.dart` placement, `<500` lines>

### 5. Human Verification Gate
<!-- Include 'Prerequisites:' bullet only when emulator, seed data, or special role setup is required -->
- **Action:**
  1. <Step 1 to trigger in app/browser>
  2. <Step 2 to trigger in app/browser>
- **Expected:**
  - <Single-line observable outcome>

---

## Task 2: <P2 Secondary Flows & Interactions>

### 1. Outcome
- <Single crisp sentence stating the secondary flow or sub-component capability delivered.>

### 2. Touchpoints
- `<path/to/file>`:
  - Update: <Specific symbol or behavior change>
- `<path/to/test_file>`:
  - Update: <Unit or controller seam test>

### 3. Acceptance Criteria (Binary Verification)
- [ ] **AC-2.1:** <Single binary testable condition mapped from 01-requirements.md>
- [ ] **Static Analysis:** `<analyzer command>` reports 0 issues.
- [ ] **Automated Tests:** `<test command>` passes cleanly.

### 4. Rules & Constraints
- **BR-2 (`<Rule Name>`):** <Single-line module rule>
- **Constraint:** <1-line task constraint>

### 5. Human Verification Gate
- **Action:**
  1. <Step 1>
- **Expected:**
  - <Single-line observable result>
