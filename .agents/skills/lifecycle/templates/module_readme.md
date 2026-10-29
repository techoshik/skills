# Module: <Module Name>

<!--
DOCUMENT FORMATTING RULE (STRICT):
- SCANNABLE SUB-BULLETS: Keep bullets concise (1 line = 1 atomic detail). Avoid multi-sentence prose walls inside bullets.
-->

## 1. At a Glance
- **Purpose:** <1-line summary of what business area this module owns>
- **Owns:** <Core responsibilities or data>
- **Does not own:** <Important ownership boundary, when useful>

## 2. Shared Concepts & Data Models

Cross-reference `GLOSSARY.md` for project-wide terms and link to authoritative model definitions.

- **`<Core Model / Entity>`:**
  - File: `<path/to/model.ext>`
  - Description: <1-line purpose and why it matters in this module>

## 3. Data & Storage Schemas

Include only collections/tables and indexes that are important for understanding or safely changing the module.

- **`<collection_or_table>`** (`key: <e.g. auto-id, userId>`):
  - Purpose: <1-line purpose and key fields>
  - Indexes / consistency: <Critical index or consistency notes>

## 4. Feature Directory Index

- **[`feature_<name_1>.md`](feature_<name_1>.md):** <1-line capability summary>
- **[`feature_<name_2>.md`](feature_<name_2>.md):** <1-line capability summary>

## 5. Scope Boundaries & Cross-Module Dependencies

- **Consumes:**
  - `<Other Module / Service>`: <What data or event it reads/consumes>
- **Exposes:**
  - `<Service / Stream / Event>`: <Public API or contract exposed to callers>
- **Delegated ownership:**
  - `<Capability>`: <Which module owns this responsibility instead>
- **Deferred (Future Backlog):**
  - `<Deferred Feature Idea>`: <1-line summary and reason deferred>
