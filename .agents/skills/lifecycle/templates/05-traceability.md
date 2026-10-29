# Traceability: <Feature Name>

<!--
HOW THIS FILE WORKS (STRICT):
- Seeded in Roadmap: one row per in-scope AC-X.Y and BR-X (and PM-n at Deep tier), with `Task` filled and `Result` = `Planned`.
- Completed in Review by the auditor from the actual code and checks, not copied from implementer reports.
- Use IDs and a label of at most 8 words. Requirement text stays in 01-requirements.md (single source of truth).
- Cells hold paths, IDs, and short check names only. Put explanations under "Gaps & dispositions".
- `Verified` requires a check that actually ran and passed. A `Not Run` check can never produce `Verified`.
- When a mid-flight change retires an ID, set its Result to `Superseded`; do not delete the row.
-->

> **Quick read:** <Coverage in 1–2 lines, e.g. `AC 14/16 Verified · BR 5/5 Verified · PM 3/3 covered · 2 gaps with dispositions below`>

## Result values

- `Planned` — row seeded in Roadmap; not yet audited.
- `Verified` — implementation located, and a check ran and passed.
- `Not Verified` — implemented, but the check failed, did not run, or cannot run here (say which in `Verified by`).
- `Gap` — required behavior is missing or incorrect in the code.
- `Superseded` — retired by a mid-flight change; kept for history.

## Acceptance Criteria

| ID | Label | Task | Implemented at | Verified by | Result |
|---|---|---|---|---|---|
| AC-1.1 | <≤8-word label> | Task 1 | `path/to/file.ext:42` | `test: path/to/test.ext::name — Passed` | Planned |
| AC-1.2 | <≤8-word label> | Task 1 | `path/to/file.ext:88` | `manual: Task 1 step 3 — Not Run` | Planned |

## Business Rules

| ID | Label | Task | Enforced at | Verified by | Result |
|---|---|---|---|---|---|
| BR-1 | <≤8-word label> | Task 1 | `path/to/file.ext:120` | `test: path/to/test.ext::name — Passed` | Planned |

## Pre-mortem coverage (Deep tier only)

Omit this section for Light and Standard.

| ID | Failure cause | Mitigated in | Verified by | Result |
|---|---|---|---|---|
| PM-1 | <≤8-word cause> | Task 2 / AC-2.1 | `test: path/to/test.ext::name — Passed` | Planned |

## Gaps & dispositions

List every row whose Result is not `Verified` or `Superseded`. Write `*(None)*` when there are none.

- **<ID>:** <`Not Verified` / `Gap`>
  - Why: <1–2 sentences on what is missing or could not be checked>
  - Disposition: `Task N added` / `User accepted (<date>)` / `Deferred — <reason>`
