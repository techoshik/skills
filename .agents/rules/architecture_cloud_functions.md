# Cloud Functions Architecture Rules & Invariants

> [!IMPORTANT]
> **MANDATORY BACKEND RULES — STRICT ENFORCEMENT**
> Creating Cloud Functions for standard CRUD operations is STRICTLY PROHIBITED. All Firestore reads/writes must use Client SDK backed by Security Rules unless satisfying the 5 explicit exception criteria. Production access or deployment requires explicit user authorization; use emulators/dev environments for automated testing.

## Direct Firebase Client SDK First & Permitted Scope
Clients MUST communicate directly with Firestore and Firebase Storage via Client SDK protected by server-side `firestore.rules`.
- **CRUD Wrappers Prohibited:** Cloud Functions MUST NOT be created or used for standard get/set/update/delete operations or pass-through database wrappers.
- **The 5 Strict Exceptions:** A Cloud Function callable, HTTP endpoint, or background trigger is ONLY permitted when fulfilling one of the following criteria:
  1. *Atomic Counters:* Gap-free, sequential human-readable numbers (`INV-001`) where client-side generation risks collisions.
  2. *Private Secrets:* Operations requiring hidden credentials (Stripe, Twilio, SendGrid, partner/government identity APIs).
  3. *Privileged Lifecycle Locks:* Operations freezing immutable snapshots across multiple collections upon state transitions.
  4. *Asynchronous System Triggers:* Background event listeners (storage upload processing, malware scanning, webhooks).
  5. *Complex Aggregations:* Multi-document batch processing exceeding Security Rules limits (10 `get()` calls).

## Strict Model Adherence & Remote Contract Literals
- **Module Source of Truth:** Backend module models represent the absolute source of truth. Incoming request objects (DTOs) MUST strictly map into internal module models.
- **Reject Unknown Fields:** Backend models and validators MUST explicitly reject unknown or caller-controlled lifecycle/tenant fields. Silently ignoring or passing through unvalidated payload fields is STRICTLY PROHIBITED.
- **Ban on Raw Contract Literals:** External contract names, callable names, request payload keys, Firestore/Storage paths, persisted collection names, and persisted field names MUST live once in an owner-owned module contract container (`*_constants.ts` or `*_models.ts`).
  - Raw string literals in Firestore reads, writes, collection queries (`.where()`, `.orderBy()`, `.select()`, `.collection()`, `.collectionGroup()`), or callable handlers are STRICTLY PROHIBITED.
  - Map remote records at the repository boundary; typed models MUST NOT permit direct snapshot-property access with raw field-name strings.
- **Static Model Constants:** Static constants in `*_models.ts` MUST be declared as `static readonly`, never mutable `static`.
- **Node Runtime:** Active Node runtime MUST be `nodejs22` in `firebase.json` and engine `"22"` in `functions/package.json`.

## Multi-Tenancy & Authorization (Admin SDK Security)
- **Admin SDK Bypasses Security Rules:** Firestore Security Rules DO NOT protect Admin SDK operations. Every callable, trigger path, and background job MUST perform its own explicit authorization and tenant check before any read or write.
- **Authentication != Tenant Access:** The actor's identity, `agencyId`, role, permissions, and session MUST ALWAYS be derived from the trusted authenticated server context (`context.auth` / `CommandContext`). Client-supplied tenant IDs or user roles in payloads MUST NEVER be trusted.
- **Tenant Isolation:** Every tenant record has one immutable owning Agency. Cross-agency access MUST fail closed immediately.
- **Backend-Only Records:** Backend-only collections and records MUST NEVER be client-readable or exposed to client SDKs.
- **Pure Validation Before Side Effects:** Input and module validation MUST execute prior to initiating any protected side effects, external API calls, or database writes.

