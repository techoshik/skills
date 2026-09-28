# Questioning and Decision Discovery

## Purpose

Remove consequential uncertainty without turning the artifact into an interview transcript.

## Design Tree

Treat unresolved decisions as a tree.

- Ask questions in rounds.
- Ask the current independent frontier together when practical.
- Recompute the frontier after each answer.
- An answer may reveal new branches that were impossible to ask well before.
- Continue until no meaningful unanswered branch can materially change the current phase outcome.

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
- acceptance/proof.

Give a recommendation when a meaningful choice needs one, but the user's decision remains theirs.

## Recording

> **Discovery depth and artifact size are independent.**

Record only:

- finalized decisions;
- important unresolved questions;
- accepted assumptions/risks;
- information needed to resume or continue.

For Idea, capture finalized points continuously while questioning. The document is living memory, not an end-of-session report.
