# Shape

## Purpose

- Turn the approved outcome and verified context into the smallest correct solution.
- Produce a blueprint Plan can implement without re-solving the product/design problem.

## Inputs

- Approved Define.
- Completed Context.
- Relevant permanent module knowledge and verified repository facts.

## Rules

- Do not repeat Define scope or Context facts unless Shape changes their implication.
- Explore experience, domain, states, alternatives, risks, seams, and proof deeply.
- Record only the final shaped solution.
- Domain before database.
- Reuse existing patterns before inventing new ones.
- Do not let shared UI widgets own persistence or cross-module orchestration unless that is already the established boundary.
- A solution-changing unknown cannot silently pass Shape.
  - Resolve it.
  - Accept it explicitly as a risk.
  - Or route it back to Define/Context.
- Only implementation-level uncertainty owned by Plan may move forward.

## Questions

### Solution
- What is the minimum solution?
- What did Shape remove or constrain?
- What expansion requires approval?

### Flow
- What is the shortest complete user/system journey?
- What states and transitions matter?
- What failures/feedback materially change the experience?

### Model
- What concepts, ownership, information, lifecycle, and invariants are needed?
- What snapshots/revisions/identity must be preserved?

### Seams
- What should be reused?
- What new responsibility must exist?
- Which interface/module owns cross-boundary behaviour?
- What must callers not duplicate?

### Proof
- What complete journey must work?
- What is the cheapest trustworthy proof level?
- What accepted proof gaps remain?

## Prototype

- Use a prototype only when it materially reduces experience/state/logic uncertainty.
- If needed:
  - create `docs/lifecycle/<change>/prototype/index.html`;
  - keep it self-contained and throwaway;
  - record its result beside the decision it validated.
- If not needed, write nothing.
- Do not add a mandatory `Prototype: Not needed` section.
- Keep a useful prototype through Plan, Build, and Verify; Refine may remove it after its learning is transferred.

## Companion Skills

- `prototype` — material UX/state uncertainty.
- `domain-modeling` — difficult domain concepts/rules.
- `codebase-design` — material seams/interfaces.
- Do not use `grill-with-docs` by default; requirement ambiguity belongs to Define.

## Output — `03-shape.md`

### Decision
- Result: Shape approved / Needs revision.
- Status: Pass / Blocked.
- Blockers.
- Next.

### Solution
- Minimum.
- Removed.
- Approval boundary.
- Add rejected alternatives only when the reason is important for future implementation decisions.

### Flow
- Journey.
- Important states/transitions.
- Important failure/retry behaviour.

### Model
- Core concepts and ownership.
- Required information.
- Rules/invariants.
- Storage details only when they materially shape the solution.

### Seams
- Reuse.
- Add.
- Ownership/boundary.
- Cross-module responsibilities.

### Proof
- Critical journey.
- Selected proof levels and why they are sufficient.
- Accepted gaps.

### Open
- Research.
- Risks.
- Questions/blockers if any.
- Only Plan-owned implementation uncertainty may normally remain.

## Phase Gate

Pass when:

- the minimum solution is explicit;
- the user/system flow is coherent;
- domain ownership and key rules are clear;
- reuse/new seams are explicit;
- proof strategy is trustworthy;
- no unresolved solution-changing unknown remains.

Do not add a second Exit section to the artifact.
