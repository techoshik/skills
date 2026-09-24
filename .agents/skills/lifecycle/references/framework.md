# Development Lifecycle Framework

## Governing Principle

> **Build the minimum necessary thing that creates meaningful value.**

- **Question**
  - Why is this necessary?
  - What real problem does it solve?
- **Value**
  - What meaningful benefit must exist when we finish?
- **Delete**
  - What can disappear without losing that value?
- **Simplify**
  - What is the smallest correct solution?
- **Scope**
  - Never add nice-to-have behaviour without approval.
- **Stop**
  - Stop when the approved outcome and proof are satisfied.

## Development Flow

1. **Define** — What must change and why?
2. **Context** — What existing reality matters?
3. **Shape** — What is the smallest correct solution?
4. **Plan** — What is the smallest runnable build sequence?
5. **Build** — Implement outside-in and keep the journey runnable.
6. **Verify** — Prove the complete promise and protect existing behaviour.
7. **Refine** — Move useful learning to its permanent home, then close the cycle.

> **Shape validates the solution. Plan organizes implementation. Build proves slices. Verify proves the promise.**

## Phase Frame

> **Decide → Work → Resolve**

Use this as the common mental structure for every phase. It is a thinking frame, not a requirement to rename phase-specific sections.

- **Decide**
  - State the phase result, status, blockers, and next step.
- **Work**
  - Record only the information owned by this phase.
- **Resolve**
  - Resolve, accept, or route anything that remains.
  - Omit the exception/open/issues group when nothing remains.

The seven phase names remain unchanged. Do not introduce an abbreviation for the lifecycle or this frame unless it clearly reduces cognitive load.

## Phase Questions

Each phase answers one question:

1. **Define** — What change is worth making and why?
2. **Context** — What existing reality must this change respect?
3. **Shape** — What is the smallest correct solution?
4. **Plan** — What is the safest runnable build sequence?
5. **Build** — Can we implement the current slice correctly and keep it runnable?
6. **Verify** — Does the completed change fulfil the original promise?
7. **Refine** — What should improve permanently because of what we learned?

Use the phase question as a delete test for artifact content.

## Working Depth vs Artifact Depth

> **Think deeply. Record only the decision.**

- Investigation, questioning, alternatives, repository reading, prototypes, and test exploration may be deep.
- Phase artifacts are compressed handoffs, not transcripts of the reasoning process.
- Record only information required for:
  - a decision;
  - the next phase;
  - verification;
  - an accepted risk;
  - future recovery.
- Do not copy question history, discarded exploration, or stable information already owned by a permanent source.

> **Artifact = handoff, not transcript.**

## Grouping Rule

> **Keep one concept in one place.**

- Keep related inputs, decisions, actions, risks, and evidence together.
- Do not scatter one concept across several sections and force the reader to reconnect it.
- Use a short title, then concise supporting bullets.
- When a topic becomes large, group it by responsibility instead of writing paragraphs.
- Reference stable sources instead of repeating them.

## Document Writing Rules

- **Zero cognitive load**
  - Optimize for scanning and decisions, not document beauty.
- **Short lines**
  - Prefer one clear idea per line.
- **Title → description**
  - Use headings or bold labels for the topic; place short supporting bullets beneath.
- **Use the shallowest useful hierarchy**
  - If a section contains one kind of information, use direct bullets.
  - If it contains several distinct groups, use short bold labels with nested bullets.
  - Never add a heading or label only to hold a list.
- **Decision first**
  - Put the answer before its explanation.
- **Every line earns its place**
  - Delete anything that does not change a decision, action, understanding, risk, or proof.
  - If a line does not help answer the current phase question, it probably does not belong in the artifact.
- **No forced completeness**
  - Templates are menus, not checklists.
  - Omit empty or irrelevant groups.
  - Never add `Not applicable` just to preserve a template.
- **Evidence beside the claim**
  - Put the file, command, observation, or proof next to what it supports.
- **Reference over duplication**
  - State stable knowledge once in its permanent source.
- **One gate**
  - Each phase artifact has one decision/status area near the top.
  - Do not repeat the same status in a second Exit section.
- **Actionable uncertainty**
  - Consequential unknowns must be classified and owned.
