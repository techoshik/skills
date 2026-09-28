# Lifecycle Framework

## Governing Principle

> **Build the minimum necessary thing that creates meaningful value — correctly, visibly, and in conformance with the project.**

## Lifecycle

1. **Idea** — What do we want and why?
2. **Prototype** — What uncertainty needs something concrete?
3. **Plan** — How exactly should we build and prove it here?
4. **Build** — Can we implement this Build Step correctly and in conformance?
5. **Finalize** — Does the complete result fulfil the promise, and what durable truth should remain?

## Approval Gate

Always stop at:

- the end of every phase;
- the end of every Build Step.

Then:

- present the result;
- wait for explicit user approval;
- continue only after approval.

Silence is not approval.

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
- Technical solution / proof / build sequence → Plan.
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
- proof needed to trust the work;
- information needed to resume or continue.

Follow `artifacts.md` for writing conventions.
