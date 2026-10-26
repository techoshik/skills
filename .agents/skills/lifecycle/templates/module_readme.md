# Module: <Module Domain Name>

<!-- 
DOCUMENT FORMATTING RULE (STRICT):
- ONE FACT PER LINE: Never write multi-sentence paragraphs inside a bullet point.
- Break concepts, schemas, and dependencies into short, scannable nested sub-bullets (1 line = 1 atomic detail).
-->

## 1. Purpose & Business Domain
- **Domain Owned:** <1-line description of what business domain this module owns>
- **Core Responsibility:** <1-line description of why this module exists>

## 2. Shared Concepts & Data Models
*Cross-reference `GLOSSARY.md` for project-wide domain language.*
- **`<Core Model / Entity 1>`:**
  - Role in Domain: <1-line purpose>
  - Source File: `<path/to/model.ext>`
- **`<Core Model / Entity 2>`:**
  - Role in Domain: <1-line purpose>
  - Source File: `<path/to/model.ext>`

## 3. Database Collections & Storage Schemas
- **`<collection_or_table_name>`:**
  - Ownership: Owned exclusively by this module.
  - Document / Row Key: `<e.g. auto-id, userId, tenantId:shopId>`
  - Primary Indexes: `<Composite index or partition key>`

## 4. Feature Directory Index
*Each substantive capability is documented in its own dedicated feature file in this directory.*
- **[`feature_<name_1>.md`](feature_<name_1>.md):** <1-line summary of what capability 1 provides>
- **[`feature_<name_2>.md`](feature_<name_2>.md):** <1-line summary of what capability 2 provides>

## 5. Scope Boundaries & Cross-Module Dependencies
- **Consumes from Other Modules:**
  - `<Other Module / Service>`: <What data or event it reads/consumes>
- **Exposes to Other Modules:**
  - `<Service / Stream / Event>`: <Public API or events exposed to callers>
- **Strictly Out of Scope (Delegated):**
  - `<Capability>`: <Which module owns this responsibility instead>
- **Deferred (Future Backlog):**
  - `<Deferred Feature Idea>`: <1-line summary and reason deferred from 01-requirements.md>
