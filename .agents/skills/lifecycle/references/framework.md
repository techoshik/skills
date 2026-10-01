# Lifecycle Framework

## Governing Principle

> **Build the minimum necessary thing that creates meaningful value — correctly, visibly, and in conformance with the project.**

## Lifecycle

1. **Idea** — What do we want and why?
2. **Prototype** — What uncertainty needs something concrete?
3. **Plan** — What are the reviewable steps, and for each step what must be true, what will we build, and how will we verify it?
4. **Build** — Can we implement and verify this Build Step correctly and in conformance?
5. **Finalize** — Does the actual branch match the approved lifecycle, and is development complete?

## Approval Gate

Always stop at:

- the end of every phase;
- the end of every **completed** Build Step.

Then:

- present the result;
- wait for explicit user approval;
- continue only after approval.

Silence is not approval.

### Build Gate

Plan approval authorizes Build Step 1.

Do not ask for a second approval before starting it.

Approval of completed Step N authorizes Step N+1.

Do not ask for a separate pre-step approval.

Stop during execution only when a consequential choice, conflict, or upstream change requires approval.

If changes are requested:

- stay in the current phase or Build Step;
- update the work;
- present it again.

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

Follow `artifacts.md` for writing conventions.

## Development Boundary

The lifecycle ends when development is finalized and approved.

Deployment, release, merge/post-merge checks, and external review outside development control are not lifecycle artifact responsibilities.
