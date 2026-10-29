# Flutter Architecture Rules & Invariants

> [!IMPORTANT]
> **MANDATORY FRONTEND RULES — STRICT ENFORCEMENT**
> Every requirement is a strict system invariant. Creating `StatefulWidget`, bypassing Direct Client SDK, exceeding the 500-line hard limit, embedding queries in UI, or placing display logic in widgets is STRICTLY PROHIBITED. Production access or deployment requires explicit user authorization; use emulators/dev environments for automated testing.

## Direct Firebase Client SDK First (Hard Invariant)
Application clients MUST interact directly with Firestore and Firebase Storage via Client SDK protected by server-side `firestore.rules`.
- **Direct SDK Default:** Standard CRUD (create, read, update, delete drafts, upload attachments) MUST use the client SDK. Wrapping standard operations in Cloud Functions is STRICTLY PROHIBITED (adds cold starts, eliminates offline caching, increases latency).
- **The 5 Strict Cloud Function Exceptions:** Cloud Functions are permitted ONLY for:
  1. *Atomic Counters:* Gap-free, sequential IDs (`INV-001`) where client generation risks collisions.
  2. *Private Secrets:* External APIs (Stripe, Twilio, SendGrid) requiring hidden credentials.
  3. *Privileged Lifecycle Locks:* Freezing immutable multi-collection snapshots upon state transitions.
  4. *Asynchronous Triggers:* Background events (storage uploads, webhooks).
  5. *Complex Aggregations:* Multi-document batch operations exceeding Security Rules limits (10 `get()` calls).

## Model-Driven UI & Component Boundaries
- **No UI Logic in Widgets:** Widgets are renderers. Raw string manipulation, status mapping, and date formatting in UI are STRICTLY PROHIBITED. Encapsulate all display logic in module models via getters, methods, or enum extensions (e.g. `role.displayName`).
- **Presentational Widgets vs. Self-Contained Feature Sections:**
  - *Reusable Presentational Widgets:* Cards, list rows, dialogs, and form controls MUST NOT call `ref.watch`/`ref.read` or import controllers/use-cases. Pass only plain module models, primitives, and callbacks (`VoidCallback`, `ValueChanged<T>`).
  - *Root Screens & Self-Contained Feature Sections:* Root screens (`<feature>_page.dart` / `<feature>_screen.dart`), composite views (`<feature>_view.dart`), and independent module sections (`<section>_section.dart` managing their own edit/save lifecycle) may watch providers and orchestrate state directly so parent screens stay decoupled and under 500 lines.

## StatelessWidget & HookConsumerWidget Only (`StatefulWidget` & `HookWidget` Prohibited)
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

## 4-Tier Placement & File-Size Thresholds
- **File-Size Thresholds (single definition — every lifecycle skill and template refers here):**
  - *Evaluate threshold — 400 lines:* A handwritten file above this MUST be evaluated for a split along natural module seams before more code is added (UI files target ~300–400 lines).
  - *Hard limit — 500 lines:* A handwritten file MUST NOT exceed this. If a task would cross it, split first, or record a user-approved exception in `01-requirements.md` Section 5.
  - Generated files (`*.g.dart`, `*.freezed.dart`) are exempt.
- **4-Tier Placement Rule:**
  - *Tier 1 (Same File — Default):* Feature child widgets MUST be private classes (`class _SectionCard extends StatelessWidget`) in the same feature file to preserve locality of reference.
  - *Tier 2 (Feature Sub-Widgets):* Extract to `features/<feature>/widgets/<widget>.dart` ONLY if independently complex (>150 lines) and the main file exceeds ~350 lines. Do not create `widgets/` by default.
  - *Tier 3 (Module-Shared):* Reused across 2+ features in the same module -> `modules/<module>/widgets/`.
  - *Tier 4 (Universal):* Reused across multiple modules -> `core/widgets/` or design system.

## State Management (Riverpod & Freezed)
- **Code-Generated Providers Only:** Use code-generated Riverpod (`@riverpod` / `@Riverpod(keepAlive: true)` with `part '<file>.g.dart';`). Legacy manual providers (`StateNotifierProvider`, etc.) are BANNED.
- **Freezed State Classes:** UI state MUST be immutable `@freezed` classes with private `const StateName._();` constructor for getters.
- **Async Mutations:** Model mutations as nullable `AsyncValue<void>?` fields (e.g. `saveOperation`). Never use fragmented boolean flags (`isLoading`, `isSuccess`, `isError`).
- **Primitive Family Keys:** Family provider arguments MUST be primitive IDs (`String caseId`), NEVER module entity objects.
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

## Functional Error Handling & Pure Module Validators
- **Functional Results:** Repositories and use cases MUST return `Either<PlatformFailure, T>` via `fpdart`. Catch and map exceptions to `PlatformFailure` at the repository boundary. NEVER throw unhandled exceptions across architectural layers.
- **Dedicated Pure Module Validators (`<module>_validator.dart`):** All pure module validation, eligibility filtering, and business-rule calculations MUST live in `modules/<module>/<module>_validator.dart` (or module model methods) returning `Option<String>`, error enums, or filtered lists. Creating ad-hoc `*_filter.dart` or `*_helper.dart` files inside `features/` is STRICTLY PROHIBITED. Validators MUST NEVER throw exceptions.

