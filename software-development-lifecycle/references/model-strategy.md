# Model Strategy

## 1. Sol — Goal Planning

- Brainstorm and challenge the idea.
- Define the Problem, Goal, Scope, and Requirements.
- Design architecture and delivery Steps.
- Create Luna-ready detailed Step records.
- Check completeness and new-developer readability.
- Present the plan for user approval.

## 2. Luna — Step Implementation

- Execute one bounded Step at a time.
- Follow Actions in order.
- Follow listed guidelines and constraints.
- Run focused tests and flow checks.
- Record verification evidence.
- Mark `Verified` only when every required check passes.

## 3. Terra or Sol — Escalation

- Escalate conflicting requirements or guidelines.
- Escalate missing material decisions.
- Escalate architecture, security, privacy, migration, compatibility,
  transaction, and concurrency risks.
- Escalate repeated verification failures.
- Escalate work outside the approved Step.
- Use Terra for moderately difficult implementation.
- Use Sol for consequential decisions or high-risk work.

## 4. Sol — Goal Verification

- Review the complete diff and flow.
- Verify Requirements and acceptance criteria.
- Check interactions, regressions, and preserved behavior.
- Confirm alignment with the Goal.
- Reopen affected Steps when gaps remain.
- Confirm documentation and release readiness after gaps are resolved.

## Use

- Use Luna at medium reasoning as the initial execution baseline.
- Increase Luna reasoning only when representative results improve.
- Prefer escalation when higher effort remains unreliable.
- Keep Goal Planning and Goal Verification independent from Luna execution.
- Follow explicit user choices and available models.
