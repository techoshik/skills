---
name: lifecycle
description: "Run the project's Define → Context → Shape → Plan → Build → Verify → Refine development lifecycle."
disable-model-invocation: true
---

# Development Lifecycle Orchestrator

Use this skill as the normal entry point for development work.

## Load

Read:

- `references/framework.md`
- `references/cycle-log.md`
- `references/third-party-skills.md` only when specialist-skill selection is relevant.

## Authority

The lifecycle is the process authority. Phase artifacts and project Engineering Guidelines are the work authority. Specialist skills are techniques only and must not override either.

## Backlog Awareness

Permanent future opportunities live in `docs/backlog/`.

- The lifecycle may search, surface, and recommend backlog items.
- Human owns priority; the lifecycle must not automatically promote a backlog item into active work.
- When a backlog item is selected, start a new lifecycle at Define.
- Treat old backlog information as input to revalidate, not as an already-approved requirement.

## Locate or Create the Lifecycle Workspace

Use `docs/lifecycle/<change-name>/`.

The workspace should contain:

- `00-lifecycle.md` — current state and artifact index.
- numbered phase files created as phases begin.
- `cycle-log.md` — improvement memory for the active cycle.

If the work is new, initialize from `.agents/skills/lifecycle/templates/`.

If the work already exists, read `00-lifecycle.md` first. Do not reconstruct state from conversation history when lifecycle artifacts exist.

## Determine the Current Phase

Use the latest approved artifact and its Exit gate:

- no approved Define → `lifecycle-define`
- Define approved, Context incomplete → `lifecycle-context`
- Context approved, Shape incomplete → `lifecycle-shape`
- Shape approved, Plan incomplete → `lifecycle-plan`
- Plan approved, slices incomplete → `lifecycle-build`
- all planned slices complete, whole solution unverified → `lifecycle-verify`
- Verify passed, cycle not closed → `lifecycle-refine`

If a later phase invalidates earlier work, route back to the phase that owns the problem.

## Run One Phase at a Time

Invoke the matching `lifecycle-*` phase skill.

Keep the active phase's completion criterion in focus. Do not load every later phase merely because it exists.

After the phase skill finishes:

1. Confirm its Exit gate actually passes.
2. Perform the Cycle Log check required by that phase.
3. Update `00-lifecycle.md` with the current phase/status and relevant artifact references.
4. Move forward only when the gate passes.
5. If the gate fails, remain in the phase or loop back to the owning phase.

## Context Discipline

Load only what the current phase needs:

- `00-lifecycle.md`
- approved upstream phase artifacts relevant now
- relevant permanent module docs under `docs/modules/`
- relevant Engineering Guidelines under `docs/guidelines/`; read `references/guidelines.md` before Build or Verify work
- actual code/implementation needed for the current decision
- Cycle Log only as required by the current phase; Refine loads the full log
- `docs/backlog/` contains permanent future opportunities and may be consulted when relevant.

Do not duplicate stable information into every artifact. Reference permanent sources where possible.

## Third-Party Skills

Use specialist skills when they reduce uncertainty or improve execution. In particular:

- Define: `grill-with-docs`, `wayfinder`
- Context: `research`, `domain-modeling`
- Shape: `prototype`, `domain-modeling`, `codebase-design`
- Plan: `wayfinder`, `to-tickets`
- Build: `tdd`, `diagnosing-bugs`, `code-review`
- Verify: `code-review`, `diagnosing-bugs`
- Refine: `improve-codebase-architecture`, `writing-for-agents`, `code-review`

If unavailable, continue using the lifecycle phase directly.

## Close the Cycle

Refine owns cycle closure.

Before closure:

- useful Cycle Log learning is promoted to its permanent source;
- permanent module documentation under `docs/modules/<module>/` reflects the system as it exists now;
- implementation refinements are reverified;
- future requirements are explicitly separated from completed work.

Then archive/remove the temporary lifecycle workspace according to project policy.

> **The orchestrator remembers where we are. The phase skill remembers how to work. The artifacts remember what we know. Specialist skills provide techniques.**
