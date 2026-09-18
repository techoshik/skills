# Lifecycle — Verify

## 1. Purpose

- Prove that the completed feature or module actually delivers the outcome defined in **Define**.
- Verify the system as a whole, not just individual slices.
- Catch integration, regression, workflow, requirement, and code-conformance failures before considering the work complete.

> **Build proves the slices. Verify proves the promise.**

## 2. Inputs

- **Define** — Problem, minimum outcome, business rules, scope, success criteria.
- **Context** — Existing behaviours and affected areas that must remain correct.
- **Shape** — Approved user experience, domain behaviour, states, and rules.
- **Prototype** — Approved standalone prototype and its recorded validation verdict, when Shape created one.
- **Plan** — Features, slices, dependencies, technical approach, planned verification.
- **Verification Strategy** — The approved proof levels, complete workflows, real boundaries, and accepted gaps.
- **Build Results** — Completed slices and verification/conformance results.
- **Engineering Guidelines** — Applicable project rules discovered under `docs/guidelines/`.
- **Running System** — Real integrated implementation.

## 3. Rules

- **Verify against Define** — Success is determined by the approved outcome, not code volume.
- **Behaviour over implementation** — Test what users/systems can actually do.
- **Whole flow over isolated parts** — Slice verification already happened; now verify integration.
- **Real boundaries** — Use actual UI, API, database, permissions, integrations where relevant.
- **Risk-based verification** — Spend more effort where failure matters most.
- **Protect existing behaviour** — Verify affected workflows have not regressed.
- **Code conformance still matters** — Completed changed code must have no known violation of applicable Engineering Guidelines.
- **No new requirements** — Verification does not expand scope because another idea appears.
- **Evidence over assumption** — Do not mark verified because tests should cover it.
- **Group evidence by outcome** — Use bold top-level bullets for outcome, workflow, integration, conformance, failures, and risks; nest individual checks and evidence beneath them.
- **Selective output** — Record meaningful proof and failures, not a field-by-field QA transcript.
- **Failure goes back to its owner** — requirement/success criteria → Define; system understanding → Context; solution/domain → Shape; technical approach → Plan; implementation/conformance defect → Build.

> **A failed verification is information about where the process must loop back.**

## 4. Questions

### Outcome

- Does the solution solve the defined problem?
- Is the minimum valuable outcome fully present?
- Can every approved success criterion be demonstrated?
- Did we build everything required and nothing silently added?

### Behaviour

- Happy Path
- Business Rules
- States / transitions
- Errors / failure cases
- Permissions
- Data creation/update/relationships/persistence

### Integration

- Do features work together?
- Do connected modules/services behave correctly?
- Did the change break anything it touches?
- Do migrations/compatibility requirements hold?

### Conformance

- Does the completed changed code still conform to all applicable files under `docs/guidelines/` after integration/fixes?
- Do required automated engineering/test gates pass?

## 5. Actions

- Run relevant automated test suite.
- Verify each feature through its real UI/API/system flow.
- Run the planned module integration or E2E workflow when the Verification Strategy requires it, and record the command/environment and result as evidence.
- Verify the complete module workflow across slice boundaries.
- Compare actual behaviour directly against Define success criteria.
- When a prototype exists, compare the implemented screens, states, interactions, and responsive behaviour against its validated decisions; record intentional differences and route unapproved solution changes back to Shape.
- Exercise meaningful business-rule, permission, failure, state, and edge cases.
- Check important existing behaviours identified in Context for regression.
- Verify migrations, persistence, integrations, and compatibility where relevant.
- Review the completed change against all applicable files under `docs/guidelines/`.
- Run required formatter/lint/type/architecture/naming/test gates.
- Use **code-review** for independent Guidelines + Spec review.
- Record failures and route them to the owning phase rather than patching around them.
- Use **diagnosing-bugs** for difficult failures.
- Re-run affected verification after every correction.

> **Do not test everything imaginable. Prove everything we promised and protect what we might have broken.**

## 6. Output

### Verification Result

- **Outcome**
  - Overall result and minimum outcome: Pass / Fail / Blocked.
  - Success criteria results.
- **Workflow**
  - Feature/module journey and module/E2E evidence.
- **Business rules**
  - States, permissions, data, and required behavior.
- **Integration**
  - Connected services, persistence, and compatibility.
- **Regression**
  - Affected existing behavior.
- **Conformance**
  - Engineering Guidelines.
- **Gates**
  - Automated gates.
- **Failures**
  - Failures and remaining risks.
- **Loop-back**
  - Owning phase and next action.

### Exit

- **Exit Status:** Pass / Blocked.
- **Evidence:** …
- **Remaining Blockers:** …
- **Next Phase:** Refine.

- Only record meaningful evidence; do not create a huge QA report.

## 7. Exit

- Move to **Refine** only when:

  - Minimum outcome is demonstrably working.
  - Required success criteria pass.
  - Complete feature/module workflow works through the real system.
  - Important business rules, permissions, states, data, and integrations behave correctly.
  - Critical regressions are ruled out or fixed.
  - Completed changed code has no known violation of applicable Engineering Guidelines.
  - Required automated engineering/test gates pass.
  - No unresolved critical verification failure remains.
  - No unapproved scope has entered the result.
  - **Cycle Log Check** has been performed.
  - The AI/developer can honestly say:

> **The completed solution does what we promised, works as a whole, conforms to the applicable Engineering Guidelines, and has not broken the important behaviour around it.**
