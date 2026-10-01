# Model coordination

## Roles

- Main coordinator: `gpt-6.1-sol`; owns discovery, lifecycle documents, approvals, scope, and Finalize assessment.
- Approved Build implementation: `gpt-6-luna` worker.
- Focused review: separate read-only `gpt-6-luna` worker after implementation finishes.
- Defined verification or Finalize inspections may be delegated to Luna; the coordinator assesses the returned evidence.
- User retains approval and explicit gap acceptance. Explicit user model overrides take precedence.

## Main chat

Select GPT-6.1 Sol before starting/resuming coordinator work. Skills cannot switch their chat model. Check runtime identity when available; explain a mismatch before coordinator work. Disclose unavailable identity verification without claiming a switch. Assigned workers retain their worker model.

## Delegation

When model-selectable subagents are available, delegate the current approved step and its subsequent review. With `collaboration.spawn_agent`, use `model: gpt-6-luna`, `fork_turns: none`, and explicit minimal context:

- Workspace, editing scope, existing work to preserve, and applicable instructions/guidelines/module docs.
- Approved step's Specification, Build, Verify, and Test Now sources.
- Required preflight, behavioral TDD, actual verification results, evidence, and unresolved gaps.

Keep one writer for overlapping files. Workers return consequential choices to the coordinator; they cannot approve work, start future steps, or recursively delegate this responsibility.

Give the separate reviewer the final diff scope, approved requirements, project standards, and [review procedure](code-review.md). Resolve in-scope findings and rerun affected checks. The coordinator inspects the returned diff and evidence before recording results.

Finalize reconciliation and completion assessment remain with the coordinator.

## Unavailable capability

If required model selection/delegation is unavailable, explain it and offer manual selection or an explicitly user-approved fallback. Keep work ready to resume. Do not silently substitute models or create a user-owned chat as a workaround.
