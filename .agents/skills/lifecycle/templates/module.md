# Module: <Module Name>

## 1. Purpose
<1–2 plain-English sentences explaining what business domain this module owns and why it exists.>

## 2. Key Concepts & Entities
*Core business concepts owned by this module. Cross-reference `GLOSSARY.md` for shared project terms.*
- **<Concept / Entity>**: <What this represents in the real world and its role in this module.>
- **<Concept / Entity>**: <Description and relation to other concepts.>

## 3. Core Business Rules
*Non-negotiable domain rules. Agents must NEVER violate these in any feature or PR.*
- <Rule 1: State or lifecycle rule (e.g., "Draft records have no workflow status until activated.")>
- <Rule 2: Validation or permission rule (e.g., "Cannot activate without all required roles assigned.")>
- <Rule 3: Security or data rule (e.g., "All mutations must execute via backend Cloud Functions.")>

## 4. Features & Current State
*The single source of truth for all built capabilities. Update this section after completing Refine for each feature.*

### <Feature Name>
*<1-sentence summary of the feature and its primary entry route (e.g. `/cases`).>*
- **<Sub-Feature / View>:** <Description of views, tables, or cards and their data density.>
- **<Sub-Feature / Filters & Search>:** <Specific filter dropdowns, search inputs, pills, or sorting options.>
- **<Sub-Feature / Actions>:** <Key buttons, dialogs, drawers, or state change actions available to users.>

## 5. Scope & Dependencies
- **Dependencies:** <What other modules, services, or design systems this module consumes (e.g., reads Auth for user identity, uses Design System components).>
- **Out of Scope:** <What this module explicitly delegates to other domains (e.g., does not handle billing; delegates to Billing module).>
- **Deferred:** <Planned future capabilities explicitly postponed.>
