# Flutter Structure

## Scope

- Apply to Flutter application modules.
- Treat `lib/` as relative to the Flutter package root.
- Use `snake_case` for module, feature, and file names.
- Follow explicit repository instructions when they conflict.
- Surface conflicts before adding new structure.

## Module Tree

```text
lib/modules/<module>/
  models/
    <module>.dart
    <module>.freezed.dart
    <module>.g.dart
  features/
    <feature_name>/
      <feature_name>.dart
      <feature_name>_state.dart
      <feature_name>_state.freezed.dart
      <feature_name>_state.g.dart
  screens/
    <module>_<screen_name>_screen.dart
  <module>_repository.dart
  <module>_service.dart
  <module>_validator.dart
  <module>_shared_state.dart
  <module>_shared_state.g.dart
  <module>_constants.dart
  widgets/
  index.dart
```

## Required Files

- Use `models/` for module models and generated companions.
- Do not create a new `entities/` directory.
- Put the single module repository in the module root.
- Name shared state `<module>_shared_state.dart`.
- Use `index.dart` as the deliberate public boundary.

## Optional Files

- Create `<module>_service.dart` only when needed.
- Create `<module>_validator.dart` only when needed.
- Create `<module>_constants.dart` only for cross-feature values.
- Create `widgets/` only when two or more features reuse a cohesive widget.
- Do not create empty or speculative files or directories.

## Features

- Keep feature behavior, state, and widgets under `features/<feature_name>/`.
- Keep feature-only constants inside the feature directory.
- Use `screens/` for module-level screens.
- Name screens `<module>_<screen_name>_screen.dart`.
- Implement feature UI classes as `HookConsumerWidget` stateless widgets.
  Use Flutter hooks for local controllers and other ephemeral UI state.
- Keep each feature's Freezed state class and its Riverpod controller together
  in the feature's `<feature_name>_state.dart` file.
- Keep remote data loading, mutations, and error state in the feature
  controller; UI classes should compose widgets and invoke controller methods.
- Use Material `DropdownMenu` or `DropdownMenuFormField` APIs for selection 
  controls. Do not add legacy `DropdownButton` or `DropdownButtonFormField`
  controls. Prefer the shared dropdown wrapper when the application provides one.

### Standard record features

- When a module needs standard record management, prefer these feature names:
  - `<module>_list` for filtering, listing, and list actions.
  - `<module>_form` for both create and update flows.
  - `<module>_detail` for one record's read-only and action workspace.
- Keep each feature's UI, state, validation feedback, and orchestration in its
  own `features/<feature_name>/` directory.
- A `<module>_form` supports both create and update when both flows exist.
  Do not create separate create and edit features for the same record.
- Module-level screens compose feature UI, routing inputs, permissions, and
  page scaffolding. They do not call persistence or remote APIs directly.
- Feature state calls a module repository or service through typed models.
  Do not use handwritten command maps or raw persisted field names in UI.

## Supporting Types

- Keep one repository, service, or validator in the module root.
- Create plural subdirectories only for multiple cohesive files of that type.
- Prefer direct repository calls for simple feature orchestration.
- Add a use case only for reusable domain policy, multi-repository coordination,
  or a transaction boundary.

## Persistence

- Put persisted names in `<Module>Constants`.
- Use `collectionName` and `viewCollectionName` identifiers.
- Keep required persisted values in their contract format.
- Use dedicated command constants when API keys differ from persistence keys.
- Pass command data through typed request and response models.
- Do not use handwritten command maps when typed models are practical.

## Public Boundary

- Use `index.dart` as the stable public module boundary.
- Always export public module files: models, root-level repository, service,
  validator, constants, shared state, module-level screens in `screens/`, and
  reusable module widgets in `widgets/`.
- Keep feature behavior and state private by default.
- Export a feature file or its state only when another module has a confirmed
  need to compose or consume it.
- Prefer direct imports inside the owning module.

## Verification

- Confirm new files match this tree.
- Confirm optional structure has a current use.
- Confirm generated companion files stay beside their source models or state.
- Confirm tests mirror the relevant module and feature ownership.
- Run repository-specific Flutter convention and analysis checks.
