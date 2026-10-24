# Roadmap: <Feature Name>

## Overview & Execution Strategy
- **Total Tasks:** <2 to 4 vertical tasks>
- **Prefactoring Required?** <Yes/No - if target file >400 lines>
- **Core Technology & Seams:** <Target state controller, repository, UI framework>

---

## Task 1: <P1 Core Tracer Bullet / Outcome Name>

### 1. Outcome
- <1 sentence stating the observable, working capability delivered.>

### 2. Touchpoints
- **Add:**
  - `<path/to/new_file.dart>`: <Brief responsibility / class name>
- **Update:**
  - `<path/to/existing_file.dart>`: <Specific method/symbol change>
- **Delete:**
  - `<path/to/deprecated_file.dart>` (if applicable)

### 3. Acceptance Criteria (Binary Verification)
- [ ] **AC-1:** <Binary testable condition>
- [ ] **Static Analysis:** `<command, e.g. flutter analyze path/>` reports 0 issues.
- [ ] **Automated Tests:** `<command, e.g. flutter test path/>` passes 100% cleanly (fast logic/controller seam tests; no shallow UI tests).

### 4. Business Rules
- **Rule 1:** <Domain rule from 01-requirements.md applicable to this slice>
- **Rule 2:** <Validation or permission constraint>

### 5. Code Guidelines
- **Applicable Rules:** Link [.agents/rules/<rule>.md](file:///.agents/rules/<rule>.md)
- **Task Constraints:** <e.g. 500-line ceiling, Direct Client SDK First, HookWidget/StatelessWidget only>

### 6. Human Verification Gate
- **Action:** <Step-by-step instructions for testing in running app/browser.>
- **Expected:** <Exact observable result confirming success.>

---

## Task 2: <P2 Secondary Flows & Interactions>

### 1. Outcome
- <1 sentence stating the secondary flow or sub-component capability delivered.>

### 2. Touchpoints
- **Add:**
  - `<path/to/new_file.dart>`
- **Update:**
  - `<path/to/existing_file.dart>`

### 3. Acceptance Criteria (Binary Verification)
- [ ] **AC-1:** <Binary testable condition>
- [ ] **Static Analysis:** `<command>` reports 0 issues.
- [ ] **Automated Tests:** `<command>` passes cleanly.

### 4. Business Rules
- **Rule 1:** <Domain rule>

### 5. Code Guidelines
- **Applicable Rules:** Link [.agents/rules/<rule>.md](file:///.agents/rules/<rule>.md)

### 6. Human Verification Gate
- **Action:** <Instructions>
- **Expected:** <Observable result>

---

## Task 3: <P3 Edge Cases, Invariants & Error Recovery>

### 1. Outcome
- <1 sentence stating edge case, validation failure, or offline recovery handling.>

### 2. Touchpoints
- **Update:**
  - `<path/to/file.dart>`

### 3. Acceptance Criteria (Binary Verification)
- [ ] **AC-1:** <Empty state / Error recovery verified>
- [ ] **Static Analysis:** `<command>` reports 0 issues.
- [ ] **Automated Tests:** `<command>` passes cleanly.

### 4. Business Rules
- **Rule 1:** <Invariants>

### 5. Code Guidelines
- **Applicable Rules:** Link [.agents/rules/<rule>.md](file:///.agents/rules/<rule>.md)

### 6. Human Verification Gate
- **Action:** <Instructions>
- **Expected:** <Observable result>
