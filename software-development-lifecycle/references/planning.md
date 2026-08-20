# Planning

## Brainstorm

- Identify affected users or systems.
- Describe what happens now.
- Explain why the problem matters.
- Identify evidence, assumptions, and unknowns.
- Separate the problem from the proposed solution.
- Explore useful alternatives.
- Recommend the simplest suitable direction.
- Ask one small group of related questions at a time.
- Do not finalize while material questions remain.

## Plan Process

- Create the plan inside the conversation.
- Use short bullets and numbered Steps.
- Mark uncertain points as assumptions or questions.
- Review and revise the plan with the user.
- Save it only after user approval.
- Store it under `docs/plans/`.
- Keep it updated during implementation.
- Use compact one-line entries for small, low-risk fixes.

## Plan Format

Use only these eight sections:

### Problem

- Who is affected.
- What happens now.
- Why it matters.
- What evidence is available.

### Goal

- Desired user outcome.
- Required system outcome.
- Success signals.
- Failure signals when useful.
- Production observation measures.
- Observation period or decision point.

### Steps

- Write one short line for each implementation outcome.
- Number every line.
- Order lines by dependency and delivery sequence.
- Keep wording clear and outcome-based.
- Do not put detailed implementation here.
- Include work needed to observe the Goal after release.
- Finalize Steps only after Scope, Requirements, and Migrations are understood.

### Scope

- Included work.
- Excluded work.
- Constraints.
- Deferred work when relevant.

### Requirements

- Required behavior.
- Business rules.
- Permissions and safety rules.
- Important states and edge cases.
- Quality expectations.
- Testable acceptance criteria.
- Production monitoring, privacy, and access constraints.

### Migrations

- State `None` when no migration is needed.
- List affected data, schema, API, contract, configuration, permissions, or
  storage.
- Classify each migration as before, during, or after release.
- Link the required migration document.
- State compatibility and rollback requirements.
- Add every migration action to Steps and Implementation.

### Implementation

- Create one item for every numbered Step.
- Use the same number and name.
- Include all work needed to complete and verify the Step.
- Add a new Step before adding new implementation work.

Use this item structure:

```text
### 1. Item name

- Status:
- Details:
  - Outcome:
  - Read:
  - Change:
  - Preserve:
  - Guidelines:
  - Dependencies:
  - Actions:
    1.
    2.
    3.
- Verification:
  - Requirements:
  - Tests:
  - Flow:
  - Goal:
  - Expected:
- Notes:
```

### Observe

- Outcome signals.
- Current baseline when available.
- Production apps, data, logs, metrics, or feedback needed.
- Privacy, security, retention, and access boundaries.
- Observation owner.
- Observation period or decision point.
- Results that trigger keep, improve, rollback, or retirement discussion.

## Clarity Gate

- Define unfamiliar domain terms.
- Explain non-obvious decisions.
- State dependencies and ordering.
- State expected outcomes and verification.
- Make important constraints explicit.
- Avoid undocumented project knowledge.
- Remove detail that does not change implementation decisions.
- Review the plan from a new developer's perspective.
- Make every item independently executable by Luna.
- Do not approve the plan while material choices require guessing.
