---
name: lifecycle-finalize
description: Permanent documentation sync, dual-target rule/skill evolution from 04-refine.md, copy-paste PR suite generation, and lifecycle directory cleanup (Lifecycle: Finalize).
---

# Lifecycle Finalize

The `lifecycle-finalize` skill permanently captures product knowledge, evolves codebase rules, generates a copy-paste PR suite, and cleans up temporary lifecycle artifacts. Your mission is to update permanent documentation (`docs/modules/`, `GLOSSARY.md`), turn logged friction into permanent rules ("Friction to Wisdom"), generate a release-ready PR summary, and clean the repository for the user's manual git commit.

Follow this strict 5-step sequence. Each step has an explicit sign-off condition before advancing to the next.

---

## 0. Core Finalize Mindset: Permanent Truth, Atomic Readability & Clean Repo

- **Permanent Knowledge Over Ephemeral Notes:** The temporary `lifecycle/` folder will be deleted. Any architecture, rule, or glossary term not copied to permanent docs will be permanently lost.
- **One Fact Per Line (No Paragraph Bullets):** When updating `docs/modules/<module>/`, `GLOSSARY.md`, or `.agents/rules/`, break every concept, rule, and feature detail into **short nested sub-bullets (1 line = 1 atomic detail)**—never write multi-sentence paragraph bullets.
- **Continuous Evolutionary Improvement:** Every mistake or friction logged in `04-refine.md` must either update `.agents/rules/` or produce an upstream skill improvement so the system permanently learns.
- **Manual Git Boundary:** Never run `git add`, `git commit`, `git push`, or `gh pr create`. Staging, committing, and PR creation are 100% manual by the user.

---

## Step 1: Entry Gate & Artifact Collection

1. **Verify Entry Gate:**
   - Read `lifecycle/00-status.md`.
   - Verify that **`Review` is marked `Done`**.
   - If `Review` is `In Progress` or `In Review`, STOP—instruct user to complete the Review audit first.
2. **Lock Status to In Progress:**
   - Update `Finalize` in `lifecycle/00-status.md` to **`In Progress`**.
3. **Collect Tracking Artifacts:**
   - Read `lifecycle/01-requirements.md` (for Glossary Updates, Business Rules, and Outcome).
   - Read `lifecycle/03-roadmap.md` (for Touched Files and Verification Evidence).
   - Read `lifecycle/04-refine.md` (for logged friction and process lessons).

> **➡️ Sign-off & Transition to Step 2:** Review is verified `Done` and all tracking artifacts are ingested.

---

## Step 2: Permanent Project Documentation Sync

Update project documentation using **1-fact-per-line nested sub-bullets** so future agents and humans can skim and understand the module in seconds:

1. **Modular Module Documentation (`docs/modules/<module>/`):**
   - Each business domain owns a dedicated folder: `docs/modules/<module>/`.
   - **Module Overview (`docs/modules/<module>/README.md`):** Create or update from [Module README Template](../lifecycle/templates/module_readme.md). Document domain ownership, shared data models, database collections/schemas, and index all feature specs.
   - **Dedicated Feature Spec (`docs/modules/<module>/feature_<name>.md`):** Create from [Feature Template](../lifecycle/templates/module_feature.md). Document the feature's problem/capability, workflows, file touchpoints, and scoped `BR-1..BR-X` business rules from `01-requirements.md` (with 1-line invariant and enforcement sub-bullets).
   - *(Legacy Migration: If an existing monolithic `docs/modules/<module>.md` exists and is growing past ~500 lines, split it into the `docs/modules/<module>/` directory pattern).*
2. **Domain Glossary (`GLOSSARY.md`):**
   - Check `## 7. Glossary Updates (Staged)` in `01-requirements.md`.
   - If new domain terms were staged, append them into `GLOSSARY.md` in alphabetical order with concise 1-line definitions.
3. **Public Project Docs (`README.md`):**
   - Update `README.md` if the feature introduced new environment variables, public CLI flags, or setup instructions.

