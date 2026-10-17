---
name: lifecycle-refine
description: Conduct full-branch two-axis code review, global test verification, documentation & PR synthesis, guideline evolution from friction logs, and clean up temporary lifecycle files (DOER: Refine).
---

# Refine

The goal of this skill is to **Refine** and safely integrate the completed feature into the codebase (Phase 4 of the DOER lifecycle). Your mission is to audit the full branch diff along two distinct axes (Standards and Spec), run global verification, generate a polished Pull Request description, evolve permanent project guidelines from logged friction, and clean up the temporary workspace.

---

## 1. Entry Gate (Strict Status Check)

Before refining:
1. Open `lifecycle/03-execute.md`.
2. Verify that **all checkpoints are marked `Done`**.
3. **STOP if unapproved:** If any checkpoint is still `Todo`, `In Progress`, or `User Review`, do not proceed. Instruct the user to complete and approve the Execute phase first.
4. Set `Phase 4: Refine` status in `lifecycle/03-execute.md` to **`In Progress`**.

---

## 2. Two-Axis Full-Branch Code Review (Internal Agent Audit)

Before drafting deliverables, inspect the complete branch diff against the base branch using `git diff <base-branch>...HEAD` (or `git status` / `git diff HEAD~<N>`). Review the changes across two separate, un-merged axes. Fix any issues silently before moving forward; do NOT write procedural checkboxes into markdown artifacts:

### Axis 1: Standards & Hygiene
- **Diff Hygiene:** Check for leftover debug statements (`print`, `console.log`, `debugger`), commented-out code, and unintended whitespace or formatting edits.
- **Rule Compliance:** Audit touched files against `.agents/rules/` for consistent conventions across all checkpoints.
- **File Sizing Audit (500-Line Soft Ceiling):** Verify that no modified or newly created non-generated file exceeds ~500 lines without natural architectural decomposition (sub-widgets or sub-controllers).
- **Code Smells:** Look for Fowler smells:
  - *Duplicated Code:* Logic copy-pasted across multiple hunks.
  - *Primitive Obsession:* Naked strings/ints used where a domain enum or value object belongs.
  - *Feature Envy:* Methods reaching across boundaries instead of living on the owning state/controller.
  - *Speculative Generality:* Unused parameters or speculative hooks not required by the feature.

### Axis 2: Spec Faithfulness
- Re-read `lifecycle/01-define.md`.
- **Success Criteria Re-Check:** Verify that every single Success Criterion is 100% satisfied by the integrated code. Ensure intermediate refactors did not accidentally break earlier outcomes.
- **Scope Creep Audit:** Ensure no un-requested behavior or rogue functionality slipped into the branch.

---

## 3. Global Verification & Infrastructure (Internal Agent Prerequisite)

Run project-wide checks to guarantee no regressions were introduced to the repository. Resolve any issues before drafting `04-refine.md`:

1. **Static Analysis:** Run the global linter across all affected projects/packages (e.g. `flutter analyze`, `npm run lint`). It must report **0 errors/warnings**.
2. **Automated Test Suites:** Run all affected test suites. Ensure **100% passing tests**.
3. **Database & Cloud Infrastructure:**
   - Verify composite indexes (e.g., `firestore.indexes.json`).
   - Verify database migrations or schema files (or mark "N/A" if greenfield/unmodified).
   - Verify security rules for any newly introduced endpoints or collections.

---

## 4. Documentation & PR Synthesis (`04-refine.md`)

Now author `lifecycle/04-refine.md` focusing strictly on high-value user deliverables:

1. **Pull Request Synthesis:** Complete `## 1. Pull Request Details` in `lifecycle/04-refine.md`:
   - **PR Title:** Semantic title `<type>(<scope>): <summary>` matching the List of Changes.
   - **Summary:** Concise bullets describing the business outcome and primary affordances.
   - **Key Changes:** Area-by-area breakdown of files and subsystems modified.
   - **Verification:** Concrete proof that the feature works (passing test results, analyzer output, manual steps).
2. **Permanent Updates:** Complete `## 2. Permanent Updates` in `lifecycle/04-refine.md`:
   - Note any `.agents/rules/` files updated, new domain terms added to `GLOSSARY.md`, or README updates made (or mark "None needed").

---

## 5. The Rule Improvement Loop (Friction to Wisdom)

Inspect `## 3. Friction & Lessons Learned` in `lifecycle/04-refine.md`:
1. If unexpected roadblocks, ambiguities, or bugs were logged during Define, Outline, or Execute:
   - Carefully evaluate the root cause.
   - **Permanent Rule Evolution:** Choose the permanent owner and edit the file:
     - Update `.agents/rules/<rule>.md` if an architectural standard or coding rule was missing or ambiguous.
     - Update `GLOSSARY.md` if domain terminology caused confusion.
     - Add a custom linter rule or automated test if a mechanical bug was caught late.
   - Record the permanent resolution under each friction entry in `04-refine.md`.
2. If no friction occurred across the task, state *"None recorded"*.

---

## 6. Human Handoff (Approval Gate)

1. Update `Phase 4: Refine` status in `lifecycle/03-execute.md` to **`User Review`**.
2. Present `lifecycle/04-refine.md` to the user in chat:
   - Highlight the Two-Axis review findings.
   - Highlight passing global verification and test runs.
   - Highlight any permanent `.agents/rules/` updates made.
   - Present the copy-paste ready PR title and description.
3. **STOP AND WAIT.** Do not delete files or commit code. Wait for the user's explicit sign-off in chat.

---

## 7. Workspace Cleanup (Upon Approval)

Once the user explicitly reviews and approves the Refine phase in chat:
1. Update `Phase 4: Refine` in `lifecycle/03-execute.md` to **`Done`**.
2. **Safely delete the temporary `lifecycle/` directory** (`rm -rf lifecycle/`) as all four phases are officially complete.
3. Inform the user:
   > *"All lifecycle phases are complete and verified. The temporary `lifecycle/` directory has been cleaned up. The repository is clean and ready for you to stage and commit using the generated PR title and description."*
4. **Strict Boundary Reminder:** Never run `git add`, `git commit`, or `git reset`. Staging and committing are 100% owned by the user.
