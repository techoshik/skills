# Requirements: <Feature Name>

<!-- 
DOCUMENT FORMATTING RULE (STRICT):
- ONE FACT PER LINE: Never write multi-sentence paragraphs inside a bullet point.
- Break every topic into short, scannable nested sub-bullets (1 line = 1 atomic detail).
- Keep all technical depth, edge cases, and file paths—just structure them vertically as sub-bullets.
- Avoid redundant bold labels on child sub-bullets; keep bolding for top-level identifiers and keys.
-->

## 1. Problem & Outcome Summary
- **Core Problem (The "Why"):**
  - <Single-line root user or operational pain point>
  - <Why current behavior falls short>
- **Observable Outcome:**
  - <Single-line capability 1 that works when complete>
  - <Single-line capability 2 that works when complete>
- **Second-Order Ripple Effects:**
  - Callers / UI: <Affected screens or upstream/downstream callers>
  - Data / State: <Affected models, providers, or cache invalidation>
  - Security / Rules: <Affected permissions, tenancy, or security rules>

<!-- For Bug Fixes & Refactors: Include Root-Cause Analysis -->
- **Bug / Refactor Root Cause (If Applicable):**
  - Current Behavior: <1-line description of what fails today>
  - Expected Behavior: <1-line description of correct behavior>
  - Root Cause: <Exact file/method and why it fails>
  - Regression Guardrail: <Test or invariant that prevents recurrence>

## 2. Existing Code & Reuse Touchpoints
- **Target Module Docs:** `docs/modules/<module>.md`
- **Target Code Paths:**
  - `<path/to/module>`
- **Reusable Models & DTOs:**
  - `<ExistingModel>`: <How it will be reused>
- **Reusable Widgets & Components:**
  - `<ExistingWidget>`: <Where it will be reused>
- **Reusable Utilities / Services:**
  - `<ExistingService>`: <Method/helper to reuse>
- **Applicable Project Rules:**
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
*(Non-negotiable domain laws synced to `docs/modules/<module>.md` in Finalize. One rule per bullet; use sub-bullets for conditions and enforcement.)*
- **BR-1 (<Rule Name>):**
  - <Single-line invariant, e.g. "Coupons cannot reduce order total below $0.00.">
  - Enforced in: <Where/how it is enforced, e.g. validator + Firestore rule>
- **BR-2 (<Rule Name>):**
  - <Single-line invariant>
  - Enforced in: <Where/how it is enforced>

<!-- Optional: For multi-condition calculations or state transitions, use a Boundary Truth Table instead of prose:
| Condition A | Condition B | Expected Result | Rule ID |
| :--- | :--- | :--- | :--- |
| Active User | Order Total > $50 | 10% Discount Applied | BR-1 |
-->

## 5. Architectural & Technical Decisions
- **Decision 1 (<Topic>):**
  - Chosen: <1-line decision>
  - Alternatives: <1-line summary of rejected option(s)>
  - Rationale: <1-line reason why the chosen approach wins>

## 6. Selected UI/UX Specification
*(Populated during Prototype after reviewing `02-prototype.html`)*
- **Selected Variants:**
  - `<Screen / Component 1>`: <Chosen option or mix-and-match combination>
- **Confirmed Interaction & Flow Details:**
  - <1-line locked UX/state behavior 1>
  - <1-line locked UX/state behavior 2>

## 7. Glossary Updates (Staged)
- **`<Domain Term>`:**
  - <1-line unambiguous business definition (synced to `GLOSSARY.md` in Finalize)>
  - Avoid: <Confusing synonyms to avoid>

## 8. Deferred Requirements (Future Scope)
- **`<Feature Idea>`:**
  - <1-line reason why this is out of scope for now>

## 9. Open Items (Must be 100% empty at sign-off)
- **Open Questions:**
  - *(None - all resolved)*
- **Open Research:**
  - *(None - all resolved)*
