---
name: lifecycle-finalize
description: Synchronize verified permanent documentation, turn recurring friction into tested process improvements, prepare an evidence-based handoff, and handle lifecycle artifacts safely (Lifecycle: Finalize).
---

# Lifecycle Finalize

Finalize only the reviewed implementation. Preserve durable product knowledge, improve the framework when the evidence supports it, prepare an accurate handoff, and handle temporary lifecycle files conservatively. Keep the existing Finalize approval and cleanup gate.

## 0. Phase Rules & Guardrails

- **Verified truth only:** Permanent docs describe the final reviewed behavior and decisions—not abandoned plans, unverified assumptions, or intended behavior that was not implemented.
- **Readable knowledge, not transcript storage:** Capture what a future developer needs to understand, maintain, and safely change the module. Do not copy the whole lifecycle specification into permanent docs.
- **Keep one authoritative home per detail:** Module README summarizes scope, models, dependencies, and links; feature docs explain detailed workflows, invariants, and architecture. Link instead of repeating.
- **Preserve managed rule regions:** In consumer projects, do not edit inside `<!-- lifecycle:guideline:start ... -->` markers. Add local rules below `<!-- lifecycle:guideline:end -->` or use the project-local rule mechanism.
- **Manual Git only:** Never run `git add`, `git commit`, `git push`, or `gh pr create`.
- **Preserve lifecycle work by default:** Requirements, prototypes, roadmaps, traceability, and refinement records may be valuable review evidence. Do not delete or archive them without explicit user approval of the action and destination.

## Step 1: Entry Gate and Artifact Collection

1. Read `00-status.md`, the Resume Checkpoint, `01-requirements.md`, `03-roadmap.md`, `04-refine.md`, and `05-traceability.md`. Confirm Review is `Done`, then set Finalize to `In Progress`.
2. Confirm the final code was reviewed and record any known failed/not-run tests or remaining risks. Do not describe them as passed or resolved. Carry every non-`Verified` row from `05-traceability.md` into the handoff’s known limitations.
3. Identify the affected module(s), permanent docs, glossary entries, and managed rule files.

**Gate:** The reviewed end state and any verification limitations are known.

## Step 2: Update Permanent Documentation

Update only the documentation relevant to the feature using scannable nested sub-bullets (`1 line = 1 atomic detail`).

### Module README (`docs/modules/<module>/README.md`)

Use [Module README Template](../lifecycle/templates/module_readme.md) when creating or substantially restructuring it. Keep the README as a module-level orientation page:

- Purpose and ownership boundary.
- Important data models/storage concepts (`File:` and `Description:` sub-bullets) and links to their definitions.
- Feature index with one-line descriptions.
- Cross-module dependencies (`Consumes`, `Exposes`, `Delegated ownership`) and explicitly deferred scope (`Deferred (Future Backlog)` from `01-requirements.md` Section 8).

Do not place the entire feature workflow or all touchpoints in the README if those belong in a feature document.

### Feature document (`docs/modules/<module>/feature_<name>.md`)

Use [Feature Template](../lifecycle/templates/module_feature.md) when creating or updating the feature spec. Include the durable facts that help a developer answer:

- What problem/capability the feature serves and its entry point.
- How the primary workflow behaves, including relevant alternate/failure paths (empty state, validation/offline, permissions/tenancy, concurrency/retry, data lifecycle).
- Which business rules (`BR-X`), permission boundaries, tenancy requirements, and data-lifecycle constraints are non-negotiable.
- Which components own the responsibilities (`File:` and `Description:` sub-bullets under Controllers & State, Views & UI, Data & Validators, Routes & Integrations).
- Which consequential architectural decisions were made and why, including material alternatives or risks when future changes depend on them.

Do not repeat every acceptance criterion from the temporary requirements file. Preserve the important behavior and rationale in a maintainable form.

### Glossary and public docs

- Sync approved staged terms from `## 7. Glossary Updates` in `01-requirements.md` into `GLOSSARY.md` alphabetically; do not add trivial terms that are already unambiguous in the project.
- Update the root `README.md` only if the feature changes setup, configuration, environment variables, commands, or user-facing project capabilities that the README documents.
- Remove or revise stale permanent documentation that now describes behavior or legacy screens that no longer exist.

**Gate:** Permanent docs describe the final implementation clearly, have no contradictions with the code, and avoid unnecessary duplication.

## Step 3: Convert Friction into Verified Improvement

