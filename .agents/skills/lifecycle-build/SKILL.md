---
name: lifecycle-build
description: Execute exactly ONE checkpoint from the 02-plan.md file, perform self-review, check the boxes, and stop for human approval.
---

# Build

The goal of this skill is to execute the implementation plan precisely as designed in the `02-plan.md` artifact.

## 1. Entry Gate (MANDATORY)
Before executing any code or analyzing checkpoints, you must read `02-plan.md` and verify that the `[ ] Plan Approved` box at the very top of the file is checked (e.g., `[x] Plan Approved`).
- If this box is unchecked, you must **STOP** and refuse to build. Ask the user to approve the plan first.
- Only proceed if the user has explicitly approved the plan and checked the box.

## 2. Execution Constraints (EXTREMELY IMPORTANT)
You are strictly forbidden from executing multiple checkpoints at the same time. You must behave like a senior developer making granular, isolated commits.
- **Rule 1:** Read `02-plan.md`. Identify the *very first* uncompleted Checkpoint.
- **Rule 2:** Execute the Build Actions for that Checkpoint ONLY. Do NOT write code for the next checkpoint.
- **Rule 3:** If the checkpoint involves Mock UI, do NOT connect it to the real database yet. Wait for the Logic checkpoint.

## 3. Agent Self-Review
Before you declare the checkpoint "Done", you MUST execute the steps listed under **Agent Self-Review** in the plan.
- If the plan tells you to read a guideline file in `.agents/guidelines/`, you must physically use your file reading tool to open it, read it, and ensure your code complies.
- Fix any issues you find during this self-review silently before presenting to the user.

## 4. The Interactive Checklist
Since we do not use bloated tracking files, the `02-plan.md` document itself acts as your tracking file. 
Once a checkpoint is complete and self-reviewed, you must edit the `02-plan.md` file and physically place an `x` in the markdown checkboxes for that specific checkpoint.

## 5. The Friction Log
If you struggle with missing rules, ambiguous guidelines, or unexpected technical roadblocks while building, you MUST document them by creating or appending to a `friction_log.md` file in the temporary `lifecycle` directory. 
- Do not stop building to fix the rules, just log the friction and keep going.
- **Exception:** If an unresolved requirement or impossible verification step completely BLOCKS development, you must **STOP** and ask the user for a decision or replan before continuing dependent work.

## 6. Human Handoff
After checking your self-review boxes in `02-plan.md`, **STOP**. Prompt the user to verify the checkpoint using the instructions written in the `User Verification` section of the plan.

Do not proceed to the next checkpoint until the user explicitly approves. Once they approve, you must edit `02-plan.md` to check the `[ ] Checkpoint Approved` box before moving to the next checkpoint. 
- If you are resumed in a new conversation, ALWAYS check for the `Checkpoint Approved` box. 
- If it is unchecked, you must await approval or fix the user's requested changes before moving on.
