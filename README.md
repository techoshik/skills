# Development Lifecycle

This repository contains reusable Lifecycle skills and installers that make a
project Lifecycle-ready without overwriting its product knowledge.

## Install into a project

From this repository:

```bash
./install-lifecycle.sh /path/to/project
```

If the repository itself is the target project:

```bash
./install-lifecycle.sh
```

On Windows PowerShell:

```powershell
.\install-lifecycle.ps1 C:\path\to\project
```

The installer is idempotent. It:

- copies only directories named `lifecycle*` that contain `SKILL.md`;
- creates `.agents/skills/` and the Lifecycle documentation directories,
  including `docs/guidelines/`;
- creates or updates only the marked Lifecycle section in `AGENTS.md`.

It leaves unrelated skills, project documentation, `CONTEXT.md`, engineering
guidelines, module content, backlog content, and active lifecycle work alone.

The installer supports both the current `.agents/skills/` repository layout
and a future top-level `skills/` layout.

## Project-owned files

The installer manages only the reusable system pieces:

```text
project/
├── .agents/skills/lifecycle*/
├── docs/lifecycle/
├── docs/guidelines/
├── docs/modules/
├── docs/backlog/
└── AGENTS.md  # only the marked Lifecycle block
```

The project owns the contents created during actual development. The installer
does not generate guideline files, generic context, module documents, backlog
items, or active cycle artifacts.

Before Build and Verify, the Lifecycle skills discover and load every
applicable guideline from `docs/guidelines/`. The installer does not guess
which technologies a project uses and does not create files such as
`flutter.md`, `react.md`, or `cloud-functions.md`.

## Updating

Pull a newer repository version and run the installer again:

```bash
git pull --ff-only
./install-lifecycle.sh /path/to/project
```

Use `VERSION` and Git tags to identify stable releases:

```bash
git tag v1.0.0
git push origin v1.0.0
```
