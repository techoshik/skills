# Questioning and Decision Discovery

## Purpose

Remove consequential uncertainty without turning the artifact into an interview transcript.

## Inspect Before Asking

Before each question round:

- Read the applicable `AGENTS.md` instructions.
- Read current module docs and relevant project guidelines.
- Read settled decisions in the active lifecycle artifacts.
- Inspect relevant code, configuration, and tests.
- Resolve factual questions from these sources first.
- Ask only unresolved decisions relevant to the current phase.
- When sources conflict, explain the conflict and ask the decision needed.
- Distinguish current behavior from the proposed change.

Do not ask the user to repeat an answer already established by a current authoritative source.

Reconfirm only when new evidence challenges it or the user proposes changing it.

## Design Tree

Treat unresolved decisions as a tree.

- Ask questions in rounds.
- Ask the current independent frontier together when practical.
- Recompute the frontier after each answer.
- An answer may reveal new branches that were impossible to ask well before.
- Continue until no meaningful unanswered branch can materially change the current phase outcome.

## Decision Dependencies

- Establish the current phase outcome before exploring its branches.
- Ask only questions whose prerequisites are settled.
- Give a recommendation when evidence supports one.
- Wait for answers before treating dependent decisions as settled.
- Recompute open questions after each answer or discovered fact.
- Resolve prerequisite questions before questions that depend on them.
- Inspect facts independently while unrelated user decisions remain open.

For discovery spanning sessions, keep a compact map in the owning artifact's Open Questions:

- **Question:** <Precise decision needed>.
  - **Depends on:** <Unresolved prerequisite, only when present>.
- **Not yet specified:** <In-scope uncertainty that cannot yet be phrased precisely>.

Replace vague uncertainty with precise questions when prerequisites become clear.

Keep excluded scope in Decisions with its reason.

Excluded work returns only after an approved scope change.

Read resolved decisions through their owning references.

Use an external tracker only when the user requests it.

## Language and Scenario Checks

- Read relevant project terminology before questioning.
- Clarify ambiguous or overloaded terms that affect behavior.
- Surface contradictions between the user's description, docs, and code.
- Distinguish current behavior from intended changes.
- Exercise concrete normal, failure, and boundary scenarios.
- Check whether the same requirement holds across affected actors and states.
- Capture settled definitions or scenario outcomes in the owning phase artifact.

Promote approved terminology to the project's existing permanent source during Finalize.

Use an ADR only for a consequential trade-off whose reason needs durable preservation.

Follow project conventions for that record.

Routine discovery does not require extra glossary or ADR files.

## Why Loop

Use during Idea and whenever a later phase proposes an addition.

For each proposed capability or consequential addition, establish:

- **User:** Who needs it?
- **Problem:** What difficulty do they face?
- **Value:** Why does solving it matter?
- **Evidence:** What observation supports the need?
- **Without it:** What fails or remains unsolved if it is omitted?
- **Minimum:** What is the smallest complete solution?

Technical safeguards may be justified by correctness, security, or operational needs.

Tie their reason to a concrete failure or affected boundary.

Distinguish evidence from assumptions.

Do not invent demand or reasons to defend a preferred feature.

When evidence is missing, identify the assumption and the cheapest useful validation.

## Persistent Questioning

- Inspect available facts before asking.
- Challenge answers that conflict with approved goals or discovered facts.
- Explain the specific contradiction or missing decision.
- Ask focused follow-ups until consequential uncertainty is resolved.
- Recommend the shortest complete path when useful.
- Suggest supporting capabilities when they address a demonstrated gap.
- State the reason and cost of each consequential suggestion.
- Obtain approval before adding it to scope.
- Defer additions without a sufficient reason.

Stop when:

- the need and intended outcome are clear;
- the minimum scope is defined;
- applicable safeguards are accounted for;
- remaining assumptions have an explicit validation or acceptance decision.

A resolved answer does not need repeated questioning.

Do not require a fixed number of “why” questions.

User disagreement does not itself prove uncertainty remains.

Record a deliberate choice and its accepted trade-off when the user settles it.

## Human vs Agent

Ask the user for:

- product decisions;
- priorities;
- preferences;
- trade-offs;
- authority/acceptance.

Discover yourself:

- repository facts;
- existing architecture and patterns;
- available components/services/models;
- configuration;
- tests;
- documented project conventions;
- technical facts available from trusted project/external sources.

Do not make the user answer facts the agent can inspect.

## No Silent Assumptions

Never silently decide something that can materially change:

- value or scope;
- user-visible behaviour;
- architecture/ownership;
- data semantics;
- build sequence;
- acceptance/verification.

Give a recommendation when a meaningful choice needs one, but the user's decision remains theirs.

## Recording

> **Discovery depth and artifact size are independent.**

Record only:

- finalized decisions;
- concise reasons for consequential scope decisions;
- important unresolved questions;
- accepted assumptions/risks;
- information needed to resume or continue.

For Idea, capture finalized points continuously while questioning. The document is living memory, not an end-of-session report.
