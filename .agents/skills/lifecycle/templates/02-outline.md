# Outline: <Feature or Module Name>

## Milestone 1: <Major Capability / Dependency Phase>

### Checkpoint 1.1: <Vertical Slice / Story Name>

_Goal: <1 sentence describing the functional outcome of this slice>_

- **Changes:**
  - [ ] `<file_path>`:
    - <Add | Update | Remove | Fix> <Exact class, function, parameter, or property>
    - <Details of changes and data flow>
  - [ ] `<file_path>`:
    - <Add | Update | Remove | Fix> <Exact class, function, parameter, or property>

- **Self-Review:**
  - [ ] **Guidelines:** Verified against `.agents/guidelines/<relevant_guideline>.md`:
    - <Explicit architectural constraint 1, e.g. Single feature controller convention>
    - <Explicit architectural constraint 2, e.g. No direct database calls from UI widgets>
  - [ ] **Static Analysis:** `<linter command, e.g. flutter analyze>` reports 0 issues.
  - [ ] **Tests:** `<test command, e.g. flutter test path/to/test>` passes cleanly (fast logic/state seam; no shallow UI tests).

- **Verification:**
  - **Action:** <Step-by-step instruction for the human to test or verify this slice>
  - **Expected:** <Exact observable result or behavior>

<!-- Repeat Checkpoints for remaining vertical slices in this Milestone -->
<!-- Optional: If end-to-end instrumented/UI integration tests are required, add a final checkpoint at the end of the Milestone (e.g. Checkpoint 1.N: Milestone E2E Journey Tests) once the full flow is stable. -->

<!-- Repeat Milestones for remaining major dependency phases -->
