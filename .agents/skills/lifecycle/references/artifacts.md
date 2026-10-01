# Lifecycle Artifact Writing

## Purpose

Lifecycle files are compact working memory.

They help:

- the current conversation stay aligned;
- another session resume quickly;
- the next phase receive only what it needs.

They are not transcripts.

## Writing Rules

- **Goal:** Zero unnecessary cognitive load.
- **Clarity:** Readers understand each point on the first read.
- **Line:** One idea or requirement per bullet.
- **Length:** Short sentences or clearer fragments.
- **Structure:** Replace prose paragraphs with a short section label and bullets.
- **Labels:** Prefer short labels with short values, especially in Specifications.
- **Conditions:** Separate conditions, exceptions, and outcomes into distinct bullets.
- **Hierarchy:** Use sections and at most one level of supporting bullets.
- **Relevance:** Keep only what affects the current decision, action, risk, verification, or handoff.
- **Detail:** Link lengthy evidence or runbooks when reviewers only need the conclusion.
- **Meaning:** Preserve necessary technical contracts, constraints, and proof limits.
- **Ownership:** Link the owning source instead of repeating its content.
- **Maintenance:** Remove empty sections and superseded statements.

## Specification Example

Bad:

```md
### Specification

- The Save button allows editors to save valid changes, remains disabled for viewers, and shows a retryable error if saving fails while keeping the entered values.
```

Good:

```md
### Specification

- **Editor:** Save enabled for valid changes.
- **Viewer:** Save disabled.
- **Save failure:** Retryable error shown.
- **Save failure:** Entered values retained.
```

Labels should describe the actual requirement.

Templates provide shape, not mandatory content.

## Required Compactness Pass

Before presenting any lifecycle or permanent document produced by Lifecycle:

- Read the complete document once.
- Split every bullet that needs rereading.
- Split every bullet containing multiple points.
- Replace remaining prose paragraphs with labeled sections and bullets.
- Remove repetition and explanations that do not affect the current review.
- Link supporting detail that belongs outside the primary document.
- Check that shortening preserved necessary technical meaning.
- Remove unused template sections and instructional comments.

Finish only when each point is understandable on the first read.

## Evidence

- Keep evidence beside the check it supports.
- Mark a check complete only after observing the expected result.
- Record the actual result.
- Link the test, command output, or manual observation supporting it.
- A method name alone is not evidence.
- Keep automated proof distinct from pending human checks.

Example format; replace placeholders with observed evidence:

```md
- [x] **Restart:** Saved token restored.
  - **Result:** Passed.
  - **Evidence:** <test or recorded observation link>.
```

## Approval Presentation

After the required compactness pass, present:

- **Result:** What is ready for review.
- **Gaps:** Material limitations, only when present.
- **Document:** Link to the owning artifact.
- **Approval:** Name the phase or completed Build Step being approved.

Keep the request short.

Let the linked artifact carry the detailed requirements and evidence.

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

Apply these writing rules and the required compactness pass to module/support/process documents produced by Lifecycle.

Permanent documents describe current truth.

Lifecycle documents describe the active change.

Do not copy lifecycle history into permanent documentation.
