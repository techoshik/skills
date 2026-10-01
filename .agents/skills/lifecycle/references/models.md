# Model Coordination

## Roles

- **Coordinator:** `gpt-6.1-sol`.
- **Idea, Prototype, Plan:** Coordinator owns discovery and decisions.
- **Build:** `gpt-6-luna` implements the approved step.
- **Focused code review:** A separate `gpt-6-luna` worker reviews the resulting diff.
- **Finalize:** Coordinator owns reconciliation and completion assessment.
- **Defined verification runs:** Coordinator may delegate execution to Luna.

The coordinator retains ownership of lifecycle documents, approvals, and scope decisions.

## Main Chat Selection

Select GPT-6.1 Sol in the main chat before starting or resuming Lifecycle.

A skill cannot switch its own chat model.

When runtime model identity is available, check it against the coordinator role.

If it differs, explain the required selection before doing coordinator work.

If identity is unavailable, disclose that it cannot be verified.

Do not claim an automatic model switch occurred.

Explicit user overrides take precedence.

## Delegation

When model-selectable subagents are available:

- Spawn the implementer with `model: gpt-6-luna`.
- Use a minimal task context that permits an explicit model override.
- With `collaboration.spawn_agent`, use `fork_turns: none` and supply the context explicitly.
- Provide the workspace path and approved step's Specification, Build, and Verify sources.
- Provide applicable instruction, guideline, and module-document paths.
- Provide existing changes to preserve and the allowed editing scope.
- Require Preflight, TDD, and planned verification.
- Require actual results, evidence, and unresolved gaps in the worker's return.
- Keep one writer for overlapping files.
- Wait for implementation to finish before requesting review of its final diff.
- Spawn a separate Luna reviewer with read-only scope.
- Give the reviewer the exact diff scope, approved requirements, and standards sources.
- Require [Lifecycle Code Review](code-review.md).
- Resolve in-scope findings and rerun affected checks before presenting completion.

Workers must return consequential choices to the coordinator.

Workers must not approve phases, start future steps, or recursively delegate this same responsibility.

The coordinator checks the returned diff and evidence before recording results.

## Finalize

Sol reconciles the full branch, requirement coverage, review findings, and verification gaps.

Delegate only clearly defined checks or focused inspections to Luna.

Sol determines whether the evidence supports completion.

The user retains final approval and gap acceptance.

## Unavailable Capability

If Luna or model-selectable delegation is unavailable:

- Explain the missing capability.
- Offer manual model selection or an explicit user-approved fallback.
- Keep the approved work ready to resume.

Do not silently substitute a model or create a separate user-owned chat.

Model choice does not replace [Proof Limits](completeness.md#proof-limits).
