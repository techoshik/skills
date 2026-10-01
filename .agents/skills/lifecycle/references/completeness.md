# Coverage and Completion Checks

## Requirement Coverage

Before presenting Plan:

- Account for every approved Idea success criterion.
- Account for every approved behavior requirement in Idea and Prototype.
- Link each requirement to its owning Build Step.
- Link each step requirement to a Verify check.
- Use source links or stable labels instead of repeating requirements.
- Record explicit scope decisions for deferred or excluded requirements.
- Obtain user approval for any change to approved scope.
- Keep unresolved coverage visible until it is resolved.

Use a compact `Covers` line inside each step.

A check may cover several related requirements when it proves each one.

## Impact Preflight

Before editing a Build Step:

- Read every applicable project rule.
- Inspect changed interfaces and their callers.
- Inspect affected constructors, mocks, and tests.
- Inspect data contracts and compatibility implications.
- Inspect permissions and failure paths affected by the change.
- Inspect integration and dependency boundaries.
- Identify required generated outputs or migrations when applicable.
- Check which existing evidence may become invalid.

Investigate applicable areas only.

Record consequential findings in the owning step.

Keep routine inspection out of the review document.

## Proof Limits

Before marking a check complete:

- Match the evidence to the check's actual claim.
- Confirm the evidence applies to the current implementation.
- Rerun affected checks when later changes invalidate their evidence.
- Keep static, unit, integration, and human proof distinct.
- Keep skipped, blocked, and unrun checks unchecked.

A clean analyzer does not prove runtime behavior or authorization.

Use [Evidence](artifacts.md#evidence) for recording format.

## Gap Acceptance

For each required check that cannot be completed:

- **Check:** Link to the unmet verification requirement.
- **Reason:** Why it remains unverified.
- **Risk:** What the missing proof leaves uncertain.
- **Acceptance:** Pending, or a reference to explicit user acceptance.

Present incomplete work with its gap visible.

Phase or step approval accepts a gap only when the user explicitly accepts that gap.

Silence and general approval are not gap acceptance.

Accepted gaps remain unchecked.

Before marking a Build Step or development Complete:

- Complete each required check, or obtain explicit acceptance of its gap.
- Resolve required implementation work; gap acceptance covers missing proof only.

## Branch Reconciliation

During Finalize:

- Identify the comparison base explicitly.
- Inspect every changed path from that base to HEAD.
- Inspect staged and unstaged changes.
- Inspect relevant untracked files.
- Group generated or formatting changes without hiding behavioral changes.
- Map each relevant change to approved work and verification.
- Identify unrelated pre-existing work separately.
- Preserve unrelated work.
- Record explicit exclusions with their reason.
- Route consequential unplanned changes to their owning phase.

Before closing, account for every approved requirement and every relevant change.

Each must have proof, an explicitly accepted verification gap, or an approved scope exclusion.

## Safe Cleanup

Before removing temporary work:

- Confirm it belongs to the current lifecycle.
- Transfer useful decisions to their permanent owner.
- Preserve evidence needed for completed checks.
- Confirm retained evidence references will still resolve.
- Preserve unrelated files and user work.
- Remove only artifacts whose useful content has been preserved.

## Deterministic Checks

Use existing project checkers wherever they can enforce applicable rules.

When repeated omissions justify a new checker:

- Propose the smallest useful check.
- Obtain approval for consequential process changes.
- Validate that it catches the omission.

Checkers supplement requirement coverage and human approval.
