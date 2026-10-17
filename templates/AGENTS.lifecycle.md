<!-- lifecycle:start -->

## Production Safety

Production access or deployment requires explicit user authorization.

Use emulators/development environments for automated testing.

## Direct Firebase Client SDK First (Hard Invariant)

Always prefer direct Firebase Client SDK (Firestore, Storage) operations backed by robust, fail-closed Firestore Security Rules. Do not create or route through Cloud Functions for standard get/set/update/delete operations. Cloud Functions are strictly reserved for centralized atomic sequence counters (e.g. sequential document or record numbering), private secrets/external APIs, cross-collection snapshot freezing, and system triggers. See details in [.agents/rules/architecture_common.md](.agents/rules/architecture_common.md#direct-firebase-client-sdk-first-cloud-functions-strictly-on-exception).

## Required Architectural Rules Review

All rules in `.agents/rules/` are **mandatory system invariants**, NOT optional suggestions. For every code change and at every checkpoint, verify compliance against `.agents/rules/` and complete the [pre-handoff review](.agents/rules/architecture_common.md#pre-handoff-review) before declaring work ready for human review.

## Context Efficiency

- Reuse files and instructions already read in this conversation.
- Reload only when files changed or the required details are unavailable.
- Prefer targeted searches and line ranges over full-file reads.
- Preserve the read-file list and key findings when summarizing context.
- Keep command output concise; show detailed output only for relevant failures.

## Development Lifecycle (DOER)

For module, feature, fix, and product-development work, read `.agents/skills/lifecycle/SKILL.md` and follow its required reading and phase routing (Define → Outline → Execute → Refine). 

Stop after every phase and completed Execute Checkpoint for explicit user approval. The user owns priority and approval; Lifecycle owns process.

Project sources: `.agents/rules/` for engineering standards and architecture rules. Active cycle tracking files belong in the temporary `lifecycle` directory and are deleted upon refinement.

<!-- lifecycle:end -->
