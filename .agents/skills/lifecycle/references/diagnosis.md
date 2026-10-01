# Diagnosis

## Reproduce

Establish exact symptom and expected behavior. Before production-code edits, run the cheapest repeatable check reaching the failing path: existing test, development request, replay, or focused harness. Prefer fast deterministic reproduction; record intermittent frequency/conditions and redact sensitive evidence.

If unavailable, record attempts and missing evidence/access, distinguish hypotheses from causes, request only needed information/authorization, and keep the proof gap visible.

## Isolate

Minimize the scenario while retaining the original for final verification. Consider competing causes and observable predictions; vary one relevant factor and use targeted inspection/instrumentation. Mark temporary instrumentation for cleanup. Measure performance baseline before optimization.

## Fix and prove

Idea owns symptom/impact/success; Prototype owns experiments; Plan owns fix/regression proof; Build implements; Finalize checks the full change. Diagnosis preserves these approval gates.

- **Regression coverage:** Add or extend a test reaching the actual failure when it provides meaningful protection, following [step-end testing](build.md#implement-then-test-the-step).
- **Proof limits:** Record limitations under Proof Limits/Gap Acceptance when the test cannot reach the failure.
- **Original scenario:** Rerun it after the fix and check affected regressions.
- **Performance:** Compare results under the baseline conditions.
- **Evidence and cleanup:** Preserve cause/fix evidence, then remove instrumentation.
