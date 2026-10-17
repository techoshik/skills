# Cloud Functions Architecture Rules & Invariants

> [!IMPORTANT]
> **MANDATORY BACKEND RULES — STRICT ENFORCEMENT**
> Creating Cloud Functions for standard CRUD operations is STRICTLY PROHIBITED. All Firestore reads/writes must use Client SDK backed by Security Rules unless satisfying the 5 explicit exception criteria defined in [architecture_common.md](architecture_common.md#direct-firebase-client-sdk-first-cloud-functions-strictly-on-exception). Checkpoints violating these rules will fail review.

## Direct Firebase Client SDK First & Permitted Scope

Per the project-wide principle in [architecture_common.md](architecture_common.md#direct-firebase-client-sdk-first-cloud-functions-strictly-on-exception), clients MUST communicate directly with Firestore and Firebase Storage via the Client SDK backed by Security Rules.

- **CRUD Wrappers Prohibited:** Cloud Functions MUST NOT be created or used for standard get/set/update/delete operations or pass-through database wrappers.
- **Strict Exception-Only Scope:** A Cloud Function callable, HTTP endpoint, or background trigger is ONLY permitted when fulfilling one of the architectural exception criteria defined in [architecture_common.md](architecture_common.md#direct-firebase-client-sdk-first-cloud-functions-strictly-on-exception) (centralized atomic sequence counters, private secrets / external APIs, privileged cross-collection lifecycle locks, asynchronous system triggers, or complex aggregations exceeding Security Rules limits).

## Strict Model Adherence & Remote Contract Literals

- Backend models represent the absolute source of truth. Incoming request objects (DTOs) MUST strictly map into internal domain models.
- Backend models and validators MUST explicitly reject unknown or caller-controlled lifecycle/tenant fields. Silently ignoring or passing through unvalidated payload fields is STRICTLY PROHIBITED.
- **Ban on Raw Contract Literals:** External contract names, callable names, request payload keys, Firestore/Storage paths, persisted collection names, persisted field names, and persisted values MUST live once in an owner-owned module contract container (`*_constants.ts` or `*_models.ts`).
  - Raw string literals in Firestore reads, writes, collection queries (`.where()`, `.orderBy()`, `.select()`, `.collection()`, `.collectionGroup()`), or callable handlers are STRICTLY PROHIBITED.
  - Map remote records at the repository boundary; typed models MUST NOT permit direct snapshot-property access with raw field-name strings.
  - Audit command:
    ```sh
    git grep -nE "(request\.data|data\(\)|\.set\(|\.update\(|https\.onCall|onCallHandler|collection\(|firestore\.doc\(|storage\.(ref|bucket))[^;]*['\"]" -- functions/src
    ```
- **Static Model Constants:** Static constants in `*_models.ts` MUST be declared as `static readonly`, never mutable `static`.
- **Node Runtime:** The active Node runtime MUST be `nodejs22` in `firebase.json` and engine `"22"` in `functions/package.json`.

## Multi-Tenancy & Authorization (Admin SDK Security)

- **Admin SDK Bypasses Security Rules:** Firestore Security Rules DO NOT protect Admin SDK operations. Every server callable, trigger path, and background job MUST perform its own explicit authorization and tenant check before any read or write.
- **Authentication ≠ Tenant Access:** The actor's identity, `agencyId`, role, permissions, and session MUST ALWAYS be derived from the trusted authenticated server context (`context.auth` / `CommandContext`). Client-supplied tenant IDs or user roles in the payload MUST NEVER be trusted.
- **Tenant Isolation:** Every tenant record has one immutable owning Agency. Cross-agency access MUST fail closed immediately.
- **Backend-Only Records:** Backend-only collections and records MUST NEVER be client-readable or exposed to client SDKs.
- **Pure Validation Before Side Effects:** Input and domain validation MUST execute prior to initiating any protected side effects, external API calls, or database writes.

## Separation of Concerns & Single Repository Contract

- **Use Cases vs Repositories:** Domain logic, authorization, and validation MUST happen in the Use Case layer (`use_cases/`). Callable handlers MUST act only as thin dispatchers; repositories strictly handle data access and persistence via Firebase Admin SDK.
- **Single Repository per Module:** All Firestore reads/writes for a module MUST belong to its single `<module>_repository.ts`. Creating sibling `*_lookup.ts`, `*_store.ts`, `*_reader.ts`, or `*_writer.ts` files is STRICTLY PROHIBITED. Agents MUST add typed repository methods or extend the public interface instead.
- **Cross-Module Access:** Cross-module workflows MUST consume the other module's public repository contract or compose injected repository interfaces inside use cases. Direct Firestore collection/document access across module boundaries is STRICTLY PROHIBITED.

## Transport vs. Persistence Separation

- **Firestore Persistence:** Persist `DateTime` as Firestore Admin SDK `Timestamp`. Server timestamps MUST be used for create/update/delete metadata.
- **Callable Transport:** Callable request and response contracts MUST be strictly JSON-compatible and MUST NEVER accept or return raw Admin SDK objects (such as `Timestamp`).
  - Use the JSON shape `{seconds, nanoseconds}` for timestamp values at the callable boundary.
  - Normalize incoming values to UTC before persistence.
  - Serialize outgoing Firestore timestamps back to the agreed JSON shape.
- Invalid timestamps or protected enum values MUST yield typed validation failures—NEVER permissive fallback defaults or server current time.

## Error Handling, Logging & Secrets

- **Safe Error Mapping:** Map module and technical errors once to safe `HttpsError` responses at the callable boundary. Raw database exceptions, stack traces, storage errors, or internal service errors MUST NEVER be returned to clients.
- **Information Leakage:** Secrets, tokens, credentials, PII, and protected internal decisions MUST NEVER appear in client error responses or operational logs.
- Use structured, minimal operational logs with sensitive data masked or omitted.

## Concurrency & Atomicity

- Multi-document writes MUST use atomic operations (Transactions via `runTransaction`, Batched Writes via `batch.commit()`) to prevent partial failures.
- **Optimistic Concurrency:** Updates to mutable entities MUST utilize optimistic concurrency (e.g., `expectedRevision` / `revision` fields) to prevent lost updates from concurrent writers.
- **Idempotency:** Unsafe or non-idempotent operations MUST implement idempotency keys or transaction checks to prevent duplicate execution.

## Folder Structure (`functions/src`)

The backend mirrors the domain modularity of the frontend, isolating logic into use cases and repositories:

- **`functions/src/core/`**: Infrastructure, middleware, `CommandContext`, auth resolution, shared persistence helpers, and base `PlatformFailure` errors.
- **`functions/src/modules/<domain_name>/`**: Domain-driven backend services.

Within each backend module, follow this internal structure:

- **`<domain>_models.ts`**: TypeScript interfaces, enums, and classes representing Firestore schemas and payload DTOs (strict source of truth). Static constants MUST be `static readonly`.
- **`<domain>_constants.ts`**: Collection names, field names, callable names, and query constants.
- **`use_cases/`**: Contains `<verb>_<noun>_use_case.ts` files containing business rules, authorization, and validation.
- **`<domain>_repository.ts`**: Contains data-access class handling Firestore `get`, `set`, transactions, and batched writes via Firebase Admin SDK.
- **`<domain>_validators.ts`**: Pure validation functions and schemas.
- **`<domain>_commands.ts`**: Callable request/response contracts and payload readers.
- **`<domain>_functions.ts`**: HTTP/Callable entry points that parse requests and dispatch to Use Cases.
- **`<capability>_adapter.ts`**: Optional external capability implementations (e.g., storage, virus scanning).
- **`index.ts`**: Public module boundary.

- **General Principle**: Do not create flat structures. Group related logic appropriately and do not leak implementation details.
