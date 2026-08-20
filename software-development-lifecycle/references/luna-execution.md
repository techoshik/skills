# Luna Item Execution

## Item Fields

- **Outcome:** exact result produced.
- **Read:** required files and documents.
- **Change:** allowed implementation surfaces.
- **Preserve:** behavior that must not change.
- **Guidelines:** applicable files and rules.
- **Dependencies:** items that must already be `Verified`.
- **Actions:** ordered implementation actions.
- **Requirements:** requirement identifiers satisfied.
- **Tests:** exact focused checks.
- **Flow:** user or system journey to exercise.
- **Goal:** contribution to the Goal.
- **Expected:** evidence required for `Verified`.

## Status

- **Not started:** implementation has not begun.
- **In progress:** implementation or verification is active.
- **Blocked:** a named blocker prevents progress.
- **Verified:** implementation and required checks are complete.

## Before

- Read the Goal, Scope, and Requirements.
- Read only the active Step and its Implementation item.
- Read every listed file and guideline.
- Confirm every dependency is `Verified`.
- Complete the repository Guidelines Check.
- Change the item status to `In progress`.
- Stop when required information is missing or conflicting.
- Do not invent material behavior, architecture, or conventions.

## During

- Follow Actions in order.
- Work only within the active item.
- Reuse suitable repository patterns.
- Preserve unrelated changes.
- Implement the smallest complete outcome.
- Add or update tests with behavior.
- Do not start another Step.
- Do not perform unrelated cleanup.
- Record minor discoveries under Notes.
- Ask before material scope, behavior, data, or architecture changes.

## Before Verified

- Confirm every Action is complete.
- Confirm every linked Requirement is satisfied.
- Run every listed test.
- Exercise the listed Flow.
- Confirm preserved behavior remains unchanged.
- Compare the result with the Goal.
- Record actual evidence under Verification.
- Keep the item `In progress` when a required check fails.

## Plan Changes

- Record a minor implementation detail under Notes.
- Add a Step and matching item for new work.
- Discuss material scope or behavior changes before continuing.
