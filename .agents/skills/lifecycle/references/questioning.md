# Questioning and Decision Discovery

## Purpose

- Use questions to remove consequential uncertainty.
- Do not ask questions merely to fill a template.

## Rules

- Ask as many rounds as the decision tree requires.
- Ask independent questions in the current frontier together.
- Recompute the frontier after each answer.
- Ask the user for:
  - product decisions;
  - priorities;
  - preferences;
  - authority;
  - acceptance.
- Find repository/system facts yourself.
- Do not silently answer anything that can materially change value, scope, behaviour, architecture, sequencing, or acceptance.
- Give a recommendation when a meaningful choice needs one.
- Preserve unresolved consequential uncertainty instead of inventing an answer.

## Recording Rule

> **Discovery depth and artifact size are independent.**

- Do not copy interview history into phase artifacts.
- Record only:
  - the final decision;
  - accepted assumptions or risks;
  - unresolved consequential items;
  - information the next phase needs.

Use the lifecycle uncertainty types:

- **Assumption**
- **Question**
- **Research**
- **Blocker**

When known, assign the earliest owning phase with `Resolve: <phase>`.

## `grill-with-docs`

- Use by default during Define for non-trivial requirement discovery.
- Later phases use it only when a genuinely new requirement/domain decision needs grilling.
- Do not rerun general requirement discovery in every phase.

## Decision Boundary

- If a later phase discovers a requirement ambiguity, route it to Define.
- If it discovers a fact gap, route it to Context.
- If it discovers solution uncertainty, route it to Shape.
- If it discovers implementation/slicing uncertainty, route it to Plan.
