# Development Lifecycle Framework

## Governing Principle

> **Build the minimum necessary thing that creates meaningful value.**

- **Question** — Why is this requirement necessary? What real problem does it solve?
- **Value** — What meaningful benefit will the user, product, or business receive?
- **Delete** — What can we remove without losing that benefit?
- **Simplify** — What is the simplest solution that produces the required outcome?
- **Scope** — Never add nice-to-have behaviour unless explicitly approved.
- **Stop** — Once the required outcome and acceptance criteria are satisfied, stop building.
- **Optimize later** — Do not optimize something that may not need to exist.
- **Automate last** — Automate only after the process or solution has proved useful and stable.

## AI Scope Rule

- AI may discover additional opportunities, but it must never silently turn them into requirements.

- Use:

  - **Discover → Mention → Justify → Get approval → Add to scope**

- Reminder:

> **Just because AI can build it quickly does not mean we should build it.**

## Development Flow

1. **Define** — Understand what we are solving, for whom, why it matters, and what success means.
2. **Context** — Give the AI the product, codebase, architecture, constraints, conventions, and history it needs.
3. **Shape** — Validate what should be built before detailed implementation planning.
4. **Plan** — Decide how the validated solution will be implemented and sequenced.
5. **Build** — Implement the approved solution in small, understandable increments.
6. **Verify** — Prove that the completed result works and satisfies the original requirement.
7. **Refine** — Improve the solution, codebase, standards, context, and development process from what reality taught us.

> **Shape validates the solution. Plan organizes the implementation.**

## Standard Phase Structure

- Every phase uses the same structure:

  1. Purpose
  2. Inputs
  3. Rules
  4. Questions
  5. Actions
  6. Output
  7. Exit

> **Same structure. Different thinking.**

- The process should carry procedural memory so humans and agents spend cognition on judgment rather than remembering what to check next.

## Module and Feature

- **Module** — A group of related features serving a larger product capability.
- **Feature** — One specific user capability or behaviour inside a module.
- **Module defines the system. Feature defines the behaviour.**
- Shared business rules belong to the module.
- Feature-specific rules belong to the feature.
- Detailed domain/data modelling belongs to Shape, not Define.

## Loop-Back Ownership

- When a later phase exposes a problem, return to its owner:

| Problem | Owning phase |
| --- | --- |
| Requirement, value, scope, or success criteria | **Define** |
| Existing-system understanding | **Context** |
| Experience, domain, or solution behaviour | **Shape** |
| Implementation approach, sequencing, or slices | **Plan** |
| Implementation defect or code conformance | **Build** |
| Whole-solution acceptance evidence | **Verify** |
| Reusable learning, standards, process, or codebase improvement | **Refine** |

- A later phase must not silently repair an earlier mistake by inventing new assumptions.

## State and Context Rules

- The lifecycle artifacts are the versioned active-cycle state; conversation history is not.
- **Markdown wrapping** — Keep each coherent point on one line, even when it exceeds 80 characters. Wrap only when one line contains separate points or wrapping improves readability; do not wrap solely to meet an 80-character limit.
- Keep one active lifecycle directory per change under `docs/lifecycle/`.
- Keep the active lifecycle workspace versioned while the change is in progress so developers, branches, and new phase chats can share its state.
- `00-lifecycle.md` is the entry point and current-state index.
- Load only the artifacts needed by the current phase.
- Reference permanent knowledge instead of copying it into every phase file.
- `docs/modules/` describes the system as it is now; lifecycle files describe the change being worked through.
- Each module normally has one concise document at `docs/modules/<module>.md` containing durable product behavior: its goal, shared rules, and feature responsibilities/capabilities—not implementation details.

## Information Architecture

```text
docs/lifecycle/ = temporary active-change memory
docs/guidelines/ = permanent engineering standards
docs/modules/   = permanent current product truth
docs/backlog/   = permanent future opportunities
cycle-log.md    = temporary development-system improvement memory
```

- Active lifecycle workspaces are temporary working records, not permanent product documentation.
- During Refine:
  - Record proposed promotions and improvements in `07-refine.md`.
  - Ask the user to review and approve them before changing code or permanent sources.
  - Apply and reverify approved changes.
  - Ask whether to retain, archive, or remove the completed workspace.
  - Remove or archive it only after explicit confirmation.

> **Human owns priority. Lifecycle owns backlog maintenance.**

> **A backlog item never goes directly to Shape, Plan, or Build. It starts a new lifecycle at Define.**

## Companion Skill Policy

- Companion skills are techniques, not policy.

> **Lifecycle owns the process. Companion skills help execute it.**

- If a companion skill conflicts with this lifecycle or the project's guidelines, this lifecycle and the project guidelines win.
