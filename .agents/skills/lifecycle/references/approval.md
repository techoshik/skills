# Approval and Chat Handoff Policy

## Approval Mode

Read the requested mode from the user's instruction and persist it in
`docs/lifecycle/<change>/00-lifecycle.md`. The canonical short syntax is:

```text
mode: strict
mode: guided
mode: auto
```

If the request does not specify a mode, ask this once before starting the
first phase:

> Which Lifecycle approval mode should I use? **Strict** (default) pauses
> after every phase and Build slice; **Guided** pauses at the main decision
> gates; **Auto** continues without phase-approval prompts.

If the user does not answer, use `strict`. If the request already specifies a
mode using `mode: <value>`, use it without asking this question. Recognize
these user phrases as
`auto`: “continue automatically”, “do not ask for phase approval”, and “do not
ask permission for each step”. Recognize `strict` when the user asks to review
or approve every phase.

### `guided` — Default

Pause for developer approval at decision gates:

- after Define, before Context;
- after Shape, before Plan;
- after Plan, before Build;
- after Verify, before Refine or cycle closure.

Context may proceed without a separate approval when it only records verified
facts and does not invalidate Define. Build may complete planned slices without
approval after every slice, but must pause when it discovers a plan or scope
deviation.

### `strict`

Pause after every phase, including Context, each Build slice, Verify, and
Refine. Do not start the next phase until the developer approves the current
phase result.

### `auto`

Do not ask for phase-approval prompts. Continue through the lifecycle whenever
the current Exit gate passes, and record each transition as `Auto-approved`.

`auto` removes phase-approval waits; it does not authorize inventing
requirements, ignoring contradictory authority, bypassing production safety,
or taking an action that requires separate user authorization.

## Persisted State

The lifecycle index must contain:

```text
Approval Mode: Guided | Strict | Auto
Approval Status: Awaiting Developer Approval | Approved | Auto-approved | Blocked
Next Phase: …
```

In `guided` or `strict` mode, set `Approval Status` to `Awaiting Developer
Approval` and stop at the applicable gate. In `auto` mode, set it to
`Auto-approved` and continue.

An explicit developer approval applies only to the current phase and its
artifacts. If the scope, solution, or plan changes materially, require a new
approval unless the mode is `auto`.

## Chat Handoff

Treat each phase as independently resumable. Before ending a phase chat:

1. Write the phase artifact.
2. Update `00-lifecycle.md` with phase, status, approval state, and next phase.
3. Record unresolved questions or blockers; do not carry them only in chat.
4. End with a concise handoff naming the next phase skill and the artifact it
   must read first.

A new chat must read `00-lifecycle.md` first, then only the current phase's
required upstream artifacts. It must not reconstruct state from the previous
conversation.

The Lifecycle skill can prepare this handoff, but creating or deleting chat
windows is controlled by the host application. Deleting a completed phase chat
is safe after its artifacts and lifecycle index are updated.
