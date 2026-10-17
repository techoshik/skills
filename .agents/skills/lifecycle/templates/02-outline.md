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
  - [ ] **Rules Compliance:**
    - [ ] **Direct Client SDK First:** Verified direct Client SDK usage; 0 CRUD Cloud Functions created.
    - [ ] **500-Line Soft Ceiling:** Verified all modified/created files remain well under ~500 lines.
    - [ ] **Architecture Invariants:** Verified against `.agents/rules/<relevant_rule>.md`:
      - [ ] <Explicit invariant 1, e.g. Single feature controller; StatefulWidget strictly prohibited; HookWidget/StatelessWidget only>
      - [ ] <Explicit invariant 2, e.g. Display logic in domain models; no direct DB queries in UI>
  - [ ] **Static Analysis:** `<linter command, e.g. flutter analyze>` reports 0 issues.
  - [ ] **Tests:** `<test command, e.g. flutter test path/to/test>` passes cleanly (fast logic/state seam; no shallow UI tests).

- **Verification:**
  - **Action:** <Step-by-step instruction for the human to test or verify this slice>
  - **Expected:** <Exact observable result or behavior>

<!-- Repeat Checkpoints for remaining vertical slices in this Milestone -->
<!-- Optional: If end-to-end instrumented/UI integration tests are required, add a final checkpoint at the end of the Milestone (e.g. Checkpoint 1.N: Milestone E2E Journey Tests) once the full flow is stable. -->

<!-- Repeat Milestones for remaining major dependency phases -->
