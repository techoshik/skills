# Requirements: <Feature Name>

<!--
DOCUMENT FORMATTING & SINGLE-TRUTH RULES (STRICT):
- SCANNABLE SUB-BULLETS: Keep bullets concise (1 line = 1 atomic detail). Avoid multi-sentence prose walls inside bullets.
- NO CONTRADICTIONS: When a requirement or UX decision changes, replace superseded lines in place across all sections so this file always reflects a single coherent truth.
- VISIBLE TO ALL: Never hide active requirements, acceptance criteria, or touchpoints in HTML comments or collapsed tags.
- EVIDENCE LABELS: Tag material statements as [Fact] (cite `path:line`, command, or URL), [Decision] (user-approved), [Assumption], [Recommendation], or [Open]. Untagged lines are routine requirement text. Never tag [Fact] without a source.
- RATIONALE: One optional `Why:` line (max 2 sentences) is allowed under a requirement or decision. It is the only prose allowed inside a bullet.
-->

> **Quick read:** <In 2–4 short lines, explain the problem, who is affected, the intended outcome, and the scope boundary. Keep this summary high-level; detailed behavior belongs below.>
>
> **Depth tier:** `<Light / Standard / Deep>` — <trigger(s) that set it, or "no Deep trigger applies">
>
> **Needs your decision:** <`None — ready for sign-off`, or 1 line per open user-owned decision: topic → link to Section 5 / 9 → recommended default>

---

## Part 1: Product & UX Specification (Human Sign-Off)

## 1. Problem, Outcome & User Flow

- **Problem:**
  - [Fact] <The user or operational pain point, not just the requested implementation> (source: `path:line` or user report)
  - [Fact] <Why current behavior or UX falls short> (source)
- **Desired outcome:**
  - <What should become possible or improve>
- **Users & context:**
  - <Who uses it and from where, when relevant>
- **Scope boundary:**
  - In scope: <Capabilities needed to deliver the outcome>
  - Out of scope: <Only meaningful exclusions; omit if none>
- **Primary user flow (simplified):**
  1. <Step 1 of the clean end-to-end path from entry to observable result>
  2. <Step 2 of the user journey (noting any redundant tabs/screens consolidated or removed)>
- **Experience delta (what changes):**
  - **<Dimension / Screen Flow>:**
    - Before: <1-line current behavior or pain point>
    - After: <1-line intended new behavior>
  - **<State / Logic Handling>:**
    - Before: <1-line current behavior or limitation>
    - After: <1-line intended new behavior>
<!-- For bug fixes or refactors, include Root-Cause Analysis:
- **Root-cause analysis (bug fix / refactor):**
  - Current behavior: <What fails today>
  - Expected behavior: <What should happen instead>
  - Verified root cause: <Exact file/symbol and why it fails>
  - Regression guardrail: <Test or invariant preventing recurrence>
-->

## 2. Requirements & Acceptance Criteria

Write requirements as observable capabilities and acceptance criteria as independently testable conditions. Keep stable IDs. Execution checkboxes are tracked in `03-roadmap.md`.

- **REQ-1 — <Capability>:**
  - <1-line summary of what the system must do and for whom>
  - Why: <Optional — max 2 sentences on the user need behind this requirement>
  - **AC-1.1:** <Observable binary pass/fail condition>
  - **AC-1.2:** <Observable binary pass/fail condition>
- **REQ-2 — <Capability>:**
  - <1-line summary of what the system must do>
  - **AC-2.1:** <Observable binary pass/fail condition>

## 3. Business Rules & Invariants

Include the non-negotiable rules that affect correctness, permissions, validation, state transitions, tenancy, concurrency, audit, or data lifecycle. Omit this section only when no special invariants apply.

- **BR-1 (<Rule Name>):** <Single-line rule that must always hold>
- **BR-2 (<Rule Name>):** <Single-line rule that must always hold>

## 4. Selected UI/UX Specification

Include this section when a prototype or meaningful UX decision exists; otherwise omit it.

- **Selected design:**
  - `<Screen / Component>`: <Chosen option or deliberate combination and link to `02-prototype.html`>
