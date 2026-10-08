---
description: Universal architectural principles and critical thinking rules for all environments.
---
# Common Architectural Guidelines

These principles apply universally across all environments (frontend, backend, scripts).

## The "Why-Loop"
Before writing or refactoring any code block, explicitly run a "why-loop" in your reasoning process:
1. **Why does this logic belong here?** 
2. Is there a more central, reusable, or testable place (like a shared domain model) to put it?
3. What is the lifecycle and ownership of this data?
4. **Action:** If the logic does not fundamentally belong to the current component, move it to the appropriate model, utility, or service before implementing the feature.

## Encapsulation & Reusability
- Never duplicate business or formatting logic across multiple consumers.
- Centralize data transformations, status derivations, and display strings inside the data models themselves (e.g. getters, methods, or enum extensions) rather than at the usage site.

## Defensive Design
- Assume missing or malformed data for older schema revisions. Always implement safe fallbacks or default values when parsing models.
- If a data model change breaks compatibility, implement a migration or compatibility layer in the model parsing phase.

## Error Handling & Validation
- **Functional Error Handling:** Use `fpdart` and `Either<PlatformFailure, T>` (or the backend equivalent) for all Repositories and Use Cases. Do not rely on try-catch exception throwing across application layer boundaries.
- **Dedicated Validators:** All domain validation logic must reside in explicit `Validator` classes (e.g., `ServiceValidator`). Validators should return simple error strings (or Enums) instead of throwing exceptions.

## UI & Layout Conventions
- **Design System First:** Always use established design system components (e.g., `ThanksCard`, `ThanksSpacing`, `ThanksButton`) over raw UI primitives. Never hardcode padding or margins when a system constant exists.
- **Intrinsic Sizing:** Avoid hardcoding static heights (e.g., `SizedBox(height: 500)`). Rely on flex bounds (`Expanded`, `Flexible`) or allow child components to naturally size themselves (e.g., using `scrollable: false` on embeddable scroll views) to prevent layout overflows on different screen sizes.
