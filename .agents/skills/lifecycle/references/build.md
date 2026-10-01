# Build

Implement, verify, review, and record only the current authorized step.

## Required reading

Read [Project Rules](guidelines.md), [Coverage and Completion](completeness.md), and [Code Review](code-review.md). Load index approval state, the approved current Plan step, relevant upstream decisions, affected module docs, applicable rules, and nearby implementations.

## Preflight

Before edits, apply Impact Preflight in completeness.md. Establish the step's Specification, actions, checks, Test Now path, governing rules, existing implementation pattern, and affected files/callers. Resolve consequential missing/conflicting conventions, architecture choices, extra requirements, or plan conflicts through their owner before coding. Mechanical imports, wiring, and required call-site updates need no separate decision.

## TDD — hard rule for testable behaviour

Work one behavior through RED → GREEN → REFACTOR before starting the next:

1. Write and run the smallest useful failing test; confirm it fails for the intended reason.
2. Implement the minimum behavior; run and confirm GREEN.
3. Refactor within approved responsibility while keeping tests green.

Test through the relevant supported interface with independent expected outcomes and a plausible regression to catch. Follow project fixtures/mocks/placement/naming. Prefer real behavior at the tested interface; use approved substitutes at isolation boundaries. Mocked integration cannot prove the real service/permission boundary. Avoid implementation-mirroring tests, decorative-only tests, and wrappers/injection added solely for generic preferences.

## Deliver and verify

- Complete current Specification/actions with established patterns; preserve unrelated work and future steps.
- Run every available planned check and the Test Now path; record actual results under Evidence and Proof Limits.
- Keep human checks pending until observed or explicitly accepted as gaps. Give exact interaction instructions when human action is needed.
- If later work is needed to run this capability, return to Plan; honor only explicitly approved preview/prerequisite exceptions.
- If verification changes materially, follow [Verification Changes](plan.md#verification-changes-during-build).
- For unresolved defects/performance failures, read [Diagnosis](diagnosis.md).
- Complete Code Review, fix in-scope defects, and rerun affected checks. Confirm compilation/runnability when practical.

## Record and present

Update `04-build.md` with actual Result, Verification/evidence, separate Standards and Specification review outcomes, and relevant approved deviations/gaps. Link Plan/Test Now rather than copying planned work. Apply Gap Acceptance before claiming the step complete; implementation defects remain work to fix.

Finish the [phase handoff](framework.md#phase-handoff) for the current step and follow the Build gate. If implementation reveals several independent responsibilities, return to Plan and split remaining work.

## Complete when

Every step is implemented, conforming, verified (or has explicitly accepted proof gaps), and approved; testable behavior used TDD; no consequential unapproved choice remains. Present Build completion and obtain approval before Finalize.

## Delegated work

When delegation is authorized:

- Provide the current approved step, workspace, editing scope, project rules, and existing work to preserve.
- Keep one writer for overlapping files; workers return consequential choices instead of approving or starting future work.
- For a separate review, supply the finished diff, approved requirements, and standards with read-only scope.
- Inspect returned changes and evidence; resolve in-scope findings and rerun affected checks before recording completion.

Delegation is not a prerequisite for executing a phase or step.
