---
description: Flutter and Dart specific architectural principles and best practices.
---
# Flutter Architecture Guidelines

## Model-Driven UI
- **No UI Logic in Widgets:** Widgets should only act as dumb renderers. Move all display logic, formatting, and computed properties into the respective Dart models (via getters or enum extensions).
- E.g. Instead of formatting a `Role` string inside a `Text` widget, add a `String get displayName` getter to the `Role` model.

## State Management
- Prefer keeping providers and state controllers simple. If a provider merely passes data through, check if it's strictly necessary or if the data can be watched directly.
- Avoid watching a provider inside a conditional statement or loop.

## Type Safety & Enums
- Prefer Dart Enums (with extensions/properties) over raw Strings for state, roles, and types to guarantee compile-time safety and exhaustiveness in `switch` statements.
- When parsing JSON models (e.g. with Freezed/json_serializable), use `@Default` for new enum values to maintain backward compatibility with old local or backend data.
