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
    <plan>/
      README.md
      steps/
        <number>-<step>.md
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
- Record important constraints in the detailed Step record.
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
- Keep a small plan in one `<plan>.md` file.
- Split a substantial plan into `<plan>/README.md` and `steps/` files.
- Read the main README and active Step record before resuming work.
- Keep Step status only in the main README for a split plan.
- Update Step status and Notes during development.
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

- **Purpose:** users, problem, value, scope, and exclusions.
- **User Flow:** entry points, the main flow, UI feedback and states,
  responsive behavior, and user-visible results.
- **Rules:** permissions, business decisions, validation, calculations,
  concurrency, retries, scale limits, and edge cases.
- **Integration:** data ownership and contract, security boundaries, APIs,
  events, side effects, dependencies, migrations, and rollout compatibility.
- **Verification:** concise acceptance criteria, evidence, manual QA, remaining
  work, and release gates.

- Use short subsections only when they make a complex section easier to scan.
- Keep validation criteria in **Rules**; describe validation feedback in
  **User Flow**.

- Avoid code copies and file or method inventories.
- Keep only contract-level data fields that readers need to understand the
  feature in **Integration**.
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
- Keep every sentence in every documentation artifact at 80 characters or fewer.
- Split a longer idea into separate sentences or bullets.
- Do not soft-wrap a long sentence merely to satisfy this rule.
- Avoid repeated information and large tables.
- Use nested bullets only when clarification is necessary.
