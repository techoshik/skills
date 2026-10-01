# Phase 2 — Prototype

## Responsibility

Make unresolved parts concrete enough to discover what discussion alone cannot.

## Principle

> **Choose the cheapest concrete representation that can answer the uncertainty.**

Prototype for learning.

Not production.

## Process

> **Question → Choose → Create → Experience → Question → Refine → Capture**

1. State the uncertainty.
2. Choose the cheapest useful representation.
3. Build only enough to answer it.
4. Exercise realistic scenarios.
5. Test important edge cases.
6. Discuss what the artifact revealed.
7. Refine while meaningful uncertainty remains.
8. Capture Prototype-owned conclusions continuously.

## Prototype Options

- **UI / Interaction**
  - visual/clickable prototype;
  - structurally different variants when comparison helps.
- **Flow**
  - Mermaid flowchart.
- **State / Business Rules**
  - Mermaid state diagram;
  - executable logic prototype.
- **System Interaction**
  - Mermaid sequence diagram.
- **API / Integration**
  - smallest useful contract/mock/sandbox/experiment.
- **Technical Uncertainty**
  - focused spike or measurement.

If no prototype adds value:

- record `Not needed — <reason>`;
- present it;
- wait for approval before Plan.

## Decision Ownership

Prototype Decisions contain only conclusions discovered or confirmed through prototyping.

Do not repeat decisions already owned by Idea.

When Idea context is needed:

- reference Idea;
- do not copy the same decision.

If Prototype changes an Idea-owned point:

- return to Idea;
- update the owning point;
- regain approval before continuing.

This includes:

- Problem / Opportunity;
- Goal;
- Key Results;
- Idea-owned Decisions.

## Rules

- State the question before building.
- Prefer real product context when useful.
- Use fake/in-memory data when integration is irrelevant.
- Expose relevant state/behaviour.
- Do not polish what cannot answer the question.
- Stop when the question is answered.

## Artifact

Use:

```md
# Prototype

## Questions
- ...

## Decisions
- ...

## Artifacts
- ...

## Open Questions
- ...
```

Follow the global artifact rule:

- omit empty headings;
- remove resolved Open Questions.

Keep prototype assets under `prototype/` when useful.

Point to in-app prototype locations when that context is better.

## Complete When

Every important uncertainty needing something concrete is resolved enough for Plan.

Present Prototype.

Wait for explicit user approval before Plan.
