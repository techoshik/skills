---
trigger: model_decision
description: Explains the exact folder structure for ThanksVisa flutter and cloud functions and where new files (use cases, UI, models, repositories) belong.
---
# Folder Structure Conventions

This project strictly adheres to a domain-driven modular architecture. When generating or moving files, respect the boundaries between modules and the separation of concerns within each module.

## Flutter Frontend (`app/lib`)

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

## Cloud Functions Backend (`functions/src`)

The backend mirrors the domain modularity of the frontend, isolating logic into use cases and repositories.

- **`functions/src/core/`**: Infrastructure, middleware, `CommandContext`, and base `PlatformFailure` errors.
- **`functions/src/modules/<domain_name>/`**: Domain-driven backend services.
  
Within each backend module, follow this internal structure:
  - **`<domain>_models.ts`**: TypeScript interfaces and enums representing Firestore schemas and payload DTOs. These are the strict source of truth.
  - **`use_cases/`**: Contains `<action>_use_case.ts` files. This is where business rules, authorization, and validation happen before invoking a repository.
  - **`<domain>_repository.ts`**: Contains data-access classes handling Firestore `get`, `set`, transactions, and batched writes via the Firebase Admin SDK.
  - **`<domain>_validator.ts`**: Validation schemas or functions.
  - **`<domain>_commands.ts`**: (or `callable` handlers) The HTTP/Callable entry points that parse requests and dispatch to the Use Cases.

## General Principles
- Do not create flat structures. If a component grows, group its related files inside a dedicated feature folder.
- Do not leak repository implementation details (like Firestore `DocumentSnapshot`) into the UI or Use Cases.
