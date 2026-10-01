# Coverage and completion

## Minimum complete solution

During Plan, inspect credible failures in access/revocation, data validity/partial writes, privacy, dependency failure/recovery, concurrency/retries, compatibility/migrations, and resource bounds/performance. Investigate applicable risks only. Put necessary safeguards in their owning step Specification and checks; tie each to a concrete failure path. Avoid speculative future infrastructure.

## Requirement coverage

Before Plan presentation, map every approved success criterion/Idea/Prototype requirement and applicable safeguard to an owning step and Verify check. Use stable labels/links and a compact Covers line. Related requirements may share proof when it establishes each. Record approved exclusions/deferments and keep unresolved coverage visible. Confirm every capability meets [Small-Step Boundary](plan.md#small-step-boundary) and has immediate Test Now instructions.

## Impact preflight

Before each Build edit, read applicable rules and inspect changed interfaces/callers, constructors/mocks/tests, data compatibility, permissions/failures, integrations/dependencies, required generated outputs/migrations, and potentially invalidated evidence. Inspect applicable areas only; record consequential findings with the owning step, not routine inspection logs.

## Proof limits

Match evidence to the actual claim and current implementation. Distinguish static, unit, mocked, real integration, and human proof. Analyzer success does not establish runtime behavior, authorization, migrations, or deployment. Rerun checks when subsequent changes invalidate evidence or leave a relevant regression; otherwise reuse valid proof. Skipped, unrun, blocked, and pending checks stay unchecked.

## Gap acceptance

For each required unavailable check, record Check/reference, Reason, Risk, and Acceptance (`Pending` or explicit user acceptance reference). General phase/step approval and silence do not accept gaps. Accepted gaps remain unchecked. Complete only after required checks pass or their missing proof is explicitly accepted. Known implementation defects require correction or an approved upstream scope change; they are not proof gaps.

## Branch reconciliation

During Finalize, establish the comparison base explicitly. Inspect all base-to-HEAD changed paths and commits, staged/unstaged changes, and relevant untracked files. Group generated/format-only churn without hiding behavior. Map every relevant change to approved intent and checks; separate/preserve unrelated pre-existing work. Record explicit exclusions and reasons. Route consequential unplanned changes to their owner instead of treating the diff as approval.

Before closure, every approved requirement and relevant change needs proof, explicit gap acceptance, or an approved scope exclusion.

## Safe cleanup

Confirm temporary work belongs to this cycle. Transfer useful decisions and retain evidence with resolving references before removing owned prototype/debug/experiment/obsolete leftovers. Preserve unrelated/user work. Archive or remove the completed lifecycle workspace only after explicit user confirmation; keep approval/evidence records accessible until then.

## Deterministic checks

Use existing project checkers for applicable rules. When repeated omissions justify a new checker, follow [Rule Promotion](guidelines.md#rule-promotion); prove it catches the observed failure. Checkers supplement coverage and human approval.
