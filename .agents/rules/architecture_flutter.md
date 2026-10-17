# Flutter Architecture Rules & Invariants

> [!IMPORTANT]
> **MANDATORY FRONTEND RULES — STRICT ENFORCEMENT**
> Every requirement in this document is a strict, non-negotiable architectural invariant. Creating `StatefulWidget`, exceeding the 500-line soft ceiling, embedding database/persistence queries in UI, or placing display logic in widgets is STRICTLY PROHIBITED. Checkpoints violating these rules will fail review.

## Model-Driven UI & Dumb Presentational Widgets

- **No UI Logic in Widgets:** Widgets MUST act strictly as dumb renderers. UI widgets MUST NOT contain raw string manipulations, conditional status mapping, or date/time formatting inline. All display logic, computed properties, and formatting MUST be encapsulated in domain models (via getters, methods, or enum extensions).
  - _Example:_ Instead of formatting a `Role` string inside a `Text` widget, add a `String get displayName` getter or enum extension to the `Role` model.
- **Dumb Presentational Widgets:** Child and section widgets MUST be dumb `StatelessWidget` renderers. They MUST NOT call `ref.watch`, `ref.read`, or import feature controllers or use cases. They MUST receive only plain domain models, primitives, and callback handlers (`VoidCallback`, `ValueChanged<T>`). This decouples UI from state management, simplifies isolated testing, and enables UI catalog tooling (e.g., Widgetbook).
- **Single Controller Entry Point:** Only the root feature entry widget (`<feature>_page.dart` for routed screens or `<feature>_view.dart` for composite embedded views) is permitted to watch feature controllers and orchestrate state down to dumb children.

## Widget Lifecycle & State Management: StatelessWidget & HookWidget Only

- **`StatefulWidget` is STRICTLY PROHIBITED:** Creating Flutter `StatefulWidget` and `State` classes is strictly prohibited across the codebase. Manual lifecycle overrides (`initState`, `dispose`, `didUpdateWidget`, etc.) introduce boilerplate, resource leaks, and synchronization bugs.
- **Strict Two-Option Widget Rule:** Every widget MUST be implemented using one of the following two options:
  1. **Option 1 — `StatelessWidget` (When There Is No Local State):**
     - Use for all dumb presentational components, section cards, and views that do not manage local mutable state, controllers, or subscriptions.
     - Receives all models and event callbacks via constructor parameters.
  2. **Option 2 — `HookWidget` / `HookConsumerWidget` (When Handling Local State, Controllers, or Subscriptions):**
     - Use whenever a component manages local mutable state, form input controllers, focus nodes, animations, tab controllers, or subscription/timer lifecycles.
     - Use `HookWidget` for components that need hooks without direct Riverpod `WidgetRef` access.
     - Use `HookConsumerWidget` for components that need both hooks and Riverpod provider observation (`WidgetRef ref`).
- **Declarative Resource & Lifecycle Management via Hooks:** Always leverage Flutter Hooks rather than manual instantiation and disposal:
  - Text editing controllers: `useTextEditingController()` (NEVER manually instantiate `TextEditingController()` or call `.dispose()`).
  - Local transient state: `useState<T>(initialValue)`.
  - Memoized keys and objects: `useMemoized(() => GlobalKey<FormState>())`.
  - Focus nodes: `useFocusNode()`.
  - Side effects, timers, streams, or listeners: `useEffect(...)` (return a cleanup callback to cancel or dispose).
  - Tab and scroll controllers: `useTabController(...)`, `useScrollController()`.
- **Automatic Resource Cleanup:** Hooks automatically bind to the underlying element's lifecycle and cleanly dispose all controllers, timers, and subscriptions upon widget unmount, eliminating manual `.dispose()` boilerplate and memory leak risks.

## Component Organization & File Size (The 4-Tier Widget Placement Rule)

To prevent premature abstraction and file clutter, agents MUST strictly adhere to the **4-Tier Widget Placement Rule**:

