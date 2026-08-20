# Documentation

## Before Changes

- Read applicable repository instructions.
- Read applicable files under `docs/guidelines/`.
- Read the module `README.md`.
- Read affected feature documents.
- Compare documentation with code and tests.
- Read related migrations when data or compatibility may change.

## Structure

```text
docs/
  guidelines/
    README.md
    <application>.md
  plans/
    <plan>.md
  modules/
    <module>/
      README.md
      <feature>.md
  releases/
    <release>.md
  migrations/
    <migration>.md
```

- Follow explicit repository instructions first.
- Use this structure when they do not conflict.
- Apply shared technology structure references when relevant.
- Surface conflicts instead of following legacy structure silently.
- Do not reorganize existing documentation without approval.

## Guidelines Check

- Run before implementing every Step.
- Identify affected application areas.
- Read applicable guidelines.
- Check structure, design, code, testing, and review rules.
- Record important constraints in the Implementation item.
- Explain missing or conflicting guidance.
- Suggest the smallest necessary addition.
- Ask before creating or changing a guideline.
- Do not invent material conventions silently.
- Verify the completed Step against its guidelines.

## Application Guidelines

- Store them under `docs/guidelines/`.
- Use `README.md` as a short index.
- Create files only for application types that exist.
- Examples include `flutter.md`, `web.md`, `admin.md`, and `backend.md`.
- Keep exact theme values in code-owned tokens.
- Link to tokens instead of duplicating values.
- Keep shared rules in one place.

Use these sections:

- **Scope:** where the guideline applies.
- **Structure:** folder, module, and feature organization.
- **Design:** spacing, theme, colours, typography, and components.
- **Code:** naming, architecture, state, errors, and dependencies.
- **Testing:** required checks and test placement.
- **Review:** what reviewers must verify.

## Plans

- Store approved plans under `docs/plans/`.
- Keep one plan for one coherent Goal or change.
- Read an existing plan before resuming work.
- Update Implementation status and Notes during development.
- Keep completed plans as delivery history.

## Modules

- Create one directory for every documented module.
- Use `README.md` for the short module overview.
- Explain purpose, boundaries, status, and related modules.
- List feature documents with links.
- Keep feature details out of the overview.

## Features

- Keep feature documents inside their module directory.
- Create or update them after implementation is verified.
- Describe current verified behavior only.
- Replace outdated behavior instead of keeping history.
- Put historical changes in release documents.

Use these fields below the title:

```text
- Status:
- Updated:
```

Use only these sections:

- **Purpose:** problem, users, value, and boundaries.
- **Behavior:** entry points, flows, states, failures, and results.
- **Rules:** business rules, validation, permissions, and edge cases.
- **Integration:** data, APIs, events, dependencies, and migrations.
- **Verification:** acceptance checks, coverage, and limitations.

- Avoid model fields, code copies, and file or method inventories.
- Link deeper API, schema, or migration documents.

## Diagrams

- Use Mermaid for flows with several stages or branches.
- Use `flowchart` for user and system flows.
- Use `sequenceDiagram` when interaction order matters.
- Use `stateDiagram-v2` for lifecycle states.
- Keep diagrams small.
- Do not repeat diagrams as long prose.

## Release

- Create or update the release document when the Goal is complete.
- Finish it before branch merge.
- Create one document per release.
- Keep previous release documents unchanged.
- Include relevant changes, migrations, configuration, verification, deployment,
  rollback, and known issues.
- Link affected feature documents.
- Do not maintain a release status.
- Treat branch merge as the release-document completion signal.

## Migration

- Read [migrations.md](migrations.md) completely.

## Style

- Use one idea per bullet.
- Keep headings short.
- Avoid repeated information and large tables.
- Use nested bullets only when clarification is necessary.
