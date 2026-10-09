---
name: lifecycle-execute
description: Execute exactly ONE checkpoint from the 02-outline.md file, perform self-review, check the boxes, and stop for human approval (DOER: Execute).
---

# Execute

The goal of this skill is to **Execute** the implementation outline precisely as designed in the `02-outline.md` artifact (Phase E of DOER).

## 1. Entry Gate (MANDATORY)
Before executing any code or analyzing checkpoints, you must read `02-outline.md` and verify that the `[ ] Outline Approved` box at the very top of the file is checked (e.g., `[x] Outline Approved`).
- If this box is unchecked, you must **STOP** and refuse to execute. Ask the user to approve the outline (`lifecycle-outline`) first.
- Only proceed when the user's explicit outline approval is recorded in that box.

## 2. Execution Constraints (EXTREMELY IMPORTANT)
You are strictly forbidden from executing multiple checkpoints at the same time. You must behave like a senior developer making granular, isolated commits.
- **Rule 1:** Read `02-outline.md`. Identify the *first applicable checkpoint* where `[ ] Checkpoint Approved` is unchecked. (Skip checkpoints marked `N/A` without changing any of their boxes; their omission was approved with the outline).
- **Rule 2:** Check its status: if its Build Actions or self-review boxes are incomplete, execute ONLY the remaining actions for that checkpoint. If both are already complete, do NOT write code for subsequent checkpoints; await user verification/approval or address requested fixes.
- **Rule 3:** If the checkpoint involves Mock UI, do NOT connect it to the real database yet. Wait for the Logic checkpoint.

## 3. Agent Self-Review
Before you declare the checkpoint "Done", you MUST execute the steps listed under **Agent Self-Review** in the outline.
- If the outline tells you to read a guideline file in `.agents/guidelines/`, you must physically use your file reading tool to open it, read it, and ensure your code complies.
- Fix any issues you find during this self-review silently before presenting to the user.

## 4. The Interactive Checklist
Since we do not use bloated tracking files, the `02-outline.md` document itself acts as your tracking file. 
Once a checkpoint is complete and self-reviewed, you must edit the `02-outline.md` file and physically place an `x` in the **implementation and self-review** markdown checkboxes for that specific checkpoint.
- **Approval:** Never check the `[ ] Checkpoint Approved` box on your own. You may check it only after the user explicitly grants approval in conversation.

## 5. The Friction Log
If you struggle with missing rules, ambiguous guidelines, or unexpected technical roadblocks while executing, you MUST document them by creating or appending to a `friction_log.md` file in the temporary `lifecycle` directory. 
- Do not stop executing to fix the rules, just log the friction and keep going.
- **Exception:** If an unresolved requirement or impossible verification step completely BLOCKS development, you must **STOP** and ask the user for a decision or replan before continuing dependent work.

## 6. Human Handoff
After checking your self-review boxes in `02-outline.md`, **STOP**. Prompt the user to verify the checkpoint using the instructions written in the `User Verification` section of the outline.

Do not proceed to the next checkpoint until the user explicitly approves. Once they approve, you must edit `02-outline.md` to check the `[ ] Checkpoint Approved` box before moving to the next checkpoint. 
- On resumption, find the first applicable checkpoint with `Checkpoint Approved` unchecked.
- If its action or self-review boxes are incomplete, continue only that checkpoint.
- If both are complete:
  - If the user explicitly approved, check the `[ ] Checkpoint Approved` box and advance to the next checkpoint.
  - If the user requested fixes, address them, complete self-review, and re-prompt for verification.
  - Otherwise, wait for the user's explicit approval before advancing.
