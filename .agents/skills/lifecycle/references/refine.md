# Lifecycle — Refine

## 1. Purpose

- Learn from completed work and improve the **codebase, Engineering Guidelines, context, and development process** where learning creates meaningful future value.
- Reduce repeated mistakes, duplicated effort, ambiguity, manual correction, and unnecessary cognitive load.
- Review what the branch introduced or exposed and make worthwhile simplifications before closing the cycle.

> **Do not just finish the work. Improve the system that produced the work.**

## 2. Inputs

- **Verify Result** — What passed, failed, or required correction.
- **Build Results** — Slice results, deviations, conformance issues, repeated corrections.
- **Cycle Log** — Friction, ambiguity, agent drift, rework, manual intervention captured during the lifecycle.
- **Branch Changes** — Diff against base branch plus nearby code needed to understand what the work introduced/exposed.
- **Engineering Guidelines** — Project rules under `docs/guidelines/` that may be incomplete, unclear, difficult to follow, or candidates for automation.
- **Context** — Product/system knowledge that may have proved missing, stale, or incomplete.
- **Human Intervention** — Things a developer repeatedly had to explain, correct, or manually check.
- **Real-World Evidence** — User feedback, production behaviour, analytics, support/operational learning when available.

## 3. Rules

- **Evidence before improvement** — Do not refine merely because something could theoretically be better.
- **Fix the system, not only the symptom** — Repeated mistakes should improve the rule/check/context/process that allowed them.
- **No gold-plating** — Refine is not permission to add extra features.
- **New value goes through Define** — Newly discovered capability/requirement becomes future work.
- **Update the source of truth** — Propose improvements to canonical Context, the applicable file under `docs/guidelines/`, lifecycle guidance, module docs, or automation in `07-refine.md`; apply only what the user approves.
- **Automate mechanical rules** — Prefer deterministic checks where they can replace repeated human review.
- **Improve verification from evidence** — Recurring missing coverage, expensive setup, or flaky module/E2E tests should produce a small proposal for guidance, fixtures, CI, or automation; do not add broad test infrastructure speculatively.
- **Keep judgment human-readable** — Do not force subjective architecture/product judgment into brittle automation.
- **Group learning by finding** — Use bold top-level bullets for learning, cause, improvement, disposition, and approval; nest the supporting evidence and recommendations beneath them.
- **One finding per group** — Give each codebase or process finding its own bold group; keep its location, evidence, impact, recommendation, and disposition together.
- **Selective output** — Record meaningful findings and proposals only; do not create a field-by-field retrospective.
- **Smallest useful improvement** — Apply only enough refinement to prevent meaningful future cost.
- **Duplication triggers investigation, not automatic abstraction.**
- **Prefer reuse of an existing abstraction.** Create a new shared abstraction only when multiple real usages represent the same responsibility and sharing reduces complexity/coupling.
- **Review the branch for high-value improvements, not broad cleanup.**
- **Reverify code changes** — Any implementation change returns through applicable Build checks, Conformance Review, and affected behavioural verification.
- **Stop when learning is captured** — Refine must not become endless polishing.

> **A repeated correction is evidence that the system needs improvement.**

## 4. Questions

### Solution

- Did reality reveal something we misunderstood?
- Did we build anything more complicated than necessary?
- Did Verify expose a scenario we should handle differently next time?
- Is this refinement or actually a new requirement for Define?

### Development Process

- Where did the agent drift from instructions?
- What did the developer repeatedly correct?
- Which instruction/plan/standard was ambiguous?
- What was discovered too late and which earlier phase should have caught it?
- What work could have been deleted?

### Engineering Guidelines

- Was a needed rule missing?
- Was an existing rule too vague?
- Can a deterministic check automate it?
- Did this work establish a proven reusable pattern?

### Reuse & Simplification

- Does similar code already exist?
- Is there an existing abstraction to reuse?
- Are repeated usages genuinely the same responsibility?
- Would extraction reduce complexity or create coupling?
- Is the pattern stable enough to abstract now?

### Context

- What missing/stale system knowledge caused wrong assumptions?
- What reusable knowledge should future features automatically know?

### Value

- Will this refinement reduce future defects, time, duplication, or cognitive load?
- Is it likely to recur?
- Is the improvement worth doing now?
- What is the smallest useful change?

## 5. Actions

- Review the **Cycle Log**, Build deviations, Conformance failures, Verify failures, and developer corrections.
- Review the branch diff and nearby code for duplication, reuse, unnecessary complexity, temporary/obsolete code, naming/structure inconsistencies, missing tests, and automation opportunities.
- Review reliability, security, performance, maintainability, and documentation/context when relevant to the changed code or its dependencies.
- Create a Codebase Review inventory of every meaningful finding.
- For each finding, record:
  - Location and evidence.
  - Impact and recommendation.
  - Proposed disposition: fix now, add to the backlog, intentionally keep separate, or dismiss with a reason.
