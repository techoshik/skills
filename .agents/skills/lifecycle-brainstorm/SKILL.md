---
name: lifecycle-brainstorm
description: Investigate the problem and codebase, compare viable solutions, resolve material ambiguity, trace affected callers, and author a clear 01-requirements.md (Lifecycle: Brainstorm).
---

# Lifecycle Brainstorm

Own the quality of problem understanding and requirements. Do not rush from the user's first proposed implementation to a solution. Determine the real goal, investigate what already exists, identify meaningful alternatives and consequences, and ask the user about decisions that belong to them. Produce a specification that is easy to scan but complete enough to guide safe implementation.

Follow the five steps below. Keep the existing Brainstorm approval gate.

## 0. Phase Rules & Guardrails

- **Understand before solutioning:** Restate the user problem, desired outcome, constraints, and non-goals before narrowing implementation options.
- **Investigate before asking:** Inspect existing module docs, relevant source/tests, `.agents/rules/`, `GLOSSARY.md`, and callers first. Do not ask the user to supply facts that can be found reliably in the repository.
- **Facts are not decisions:** Existing behavior is evidence, not automatic proof of intended behavior. A historical pattern does not grant permission to preserve a confusing UX or to choose a business rule.
- **Challenge constructively:** Look for simpler user journeys, existing reusable capabilities, duplicate flows, obsolete paths, unnecessary states, and avoidable changes. Do not refactor unrelated code merely because it looks imperfect.
- **Comprehension over brevity:** Put the decision-critical summary first. Use concise bullets for requirements and constraints, and short prose when it explains a rationale more clearly. Never omit a material edge case solely to shorten the file.

## Step 1: Initialize or Resume

1. If `lifecycle/00-status.md` and `lifecycle/01-requirements.md` exist, inspect and resume them; never overwrite existing work.
2. For a cold start, initialize `lifecycle/00-status.md` from [Status Template](../lifecycle/templates/00-status.md) with Brainstorm `In Progress`, and initialize `lifecycle/01-requirements.md` from [Requirements Template](../lifecycle/templates/01-requirements.md).
3. Read the orchestrator's global contract and any project-specific instructions supplied by the workflow. Respect existing user decisions and any status checkpoint.

**Gate:** Status is `Brainstorm: In Progress`; the requirements artifact exists and preserves any prior work.

## Step 2: Evidence-Driven Pre-Flight Research

Before asking the first question, inspect the relevant system:

1. Read `docs/modules/<module>/README.md` and relevant `feature_<name>.md` files, `.agents/rules/`, `GLOSSARY.md`, and existing lifecycle artifacts.
2. Trace the likely implementation path through UI/entry point, validation, state/controller, repository/data layer, permissions, persistence, and UI refresh where relevant.
3. **Mandatory All-Callers Grep (2nd-Order Ripple Trace):** Search (`grep`) across source and test files for callers of affected routes, model fields, getters, events, controllers, or public methods. Read the actual call sites, not just search-result counts. Delegate broad scans (`10+` files) to a fresh worker sub-agent when available and give it the required task packet.
4. **UX Duplication & Technical Debt Critique:** Ask yourself while inspecting the existing code:
   - *Are there duplicate screens, tabs, or cards managing the same module concept in multiple places?*
   - *Are there deprecated fields, legacy aliases, or `TODO`s that should be cleaned up rather than preserved?*
   - *What is the simplest, most intuitive screen flow for the end user?*
   Inspect existing tests and conventions to learn expected behavior and reusable code. Distinguish verified facts from guesses, stale documentation, and conflicting sources.
5. Use web research when current external APIs, dependency behavior, platform requirements, security guidance, or established UX patterns materially affect the solution. Summarize findings and cite useful sources in the artifact or conversation.
6. Record the important reusable building blocks, directly modified files, and 2nd-order caller ripple impacts once in `## 6. Impact, Reusable Code & Dependencies` of `01-requirements.md` using `File:` and `Description:` sub-bullets under each component. Do not paste raw search dumps into the requirements document.

### Deep decision method

For each **consequential or ambiguous** design/technical choice, prepare a compact decision comparison:

