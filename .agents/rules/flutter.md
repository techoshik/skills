# Flutter Architecture Rules & Invariants

> [!IMPORTANT]
> **MANDATORY FRONTEND RULES — STRICT ENFORCEMENT**
> Every requirement is a strict system invariant. Creating `StatefulWidget`, bypassing Direct Client SDK, exceeding the 1000-line hard limit, embedding queries in UI, or placing display logic in widgets is STRICTLY PROHIBITED. Production access or deployment requires explicit user authorization; use emulators/dev environments for automated testing.

## 1. Direct Firebase Client SDK First (Hard Invariant)
Application clients MUST interact directly with Firestore and Firebase Storage via Client SDK protected by server-side `firestore.rules`.
- **Direct SDK Default:** Standard CRUD (create, read, update, delete drafts, upload attachments) MUST use the client SDK. Wrapping standard operations in Cloud Functions is STRICTLY PROHIBITED (adds cold starts, eliminates offline caching, increases latency).
- **The 5 Strict Cloud Function Exceptions:** Cloud Functions are permitted ONLY for:
  1. *Atomic Counters:* Gap-free, sequential IDs (e.g. order/invoice numbers) where client generation risks collisions.
  2. *Private Secrets:* External APIs (e.g. payment processors, external communication services) requiring hidden credentials.
  3. *Privileged Lifecycle Locks:* Freezing immutable multi-collection snapshots upon state transitions.
  4. *Asynchronous Triggers:* Background events (storage uploads, webhooks).
  5. *Complex Aggregations:* Multi-document batch operations exceeding Security Rules limits (10 `get()` calls).

## 2. Model-Driven UI & Component Boundaries
- **No UI Logic in Widgets:** Widgets are renderers. Raw string manipulation, status mapping, and date formatting in UI are STRICTLY PROHIBITED. Encapsulate all display logic in module models via getters, methods, or enum extensions (e.g. `role.displayName`).
- **Presentational Widgets vs. Self-Contained Feature Sections:**
  - *Reusable Presentational Widgets:* Cards, list rows, dialogs, and form controls MUST NOT call `ref.watch`/`ref.read` or import controllers/use-cases. Pass only plain module models, primitives, and callbacks (`VoidCallback`, `ValueChanged<T>`).
  - *Root Screens & Self-Contained Feature Sections:* Root screens (`<feature>_page.dart` / `<feature>_screen.dart`), composite views (`<feature>_view.dart`), and independent module sections (`<section>_section.dart` managing their own edit/save lifecycle) may watch providers and orchestrate state directly so parent screens stay decoupled and under 1000 lines.

## 3. StatelessWidget & HookConsumerWidget Only (`StatefulWidget` & `HookWidget` Prohibited)
- **Strict Two-Widget Rule:** Creating `StatefulWidget`, `State`, `ConsumerWidget`, `ConsumerStatefulWidget`, or standalone `HookWidget` classes is STRICTLY PROHIBITED. Every widget MUST use one of two base classes:
  1. **`StatelessWidget`:** For pure presentational components with no local state, hooks, or Riverpod provider access.
  2. **`HookConsumerWidget`:** For all screens, feature sections, and components using Flutter Hooks (`useState`, `useTextEditingController`, `useEffect`) or Riverpod (`WidgetRef ref`). Using `HookConsumerWidget` directly avoids refactoring base classes and `build(context, ref)` signatures when adding hooks or providers later.
- **Declarative Hooks Lifecycle:** Use Flutter Hooks exclusively:
  - Text controllers: `useTextEditingController()` (never manually call `new` or `.dispose()`).
  - Local state: `useState<T>(initialValue)`.
  - Keys/memoization: `useMemoized(() => GlobalKey<FormState>())`.
  - Focus nodes: `useFocusNode()`.
  - Subscriptions/timers: `useEffect(...)` returning a cleanup cancel callback.
  - Scroll/tab: `useScrollController()`, `useTabController(...)`.
  Hooks automatically dispose resources on unmount, eliminating memory leaks.

## 4. 4-Tier Placement & File-Size Thresholds
- **File-Size Thresholds (single definition — every lifecycle skill and template refers here):**
  - *Evaluate threshold — 900 lines:* A handwritten file above this MUST be evaluated for a split along natural module seams before more code is added.
  - *Hard limit — 1000 lines:* A handwritten file MUST NOT exceed this. If a task would cross it, split first, or record a user-approved exception in `lifecycle/01-discover.md` (under `## 4. Key Decisions & Rationale`).
  - Generated files (`*.g.dart`, `*.freezed.dart`) are exempt.
- **4-Tier Placement Rule:**
  - *Tier 1 (Same File — Default):* Feature child widgets MUST be private classes (`class _SectionCard extends StatelessWidget`) in the same feature file to preserve locality of reference.
  - *Tier 2 (Feature Sub-Widgets):* Extract to `features/<feature>/widgets/<widget>.dart` ONLY if independently complex (>200 lines) and the main file exceeds ~900 lines. Do not create `widgets/` by default.
  - *Tier 3 (Module-Shared):* Reused across 2+ features in the same module -> `modules/<module>/widgets/`.
  - *Tier 4 (Universal):* Reused across multiple modules -> `core/widgets/` or design system.

