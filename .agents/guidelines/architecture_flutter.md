# Flutter Architecture Guidelines

## Model-Driven UI

- **No UI Logic in Widgets:** Widgets should only act as dumb renderers. Move all display logic, formatting, and computed properties into the respective Dart models (via getters or enum extensions).
- E.g. Instead of formatting a `Role` string inside a `Text` widget, add a `String get displayName` getter to the `Role` model.

## State Management

- Prefer keeping providers and state controllers simple. If a provider merely passes data through, check if it's strictly necessary or if the data can be watched directly.
- Avoid watching a provider inside a conditional statement or loop.

## Type Safety & Enums

- Prefer Dart Enums (with extensions/properties) over raw Strings for state, roles, and types to guarantee compile-time safety and exhaustiveness in `switch` statements.
- When parsing JSON models (e.g. with Freezed/json_serializable), use `@Default` for missing/null fields, and MUST use `@JsonKey(unknownEnumValue: Enum.fallback)` to explicitly handle unrecognized enum values from older/newer schemas.

## Folder Structure (`app/lib`)

The frontend is divided into core infrastructure and domain-specific modules.

- **`app/lib/core/`**: Application-wide infrastructure. Never put domain-specific business logic here. Contains:
  - `routing/` & `navigation/`: App router configs, deep links, and navigation guards.
  - `errors/`, `validators/`, `utils/`, `constants/`: Global utilities and base types (like `PlatformFailure`).
  - `widgets/`: Universal widgets used across the entire application.
- **`app/lib/modules/<domain_name>/`**: Domain-driven feature sets (e.g., `service`, `case`, `dynamic_form`, `agency`).

Within each module, follow this internal structure:

- **`models/`**: Data definitions. Contains `Freezed` classes, Enums, JSON serializable classes, and Command Request/Response objects.
- **`use_cases/`**: Business logic units. Receives data from the UI, applies authorization/validation rules, and orchestrates repository calls. Must return `Either<PlatformFailure, T>`.
- **`features/<feature_name>/`**: UI boundaries. Grouped by standard user-facing flows, prefixed by the module name to avoid confusing generic paths. Prefer these standard patterns (e.g., for a `user` module):
  - `features/user_list/` (for listing records)
  - `features/user_detail/` (for viewing a single record)
  - `features/user_form/` (for creating or editing records, rather than calling it `editor` or `creator`)
    Contains View files (Widgets/Pages) and their dedicated State controllers (Riverpod providers).
- **`widgets/`**: Reusable sub-components that span across multiple features within the same module. (If it only belongs to one feature, it should stay inside `features/<feature_name>/widgets/`).
- **`<domain>_repository.dart`**: Interfaces and implementations (Firestore) for data persistence.
- **`<domain>_validator.dart`**: Domain-specific validation logic (e.g., `ServiceValidator`).
- **`<domain>_constants.dart`**: Field names, collection paths, and magic strings.
- **`<domain>_navigation.dart`**: Module-specific navigation logic, route definitions, and deep link parsing.
- **`<domain>_providers.dart`**: Publicly exposed Riverpod providers for the module.

- **General Principle**: Do not create flat structures. If a component grows, group its related files inside a dedicated feature folder. Do not leak repository implementation details (like Firestore `DocumentSnapshot`) into the UI or Use Cases.