- **Goal and constraints:** What must be true, and what limits the solution?
- **Viable options:** Usually 2–3 genuinely different choices, including reuse or simplification where appropriate. Fewer are fine if only one sensible option exists.
- **Trade-offs:** Explain the most important benefits, costs, user impact, implementation complexity, operational consequences, and failure modes.
- **Second-order effects:** Consider callers, data compatibility, permissions/tenancy, performance, testing, migration, support burden, rollback, and future changes as applicable.
- **Recommendation:** Name the best-supported option and why it wins against the strongest alternative.
- **Confidence/evidence:** State what was verified and what could change the recommendation.

Then challenge the leading option: identify at least one plausible counterexample or failure path. Do not create a long analysis for trivial, reversible choices. A decision summary must show the substance of the evaluation; merely listing options is not sufficient.

**Gate:** The relevant code path, existing conventions, callers, constraints, and meaningful simplification opportunities are understood well enough to ask focused questions.

## Step 3: Resolve Ambiguity with the User

Ask questions in dependency order: **start Q1 with high-level UX flow and simplification** (if Step 2 revealed duplicated screens/tabs, split settings, or a simpler user journey), then move to business rules and detailed constraints that depend on those choices.

### When to ask instead of assume

Ask the user before locking a requirement when multiple plausible interpretations would materially change:

- User-visible behavior or expected workflow.
- Business rules, calculations, statuses, or data ownership.
- Permissions, roles, tenant boundaries, privacy, or audit history.
- Creation, update, deletion, migration, retention, or irreversible changes.
- Compatibility, architecture, a costly dependency, or a substantial scope/timeline choice.

Do not make a consequential choice silently even if one option seems easier to implement. Present the missing decision, why it matters, 2–3 credible options with their key consequence, and your recommendation. Ask one focused question at a time, or at most two tightly related questions.

For a low-impact, reversible implementation detail with a clear established project convention, use the convention and mark the choice as an assumption only if necessary. Do not interrupt the user for every minor coding detail.

### Question format

Use a clean, scannable format in chat:

```markdown
❓ **Decision needed: <Concise Question Title>**
**Context:** <1–2 sentences of verified facts from codebase/UX research and the real uncertainty.>

1. **Option A:** <Summary + key benefit and trade-off>
2. **Option B:** <Summary + key benefit and trade-off>

➡️ **Recommendation:** <Best option + concrete reason why, worded so typing "yes" accepts it.>
```

Avoid asking the user to choose between implementation details that the agent can confidently resolve from project rules. Avoid presenting a recommendation as if it were already approved.

Update `01-requirements.md` immediately after each meaningful answer using scannable nested sub-bullets (`1 line = 1 atomic detail`). Record **Experience delta** in Section 1 using `Before:` and `After:` sub-bullets under each dimension (never single-line arrows). Replace superseded statements in place, preserve stable IDs when meaning is unchanged, and mark any changed scope clearly. If the user's answer creates a new unresolved dependency, ask about that before proceeding.

### Required coverage, when relevant

Check the feature against the five lenses below and translate applicable items directly into `REQ-X`, `AC-X.Y`, or `BR-X` rules. Record only the cases applicable to the feature, but do not skip a lens merely because it is inconvenient:

1. **Empty / first-time state:** No records, no setup, initial use.
2. **Validation / failure / offline:** Invalid input, permission denial, network or service failure, recovery and retry.
3. **Permissions / roles / tenancy:** Who can view or change each resource; tenant isolation and unauthorized access.
4. **Concurrency / idempotency:** Double-submit, duplicate requests, stale data, race conditions, retries.
5. **Data lifecycle / side effects:** Create/update/delete, derived state, linked records, audit history, indexes/rules/schema, migrations and rollback when relevant.

For a bug fix or refactor, establish the actual root cause and capture `Current behavior`, `Expected behavior`, `Verified root cause`, and `Regression guardrail` in Section 1. Do not label an unverified hypothesis as the root cause.

**Gate:** All material user-owned decisions are answered or explicitly held as blockers. Research items that are not necessary to this scope may be deferred with a reason; do not claim there are no open questions if a consequential decision remains unresolved.

