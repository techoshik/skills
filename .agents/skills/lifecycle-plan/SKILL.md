---
name: lifecycle-plan
description: Convert approved designs and prototypes into an actionable implementation plan with single-concern feature tasks, verified library seams, task-specific rules, and two-tier verification (Lifecycle: Phase 3 — Plan).
---

# Phase 3 — Lifecycle Plan

## 1. Purpose

> **Core Mental Model:** Map every `F-N` feature to small, single-concern vertical tasks in verifiable order. Verify complex library seams before locking changes. Assign rules where the code changes, verify automated checks first, and give the user crisp verification steps.

Convert approved Designs and Prototypes from Phase 2 into a clean, actionable **Implementation Plan** (`lifecycle/03-plan.md`).

---

## 2. Core Rules

- **Verbatim `F-N` Traceability (`Discover → Plan`):** Every `F-N.x` item and `F-N-Ex` edge case in `lifecycle/01-discover.md` must map to at least one task change (`C1`, `C2`...), copying exact IDs and meanings verbatim into `## Coverage Map (Discover → Plan)` at the bottom of `03-plan.md` — never renumber, rewrite, or silently drop items.
- **Small, Single-Concern Vertical Slices (3–6 Files Target):** Keep every task reviewable in ~5 minutes (roughly **3–6 files**, max ~8) **and** scoped to a single heavy concern. Never bundle a pure computation/rendering/export engine with a full UI screen and cross-module wiring, or complex interactive canvas/embed controls with modal picker dialogs, in one task. No horizontal layer-cake batching (all DB, then all API, then all UI).
- **Prefactoring & Technical Seam Checks Up Front:**
  - *File-Size Thresholds (900 / 1000 lines):* If a target file exceeds 900 lines or the change would cross 1000 lines, schedule an upfront `Prefactor <Target>` task first.
  - *No Black-Box Libraries:* Before locking tasks that use a non-trivial third-party library, custom embed, or rendering/export engine, inspect its actual API/source (or schedule a brief spike) and record critical lifecycle/layout constraints in a 1-line `**Seam Note:**` under `Changes`.
- **Verifiable Execution Order & Wire Completeness:** Sequence Producer (Create/Ingest) → Consumer (Read/List) → Modifier/Teardown (Update/Delete) so every task is verifiable with real state. Every boundary crossing (URL query param, webhook, emitted event, job queue) must have both an emitting task and an ingesting task scheduled 1:1.
- **Compile-Clean Slices & Backward Compatibility:** Every task must compile and pass its own checks. If an early task renames a symbol, update callers in the same task or schedule explicit cleanup of a temporary alias. Schema or contract changes across independently deployed layers must include live data fallbacks for unmigrated records.
- **Rule-File Structure & Actionable Line-by-Line Verification:** Verify planned file paths and module boundary files (e.g. contract, repository, validator, constants) conform to `.agents/rules/`. Under each task's **Agent Verification**, never write passive pointers like `- Rule [Name]: <file>` — write concrete, checkable **`- Verify <exact condition to check> (<file> — <Section>)`** lines (especially design system tokens/widgets on every UI task) plus the exact linter/analyzer and test commands.
- **Two-Tier Verification (Zero Hunting in Setup):** Separate **Agent Verification** (explicit rules + linter + automated tests the agent runs first) from **User Verification** (`Setup / Action / Expected`). `Setup` must always include the **exact full file paths, exact terminal command, or exact app navigation path** so the user can execute it immediately without searching. For UI tasks, give click-by-click steps in the running app; for pure foundation/engine tasks, point directly to the exact files/contracts to inspect (with optional smoke command).
- **Strict Phase Boundaries & Friction Logging:** No production code, no test execution, and no unilateral scope changes (return unmappable `F-N.x` items to Discover). Immediately append any planning or sequencing friction to `lifecycle/refine.md`.

---

## 3. Execution Sequence

### Step 1 — Input Review, Seam Inspection & Prefactoring Check

1. **Extract Confirmed Scope:** Read `lifecycle/01-discover.md` (`F-N` headings, `F-N.x` items, `F-N-Ex` edge cases) and `lifecycle/02-design.md` (flows and selected prototype options). Every interactive element in the approved prototype must trace to an `F-N.x` item.
2. **Inspect Codebase & Library Seams:**
   - Check line counts of existing files to be modified against the 900/1000-line threshold (schedule `Task 4.0: Prefactor <Target>` if needed).
   - Inspect actual API/source of any non-trivial third-party library, custom embed, or rendering engine to verify focus, serialization, and layout seams before locking task changes.
   - Verify planned file paths and module boundary files against `.agents/rules/`.

### Step 2 — Decompose Features Into Single-Concern Tasks

1. **Sequence Per Feature (`F-N`) in Producer-Before-Consumer Order:**
   - **Prefactoring (if needed):** Split files near 900/1000 lines first.
   - **Backend + Security Rules:** Server functions/APIs + DB/storage security rules + rules tests (so live UI never hits permission errors).
   - **Models, Repository & State:** Data models, client repository, validators, and state/contract providers.
   - **Pure Engines / Services (when complex):** Dedicated task for parsers, compilers, resolvers, or export/PDF renderers.
   - **UI & Route Wiring:** Screen or dialog components + router/sidebar wiring (immediately reachable in the running app).
   - **Hardening & Cross-Module Integration:** Secondary modifiers/teardown, entry buttons in other modules, and edge-case tests.
