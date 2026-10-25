# Flutter Architecture Rules & Invariants

> [!IMPORTANT]
> **MANDATORY FRONTEND RULES — STRICT ENFORCEMENT**
> Every requirement is a strict system invariant. Creating `StatefulWidget`, bypassing Direct Client SDK, exceeding the 500-line ceiling, embedding queries in UI, or placing display logic in widgets is STRICTLY PROHIBITED.

## Direct Firebase Client SDK First (Hard Invariant)
Application clients MUST interact directly with Firestore and Firebase Storage via Client SDK protected by server-side `firestore.rules`.
- **Direct SDK Default:** Standard CRUD (create, read, update, delete drafts, upload attachments) MUST use the client SDK. Wrapping standard operations in Cloud Functions is STRICTLY PROHIBITED (adds cold starts, eliminates offline caching, increases latency).
- **The 5 Strict Cloud Function Exceptions:** Cloud Functions are permitted ONLY for:
  1. *Atomic Counters:* Gap-free, sequential IDs (`INV-001`) where client generation risks collisions.
  2. *Private Secrets:* External APIs (Stripe, Twilio, SendGrid) requiring hidden credentials.
  3. *Privileged Lifecycle Locks:* Freezing immutable multi-collection snapshots upon state transitions.
  4. *Asynchronous Triggers:* Background events (storage uploads, webhooks).
  5. *Complex Aggregations:* Multi-document batch operations exceeding Security Rules limits (10 `get()` calls).

## Model-Driven UI & Dumb Presentational Widgets
- **No UI Logic in Widgets:** Widgets are dumb renderers. Raw string manipulation, status mapping, and date formatting in UI are STRICTLY PROHIBITED. Encapsulate all display logic in domain models via getters, methods, or enum extensions (e.g. `role.displayName`).
- **Dumb Presentational Widgets:** Child and section widgets MUST be dumb `StatelessWidget` renderers. They MUST NOT call `ref.watch`/`ref.read` or import controllers/use-cases. Pass only plain domain models, primitives, and callbacks (`VoidCallback`, `ValueChanged<T>`).
- **Single Controller Entry:** Only root feature screens (`<feature>_page.dart`) or composite views (`<feature>_view.dart`) watch controllers and orchestrate state.

## StatelessWidget & HookWidget Only (StatefulWidget Prohibited)
- **`StatefulWidget` is STRICTLY PROHIBITED:** Creating Flutter `StatefulWidget` and `State` classes is banned. Manual lifecycle overrides (`initState`, `dispose`) cause memory leaks and boilerplate.
- **Two Widget Types Only:**
  1. **`StatelessWidget`:** For dumb presentational components without local mutable state.
  2. **`HookWidget` / `HookConsumerWidget`:** For components managing local state, controllers, or subscriptions. Use `HookWidget` by default; use `HookConsumerWidget` only when Riverpod (`WidgetRef ref`) is also required.
- **Declarative Hooks Lifecycle:** Use Flutter Hooks exclusively:
  - Text controllers: `useTextEditingController()` (never manually call `new` or `.dispose()`).
  - Local state: `useState<T>(initialValue)`.
  - Keys/memoization: `useMemoized(() => GlobalKey<FormState>())`.
  - Focus nodes: `useFocusNode()`.
  - Subscriptions/timers: `useEffect(...)` returning a cleanup cancel callback.
  - Scroll/tab: `useScrollController()`, `useTabController(...)`.
  Hooks automatically dispose resources on unmount, eliminating memory leaks.

## 4-Tier Placement & 500-Line Soft Ceiling
- **The 500-Line Ceiling:** Handwritten code files SHOULD NOT exceed ~500 lines (UI files target ~300–400 lines). When approaching 500 lines, split along natural domain seams. Generated files (`*.g.dart`, `*.freezed.dart`) are exempt.
- **4-Tier Placement Rule:**
  - *Tier 1 (Same File — Default):* Feature child widgets MUST be private classes (`class _SectionCard extends StatelessWidget`) in the same feature file to preserve locality of reference.
  - *Tier 2 (Feature Sub-Widgets):* Extract to `features/<feature>/widgets/<widget>.dart` ONLY if independently complex (>150 lines) and the main file exceeds ~350 lines. Do not create `widgets/` by default.
  - *Tier 3 (Module-Shared):* Reused across 2+ features in the same module -> `modules/<module>/widgets/`.
  - *Tier 4 (Universal):* Reused across multiple modules -> `core/widgets/` or design system.

## State Management (Riverpod & Freezed)
- **Code-Generated Providers Only:** Use code-generated Riverpod (`@riverpod` / `@Riverpod(keepAlive: true)` with `part '<file>.g.dart';`). Legacy manual providers (`StateNotifierProvider`, etc.) are BANNED.
- **Freezed State Classes:** UI state MUST be immutable `@freezed` classes with private `const StateName._();` constructor for getters.
- **Async Mutations:** Model mutations as nullable `AsyncValue<void>?` fields (e.g. `saveOperation`). Never use fragmented boolean flags (`isLoading`, `isSuccess`, `isError`).
- **Primitive Family Keys:** Family provider arguments MUST be primitive IDs (`String caseId`), NEVER domain entity objects.
- **Ref Usage Rules:**
  - `ref.watch`: Unconditionally at top of `build()`. NEVER inside branches, loops, or callbacks.
  - `ref.read`: Inside callbacks (`onPressed`) or controller event handlers. NEVER inside `build()`.
