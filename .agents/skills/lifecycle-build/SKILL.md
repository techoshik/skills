---
name: lifecycle-build
description: "Use after Plan approval to execute one Build Step at a time, verify it, record the actual result, and request approval only after the completed step is reviewable."
---

# Build

## Phase Question

> **Can we implement and verify the current Build Step correctly without guessing or drifting from the project?**

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/artifacts.md`
- `../lifecycle/references/build.md`
- `../lifecycle/references/code-review.md`
- `../lifecycle/references/guidelines.md`
- `../lifecycle/references/cycle-log.md`

Before presenting a document, complete the [required compactness pass](../lifecycle/references/artifacts.md#required-compactness-pass).

Load:

- `00-lifecycle.md`;
- approved `03-plan.md`;
- current Build Step:
  - Specification;
  - Build;
  - Verify;
- only relevant Idea/Prototype decisions;
- affected module docs;
- every applicable engineering rule;
- nearby established implementations.

Follow the [Build approval gate](../lifecycle/references/framework.md#build-gate).

Complete Preflight and [Impact Preflight](../lifecycle/references/completeness.md#impact-preflight) before editing.

## Non-negotiable

- Do not invent consequential conventions.
- Do not silently broaden scope.
- Do not implement an unapproved architectural/product decision.
- Suggestions are welcome.
- Consequential extra implementation requires approval.
- Implement one Build Step at a time.
- Use TDD for testable behaviour.
- Honor approved UI-first steps.
- Follow the step Specification.
- Perform the step Verify checks.

When something unexpected requires a **consequential choice**:

- stop;
- explain;
- recommend;
- ask.

Use [decision ownership](../lifecycle/references/framework.md#return-to-the-owner) when upstream decisions change.

If a planned Verify check must materially change:

- return to Plan;
- update the step;
- regain approval;
- then resume Build.

Apply [Proof Limits](../lifecycle/references/completeness.md#proof-limits) and [Gap Acceptance](../lifecycle/references/completeness.md#gap-acceptance).

Complete [Lifecycle Code Review](../lifecycle/references/code-review.md) before presenting each Build Step.

After completing and verifying each Build Step:

- update `04-build.md`;
- run the Cycle Log sweep;
- update `00-lifecycle.md`;
- present the completed result;
- wait for explicit user approval.

When all Build Steps are approved:

- present Build completion;
- wait for explicit user approval before Finalize.
