<!-- lifecycle:start -->

## Context Efficiency

- Reuse files and instructions already read in this conversation.
- Reload only when files changed or the required details are unavailable.
- Prefer targeted searches and line ranges over full-file reads.
- Preserve the read-file list and key findings when summarizing context.
- Keep command output concise; show detailed output only for relevant failures.

## Development Lifecycle (DOER)

For module, feature, fix, and product-development work, read `.agents/skills/lifecycle/SKILL.md` and follow its required reading and phase routing (Define → Outline → Execute → Refine). 

Stop after every phase and completed Execute Checkpoint for explicit user approval. The user owns priority and approval; Lifecycle owns process.

Project sources: `.agents/guidelines/` for engineering standards and architecture rules. Active cycle tracking files belong in the temporary `lifecycle` directory and are deleted upon refinement.

<!-- lifecycle:end -->
