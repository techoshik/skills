# Approval and Chat Handoff Policy

## Approval Mode

Persist one mode in `docs/lifecycle/<change>/00-lifecycle.md`:

```text
mode: strict
mode: guided
mode: auto
```

If unspecified, ask once before the first phase. If the user does not answer, use `strict`.

### Guided

Pause for developer approval:

- after Define;
- after Shape;
- after Plan;
- after Verify.

Context may proceed when it only records verified facts and does not invalidate Define.
Build may complete approved slices without per-slice approval unless a deviation appears.

### Strict

Pause after every phase and each Build slice.

### Auto

Continue whenever the current phase gate passes.

Auto does not authorize:

- inventing requirements;
- ignoring conflicting authority;
- bypassing safety/production authorization;
- silently expanding scope.

Refine proposals and destructive workspace cleanup still require explicit user authorization unless the user already gave a standing instruction.

## Persisted State

`00-lifecycle.md` contains:

```text
Approval Mode: Guided | Strict | Auto
Approval Status: Awaiting Developer Approval | Approved | Auto-approved | Blocked
Next Phase: …
Suggested Chat Title: [Phase] - [Feature]
```

A material scope/solution/plan change invalidates earlier approval unless mode is `auto` and no separate authorization is required.

## Chat Handoff

Before ending a phase chat:

1. Write/update the phase artifact.
2. Update `00-lifecycle.md`.
3. Ensure unresolved consequential items are in the artifact, not only chat.
4. Set `Suggested Chat Title`.
5. Name the next phase skill and first artifact to read.

A new chat reads `00-lifecycle.md` first, then only the sources required by the active phase.
