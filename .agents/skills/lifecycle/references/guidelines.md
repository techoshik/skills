# Project Rules and Engineering Guidelines

## Source of Truth

Project-specific standards belong in permanent project guidance.

Lifecycle skills define **when** to read rules.

The project defines **what** the rules are.

Never assume:

- filenames;
- folder structure;
- class types;
- frameworks;
- naming;
- architecture;
- test conventions.

## Plan

Plan inspects relevant rules and existing patterns.

Do not copy stable conventions into Plan unless they affect:

- technical design;
- build order;
- risk;
- proof.

## Build — Mandatory Preflight

Before every Build Step:

1. Identify touched technologies/layers.
2. Find every applicable rule.
3. Read the rules.
4. Inspect nearby established patterns.
5. Confirm:
   - placement;
   - naming;
   - architecture/layer;
   - dependency direction;
   - structure;
   - test conventions.

If a **consequential** convention is missing, unclear, or contradictory:

> **Stop and ask. Do not invent it.**

Ordinary implementation judgment does not require interruption when:

- the Plan already determines the outcome;
- an existing rule/pattern clearly determines the choice;
- the change is a mechanical consequence of approved work.

## Suggestions vs Authority

The agent may:

- explain a discovery;
- explain why it matters;
- recommend an option.

The agent must not implement an unapproved consequential change outside the Plan.

> **Permission to suggest is not permission to implement.**

## Finalize — Promote Real Learning

When real work exposes a reusable rule gap:

- propose the durable improvement;
- get explicit user approval;
- update the authoritative guideline/checker;
- rerun relevant checks when current work changes.

Update lifecycle skills only for portable process learning.

Do not change guidance merely because Finalize contains Improve.
