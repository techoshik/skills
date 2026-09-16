# Cycle Log — Improvement Source of Truth

Keep one Cycle Log per active development cycle or branch, shared by developers and AI agents.

The Cycle Log is the **single temporary source of truth for improvement opportunities during the active cycle**. It exists to provide a mental sweep: capture something worth improving, then stop carrying it in memory and continue the current work.

## What Belongs Here

The Cycle Log is for:

- system and lifecycle improvements;
- Engineering Guideline improvements;
- tooling and automation opportunities;
- code-quality and structural improvements;
- recurring friction, ambiguity, rework, or manual correction;
- agent drift from standards or lifecycle instructions;
- missing, unclear, stale, or hard-to-find guidance/context;
- hidden dependencies, poor slicing, or late discoveries;
- recurring duplication or reuse opportunities;
- missing tests, observability, or deterministic checks.

It is **not** the source of truth for product requirements, feature decisions, bugs, domain knowledge, or project status.

If a product problem exposes a process or guideline weakness, log the **system weakness** here while product information stays in its proper lifecycle artifact.

## Resolve Now vs Log for Later

- If the issue blocks correctness, safety, or the current phase's Exit condition: **fix it now** and optionally log the lesson so Refine can prevent recurrence.
- If the issue does not block the current work but is worth improving: **log it and continue**.
- Do not interrupt the current phase to redesign the process merely because an improvement idea appeared.

## Entry Format

Use one concise line:

`[Phase] Difficulty — Impact`

Add one evidence line only when needed to understand the entry later.

Examples:

- `[Build] Repository created in the wrong folder — developer manually corrected four files.`
- `[Context] Permission rules were difficult to locate — agent made an incorrect assumption.`
- `[Plan] Dependency discovered only during Build — slice had to be replanned.`

## Common Phase Exit Check

Before leaving Define, Context, Shape, Plan, or Verify, and before closing each Build slice, ask:

> **Did this work create unnecessary friction, rework, ambiguity, manual correction, agent drift, or a repeated mistake that we should prevent next time?**

If yes, append one concise entry. If no, continue without creating noise.

## Refine Responsibility

Refine loads the complete Cycle Log and proposes the proper destination for
each meaningful lesson: lifecycle guidance, Context, Engineering Guidelines,
automation, code improvement, or future work. Apply only user-approved
changes.

Once useful learning has been transferred to its permanent source of truth, the Cycle Log must not remain the permanent documentation.

After approved learning has been transferred and the user confirms cleanup,
archive the completed Cycle Log and begin the next development cycle with a
fresh log.

> **Capture during the cycle. Improve the system during Refine.**
