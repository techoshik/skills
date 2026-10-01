# Artifact writing

Lifecycle files are compact working memory, not transcripts. Think deeply; record only decisions, consequential reasons, risks, checks, and information needed to resume.

## Writing rules

- Group by responsibility using short headings, labeled bullets, and at most one supporting bullet level.
- Give each point one clear meaning. Separate conditions and outcomes when combining them obscures the requirement.
- Keep necessary technical contracts and proof limits; link the owning source instead of copying it.
- Put lengthy evidence and runbooks behind links when only the conclusion affects review.
- Remove empty sections, instructional comments, and superseded statements. Templates provide shape, not mandatory filler.

## Required compactness pass

Before presenting a lifecycle or permanent document produced by Lifecycle, read the whole document. Split points that need rereading; turn long prose into short labeled points. Remove repetition and unrelated explanations. Link supporting detail and verify that shortening preserved requirements and proof limits.

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