- **Single Intent Dispatch:** One user action -> one controller notifier call. Widgets MUST NOT coordinate multiple calls, derive workflow decisions, or import from `use_cases/`.
- **No Pass-Through Providers:** Do not create thin wrapper providers that only forward repository calls.
- **Scoped Listeners (`ref.listen`):** Trigger one-time side effects (toasts, navigation) via `ref.listen` in `build()` using `next?.whenOrNull(...)`.

## Transport, Persistence & Fail-Closed Parsing
- **Callable Transport:** Callable request/response contracts MUST be JSON-compatible. Timestamps in callables MUST use `{seconds, nanoseconds}` UTC JSON format—NEVER raw SDK `Timestamp` objects. Map to UTC `DateTime` at the repository boundary.
- **Enums Over Strings:** Use Dart enums with extensions/properties for states, roles, and types.
- **Deserialization Invariants:** Optional fields MUST specify `@Default(...)`. Non-critical enums use `@JsonKey(unknownEnumValue: ...)`. Security-critical identifiers, roles, tenant keys, and mandatory fields MUST fail closed on invalid or unrecognized values—NEVER use permissive fallbacks.

## Functional Error Handling & Pure Validators
- **Functional Results:** Repositories and use cases MUST return `Either<PlatformFailure, T>` via `fpdart`. Catch and map exceptions to `PlatformFailure` at the repository boundary. NEVER throw unhandled exceptions across architectural layers.
- **Dedicated Pure Validators:** Validation MUST live in dedicated `Validator` classes returning `Option<String>` or error strings/enums. Validators MUST NEVER throw exceptions.

## UI & Design System Conventions
- **Design System First:** Use design system components (`ThanksCard`, `ThanksButton`, `ThanksSpacing`). Hardcoding padding, margins, or colors is BANNED.
- **Design System Primacy Over Prototype Values:** Prototypes (`02-prototype.html`) are conceptual visual references for layout and workflow alignment only. Production UI code must strictly consume canonical design system components (`ThanksCard`, `ThanksSpacing`, `ThanksTheme`) and Flutter theme tokens (`context.textTheme`, `context.colorScheme`). Copying raw inline CSS, hardcoded pixel values, custom typography, or arbitrary alpha overlays from HTML prototypes into Flutter code is STRICTLY BANNED.
- **Intrinsic Sizing:** Do NOT hardcode static heights (`SizedBox(height: 500)`). Use flex bounds (`Expanded`, `Flexible`) or intrinsic widget sizing to prevent layout overflow.
- **Prohibited UI APIs:** `showDialog`, `AlertDialog`, `ScaffoldMessenger`, and `SnackBar` are PROHIBITED in product code. Use `ThanksDialog` and `ThanksToast`.
- **Standard Message Views:** Loading states MUST use `ThanksMessageView.loading(...)` (bare spinners BANNED). Error states MUST use `ThanksMessageView.error(...)` with retry. Empty states use generic `ThanksMessageView`.
- **Interaction Lock:** Bind `ThanksButton.isLoading` and interaction lock to the same async state; activate before the first `await`.
- **Theming:** Use `ThanksTheme.of(context)` palette roles. Page-local `Color` literals and ad-hoc alpha (`.withOpacity()`) on status colors are BANNED.
- **Card Radius:** Main page cards: `ThanksCardSpacing.medium`. Nested cards: small radius.
- **Navigation Decoupling:** Route navigation MUST go through the module's `<domain>_navigation.dart` extending `ThanksNavigator`. Raw route strings (`context.go('/...')`) in widgets are BANNED.

## Folder Structure (`app/lib`)
- **`core/`**: Universal infrastructure: `routing/`, `navigation/`, `errors/`, `validators/`, `widgets/`. No domain logic.
- **`modules/<domain>/`**: Domain-driven feature sets:
  - `models/`: Freezed entities, enums, DTOs, request/response contracts.
  - `use_cases/`: Business logic returning `Either<PlatformFailure, T>`. Widgets never import here.
  - `features/<feature>/`: `<feature>_page.dart` / `<feature>_view.dart`, `<feature>_state.dart`, private child widgets (Tier 1).
  - `widgets/`: Module-shared widgets (Tier 3).
  - `<domain>_navigation.dart`: Module route definitions extending `ThanksNavigator`.
  - `<domain>_repository.dart`: Data persistence contracts and Firestore implementations.
  - `<domain>_validator.dart`: Pure domain validation logic.
  - `<domain>_constants.dart`: Collection paths and domain field names.
  - `<domain>_providers.dart`: Public Riverpod providers for the module.

## Pre-Handoff Self-Review
Before declaring any task ready for human review:
1. **Rule Check:** Verify compliance against this document (StatelessWidget/HookWidget only, Direct SDK First, 500-line ceiling, dumb presentational widgets).
2. **Simplicity:** Remove dead code, redundant transformations, debug logs (`print`, `debugPrint`), and pass-through abstractions.
3. **Behavior & Concurrency:** Verify error propagation, async state cleanup, and null-safety.
4. **Automated Verification:** Run `flutter analyze` (0 issues) and `flutter test` (100% passing).
5. **Diff Hygiene:** Inspect `git diff` to ensure changes touch only authorized task files.
