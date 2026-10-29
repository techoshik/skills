<!-- lifecycle:start -->
## Development Lifecycle & Architecture Rules

- **Lifecycle Workflow:** For all module, feature, fix, and refactor work, read [`.agents/skills/lifecycle/SKILL.md`](.agents/skills/lifecycle/SKILL.md) and follow its 6-phase routing (`Brainstorm → Prototype → Roadmap → Execute → Review → Finalize`) tracked in `lifecycle/00-status.md`. Stop at every `In Review` gate for explicit user approval.
- **Mandatory Architecture Invariants:** All files in [`.agents/rules/`](.agents/rules/) are strict, non-negotiable system invariants. Verify compliance on every change before requesting review.
- **Safety Boundaries:** Never run `git add`, `git commit`, `git reset`, `git restore`, long-running watchers, or production deployments without explicit user authorization.
<!-- lifecycle:end -->
