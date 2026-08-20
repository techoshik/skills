# Cloud Functions Structure

## Scope

- Apply to TypeScript Cloud Functions modules.
- Treat `src/` and `test/` as relative to the Functions package root.
- Use `snake_case` for module and file names.
- Follow explicit repository instructions when they conflict.
- Surface conflicts before adding new structure.

## Source Tree

```text
src/
  index.ts
  modules/
    <module>/
      index.ts
      <module>_models.ts
      <module>_repository.ts
      <module>_service.ts
      <module>_manager.ts
      <module>_validator.ts
      <module>_functions.ts
    platform/
  utils/
test/
```

## Module Layout

- Keep each module flat under `src/modules/<module>/`.
- Do not create `models/`, `repositories/`, `services/`, or `managers/`
  subdirectories.
- Create only files whose responsibilities exist.
- Give supporting files the owning module name.
- Put triggers in `<module>_functions.ts`.
- Give every module an `index.ts` public boundary that exports only the module's
  intended public API.

## File Responsibilities

- `<module>_models.ts` owns models, types, enums, and schema constants.
- `<module>_repository.ts` owns persistence access.
- `<module>_service.ts` owns module business operations.
- `<module>_manager.ts` owns multi-step module coordination when needed.
- `<module>_validator.ts` owns reusable domain validation.
- `<module>_functions.ts` owns callable, scheduled, and trigger functions.
- `index.ts` re-exports the intended public functions and types; it does not
  define handlers.
- Do not create empty responsibility files.

## Shared Code

- Keep shared platform infrastructure in `src/modules/platform/`.
- Keep reusable generic helpers in `src/utils/`.
- Keep `src/index.ts` limited to initialization, global options, and exports.
- Import Cloud Function handlers from each module's `index.ts`.
- Construct initialized platform dependencies inside handlers or lazy helpers.

## Persistence

- Define collection and persisted-field constants before consuming them.
- Keep constants with the owning module models.
- Use constants in paths, queries, writes, projections, audit, and event payloads.
- Avoid raw schema strings outside declarations or configuration that requires
  them.
- Use explicit cross-module identifiers instead of generic IDs.

## Validation

- Validate before trusted transactions begin.
- Keep validators free of persistence and side effects.
- Throw clear, actionable validation errors.
- Add focused tests for each validation rule.

## Verification

- Confirm the module remains flat.
- Confirm every public module file is exported intentionally.
- Confirm schema names use owning constants.
- Confirm identifiers name their entity clearly.
- Run repository convention checks before and after a logical Step.
- Run focused tests, lint, and TypeScript checks.
- Run broad emulator suites after a logical batch or before deployment.
