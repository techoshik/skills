---
name: software-development-lifecycle
description: Shape a software idea collaboratively, create a concise lifecycle plan, guide implementation and verification, maintain delivery documentation, and observe production outcomes. Use for projects, modules, features, fixes, or unfinished software work. Do not deploy or access production systems or data without explicit authorization.
---

# Software Development Lifecycle

## Principles

- Start with discussion, not files or code.
- Treat the user's idea as input, not a final solution.
- Separate facts, assumptions, choices, and unknowns.
- Offer alternatives and a reasoned recommendation.
- Apply senior architectural judgment.
- Write so a new developer can act without material guessing.
- Prefer short bullets over long paragraphs.
- Keep every documentation sentence at 80 characters or fewer.
- Split longer ideas into short sentences or separate bullets.
- Do not use soft-wrapping to make a long sentence appear shorter.
- Preserve unrelated work and authorization boundaries.
- Require user approval before implementation.
- Require separate approval for deployment and production access.

## Workflow

### 1. Brainstorm

- Understand the problem, users, evidence, and constraints.
- Challenge the proposed solution when useful.
- Discuss material choices with the user.
- Read [planning.md](references/planning.md) completely.

### 2. Plan

- Create the plan in conversation first.
- Present it for user review.
- Save the approved plan under `docs/plans/`.
- Read [planning.md](references/planning.md) completely.
- Read [observation.md](references/observation.md) completely.
- Read [migrations.md](references/migrations.md) when the Goal may change data,
  contracts, configuration, permissions, or storage.
- Read [model-strategy.md](references/model-strategy.md) when assigning models.

### 3. Implement

- Work on one approved Step at a time.
- Read [luna-execution.md](references/luna-execution.md) completely.
- Before editing an existing feature, inspect the closest comparable completed
  implementations in the repository.
- State which existing pattern will be reused, or why a different pattern is
  required.
- When repairing review findings, distinguish a narrow safe repair from a
  required contract or architecture change before modifying code.
- For Flutter work, read
  [flutter-structure.md](references/flutter-structure.md) completely.
- For Cloud Functions work, read
  [cloud-functions-structure.md](references/cloud-functions-structure.md)
  completely.
- Read the Guidelines Check in
  [documentation.md](references/documentation.md) before folders or code change.

### 4. Verify

- Verify every Step and the complete Goal.
- Read [verification.md](references/verification.md) completely.
- Read [model-strategy.md](references/model-strategy.md) for escalation or final review.

### 5. Document

- Update required repository documentation.
- Read [documentation.md](references/documentation.md) completely.
- Read [migrations.md](references/migrations.md) for migration documents.

### 6. Release

- Complete documentation and final checks before branch merge.
- Read the Release section in [documentation.md](references/documentation.md).
- Read [migrations.md](references/migrations.md) when the release has migrations.
- Do not deploy without explicit approval.

### 7. Observe

- Treat production outcome observation as required lifecycle work.
- Begin after an authorized release.
- Read [observation.md](references/observation.md) completely.

## Core Invariants

- Keep one plan for one coherent Goal or change.
- Every Step must have one matching detailed record.
- Do not implement work that has no approved Step.
- Follow applicable repository instructions and guidelines.
- Record actual verification evidence.
- Working code is insufficient when its result does not match the Goal.
- Reopen work when verification finds a gap.
- Discuss material plan changes before continuing.
- Keep completed release documents unchanged.
- Suggest skill improvements from demonstrated use.
- Discuss and approve skill changes before editing this skill.
