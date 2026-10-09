---
name: lifecycle-plan
description: After Idea approval, act as a Technical Architect to align on technical decisions, then define the implementation plan using horizontal architectural checkpoints.
---

# Plan

The goal of this skill is to take the Expected Outcomes (EO) from the Idea phase and break them down into extremely granular, reviewable implementation checkpoints.

## 1. Required Inputs
Before generating a plan, you must have an approved `01-idea.md` document containing the Micro-Stories/Expected Outcomes. If this does not exist, ask the user to complete the Idea phase first.

## 2. The Research Loop (MANDATORY)
Before writing the plan or asking the user any questions, you must act as a Technical Lead and research the existing codebase, guidelines, and documentation.
- If you find an established architectural pattern that perfectly answers how the feature should be built, **do not ask the user a redundant question**. Apply the pattern directly.
- If the documentation is ambiguous, outdated, or there are multiple conflicting patterns, you must gather this context to present to the user.

## 3. The Architectural Alignment Loop
Do NOT generate the `02-plan.md` document immediately. If the research loop revealed technical ambiguities or multiple valid ways to build a feature (e.g., local UI filtering vs. backend Firestore querying):
- You must ask the user multiple-choice questions to align on the architecture.
- Ask 1 to 2 technical questions (using Radio buttons or Checkboxes).
- E.g., *"Should this search input be a reusable widget in `core/` or specific to this feature?"*
- E.g., *"Should we filter the users locally in Dart to save Firestore reads, or query Firestore directly?"*

## 4. Planning Constraints (The Matrix)
Once technical decisions are aligned, you must **never** plan to build an entire feature (Models, UI, and Database) in a single step. 
You must iterate through each Expected Outcome, and break it down into strict architectural checkpoints:
- **Checkpoint 1:** Data Models & DTOs
- **Checkpoint 2:** UI Layout & States (Mocked data only, for visual/interaction verification)
- **Checkpoint 3:** Repositories & Logic (Implement backend and REPLACE the mock data from Checkpoint 2 with live data)

*Note: If an outcome does not require one of these layers (e.g., a pure backend fix doesn't need UI, or a pure visual tweak doesn't need Models/Logic), you must still list the Checkpoint in the plan, but mark it as `N/A - [Reason]` so it is explicitly skipped.*

## 5. The Friction Log
If you struggle with ambiguous architectural guidelines or missing rules during the Plan phase, you MUST document them by creating or appending to a `friction_log.md` file in the temporary `lifecycle` directory. Do not stop planning to fix the rules, just log the friction.

## 6. Execution
1. Read the provided `01-idea.md` document.
2. Ask the user architectural alignment questions ONLY if the Research Loop revealed ambiguities. If the pattern is clear, skip questioning.
3. Use the provided [Plan Template](../lifecycle/templates/02-plan.md) to generate the implementation plan.
4. Save the resulting plan as `02-plan.md`.

## 7. Agent Self-Review & Human Handoff
Ensure the generated plan explicitly instructs the agent to read the relevant `.agents/guidelines/` documents to self-verify its work during the Build phase.

Once the plan is written, **STOP**. You must present the plan to the user for explicit approval. 
- Once the user approves, you must check the `[ ] Plan Approved` box at the top of `02-plan.md`. 
- Do not proceed or offer to start building until this box is checked.
