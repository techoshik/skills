---
name: lifecycle-review
description: Comprehensive full-branch code audit, spec-to-code truth verification, integration seam check, two-tier deduplication, and diff hygiene (Lifecycle: Review).
---

# Lifecycle Review

The `lifecycle-review` skill audits the **entire branch as a unified whole** after all roadmap tasks are complete. Your mission is to verify that `01-requirements.md` and the actual code match 100% (with all checkboxes checked and zero stale/contradictory specs from mid-flight pivots), verify cross-task integration seams, enforce `.agents/rules/`, deduplicate repeated code, and run full verification.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Review Principles

- **Audit the Whole Branch with Fresh Eyes:** Spawn a fresh auditor sub-agent (when supported) to inspect all modified and newly created untracked files without conversation bias.
- **Verify Spec Truth Before Finalize:** If mid-flight pivots occurred during `Execute`, verify that `01-requirements.md` and `03-roadmap.md` accurately reflect the final built code so `Finalize` never writes stale specs into permanent `docs/modules/` documentation.

---

## Step 1: Entry Gate & Complete Branch Scope Discovery

1. **Verify Entry Gate:**
   - Read `lifecycle/00-status.md`, verify all roadmap tasks are **`Done`**, and set `Review` to **`In Progress`**.
2. **Discover Complete Branch Scope (Tracked + Untracked Files):**
   - Run read-only `git status --short`, `git diff HEAD`, and `git diff origin/main...HEAD`.
   - **Explicitly Read All Untracked (`??`) Files:** Because `git add` is manual, newly created source and test files are untracked and do not appear in `git diff HEAD`. Read the full contents of every untracked file listed by `git status --short`.

> **➡️ Sign-off & Transition to Step 2:** Full branch scope (committed + modified + untracked files) is mapped.

---

## Step 2: The 5-Point Full-Branch Audit

### 1. Spec-to-Code Truth & Checkbox Integrity (`01-requirements.md` & `03-roadmap.md`)
- Verify that every `REQ-X`, `AC-X.Y`, and `BR-X` in `01-requirements.md` holds true in the integrated code.
- **Zero Stale Spec Contradictions:** Check `01-requirements.md` from top to bottom—if any mid-flight UX change or pivot occurred during `Execute`, ensure superseded lines in `01-requirements.md` were replaced in place and all completed `REQ-X` / `AC-X.Y` checkboxes are marked **`[x]`**.

### 2. Cross-Task Seam & Integration Check
- Trace end-to-end flows across tasks: `Input → Validation → State/Controller → Repository → UI Refresh`.
- Verify navigation routes, deleted screen/route cleanup, and state/cache invalidations across screens.

### 3. Guidelines & Diff Hygiene (`.agents/rules/`)
- Verify `<500` lines per file, canonical folder/file naming (`<domain>_validator`, 4-tier widget placement), and framework invariants.
- Remove all dead code, unused imports, deprecated aliases slated for removal, and debug logs (`print`, `debugPrint`, `console.log`).

### 4. Security, Tenancy & Performance
- Confirm tenant/role checks on all queries/mutations, zero N+1 queries inside loops/builders, and proper disposal of controllers/streams.

### 5. Two-Tier Smart Deduplication
- **Tier 1 (Intra-Module):** Consolidate duplicated widgets, validation helpers, or logic across touched files into module `widgets/` or `utils/`.
- **Tier 2 (Cross-Module / `core/`):** Reuse existing shared components first; ask the user before modifying shared `core/` files used by unrelated modules.

> **➡️ Sign-off & Transition to Step 3:** All 5 audit dimensions are checked.

---

## Step 3: Apply Fixes & Sync Artifacts

1. Apply safe in-branch cleanups, dead-code removal, and intra-module deduplications directly.
2. Repair any stale lines or unchecked `[ ]` boxes in `01-requirements.md` and `03-roadmap.md` so the artifacts match the final code 100%.
3. If a major missing capability is uncovered, add a new numbered `Task N` to `03-roadmap.md` and `00-status.md` and return to `Execute`.

> **➡️ Sign-off & Transition to Step 4:** Code and `lifecycle/` specs are clean and 100% synchronized.

---

## Step 4: Global Verification (Full Analyzer & Test Suite)

1. Run the project-wide static analyzer (`0` issues) and full relevant test suite (`100%` pass).
2. Run read-only `git status` and `git diff` to confirm workspace cleanliness.

> **➡️ Sign-off & Transition to Step 5:** Global analyzer and test suite pass with 0 issues.

---

## Step 5: Refinement Logging & Audit Handoff

1. Append any lessons learned or rule gaps to `lifecycle/04-refine.md`.
2. Set `Review` to **`In Review`** in `lifecycle/00-status.md`.
3. Present a concise 5-bullet review summary in chat (linking to `01-requirements.md` and `03-roadmap.md`, no chat tables):
   - **Spec & AC Integrity:** Confirmation that code and `01-requirements.md` match 100% with all `[x]` boxes checked.
   - **Seam & Integration Check:** Cross-task flows, routes, and state updates verified.
   - **Guidelines & Hygiene:** `<500` lines, canonical file placement, and zero dead/debug code confirmed.
   - **Security & Performance:** Tenant/role boundaries and query efficiency confirmed.
   - **Deduplications & Test Proof:** Summary of cleanups made + global analyzer/test pass proof.
4. **STOP** and wait for user approval. On approval, mark `Review` as **`Done`** in `00-status.md`, read [`lifecycle-finalize/SKILL.md`](../lifecycle-finalize/SKILL.md), and auto-advance to Finalize.
