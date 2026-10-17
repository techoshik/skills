# Universal Architecture Rules & System Invariants

> [!IMPORTANT]
> **MANDATORY ARCHITECTURAL RULES — NOT ADVISORY GUIDELINES**
> Every requirement in this document is a strict, non-negotiable system invariant. Code that violates these rules (such as bypassing Direct Client SDK access, breaking layer encapsulation, leaking persistence primitives into UI, or exceeding the 500-line limit) is considered broken and will be rejected at checkpoint review.

These principles apply universally across all environments (Flutter frontend, Cloud Functions backend, scripts, and shared tooling).

## The "Why-Loop"

Before writing or refactoring any code block, agents MUST explicitly execute the "Why-Loop" in reasoning:

1. **Why does this logic belong here?**
2. Is there a more central, reusable, or testable domain layer (such as a shared domain model, validator, or repository) to own it?
3. What is the lifecycle and ownership boundary of this data?
4. **Action:** If the logic does not fundamentally belong to the current component, agents MUST move it to the appropriate model, validator, or service before implementing or completing the feature.

## Encapsulation & Reusability

- Business logic, calculations, status derivations, and display formatting MUST NEVER be duplicated across consumers.
- Centralize shared data transformations, status derivations, and formatting in the owning domain models (methods, getters, enum extensions) or pure domain utilities rather than duplicating them at usage sites.
- **Layer Isolation:** Presentation layers MUST NOT leak into domain or data layers. Persistence driver primitives (e.g., Firestore `DocumentSnapshot`, Admin SDK objects) MUST NEVER leak into presentation or business logic layers.

## Defensive Design & Fail-Closed Invariants

- **Defensive Schema Parsing:** Backward-compatible fields (e.g., newly introduced optional properties) MUST specify safe defaults or fallbacks when parsing older schema revisions.
- **Fail-Closed Security Invariants:** Security-critical identifiers (e.g., `agencyId`, authenticated user ID, tenant keys, and role permissions) and mandatory domain constraints MUST NEVER use permissive fallback defaults. Any malformed, missing, or unrecognized value on a protected field MUST fail closed immediately with an explicit validation error.
- If a data model change breaks compatibility, implement a migration or compatibility layer in the model parsing phase.

## Direct Firebase Client SDK First (Cloud Functions Strictly on Exception)

Applications follow a **Direct Firebase Client SDK First** architectural principle. Application clients (Flutter, Web) MUST interact directly with Firestore and Firebase Storage using the Client SDK, protected by server-side Firestore Security Rules (`firestore.rules`).

1. **Direct Firebase SDK Default:**
   - Standard CRUD operations (creating drafts, reading collections, updating editable records, discarding/deleting drafts, uploading attachments) MUST be performed directly via the client SDK.
   - Do NOT wrap standard Firestore read/write operations in Cloud Functions. Cloud Functions add unnecessary cold start latency (1–3s), eliminate client offline caching/persistence, complicate test surfaces, and increase operational costs.
   - **Security Invariant:** Firestore Security Rules execute exclusively on Google's backend infrastructure and CANNOT be bypassed by external scripts, curl, or malicious clients. Security rules MUST enforce tenant isolation (e.g., verifying active tenant or agency membership), lifecycle invariants (e.g., only draft records can be created or deleted directly), and immutable field integrity.

2. **When Cloud Functions ARE Strictly Required (Exceptions):**
   Creating or routing through a Cloud Function is ONLY permitted when one or more of the following technical requirements exist:
   - **Centralized Sequence & Atomic Counters:** Operations that generate gap-free, sequential human-readable numbers (e.g., `C-001`, `INV-001`) from a shared counter where client-side generation risks collisions, gaps, or clock skew.
   - **Private Secrets & External Third-Party APIs:** Operations that require secret credentials that must never be exposed to the client (e.g., Stripe payments, SendGrid/Twilio communications, external partner or government identity APIs).
   - **Privileged State Transitions & Irreversible Lifecycle Locks:** Operations that freeze immutable snapshots of referenced entities across multiple collections (e.g., activating a record, locking a submission, or taking frozen snapshots of referenced schemas, forms, and profiles, and validating that prerequisite requirements are completed).
   - **Asynchronous System Triggers & Webhooks:** Background jobs listening to system events (e.g., Storage file upload triggers, malware scanning, webhooks from third-party systems).
   - **Complex Cross-Collection Aggregations Exceeding Security Rules Limits:** Security rules have a hard limit of 10 `get()` lookups per evaluation. Multi-document batch processing or deep cross-collection traversals beyond rules capability belong in Cloud Functions.

