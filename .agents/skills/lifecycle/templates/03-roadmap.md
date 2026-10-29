# Roadmap: <Feature Name>

<!--
DOCUMENT FORMATTING & SYNC RULES (STRICT):
- SCANNABLE SUB-BULLETS: Keep bullets concise (1 line = 1 atomic detail). Avoid multi-sentence prose walls.
- CANONICAL FILE PLACEMENT: Run each applicable `.agents/rules/` file’s Roadmap placement check against every new file path under Touchpoints before finalizing.
- MID-FLIGHT PIVOTS: Never dump new scope into an untracked footer. Collapse any fully superseded task to a single heading line (`## Task X: <Name> — ~(Superseded by Task N)~`) and add a numbered `Task N` here and in `00-status.md`.
-->

> **Quick read:** <1–2 lines stating the overall implementation strategy, total vertical slices, and key architectural trade-off.>
>
> **Needs your decision:** <`None — ready for sign-off`, or 1 line per open user-owned decision: topic → link → recommended default>

- **Applicable project rules:** `.agents/rules/<rule>.md`

## Roadmap Overview

1. [Task 1: <Short Slug>](#task-1-<short-slug>-<scope-slug>) `[<Scope Badge>]` — <1-line observable outcome>
2. [Task 2: <Short Slug>](#task-2-<short-slug>-<scope-slug>) `[<Scope Badge>]` — <1-line observable outcome>

---

## Task 1: <P1 Core Tracer Bullet / Short Outcome Name> [<Scope Badge>]

### 1. Outcome and dependency
- **Outcome:** <One crisp sentence describing what works when this task finishes>
- **Depends on:** <Task N or `None`>

### 2. Touchpoints
List all required source, configuration, migration, documentation, and test files verified against `.agents/rules/`.

- `<path/to/file>`:
  - **Create / Add:** <Class, widget, or method to add>
  - **Update:** <Specific symbol, state field, or wiring to update>
  - **Delete:** <Deprecated symbol, route, or temporary compatibility alias to remove (omit if none)>
- `<path/to/test_file>`:
  - **Create / Update:** <Behavior or risk the unit/controller/integration test verifies>

### 3. Acceptance criteria and verification
Map each product criterion to `01-requirements.md`. Separate human-readable behavior criteria from automated CLI verification commands.

- **Behavioral Criteria:**
  - [ ] **AC-1.1:** <Observable pass/fail condition from 01-requirements.md>
  - [ ] **AC-1.2:** <Observable pass/fail condition from 01-requirements.md>
- **Automated Verification Gates:**
  - [ ] **Static analysis:** `<exact analyzer command>` — expected: <0 issues, or documented baseline with 0 new regressions>
  - [ ] **Automated tests:** `<exact test command>` — expected: <100% pass on targeted unit/controller/integration tests>

### 4. Rules and constraints
- **BR-1 (`<Rule Name>`):** <Single-line module, validation, or permission invariant enforced in this slice>
- **Project constraint:** <1-line architectural constraint specific to the touched files, e.g. a placement rule or the file-size hard limit from `.agents/rules/`>
- **Pre-mortem coverage (Deep tier only):** `PM-1` — <what in this task mitigates it> <!-- Omit for Light and Standard. -->

### 5. Human verification gate
- **Prerequisites / Environment Setup:**
  - <Required emulator/server, test account/role, seed data, or starting state (or "None — standard logged-in session")>
- **Action:**
  1. <Step 1 to trigger in app/browser>
  2. <Step 2 to trigger in app/browser>
- **Expected:**
  - <Single-line observable outcome>

---

## Task 2: <P2 Secondary Flows & Interactions> [<Scope Badge>]

### 1. Outcome and dependency
- **Outcome:** <One crisp sentence describing what works when this task finishes>
- **Depends on:** <Task 1 or `None`>

### 2. Touchpoints
- `<path/to/file>`:
  - **Update:** <Specific responsibility or symbol change>
- `<path/to/test_file>`:
  - **Update:** <Behavior or risk the test verifies>

### 3. Acceptance criteria and verification
- **Behavioral Criteria:**
  - [ ] **AC-2.1:** <Observable pass/fail condition from 01-requirements.md>
- **Automated Verification Gates:**
  - [ ] **Static analysis:** `<exact analyzer command>` — expected: <result>
  - [ ] **Automated tests:** `<exact test command>` — expected: <result>

### 4. Rules and constraints
- **BR-2 (`<Rule Name>`):** <Single-line module rule>
- **Project constraint:** <Relevant constraint, or omit if none>

### 5. Human verification gate
- **Prerequisites / Environment Setup:**
  - <Required emulator/server, test account/role, seed data, or starting state (or "None — standard logged-in session")>
- **Action:**
  1. <Step 1 to trigger in app/browser>
- **Expected:**
  - <Single-line observable outcome>
