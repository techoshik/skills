---
name: lifecycle-verify
description: "Use after Build to prove the complete integrated change satisfies the original promise and protects affected existing behaviour."
---

## Phase Question

> **Does the completed change fulfil the original promise?**

- Use this question as the delete test for phase work and artifact content.
- Follow the shared **Decide → Work → Resolve** frame without renaming the phase-specific sections.

- Read:
  - `../lifecycle/references/framework.md`
  - `../lifecycle/references/verify.md`
  - `../lifecycle/references/verification-strategy.md`
  - `../lifecycle/references/guidelines.md`
  - `../lifecycle/references/approval.md`
  - `../lifecycle/references/cycle-log.md`

- Load:
  - Define success criteria/journey;
  - Context protection boundaries;
  - Shape proof decision;
  - Plan journeys;
  - Build results;
  - applicable Engineering Guidelines.

- Verify the final integrated change, not each Build slice again.
- Run the required real journey/boundary.
- Check critical rules, targeted regressions, final conformance, and project gates.
- Record the smallest trustworthy evidence; do not write a QA transcript.

- Use `code-review` for independent final review when useful.
- Use `diagnosing-bugs` for difficult failures.

- Route failures to the owning phase with the required action and reverification target.

- Write/update `06-verify.md` using:
  - Decision
  - Proof
  - Protection
  - Issues

- Add a compact Mermaid verification journey when final proof crosses UI, navigation, backend, persistence, permissions, or external boundaries. Keep evidence and pass/fail results in the text.

- Complete when the Verify gate passes.
- Apply approval mode and update `00-lifecycle.md`.