## File Sizing & Single Responsibility: The 500-Line Soft Ceiling

To maintain maintainability, context window hygiene, and clean architectural boundaries:
- **The 500-Line Soft Ceiling:** Handwritten code files (controllers, services, repositories, models, or views) SHOULD NOT exceed ~500 lines of code. When a file approaches or crosses this limit, it is an architectural signal to evaluate for splitting.
- **Natural Seam Splitting (Never Arbitrary Math):** Split along natural domain or architectural boundaries:
  - *UI / Views:* Extract distinct modal dialogs, bottom sheets, filter panels, or complex card items into dedicated sub-widgets.
  - *Controllers / State:* Extract sub-domain logic into focused delegates, services, or separate sub-controllers (e.g., splitting a monolithic `CaseController` to delegate filtering or exports).
  - *Models:* Split nested DTOs or multi-entity definitions into their own files.
  - *Never Micro-Split:* Do not extract trivial 10–20 line helpers or simple widgets purely to shave line counts.
- **Exclusions:** Code-generated files (`*.g.dart`, `*.freezed.dart`, mock files) are exempt.

## Universal Error Handling & Validation

- **Functional Error Handling:** Repositories and use cases MUST use explicit success/failure result types (`Either<PlatformFailure, T>` in Dart/Flutter, typed result/failure objects in Cloud Functions), adhering to the platform's error contract. Application code MUST NOT throw unhandled exceptions across architectural layer boundaries.
- **Dedicated Pure Validators:** Domain validation logic MUST reside in dedicated, pure validator classes or functions. Validators MUST return explicit validation outcomes (e.g., error strings, failure enums, or `Option<String>`) and MUST NEVER throw exceptions.

## Sensitive Data & Information Leakage

- Secrets, private keys, authentication tokens, session cookies, passwords, and customer PII MUST NEVER appear in client-facing error responses, URL query parameters, or operational log outputs.

## Pre-handoff Review

Before declaring a code change ready or requesting approval, review the final diff and surrounding code in every changed handwritten file within the task's scope. Passing tests and static checks are necessary evidence where applicable; they do not establish simplicity or architectural compliance.

1. **Current rules:** Read the applicable `.agents/guidelines/` files, reusing unchanged content already read this session. Check each applicable rule against the changed code. Resolve conflicts using explicit user instructions and current project sources.
2. **Necessity and simplicity:** Trace each changed operation from its inputs to the result consumed by its caller. Remove avoidable repetition, discarded results, duplicate reads, redundant transformations, and pass-through abstractions. Compare the current implementation with the simplest equivalent alternative. Prefer readability and type safety over fewer lines; retain complexity only when it serves a concrete behavior or constraint.
3. **Behavior preservation:** For asynchronous or stateful changes, check concurrency, error propagation, types, loading/cleanup, and late results. For example, replacing repeated awaits with a combined result must account for heterogeneous result types and failure semantics. Verify unfamiliar API behavior against the installed source or authoritative documentation before choosing it.
4. **Verification & fix:** Resolve findings within the authorized scope before handoff. Run standard platform checks appropriate to the affected areas (e.g., `flutter analyze` and `flutter test` for Flutter; `npm run check` and `npm test` for Cloud Functions). Verify all code against the architectural guidelines during self-review. All analyzer errors, type mismatches, and test failures MUST be resolved before handoff. Keep unrelated refactoring outside the task.
5. **Evidence:** Record a concise review result in the existing checkpoint evidence, or in the handoff when no checkpoint exists: significant corrections or retained tradeoffs, checks actually run, and remaining gaps. Mark self-review complete only after all changed handwritten files have been reviewed and findings have been fixed or explicitly reported as unresolved.

Human review should focus on product intent and meaningful tradeoffs. Routine cleanup and compliance with documented rules remain the agent's responsibility. If human review finds a missed issue, inspect the current change for other instances of the same pattern before returning it.
