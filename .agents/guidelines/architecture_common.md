# Common Architectural Guidelines

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