## Separation of Concerns & Single Repository Contract
- **Use Cases vs Repositories:** Module business logic, authorization, and validation MUST happen in the Use Case layer (`use_cases/`). Callable handlers act only as thin dispatchers; repositories strictly handle data access and persistence via Firebase Admin SDK.
- **Single Repository per Module:** All Firestore reads/writes for a module MUST belong to its single `<module>_repository.ts`. Creating sibling `*_lookup.ts`, `*_store.ts`, `*_reader.ts`, or `*_writer.ts` files is STRICTLY PROHIBITED.
- **Cross-Module Access:** Cross-module workflows MUST consume the other module's public repository contract or compose injected repository interfaces inside use cases. Direct Firestore access across module boundaries is STRICTLY PROHIBITED.

## Transport vs. Persistence Separation
- **Firestore Persistence:** Persist `DateTime` as Firestore Admin SDK `Timestamp`. Server timestamps MUST be used for create/update/delete metadata.
- **Callable Transport:** Callable request and response contracts MUST be strictly JSON-compatible and MUST NEVER accept or return raw Admin SDK objects (such as `Timestamp`).
  - Use JSON shape `{seconds, nanoseconds}` for timestamp values at the callable boundary.
  - Normalize incoming values to UTC before persistence.
  - Serialize outgoing Firestore timestamps back to the agreed JSON shape.
- Invalid timestamps or protected enum values MUST yield typed validation failures—NEVER permissive fallback defaults or server current time.

## Concurrency, Atomicity & File-Size Thresholds
- **Multi-Document Writes:** MUST use atomic operations (Transactions via `runTransaction`, Batched Writes via `batch.commit()`) to prevent partial failures.
- **Optimistic Concurrency:** Updates to mutable entities MUST utilize optimistic concurrency (`expectedRevision` / `revision`) to prevent lost updates from concurrent writers.
- **Idempotency:** Non-idempotent operations MUST implement idempotency keys or transaction checks to prevent duplicate execution.
- **File-Size Thresholds (single definition — every lifecycle skill and template refers here):**
  - *Evaluate threshold — 400 lines:* A handwritten backend file above this MUST be evaluated for a split along natural module seams (separate use cases, dedicated validators, modular adapters) before more code is added.
  - *Hard limit — 500 lines:* A handwritten backend file MUST NOT exceed this. If a task would cross it, split first, or record a user-approved exception in `01-requirements.md` Section 5.

## Error Handling, Logging & Secrets
- **Safe Error Mapping:** Map module and technical errors once to safe `HttpsError` responses at the callable boundary. Raw database exceptions, stack traces, storage errors, or internal service errors MUST NEVER be returned to clients.
- **Information Leakage:** Secrets, tokens, credentials, PII, and protected internal decisions MUST NEVER appear in client error responses or operational logs.
- Use structured, minimal operational logs with sensitive data masked or omitted.

## Folder Structure (`functions/src`)
- **`core/`**: Infrastructure, middleware, `CommandContext`, auth resolution, shared persistence helpers, and base `PlatformFailure` errors.
- **`modules/<module_name>/`**: Module-driven backend services:
  - `<module>_models.ts`: Schemas and payload DTOs. Constants must be `static readonly`.
  - `<module>_constants.ts`: Collection names, field names, callable names, query constants.
  - `use_cases/`: `<verb>_<noun>_use_case.ts` containing business rules, authorization, and validation.
  - `<module>_repository.ts`: Data-access class handling Firestore `get`, `set`, transactions, and batches.
  - `<module>_validators.ts`: Pure validation functions and schemas.
  - `<module>_commands.ts`: Callable request/response contracts and payload readers.
  - `<module>_functions.ts`: HTTP/Callable entry points parsing requests and dispatching to Use Cases.
  - `<capability>_adapter.ts`: Optional external capability implementations.
  - `index.ts`: Public module boundary.

## Pre-Handoff Self-Review
Before declaring any backend task ready for human review:
1. **Rule Check:** Verify compliance against this document (Direct SDK First, no raw contract strings, Admin SDK tenant checks, single repository contract).
2. **Security & Secrets:** Confirm that tenant IDs come from `context.auth` and zero secrets or PII leak into client responses or logs.
3. **Simplicity:** Remove dead code, redundant queries, and unnecessary abstractions.
4. **Automated Verification:** Run `npm run lint` (0 issues) and `npm test` (100% passing).
5. **Diff Hygiene:** Inspect `git diff` to verify only authorized task files are modified.
