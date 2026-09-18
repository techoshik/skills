# Lifecycle — Build

## 1. Purpose

- Implement the approved Plan **one vertical slice at a time**.
- Keep the amount of code being held, reviewed, and verified at any moment small.
- Produce working behaviour continuously instead of waiting for the whole feature.

> **Build one slice. Prove it works and conforms. Then continue.**

## 2. Inputs

- **Approved Plan** — Feature order and vertical slices.
- **Current Slice** — The one slice being implemented now.
- **Shape Artifacts** — Approved prototype, domain model, flows, contracts, relevant design decisions.
- **Relevant Context** — Existing code, patterns, dependencies, constraints, current behaviour.
- **Engineering Guidelines** — Authoritative rules under `docs/guidelines/` for architecture, placement, naming, structure, dependencies, tests, and other conventions applicable to this slice.
- **Verification Method** — The proof already defined for this slice.

## 3. Rules

- **One slice at a time** — Do not start later slices while the current slice is unfinished.
- **Follow the Plan** — Build what was approved; do not redesign while implementing.
- **Minimum change** — Change only what the current slice requires.
- **Load guidelines before editing**:
  - Identify affected technologies and areas.
  - Discover and read all applicable files under `docs/guidelines/`.
  - Stop when guidance is missing or contradictory; do not guess.
- **Guidelines are a gate, not a suggestion** — A working slice that violates applicable project guidelines is incomplete.
- **Test important behaviour first** — For meaningful behaviour, define proof before implementation and use **Specify → Red → Green → Refactor → Verify**.
- **Do not force low-value tests** — Test business behaviour, contracts, integrations, and meaningful interactions; do not create ceremonial tests.
- **Build planned proof before Verify** — Create or update planned module integration/E2E tests, fixtures, and test-environment setup alongside the behavior; Verify is not the place to invent the test strategy.
- **Test behaviour, not implementation trivia.**
- **Reuse existing patterns** — Do not create new abstractions when existing ones fit.
- **No silent scope expansion** — Discoveries may be mentioned, never silently implemented.
- **Group the slice record** — Use bold top-level bullets for outcome, changes, proof, conformance, and deviations; nest the supporting evidence beneath them.
- **Selective output** — Record only meaningful slice evidence; omit empty or inapplicable fields.
- **No unrelated cleanup** — Do not refactor neighbouring code merely because improvement is possible.
- **Keep the system working** — Prefer small changes that leave the codebase valid.
- **Temporary means temporary** — Mock/temporary data used during UI work must be removed during Connect.
- **Verify before continuing** — Compile/tests alone are not completion; exercise the real UI/API/technical boundary.
- **Do not hide deviations** — If implementation must differ from Plan, stop and surface it.
- **Loop back to the owner** — requirement/value/scope → Define; system understanding → Context; solution/domain → Shape; implementation approach → Plan.

> **Build is not authorized to repair earlier mistakes by silently inventing a new plan.**

## 4. Questions

### Before a slice

- **Slice** — What observable capability am I implementing?
- **Boundary** — What belongs to this slice and what does not?
- **Dependencies** — Are prerequisites actually available?
- **Existing Pattern** — What implementation should I reuse?
- **Guidelines** — Which files under `docs/guidelines/` apply to the technologies/layers being touched?
- **Proof** — What automated and real-world evidence proves completion?

### During implementation

- **Mismatch** — Anything inconsistent with Plan, Shape, Context, or Define?
- **Extra Work** — Is this change truly required?
- **Risk** — Am I changing behaviour outside the slice?
- **Uncertainty** — Am I about to guess?
- **Conformance** — Am I drifting from naming, placement, structure, architecture, testing, or dependency rules?

## 5. Actions

- For each slice execute:

  1. **Model** — Create/update only models, types, states, fields, contracts required by this slice.
  2. **UI** — Implement the approved portion of the prototype; temporary/mock data only where useful.
  3. **Backend** — Implement required database, repository, service, API, permissions, integrations, migrations, or other backend work.
  4. **Connect** — Connect real UI/API behaviour and remove temporary shortcuts.
  5. **Verify** — Exercise the real behaviour through its actual boundary.

- For every meaningful behaviour inside those steps, use the test-first loop where appropriate:

  - **Specify** — Define expected behaviour.
  - **Red** — Write the failing test/executable proof.
  - **Green** — Implement minimum code required to pass.
  - **Refactor** — Improve structure without changing behaviour.
  - **Verify** — Confirm integrated slice through the real UI/API/technical boundary.

- Use **tdd** for the behavioural loop. Use **diagnosing-bugs** when failure is non-obvious.

- After behaviour passes, run the mandatory **Slice Conformance Review**.

### Slice Conformance Review

- Review **all changed and newly created code** against every applicable guideline under `docs/guidelines/`:

  - folder and file placement;
  - file and folder naming;
  - class, interface, type, method, and member naming where applicable;
  - internal file/class/interface structure;
  - correct architectural layer and dependency direction;
  - existing patterns reused where appropriate;
  - test placement/naming/style conventions;
  - no unnecessary abstraction or speculative generality;
  - no unrelated changes;
  - no temporary/mock code left unintentionally;
  - required formatter, lint, type, architecture, naming, test, and other deterministic checks.

- Use **code-review** to review changed code against guidelines and the approved spec/slice.

- Fix every discovered deviation, rerun affected automated checks, and reverify affected real behaviour. Only then close the slice.

> **Model → UI → Backend → Connect → Verify → Conformance → Next Slice**

## 6. Output

### Slice Result

- **Outcome**
  - Slice and result: Pass / Blocked.
- **Changes**
  - Meaningful implementation changes.
- **Automated proof**
  - Tests, executable checks, and their results.
- **Real verification**
  - Actual UI/API/technical boundary exercised and its result.
- **Conformance**
  - Pass / Blocked, with relevant evidence.
- **Deviations**
  - Discoveries or deviations, only when relevant.

### Exit

- **Exit Status:** Pass / Blocked.
- **Evidence:** …
- **Remaining Blockers:** …
- **Next Phase:** Next slice / Verify.

- Keep the record small. The primary output is working, verified, conformant code.

## 7. Exit

- Move to the next slice only when:

  - Planned behaviour is implemented.
  - Meaningful behaviour is protected by appropriate automated tests/executable proof where useful.
  - Temporary development implementations are removed.
  - Relevant code-level checks pass.
  - Actual behaviour has been exercised through its real verification boundary.
  - All changed/new code conforms to applicable Engineering Guidelines.
  - Required deterministic checks pass where available.
  - Conformance fixes have been retested and affected real behaviour reverified.
  - No unresolved deviation from Plan remains.
  - No earlier phase has been invalidated.
  - **Cycle Log Check** has been performed for the slice.
  - The AI/developer can honestly say:

> **This slice works as planned, its changed code conforms to the applicable Engineering Guidelines, I have reverified it after any corrections, and I can now safely move to the next slice.**

- After all planned slices are complete, move to **Verify**.

> **Slice Verify proves the thing just built works. The Verify phase proves the completed feature/module works as a whole and still satisfies Define.**
