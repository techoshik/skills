---
name: lifecycle-finalize
description: Run global tests, synchronize documentation, commit the feature, and clean up temporary lifecycle files.
---

# Finalize

The goal of this skill is to rapidly and safely integrate the completed feature into the codebase. Because the feature was already verified layer-by-layer during the Build phase, there is no need to write another heavy documentation file.

## 1. Global Verification
You must ensure no regressions were introduced to the rest of the project. 
- Use your terminal tools to run `flutter analyze` in the project root.
- Use your terminal tools to run `flutter test` (if applicable).
- If any global checks fail, you must stop and fix them before proceeding.

## 2. Documentation Synchronization
Briefly check if the newly implemented Expected Outcomes require an update to the project's permanent documentation (e.g., `README.md`). If they do, update them directly. 

## 3. The Improvement Loop
Before asking for human approval, you must check if a `friction_log.md` file exists in the temporary `lifecycle` directory. 
- If the agent struggled with missing or ambiguous rules during any phase, you must edit the relevant `.agents/guidelines/` files or `SKILL.md` files to permanently fix the ambiguity so future agents don't make the same mistake.
- If the `friction_log.md` does not exist, do nothing.

## 4. Human Approval (MANDATORY)
After running verification, updating documentation, and applying any guideline improvements from the Friction Log, you must **STOP** and present the results to the user. Do not commit anything yet. Wait for the user to review the test results, documentation, and guideline improvements.

## 5. Commit & Cleanup
Once the user explicitly approves the final state:
1. Stage all approved changes.
2. Commit the changes using a clean, descriptive commit message based on the Expected Outcomes listed in `01-idea.md`.
3. Safely delete the temporary `lifecycle` tracking directory (which contains the `idea`, `plan`, and `build` markdown files), as they are no longer needed.
