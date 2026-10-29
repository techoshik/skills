# Requirements: <Feature Name>

<!-- 
DOCUMENT FORMATTING & SINGLE-TRUTH RULES (STRICT):
- ONE FACT PER LINE: Never write multi-sentence paragraphs inside a bullet point. Break details into short nested sub-bullets (1 line = 1 atomic detail).
- NO CONTRADICTIONS: If a requirement or UX decision changes at any point, REPLACE the superseded bullets in place across all sections so this file always reflects a single, coherent truth.
- NO DUPLICATE LISTS: Keep Section 1 focused strictly on Problem, User Flow, and Experience Delta; list requirements only once in Section 2, and list affected/reused code and 2nd-order caller ripple impacts only once in Section 6.
- CHECKBOX SYNC: Check off [x] on REQ-X and AC-X.Y items as tasks complete during Execute and verify 100% completion in Review.
- VISIBLE TO ALL: Never hide requirements, acceptance criteria, or technical touchpoints in comments or collapsed tags; humans and agents review every detail in plain markdown.
-->

## 1. Problem & Experience Delta
- **Core Problem (The "Why"):**
  - <Single-line root user or operational pain point>
  - <Why current behavior or UX falls short>
- **End-to-End User Flow (Simplified):**
  - <Step 1 of the clean user journey across screens>
  - <Step 2 of the clean user journey (noting any redundant tabs/screens consolidated or removed)>
- **Experience Delta (What Changes):**
  - **<Dimension / Screen Flow>:** <Current behavior> → <Proposed new behavior>
  - **<State / Logic Handling>:** <Current behavior> → <Proposed new behavior>

## 2. Requirements & Acceptance Criteria
- [ ] **REQ-1 (<Feature Capability>):**
  - <1-line summary of what this capability does>
  - [ ] **AC-1.1:** <Single binary testable condition>
  - [ ] **AC-1.2:** <Single binary testable condition>
- [ ] **REQ-2 (<Feature Capability>):**
  - <1-line summary of what this capability does>
  - [ ] **AC-2.1:** <Single binary testable condition>

## 3. Business Rules & Module Invariants
*(Non-negotiable module laws synced to `docs/modules/<module>/feature_<name>.md` in Finalize.)*
- **BR-1 (<Rule Name>):** <Single-line business, validation, or permission invariant>
- **BR-2 (<Rule Name>):** <Single-line business, validation, or permission invariant>

## 4. Selected UI/UX Specification
*(Populated during Prototype after reviewing `02-prototype.html`, or omitted if pure backend)*
- **Selected Variants:**
  - `<Screen / Component>`: <Chosen option or mix-and-match combination>
- **Confirmed Interaction & State Details:**
  - <1-line locked UX/state behavior>

## 5. Architectural & Technical Decisions
- **Decision 1 (<Topic>):**
  - Chosen: <1-line chosen approach>
  - Why (vs. Alternatives): <1-line reason why this wins over rejected alternatives>

## 6. Code, Callers & Docs Touchpoints
- **Module Docs:**
  - `docs/modules/<module>/README.md`
  - `docs/modules/<module>/feature_<name>.md`
- **Affected & Reusable Code (Including All Callers & Ripple Effects):**
  - **<Screen / Model / Widget / Validator>** (`<path/to/file>`): <1-line role, reuse, or caller ripple impact>
- **Project Rules:**
  - `.agents/rules/<rule>.md`

## 7. Glossary Updates (Staged)
- **`<Module Term>`:** <1-line unambiguous business definition (synced to `GLOSSARY.md` in Finalize)>

## 8. Deferred Requirements (Future Scope)
- **`<Feature Idea>`:** <1-line reason why this is out of scope for now>

## 9. Open Items (Questions & Research)
*(Must be resolved before advancing, but new questions or research items can be added here at any point during the lifecycle)*
- **Open Questions:**
  - *(None - all resolved)*
- **Open Research:**
  - *(None - all resolved)*
