# Requirements: <Feature Name>

<!-- 
DOCUMENT FORMATTING & SINGLE-TRUTH RULES (STRICT):
- ONE FACT PER LINE: Never write multi-sentence paragraphs inside a bullet point. Break details into short nested sub-bullets (1 line = 1 atomic detail).
- NO CONTRADICTIONS: If a requirement or UX decision changes at any point, REPLACE the superseded bullets in place across all sections so this file always reflects a single, coherent truth.
- NO DUPLICATE LISTS: Keep Section 1 focused strictly on Problem and User Flow; list affected/reused code only once in Section 2, and list requirements only once in Section 3.
- CHECKBOX SYNC: Check off [x] on REQ-X and AC-X.Y items as tasks complete during Execute and verify 100% completion in Review.
-->

## 1. Problem & UX Summary
- **Core Problem (The "Why"):**
  - <Single-line root user or operational pain point>
  - <Why current behavior or UX falls short>
- **End-to-End User Flow (Simplified):**
  - <Step 1 of the clean user journey across screens>
  - <Step 2 of the clean user journey (noting any redundant tabs/screens consolidated or removed)>

## 2. Code & Docs Touchpoints
- **Module Docs:**
  - `docs/modules/<module>/README.md`
  - `docs/modules/<module>/feature_<name>.md`
- **Affected & Reusable Code:**
  - **<Screen / Model / Widget / Service>** (`<path/to/file>`): <1-line role, reuse, or impact>
- **Project Rules:**
  - `.agents/rules/<rule>.md`

## 3. Requirements & Acceptance Criteria
- [ ] **REQ-1 (<Feature Capability>):**
  - <1-line summary of what this capability does>
  - [ ] **AC-1.1:** <Single binary testable condition>
  - [ ] **AC-1.2:** <Single binary testable condition>
- [ ] **REQ-2 (<Feature Capability>):**
  - <1-line summary of what this capability does>
  - [ ] **AC-2.1:** <Single binary testable condition>

## 4. Business Rules & Domain Invariants
*(Non-negotiable domain laws synced to `docs/modules/<module>/feature_<name>.md` in Finalize.)*
- **BR-1 (<Rule Name>):** <Single-line domain, validation, or permission invariant>
- **BR-2 (<Rule Name>):** <Single-line domain, validation, or permission invariant>

<!-- Optional: For multi-condition calculations or state transitions, use a Boundary Truth Table:
| Condition A | Condition B | Expected Result | Rule ID |
| :--- | :--- | :--- | :--- |
| Condition 1 | Condition 2 | Expected Output | BR-1 |
-->

## 5. Architectural & Technical Decisions
- **Decision 1 (<Topic>):**
  - Chosen: <1-line chosen approach>
  - Why (vs. Alternatives): <1-line reason why this wins over rejected alternatives>

## 6. Selected UI/UX Specification
*(Populated during Prototype after reviewing `02-prototype.html`, or omitted if pure backend)*
- **Selected Variants:**
  - `<Screen / Component>`: <Chosen option or mix-and-match combination>
- **Confirmed Interaction & State Details:**
  - <1-line locked UX/state behavior>

## 7. Glossary Updates (Staged)
- **`<Domain Term>`:** <1-line unambiguous business definition (synced to `GLOSSARY.md` in Finalize)>

## 8. Deferred Requirements (Future Scope)
- **`<Feature Idea>`:** <1-line reason why this is out of scope for now>

## 9. Open Items (Must be 100% empty at sign-off)
- **Open Questions:** *(None - all resolved)*
- **Open Research:** *(None - all resolved)*