- **Clarity over compactness**
  - Split a group when combining items would hide different responsibilities.

## Diagram Use

- Use Mermaid for sequence, branching, state, dependency, or system-boundary relationships that are harder to scan in prose.
- Place the diagram beside the phase decision or journey it summarizes.
- Keep the diagram compact and give it one clear reading direction.
- Treat the surrounding bullets, evidence, and ownership fields as authoritative; the diagram is a navigation aid.
- Do not repeat the same diagram across phase artifacts. Reference the owning artifact when the flow is already documented elsewhere.
- Omit the diagram when a short list or table is clearer.

## Uncertainty Rule

> **Resolve only what the current phase owns. Carry the rest without guessing.**

Classify consequential uncertainty as:

- **Assumption**
  - We intentionally proceed as though it is true.
- **Question**
  - A decision or clarification is still needed.
- **Research**
  - Evidence must be gathered before deciding.
- **Blocker**
  - The current phase cannot pass until it is resolved.

When useful, record:

- the item;
- why it matters;
- `Resolve: <phase>`.

Do not record trivial unknowns that cannot change value, scope, solution, implementation, risk, or proof.

## Information Ownership

> **One fact, one owner.**

- Every requirement, fact, decision, plan, result, and lesson has one owning phase or permanent source.
- Later phases reference upstream information; they do not restate it unless a short reminder is required to understand the local decision.
- If upstream information is wrong or changes, route back to its owner and update the owning source.
- Do not create a second source of truth for convenience.

Ownership by phase:

- **Define** — value, requirement, scope, rules, success.
- **Context** — existing-system reality relevant to the change.
- **Shape** — chosen solution, flow, model, seams, proof level.
- **Plan** — build order, slices, slice journeys and proof.
- **Build** — implementation result, slice proof, conformance, deviations.
- **Verify** — whole-change acceptance and protection evidence.
- **Refine** — reusable learning and its permanent destination.

> **Reference; do not rewrite.**

## Loop-Back Ownership

| Problem | Owning phase |
| --- | --- |
| Requirement, value, scope, success | **Define** |
| Existing-system understanding | **Context** |
| Experience, domain, solution behaviour | **Shape** |
| Implementation approach, sequencing, slices | **Plan** |
| Implementation defect or code conformance | **Build** |
| Whole-solution acceptance evidence | **Verify** |
| Reusable learning or development-system improvement | **Refine** |

- A later phase must not silently repair an earlier mistake by inventing assumptions.
- Route the problem to its owner.

## Module and Feature

- **Module**
  - A group of related features serving a larger product capability.
- **Feature**
  - One specific user capability or behaviour inside a module.
- Shared business rules belong to the module.
- Feature-specific rules belong to the feature.
- Detailed solution/domain modelling belongs to Shape, not Define.

## State and Context Rules

- `docs/lifecycle/<change>/` is temporary active-change memory.
- `00-lifecycle.md` is the entry point and current-state index.
- Load only the artifacts required by the current phase.
- Conversation history is not the source of truth when lifecycle artifacts exist.
- Keep active lifecycle files versioned when multiple developers, branches, or chats need continuity.
- A solo developer may ignore `docs/lifecycle/` in Git if local persistence is enough.

## Permanent Knowledge

```text
docs/lifecycle/ = temporary change memory
docs/modules/   = permanent module knowledge, including deferred/future work
docs/guidelines/ = permanent engineering standards
cycle-log.md    = temporary process-improvement memory
codebase        = permanent implemented behaviour
skills repository = permanent lifecycle/process guidance
```

- Lifecycle files should normally be removable after the cycle.
- Before cleanup, Refine must move every useful lesson to its permanent home.
- `docs/modules/<module>.md` contains:
  - current module goal;
  - durable rules;
  - current feature responsibilities;
  - concise future/deferred work for that module.
- Future work in a module document is **not approved scope**.
- When selected, future work starts a new lifecycle at Define.
- Do not keep a separate permanent backlog inside temporary lifecycle files.

> **Temporary files help perform the change. Permanent sources preserve what matters after it.**

## Companion Skill Policy

- Companion skills are techniques, not policy.
- The lifecycle owns the process.
- Project Engineering Guidelines own project conventions.
- If a companion skill conflicts with either, the lifecycle/project rule wins.
