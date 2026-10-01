# Development Lifecycle Skills

A portable development system: **Idea → Prototype → Plan → Build → Finalize**.

| Phase | Responsibility |
| --- | --- |
| Idea | Need, minimum scope, observable success |
| Prototype | Concrete evidence for uncertainty, or justified Not needed |
| Plan | Small runnable steps with Specification, Build, Verify |
| Build | One authorized step, immediate testing, review, actual evidence |
| Finalize | Full-branch reconciliation, verification, permanent truth, closure |

Explicit approval is required after each phase and completed Build Step. [Framework](.agents/skills/lifecycle/references/framework.md) owns the exact approval/ownership contract; [Model Coordination](.agents/skills/lifecycle/references/models.md) owns Sol/Luna roles and unavailable-capability handling.

## Reading without waste

Start at [lifecycle/SKILL.md](.agents/skills/lifecycle/SKILL.md). Each phase entry requires the shared contract, model roles, writing rules, and its own procedure. Procedures point to required and conditionally triggered references. Reuse unchanged sources already read; load all applicable project rules. Finalize deliberately reads complete intent and branch changes.

Each rule has one reference owner. Templates shape artifacts without duplicating procedures. External companion skills are not required.

## Install or update

```bash
./install-lifecycle.sh /path/to/project
./install-lifecycle.sh --projects-file /path/to/projects-file
./install-lifecycle.sh .
```

No arguments use ignored `.lifecycle-projects` at the installer root. See [.lifecycle-projects.example](.lifecycle-projects.example): one path per line, blank/comment lines ignored, relative paths based on the list directory. Missing project directories are skipped and never created.

PowerShell equivalents:

```powershell
.\install-lifecycle.ps1 C:\path\to\project
.\install-lifecycle.ps1 -ProjectsFile C:\path\to\projects-file
```

Run the installer again after updating this repository. `VERSION` and Git tags identify releases.

## Ownership and preservation

Installers replace managed `lifecycle*` skill directories containing `SKILL.md`, update only the marked Lifecycle block in `AGENTS.md`, and ensure `docs/lifecycle`, `docs/guidelines`, `docs/modules`, and `docs/backlog` exist. Self-install preserves source skills. Unrelated skills and project-owned content remain intact; malformed managed markers are rejected before target changes.

During work, create index/phase/Cycle Log artifacts under `docs/lifecycle/<change>/` using the included templates; add prototype assets only when useful. Permanent product, user, engineering, and process knowledge goes to its authoritative owner during Finalize. Archive/remove a completed cycle workspace only after explicit confirmation. Installation does not generate or migrate project knowledge, active work, or technology-specific rules.
