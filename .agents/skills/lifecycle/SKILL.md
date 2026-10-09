---
name: lifecycle
description: Orchestrate the project's Define → Outline → Execute → Refine (DOER) development lifecycle.
disable-model-invocation: true
---

# Lifecycle Orchestrator

The `lifecycle` skill is the master router for feature development. It ensures that features are strictly defined, outlined, executed, and refined in the correct order based on the **DOER** framework.

## Required Entry
Before executing ANY phase, you must understand the current state of the feature. Check the project's temporary `lifecycle` tracking directory.

## Route
Determine the current state below. To enter a phase, read its corresponding `SKILL.md` file and execute its instructions exactly.

| State | Action (Read Next) |
| --- | --- |
| No `01-define.md` exists | [Define skill](../lifecycle-define/SKILL.md) |
| `01-define.md` exists but lacks `[x] Define Approved` | [Define skill](../lifecycle-define/SKILL.md) (Ask for approval) |
| Define approved; no `02-outline.md` exists | [Outline skill](../lifecycle-outline/SKILL.md) |
| `02-outline.md` exists but lacks `[x] Outline Approved` | [Outline skill](../lifecycle-outline/SKILL.md) (Ask for approval) |
| Outline approved; feature not yet fully built | [Execute skill](../lifecycle-execute/SKILL.md) |
| Execution complete; feature needs verification/commit/cleanup | [Refine skill](../lifecycle-refine/SKILL.md) |

## Approval Invalidation
If the user modifies an already-approved document (e.g., changes outcomes in `01-define.md` or alters the architecture in `02-outline.md`), you must un-check all dependent approval boxes. All affected work must be reconsidered and explicitly re-approved.

## Workspace & Artifacts
The temporary `lifecycle` tracking directory is used strictly for organizing the current feature being built. 
- You do not need to create bloated index files.
- The existence of an approved phase artifact (e.g., `01-define.md`) is sufficient proof that the phase is complete.
- Follow the hard stop-and-wait approval gates at the end of every phase before advancing to the next.

## Universal Rule: Continuous Improvement (Friction Logging)
If you struggle with missing rules, ambiguous guidelines, or unexpected technical roadblocks during **ANY phase** (Define, Outline, or Execute), you MUST document them by creating or appending to a `friction_log.md` file in the temporary `lifecycle` directory. Do not stop your work to fix the rules, just log the friction and keep going. The Refine phase will resolve it.