- **Confirmed interactions & states:**
  - <1-line locked UX/state behavior that must be preserved in implementation>
- **Reason for choice:**
  - <1-line key trade-off or user need the design serves>

---

## Part 2: Technical & Agent Reference

## 5. Consequential Decisions & Assumptions

Record decisions that materially affect behavior, architecture, risk, or future maintenance—not every routine implementation detail.

- **Decision 1 — <Topic>:**
  - Status: `Confirmed` / `Proposed` / `Needs User Decision`
  - Chosen / recommended approach: <1-line option summary>
  - Alternatives considered: <Credible alternative(s) and their material trade-offs>
  - Why this wins: <Evidence and most important reason this option fits>
  - Consequences & risks: <Material side effects, failure cases, compatibility, or future costs>
  - Confidence & evidence: <What was verified and what could change the decision>

### Pre-mortem (Deep tier only)

Assume the change shipped and failed. List the top 3 causes and map each to a mitigation. Omit this block for Light and Standard.

- **PM-1 — <Failure cause>:**
  - Likelihood / impact: `Low` / `Medium` / `High`
  - Mitigated by: <`Task N` and/or `AC-X.Y` / `BR-X`> — or `Risk accepted by user (<date>)`
- **PM-2 — <Failure cause>:**
  - Likelihood / impact: `Low` / `Medium` / `High`
  - Mitigated by: <`Task N` and/or `AC-X.Y` / `BR-X`> — or `Risk accepted by user (<date>)`
- **PM-3 — <Failure cause>:**
  - Likelihood / impact: `Low` / `Medium` / `High`
  - Mitigated by: <`Task N` and/or `AC-X.Y` / `BR-X`> — or `Risk accepted by user (<date>)`

List assumptions explicitly as `[Assumption]` lines when they influence implementation. Ask the user instead of recording an assumption when the unresolved choice materially affects business behavior, authorization, financial/data outcomes, destructive operations, or the user experience.

## 6. Impact, Reusable Code & Dependencies

List important reusable building blocks, directly modified files, 2nd-order caller ripple impacts, schemas/rules, and permanent documentation once.

- **Reusable Code (Use As-Is):**
  - **<Widget / Validator / Helper / Service>:**
    - File: `<path/to/file>`
    - Description: <1-line role and how this existing code will be reused>
- **Affected Code (Direct Modifications):**
  - **<Screen / Controller / Model / Repository>:**
    - File: `<path/to/file>`
    - Description: <1-line role and summary of changes>
- **Caller Ripple Effects (2nd-Order Impact):**
  - **<Upstream / Downstream Caller>:**
    - File: `<path/to/file>`
    - Description: <1-line impact from model, getter, route, or signature changes>
- **Data, Schemas & Migrations:**
  - <Relevant schema, index, permission rule, migration, or side effect; omit when not applicable>
- **Project Rules:**
  - `.agents/rules/<rule>.md`
- **Permanent Docs:**
  - `docs/modules/<module>/README.md`
  - `docs/modules/<module>/feature_<name>.md`

## 7. Glossary Updates

Include only new or clarified project-specific terms that could otherwise be misunderstood. Omit if none.

- **`<Term>`:** <1-line unambiguous business definition (synced to `GLOSSARY.md` in Finalize)>

## 8. Deferred Scope

Include only meaningful ideas explicitly excluded from the current outcome. Explain why they are deferred. Never defer necessary validation, security, error handling, data integrity, or migration work merely to shorten the plan. Omit if none.

- **`<Capability>`:** <1-line reason deferred and any dependency or follow-up condition>

## 9. Open Questions & Research

Keep this section visible (showing `*(None - all resolved)*` when empty, or listing active items) so new questions or research items can be added and resolved at any stage before advancing.

- **[Open] Question / uncertainty:** <Specific issue (or `*(None - all resolved)*`)>
  - Why it matters: <How the answer may change the solution>
  - Owner: `User` / `Agent` / `External`
  - Blocking: `Yes` / `No`
  - Next step: <Question to ask or evidence to gather>
