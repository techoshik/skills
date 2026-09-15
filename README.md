# Development Lifecycle

This repository contains reusable Lifecycle skills and installers that make a
project Lifecycle-ready without overwriting its product knowledge.

## Required companion skills

Before using the Lifecycle skills in a project, install the required companion
skills from [mattpocock/skills](https://github.com/mattpocock/skills):

```bash
npx skills@latest add mattpocock/skills
```

When prompted, install the Lifecycle companion skills, including:

```text
setup-matt-pocock-skills
grill-with-docs
wayfinder
to-tickets
research
domain-modeling
prototype
codebase-design
tdd
diagnosing-bugs
code-review
improve-codebase-architecture
writing-for-agents
```

Then run the setup skill once from the target project:

```text
/setup-matt-pocock-skills
```

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

## Approval modes

The Lifecycle approval mode is recorded in `00-lifecycle.md` and survives
phase-to-phase chat handoffs:

- `strict` — default; pause after every phase and Build slice.
- `guided` — pause at Define, Shape, Plan, and Verify decision gates.
- `auto` — continue through passing gates without phase-approval prompts.

Pass the mode in the request using the short syntax:

```text
Add an optional daytime field to the existing feature.
mode: auto
```

`auto` skips phase approvals only. It does not authorize guessing through
contradictory requirements, missing authority, production safety boundaries,
or separately authorized external actions.

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
