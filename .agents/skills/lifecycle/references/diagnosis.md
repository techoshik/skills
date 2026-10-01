# Diagnosis

## Reproduce

Establish exact symptom and expected behavior. Before production-code edits, run the cheapest repeatable check reaching the failing path: existing test, development request, replay, or focused harness. Prefer fast deterministic reproduction; record intermittent frequency/conditions and redact sensitive evidence.

If unavailable, record attempts and missing evidence/access, distinguish hypotheses from causes, request only needed information/authorization, and keep the proof gap visible.

## Isolate

Minimize the scenario while retaining the original for final verification. Consider competing causes and observable predictions; vary one relevant factor and use targeted inspection/instrumentation. Mark temporary instrumentation for cleanup. Measure performance baseline before optimization.

## Fix and prove

Idea owns symptom/impact/success; Prototype owns experiments; Plan owns fix/regression proof; Build implements; Finalize checks the full change. Diagnosis preserves these approval gates.

Turn reproduction into a regression test reaching the actual failure and use [behavioral TDD](build.md#tdd--hard-rule-for-testable-behaviour). Record limitations under Proof Limits/Gap Acceptance when the test cannot reach it. Rerun original scenario and affected regressions; compare performance under baseline conditions. Preserve cause/fix evidence, then remove instrumentation.
