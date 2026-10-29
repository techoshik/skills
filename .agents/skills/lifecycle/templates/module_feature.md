# Feature: <Feature Name>

<!--
DOCUMENT FORMATTING RULE (STRICT):
- SCANNABLE SUB-BULLETS: Keep bullets concise (1 line = 1 atomic detail). Avoid multi-sentence prose walls inside bullets.
-->

## At a Glance
- **Problem:** <1-line user or operational pain this feature addresses>
- **Capability:** <1-line summary of what this feature enables>
- **Entry point:** `<e.g. Route /shops, button on OrderSummary, or background push event>`

## 1. Primary Workflow

Describe the end-to-end happy path clearly so a developer sees which components are involved and what the user/system observes.

1. <User action or trigger event>
2. <Validation, state transition, or controller/repository dispatch>
3. <Observable UI or persistence result>

## 2. Important Alternate & Failure Paths

Include only the relevant cases for this feature; do not keep empty state placeholders.

- **Empty / first use:** <What happens when 0 records exist or feature is unconfigured>
- **Validation / error / offline:** <Failure behavior and how the user recovers>
- **Permissions / tenancy:** <Allowed and denied behavior>
- **Concurrency / retry:** <Debounce, lock, idempotency, or stale-state guard>
- **Data lifecycle / side effects:** <Linked records, audit trail, derived state, migration, or cleanup>

## 3. Business Rules & Module Invariants

*Scoped non-negotiable module rules governing this specific feature.*

- **BR-1 (`<Rule Name>`):** <1-line state, calculation, or validation law>
- **BR-2 (`<Rule Name>`):** <1-line permission, lifecycle, or consistency law>

<!-- Optional: For multi-condition calculations or state transitions, use bulleted condition cases:
- Case 1: <Condition A> + <Condition B> -> Expected: <Output> (BR-1)
- Case 2: <Condition A> + <Condition C> -> Expected: <Output> (BR-2)
-->

## 4. Architecture & File Touchpoints

Include only the layers that exist and matter for this feature. Show file path and description as sub-bullets for scannability.

- **Controllers & State:**
  - **<Controller / State / Provider>:**
    - File: `<path/to/file>`
    - Description: <1-line responsibility>
- **Views & UI Components:**
  - **<Screen / Dialog / Card / Widget>:**
    - File: `<path/to/file>`
    - Description: <1-line responsibility>
- **Data & Validators:**
  - **<Repository / Service / Validator>:**
    - File: `<path/to/file>`
    - Description: <1-line responsibility>
- **Routes & Integrations:**
  - **<Route / Guard / External Integration>:**
    - File: `<path/to/file>`
    - Description: <1-line responsibility or guard logic>

## 5. Security, Tenancy & Operational Constraints

Include relevant boundaries; omit those that do not apply rather than leaving placeholders.

- **Authorization:** <Permission or role required and where access is enforced>
- **Tenant / resource isolation:** <How tenant filtering is enforced on reads/writes>
- **Fail-closed policy & audit:** <What happens when credentials/permissions fail and what is logged>
- **Performance / reliability:** <Important query/indexing limit or operational consideration>

## 6. Consequential Architectural Decisions

Record only decisions that future maintainers need to understand or may need to revisit.

- **Decision 1 (`<Topic>`):**
  - Chosen: <1-line confirmed approach>
  - Why: <Evidence and main trade-off>
  - Alternative rejected: <Meaningful alternative and why it was not selected>
  - Consequences / revisit trigger: <Risk, compatibility effect, or condition that would justify revisiting>
