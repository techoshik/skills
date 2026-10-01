# Decision discovery

## Inspect before asking

Before each round, inspect applicable instructions, settled decisions, module docs, relevant rules, code, config, and tests. Resolve repository/technical facts yourself. Ask the user for unresolved product choices, priorities, preferences, trade-offs, or acceptance. Reconfirm settled answers only when new evidence challenges them.

Surface source conflicts and distinguish current behavior from intended change. Read project terminology; clarify ambiguous terms that change behavior. Exercise normal, failure, boundary, actor, and state scenarios.

## Decision dependencies

Treat questions as a tree: ask the current independent frontier together, settle prerequisites, then recompute after answers or discoveries. Continue independent inspection while unrelated decisions remain open. Never treat an unanswered dependent decision as settled.

For cross-session discovery, record precise questions and unresolved prerequisites in Open Questions. Use `Not yet specified` only for in-scope uncertainty that cannot yet be phrased precisely. Exclusions stay in Decisions with their reason and reopen only through approved scope changes. Use external trackers only when requested.

## Why loop

For each capability or consequential addition establish who needs it, the problem, value, evidence, consequence of omission, and smallest complete solution. Tie technical safeguards to concrete correctness, security, or operational failures. Label assumptions and identify the cheapest useful validation; avoid inventing demand to justify a preferred feature.

## Persistent questioning

Challenge specific contradictions or missing decisions; give an evidence-based recommendation and follow up until consequential uncertainty is resolved. Suggestions need a reason and cost; obtain approval before adding consequential scope.

Stop when need, minimum scope, safeguards, and validation/acceptance of assumptions are settled. A deliberate user choice and accepted trade-off closes the question; no fixed count of questions or repeated challenges is required.

## Recording

Capture settled decisions continuously, replacing superseded points. Keep concise reasons, accepted assumptions/risks, and consequential open questions rather than the interview transcript. Promote approved terminology to the existing permanent source during Finalize; use an ADR only when a consequential trade-off needs durable reasoning under project conventions.
