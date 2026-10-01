# Phase 5 — Finalize

## Responsibility

Reconcile the approved lifecycle with the actual branch, verify the complete development change, synchronize permanent truth, preserve reusable learning, clean temporary work, and close development.

## Principle

> **Reconcile → Verify → Synchronize → Improve → Clean → Close**

## Boundary

Finalize ends the development lifecycle.

It does not own:

- deployment;
- release decisions;
- staging/production validation that can only happen after development;
- merge/post-merge checks;
- external review after the development branch is handed off.

Do not put work in `05-finalize.md` that cannot be completed while development is still under the lifecycle's control.

## 1. Reconcile

Start from:

- Idea Goal + Key Results;
- Prototype-owned decisions;
- Plan Build Steps;
- every step's Verify checks;
- Build results;
- complete branch diff against its base;
- current working-tree changes, if any.

Create a compact `Change Inventory`.

The inventory answers:

> **What changed that may need verification?**

Prefer changed behaviours/areas.

Do not dump raw filenames when they do not help verification.

### Unplanned Changes

Branch changes are evidence of scope.

They are not automatically approved requirements.

If the actual branch contains a consequential change not represented by the approved lifecycle:

- flag it as unplanned;
- do not legitimize it by silently adding it to the checklist;
- route it to the owning phase;
- resolve whether to approve, change, or remove it;
- regain the required approval before closing Finalize.

## 2. Verify

Create one complete `Verification Checklist` inside `05-finalize.md`.

Do not create a separate verification file.

Build the checklist from:

- Idea success criteria;
- Prototype decisions that affect behaviour;
- Plan step Verify checks;
- Build verification/evidence;
- Change Inventory;
- relevant regression risk created by the branch.

### Checklist Rules

- One check per line.
- Make the action and expected result clear.
- Organize by area when the list is long.
- Carry already-proven checks forward as `[x]`.
- Keep pending development checks as `[ ]`.
- Add newly discovered checks from actual branch changes.
- Do not add deployment/release/post-merge checks.

The user should be able to verify the whole development change from this one file without reopening every earlier lifecycle artifact.

### Test Setup

Add `Test Setup` only when verification requires special:

- users/roles;
- data;
- accounts;
- configuration;
- environment preparation.

Omit it when unnecessary.

### Gaps

Record only development-time verification that could not be completed.

For each gap include:

- what remains unverified;
- why.

Do not hide a gap.

Do not describe post-development deployment/release work as a verification gap.

### Failure Routing

If verification reveals:

- implementation defect → Build;
- technical/step/verification-plan defect → Plan;
- behaviour/experience defect → Prototype;
- problem/goal/success defect → Idea.

Update the owning artifact.

Regain approval when required.

## 3. Synchronize

After intended behaviour is sufficiently verified:

- update module docs;
- update support/user docs;
- update other permanent sources when needed;
- remove statements that are no longer true.

Permanent docs describe current verified behaviour.

They do not describe intended-but-unverified behaviour.

## 4. Improve

Review:

- Cycle Log;
- Build friction;
- environment limitations;
- verification blockers;
- missing/unclear conventions;
- repeated agent mistakes;
- lifecycle friction.

Promote only reusable learning.

Possible destinations:

- project guideline/checker;
- lifecycle skill;
- architecture/process guidance.

Do not change process merely to fill this section.

Consequential process changes require explicit user approval before applying.

Ask:

> **Could this problem reasonably affect future work again?**

If yes:

- preserve it as reusable learning;
- recommend its permanent home;
- fix it only when appropriate and approved.

If no:

- make no permanent process change.

## 5. Clean

After useful learning is preserved:

- remove prototype/debug/temporary code;
- remove obsolete TODOs;
- remove experiments;
- remove accidental leftovers;
- retain evidence only when it has durable value.

## 6. Close

Confirm:

- lifecycle intent and branch changes are reconciled;
- consequential unplanned changes are resolved;
- required development checks are completed or explicitly accepted as gaps;
- permanent docs match verified reality;
- approved process learning is preserved;
- temporary work is cleaned;
- no consequential development issue remains.

Set:

- `Complete` when development can close;
- `Blocked` when unresolved development work remains.

Present Finalize result.

Wait for explicit user approval before closing the lifecycle.
