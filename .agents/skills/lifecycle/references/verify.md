# Verify

## Purpose

> **Build proves the slices. Verify proves the promise.**

- Verify the final integrated change against Define.
- Protect affected existing behaviour.
- Do not replay Build as a slice-by-slice transcript.

## Inputs

- Define success criteria and critical journey.
- Context regression boundaries and existing-system constraints.
- Shape proof decision.
- Plan journeys.
- Build results.
- Applicable Engineering Guidelines.

## Process

```text
Define promise
+ Context protection boundaries
+ Shape proof strategy
+ Plan journeys
+ Build results
  ↓
Run final integrated journey
  ↓
Check critical rules
  ↓
Check targeted regressions
  ↓
Run final conformance/gates
  ↓
Pass or route failure
```

## Rules

- Verify through the real boundary required by Shape.
- Prefer deterministic evidence.
- Do not record every click/test command.
- Record the smallest evidence that proves or disproves the promise.
- Put evidence beside the claim it supports.
- Build already performed slice conformance; Verify performs the final integrated conformance check.
- If verification exposes an upstream mistake, route it to its owner instead of patching the requirement/solution silently.

## Proof

Confirm:

- approved outcome and success criteria;
- complete critical journey;
- important business/domain rules;
- permissions/data/persistence/integration behaviour required by Shape.

## Protection

Confirm:

- affected existing workflows/regressions;
- final combined code conforms to applicable Engineering Guidelines;
- required tests, formatter, lint/type, architecture, or project gates pass.

## Failure Routing

For each issue, record together:

- failure/blocker;
- owning phase;
- required action;
- what must be reverified.

Examples:

- implementation defect → Build;
- wrong slice/contract → Plan;
- wrong seam/domain behaviour → Shape;
- incorrect current-system assumption → Context;
- missing/incorrect requirement → Define.

## Companion Skills

- `code-review` — independent standards/spec review when useful.
- `diagnosing-bugs` — difficult verification failures.

## Output — `06-verify.md`

### Decision
- Result: Verified / Failed / Blocked.
- Status: Pass / Blocked.
- Blockers.
- Next.

### Proof
Group the new-behaviour proof together:
- Outcome.
- Journey.
- Rules.
- Include evidence only as needed.

### Protection
Group preservation evidence together:
- Regression.
- Conformance.
- Gates.

### Issues
- `None`, or one complete group per failure:
  - issue;
  - result;
  - owner;
  - action;
  - reverify.

## Phase Gate

Pass when:

- Define's approved promise is satisfied;
- the required integrated journey works;
- critical rules hold;
- targeted regression protection passes;
- final conformance/gates pass;
- no unresolved verification blocker remains.

Do not add a second Exit section to the artifact.
