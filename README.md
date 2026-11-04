# Development Lifecycle Skills

A portable, agentic development system for engineering teams and AI agents, driving features through a disciplined 5-phase sequential pipeline orchestrated by `lifecycle`: **Discover → Flows → Plan → Build → Finalize**.

| Phase | Skill | Responsibility | Live Artifact |
| :--- | :--- | :--- | :--- |
| **0. Orchestrator** | `lifecycle` | Master router, status dashboard, cross-phase friction log, Git safety boundary | `lifecycle/00-status.md`<br>`lifecycle/04-refine.md` |
| **1. Discover** | `lifecycle-discover` | Evidence-based problem investigation (`grep`/logs), target features, boundaries, decisions | `lifecycle/01-discover.md` |
| **2. Flows** | `lifecycle-flows` | Visual sequences/diffs (Mermaid), Modular Prototype Hub (`02-prototype.html` + `prototype/`), state switcher | `lifecycle/02-flows.md` |
| **3. Plan** | `lifecycle-plan` | Feature-driven task breakdown, assigned Rule Files, prefactoring check (900/1000 lines), two-tier verification | `lifecycle/03-plan.md` |
| **4. Build** | `lifecycle-build` | Execution modes (Task vs. Feature), instruction re-anchoring, caller inspection, diff hygiene, honest evidence | *(Checked tasks in `03-plan.md`)* |
| **5. Finalize** | `lifecycle-finalize` | Integrated audit, orphaned symbols check, smart deduplication, permanent doc sync (`docs/`), PR summary, cleanup | `docs/modules/` |

---

## Core Operational Invariants

- **Context Hygiene:** Start at `lifecycle/00-status.md`. Load **only** the active phase's skill into the context window (never load all skills simultaneously).
- **Human-First Approval Protocol:** Every phase exit gate and Phase 4 implementation task/feature stops at `In Review` in `lifecycle/00-status.md`. The agent outputs a concise 1–2 sentence summary linking the deliverable (with concrete user verification steps during Build) and asks for explicit approval to advance. **Silence is never approval.**
- **Non-Negotiable Git Safety Boundary:** The agent executes **read-only** Git commands (`git status`, `git diff`, `git log`). **NEVER** run mutating Git commands (`git commit`, `git push`, `git checkout`, `git reset`, `git restore`, `git branch`). All commits, pushes, and branch changes belong exclusively to the human developer.
- **No Persistent Watchers or Daemons:** Never launch persistent background dev servers, watchers, or daemon processes without explicit user direction.
- **Mid-Flight Scope Pivot Protocol:** If requirements pivot mid-flight, pause coding immediately, update upstream specifications in place (`01-discover.md`, `02-flows.md`, or `03-plan.md`), check `git status` for discarded code, and realign `lifecycle/00-status.md` before writing new code.
- **Cross-Phase Friction Log:** Never edit `.agents/skills/` directly in consumer projects. Any active phase logs workflow friction, instruction ambiguity, or rule improvements into `lifecycle/04-refine.md` to be reviewed in Phase 5 and refined centrally in this repository.

---

## Installation & Updates

To install or update the Lifecycle system into target projects:

### Bash / macOS / Linux
```bash
./install-lifecycle.sh /path/to/project
./install-lifecycle.sh --projects-file /path/to/projects-file
./install-lifecycle.sh .
```

*Running with no arguments uses the ignored `.lifecycle-projects` file at the repository root (one project path per line).*

### PowerShell / Windows
```powershell
.\install-lifecycle.ps1 C:\path\to\project
.\install-lifecycle.ps1 -ProjectsFile C:\path\to\projects-file
```

---

## Ownership & Artifact Lifecycle

- **Managed Sections:** Installers replace managed `lifecycle*` skill directories containing `SKILL.md`, manage marked Lifecycle rule sections in `.agents/rules/`, and update the marked block in consumer `AGENTS.md` files. Unrelated skills and text outside managed markers remain untouched.
- **Temporary Lifecycle Directory:** During active development, tracking files (`00-status.md`, `01-discover.md`, `02-flows.md`, `03-plan.md`, `04-refine.md`) reside in a temporary `lifecycle/` directory at the project root.
- **Permanent Knowledge & Cleanup Gate:** Upon completing Finalize, durable architecture and workflows are synchronized into permanent project documentation (`docs/modules/<module>/README.md`, `feature_<name>.md`). The agent stops at the **Artifact Cleanup Gate**, allowing the user to explicitly choose whether to **Delete**, **Archive**, or **Keep** the temporary `lifecycle/` directory before manual Git commit.
