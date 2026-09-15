# Lifecycle — Plan

## 1. Purpose

- Translate the approved **Shape** into the smallest clear implementation path.
- Organize the work into **vertical slices** that produce observable working behaviour as early as possible.
- Make each slice small enough for humans and AI agents to understand, review, and verify without holding the whole module in mind.

> **Plan working slices, not isolated technical layers.**

## 2. Inputs

- **Approved Define Output** — Problem, value, scope, business rules, success criteria.
- **Approved Context Output** — Architecture, code, patterns, dependencies, constraints, relevant implementation.
- **Approved Shape Output** — Experience, domain, prototype, rules, minimum solution.
- **Validation Learnings** — Prototypes, spikes, contracts, diagrams, other findings from Shape.

## 3. Rules

- **Shape controls what; Plan controls how** — Planning must not silently change the shaped solution.
- **One module, one plan by default** — Keep features/slices together unless splitting clearly reduces cognitive load.
- **Feature before slice** — Organize by feature, then vertical slices.
- **Vertical slices over horizontal layers** — Prefer small end-to-end capability over all models, then all UI, then all backend.
- **Slice sequence** — Use **Model → UI → Backend → Connect → Verify** when applicable.
- **Observable result** — Normal slices end in behaviour that can be exercised through a real interface.
- **Technical-only work is an exception** — It still requires concrete technical verification.
- **Minimum models only** — Create/extend only what the current slice needs.
- **Reuse before creating** — Prefer existing architecture, components, services, repositories, patterns, abstractions.
- **Build shared foundations when required** — Never speculative infrastructure for hypothetical future features.
- **Module Foundation is exceptional** — Put truly module-wide prerequisites before features only when they cannot naturally belong to a real slice.
- **Do not expand scope** — New product behaviour requires approval.
- **Verification is part of the slice** — Code written is not completion.
- **Status is not duplicated by default** — Use the existing execution tracker unless Plan itself is the execution source of truth.
- **Split only when needed** — Large/independent feature details can move to a linked child plan.
- **Loop back when needed** — Define mismatch → Define; missing system understanding → Context; solution/domain change → Shape; implementation uncertainty → remain in Plan.

## 4. Questions

### Module

- Feature Order
- Cross-Feature Dependencies
- Shared Foundation
- Plan Size

### Feature

- Outcome
- Slices
- Reuse
- Dependencies

### Slice

- Model
- UI
- Backend
- Connect
- Verify
- Regression
- Delete Test

## 5. Actions

- Order module features by dependency and value.
- Break each feature into the smallest practical vertical slices.
- For each slice, plan **Model → UI → Backend → Connect → Verify** where applicable.
- Keep model/domain changes limited to the current slice.
- Reuse the approved prototype instead of redesigning UI during Plan.
- Preserve the approved prototype's validated screens, states, and responsive decisions in the implementation plan; do not treat the prototype file itself as production code.
- Identify affected code, data, interfaces, permissions, migrations, dependencies, and regression risks only as needed by the slice.
- Define a concrete verification method for every slice before Build starts.
- Remove technical work that does not contribute to an approved slice.
- Keep feature slices in one module Plan unless splitting clearly reduces cognitive load.
- Re-check **Define → Context → Shape** before approving Plan.
- Use **wayfinder** when the implementation path is too large/uncertain for a single session or has many unresolved decision edges.
- Use **to-tickets** only when external issue-tracker decomposition is useful; the lifecycle Plan remains authoritative.

## 6. Output

### Module Plan

- **Module:** …
- **Feature Order:** …
- **Cross-Feature Dependencies:** …
- **Module Foundation:** … *(only when genuinely required)*
- **Shared Risks / Constraints:** …

### Feature: …

- **Feature Outcome:** …
- **Depends On:** …

#### Slice 1 — …

- **Change:** …
- **Depends On:** …
- **Model:** …
- **UI:** …
- **Backend:** …
- **Connect:** …
- **Verify:** …

Add only as many slices as needed. Omit a sub-step when genuinely not applicable. If a feature needs its own detailed plan, link it instead of duplicating it.

## 7. Exit

Move to **Build** only when:

- Feature order and important cross-feature dependencies are clear.
- Each feature is broken into small vertical slices understandable independently.
- Each normal slice ends in observable behaviour verifiable through UI/API/another real interface.
- Technical-only slices have concrete verification.
- Each slice contains only necessary models and implementation work.
- Dependencies, migrations, compatibility, permissions, and regression risks are understood where relevant.
- No critical implementation questions force guessing.
- Define, Context, and Shape remain valid.
- **Cycle Log Check** has been performed.
- A human or AI agent can honestly say:

> **I know which slice to build next, what minimum changes it needs, and exactly how to prove that slice works before continuing.**