Review every entry in `04-refine.md` and classify it:

- **One-off:** Correct the task-specific artifact or capture the lesson; do not create a universal rule unless it generalizes.
- **Project-specific:** Update the relevant project rule or local documentation.
- **Framework-wide:** Update the appropriate upstream skill/template only when it will prevent a repeatable failure across projects.
- **Unclear or not reproducible:** Investigate or keep it explicitly unresolved; do not claim the lesson is verified.

For each change that is applied, record the target and status (`Proposed`, `Applied`, `Verified`, or `Deferred`). A rule change is **Verified** only when its wording is checked against the intended scenario and does not introduce a contradiction with other lifecycle files. Prefer consolidating or clarifying an existing rule over adding another rule for the same concern.

### Project rules

- Promote only repeatable architecture, security, testing, naming, or maintenance rules that have evidence behind them.
- Preserve managed guideline hashes (`<!-- lifecycle:guideline:start ... -->` / `<!-- lifecycle:guideline:end -->`) as described above.
- After a generalizable change, consider a small scenario that should now be handled correctly and make sure the new rule actually addresses it.

### Upstream skills and templates

When working inside the central skills repository, update the source files directly. In a consuming project, provide a concise improvement block for the user to apply upstream:

```markdown
### 🔄 Upstream Skill / Rule Improvement
- **Target:** `<skill, template, or rule path>`
- **Observed failure:** <1-line recurring problem>
- **Evidence / cause:** <1-line root cause why current instructions permit it>
- **Recommended change:** <1-line precise instruction or rule change>
- **Verification scenario:** <1-line check confirming the change works>
```

**Gate:** Every friction item is resolved, applied, verified, or explicitly deferred with a reason. Do not claim all entries are complete merely because they were read.

## Step 4: Prepare an Accurate Handoff Summary

Prepare a copyable PR/handoff description using the structure below. Populate every claim with actual evidence; omit sections that truly do not apply rather than leaving placeholders.

```markdown
# 🚀 Pull Request: <Concise Feature Title>

## 1. Outcome Summary
- **Problem solved:** <1-line user or operational problem>
- **Delivered outcome:** <1-line observable capability now available>

## 2. Key Changes & File Touchpoints
- **<Core Capability 1>:**
  - File: `<path/to/file>`
  - Description: <1-line summary of change and why it matters>
- **Documentation & Rules:**
  - Updated `docs/modules/<module>/`, `GLOSSARY.md`, and `.agents/rules/<rule>.md`

## 3. Verification & Evidence
- **Automated tests:** `<exact command>` — <Passed / Failed / Not Run>
- **Static analysis:** `<exact command>` — <actual result>
- **Manual verification:**
  - Prerequisites / Environment Setup: <Test role, seed data, or emulator setup>
  - Action: <Steps performed>
  - Expected: <Observable result and whether verified>
- **Traceability:** <n>/<total> acceptance criteria and <n>/<total> business rules `Verified` — <gaps and dispositions, or "none">

## 4. Business Rules & Known Limitations
- **BR-1 (`<Rule Name>`):** <1-line invariant>
- **Known limitations:** <Failed/not-run checks or unresolved risks, if any>
```

Do not invent PR URLs, claim a merge occurred, or imply tests passed without evidence. This lifecycle does not create commits or pull requests.

**Gate:** The handoff can be copied as written without overstating completion or verification.

## Step 5: Final Handoff and Explicit Artifact Decision

1. Inspect read-only `git status --short` and confirm what temporary lifecycle files remain, including untracked or uncommitted work.
2. Update the Resume Checkpoint and set Finalize to `In Review`.
3. Present the Approval Request block (Section 4 of [`lifecycle/SKILL.md`](../lifecycle/SKILL.md)): **What I did** = links to updated permanent docs and verified rule/skill improvements; **What to check** = the handoff summary and any residual limitations; **What I need from you** = the artifact decision in the next item.
4. Ask the user to choose what should happen to `lifecycle/`: **keep it in place**, **archive it to a specific location**, or **delete it**. State that preservation is the default and list the artifacts that would be moved/deleted. Do not infer permission to delete from approval of the feature or of Finalize.
5. Stop and wait for explicit approval of the cleanup action. If the destination or deletion scope is unclear, ask before acting.
6. After approval, perform only the authorized action, verify the resulting paths, and never remove unrelated or uncommitted user files. Then mark Finalize `Done` and update the checkpoint.