- Record material findings; prioritize only high-leverage improvements for implementation.
- For duplication or reusable behaviour: **reuse an existing abstraction → extract only when justified → keep implementations separate when responsibilities differ or the pattern is unstable**.
- Propose removal of temporary or obsolete code introduced by the work; remove it only after user approval and a safety check.
- Propose prototype removal after Verify when its validated decisions are captured in lifecycle or permanent documentation; remove it only after approval.
- Preserve a useful screenshot or decision record when it benefits future context.
**Classify each meaningful lesson into its proper home:**

| Lesson | Destination |
| --- | --- |
| New requirement or value | Define / future work |
| Missing or stale system knowledge | Context / permanent module docs |
| Solution-learning pattern | Shape guidance |
| Planning problem | Plan guidance |
| Development or conformance problem | Build or the applicable file under `docs/guidelines/` |
| Mechanical recurring check | Automation |

- Propose each update to its canonical source of truth in `07-refine.md`; do not apply it while preparing the review.
- After approval, strengthen unclear guidelines with concrete rules/examples in `docs/guidelines/`.
- After approval, convert worthwhile deterministic rules into a formatter, linter, architecture test, compiler check, CI check, or other automated guard.
- Propose removal of obsolete or duplicated guidance; apply it only after approval.
- Use **improve-codebase-architecture** to survey branch/codebase design opportunities.
- Use **writing-for-agents** when the Cycle Log shows lifecycle/skill/pointer/agent-instruction problems.
- Use **code-review** after code-level refinement when useful.
- If the user approves implementation changes, rerun applicable automated checks, Slice Conformance Review, and affected behavioural verification.
- Process every Cycle Log entry by proposing useful learning, explicit future work, or intentional dismissal in `07-refine.md`.
- After approval, promote durable product/module knowledge into `docs/modules/<module>.md`.
- Update an existing module document in place; create a missing one from `.agents/skills/lifecycle/templates/module.md`.
- Keep module docs concise and behavioral: `Goal → Rules → Features`.
- Use `Feature Name — Responsibility` headings with capability bullets.
- Remove stale behaviour and keep implementation details in code.
- Skip promotion when the change added no durable product knowledge.
- Keep the active lifecycle workspace versioned until the cycle is closed and its handoff state is no longer needed.
- After promotion and reverification pass, ask whether to retain, archive, or remove the workspace. Record the choice; explicit confirmation is required before archive/removal.

- Before closing the lifecycle:

  - Identify intentionally postponed modules, features, and capabilities.
  - Propose worthwhile future work in `07-refine.md` before editing `docs/backlog/`.
  - After approval, preserve product opportunities in the backlog rather than the Cycle Log.
  - Do not duplicate items already represented accurately in the backlog.

> **Every lesson should improve the place in the system that should have prevented the problem.**

## 6. Output

### Refinement Result

- **Learning**
  - What we learned and the evidence.
- **Cause**
  - What caused it.
- **Improvement**
  - System improvement, proposed source, and reverification requirement.
- **Future work**
  - Only when something must return to Define or be deferred.

- Keep the result small. The goal is to change the system, not create a large retrospective document.

### Codebase Review

- **Finding — …**
  - Location and evidence.
  - Impact.
  - Recommendation.
  - Proposed disposition.

### Lifecycle Workspace Closure

- **Cleanup**
  - Decision: Pending user confirmation / Retain / Archive / Remove.
  - User confirmation: …

### Exit

- **Exit Status:** Pass / Blocked.
- **Evidence:** …
- **Remaining Blockers:** …
- **Next Phase:** Cycle closed.

## 7. Exit

- Refine is complete when:

  - Important Cycle Log lessons and completed work have been reviewed.
  - Repeated/expensive problems have been addressed at their root system/process level where practical.
  - The branch has been reviewed for worthwhile reuse, duplication reduction, unnecessary complexity, temporary code, and consistency issues introduced/exposed by this work.
  - Shared abstractions exist only where real repeated responsibility justifies them; premature abstraction is avoided.
  - Approved updates to Context, Engineering Guidelines, lifecycle guidance, permanent module docs, or automation have been applied where needed.
  - New requirements are separated from refinement and returned to Define/future work.
  - Valuable postponed product work has either been added to the backlog, intentionally dismissed, or is already represented there.
  - Any code changes made during Refine pass applicable automated checks, Conformance Review, and affected behavioural verification.
  - Useful learning has been transferred out of the Cycle Log.
  - A Codebase Review inventory records meaningful duplication, reuse, simplification, quality, automation, and documentation findings, or explicitly records that none were found.
  - The user has reviewed the Refine proposal and approved, declined, or deferred each proposed change.
  - Only approved code, documentation, guideline, automation, or backlog changes have been applied and reverified where applicable.
  - The user has confirmed whether the completed lifecycle workspace is retained, archived, or removed.
  - No further refinement currently provides enough value to justify the work.
  - A human/AI agent can honestly say:

> **We captured what this cycle taught us, improved the code or system where the evidence justified it, and made the next development cycle easier and more reliable than this one.**