> **➡️ Sign-off & Transition to Step 3:** Permanent module documentation and glossary are updated on disk with 1-fact-per-line formatting.

---

## Step 3: Process Evolution ("Friction to Wisdom" from `04-refine.md`)

Turn temporary friction into permanent wisdom so future agents never repeat the same mistakes:

1. **Review All Logged Friction:**
   - Inspect every entry in `lifecycle/04-refine.md`.
2. **Target A: Project Rules (`.agents/rules/*.md`):**
   - If an entry solved code conventions, framework pitfalls, or architectural confusion:
     - Update the relevant `.agents/rules/<rule>.md` file with a crisp, 1-line bulleted invariant.
     - In `04-refine.md`, update `Target File Updated: .agents/rules/<rule>.md`.
3. **Target B: Lifecycle Skills Evolution & Upstream Sync:**
   - If an entry was caused by a lifecycle skill ambiguity, missing step, or gate confusion:
     - If working in the central skills repository, update the relevant `SKILL.md` directly.
     - If working in a consumer project, generate an **"Upstream Skill Improvement Block"** in chat so the user can paste it into the central `skills` repository to upgrade the master skills:
       ```markdown
       ### 🔄 Upstream Skill Improvement
       - **Skill:** `<skill_name>`
       - **Problem:** <1-line description of what caused friction>
       - **Recommended Upstream Fix:** <1-line concrete instruction change>
       ```
     - In `04-refine.md`, update `Target File Updated: Upstream Sync`.

> **➡️ Sign-off & Transition to Step 4:** Every entry in `04-refine.md` is addressed; permanent rules are updated on disk.

---

## Step 4: Copy-Paste PR Suite Generation

Generate a complete, professional Pull Request description formatted in Markdown:

```markdown
# 🚀 Pull Request: <Concise Feature Title>

## 1. Outcome Summary
- **Problem Solved:** <1-line root user or operational problem>
- **Delivered Outcome:** <1-line summary of what works now>

## 2. Key Changes & File Touchpoints
- **<Core Capability 1>:**
  - `<path/to/file>`: <1-line change summary>
- **<Core Capability 2>:**
  - `<path/to/file>`: <1-line change summary>
- **Documentation & Rules:**
  - Updated `docs/modules/<module>/`, `GLOSSARY.md`, and `.agents/rules/<rule>.md`

## 3. Verification & Evidence
- **Automated Tests:** `<test command>` passed 100% cleanly.
- **Static Analysis:** `<analyzer command>` reported 0 issues.
- **Manual Verification Steps:**
  1. <Action step 1> -> <Expected result>
  2. <Action step 2> -> <Expected result>

## 4. Business Rules Enforced
- **BR-1 (`<Rule Name>`):** <1-line invariant>
- **BR-2 (`<Rule Name>`):** <1-line invariant>
```

> **➡️ Sign-off & Transition to Step 5:** PR suite is generated in chat; manual git boundary is respected (no git commit or push commands run).

---

## Step 5: Final Handoff & Confirmed `lifecycle/` Cleanup

1. **Update Status Dashboard:**
   - Update `Finalize` in `lifecycle/00-status.md` to **`In Review`**.
2. **Present Final Handoff in Chat:**
   - Summarize the updated permanent documentation files (`docs/modules/`, `GLOSSARY.md`, rules).
   - Present the copy-paste PR suite.
   - Ask for confirmation to clean up the temporary directory:
     > *"Finalize is complete. All permanent docs and rules are updated, and the PR summary is ready above. Once you approve, should I delete the temporary `lifecycle/` directory (`rm -rf lifecycle/`) or archive it before your manual git commit?"*
3. **STOP.** Wait for explicit human approval.
4. **On User Approval:**
   - Mark `Finalize` as **`Done`** in `00-status.md`.
   - If user confirms deletion: delete the temporary `lifecycle/` directory (`rm -rf lifecycle/`).
   - If user confirms archiving: move `lifecycle/` to `docs/lifecycle/<feature-name>/` (or preferred archive path).
   - Output final success message:
     > *"Lifecycle complete! Workspace is clean and ready for your manual git commit and push."*
