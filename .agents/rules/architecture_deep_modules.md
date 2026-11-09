# Deep Modules & Boundary Contracts Rules

> [!IMPORTANT]
> **MANDATORY ARCHITECTURAL RULES — STRICT ENFORCEMENT ACROSS FRONTEND & BACKEND**
> These invariants govern both Flutter client code and backend Cloud Functions. Shallow pass-through abstractions, leaking private module internals, cross-module database querying, and reading generated files are STRICTLY PROHIBITED.

---

## 1. Public Boundary Contract Law (`<module>_contract`)
Every module MUST expose a single, explicit public contract file—named `<module>_contract` identically across both platforms—that serves as the sole gateway for external callers:
- **Unified Cross-Platform Contract File:**
  - **Frontend (Flutter):** `modules/<module>/<module>_contract.dart`
  - **Backend (Cloud Functions):** `modules/<module>/<module>_contract.ts`
- **Frontend (Flutter):** External features and modules MUST consume only `modules/<module>/<module>_contract.dart`:
  - `<module>_contract.dart` serves as the single public gateway, directly exposing public Riverpod state providers, navigation routes, and repository contracts. A separate `<module>_providers.dart` file is ELIMINATED because `<module>_contract.dart` handles this exact purpose.
  - Directly importing private feature files, internal controllers (`features/<feature>/<feature>_controller.dart`), internal presentation widgets, or private use cases across module boundaries is STRICTLY PROHIBITED.
- **Backend (Cloud Functions / Microservices):** External modules and entrypoints MUST consume only `modules/<module>/<module>_contract.ts`:
  - `<module>_contract.ts` serves as the single public gateway, directly exposing public repository contracts, callable command interfaces, public schemas/types, and public domain services (re-exported by `index.ts` if needed).
  - Directly importing from another module's internal directories (`src/internal/`, `src/helpers/`, `src/adapters/`, `use_cases/`) is STRICTLY PROHIBITED.

---

## 2. Cross-Module Direct Database Access Ban
A module strictly owns its database collections, tables, and documents.
- **No Direct Remote Queries:** Module $B$ MUST NEVER reach into Module $A$'s database collection or table directly (e.g. `FirebaseFirestore.instance.collection('users')` called from `order_service` is STRICTLY PROHIBITED).
- **Contract Access Only:** Cross-module data workflows MUST consume the owning module's public repository contract or public callable interface.
- **Schema Isolation:** If Module $A$'s internal database schema changes, zero external modules should require code modifications.

---

## 3. Anti-Shallow Pass-Through Invariant
A module or class MUST provide substantial internal capability behind its interface. Shallow wrappers that merely pass calls through are banned.
- **No Pass-Through Wrappers:** If a class, helper, provider, or function does nothing except forward parameters to an underlying method without transforming state, enforcing business invariants, or handling errors, creating that wrapper file is STRICTLY PROHIBITED. Call the underlying service or repository directly.
- **No Layer-Cake Fragmentation:** Avoid splitting a simple vertical capability across 5 boilerplate files (`controller -> service -> manager -> adapter -> repository`) where each layer only forwards calls. Implement the capability cleanly within the vertical domain owner.

---

## 4. Intent-Driven Interfaces Over Step-by-Step Plumbing
Interfaces MUST expose high-level business *intents*, hiding multi-step procedural coordination deep inside the module.
- **Single Intent Dispatch:** An interface should accept what the user or system wants to achieve (e.g. `checkout({ cartId, paymentMethodId })`), rather than forcing callers to orchestrate sequential procedural steps (`validateCart()`, `reserveStock()`, `calculateTax()`, `executePayment()`, `clearCart()`).
- **Deep Failure Handling:** Validation, concurrency guards, atomic locks, rollback policies, and error recovery MUST be encapsulated deep inside the module—never leaked to the caller.

---

## 5. Part-File & Generated Code Blindfold (AI Context Protection)
Generated files exist solely as opaque build artifacts for compilers and bundlers.
- **The Blindfold Rule:** AI Agents MUST NEVER open, read, edit, or debug generated files (`*.g.dart`, `*.freezed.dart`, `*.pb.dart`, generated ORM/OpenAPI clients) directly.
- **Handwritten Source of Truth:** Agents inspect and modify only handwritten source files. All serialization, copyWith, and equality logic is generated automatically via build tools (`dart run build_runner build` / `npm run build`).
- **Line Limit Exemption:** All generated files are exempt from file-size thresholds.

---

## 6. Deep Repositories & Functional Error Boundaries
Repositories MUST perform deep data handling and boundary defense before returning results.
- **Clean Domain Entities:** Repositories MUST return domain models or immutable entity objects. Returning raw database cursors, `DocumentSnapshot`, or unparsed HTTP payloads across layer boundaries is STRICTLY PROHIBITED.
- **No Leaked Persistence Exceptions:** Repositories MUST catch network, timeout, and database exceptions at the boundary and map them to domain failures (e.g. returning `Either<PlatformFailure, T>` via `fpdart` in Flutter, or structured domain errors in backend services). Unhandled database exceptions must never leak to controllers or UI.
