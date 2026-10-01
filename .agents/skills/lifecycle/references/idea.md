# Phase 1 — Idea

## Responsibility

Understand what deserves attention, what should become true, and how success will be recognized.

## Principle

> **The conversation explores. The Idea document remembers.**

Ask as much as necessary.

Document as little as necessary.

For a reported defect, use [Diagnosis](diagnosis.md) to establish its exact symptom and reproduction needs.

## Scope Discovery

Complete [Inspect Before Asking](questioning.md#inspect-before-asking).

Apply the [Why Loop](questioning.md#why-loop).

Use [Decision Dependencies](questioning.md#decision-dependencies) to order questions.

Apply [Language and Scenario Checks](questioning.md#language-and-scenario-checks).

Use [Persistent Questioning](questioning.md#persistent-questioning) for consequential gaps.

Capture the resulting need, minimum scope, and reasons for scope decisions.

Keep the questioning transcript out of the artifact.

Identify safety and correctness needs without designing their implementation here.

## Working Method

> **Discuss → Confirm → Write → Continue**

- Start from any raw:
  - feature;
  - request;
  - issue;
  - bug;
  - improvement;
  - opportunity.
- Question broadly before narrowing.
- Surface:
  - hidden scenarios;
  - contradictions;
  - assumptions;
  - missing thinking.
- Capture a point when it is sufficiently discussed and confirmed.
- Replace outdated points when decisions change.
- On resume:
  - read `01-idea.md`;
  - continue from unresolved questions.
- Do not design:
  - architecture;
  - storage;
  - APIs;
  - file structure;
  - code.

## Artifact

Use:

```md
# Idea

## Problem / Opportunity
- ...

## Goal
- ...

## Key Results
- ...

## Decisions
- **<Scope decision>:** <Decision>.
  - **Why:** <Need or safeguard it serves>.

## Open Questions
- ...
```

Key Results should be observable or measurable when practical.

Do not force fake precision.

## Complete When

- Problem / Opportunity is understood.
- Goal is clear.
- Minimum scope has a reason tied to the goal or an applicable safeguard.
- Consequential assumptions have a validation or acceptance decision.
- Key Results make success recognizable.
- No meaningful unanswered branch can materially change them.

Present Idea.

Wait for explicit user approval before Prototype.
