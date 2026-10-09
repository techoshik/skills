# Cloud Functions Architecture Guidelines

## Strict Model Adherence

- Backend models represent the absolute source of truth. Ensure that incoming request objects (DTOs) strictly map into the internal domain models.
- Silently ignoring fields sent by a client (because the backend model isn't updated) is dangerous. Ensure the backend model matches the required schema from the frontend, or explicitly reject unknown fields if strictness is required.

## Separation of Concerns

- **Use Cases vs Repositories:** Domain logic and authorization must happen in the Use Case layer, while the Repository layer strictly handles data access and Firebase/Firestore specific operations.
- Avoid using Firestore specific types (like `Timestamp`) in the presentation or HTTP entry layers when possible; keep them contained in the repositories or specific mapping boundaries.

## Concurrency & Atomicity

- Use atomic operations (Transactions, Batched Writes) for multi-document writes to prevent partial failures.
- Utilize optimistic concurrency (e.g. `revision` fields) when updating entities to prevent lost updates from concurrent users.

## Folder Structure (`functions/src`)

The backend mirrors the domain modularity of the frontend, isolating logic into use cases and repositories.

- **`functions/src/core/`**: Infrastructure, middleware, `CommandContext`, and base `PlatformFailure` errors.
- **`functions/src/modules/<domain_name>/`**: Domain-driven backend services.

Within each backend module, follow this internal structure:

- **`<domain>_models.ts`**: TypeScript interfaces and enums representing Firestore schemas and payload DTOs. These are the strict source of truth.
- **`use_cases/`**: Contains `<action>_use_case.ts` files. This is where business rules, authorization, and validation happen before invoking a repository.
- **`<domain>_repository.ts`**: Contains data-access classes handling Firestore `get`, `set`, transactions, and batched writes via the Firebase Admin SDK.
- **`<domain>_validator.ts`**: Validation schemas or functions.
- **`<domain>_commands.ts`**: (or `callable` handlers) The HTTP/Callable entry points that parse requests and dispatch to the Use Cases.

- **General Principle**: Do not create flat structures. Group related logic appropriately and do not leak implementation details.
