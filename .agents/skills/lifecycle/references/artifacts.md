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
  - verification.
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

## Compaction Pass

Before presenting any lifecycle artifact for approval:

- Read the complete artifact once.
- Keep one idea per line.
- Split bullets with multiple independent ideas.
- Prefer:
  - short parent point;
  - short sub-bullets.
- Remove repeated information.
- Remove wording that does not help:
  - understand;
  - decide;
  - act;
  - verify;
  - resume.
- Keep necessary meaning.

The final artifact should be easy to scan without reading paragraphs.

## Evidence

Keep evidence beside the point it supports.

Example:

```md
- **Token survives restart**
  - Verification: integration test.
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
