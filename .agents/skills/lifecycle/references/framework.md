# Lifecycle contract

Build the minimum complete change that creates meaningful value and conforms to the project.

## Authority

- User instructions and explicit overrides govern scope and authorization.
- This file owns phase boundaries, approval, and decision ownership.
- Phase references own execution; approved artifacts own active decisions.
- Project guidelines own engineering standards; module docs own current product truth.
- Support/user docs own user-facing instructions. Inspect source conflicts before asking for a consequential decision.

## Approval gate

Stop after every phase and completed Build Step. Present the reviewable result using [Approval Presentation](artifacts.md#approval-presentation), then wait for explicit approval. Silence is not approval.

### Build gate

- Plan approval authorizes Step 1; completed Step N approval authorizes Step N+1.
- Finish implementation, verification, review, and recording for the current step before requesting approval.
- Start the authorized step directly; no additional pre-step approval is needed.
- Keep future steps untouched while awaiting approval.
- After all steps are approved, present Build completion and obtain approval before Finalize.
- Requested corrections stay in the current phase/step until presented again.

## Approval state

`00-lifecycle.md` records Last Approved, Approval Evidence (message reference or dated quotation), and Next Authorized Action. Set the next action to `None` while awaiting approval.

On resume, verify recorded approval against current artifacts. Changed decisions make affected approval stale; regain approval before affected work continues. Inspect history before asking about missing approval.

## Return to the owner

| Invalidated decision | Owner |
| --- | --- |
| Problem, goal, proposed product changes, expected outcomes, Idea scope decision | Idea |
| Behavior or experience discovered through prototyping | Prototype |
| Technical specification, sequence, actions, verification plan | Plan |
| Implementation or conformance | Build |

Update the owning artifact and regain affected approval. Record a fact once and link its owner. Consequential product, architecture, scope, or verification choices require a decision before implementation; inspected local choices and mechanical consequences use agent judgment.

## Phase boundaries

- **Idea:** Need, concrete product changes, and verifiable expected outcomes; implementation design belongs later.
- **Prototype:** Resolve uncertainty with the cheapest concrete representation, or record `Not needed` with a reason.
- **Plan:** Inspect the existing system and define small, immediately testable steps.
- **Build:** Implement and verify one approved step.
- **Finalize:** Reconcile the entire development change and prepare closure.

Small changes may resolve phases quickly. Create only work that serves the phase responsibility.

## Development boundary

Lifecycle ends after Finalize approval. Include available development verification and authorized development-time staging checks. Deployment, release, merge/post-merge checks, and external handoff reviews are outside this lifecycle. Lifecycle approval grants no production access or deployment permission.

## Phase handoff

Before leaving a phase or presenting a Build Step:

1. Capture settled decisions/results in its artifact; remove superseded points.
2. Sweep for reusable friction using [Cycle Log](cycle-log.md).
3. Update the index and approval state.
4. Apply [artifact writing](artifacts.md) and present the result.

Keep durable state in files so a later chat can resume without rereading the conversation.
