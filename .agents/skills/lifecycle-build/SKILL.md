---
name: lifecycle-build
description: "Use after Plan to implement one approved Build Step at a time with strict project conformance, UI-first feedback when useful, and TDD for testable behaviour."
---

# Build

## Phase Question

> **Can we implement the current Build Step correctly without guessing or drifting from the project?**

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
- current Build Step;
- current `Done When`;
- only relevant Idea/Prototype decisions;
- affected module docs;
- every applicable engineering rule;
- nearby established implementations.

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
- Check conformance and `Done When`.

When something unexpected requires a **consequential choice**:

- stop;
- explain;
- recommend;
- ask.

When an upstream decision is wrong:

- route it to Idea/Prototype/Plan;
- do not improvise inside Build.

After each Build Step:

- update `04-build.md`;
- run the Cycle Log sweep;
- update `00-lifecycle.md`;
- present the step;
- wait for explicit user approval.

Do not start the next Build Step before approval.

When all Build Steps are approved:

- present Build completion;
- wait for explicit user approval before Finalize.