- **Tier 1 — Private Classes in the Same File (Default):**
  - Child and section widgets specific to a feature MUST be written as private classes (`class _SectionCard extends StatelessWidget`) within the same `<feature>_page.dart` or `<feature>_view.dart` file.
  - This preserves locality of reference (reading the entire screen top-to-bottom without jumping across files) and eliminates boilerplate.
  - **File Size Guideline:** Keep UI files within ~300–400 lines. Agents MUST NOT extract child widgets into separate files unless the file genuinely exceeds this threshold or Tier 2 applies.
- **Tier 2 — Feature Sub-Widgets (Optional Extraction):**
  - Only when a specific child widget is independently complex (>150 lines) and causes the main file to exceed ~300–400 lines, extract it into `features/<feature_name>/widgets/<widget_name>.dart`.
  - Agents MUST NOT create a `widgets/` folder inside every feature by default.
- **Tier 3 — Module-Shared Widgets:**
  - When a component is reused by **2 or more features within the same module** (e.g., a status badge shared across list and detail features), place it in `modules/<module>/widgets/<widget_name>.dart`.
- **Tier 4 — Universal Application Widgets:**
  - Widgets used across multiple distinct modules MUST be placed in `app/lib/core/widgets/` or `thanks_design_system`.

## State Management (Riverpod & Freezed)

- **Code-Generated Providers:** Providers and state controllers MUST ALWAYS use code-generated Riverpod (`@riverpod` or `@Riverpod(keepAlive: true)` with `part '<file>.g.dart';`). Legacy manual providers (`Provider(...)`, `StateNotifierProvider`, `ChangeNotifierProvider`) are STRICTLY PROHIBITED.
- **Freezed State Classes:** Feature and UI state representations MUST be declared as immutable `@freezed` classes (with `part '<file>.freezed.dart';` and a private `const StateName._();` constructor for getters and methods).
- **Modeling Asynchronous Mutations:** State classes MUST NOT use fragmented boolean flags (`isLoading`, `isError`, `isSuccess`). Asynchronous mutations (e.g., save, delete, activate) MUST be modeled as nullable `AsyncValue<T>?` fields (e.g., `final AsyncValue<void>? saveOperation`). This provides unified loading, error, and data states natively.
- **Primitive Family Keys:** When using family providers or controllers (`@riverpod ... build(String id)`), family arguments MUST be primitive identifiers (e.g., `String caseId`, `String applicantId`), **NEVER full domain entity objects** (such as `CaseRecord`). Passing full objects as family arguments breaks instance caching and causes redundant controller recreation.
- **Rules for `ref.watch` and `ref.read`:**
  - `ref.watch` MUST ONLY be declared unconditionally at the top of the `build()` method. `ref.watch` MUST NEVER be invoked inside conditional branches, loops, or callback handlers.
  - `ref.read` MUST ONLY be used inside callbacks (e.g. `onPressed`) or controller event handlers. `ref.read` MUST NEVER be called inside the `build()` method body.
- **Guaranteed Context State:** Synchronous providers (e.g., `requireSessionProvider`) MUST watch and validate required context. These providers MUST throw `PlatformFailure` if the context is invalid or missing, allowing Riverpod to gracefully short-circuit downstream providers to an `AsyncError` state without redundant manual null-checks.
- **Single Intent Dispatch & Controller Encapsulation:** One user intent dispatches one feature-controller command (`ref.read(controllerProvider.notifier).action()`). A feature widget MUST NOT coordinate multiple controller/use-case calls, MUST NOT derive workflow decisions, and MUST NEVER import from `use_cases/` directly.
- **No Pass-Through Providers:** Providers MUST NOT be thin pass-through wrappers that only forward repository calls without transforming, filtering, or caching data.
- **Reactive Streams:** Simple data-fetching streams may read directly from the repository inside a Riverpod provider.
- **Scoped Listeners (`ref.listen`):** Every user-triggered async mutation MUST expose state transitions through feature state and attach scoped `ref.listen` handlers in `build()` for one-time side effects (toasts, navigation), using repeated-value guards or `next?.whenOrNull(...)`.

