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
- **Update the source of truth** — Improve canonical Context, the applicable file under `docs/guidelines/`, lifecycle guidance, module docs, or automation rather than scattered notes.
- **Automate mechanical rules** — Prefer deterministic checks where they can replace repeated human review.
- **Keep judgment human-readable** — Do not force subjective architecture/product judgment into brittle automation.
- **Smallest useful improvement** — Apply only enough refinement to prevent meaningful future cost.
- **Duplication triggers investigation, not automatic abstraction.**
- **Prefer reuse of an existing abstraction.** Create a new shared abstraction only when multiple real usages represent the same responsibility and sharing reduces complexity/coupling.
- **Review the branch for high-value improvements, not uncontrolled cleanup.**
- **Reverify code changes** — Any implementation change returns through applicable Build checks, Conformance Review, and affected behavioural verification.
- **Stop when learning has been captured** — Refine must not become endless polishing.

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
- Identify the **few highest-leverage lessons and improvements**, not every cleanup opportunity.
- For duplication/reusable behaviour: **reuse existing abstraction → extract shared abstraction only when justified → otherwise keep separate implementations when responsibilities differ or the pattern is not stable**.
- Remove temporary/obsolete code introduced by the work when clearly safe and unnecessary.
- Classify each meaningful lesson into its proper home:
  - New requirement/value → Define / future work
  - Missing/stale system knowledge → Context / permanent module docs
  - Solution-learning pattern → Shape guidance
  - Planning problem → Plan guidance
  - Development/conformance problem → Build or the applicable file under `docs/guidelines/`
  - Mechanical recurring check → Automation
- Update the appropriate canonical source of truth instead of leaving learning only in the Cycle Log.
- Strengthen unclear guidelines with concrete rules/examples in `docs/guidelines/`.
- Convert deterministic rules into formatter, linter, architecture test, compiler check, CI check, or another automated guard where worthwhile.
- Remove obsolete or duplicated guidance.
- Use **improve-codebase-architecture** to survey branch/codebase design opportunities.
- Use **writing-for-agents** when the Cycle Log shows lifecycle/skill/pointer/agent-instruction problems.
- Use **code-review** after code-level refinement when useful.
- If implementation code changes, rerun applicable automated checks, Slice Conformance Review, and affected behavioural verification.
- Process every Cycle Log entry by promoting useful learning, creating explicit future work, or intentionally dismissing a one-off.
- Promote durable product/module knowledge from the lifecycle into `docs/modules/<module>/` so module documentation reflects the system as it now exists.
- Archive the completed Cycle Log and lifecycle workspace according to project policy after durable knowledge has been promoted.

Before closing the lifecycle:

- Identify intentionally postponed modules, features, and capabilities.
- Preserve worthwhile future work in `docs/backlog/`.
- Keep product opportunities in the backlog rather than the Cycle Log.
- Do not duplicate items already represented accurately in the backlog.

> **Every lesson should improve the place in the system that should have prevented the problem.**

## 6. Output

### Refinement Result

- **What We Learned:** …
- **What Caused It:** …
- **System Improvement:** …
- **Updated Source:** Define / Context / Shape / Plan / Build / Verify / Engineering Guidelines / Module Docs / Automation / Other
- **Future Work:** … *(only when something must return to Define or be deferred)*
- **Reverification Required:** Yes / No

Keep the result small. The goal is to change the system, not create a large retrospective document.

## 7. Exit

Refine is complete when:

- Important Cycle Log lessons and completed work have been reviewed.
- Repeated/expensive problems have been addressed at their root system/process level where practical.
- The branch has been reviewed for worthwhile reuse, duplication reduction, unnecessary complexity, temporary code, and consistency issues introduced/exposed by this work.
- Shared abstractions exist only where real repeated responsibility justifies them; premature abstraction is avoided.
- Relevant Context, Engineering Guidelines, lifecycle guidance, permanent module docs, or automation has been updated where needed.
- New requirements are separated from refinement and returned to Define/future work.
- Valuable postponed product work has either been added to the backlog, intentionally dismissed, or is already represented there.
- Any code changes made during Refine pass applicable automated checks, Conformance Review, and affected behavioural verification.
- Useful learning has been transferred out of the Cycle Log.
- No further refinement currently provides enough value to justify the work.
- A human/AI agent can honestly say:

> **We captured what this cycle taught us, improved the code or system where the evidence justified it, and made the next development cycle easier and more reliable than this one.**
