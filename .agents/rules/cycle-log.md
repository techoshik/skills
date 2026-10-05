# Cycle Log

## Sweep

Before each phase handoff and completed Build Step, ask whether avoidable friction, ambiguity, rework, manual correction, or agent drift could recur. If so, log it in `cycle-log.md`; otherwise add nothing.

Include reusable guideline, naming, placement, test-environment, tooling, verification, step-boundary, or architecture friction, even when pre-existing. Logging does not authorize fixing it now.

Use `[Phase] Difficulty — Impact`. Add evidence and prevention only when useful. Keep product requirements, feature decisions, current behavior, status, and future product ideas with their own sources.

## Feedback loop

For actionable learning, record observed evidence, contributing gap (or labeled hypothesis), smallest durable improvement, and how to check effectiveness.

| Gap | Possible owner |
| --- | --- |
| Requirement | Owning Specification/acceptance criteria |
| Validation | Test or deterministic checker |
| Language | Existing domain documentation |
| Instruction | Authoritative project guideline or portable lifecycle skill |
| Architecture | Evidence-backed proposal in Finalize |

During Finalize, review every meaningful entry: promote through approved work, defer, or dismiss with a reason. After promotion, check that it prevents the observed failure while preserving behavior. Label effectiveness requiring future runs as unverified. Permanent transfer ends the log's authority; avoid expanding scope to empty it.