## UI & Design System Conventions
- **Design System First:** Use design system components (`ThanksCard`, `ThanksButton`, `ThanksSpacing`). Hardcoding padding, margins, or colors is BANNED.
- **Design System Primacy Over Prototype Values:** Prototypes (`02-prototype.html`) are conceptual visual references for layout and workflow alignment only. Production UI code must strictly consume canonical design system components (`ThanksCard`, `ThanksSpacing`, `ThanksTheme`) and Flutter theme tokens (`context.textTheme`, `context.colorScheme`). Copying raw inline CSS, hardcoded pixel values, custom typography, or arbitrary alpha overlays from HTML prototypes into Flutter code is STRICTLY BANNED.
- **Intrinsic Sizing:** Do NOT hardcode static heights (`SizedBox(height: 500)`). Use flex bounds (`Expanded`, `Flexible`) or intrinsic widget sizing to prevent layout overflow.
- **Prohibited UI APIs:** `showDialog`, `AlertDialog`, `ScaffoldMessenger`, and `SnackBar` are PROHIBITED in product code. Use `ThanksDialog` and `ThanksToast`.
- **Standard Message Views:** Loading states MUST use `ThanksMessageView.loading(...)` (bare spinners BANNED). Error states MUST use `ThanksMessageView.error(...)` with retry. Empty states use generic `ThanksMessageView`.
- **Interaction Lock:** Bind `ThanksButton.isLoading` and interaction lock to the same async state; activate before the first `await`.
- **Theming:** Use `ThanksTheme.of(context)` palette roles. Page-local `Color` literals and ad-hoc alpha (`.withOpacity()`) on status colors are BANNED.
- **Card Radius:** Main page cards: `ThanksCardSpacing.medium`. Nested cards: small radius.
- **Navigation Decoupling:** Route navigation MUST go through the module's `<module>_navigation.dart` extending `ThanksNavigator`. Raw route strings (`context.go('/...')`) in widgets are BANNED.

## Folder Structure (`app/lib`)
- **`core/`**: Universal infrastructure: `routing/`, `navigation/`, `errors/`, `validators/`, `widgets/`. No module-specific business logic.
- **`modules/<module>/`**: Module-driven feature sets:
  - `models/`: Freezed entities, enums, DTOs, request/response contracts.
  - `use_cases/`: Business logic returning `Either<PlatformFailure, T>`. Widgets never import here.
  - `features/<feature>/`: `<feature>_page.dart` / `<feature>_view.dart`, `<feature>_state.dart`, private child widgets (Tier 1).
  - `widgets/`: Module-shared widgets and self-contained sections (Tier 3).
  - `<module>_navigation.dart`: Module route definitions extending `ThanksNavigator`.
  - `<module>_repository.dart`: Data persistence contracts and Firestore implementations.
  - `<module>_validator.dart`: Pure module validation, eligibility filtering, and business rules.
  - `<module>_constants.dart`: Collection paths and module field names.
  - `<module>_providers.dart`: Public Riverpod providers for the module.

## Pre-Handoff Self-Review
Before declaring any task ready for human review:
1. **Rule Check:** Verify compliance against this document (`StatefulWidget` ban, Direct SDK First, 500-line hard limit, `<module>_validator.dart` placement).
2. **Simplicity:** Remove dead code, redundant transformations, debug logs (`print`, `debugPrint`), and pass-through abstractions.
3. **Behavior & Concurrency:** Verify error propagation, async state cleanup, and null-safety.
4. **Automated Verification:** Run `flutter analyze` (0 issues) and `flutter test` (100% passing).
5. **Diff Hygiene:** Inspect `git diff` to ensure changes touch only authorized task files.

## Lifecycle Checklists

The generic lifecycle skills delegate stack-specific checks to these lists. Apply every item that is relevant to the change.

### Roadmap placement check (used by `lifecycle-roadmap`)
- Every new file path matches the Folder Structure above (`<module>_repository.dart`, `<module>_navigation.dart`, `<module>_validator.dart`, `features/<feature>/`, etc.).
- Validation, eligibility filtering, and business-rule calculations are planned into `modules/<module>/<module>_validator.dart` — never into ad-hoc `*_filter.dart` / `*_helper.dart` files.
- Widget placement follows the 4-Tier rule (private same-file → feature `widgets/` → module `widgets/` → `core/widgets/`).
- Any target file above the 400-line evaluate threshold has a prefactor decision (a `P0` task or a recorded reason).
- No planned change leaves a handwritten file above the 500-line hard limit.
- Verification commands: `flutter analyze` and `flutter test` (targeted paths per task).

### Review hygiene checklist (used by `lifecycle-review`)
- Deleted or consolidated screens/widgets are removed from barrel `index.dart` exports, route constants, `<module>_navigation.dart`, callers, and tests.
- No `print` / `debugPrint` remains in product code.
- No `StatefulWidget`, `ConsumerWidget`, or standalone `HookWidget` classes; no `showDialog` / `AlertDialog` / `ScaffoldMessenger` / `SnackBar`.
- No hardcoded colors, padding, or static heights; design-system components and theme tokens are used.
- Intra-module duplicates are consolidated into the module's `widgets/` (Tier 3); prefer existing `core/widgets/` components; ask the user before changing shared `core/` files used by unrelated modules.
- No handwritten file is above the 500-line hard limit.
- Global verification commands: `flutter analyze` (target 0 issues) and `flutter test`.
