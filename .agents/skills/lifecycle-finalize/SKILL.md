---
name: lifecycle-finalize
description: Permanent documentation sync, dual-target rule/skill evolution from 04-refine.md, copy-paste PR suite generation, and lifecycle directory cleanup (Lifecycle: Finalize).
---

# Lifecycle Finalize

The `lifecycle-finalize` skill permanently captures product knowledge, evolves codebase rules and skills from `04-refine.md`, generates a copy-paste PR summary, and cleans up the temporary `lifecycle/` directory.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Finalize Principles

- **Permanent Truth Only:** Sync only the final, verified truth from `01-requirements.md` and `03-roadmap.md` into `docs/modules/<module>/` and `GLOSSARY.md` using **1-fact-per-line nested sub-bullets**.
- **Preserve Managed Guideline Hashes:** Never edit inside `<!-- lifecycle:guideline:start ... -->` markers in consumer projects; append project-specific rules **below `<!-- lifecycle:guideline:end -->`** so future `./install-lifecycle.sh` updates succeed.
- **100% Manual Git:** Never run `git add`, `git commit`, `git push`, or `gh pr create`.

---

## Step 1: Entry Gate & Artifact Collection

1. Read `lifecycle/00-status.md`, verify **`Review` is `Done`**, and set `Finalize` to **`In Progress`**.
2. Read `lifecycle/01-requirements.md`, `lifecycle/03-roadmap.md`, and `lifecycle/04-refine.md`.

> **➡️ Sign-off & Transition to Step 2:** Review is verified `Done` and all tracking artifacts are ingested.

---

## Step 2: Permanent Project Documentation Sync

Update permanent docs using **1-fact-per-line nested sub-bullets**:

1. **Modular Module Docs (`docs/modules/<module>/`):**
   - **Module Overview (`docs/modules/<module>/README.md`):** Create or update from [Module README Template](../lifecycle/templates/module_readme.md). Update domain models, schemas, feature index links, and append any **Deferred Requirements** from `01-requirements.md` (`## 8`) under `## 5. Scope Boundaries & Cross-Module Dependencies` (`Deferred (Future Backlog)`). If any legacy feature/screen was removed during this cycle, remove or update its stale entry in `docs/modules/<module>/`.
   - **Feature Spec (`docs/modules/<module>/feature_<name>.md`):** Create or update from [Feature Template](../lifecycle/templates/module_feature.md). Sync the final workflows, file touchpoints, `BR-X` business rules (`## 3`), and `Key Architectural Decisions` (`## 6`).
2. **Domain Glossary (`GLOSSARY.md`):**
   - Sync any staged terms from `## 7. Glossary Updates` in `01-requirements.md` into `GLOSSARY.md` alphabetically.
3. **Public Project Docs (`README.md`):**
   - Update `README.md` only if setup instructions, env vars, or CLI flags changed.

> **➡️ Sign-off & Transition to Step 3:** Permanent module docs, decisions, backlog, and glossary are synced on disk.

---

## Step 3: Process Evolution ("Friction to Wisdom" from `04-refine.md`)

Review every entry in `lifecycle/04-refine.md`:

1. **Target A — Project Rules (`.agents/rules/*.md`):**
   - In consumer projects, append project-specific rules **below `<!-- lifecycle:guideline:end -->`** (or in a project-local rule file) so managed SHA-256 hashes stay intact.
   - Update `Target File Updated` in `04-refine.md`.
2. **Target B — Upstream Skills & Universal Rules Sync:**
   - For universal framework rules or lifecycle skill improvements: update directly if inside the central `skills` repo, or output an **Upstream Skill / Rule Improvement Block** in chat for the user to copy back to the central `skills` repo:
     ```markdown
     ### 🔄 Upstream Skill / Rule Improvement
     - **Target:** `<skill_name or .agents/rules/file.md>`
     - **Problem:** <1-line friction summary>
     - **Recommended Upstream Fix:** <1-line instruction or rule change>
     ```

> **➡️ Sign-off & Transition to Step 4:** All `04-refine.md` entries are resolved.

---

## Step 4: Copy-Paste PR Suite Generation

Output a clean, copy-pasteable Pull Request description in chat:

```markdown
# 🚀 Pull Request: <Concise Feature Title>

## 1. Outcome Summary
- **Problem Solved:** <1-line root user or operational problem>
- **Delivered Outcome:** <1-line summary of what works now>

## 2. Key Changes & File Touchpoints
- **<Core Capability 1>:**
  - `<path/to/file>`: <1-line change summary>
- **Documentation & Rules:**
  - Updated `docs/modules/<module>/`, `GLOSSARY.md`, and `.agents/rules/<rule>.md`

## 3. Verification & Evidence
- **Automated Tests:** `<test command>` passed 100% cleanly.
- **Static Analysis:** `<analyzer command>` reported 0 issues.
- **Manual Verification Steps:**
  1. <Action step 1> -> <Expected result>

## 4. Business Rules Enforced
- **BR-1 (`<Rule Name>`):** <1-line invariant>
```

> **➡️ Sign-off & Transition to Step 5:** Copy-paste PR suite is ready.

---

## Step 5: Final Handoff & Confirmed `lifecycle/` Cleanup

1. Set `Finalize` to **`In Review`** in `lifecycle/00-status.md`.
2. Present the updated permanent doc links, any Upstream Improvement Blocks, and the copy-paste PR suite in chat, then ask:
   > *"Finalize is complete. Once you approve, should I delete the temporary `lifecycle/` directory (`rm -rf lifecycle/`) or archive it before your manual git commit?"*
3. **STOP** and wait for user approval.
4. **On User Approval:** Mark `Finalize` as **`Done`**, delete `lifecycle/` (`rm -rf lifecycle/`) or move it to `docs/lifecycle/<feature-name>/` as instructed, and confirm the workspace is clean for manual commit.
