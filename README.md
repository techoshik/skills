# Development Lifecycle

- This repository contains reusable Lifecycle skills and installers.
- They make projects Lifecycle-ready without overwriting product knowledge.

## Required companion skills

- Before using Lifecycle, ensure the required companion skills from [mattpocock/skills](https://github.com/mattpocock/skills) are available.
- Codex-installed skills, such as `~/.agents/skills`, and repository-local `.agents/skills/` skills both count.
- If skills are missing, install them with:

```bash
npx skills@latest add mattpocock/skills
```

- When prompted, install the Lifecycle companion skills, including:

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

- Then run the setup skill once from the target project:

```text
/setup-matt-pocock-skills
```

## Install into a project

- From this repository:

```bash
./install-lifecycle.sh /path/to/project
```

- To install into all projects listed in the ignored root file `.lifecycle-projects`, run without a project path:

```bash
./install-lifecycle.sh
```

- Use [`.lifecycle-projects.example`](.lifecycle-projects.example) as the list-file format: one existing project path per line, with blank lines and `#` comments ignored. Relative paths resolve from the list file's directory.

- An explicit list file is also supported:

```bash
./install-lifecycle.sh --projects-file /path/to/projects-file
```

- Only existing listed project directories are processed. Missing entries are skipped with a warning and are never created. PowerShell uses `-ProjectsFile <path>`; no arguments use `.lifecycle-projects` at the installer root.

- If the repository itself is the target project:

```bash
./install-lifecycle.sh .
```

- On Windows PowerShell:

```powershell
.\install-lifecycle.ps1 C:\path\to\project
```

- The installer is idempotent. It:

  - copies only directories named `lifecycle*` that contain `SKILL.md`;
  - creates `.agents/skills/` and the Lifecycle documentation directories, including `docs/guidelines/`;
  - creates or updates only the marked Lifecycle section in `AGENTS.md`.

- It leaves unrelated skills, project documentation, `CONTEXT.md`, engineering guidelines, module content, backlog content, and active lifecycle work alone.

- The installer supports both the current `.agents/skills/` repository layout and a future top-level `skills/` layout.

## Approval modes

- The Lifecycle approval mode is recorded in `00-lifecycle.md` and survives phase-to-phase chat handoffs:

  - `strict` — default; pause after every phase and Build slice.
  - `guided` — pause at Define, Shape, Plan, and Verify decision gates.
  - `auto` — continue through passing gates without phase-approval prompts.

- Pass the mode in the request using the short syntax:

```text
Add an optional daytime field to the existing feature.
mode: auto
```

- `auto` skips phase approvals only. It does not authorize guessing through contradictory requirements, missing authority, production safety boundaries, or separately authorized external actions.

## Phase chat handoffs

- Each phase records its next handoff in `00-lifecycle.md`, including a suggested chat title in this form:

```text
[Phase] - [Feature]
```

- For example:

```text
Plan - Add optional daytime field
```

- The host application controls whether that suggested title is applied automatically. A new chat should read `00-lifecycle.md` first and then only the artifacts required by its phase.

## Project-owned files

- The installer manages only the reusable system pieces:

```text
project/
├── .agents/skills/lifecycle*/
├── docs/lifecycle/
├── docs/guidelines/
├── docs/modules/
├── docs/backlog/
└── AGENTS.md  # only the marked Lifecycle block
```

- The project owns the contents created during actual development. The installer does not generate guideline files, generic context, module documents, backlog items, or active cycle artifacts.

- Active lifecycle workspaces are normally committed while a change is in progress so developers, branches, and phase chats can share state.
- Developers working alone may add `docs/lifecycle/` to the project's `.gitignore` when they do not need to share or preserve active lifecycle records in version control. Lifecycle continues to work locally; ignoring the folder only removes those records from commits and means they will not be available after a fresh clone or on another machine.
- If a team later needs shared lifecycle continuity, remove that ignore entry and commit the active workspace.
- During Refine:
  - Record proposed durable knowledge, code improvements, guideline changes, automation, and backlog items in `07-refine.md`.
  - Review the branch for duplication, unnecessary complexity, temporary code, missing tests, automation opportunities, and other evidence-based improvements.
  - Ask the user to approve proposed changes and apply only approved changes.
  - Ask whether to retain, archive, or remove the completed workspace.
  - Archive or remove it only after explicit confirmation.

- Before Build and Verify, Lifecycle discovers and loads every applicable guideline from `docs/guidelines/`.
- The installer does not guess project technologies or create files such as `flutter.md`, `react.md`, or `cloud-functions.md`.

## Updating

- Pull a newer repository version and run the installer again:

```bash
git pull --ff-only
./install-lifecycle.sh /path/to/project
```

- Use `VERSION` and Git tags to identify stable releases:

```bash
git tag v1.0.0
git push origin v1.0.0
```
