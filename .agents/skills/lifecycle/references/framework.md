# Lifecycle Framework

## Governing Principle

> **Build the minimum necessary thing that creates meaningful value — correctly, visibly, and in conformance with the project.**

## Lifecycle

1. **Idea** — What do we want and why?
2. **Prototype** — What uncertainty needs something concrete?
3. **Plan** — What are the reviewable steps, and for each step what must be true, what will we build, and how will we verify it?
4. **Build** — Can we implement and verify this Build Step correctly and in conformance?
5. **Finalize** — Does the actual branch match the approved lifecycle, and is development complete?

Follow [Model Coordination](models.md) for main-chat selection and delegated execution.

## Authority

- **Process:** Lifecycle framework and phase references.
- **Active decisions:** Approved phase artifacts.
- **Product truth:** `docs/modules/`.
- **Engineering standards:** Project guidelines.
- **User instructions:** Support/user docs.

Resolve source conflicts with the owning phase.

Ask the user when a consequential decision remains.

## Approval Gate

Always stop at:

- the end of every phase;
- the end of every **completed** Build Step.

Then:

- present the result using [Approval Presentation](artifacts.md#approval-presentation);
- wait for explicit user approval;
- continue only after approval.

Silence is not approval.

### Build Gate

Plan approval authorizes Build Step 1.

Do not ask for a second approval before starting it.

Approval of completed Step N authorizes Step N+1.

Implement, verify, review, and record only the current step before presenting it.

Do not batch future steps while waiting for approval.

Do not ask for a separate pre-step approval.

Stop during execution only when a consequential choice, conflict, or upstream change requires approval.

If changes are requested:

- stay in the current phase or Build Step;
- update the work;
- present it again.

## Approval State

Record approval state in `00-lifecycle.md`:

- **Last Approved:** Exact phase or Build Step; `None` initially.
- **Approval Evidence:** User message reference or concise dated quotation.
- **Next Authorized Action:** Action permitted by that approval; `None` while awaiting approval.

On resume, confirm the recorded approval still applies to the current artifacts.

If decisions changed after approval, mark affected approval stale.

Obtain renewed approval before continuing affected work.

When approval cannot be established, inspect available history first.

Ask the user only if it remains unresolved.

## Completion Checks

Apply [coverage and completion checks](completeness.md) at their specified phases.

## Phase Rules

### Phases are responsibilities

- A tiny issue may pass through a phase quickly.
- Prototype may be `Not needed`.
- Never invent work to fill a phase.

### Return to the owner

If later reality invalidates earlier work:

- Problem / Goal / Key Results → Idea.
- Behaviour / experience → Prototype.
- Build Step Specification / Build actions / Verify plan / build sequence → Plan.
- Implementation / conformance → Build.

Update the owning artifact.

Do not hide the change in a later phase.

### One fact, one owner

Reference the owning source.

Do not duplicate durable truth.

## Additions and Minimum Scope

Use the [Why Loop](questioning.md#why-loop) before proposing consequential additions.

Apply [Minimum Complete Solution](completeness.md#minimum-complete-solution) when defining implementation scope.

Keep the existing phase and Build Step approval gates.

## Working Depth vs Artifact Depth

> **Think deeply. Record minimally.**

Investigation may include:

- many questions;
- repository inspection;
- alternatives;
- prototypes;
- experiments;
- tests.

Artifacts keep only:

- finalized decisions;
- meaningful risks;
- consequential open questions;
- verification needed to trust the work;
- information needed to resume or continue.

For document writing and the required pre-presentation pass, follow [artifacts.md](artifacts.md).

## Development Boundary

The lifecycle ends when development is finalized and approved.

- Include verification available while development remains under lifecycle control.
- Development-time staging checks may be included when authorized.
- Deployment, release, merge/post-merge checks, and external handoff reviews remain outside this lifecycle.
- Lifecycle approval does not authorize production access or deployment.
