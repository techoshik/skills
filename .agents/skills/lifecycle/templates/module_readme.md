# Module: <Module Name>

<!-- 
DOCUMENT FORMATTING RULE (STRICT):
- ONE FACT PER LINE: Never write multi-sentence paragraphs inside a bullet point.
- Break concepts, schemas, and dependencies into short, scannable nested sub-bullets (1 line = 1 atomic detail).
-->

## 1. Purpose & Module Scope
- <1-line summary of what business area and core responsibility this module owns>

## 2. Shared Concepts & Data Models
*Cross-reference `GLOSSARY.md` for project-wide terminology.*
- **`<Core Model / Entity>`** (`<path/to/model.ext>`): <1-line purpose in module>

## 3. Database Collections & Storage Schemas
- **`<collection_or_table_name>`** (`key: <e.g. auto-id, userId>`): <1-line purpose and primary indexes>

## 4. Feature Directory Index
- **[`feature_<name_1>.md`](feature_<name_1>.md):** <1-line summary of capability 1>
- **[`feature_<name_2>.md`](feature_<name_2>.md):** <1-line summary of capability 2>

## 5. Scope Boundaries & Cross-Module Dependencies
- **Consumes:**
  - `<Other Module / Service>`: <What data or event it reads/consumes>
- **Exposes:**
  - `<Service / Stream / Event>`: <Public API or events exposed to callers>
- **Out of Scope (Delegated):**
  - `<Capability>`: <Which module owns this responsibility instead>
- **Deferred (Future Backlog):**
  - `<Deferred Feature Idea>`: <1-line summary and reason deferred>
