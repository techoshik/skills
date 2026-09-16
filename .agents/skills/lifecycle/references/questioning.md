# Questioning and Decision Discovery

## Purpose

Use questions to remove consequential uncertainty, not to satisfy a fixed
question count. A request that sounds clear still receives a structured pass.

## Rules

- Ask as many rounds as the decision tree requires; there is no three-question
  limit.
- Ask the user for decisions, preferences, authority, priorities, and
  acceptance. Find facts yourself through the repository, tools, and available
  documentation.
- Ask all independent questions in the current **frontier** together. Wait for
  the answers, then recompute the frontier before asking the next round.
- Give a recommendation and the consequence of each meaningful choice.
- Do not silently answer a question whose answer could change value, scope,
  behaviour, architecture, sequencing, or acceptance.
- Record unresolved questions as assumptions, risks, or blockers. An explicit
  accepted risk is different from an unanswered question.
- `auto` skips routine phase-approval prompts; it does not authorize guessing
  through a consequential unanswered question.

## Round Protocol

1. Name the destination and minimum outcome before exploring alternatives.
2. Build a decision tree from the current phase's questions and the request.
3. Mark each node as **known**, **verified**, **user decision**, or
   **unresolved**.
4. Ask the whole current frontier of user decisions in one numbered round.
   Number the questions, give a recommendation and consequence for each
   meaningful choice, and wait before asking dependent questions.
5. Record the answers and update the tree before proceeding. Never answer a
   human-in-the-loop question on the user's behalf.
6. Stop questioning only when every consequential branch is resolved,
   explicitly accepted as an assumption/risk, or returned to its owning phase.

If no user question is needed, record why the requirement is sufficiently
defined and list the assumptions and evidence that support proceeding.

## Phase Ownership

- **Define** owns problem, users, value, priority, scope, business rules,
  constraints, and observable success.
- **Context** owns verified facts about the existing product, module, code,
  dependencies, conventions, and limitations. Ask the user only when a fact
  requires human authority or a product decision.
- **Shape** owns experience, domain concepts, states, alternatives, and
  solution-level assumptions.
- **Plan** owns implementation sequencing, slice boundaries, dependencies,
  reuse, rollout, and proof.
- **Build** owns slice-level implementation uncertainty; **Verify** owns
  acceptance and regression evidence. Neither silently repairs an earlier
  unanswered decision.

## Specialist Routing

- Use `grill-with-docs` for every non-trivial change: it combines deep
  human-in-the-loop grilling with domain modeling, so use it to sharpen terms,
  expose boundaries, and stress-test concrete scenarios.
- Use `wayfinder` when the decision tree is large or foggy: name the
  destination, explore the current frontier breadth-first, and bring its
  decisions back into the lifecycle artifacts. If the route is clear and can
  be resolved in one session, do not create a separate map.
- If a specialist is unavailable, follow this protocol directly.
