---
name: lifecycle-prototype
description: "Use after Idea when something must be made concrete to resolve behaviour, UI, flow, state, integration, or technical uncertainty before planning."
---

# Prototype

## Phase Question

> **What uncertainty cannot be settled well enough by discussion alone?**

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/artifacts.md`
- `../lifecycle/references/prototype.md`
- `../lifecycle/references/questioning.md`
- `../lifecycle/references/cycle-log.md`

Before presenting a document, complete the [required compactness pass](../lifecycle/references/artifacts.md#required-compactness-pass).

Load approved `01-idea.md`.

For each important uncertainty:

1. State the question.
2. Choose the cheapest concrete representation.
3. Create only enough to learn.
4. Exercise realistic scenarios/edge cases.
5. Question what it reveals.
6. Refine until resolved.
7. Capture the Prototype-owned conclusion immediately.

Prototype Decisions contain only conclusions discovered or confirmed because of prototyping.

- Do not repeat Idea-owned decisions.
- Reference Idea when context is needed.
- If Prototype changes an Idea-owned decision:
  - return to Idea;
  - update the owning point;
  - regain approval.

Allowed forms include:

- UI variants;
- Mermaid flow/state/sequence diagrams;
- executable logic demos;
- API/integration experiments;
- focused technical spikes.

If no prototype adds value:

- record `Not needed — <reason>`;
- present it;
- wait for explicit approval before Plan.

Run the Cycle Log sweep.

Update `00-lifecycle.md`.

Present the Prototype.

Apply the [approval gate](../lifecycle/references/framework.md#approval-gate).
