# Feature: <Feature Name>

<!-- 
DOCUMENT FORMATTING RULE (STRICT):
- ONE FACT PER LINE: Never write multi-sentence paragraphs inside a bullet point.
- Break every workflow, invariant, and touchpoint into short, scannable nested sub-bullets (1 line = 1 atomic detail).
-->

## 1. Purpose & User Problem
- **Problem Solved:** <1-line summary of user or operational pain point>
- **Delivered Capability:** <1-line summary of what this feature enables>

## 2. Entry & Primary Workflows
- **Entry Anchor:** `<e.g. Route /shops, button on OrderSummary, or background push event>`
- **Primary Happy Path:**
  1. <User action or trigger event>
  2. <State update or controller dispatch>
  3. <Observable UI or persistence result>
- **Secondary & Edge Flows:**
  - Empty State: <What happens when 0 records exist>
  - Error State: <What happens on network or validation failure>
  - Concurrency / Guard: <Debounce, lock, or disabled state behavior>

## 3. Core Business Rules & Module Invariants
*Scoped non-negotiable module rules governing this specific feature.*
- **BR-1 (`<Rule Name>`):** <1-line state, calculation, or validation law>
- **BR-2 (`<Rule Name>`):** <1-line permission or lifecycle law>

<!-- Optional: Boundary Truth Table for complex calculations or multi-state transitions:
| Condition A | Condition B | Expected Result | Rule ID |
| :--- | :--- | :--- | :--- |
| Condition 1 | Condition 2 | Expected Output | BR-1 |
-->

## 4. Architecture & File Touchpoints
- **Controllers & State:**
  - `<...Controller / ...State / ...Provider>`: <1-line responsibility>
- **Views & UI Components:**
  - `<...Screen / ...Dialog / ...Card>`: <1-line responsibility>
- **Data & Validators:**
  - `<...Repository / ...Validator>`: <1-line responsibility>
- **Routes & Navigation:**
  - `<Route name and path>`: <Guard or redirection logic if applicable>

## 5. Security, Tenancy & Role Boundaries
- **Permission Required:** `<Permission or role required to access/execute>`
- **Tenant Isolation:** `<How tenant filtering is enforced on reads/writes>`
- **Fail-Closed Policy:** `<What happens when credentials or permissions fail>`

## 6. Key Architectural Decisions
- **Decision 1 (`<Topic>`):**
  - Chosen: <1-line chosen approach>
  - Why (vs. Alternatives): <1-line reason why this wins over rejected alternatives>
