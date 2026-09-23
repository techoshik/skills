# Refine

## Purpose

> **Refine is a router for learning, not a retrospective archive.**

- Review what reality taught during the completed cycle.
- Move every useful lesson to the place that can prevent or exploit it next time.
- Make the temporary lifecycle workspace safe to delete.

## Inputs

- Verify result.
- Build results/deviations.
- Complete Cycle Log.
- Completed branch diff.
- Relevant module docs.
- Applicable Engineering Guidelines.
- Lifecycle/phase skills when process drift was observed.

## Core Rule

> **Fix learning at its source of truth.**

Route findings to one of three permanent destinations:

### Codebase
Use when:
- the current implementation can be improved now;
- duplication/complexity/temporary code should be removed;
- tests/automation/code structure should be improved.

### Module Docs
Use when:
- durable module behaviour/knowledge was missing or changed;
- a limitation or deferred/future module opportunity should survive cleanup.

Future work recorded in a module document is not approved scope. When selected, it starts at Define.

### Lifecycle / Engineering Guidance
Use when:
- the lifecycle caused avoidable friction;
- agents drifted from instructions;
- a recurring engineering rule belongs in `docs/guidelines/`;
- a lifecycle phase/skill should change;
- deterministic automation could prevent repeated manual correction.

Do not preserve useful learning only in `07-refine.md` or the Cycle Log.

## Review Rule

> **Review broadly. Record selectively.**

Inspect as relevant:

- branch diff and nearby code;
- duplication and reuse;
- unnecessary complexity;
- obsolete/temporary code;
- naming/structure;
- tests and deterministic checks;
- reliability/security/performance;
- module documentation;
- Engineering Guidelines;
- lifecycle instructions;
- Cycle Log entries.

Record a finding only when it is:

- worth fixing now;
- worth preventing next time;
- worth preserving as module knowledge;
- worth recording as future module work.

## One Finding = One Complete Group

Keep related information together:

- **Finding**
  - What happened and evidence when needed.
- **Action**
  - Smallest useful improvement.
- **Home**
  - Codebase / module doc / guideline / lifecycle skill.
- **Status**
  - Proposed / Approved → Applied / Declined / Deferred.
- **Proof**
  - Only when an applied change needs reverification.

Do not split one finding across separate review, promotion, approval, and exit sections.

## Approval

- Propose Refine changes before applying them unless the user has explicitly authorized direct updates.
- Apply only approved changes.
- Reverify approved code changes and any process/guideline change that has a deterministic check.
- Cleanup is a separate decision unless the user already gave a standing instruction.

## Output — `07-refine.md`

### Decision
- Result: Refinement complete / Awaiting approval / Blocked.
- Status.
- Blockers.
- Next.

### Improvements
Group findings by permanent destination when useful:

- **Codebase — <finding>**
- **Module Docs — <finding>**
- **Lifecycle — <finding>**

Each finding contains its complete Finding / Action / Home / Status / Proof group.

### Closure
- Code improvements: Applied / None / Pending.
- Module knowledge: Transferred / None / Pending.
- Lifecycle improvements: Applied / None / Pending.
- Cycle Log: Processed / Pending.
- Workspace: Safe to delete / Retain / Archive / Remove / Pending.
- Cycle: Closed / Blocked.

## Phase Gate

Pass when:

- every meaningful Cycle Log entry is applied, transferred, deferred intentionally, or dismissed intentionally;
- approved code improvements are reverified;
- durable module knowledge/future work is in module docs;
- approved lifecycle/guideline learning is in its permanent source;
- nothing valuable exists only in temporary lifecycle files;
- workspace cleanup decision is recorded.

After that, the lifecycle workspace is safe to remove or archive.
