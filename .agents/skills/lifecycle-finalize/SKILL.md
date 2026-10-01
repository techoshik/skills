---
name: lifecycle-finalize
description: "Use after Build to reconcile the approved lifecycle with the actual branch, create one complete development verification checklist, synchronize permanent truth, preserve reusable learning, clean temporary work, and close development."
---

# Finalize

## Phase Question

> **Does the actual branch match the approved lifecycle, and is development complete?**

Read:

- `../lifecycle/references/framework.md`
- `../lifecycle/references/models.md`
- `../lifecycle/references/artifacts.md`
- `../lifecycle/references/finalize.md`
- `../lifecycle/references/code-review.md`
- `../lifecycle/references/guidelines.md`
- `../lifecycle/references/cycle-log.md`

Before presenting a document, complete the [required compactness pass](../lifecycle/references/artifacts.md#required-compactness-pass).

Sol owns Finalize assessment; use [Model Coordination](../lifecycle/references/models.md#finalize) for delegated checks.

Load:

- Idea Goal + Key Results;
- Prototype-owned decisions/artifacts;
- Plan Build Steps and their Verify checks;
- Build results and verification;
- complete branch diff against its base;
- current working-tree changes, if any;
- relevant permanent docs;
- complete Cycle Log;
- project verification/conformance rules.

Execute:

> **Reconcile → Verify → Synchronize → Improve → Clean → Close**

Follow the [development boundary](../lifecycle/references/framework.md#development-boundary).

### Reconcile

Apply [Branch Reconciliation](../lifecycle/references/completeness.md#branch-reconciliation).

Create a compact Change Inventory from:

- approved lifecycle intent;
- actual branch changes.

Branch changes are evidence of scope.

They are not automatically approved requirements.

If the branch contains an unplanned consequential change:

- flag it;
- route it to the owning phase;
- resolve it before closing development.

### Verify

Create the complete verification checklist inside `05-finalize.md`.

Use:

- Idea success criteria;
- Prototype decisions;
- every Plan step's Verify checks;
- Build verification/evidence;
- actual branch changes;
- relevant regressions implied by those changes.

Carry checks forward using the [evidence rules](../lifecycle/references/artifacts.md#evidence).

Keep pending development checks unchecked.

Add Test Setup only when special setup is needed.

Apply [Proof Limits](../lifecycle/references/completeness.md#proof-limits) and [Gap Acceptance](../lifecycle/references/completeness.md#gap-acceptance).

Complete [Lifecycle Code Review](../lifecycle/references/code-review.md) for the reconciled change.

### Synchronize

After intended behaviour is sufficiently verified:

- update module docs;
- update support/user docs;
- update other permanent truth.

### Improve

Use real evidence.

Improve:

- skills;
- guidelines;
- checkers;
- process.

Only when a reusable lesson exists.

Treat recurring environment and verification friction as reusable learning when it can affect future work again.

Consequential process changes require explicit user approval before applying.

### Clean

Apply [Safe Cleanup](../lifecycle/references/completeness.md#safe-cleanup) before removing temporary work.

### Close

Development is Complete only when:

- approved intent and branch changes are reconciled;
- consequential unplanned changes are resolved;
- required development verification is complete or explicitly accepted as a gap;
- permanent truth is synchronized;
- useful process learning is preserved;
- temporary work is cleaned.

Otherwise mark development Blocked.

Update:

- `05-finalize.md`;
- `00-lifecycle.md`.

Present Finalize.

Apply the [approval gate](../lifecycle/references/framework.md#approval-gate).