## Incremental Refactoring Scope

- When implementing a new feature or modifying an existing flow, agents MUST apply current architecture guidelines strictly to the new and directly modified feature files.
- Agents MUST NOT perform unsolicited structural rewrites, mass renames, or file moves across unaffected parts of the module within a feature task. Keep changes isolated, minimal, and reviewable. Schedule module-wide structural realignments as dedicated refactoring slices.

## Transport vs. Persistence Separation & Type Safety

- **Separate Transport & Firestore Serializers:** Firestore-facing models may serialize to `cloud_firestore.Timestamp`. However, **callable/API request payloads MUST contain JSON-compatible values only**. Callable JSON MUST NEVER contain SDK objects such as `Timestamp`. For timestamps in callables, use the JSON shape `{seconds, nanoseconds}`, normalize to UTC before encoding, and decode the value back to UTC `DateTime` at the repository boundary.
- **Typed Contracts:** Callable requests and responses MUST use distinct typed `*Request`/`*Response` models with generated JSON serializers.
- **Enums Over Strings:** Agents MUST use Dart Enums (with extensions/properties) rather than raw Strings for state, roles, and types to guarantee compile-time safety and exhaustiveness in `switch` statements.
- **Safe Deserialization with Fallbacks:** When parsing JSON models (e.g., with Freezed / `json_serializable`):
  - Optional/nullable fields MUST specify `@Default(...)` for missing/null fields.
  - Non-critical enums MUST use `@JsonKey(unknownEnumValue: Enum.fallback)` to explicitly handle unrecognized enum values from older/newer schemas.
  - Critical/security-sensitive enums (e.g., permissions, tenant roles, financial statuses) MUST NOT use fallback defaults; unrecognized values MUST fail closed as typed deserialization failures.
- Invalid protected enums, invalid required data, or invalid timestamps MUST yield typed failures—NEVER permissive defaults or fallback current times.

## Error Handling & Validation

- **Functional Error Handling:** Repositories and Use Cases MUST return `Either<PlatformFailure, T>` using `fpdart`. They MUST NOT throw exceptions across application layer boundaries. Caught exceptions (e.g., from Firebase or HTTP clients) MUST be mapped into a subclass of `PlatformFailure` at the repository boundary.
- **Dedicated Pure Validators:** All domain validation logic MUST reside in explicit `Validator` classes (e.g., `ServiceValidator`). Validators MUST return simple error strings, enums, or `Option<String>` instead of throwing exceptions.

## UI & Design System Conventions

- **Design System First:** Always use established design system components (e.g., `ThanksCard`, `ThanksSpacing`, `ThanksButton`) over raw UI primitives. Hardcoding padding or margins when a system constant exists is STRICTLY PROHIBITED.
- **Intrinsic Sizing:** Agents MUST NOT hardcode static heights on content containers (e.g., `SizedBox(height: 500)`). Layouts MUST rely on flex bounds (`Expanded`, `Flexible`) or allow child components to naturally size themselves (e.g., using `scrollable: false` on embeddable scroll views) to prevent layout overflows on different screen sizes.
- **Prohibited APIs:** Do NOT use `showDialog`, `AlertDialog`, `ScaffoldMessenger`, or `SnackBar` in product code. Exceptions belong in the design system and require explicit approval.
- **Standard Dialogs & Toasts:** Use `ThanksDialog` for dialogs and `ThanksToast` for transient feedback.
- **Standard Message Views:**
  - Page or section loading states MUST use `ThanksMessageView.loading(...)`. Hand-building loading states with a bare `CircularProgressIndicator` or centered `Text` is STRICTLY PROHIBITED.
  - Page or section errors MUST use `ThanksMessageView.error(...)`; provide a retry action (`onAction`) when the state can be reloaded.
  - Page or section empty and not-found states MUST use generic `ThanksMessageView`, with an appropriate icon and user guidance.
