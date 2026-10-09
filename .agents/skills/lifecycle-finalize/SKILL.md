---
name: lifecycle-finalize
description: Run global tests, synchronize documentation, commit the feature, and clean up temporary lifecycle files.
---

# Finalize

The goal of this skill is to rapidly and safely integrate the completed feature into the codebase. Because the feature was already verified layer-by-layer during the Build phase, there is no need to write another heavy documentation file.

## 1. Entry Gate (MANDATORY)
Before running any checks, read `02-plan.md` and verify that `Plan Approved` and every applicable `Checkpoint Approved` box are checked.
- If the plan or any applicable checkpoint is unapproved, you must **STOP** and refuse to finalize. Instruct the user to complete the Build phase (`lifecycle-build`) first.
- Ignore checkpoints marked `N/A`; their omission was approved with the plan, even if they still contain unchecked boxes.
- Reconcile the complete change: run `git status` AND `git diff --name-only main...HEAD` (or equivalent base branch) to inspect all work done for this feature. Ensure you only stage/commit changes relevant to the Expected Outcomes, preserving unrelated changes.

## 2. Global Verification
You must ensure no regressions were introduced to the affected projects. 
- Identify which sub-projects were modified (e.g., `app/`, `functions/`).
- Use your terminal tools to run the appropriate static analysis commands in the correct directories (e.g., `flutter analyze` inside `app/`, or `npm run lint` inside `functions/`).
- Use your terminal tools to run unit tests (if applicable) in the affected directories.
- If any global checks fail, you must stop and fix them before proceeding.

## 3. Documentation Synchronization
Briefly check if the newly implemented Expected Outcomes require an update to the project's permanent documentation (e.g., `README.md`). If they do, update them directly. 

## 4. The Improvement Loop
Before asking for human approval, you must check if a `friction_log.md` file exists in the temporary `lifecycle` directory. 
- If the agent struggled with missing or ambiguous rules during any phase, carefully evaluate the recorded evidence.
- Choose the correct permanent owner (`.agents/guidelines/` files or `SKILL.md` files) and edit it to permanently fix the ambiguity.
- You may defer or dismiss a friction entry if the evidence does not support rewriting a global rule.
- If the `friction_log.md` does not exist, do nothing.

## 5. Human Approval (MANDATORY)
After running verification, updating documentation, and applying any guideline improvements from the Friction Log, you must **STOP** and present the results to the user. Do not commit anything yet. Wait for the user to review the test results, documentation, and guideline improvements.

## 6. Commit & Cleanup
Once the user explicitly approves the final state:
1. Safely delete the temporary `lifecycle` tracking directory (which contains the `idea`, `plan`, and `build` markdown files), as they are no longer needed.
2. Stage all approved changes (which will now include the deletion of the tracking directory).
3. Commit the changes using a clean, descriptive commit message based on the Expected Outcomes listed in `01-idea.md`.
