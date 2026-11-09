<!-- lifecycle:start -->
## Development Lifecycle & Architecture Rules

- **Lifecycle Workflow:** For all module, feature, bugfix, refactor, and architecture work, inspect `lifecycle/00-status.md` and follow the 5-phase sequential pipeline orchestrated by [`.agents/skills/lifecycle/SKILL.md`](.agents/skills/lifecycle/SKILL.md): **`Discover → Design → Plan → Build → Close`**.
- **Context Hygiene:** Load **only** the active phase's skill file into context (`lifecycle-discover`, `lifecycle-design`, `lifecycle-plan`, `lifecycle-build`, `lifecycle-close`). Never load all skills simultaneously.
- **Human-First Approval Protocol:** Every phase exit gate and build task stops at `In Review` in `lifecycle/00-status.md` for explicit user approval via a concise 1–2 sentence chat summary linking the deliverable. Silence is never approval.
- **Universal Safety Boundaries:**
  - **Read-Only Git:** The Agent is permitted to execute only read-only Git commands (`git status`, `git diff`, `git log`). **NEVER** run mutating Git commands (`git commit`, `git push`, `git checkout`, `git reset`, `git restore`, `git branch`). All commits, pushes, and branch changes belong exclusively to the user.
  - **No Persistent Watchers or Daemons:** Never launch persistent background dev servers, file watchers, or daemon code generators without explicit user direction.
  - **Cross-Phase Friction Log:** Never edit `.agents/skills/` directly in consumer projects; any active phase logs friction and rule improvements into `lifecycle/refine.md`.
- **Mandatory Architecture Invariants:** All rule files in [`.agents/rules/`](.agents/rules/) are strict, non-negotiable system invariants. Verify compliance on every task before requesting review.
<!-- lifecycle:end -->
