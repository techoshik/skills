---
name: lifecycle-build
description: Execute exactly ONE checkpoint from the 02-plan.md file, perform self-review, check the boxes, and stop for human approval.
---

# Build

The goal of this skill is to execute the implementation plan precisely as designed in the `02-plan.md` artifact.

## 1. Execution Constraints (EXTREMELY IMPORTANT)
You are strictly forbidden from executing multiple checkpoints at the same time. You must behave like a senior developer making granular, isolated commits.
- **Rule 1:** Read `02-plan.md`. Identify the *very first* uncompleted Checkpoint.
- **Rule 2:** Execute the Build Actions for that Checkpoint ONLY. Do NOT write code for the next checkpoint.
- **Rule 3:** If the checkpoint involves Mock UI, do NOT connect it to the real database yet. Wait for the Logic checkpoint.

## 2. Agent Self-Review
Before you declare the checkpoint "Done", you MUST execute the steps listed under **Agent Self-Review** in the plan.
- If the plan tells you to read a guideline file in `.agents/guidelines/`, you must physically use your file reading tool to open it, read it, and ensure your code complies.
- Fix any issues you find during this self-review silently before presenting to the user.

## 3. The Interactive Checklist
Since we do not use bloated tracking files, the `02-plan.md` document itself acts as your tracking file. 
Once a checkpoint is complete and self-reviewed, you must edit the `02-plan.md` file and physically place an `x` in the markdown checkboxes for that specific checkpoint.

## 4. The Friction Log
If you struggle with missing rules, ambiguous guidelines, or unexpected technical roadblocks while building, you MUST document them by creating or appending to a `friction_log.md` file in the temporary `lifecycle` directory. Do not stop building to fix the rules, just log the friction and keep going.

## 5. Human Handoff
After checking the boxes in `02-plan.md`, **STOP**. Prompt the user to verify the checkpoint using the instructions written in the `User Verification` section of the plan.

Do not proceed to the next checkpoint until the user explicitly approves.
