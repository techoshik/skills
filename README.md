# Development Lifecycle Skills

A portable development system based on the **DOER** framework: **Define → Outline → Execute → Refine**.

| Phase | Skill | Responsibility |
| --- | --- | --- |
| **D** — Define | `lifecycle-define` | Need, minimum scope, observable success, Expected Outcomes |
| **O** — Outline | `lifecycle-outline` | Granular architectural checkpoints (Models, UI, Logic) |
| **E** — Execute | `lifecycle-execute` | Implement one checkpoint, self-review, test, evidence, and human handoff |
| **R** — Refine | `lifecycle-refine` | Full-branch reconciliation, verification, permanent truth, cleanup |

Explicit human approval is required after every phase and completed Execute checkpoint.

## Reading without waste

Start at `lifecycle/SKILL.md`. Each phase entry contains its own constraints. Reuse unchanged sources already read; load all applicable project rules from `.agents/guidelines/`.

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

Installers replace managed `lifecycle*` skill directories containing `SKILL.md`, manage marked Lifecycle sections in `.agents/guidelines/`, and update the marked Lifecycle block in `AGENTS.md`. Unrelated skills and text outside managed sections remain intact. Manually edited guideline sections are preserved and reported for review.

During work, tracking files (`01-define.md`, `02-outline.md`, `friction_log.md`) are kept in a temporary `lifecycle` directory at the project root. These files act as the active context and checklist. Upon running Refine, the temporary tracking files are safely deleted and committed alongside the completed feature. Permanent product, engineering, and process knowledge is updated directly in the project files.