- **Interaction Lock & Progress:**
  - Bind `ThanksButton.isLoading` and the form's interaction lock to the same feature loading state. Disabling a callback without visible progress feedback is incomplete.
  - Set loading before the first async wait to prevent duplicate actions or race conditions while pending.
- **Semantic Colors & Theming:** UI code MUST use `ThanksTheme.of(context)` palette roles (`.warning.subtle`, `.border`, `.main`, etc.) or the active `ColorScheme`. Page-local `Color` literals and applying ad-hoc alpha (`.withOpacity()`, `.withValues()`) to semantic status colors are STRICTLY PROHIBITED.
- **Card Radius:**
  - Main page card: Set `ThanksCard.radius` to `ThanksCardSpacing.medium`.
  - Nested card: For a card inside another card, keep the default small radius.
- **Navigation Decoupling:** UI widgets MUST NOT execute navigation using raw route strings (`context.go('/...')`, `context.push('/...')`). All navigation MUST be routed through the module's dedicated `<domain>_navigation.dart` class extending `ThanksNavigator`.

## Folder Structure (`app/lib`)

The frontend is divided into core infrastructure and domain-specific modules.

- **`app/lib/core/`**: Application-wide infrastructure. Never put domain-specific business logic here. Contains:
  - `routing/` & `navigation/`: App router configs, deep links, and navigation guards.
  - `errors/`, `validators/`, `utils/`, `constants/`: Global utilities and base types (like `PlatformFailure`).
  - `widgets/`: Universal widgets used across the entire application.
- **`app/lib/modules/<domain_name>/`**: Domain-driven feature sets (e.g., `service`, `case`, `dynamic_form`, `agency`).

Within each module, follow this internal structure:

- **`models/`**: Data definitions. Contains `Freezed` classes, Enums, JSON serializable classes, and Command Request/Response objects.
- **`use_cases/`**: Business logic units. Receives data from UI state controllers, applies authorization/validation rules, and orchestrates repository calls using `Either<PlatformFailure, T>`. UI widgets MUST NEVER import from `use_cases/`.
- **`features/<feature_name>/`**: UI capability boundaries. Grouped by standard user-facing flows (e.g., `features/case_detail/`, `features/case_form/`, `features/case_list/`).
  - View files: `<feature>_page.dart` (for routed screens) or `<feature>_view.dart` (for composite/embedded views).
  - State controllers: dedicated `<feature>_state.dart`.
  - Feature-only child widgets live in the same file as private classes by default (Tier 1), or in `features/<feature_name>/widgets/` only when extracted due to complexity (Tier 2).
  - Prohibited naming: Generic `<feature>.dart`, `*_screen.dart`, `RouteScreen`, or a module-level `pages/` directory.
- **`widgets/`**: Reusable sub-components that span across multiple features within the same module (Tier 3).
- **`<domain>_navigation.dart`**: Module-specific navigation class extending `ThanksNavigator` defining all route constants and navigation methods for the module, avoiding hardcoded route strings in UI widgets.
- **`<domain>_repository.dart`**: Interfaces and implementations (Firestore) for data persistence.
- **`<domain>_validator.dart`**: Domain-specific validation logic (e.g., `ServiceValidator`).
- **`<domain>_constants.dart`**: Field names, collection paths, and magic strings.
- **`<domain>_providers.dart`**: Publicly exposed Riverpod providers for the module (repository, use case, and shared stream providers).
- **`<domain>_mappers.dart`**: Optional non-UI mapping helpers (must never import Flutter widgets).

- **General Principle**: Do not create flat structures. If a component grows, group its related files inside a dedicated feature folder. Do not leak repository implementation details (like Firestore `DocumentSnapshot`) into the UI or Use Cases.
