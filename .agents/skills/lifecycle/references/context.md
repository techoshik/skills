# Lifecycle — Context

## 1. Purpose

- Give the AI the **minimum sufficient understanding of the existing system** required to make correct decisions.
- Help the AI extend the existing product instead of inventing parallel patterns, rules, or architecture.
- Context exists for **decision quality**, not documentation completeness.

> **Give the AI what it needs to know — no more, no less.**

## 2. Inputs

- **Approved Define Output** — Finalized module or feature definition.
- **Canonical Module Documentation** — The existing `docs/modules/<module>.md` for each affected module, when present.
- **Global Product Context** — Existing product, architecture, stack, conventions, and shared rules.
- **Module Context** — Existing module purpose, boundaries, domain, rules, and dependencies.
- **Existing Implementation** — Relevant code, models, APIs, components, tests, configurations, and schemas.
- **Previous Decisions** — Architectural, product, or technical decisions affecting the work.
- **Known Limitations** — Existing constraints, compatibility requirements, and known problems.
- **Verification Landscape** — Existing test levels, harnesses, fixtures, real boundaries, environment constraints, and known flakiness.

## 3. Rules

- **Every line must earn its place** — Remove anything that does not improve understanding or decision quality.
- **Minimum sufficient context** — Never dump the entire codebase/documentation just because it is available.
- **Specific over vague** — Prefer concrete rules, files, flows, constraints, and examples.
- **Facts over assumptions** — Mark uncertainty clearly.
- **Current over stale** — Remove/correct outdated context.
- **Relevant over complete** — Context is not an encyclopedia.
- **Group by system boundary** — Use bold top-level bullets for Global, Module, Feature, and Gap topics; nest supporting files, rules, and evidence beneath them.
- **Selective output** — The context categories are a decision aid, not a checklist; omit fields that do not affect the current solution.
- **Reference over duplication** — Do not repeat stable Global/Module knowledge in every feature.
- **Read the canonical module document**:
  - Identify each affected module for every bug fix, existing-functionality change, or new functionality.
  - Read its existing `docs/modules/<module>.md` before shaping or editing code.
  - Record missing documents as context gaps.
- **Do not invent missing information** — Surface the gap.
- **Do not turn context into requirements** — Context explains the existing system; Define controls what we are building.
- **Validate Define against reality** — If system facts contradict approved problem, scope, rules, constraints, or success criteria, return to Define.
- **Do not create new patterns unnecessarily** — Prefer existing proven patterns unless there is a clear reason to change them.

> **Context should reduce uncertainty, not increase information volume.**

## 4. Questions

- Ask these as concrete prompts and investigate facts yourself:

### Global

- Which product capability and system boundaries are relevant?
- Which architecture, technology, conventions, and shared rules apply?
- Which reusable building blocks already support this work?

### Module

- What is the module's purpose and boundary?
- Which domain concepts, shared rules, flows, and existing features matter?
- Which dependencies and integration points can constrain the solution?

### Feature

- How does the current behaviour work, and which code, data, tests, and rules implement it?
- Which areas, dependencies, history, limitations, or previous decisions are relevant?
- What is still unknown, and does the discovered system remain consistent with Define?

## 5. Actions

- Gather context in three layers: **Global → Module → Feature**.
- Inspect the **real implementation** where necessary instead of relying only on summaries.
- Identify the smallest set of files, rules, models, flows, and decisions relevant to the work.
- Inspect existing automated coverage and the available real verification boundary before recommending module integration or E2E work.
- Remove irrelevant, duplicated, vague, stale, or speculative information.
- Separate verified facts from assumptions.
- Surface conflicts or missing information instead of silently resolving them.
- Compare finalized Define output against discovered Context.
- If Context is incomplete or contradictory, stay in Context until resolved or explicitly recorded.
- If Context invalidates approved problem/value/scope/rules/constraints/success criteria, return to Define.
- Reference stable context instead of copying repeatedly.
- Keep context gaps visible before moving forward.
- Use specialist **research** when an external/technical fact needs investigation.
- Use **domain-modeling** when terminology/domain understanding is the source of uncertainty.

## 6. Output

### Decision Summary

- **Decision / Result:** Context complete / Context gap.
- **Status:** Complete / Blocked.
- **Blockers:** …
- **Next Action:** …

### Global Context

- **Product**
  - Product and system boundaries.
- **Platforms**
  - Supported platforms and environments.
- **Architecture**
  - Architecture and technology.
- **Entry points**
  - Bootstrap and relevant entry points.
- **Shared rules**
  - Engineering conventions and reusable components.
- **Constraints**
  - System-wide limits and technical constraints.
- **Evidence**
  - Files, commands, or external sources supporting the context.

### Module Context

- **Purpose**
  - Purpose and domain.
- **Boundary**
  - Module boundaries.
- **Existing behavior**
  - Existing features and module flow.
- **Rules**
  - Shared business rules and limitations.
- **Dependencies**
  - Dependencies.
- **Integrations**
  - Integration points.
- **Canonical documentation**
  - Module document path, or an explicit missing-document gap.

### Feature Context

- **Current behavior**
  - Current user/system behavior and relevant flows.
- **Implementation**
  - Relevant code and rules.
- **Data**
  - Relevant models, data, and existing tests.
- **Affected areas**
  - Files, dependencies, integrations, permissions, and verification landscape.
- **Gaps**
  - Unknowns, limitations, previous decisions, and open questions.
- **Mismatches**
  - Define mismatches.

### Exit

- **Exit Status:** Pass / Blocked.
- **Evidence:** …
- **Remaining Blockers:** …
- **Next Phase:** Shape.

- Not every field must be filled. Include it only when it helps current work.

## 7. Exit

- Move to **Shape** only when:

  - The AI understands how the relevant part of the existing system works.
  - Required Global, Module, and Feature context is available.
  - Important boundaries, rules, dependencies, data, and affected areas are understood.
  - Relevant existing implementation has been identified.
  - Critical context gaps/contradictions are resolved or explicitly recorded.
  - Define is still valid; otherwise return to Define.
  - Unnecessary context has been removed.
  - **Cycle Log Check** has been performed.
  - The AI can honestly say:

> **I understand the existing system well enough to shape the smallest correct solution without inventing assumptions or unnecessary architecture.**
