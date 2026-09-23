# Cycle Log — Temporary Improvement Memory

- Keep one Cycle Log per active development cycle/branch.
- It is temporary memory for **development-system improvement opportunities**.
- It is not product documentation.

## What Belongs Here

- lifecycle/process friction;
- Engineering Guideline gaps;
- tooling/automation opportunities;
- code-quality/structural improvements;
- recurring ambiguity/rework/manual correction;
- agent drift;
- missing or hard-to-find guidance;
- hidden dependencies or poor slicing;
- repeated duplication/reuse opportunities;
- missing deterministic checks.

Do not store:

- product requirements;
- feature decisions;
- domain truth;
- project status;
- future product work.

Future module work belongs in the module document during Refine.

## Resolve Now vs Later

- If it blocks correctness, safety, or the current phase gate:
  - fix it now;
  - optionally log the lesson so Refine can prevent recurrence.
- Otherwise:
  - log it;
  - continue current work.

## Entry Format

Use one concise line:

`[Phase] Difficulty — Impact`

Add one evidence line only when necessary.

Examples:

- `[Build] Repository files placed incorrectly — developer manually corrected four files.`
- `[Context] Permission rule was hard to locate — agent made an incorrect assumption.`
- `[Plan] Backend dependency appeared during Build — slice required replanning.`

## Phase Sweep

Before leaving Define, Context, Shape, Plan, or Verify, and before closing each Build slice, ask:

> **Did this work create avoidable friction, rework, ambiguity, manual correction, agent drift, or a repeated mistake worth preventing?**

If yes, log one concise entry. Otherwise add nothing.

## Refine

- Refine processes the complete Cycle Log.
- Each meaningful lesson is:
  - applied to the codebase;
  - transferred to module docs;
  - transferred to engineering/lifecycle guidance;
  - deferred intentionally;
  - or dismissed intentionally.
- After transfer, the Cycle Log is no longer the source of truth.
- When nothing valuable remains trapped in it, the workspace is safe to clean up.

> **Capture during the cycle. Improve the system during Refine.**