2. **Write Crisp Task Anatomy:**
   - Start `lifecycle/03-plan.md` directly with `## F1 — [Feature Name]` → `### Task 4.1: [Plain-English Goal]` (so reviewers see the tasks immediately).
   - Tag **Blast Radius:** `🟢 Low (<5 words)` or `🔴 High (<5 words)`.
   - Write **Changes** (`C1`, `C2`...) as a short headline (**≤ 12–15 words**) with crisp sub-bullets (**≤ 10 words each**) — zero semicolon-packed run-on sentences. List each target file with its action verb (`Add`, `Update`, `Delete`, `Refactor`, `Fix`) as its own final sub-bullet (**one file per line**: `- _File:_ path/to/file (Add)`) — no separate `**Files:**` section. Add a 1-line `**Seam Note:**` when a complex library or cross-module contract has a critical constraint.
   - Specify **Agent Verification** (actionable `- Verify <exact condition> (<file> — <Section>)` lines + linter + automated test commands) and **User Verification** (`Setup / Action / Expected`).

### Step 3 — Populate Coverage Map & Dashboard Upon Approval

1. **Append `## Coverage Map (Discover → Plan)` at the Bottom of `03-plan.md`:**
   - Map every `F-N.x` item and `F-N-Ex` edge case verbatim from `01-discover.md` to its owning `Task 4.x (CN)` with zero `⚠️ Missing` rows.
2. **Populate `lifecycle/00-status.md` Upon User Approval:**
   - Add one row per planned task under Phase 4 Build with status `Todo` and matching markdown anchor link `[Task 4.1: <Title>](03-plan.md#task-41-title)`.

---

## 4. Exit Gate & Completion Criteria

### Pre-Flight Checklist

Before requesting Phase 3 approval, verify:
- **1:1 Feature Mapping (`F-N`):** Every Target Feature from `01-discover.md` appears as a `## F-N — <Feature Name>` heading.
- **Small Single-Concern Tasks:** Every task targets ~3–6 files and isolates heavy engines from full UI screens and cross-module wiring.
- **Seams, Prefactoring & Compatibility Verified:** Complex library seams are captured in `**Seam Note:**`, files near 900/1000 lines have upfront prefactoring, and schema changes include live data fallbacks.
- **Rule-File Structure & Wire Completeness:** Planned file paths/contracts match `.agents/rules/`; every emitter/consumer boundary has both tasks scheduled 1:1.
- **Two-Tier Verification Actionable:** Every task lists concrete `- Verify <exact condition> (<file> — <Section>)` checks + linter + tests under Agent Verification, and zero-hunting User Verification steps.
- **Coverage Map Complete & Verbatim:** `## Coverage Map (Discover → Plan)` at the bottom accounts for 100% of `F-N.x` and `F-N-Ex` items verbatim with zero `⚠️ Missing` rows.

### Requesting User Approval (Phase 0 Protocol)

1. Set Phase 3 to `In Review` in `lifecycle/00-status.md`.
2. Output a concise 1–2 sentence summary linking `[03-plan.md](03-plan.md)` with total task count and high blast-radius tasks, and ask for explicit approval to advance to Phase 4 — Build.
3. Stop calling tools and wait for the user's response (`Approved` → mark Phase 3 `Done`, populate Phase 4 task rows in `00-status.md`, load `lifecycle-build`; `Changes Requested` → return to `In Progress`; `Blocked` → mark `Blocked`).

---

## 5. Output Template (`lifecycle/03-plan.md`)

```markdown
# Plan: [Requirement / Feature Name]

## F1 — [Feature 1 Name]

### Task 4.1: [Plain-English Task Title]

**Blast Radius:** 🔴 High (shared database schema & models)

**Changes:**
- **C1:** Create `users` table with unique lowercase `email` index
  - _File:_ `src/migrations/001_auth_tables.sql` (Add)
- **C2:** Add session fields to `User` model
  - `sessionCount` defaults to `0`; `activeDeviceIds` defaults to `[]`
  - Enforce max 5 concurrent devices
  - _File:_ `src/models/user.ts` (Update)
  - _File:_ `src/models/user.test.ts` (Update)
- **Seam Note:** *(Optional — include only for complex libraries or cross-module contracts)* Document verified API/focus/layout constraint here.

**Agent Verification:**
- Verify migration is idempotent and rollback drops added tables cleanly (`.agents/rules/database_migrations.md` — Idempotent Migrations)
- Verify token expiry and session bounds fail closed on invalid input (`.agents/rules/security_invariants.md` — Token Validation)
- Run project linter/typecheck -> 0 errors.
- Run `npm run migrate:up && npm run migrate:down` -> migrations apply and roll back cleanly.

> **User Verification**
> - **Setup:** Open `src/migrations/001_auth_tables.sql` and `src/models/user.ts` (or run `git diff src/migrations/001_auth_tables.sql src/models/user.ts`).
> - **Action:** Confirm `sessionCount`/`activeDeviceIds` default safely for existing records and the unique `email` index is lowercase.
> - **Expected:** Schema and model defaults match approved requirements with zero breaking changes for live data.

---

### Task 4.2: [Next Task Title]

## F2 — [Feature 2 Name]

### Task 4.3: [Next Task Title]

---

## Coverage Map (Discover → Plan)

| ID | Verbatim Item from `01-discover.md` | Planned In |
| :--- | :--- | :--- |
| **F1.1** | [Exact summary of `F1.1`] | Task 4.x (`C1`) |
| **F1-E1** | [Exact summary of `F1-E1`] | Task 4.x (`C2`) |
```
