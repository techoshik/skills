# Define

## Purpose

- Decide whether the work is worth doing.
- Define the problem, minimum valuable outcome, boundaries, rules, and success.
- Do not design the solution.

## Inputs

- User request, bug, idea, or change.
- Relevant product/module knowledge when already available.
- Existing future-work note when the work originated from a module document.

## Rules

- Work only on Define concerns.
- Do not design detailed UI, data models, APIs, architecture, storage, or code.
- Use the full questioning process when the change is non-trivial.
- Resolve only what Define owns.
- Carry later-phase uncertainty without guessing.
- A Define blocker must be resolved before passing.

## Questions

### Problem
- Who has the problem?
- What is happening now?
- What is wrong or missing?
- What evidence supports the need?
- Why now?

### Outcome
- What valuable change must exist?
- What is the minimum valuable outcome?
- What capabilities are necessary?
- What can be removed without losing value?

### Boundaries
- What is in scope?
- What is explicitly out?
- What constraints or dependencies already matter?

### Rules
- What must always be true regardless of implementation?

### Success
- What observable criteria prove the outcome?
- What critical journey must eventually work?
- What is the risk if that journey cannot be proven?

## Actions

- Use `grill-with-docs` for non-trivial requirement discovery.
- Use `wayfinder` only when the decision tree is large or foggy.
- Find facts through repository/docs/tools instead of asking the user for discoverable information.
- If a worthwhile idea is deferred, record it in the affected module document during Refine, not as permanent lifecycle scope.

## Output — `01-define.md`

Use only these groups when they add information:

### Decision
- Result: Proceed / Defer / Reject.
- Status: Pass / Blocked.
- Blockers.
- Next.

### Problem
- User.
- Problem.
- Current.
- Evidence.
- Why now.

### Outcome
- Value.
- Minimum.
- Capabilities.
- Delete test.

### Boundaries
- In.
- Out.
- Constraints.
- Dependencies.

### Rules
- Only durable behaviour/invariants relevant to the outcome.

### Success
- Criteria.
- Critical journey.
- Proof risk.

### Open
- Assumptions.
- Questions.
- Research.
- Blockers.
- Add `Resolve: <phase>` when useful.

## Phase Gate

Pass when:

- the problem and value are clear enough to justify the work;
- the minimum outcome is bounded;
- success can be observed;
- no Define-owned blocker remains;
- later-phase uncertainty is classified rather than guessed.

Do not add a second Exit section to the artifact.
