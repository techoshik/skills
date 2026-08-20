# Migrations

## Plan

- Consider migrations for every Goal.
- State `None` when no migration is needed.
- Include data, schema, API, contract, configuration, permission, and storage
  changes when relevant.
- Classify each migration as before, during, or after release.
- Create a matching Step and Implementation item.
- Create one detailed document per migration.

## Document

- Store documents under `docs/migrations/`.
- Create the document while planning the migration.
- Finalize it before execution.
- Record results after execution.
- Link it from affected feature and release documents.
- Do not create one for ordinary internal refactoring.

Use these sections:

### Purpose

- Reason for the migration.
- Intended outcome.

### Impact

- Affected data, systems, users, and contracts.
- Compatibility and downtime concerns.

### Prerequisites

- Required state, access, backups, and dependencies.
- Conditions that block execution.

### Steps

- Ordered migration actions.
- Clear stopping points when relevant.

### Verification

- Checks required before continuing.
- Expected evidence and results.

### Rollback

- Conditions that trigger rollback.
- Ordered recovery actions.
- Irreversible effects when present.

### Status

- Planned, Ready, Running, Verified, Rolled back, or Failed.

### Results

- Actual execution time and outcome.
- Verification evidence.
- Incidents, deviations, or follow-up work.

## Release Document

- List every migration under the release `Migrations` section.
- Link each migration document.
- Do not duplicate its detailed Steps.
- State `None` when the release has no migrations.

Use this order:

### Before

- Migrations required before deployment begins.
- Required verification and blocking conditions.

### During

- Migrations coupled to deployment.
- Ordering and compatibility requirements.

### After

- Migrations required after deployment.
- Verification, cleanup timing, and ownership.

## Safety

- Do not execute without required authorization.
- Do not execute before prerequisites and rollback are ready.
- Stop when verification fails.
- Record partial or failed execution accurately.
- Never describe an unverified migration as complete.
