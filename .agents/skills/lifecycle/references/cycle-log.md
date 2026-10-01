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

Also log reusable friction that may affect future work again:

- required test environment unavailable;
- emulator/device setup blocks verification;
- project-wide checks blocked by existing errors;
- unclear or missing convention;
- repeated agent misunderstanding;
- tooling/setup makes a normal lifecycle step difficult;
- recurring manual verification work.

The friction does not need to be caused by the current feature.

A Cycle Log entry does not mean it must be fixed now.

It means Finalize → Improve should review it.

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

## Feedback Loop

For avoidable mistakes or repeated friction:

- Link the observed finding or correction as evidence.
- Identify the contributing gap when the evidence supports it.
- Keep unconfirmed causes labeled as hypotheses.
- Recommend the smallest durable improvement.
- Record how its effectiveness can be checked.

Possible destinations:

- **Requirement gap:** Owning Specification or acceptance criteria.
- **Validation gap:** Test or deterministic check.
- **Language gap:** Existing domain documentation.
- **Instruction gap:** Authoritative project guideline.
- **Architecture friction:** Focused proposal under [Architecture Improvements](finalize.md#architecture-improvements).

After an approved improvement:

- Check that it catches or prevents the observed failure.
- Confirm it preserves required behavior.
- If effectiveness needs future runs, record it as unverified.

Log only actionable, reusable learning.

Do not expand scope merely to close a log entry.

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
