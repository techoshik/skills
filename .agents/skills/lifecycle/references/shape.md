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
- **Prototype risky parts**
- **Loop back when needed** — solution changes problem/value/minimum outcome/scope/success criteria → Define; missing/incorrect system understanding → Context.

> **Shape validates the solution. Plan organizes the implementation.**

## 4. Questions

### Experience

- User Flow
- States & Actions
- Feedback & Errors
- Permissions
- Minimum Experience

### Domain

- Concepts / Entities
- Required Information
- Relationships & Ownership
- Lifecycle / States
- Business Rules
- Required vs Optional

### Validation

- Assumptions
- Risk
- Cheapest Test
- Alternative
- Define Check
- Context Check

## 5. Actions

- Create the minimum user/system flow.
- Define required domain concepts and information.
- Identify important assumptions and risks.
- Validate important uncertainty with the cheapest useful medium: prototype, flow diagram, API contract, conceptual model, architecture sketch, or technical spike.
- Compare shaped solution against Define and Context.
- Remove unnecessary screens, states, fields, concepts, steps, and behaviours.
- Escalate mismatches early rather than continuing with a flawed solution.
- Use **prototype** for cheap experience/state/logic validation.
- Use **domain-modeling** for domain terminology, ownership, lifecycle, and rule stress-testing.
- Use **codebase-design** when module seams/interfaces are material to the solution.

## 6. Output

### Experience Shape

- User Flow / Entry Points
- Key Screens / Interactions / States
- Feedback / Errors / Permissions
- Existing Patterns Reused
- Explicitly Excluded Experience

### Domain Shape

- Core Concepts / Entities
- Required Information
- Relationships / Ownership
- Lifecycle / States
- Business Rules
- Required vs Optional Information

### Validation

- Important Assumptions / Risks
- Validation Method / Learning
- Define Changes Needed
- Context Changes Needed
- Remaining Open Questions

### Shaped Solution

- Minimum Solution
- Why This Solution
- What Was Removed
- What Requires Approval Before Expansion

## 7. Exit

Move to **Plan** only when:

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
