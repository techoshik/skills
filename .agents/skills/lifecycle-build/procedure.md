# Build

Implement, verify, review, and record only the current authorized step.

## Required reading

Read [Project Rules](../../rules/guidelines.md), [Coverage and Completion](../../rules/completeness.md), and [Code Review](../../rules/code-review.md). Load index approval state, the approved current Plan step, relevant upstream decisions, affected module docs, applicable rules, and nearby implementations.

## Preflight

Before edits, apply Impact Preflight in completeness.md. Establish the step's Specification, actions, checks, Test Now path, governing rules, existing implementation pattern, and affected files/callers. Resolve consequential missing/conflicting conventions, architecture choices, extra requirements, or plan conflicts through their owner before coding. Mechanical imports, wiring, and required call-site updates need no separate decision.

## Implement, then test the step

Default sequence: **Implement → Focused tests → Verify → Review → Record → Approval**.

- **Implement first**
  - Complete the current approved capability directly from its Specification and project rules.
  - Keep refactoring within this responsibility; a mandatory failing-test cycle is not required.
- **Focused tests before step approval**
  - Reuse or extend existing tests before adding new ones.
  - Cover changed business rules, permission boundaries, data mutations/invariants, and meaningful failure or recovery paths.
  - Choose cases that catch plausible regressions and observe independent expected outcomes through a supported interface.
  - Skip new tests for trivial wiring, decorative-only details, and assertions that merely mirror the implementation.
  - Record why existing tests or another proof method suffice when no new tests are warranted.
- **Test boundaries**
  - Follow project fixture, mock, placement, and naming rules.
  - Prefer real behavior at the tested interface; use approved substitutes where isolation is needed.
  - Mocked tests do not establish real service or permission behavior.
  - Add wrappers/injection only for an actual need or governing project rule.
- **Bug fixes**
  - Reproduce the failure before editing when practical, using an existing test, request, or observation.
  - Add or extend meaningful regression coverage by the end of the step; reproduction need not start with a newly written failing test.
- **Timing**
  - Complete focused tests and planned verification within this step, before requesting its approval.
  - Keep the approved Verify checks; changes follow Plan’s verification-change rule.
  - Finalize checks the combined feature rather than receiving deferred step testing.

Use test-first development when explicitly requested or required by applicable project rules; it is not the shared default.

## Deliver and verify

- Complete current Specification/actions with established patterns; preserve unrelated work and future steps.
- Run every available planned check and the Test Now path; record actual results under Evidence and Proof Limits.
- Keep human checks pending until observed or explicitly accepted as gaps. Give exact interaction instructions when human action is needed.
- If later work is needed to run this capability, return to Plan; honor only explicitly approved preview/prerequisite exceptions.
- If verification changes materially, follow [Verification Changes](../lifecycle-plan/procedure.md#verification-changes-during-build).
- For unresolved defects/performance failures, read [Diagnosis](../../rules/diagnosis.md).
- Complete Code Review, fix in-scope defects, and rerun affected checks. Confirm compilation/runnability when practical.

## Record and present

Update `04-build.md` with actual Result, Verification/evidence, separate Standards and Specification review outcomes, and relevant approved deviations/gaps. Link Plan/Test Now rather than copying planned work. Apply Gap Acceptance before claiming the step complete; implementation defects remain work to fix.

Finish the [phase handoff](../../rules/framework.md#phase-handoff) for the current step and follow the Build gate. If implementation reveals several independent responsibilities, return to Plan and split remaining work.

## Complete when

Every step is implemented, conforming, verified (or has explicitly accepted proof gaps), and approved. Its meaningful test coverage is complete before approval; no consequential unapproved choice remains. Present Build completion and obtain approval before Finalize.

## Delegated work

When delegation is authorized:

- Provide the current approved step, workspace, editing scope, project rules, and existing work to preserve.
- Keep one writer for overlapping files; workers return consequential choices instead of approving or starting future work.
- For a separate review, supply the finished diff, approved requirements, and standards with read-only scope.
- Inspect returned changes and evidence; resolve in-scope findings and rerun affected checks before recording completion.

Delegation is not a prerequisite for executing a phase or step.
