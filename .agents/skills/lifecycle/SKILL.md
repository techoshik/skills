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
- `references/approval.md`
- `references/third-party-skills.md` before selecting or using a companion skill.

Before selecting the first phase, determine the approval mode using
`references/approval.md`. If the request does not specify a mode, ask the
approval-mode question once and use `Strict` when the user gives no answer.
Prefer the canonical short syntax `mode: strict`, `mode: guided`, or
`mode: auto` when interpreting or documenting the selected mode.
Persist the mode in `00-lifecycle.md`; later phase chats must read it and must
not ask again.

## Authority

The lifecycle is the process authority. Phase artifacts and project Engineering Guidelines are the work authority. Companion skills are techniques only and must not override either.

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
- approval mode, approval status, next phase, and suggested chat title in
  `00-lifecycle.md`.
- numbered phase files created as phases begin.
- `cycle-log.md` — improvement memory for the active cycle.

If the work is new, initialize from `.agents/skills/lifecycle/templates/`.

If the work already exists, read `00-lifecycle.md` first. Do not reconstruct state from conversation history when lifecycle artifacts exist.

## Determine the Current Phase

Use the latest approved artifact and its Exit gate. In `auto` mode,
`Auto-approved` is an approved transition:

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

Apply `references/approval.md` after each phase. In `guided` or `strict` mode,
stop at the required approval gate. In `auto` mode, record `Auto-approved` and
continue without a phase-approval prompt.

When a phase chat ends, leave a concise handoff in the final response naming
the next phase skill, the suggested title `[Next Phase] - [Feature]`, and the
artifact it should read first. The host application, not the skill text,
controls creating, naming, or deleting chat windows.

## Context Discipline

Load only what the current phase needs:

- `00-lifecycle.md`
- approved upstream phase artifacts relevant now
- relevant permanent module docs under `docs/modules/`
- relevant Engineering Guidelines under `docs/guidelines/`; read `references/guidelines.md` before Build or Verify work
- actual code/implementation needed for the current decision
- Cycle Log only as required by the current phase; Refine loads the full log
- `docs/backlog/` contains permanent future opportunities and may be consulted when relevant.

For every change that fixes a bug, changes existing functionality, or adds new
functionality, identify the affected module(s) and read each existing canonical
module document at `docs/modules/<module>.md` during Context, before shaping or
editing code. Record the document paths read in `02-context.md`. If an affected
module has no document, record that context gap; create the document during
Refine after Verify rather than inventing permanent documentation mid-change.

Do not duplicate stable information into every artifact. Reference permanent sources where possible.

## Required Companion Skills

Use the required companion skills when their phase mapping applies:

- Define: `grill-with-docs`, `wayfinder`
- Context: `research`, `domain-modeling`
- Shape: `prototype`, `domain-modeling`, `codebase-design`
- Plan: `wayfinder`, `to-tickets`
- Build: `tdd`, `diagnosing-bugs`, `code-review`
- Verify: `code-review`, `diagnosing-bugs`
- Refine: `improve-codebase-architecture`, `writing-for-agents`, `code-review`

If a required companion skill is not installed, stop and report the setup requirement before continuing.

## Close the Cycle

Refine owns cycle closure.

Before closure:

- useful Cycle Log learning is promoted to its permanent source;
- permanent module documentation under `docs/modules/<module>.md` reflects the system as it exists now;
- implementation refinements are reverified;
- future requirements are explicitly separated from completed work.

Then archive/remove the temporary lifecycle workspace according to project policy.

> **The orchestrator remembers where we are. The phase skill remembers how to work. The artifacts remember what we know. Companion skills provide techniques.**
