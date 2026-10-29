# Development Lifecycle Skills

A portable, agentic development system for engineering teams and AI agents, driving features through a disciplined 6-phase sequential pipeline orchestrated by `lifecycle`: **Brainstorm → Prototype → Roadmap → Execute → Review → Finalize**.

| Phase               | Skill                  | Responsibility                                                                                                 |
| :------------------ | :--------------------- | :------------------------------------------------------------------------------------------------------------- |
| **0. Orchestrator** | `lifecycle`            | Master router, status dashboard (`00-status.md`), entry gates, and crash resumption                            |
| **1. Brainstorm**   | `lifecycle-brainstorm` | Elite researcher persona: root "why", 2nd-order ripple effects, 5-lens gap hunting (`01-requirements.md`)      |
| **2. Prototype**    | `lifecycle-prototype`  | 3 divergent UI variants with 5 state toggles + Mermaid flow diagrams (`02-prototype.html`)                     |
| **3. Roadmap**      | `lifecycle-roadmap`    | Small vertical slices (~2–5 files/task), 5-part task anatomy, binary verification oracles (`03-roadmap.md`)    |
| **4. Execute**      | `lifecycle-execute`    | Single-task execution, worker sub-agent delegation, mandatory 5-gate self-review                               |
| **5. Review**       | `lifecycle-review`     | Full-branch audit (AC, integration seams, guidelines, security, two-tier deduplication)                        |
| **6. Finalize**     | `lifecycle-finalize`   | Permanent doc sync (`docs/modules/`, `GLOSSARY.md`), dual-target rule/skill evolution, PR summary, cleanup     |

Explicit human approval is required after every phase and after every completed Execute task.

## Reading without waste

Start at `lifecycle/SKILL.md`. Check `lifecycle/00-status.md` first and load **only** the active phase's `SKILL.md` (never load all skills into context at once).

## Install or update

```bash
./install-lifecycle.sh /path/to/project
./install-lifecycle.sh --projects-file /path/to/projects-file
./install-lifecycle.sh .
```

No arguments use ignored `.lifecycle-projects` at the installer root. See `.lifecycle-projects.example`: one path per line, blank/comment lines ignored, relative paths based on the list directory. Missing project directories are skipped and never created.

PowerShell equivalents:

```powershell
.\install-lifecycle.ps1 C:\path\to\project
.\install-lifecycle.ps1 -ProjectsFile C:\path\to\projects-file
```

Run the installer again after updating this repository. `VERSION` and Git tags identify releases.

## Ownership and preservation

Installers replace managed `lifecycle*` skill directories containing `SKILL.md`, manage marked Lifecycle rule sections in `.agents/rules/`, and update the marked Lifecycle block in `AGENTS.md`. Unrelated skills and text outside managed sections remain intact. Manually edited rule sections are preserved and reported for review.

During work, tracking files (`00-status.md`, `01-requirements.md`, `02-prototype.html`, `03-roadmap.md`, `04-refine.md`) are kept in a temporary `lifecycle/` directory at the project root. Upon completing Finalize, permanent documentation is updated in the project files, and the temporary tracking directory is confirmed for deletion or archiving before your manual git commit.
