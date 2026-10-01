# Artifact writing

Lifecycle files are compact working memory, not transcripts. Think deeply; record only decisions, consequential reasons, risks, checks, and information needed to resume.

## Applies to every document

- **Active work:** Lifecycle index, Idea, Prototype, Plan, Build, Finalize, and Cycle Log.
- **Permanent knowledge:** Module, support/user, domain, architecture, and engineering-guideline documents.
- **Agent/process guidance:** Skills, references, templates, READMEs, and runbooks.
- **Timing:** Apply when creating or editing a document, then check before presentation or handoff.

Keep the document's required sections and meaning. Tables, diagrams, code, commands, and verbatim evidence keep their appropriate form; surrounding explanations follow these writing rules.

## Writing rules

- **Single point:** Use a short bullet, with a bold label when useful. Brief prose is suitable only for one simple explanatory point.
- **Multiple points under one topic:** Use a short **bold parent topic** and one indented bullet per requirement, condition, exception, or outcome.
- **Parent:** Name the topic; put its details in the children. Keep one supporting level.
- **Separate responsibilities:** Use separate parent topics rather than combining unrelated rules to reduce line count.
- **Concise:** Optimize for scanning, not fewer lines. Preserve every requirement when restructuring.
- Keep necessary technical contracts and proof limits; link the owning source instead of copying it.
- Put lengthy evidence and runbooks behind links when only the conclusion affects review.
- Remove empty sections, instructional comments, and superseded statements. Templates provide shape, not mandatory filler.

## Required format

A bold label alone does not make a paragraph concise. When a bullet contains several independently checkable statements, split it under a bold parent topic.

Instead of:

```md
- **Visibility:** Editors see assigned records; viewers see shared records. Archived records are excluded. No assignment returns an empty list.
```

Write:

```md
- **Visibility**
  - Editors: assigned records.
  - Viewers: shared records.
  - Exclude archived records.
  - No assignment: empty list.
```

Apply this structure throughout every document covered above, including requirements, actions, verification, decisions, explanations, and exceptions. Put multi-command setup/run instructions in separate code blocks or a linked runbook; retain an exact runnable Test Now path beside the step.

## Required compactness pass

Before presenting or handing off any created or edited document:

- **Inspect:** Read the entire document, including every bullet.
- **Split:** Replace each paragraph or bullet containing several distinct points with a bold parent and short supporting bullets.
- **Group:** Confirm each parent owns one responsibility and each child states one point.
- **Preserve:** Check the rewritten points against the source; retain requirements, exceptions, technical contracts, and proof limits.
- **Trim:** Remove repetition, empty sections, instructional comments, and unrelated explanations; link lengthy supporting evidence/runbooks.

Presentation is ready only when every paragraph and bullet meets this format. Correct remaining dense paragraphs and bullets before presentation or approval; fewer lines are not a completion criterion.

## Evidence

Keep evidence beside its check. Mark `[x]` only after observing the expected result on the current implementation. Record actual result and a test result, command output, or manual observation reference; a command/test name alone is not proof. Keep automated, human, pending, blocked, and unrun results distinguishable.

Apply [Proof Limits](completeness.md#proof-limits) and [Gap Acceptance](completeness.md#gap-acceptance) before claiming completion.

## Approval presentation

Present the result, owning artifact link, material gaps, and exact phase/step approval requested. For Build, link its Test Now instructions and identify pending human checks. Keep detailed requirements and evidence in the artifact.

## Index and permanent documents

- `00-lifecycle.md` contains state and navigation: change title, phase/status, approval state, existing artifact links, relevant permanent sources.
- Include current step only during Build; branch/module only when they clarify context.
- Keep scope and decision reasons in their owning phase artifact.
- Permanent docs describe current verified truth, not cycle history or intended but unverified behavior.
- Open Questions contain only consequential unresolved decisions; move settled answers to their owner.

## Mermaid

Use flow, state, sequence, or dependency diagrams when relationships become easier to scan. Keep exact decisions in text. Simple lists and linear steps usually need no diagram.
