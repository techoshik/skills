# Lifecycle — Define

## 1. Purpose

- Decide whether the work is worth doing and define the **minimum valuable outcome**.
- Clarify the problem, user, value, boundaries, and success before designing the solution.
- Do **not** design detailed UI, data models, APIs, architecture, or code yet.

## 2. Inputs

- **Request / Idea** — The proposed module, feature, task, or problem.
- **Evidence** — User feedback, observed behavior, analytics, support issues, business needs, or other proof available.
- **Priorities** — Relevant product or business goals that help answer why this matters now.
- **Known Constraints** — Product, legal, time, platform, compatibility, permission, or business limits already known.
- **Existing Module Definition** — When defining a feature inside an existing module.

## 3. Rules

- **Value before features** — Build only what creates meaningful value or necessary risk reduction.
- **Minimum before complete** — Find the smallest useful outcome before expanding scope.
- **Group by decision** — In the artifact, use bold top-level bullets for topics such as scope, outcome, rules, and proof; nest supporting details beneath them.
- **Selective output** — The question set is a thinking aid, not a checklist; omit fields that do not change the Define decision.
- Describe **problems and outcomes before solutions**.
- Prefer observable requirements over vague words such as easy, fast, or user-friendly.
- Separate **facts from assumptions**.
- Never let unanswered questions silently become implementation assumptions.
- Never let AI silently convert discovered opportunities into requirements.
- Do not add content merely to fill the template; unknowns remain unknown or Open Questions.
- Avoid detailed UI, data, API, and architecture decisions; those belong to later phases.
- If the problem or value is unclear, do not move forward just because AI can build it quickly.

## 4. Questions

- Use these as a decision-tree frontier, not a three-question checklist.
- Ask all currently answerable user decisions in one round.
- Wait for answers, then recompute the next round.
- Run this pass even when the request sounds clear.

- **Problem** — What real problem are we solving?
- **User** — Who experiences it?
- **Current Situation** — How is it handled today?
- **Value** — What meaningful change will solving it create?
- **Evidence** — Why do we believe the problem is real?
- **Why Now** — Why is this worth doing before other work?
- **Delete Test** — What happens if we do not build it?
- **Minimum Outcome** — What is the smallest result that meaningfully solves the problem?
- **Required Capabilities** — What must the user be able to do?
- **Business Rules** — What must always remain true?
- **Scope** — What is included now?
- **Non-Scope** — What tempting additions are intentionally excluded?
- **Success Criteria** — What observable result proves this works?
- **Constraints** — What limits must the solution respect?
- **Assumptions** — What do we believe but have not verified?
- **Open Questions** — What still needs an answer before Shape?
- **Dependencies** — What other modules, services, people, or processes are involved?
- **Risks** — What could make this fail even if the code works?
- **Proof** — Which outcome or critical journey must be demonstrated, and what risk remains if it is not proven?

## 5. Actions

- Question every requirement before accepting it.
- Separate **facts, assumptions, and open questions**.
- Capture the outcome, critical journey, and risk that verification must prove; defer the specific test level to Shape unless it is already known.
- Delete requirements that do not materially improve the intended outcome.
- Reduce the work to the **minimum outcome** that still creates meaningful value.
- Resolve critical ambiguity; keep unresolved items visible as **Open Questions**.
- Decide **Proceed, Defer, or Reject** before moving forward.
- If the decision is **Defer** but the opportunity still has meaningful future value, create or update an entry in `docs/backlog/`.
- If the current release intentionally excludes valuable capabilities, preserve those capabilities in the backlog instead of leaving them only in lifecycle history.
- Use **grill-with-docs** for every non-trivial change to interview the user, sharpen terminology, and stress-test concrete scenarios.
- Use **wayfinder** when the decision tree is too large or foggy for one session; translate its decisions into this lifecycle structure rather than adopting a competing monolithic spec.

> **Define captures deferred value; it does not decide when that value becomes a priority.**

## 6. Output

### Decision Summary

- **Decision / Result:** Proceed / Defer / Reject.
- **Status:** Complete / Blocked.
- **Blockers:** …
- **Next Action:** …

### Requirement Review

- **Decisions**
  - …
- **Assumptions**
  - …
- **Risks**
  - …
- **Open questions**
  - Decision needed, owner, impact, and next action.

### Feature Definition

- **Problem framing**
  - Problem, users, current situation, and evidence.
- **Value**
  - Value and why now.
- **Minimum outcome**
  - The smallest result that creates meaningful value.
  - Delete test: what happens if the work is not built.
- **Capabilities**
  - Required user or system capabilities.
- **Rules**
  - Business, privacy, safety, and reliability rules.
- **Scope**
  - In-scope and out-of-scope work.
- **Constraints**
  - Product, platform, permission, legal, or technical constraints.
- **Success**
  - Observable success criteria.
- **Dependencies**
  - Services, people, permissions, or systems required.
- **Risks**
  - Risk, impact, and mitigation.

### Verification Intent

- **Outcome**
  - Outcome to prove.
- **Critical journey**
  - Feature or module flow that must work.
- **Risk**
  - Risk if the outcome remains unproven.
- **Constraints**
  - Verification constraints.

### Exit

- **Exit Status:** Pass / Blocked.
- **Evidence:** …
- **Remaining Blockers:** …
- **Next Phase:** Context.

### Module Definition

- **Decision / result**
  - Proceed / Defer / Reject.
- **Purpose**
  - Purpose and users.
- **Value**
  - Module outcome, value, evidence, and why now.
- **Minimum outcome**
  - Minimum outcome and delete test.
- **Rules**
  - Shared business rules.
- **Scope**
  - In-scope and out-of-scope work.
- **Dependencies**
  - Dependencies.
- **Risks**
  - Risks and mitigations.
- **Features**
  - Features in the module.

- A **Defer** decision with future value has been preserved in the backlog.

## 7. Exit

- Move to **Context** only when:

  - Decision is **Proceed**.
  - Problem, user, value, evidence, and minimum outcome are clear.
  - Scope and non-scope are explicit.
  - Success criteria are observable.
  - Important assumptions, open questions, dependencies, and risks are visible.
  - The outcome, critical journey, and verification risk are visible; no test level has been added as unapproved scope.
  - **Cycle Log Check** has been performed.
  - A **Defer** decision with future value has been preserved in the backlog.
  - A human or AI agent can honestly say:

> **I understand who needs this, why it matters, the minimum thing worth building, its boundaries, and what success looks like.**
