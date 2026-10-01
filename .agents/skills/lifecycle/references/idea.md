# Idea

Define the intended product change clearly enough for someone outside the conversation to understand it and recognize success.

## Required reading

Read [Decision Discovery](questioning.md). For a reported defect, also read [Diagnosis](diagnosis.md) to establish symptom and reproduction needs.

## Work

1. Inspect relevant product facts and discuss the need before narrowing scope.
2. Resolve hidden scenarios, contradictions, safeguards, and consequential assumptions through discovery.
3. Capture confirmed points continuously in `01-idea.md` using the sections below.
4. Tie minimum scope and exclusions to their reasons; replace superseded points.

Keep architecture, storage, APIs, file layout, and implementation steps for later phases. Resume from recorded decisions and unresolved questions.

## Section responsibilities

- **Problem / Opportunity:** Affected users, current difficulty, impact, and evidence or explicit assumption.
- **Goal:** Name who the change serves, what they should be able to do, and the essential scope boundary.
  - Make the intended change understandable from the Goal alone.
  - Keep backend mechanisms, testing strategy, and development-process promises in their owning sections/phases.
- **What Will Change:** Concrete product capabilities to add, modify, or remove.
  - State the proposed change and how it differs from current behavior when useful.
  - Describe product behavior, not files, APIs, or coding tasks.
- **Expected Outcomes:** Independently verifiable acceptance outcomes for the proposed changes.
  - Identify actor, relevant starting conditions, action/event, and expected observable result.
  - Include applicable denial, failure, preservation, and boundary outcomes.
  - For noninteractive changes, identify the relevant context/trigger and observable result without inventing an actor or false precision.
  - Split vague bundles such as “manage staff” into separately verifiable behaviors.
  - Use stable outcome labels so Plan and verification can link them.
- **Decisions:** Scope boundaries, exclusions, and accepted trade-offs with concise reasons.
- **Open Questions:** Consequential unresolved choices and prerequisites; omit when resolved.

What Will Change is the product-change summary; Expected Outcomes defines acceptance. Link an owning decision instead of repeating its complete rules. Plan adds exact setup, commands, implementation, and proof methods.

For existing cycles, treat Key Results as the earlier acceptance source. Preserve approved meanings, stable labels, and links when updating the heading; apply normal approval rules if behavior or scope changes.

## Complete when

- **Clear change:** Goal identifies users, capability, and essential boundary; What Will Change makes the proposed work concrete.
- **Verifiable success:** Every proposed change has Expected Outcomes that can be checked without inventing acceptance criteria.
- **Settled scope:** Minimum scope and safeguards have reasons; consequential assumptions have validation or acceptance decisions.
- **Resolved uncertainty:** No unanswered branch can materially change these points.

Finish the [phase handoff](framework.md#phase-handoff).
