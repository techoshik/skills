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
- `../lifecycle/references/guidelines.md`
- `../lifecycle/references/cycle-log.md`
- `../lifecycle/references/companion-skills.md`

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

Plan approval already authorizes Build Step 1.

Do not request approval before starting an already-approved Build Step.

Complete Preflight before editing.

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

When an upstream decision is wrong:

- route it to Idea/Prototype/Plan;
- do not improvise inside Build.

If a planned Verify check must materially change:

- return to Plan;
- update the step;
- regain approval;
- then resume Build.

After completing and verifying each Build Step:

- update `04-build.md`;
- run the Cycle Log sweep;
- update `00-lifecycle.md`;
- present the completed result;
- wait for explicit user approval.

Approval of completed Step N authorizes Step N+1.

Do not ask for a separate pre-approval before starting the next already-planned step.

When all Build Steps are approved:

- present Build completion;
- wait for explicit user approval before Finalize.
