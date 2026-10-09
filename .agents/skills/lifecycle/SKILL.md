---
name: lifecycle
description: Orchestrate the project's Idea → Plan → Build → Finalize development lifecycle.
disable-model-invocation: true
---

# Lifecycle Orchestrator

The `lifecycle` skill is the master router for feature development. It ensures that features are strictly designed, planned, built, and finalized in the correct order.

## Required Entry
Before executing ANY phase, you must understand the current state of the feature. Check the project's temporary `lifecycle` tracking directory.

## Route
Determine the current state below. To enter a phase, read its corresponding `SKILL.md` file and execute its instructions exactly.

| State | Action (Read Next) |
| --- | --- |
| No `01-idea.md` exists | [Idea skill](../lifecycle-idea/SKILL.md) |
| Idea approved; no `02-plan.md` exists | [Plan skill](../lifecycle-plan/SKILL.md) |
| Plan approved; feature not yet fully built | [Build skill](../lifecycle-build/SKILL.md) |
| Build approved; feature needs commit/cleanup | [Finalize skill](../lifecycle-finalize/SKILL.md) |

## Workspace & Artifacts
The temporary `lifecycle` tracking directory is used strictly for organizing the current feature being built. 
- You do not need to create bloated index files.
- The existence of an approved phase artifact (e.g., `01-idea.md`) is sufficient proof that the phase is complete.
- Follow the hard stop-and-wait approval gates at the end of every phase before advancing to the next.

## Universal Rule: Continuous Improvement (Friction Logging)
If you struggle with missing rules, ambiguous guidelines, or unexpected technical roadblocks during **ANY phase** (Idea, Plan, or Build), you MUST document them by creating or appending to a `friction_log.md` file in the temporary `lifecycle` directory. Do not stop your work to fix the rules, just log the friction and keep going. The Finalize phase will resolve it.
