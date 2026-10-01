# Bug and Performance Diagnosis

## Feedback Loop

Use when a reported defect or regression needs investigation.

- Identify the user's exact symptom and expected behavior.
- Build the cheapest repeatable check that distinguishes failure from success.
- Run it before changing production code.
- Prefer an existing test, development request, replay, or focused harness.
- Confirm it reaches the actual failing path.
- Make it fast and deterministic where practical.
- For intermittent failures, record reproduction frequency and conditions.
- Redact secrets and sensitive data in captured evidence.

If reproduction is unavailable:

- Record attempts and missing access or evidence.
- Distinguish hypotheses from confirmed causes.
- Request only the information or authorization needed to proceed.
- Keep the reproduction gap visible.

## Isolate the Cause

- Minimize the scenario while preserving the observed failure.
- Keep the original scenario for final verification.
- Consider competing causes before committing to one explanation.
- State the observable prediction for each plausible hypothesis.
- Change one relevant variable at a time.
- Use targeted inspection or instrumentation to distinguish hypotheses.
- Label temporary instrumentation so cleanup can find it.
- For performance issues, measure a baseline before optimizing.

## Phase Ownership

- **Idea:** Establish the symptom, impact, and expected outcome.
- **Prototype:** Use a focused experiment when needed to establish the cause.
- **Plan:** Define the approved fix and regression proof.
- **Build:** Fix within the approved step and verify the behavior.
- **Finalize:** Recheck the complete journey and preserve useful learning.

Diagnosis does not bypass phase or scope approval.

## Fix and Verify

- Turn the reproducer into a regression test where the actual failure can be exercised.
- Follow the [Build TDD loop](build.md#tdd--hard-rule-for-testable-behaviour).
- If the available test cannot reach the failure, record the proof limitation.
- Use the [gap acceptance rules](completeness.md#gap-acceptance) for missing required verification.
- Rerun the original scenario after the fix.
- For performance fixes, compare against the baseline using the same conditions.
- Check affected regressions.
- Remove temporary instrumentation after preserving needed evidence.
- Record the confirmed cause and the fix briefly.
