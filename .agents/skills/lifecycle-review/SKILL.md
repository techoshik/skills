---
name: lifecycle-review
description: Comprehensive full-branch code audit, integration seam verification, two-tier deduplication, and diff hygiene (Lifecycle: Review).
---

# Lifecycle Review

The `lifecycle-review` skill steps back from individual task execution to audit the **entire branch as a unified whole**. Your mission is to verify end-to-end acceptance criteria, test integration seams between tasks, enforce codebase rules and security invariants, deduplicate redundant code into shared components/utils, and ensure zero dead code or debug artifacts.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Review Mindset: Holistic Fresh Eyes

- **Review the Branch, Not Just Slices:** Individual tasks might work in isolation while breaking across seams (e.g. stale caches, missing navigation arguments, or duplicated helper functions).
- **Auditor Sub-Agent Delegation:** Spawn a fresh auditor sub-agent to inspect the branch diff with unbiased "fresh eyes" and zero conversation context rot.
- **Inviolable Boundaries:** 100% manual git (no `git add/commit/reset/restore`), read-only git commands allowed (`git diff`, `git status`).

---

## Step 1: Entry Gate & Branch Scope Discovery

1. **Verify Entry Gate:**
   - Read `lifecycle/00-status.md`.
   - Verify that **all roadmap tasks are marked `Done`**.
   - If any task is still `Todo` or `In Progress`, STOP—instruct user to complete Execute first.
2. **Lock Status to In Progress:**
   - Update `Review` in `lifecycle/00-status.md` to **`In Progress`**.
3. **Discover Complete Branch Scope:**
   - Run read-only git commands to map the full branch footprint:
     - `git status --short` (all untracked or modified files)
     - `git diff HEAD` (uncommitted working tree changes)
     - `git diff origin/main...HEAD` (or target base branch) to inspect all committed branch changes.
   - Cross-reference with all touchpoints declared in `lifecycle/03-roadmap.md`.
4. **Spawn Auditor Sub-Agent (Recommended):**
   - Delegate the heavy diff inspection to a fresh sub-agent (`TypeName: 'self'`, `Role: 'Branch Auditor'`) to keep main context clean for the handoff.

> **➡️ Sign-off & Transition to Step 2:** All roadmap tasks are `Done`, branch footprint is fully mapped, and auditor is initialized.

---

## Step 2: The 5-Point Full-Branch Audit

Systematically audit the entire branch diff across 5 critical dimensions:

### 1. Global AC & Scope Integrity (`01-requirements.md`)
- Verify that every requirement (`REQ-X`), acceptance criterion (`AC-X`), and business rule (`BR-X`) from `01-requirements.md` holds true end-to-end.
- Check for scope creep: verify that no unauthorized features or rogue abstractions were sneaked into the branch.

### 2. Cross-Task Seam & Integration Check
- Trace the complete data flow across tasks: `Input → Validation → State/Controller → Repository → UI Refresh`.
- Verify navigation arguments, route guards, and provider/bloc cache invalidations work seamlessly when transitioning between screens.
- Ensure state updates in one task immediately reflect in components built in earlier tasks.

### 3. Guidelines & Diff Hygiene (`.agents/rules/`)
- **500-Line Ceiling:** Verify that every created or modified file remains within ~500 lines.
- **Framework Invariants:** Check adherence to `.agents/rules/` (e.g. `StatelessWidget`/`HookWidget` only, `Direct Client SDK First`, typed parameters).
- **Zero Dead Code:** Remove unused imports, abandoned draft files, and commented-out code blocks.
- **Zero Debug Artifacts:** Remove all `print()`, `console.log()`, `debugPrint()`, and hardcoded testing mocks.
- **Code Smells:** Eliminate primitive obsession (use domain enums/types), feature envy, and speculative generality.

### 4. Security, Tenancy & Performance
- **Tenant & Role Invariants:** Confirm that tenant IDs and user permissions are enforced on all queries, mutations, and views.
- **Query & Resource Efficiency:** Verify zero N+1 database queries in loops, and no missing composite indexes.
- **Leak Prevention:** Verify controllers, streams, animations, and event listeners are properly disposed.

### 5. Two-Tier Smart Deduplication
- **Tier 1 (Intra-Module / Intra-Feature):** Scan touched files for duplicated widgets, repeated logic, or identical validation regexes. Consolidate them into module-level `widgets/`, `components/`, or `utils/`.
- **Tier 2 (Cross-Module / `core/`):** Scan for utilities or components that already exist in shared commons before extracting new ones. If extracting a new helper to shared `core/`, propose it to the user first before modifying code outside the module.

> **➡️ Sign-off & Transition to Step 3:** 5-point audit is complete with a clear list of findings and necessary cleanups.

---

## Step 3: Fix Policy & Deduplication Execution

1. **Apply Safe In-Branch Fixes:**
   - Directly extract intra-module duplicates into adjacent shared helpers.
   - Directly remove dead code, unused imports, and debug logs.
   - Refactor any file nearing the 500-line ceiling into natural sub-widgets.
2. **Handling Major Missing Requirements:**
   - If the audit discovers a fundamental missing capability or major architectural defect, **do NOT hack it into Review**.
   - Schedule an explicit new task in `03-roadmap.md`, insert it into `00-status.md` as `Todo`, and transition back to `Execute`.

> **➡️ Sign-off & Transition to Step 4:** Safe refactors and deduplications are applied; branch diff is clean and disciplined.

---

## Step 4: Global Verification (Zero-Issue Full Suite)

Run full verification across the entire project to ensure branch-wide stability:

1. **Full Static Analysis:**
   - Run the project-wide analyzer (e.g. `flutter analyze` or `npm run lint`).
   - Must report **0 issues**. Fix all warnings silently before presenting to the user.
2. **Full Automated Test Suite:**
   - Run the complete relevant test suite (e.g. `flutter test`).
   - Must pass **100% cleanly**.
3. **Verify Git Diff State:**
   - Run read-only `git status` and `git diff` to ensure only intended, clean files are modified.

> **➡️ Sign-off & Transition to Step 5:** Global analyzer reports 0 issues, all tests pass 100%, and diff is verified.

---

## Step 5: Refinement Logging & 5-Point Handoff

1. **Log Process Friction (`04-refine.md`):**
   - If the review uncovered recurring agent errors, brittle code patterns, or missing project rules, append an entry to `lifecycle/04-refine.md`.
2. **Update Status Dashboard:**
   - Update `Review` in `lifecycle/00-status.md` to **`In Review`**.
3. **Present 5-Point Review Summary in Chat:**
   Present an executive summary covering:
   - **1. Scope & AC Integrity:** Confirmation that all `REQ`, `AC`, and `BR` items pass end-to-end.
   - **2. Seam & Integration Verification:** Confirmation that cross-task flows and navigation arguments are seamless.
   - **3. Guidelines & Diff Hygiene:** Confirmation that 500-line limits hold and dead code/debug logs are removed.
   - **4. Security & Performance:** Confirmation of tenant filters, leak disposal, and query efficiency.
   - **5. Deduplications Applied & Verification Proof:** List of deduplications made + proof of analyzer (0 issues) and test pass.
4. **STOP.** Wait for explicit human approval before advancing to Finalize.
5. **On User Approval:**
   - Mark `Review` as **`Done`** in `00-status.md`.
   - Read [`lifecycle-finalize/SKILL.md`](../lifecycle-finalize/SKILL.md) and auto-advance to Finalize.
