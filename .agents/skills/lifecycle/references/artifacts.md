# Lifecycle Artifact Writing

## Purpose

Lifecycle files are compact working memory.

They help:

- the current conversation stay aligned;
- another session resume quickly;
- the next phase receive only what it needs.

They are not transcripts.

## Writing Rules

- One idea per line.
- Prefer short bullets.
- Prefer short sentences.
- Avoid paragraphs.
- Avoid long compound sentences.
- Use shallow hierarchy.
- Keep only information that changes:
  - understanding;
  - decisions;
  - action;
  - risk;
  - proof.
- Omit empty headings.
- Remove outdated statements when decisions change.
- Reference another source instead of copying it.

## When One Line Is Not Enough

Use a short parent point with sub-bullets.

Example:

```md
- **Login controller**
  - Calls the login use case.
  - Owns loading state.
  - Exposes login errors.
```

Do not compress several ideas into one long sentence.

## Evidence

Keep evidence beside the point it supports.

Example:

```md
- **Token survives restart**
  - Proof: integration test.
```

## Open Questions

Only keep questions that can materially change the current phase.

Remove a question when it is resolved.

Move the decision to its owning section.

## Mermaid

Use Mermaid only when relationships are clearer visually.

Useful forms:

- flowchart;
- state diagram;
- sequence diagram;
- dependency graph.

The diagram supports the artifact.

Exact decisions remain as short written points.

## Permanent Documents

Use the same compact style for module/support/process documents when practical.

Permanent documents describe current truth.

Lifecycle documents describe the active change.

Do not copy lifecycle history into permanent documentation.