## 5. State Management (Riverpod & Freezed)
- **Code-Generated Providers Only:** Use code-generated Riverpod (`@riverpod` / `@Riverpod(keepAlive: true)` with `part '<file>.g.dart';`). Legacy manual providers (`StateNotifierProvider`, etc.) are BANNED.
- **Freezed State Classes:** UI state MUST be immutable `@freezed` classes with private `const StateName._();` constructor for getters.
- **Async Mutations:** Model mutations as nullable `AsyncValue<void>?` fields (e.g. `saveOperation`). Never use fragmented boolean flags (`isLoading`, `isSuccess`, `isError`).
- **Primitive Family Keys:** Family provider arguments MUST be primitive IDs (`String id`), NEVER module entity objects.
- **Ref Usage Rules:**
  - `ref.watch`: Unconditionally at top of `build()`. NEVER inside branches, loops, or callbacks.
  - `ref.read`: Inside callbacks (`onPressed`) or controller event handlers. NEVER inside `build()`.
- **Single Intent Dispatch:** One user action -> one controller notifier call. Widgets MUST NOT coordinate multiple calls, derive workflow decisions, or import from `use_cases/`.
- **No Pass-Through Providers:** Do not create thin wrapper providers that only forward repository calls.
- **Scoped Listeners (`ref.listen`):** Trigger one-time side effects (loaders, toasts, post-mutation navigation) reactively via `ref.listen` in `build()` observing the controller's `AsyncValue<void>?` operation field using `next?.whenOrNull(...)`. Never imperatively `await` a controller mutation and inspect a boolean return value inside widget callbacks to drive UI feedback.

## 6. Transport, Persistence & Fail-Closed Parsing
- **Callable Transport:** Callable request/response contracts MUST be JSON-compatible. Timestamps in callables MUST use `{seconds, nanoseconds}` UTC JSON format—NEVER raw SDK `Timestamp` objects. Map to UTC `DateTime` at the repository boundary.
- **Enums Over Primitives:** Use `@JsonValue`-annotated Dart enums with extensions/properties for states, roles, types, and discrete visual/formatting options (alignments, levels, variants, layout modes) — never raw `String`s or `int` codes.
- **Cohesive Value Objects:** Group tightly coupled multi-field domain configurations (such as page geometry/margins, dimensions, or address/range settings) into dedicated immutable Freezed value objects rather than scattering individual fields across the parent entity root.
- **Deserialization Invariants:** Optional fields MUST specify `@Default(...)`. Non-critical enums use `@JsonKey(unknownEnumValue: ...)`. Security-critical identifiers, roles, tenant keys, and mandatory fields MUST fail closed on invalid or unrecognized values—NEVER use permissive fallbacks.

## 7. Functional Error Handling & Pure Module Validators
- **Functional Results:** Repositories and use cases MUST return `Either<PlatformFailure, T>` via `fpdart`. Catch and map exceptions to `PlatformFailure` at the repository boundary. NEVER throw unhandled exceptions across architectural layers.
- **Dedicated Pure Module Validators (`<module>_validator.dart`):** All pure module validation, eligibility filtering, and business-rule calculations MUST live in `modules/<module>/<module>_validator.dart` (or module model methods) returning `Option<String>`, error enums, or filtered lists. Creating ad-hoc `*_filter.dart` or `*_helper.dart` files inside `features/` is STRICTLY PROHIBITED. Validators MUST NEVER throw exceptions.

## 8. UI & Design System Conventions
- **Single Source of Truth:** All colors, typography (`textTheme`), spacing tokens, icon sizes, canonical `Thanks*` widgets, and prohibited UI APIs live in [`design_system.md`](design_system.md). Follow every token and widget rule there with zero custom `Color(...)`, `TextStyle(...)`, `EdgeInsets.*(...)`, `SizedBox(width/height: ...)`, or `Icon(size: ...)`.
- **Navigation Decoupling:** Route navigation MUST go through the module's `<module>_navigation.dart` extending `ThanksNavigator`, and all dialog dismissals and back-navigation actions MUST use `ThanksNavigator.pop(...)`. Raw route strings (`context.go('/...')`) and direct `Navigator.of(context)` calls in widgets and dialogs are BANNED.

## 9. Folder Structure (`app/lib`)
- **`core/`**: Universal infrastructure: `routing/`, `navigation/`, `errors/`, `validators/`, `utils/` (pure, stateless cross-module helpers), `adapters/` (single canonical home for third-party SDK/API wrappers so any module can reuse them without migration; no shallow pass-through wrappers per `deep_modules.md`), `widgets/`. No module-specific business logic.
- **`modules/<module>/`**: Module-driven feature sets:
  - `models/`: Freezed entities, enums, DTOs, request/response contracts.
  - `use_cases/`: Business logic returning `Either<PlatformFailure, T>`. Widgets never import here.
  - `services/`: Optional pure domain engines (resolvers, compilers, calculators) with descriptive, single-purpose names — never a catch-all `<module>_service.dart`.
  - `features/<feature>/`: `<feature>_page.dart` / `<feature>_view.dart`, `<feature>_state.dart`, private child widgets (Tier 1).
  - `widgets/`: Module-shared widgets and self-contained sections (Tier 3).
  - `<module>_navigation.dart`: Module route definitions extending `ThanksNavigator`.
  - `<module>_repository.dart`: Data persistence contracts and Firestore implementations.
  - `<module>_validator.dart`: Pure module validation, eligibility filtering, and business rules.
  - `<module>_constants.dart`: Dedicated module constants container for collection paths, field names, and runtime status/query constants. All queries and lookups MUST consume constants from this file—never raw string literals.
  - `<module>_contract.dart`: Mandatory public module boundary contract serving as the sole gateway for external callers (exposing public Riverpod providers, navigation contracts, and repository interfaces; replaces `<module>_providers.dart`).
