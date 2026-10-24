# Module: <Module Name>

## 1. Purpose & Business Domain
<1–2 plain-English sentences explaining what business domain this module owns and why it exists.>

## 2. Key Concepts & Entities
*Core business concepts owned by this module. Cross-reference `GLOSSARY.md` for shared project terms.*
- **<Concept / Entity>**: <What this represents in the real world and its role in this module.>
- **<Concept / Entity>**: <Description and relation to other concepts.>

## 3. Core Business Rules & Domain Invariants
*Non-negotiable domain rules. Agents must NEVER violate these in any feature or PR. Synced from 01-requirements.md during Finalize.*
- **BR-1 (<Rule Name>):** <State or lifecycle rule, e.g. "Draft records have no workflow status until activated.">
- **BR-2 (<Rule Name>):** <Validation or calculation rule, e.g. "Coupons cannot reduce order total below $0.00.">
- **BR-3 (<Rule Name>):** <Security or tenant rule, e.g. "Archived records cannot be modified or re-activated.">

<!-- Optional: For complex multi-condition calculations or state transitions, use a Boundary Truth Table:
| Condition A | Condition B | Expected Result | Rule / Invariant |
| :--- | :--- | :--- | :--- |
| Active User | Order Total > $50 | 10% Discount Applied | BR-Promo-1 |
-->

## 4. Features & Current State
*The single source of truth for all built capabilities. Update this section after completing Finalize for each feature.*

### <Feature Name>
*<1-sentence summary of the feature and its primary entry route (e.g. `/cases`).>*
- **Views & Data Density:** <Description of views, tables, or cards and their data density.>
- **Filters & Search:** <Specific filter dropdowns, search inputs, pills, or sorting options.>
- **Actions & Dialogs:** <Key buttons, dialogs, drawers, or state change actions available to users.>

## 5. Key Architecture & File Touchpoints
*Primary codebase anchors so agents can locate code instantly during Brainstorm pre-flight research.*
- **Module Root:** `<path/to/module>`
- **Controllers / State:** `<...Controller / ...Provider / ...Bloc>`
- **Repositories / Services:** `<...Repository / ...Service>`
- **Database Collections / Schemas:** `<collection_name or table_name>`
- **Primary Routes:** `<e.g. /cases, /cases/:id>`

## 6. Scope Boundaries & Dependencies
- **Dependencies:** <What other modules, services, or design systems this module consumes (e.g. reads Auth for user identity, uses Design System components).>
- **Out of Scope:** <What this module explicitly delegates to other domains (e.g. does not handle billing; delegates to Billing module).>
- **Deferred:** <Planned future capabilities explicitly postponed.>
