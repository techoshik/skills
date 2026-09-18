# Lifecycle — Shape

## 1. Purpose

- Turn the approved problem into the **smallest viable solution**.
- Validate important assumptions before implementation.
- Define experience and domain enough that Plan can focus on **how to build it**.

> **Shape the right solution before planning the implementation.**

## 2. Inputs

- Approved Define Output
- Approved Context Output
- Existing Product Behaviour
- Known Constraints

## 3. Rules

- **Minimum solution first**
- **Validate before committing**
- **Experience before implementation**
- **Domain before database**
- **Reuse before invention**
- **Do not expand scope silently**
- **Make uncertainty visible**
- **Group by solution decision** — Use bold top-level bullets for experience, domain, validation, proof, and minimum-solution topics; nest their supporting details.
- **Keep implementation detail proportionate** — Record only the technical detail needed to validate the shape; defer build sequencing and file-level work to Plan.
- **Prototype risky parts**
- **Loop back when needed** — solution changes problem/value/minimum outcome/scope/success criteria → Define; missing/incorrect system understanding → Context.

> **Shape validates the solution. Plan organizes the implementation.**

## 4. Questions

- Ask these as concrete prompts in frontier rounds:

### Experience

- Where does the user enter, what can they do, and what is the minimum useful flow?
- Which states, transitions, feedback, errors, permissions, and empty/loading cases must be defined?

### Domain

- Which concepts or entities exist, who owns them, and how do they relate?
- Which information is required or optional, and which lifecycle states and business rules must remain true?

### Validation

- Which assumptions or risks could change the solution?
- What is the cheapest useful test, what alternatives exist, and do Define and Context still hold?
- What is the cheapest trustworthy proof for each important success criterion?
- Does any criterion require a complete module or end-to-end flow through a real boundary?

## 5. Actions

- Create the minimum user/system flow.
- Define required domain concepts and information.
- Identify important assumptions and risks.
- Choose a proportionate verification level using `references/verification-strategy.md`; recommend module integration or E2E only when lower-level proof is insufficient.
- Validate important uncertainty with the cheapest useful medium: prototype, flow diagram, API contract, conceptual model, architecture sketch, or technical spike.
- Compare shaped solution against Define and Context.
- Remove unnecessary screens, states, fields, concepts, steps, and behaviours.
- Escalate mismatches early rather than continuing with a flawed solution.
- Use **prototype** for cheap experience/state/logic validation.
- Use **domain-modeling** for domain terminology, ownership, lifecycle, and rule stress-testing.
- Use **codebase-design** when module seams/interfaces are material to the solution.

## 6. Output

### Decision Summary

- **Decision / Result:** Shape approved / Shape needs revision.
- **Status:** Complete / Blocked.
- **Blockers:** …
- **Next Action:** …

### Experience Shape

- **User flow**
  - Entry points and interactions.
- **States**
  - States and transitions.
- **Feedback**
  - Feedback, errors, and permissions.
- **Existing patterns**
  - Reusable product patterns that shape the solution.
- **Excluded experience**
  - Experience intentionally out of scope.

### Prototype

- Create a prototype when UI, responsive behaviour, or interaction states could change the shaped solution.
  - Put it at `docs/lifecycle/<change-name>/prototype/index.html`.
  - Make it standalone, responsive, and runnable by opening the file directly.
  - Use no server, dependency, network request, or production code.
  - Include only the screens and states needed to answer the uncertainty.
  - Label it as throwaway.
  - Record its question, covered screens/states, run instructions, validation verdict, and decisions in `03-shape.md`.
- If visual uncertainty is immaterial, record why a prototype is not needed.

- Keep an approved prototype available as a reference through Plan, Build, and Verify. Refine removes it after the validated decisions have been captured in the lifecycle or permanent documentation.

### Domain Shape

- **Concepts**
  - Core concepts and entities.
- **Ownership**
  - Relationships and ownership.
- **Information**
  - Required and optional information.
- **Lifecycle**
  - States and transitions.
- **Rules**
  - Business rules.

### Validation

- **Risks**
  - Important assumptions and risks.
- **Validation learning**
  - Validation method, learning, and mitigation.
- **Phase changes**
  - Define changes, Context changes, and remaining open questions.

### Verification Strategy

- **Outcome**
  - Outcome that must be proven.
- **Critical journey**
  - Complete feature or module flow that must work.
- **Proof level**
  - Unit / Widget / Module Integration / E2E / Manual, with why it is sufficient.
- **Real boundaries**
  - UI, API, database, permissions, integrations, or other boundaries involved.
- **Existing coverage**
  - Current tests, harnesses, fixtures, and environments.
- **Missing coverage**
  - Proof that does not yet exist.
- **Cost**
  - Cost and determinism.
- **Environment**
  - Environment risks.
- **Approval**
  - Required approval.
- **Accepted gap**
  - Accepted limitations.

### Shaped Solution

- **Solution**
  - Minimum solution.
- **Reason**
  - Why this is the smallest correct solution.
- **Removed scope**
  - What was removed.
- **Approval boundary**
  - What requires approval before expansion.

### Exit

- **Exit Status:** Pass / Blocked.
- **Evidence:** …
- **Remaining Blockers:** …
- **Next Phase:** Plan.

## 7. Exit

- Move to **Plan** only when:

  - Shaped solution satisfies approved Define outcome.
  - Define is still valid or changes have been returned and approved.
  - Context is still valid or corrected.
  - Minimum experience and required domain are clear.
  - Important assumptions are validated or explicitly accepted as risks.
  - Major uncertainty that could change the solution is reduced.
  - Unnecessary scope is removed and no new requirement entered scope without approval.
  - **Cycle Log Check** has been performed.
  - A human or AI agent can honestly say:

> **I understand what we are building, why this is the smallest correct solution, how it should behave, and what domain it requires. Define and Context still hold, so I can now plan how to implement it.**