## Step 4: Consolidate Scope and Specification

Write `01-requirements.md` from [Requirements Template](../lifecycle/templates/01-requirements.md), organized into **Part 1 (Product & UX Specification)** and **Part 2 (Technical & Agent Reference)**:

- Start with the **Quick read** summary and Section 1 (`Problem, Outcome & User Flow`) so the reader understands the feature in about 30 seconds, using `Before:` and `After:` sub-bullets under `Experience delta`.
- Give each required behavior a stable `REQ-X` ID and each independently testable criterion an `AC-X.Y` ID in Section 2.
- Put non-negotiable business, permission, lifecycle, concurrency, and data-integrity constraints in crisp 1-line `BR-X` rules in Section 3.
- Record consequential decisions in Section 5 with status (`Confirmed`, `Proposed`, or `Needs User Decision`), the chosen/recommended approach, key alternative(s), why the option wins, and material consequences/risks. Do not create a decision record for every routine coding choice.
- In Section 6 (`Impact, Reusable Code & Dependencies`), group code touchpoints into **Reusable Code (Use As-Is)**, **Affected Code (Direct Modifications)**, and **Caller Ripple Effects (2nd-Order Impact)**, showing `File:` and `Description:` as sub-bullets under each component. Keep implementation task breakdown in `03-roadmap.md` rather than duplicating a task plan here.
- Stage new or clarified module terms in Section 7 (`Glossary Updates`) and move distinct future capabilities into Section 8 (`Deferred Scope`). Deferred scope must be genuinely outside the approved outcome; never move essential validation, safety, permission behavior, error recovery, or necessary migration work to future scope merely to make the current plan shorter.
- Keep Section 9 (`Open Questions & Research`) visible throughout the lifecycle (showing `*(None - all resolved)*` when empty) and distinguish **confirmed facts**, **user decisions**, **assumptions**, and **unresolved questions** when that distinction affects implementation.

Keep each requirement and acceptance criterion clear enough that two people could independently agree whether it passes. Do not duplicate detailed behavior in the overview and then repeat it verbatim in several other sections.

**Gate:** The specification is internally consistent, requirements have testable criteria, scope boundaries are clear, and material assumptions/questions are visible.

## Step 5: Exit Gate and Handoff

Check the artifact and evidence before requesting approval:

- [ ] The actual problem, desired outcome, and `Before:` / `After:` experience delta are stated clearly.
- [ ] End-to-end user journey was critiqued for simplicity and UX duplication.
- [ ] All callers of modified models/getters/routes were searched (`grep`) and recorded in Section 6 using `File:` and `Description:` sub-bullets.
- [ ] Applicable 5 lenses (empty state, validation/failure/offline, permissions/tenancy, concurrency/idempotency, data lifecycle) or bug root cause are covered.
- [ ] Consequential decisions show real trade-offs and second-order consequences, not just an option list.
- [ ] User-owned decisions are approved or explicitly marked as blockers; assumptions are labelled.
- [ ] Requirements and constraints use scannable sub-bullets (`1 line = 1 atomic detail`) with zero internal contradictions or duplicate lists.
- [ ] Open Questions & Research in Section 9 are resolved (or explicitly flagged if blocking).

Then:

1. Record meaningful process friction in `lifecycle/04-refine.md`.
2. Update the Resume Checkpoint in `lifecycle/00-status.md` and set Brainstorm to `In Review`.
3. Give a concise summary in chat (no chat tables): problem/outcome, key recommendation or decision, material risk/open decision, and link to `lifecycle/01-requirements.md`.
4. Recommend Prototype for non-trivial user-facing screen or workflow changes. Recommend `Skipped` only for minor, clearly patterned UI edits or strictly non-visual work, with a one-line reason.
5. Stop for user approval. After approval, set Brainstorm to `Done` (and Prototype to `Skipped` if accepted) in `00-status.md`, read [`lifecycle-prototype/SKILL.md`](../lifecycle-prototype/SKILL.md) (or [`lifecycle-roadmap/SKILL.md`](../lifecycle-roadmap/SKILL.md) if skipped), and auto-advance.
