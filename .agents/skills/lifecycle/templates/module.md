# Module: <Module Name>

<!-- 
DOCUMENT FORMATTING RULE (STRICT):
- ONE FACT PER LINE: Never write long paragraphs inside bullet points.
- Break concepts, rules, and feature details into short, scannable nested sub-bullets (1 line = 1 atomic detail).
- MODULAR DIRECTORY PATTERN (RECOMMENDED): For scalable modules, organize as a dedicated directory `docs/modules/<domain>/` with a `README.md` (using module_readme.md) and individual `feature_<name>.md` files (using module_feature.md) to prevent 1,000+ line monolithic files.
-->

## 1. Purpose & Business Domain
- **Domain Owned:** <1-line description of what business domain this module owns>
- **Core Responsibility:** <1-line description of why this module exists>

## 2. Key Concepts & Entities
*Cross-reference `GLOSSARY.md` for shared project terms.*
- **`<Concept / Entity>`:**
  - <1-line definition of what this represents>
  - Role in Module: <1-line description of how this module uses it>

## 3. Core Business Rules & Domain Invariants
*Non-negotiable domain rules synced from `01-requirements.md` during Finalize.*
- **BR-1 (`<Rule Name>`):**
  - <1-line state, validation, or calculation law>
  - Enforced in: <Where/how enforced>
- **BR-2 (`<Rule Name>`):**
  - <1-line security or lifecycle law>
  - Enforced in: <Where/how enforced>

<!-- Optional: For multi-condition calculations or state transitions, use a Boundary Truth Table:
| Condition A | Condition B | Expected Result | Rule ID |
| :--- | :--- | :--- | :--- |
| Active User | Order Total > $50 | 10% Discount Applied | BR-1 |
-->

## 4. Features & Current State
*Single source of truth for all built capabilities. Updated during Finalize.*

### <Feature / Capability Name>
- **Entry / Anchor:** `<e.g. Route /cases, or Service PaymentGateway>` — <1-line purpose>
- **Primary Components / Handlers:**
  - `<View, Controller, Service, or Worker>`: <1-line responsibility>
- **Key Workflows & Interactions:**
  - `<Action, Event, or API Call>`: <1-line state change or outcome triggered>

## 5. Key Architecture & File Touchpoints
- **Module Root:** `<path/to/module>`
- **Controllers / State:**
  - `<...Controller / ...Provider>`
- **Repositories / Services:**
  - `<...Repository / ...Service>`
- **Database Collections / Schemas:**
  - `<collection_name or table_name>`
- **Primary Routes:**
  - `<e.g. /cases, /cases/:id>`

## 6. Scope Boundaries & Dependencies
- **Consumes / Dependencies:**
  - `<Other Module / Service>`: <What it reads or uses>
- **Out of Scope (Delegated):**
  - `<Capability>`: <Which module owns it instead>
- **Deferred (Future):**
  - `<Planned Capability>`: <1-line summary>
