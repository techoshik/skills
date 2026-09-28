# Cycle Log — Temporary Process-Improvement Memory

Keep one `cycle-log.md` inside each active lifecycle workspace.

It captures development-system lessons that may deserve permanent improvement during Finalize.

## Log

- lifecycle/process friction;
- project guideline gaps;
- repeated agent drift;
- naming/placement/structure ambiguity;
- repeated rework/manual correction;
- missing deterministic checks;
- tooling/automation opportunities;
- poor Build Step boundaries;
- recurring code-quality/architecture friction.

Do not log:

- product requirements;
- feature decisions;
- current module behaviour;
- project status;
- future product ideas.

Those belong to their owning artifacts/permanent sources.

## Format

Prefer one concise entry:

`[Phase] Difficulty — Impact`

Add evidence only when it helps Finalize make a real improvement decision.

## Sweep

Before leaving each phase and before completing each Build Step, ask:

> **Did this work create avoidable friction, ambiguity, rework, manual correction, or agent drift worth preventing next time?**

If yes, log it. Otherwise add nothing.

## Finalize

Finalize reviews the entire Cycle Log during **Improve**, before **Clean**.

Each meaningful entry is:

- promoted to a project guideline/checker;
- promoted to a lifecycle skill;
- used for an approved code/process improvement;
- intentionally deferred;
- or intentionally dismissed.

After permanent transfer, the Cycle Log is no longer the source of truth.
