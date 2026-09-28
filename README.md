# Development Lifecycle Skills

This repository contains reusable Lifecycle skills and installers. They make projects Lifecycle-ready without overwriting product knowledge.

Five phases:

> **Idea → Prototype → Plan → Build → Finalize**

## Responsibilities

- **Idea** — understand what we want and define observable success.
- **Prototype** — make uncertainty concrete when discussion is insufficient.
- **Plan** — inspect the system, specify the technical change, choose proof, and create reviewable Build Steps.
- **Build** — implement one approved Build Step at a time, follow project rules, and use TDD for testable behaviour.
- **Finalize** — verify, synchronize permanent truth, improve from real learning, clean, and close.

## Approval

Always stop after every phase and every Build Step. Present the result and wait for explicit user approval before continuing; never infer approval from silence.

## Active workspace

```text
docs/lifecycle/<change-name>/
├── 00-lifecycle.md
├── 01-idea.md
├── 02-prototype.md
├── 03-plan.md
├── 04-build.md
├── 05-finalize.md
├── cycle-log.md
└── prototype/          # optional
```

Lifecycle artifacts are compact working memory: one idea per line, short bullets and sentences, one fact per owner, and references instead of duplication. See `.agents/skills/lifecycle/references/artifacts.md` and `.agents/skills/lifecycle/references/framework.md`.

## Companion skills

Companion skills provide techniques; they do not replace Lifecycle ownership, approved artifacts, or project rules. The Lifecycle references map useful techniques to each phase, including `grilling`, `prototype`, `domain-modeling`, `research`, `codebase-design`, `tdd`, `diagnosing-bugs`, `code-review`, and `writing-for-agents`.

## Install into a project

From this repository:

```bash
./install-lifecycle.sh /path/to/project
```

To install into all projects listed in the ignored root file `.lifecycle-projects`, run without a project path:

```bash
./install-lifecycle.sh
```

Use [`.lifecycle-projects.example`](.lifecycle-projects.example) as the list-file format: one existing project path per line, with blank lines and `#` comments ignored. Relative paths resolve from the list file's directory.

An explicit list file is also supported:

```bash
./install-lifecycle.sh --projects-file /path/to/projects-file
```

Only existing listed project directories are processed. Missing entries are skipped with a warning and are never created. PowerShell uses `-ProjectsFile <path>`; no arguments use `.lifecycle-projects` at the installer root.

If the repository itself is the target project:

```bash
./install-lifecycle.sh .
```

On Windows PowerShell:

```powershell
.\install-lifecycle.ps1 C:\path\to\project
```

The installer is idempotent. It:

- copies only directories named `lifecycle*` that contain `SKILL.md`;
- creates `.agents/skills/` and the Lifecycle documentation directories, including `docs/guidelines/`;
- creates or updates only the marked Lifecycle section in `AGENTS.md`.

It leaves unrelated skills, project documentation, `CONTEXT.md`, engineering guidelines, module content, backlog content, and active lifecycle work alone.

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

The project owns the contents created during actual development. The installer does not generate guideline files, generic context, module documents, backlog items, or active cycle artifacts.

Active lifecycle workspaces are normally committed while a change is in progress so developers, branches, and phase chats can share state. Developers working alone may add `docs/lifecycle/` to `.gitignore` when they do not need that continuity in version control.

During Finalize, preserve durable knowledge in its permanent home before cleanup: module docs for current product behaviour, support/user docs for user-facing instructions, project guidelines or checkers for reusable engineering conventions, and Lifecycle skills for reusable process lessons. Archive or remove completed workspaces only after explicit user confirmation.

Before Plan, Build, and Finalize, Lifecycle loads the project sources and rules relevant to that phase. The installer does not guess project technologies or create generic rules such as `flutter.md`, `react.md`, or `cloud-functions.md`.

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
