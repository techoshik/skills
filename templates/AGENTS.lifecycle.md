<!-- lifecycle:start -->

## Context Efficiency

- Reuse files and instructions already read in this conversation.
- Reload only when files changed or the required details are unavailable.
- Prefer targeted searches and line ranges over full-file reads.
- Preserve the read-file list and key findings when summarizing context.
- Keep command output concise; show detailed output only for relevant failures.

## Development Lifecycle

For module, feature, fix, and product-development work, read `.agents/skills/lifecycle/SKILL.md` and follow its required reading and phase routing. Read the active `docs/lifecycle/<change>/00-lifecycle.md` before resuming.

For every document created or edited, follow `.agents/skills/lifecycle/references/artifacts.md`: short points, bold parent topics for related details, and the required compactness pass before presentation or handoff.

Stop after every phase and completed Build Step for explicit user approval. The user owns priority and approval; Lifecycle owns process.

Project sources: `docs/modules/` for current product truth, `docs/guidelines/` for engineering standards, support/user docs for user instructions, and `CONTEXT.md` for domain language when available. Active cycle files belong in `docs/lifecycle/`; commit for shared continuity or explicitly choose local-only storage when working alone.

<!-- lifecycle:end -->
