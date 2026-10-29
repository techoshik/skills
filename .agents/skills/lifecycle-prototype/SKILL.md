---
name: lifecycle-prototype
description: Test important UX alternatives and interaction states in a browser prototype, then synchronize the selected design into requirements (Lifecycle: Prototype).
---

# Lifecycle Prototype

Use prototypes to reduce uncertainty about user experience before production code is written. The goal is a clear, testable design—not to produce a fixed number of HTML files. Keep the existing Prototype approval gate and user choice.

## 0. Phase Rules & Guardrails

- **Prototype decisions, not decoration:** Explore differences in information hierarchy, navigation, interaction flow, or recovery behavior. Color/font variations do not count as distinct options unless visual styling is the actual decision.
- **Scale exploration to uncertainty:** Small changes that follow an established pattern may need one focused prototype. A meaningful design decision usually benefits from two alternatives; use a third only when it offers a genuinely different viable approach. High-risk or unfamiliar workflows deserve broader exploration.
- **Show relevant states:** Include the states that affect the design decision, such as populated, empty, loading, error, validation, permission-denied, success, or destructive confirmation. Do not force all five legacy states into every component when a state does not apply.
- **Preserve existing project conventions:** Prototypes are conceptual references. Production code must follow `.agents/rules/`, the canonical design system, and existing architecture.
- **Explain meaningful trade-offs:** For each option, briefly state what it optimizes for, what it costs, and when it is appropriate. A visually complete prototype is not proof that the underlying workflow is correct.

## Step 1: Entry Gate and Design Scope

1. Read `lifecycle/00-status.md`, `01-requirements.md`, and the Resume Checkpoint. Confirm Brainstorm is `Done`.
2. Set Prototype to `In Progress`.
3. Identify the specific screen, composite component, or workflow where visual or interaction uncertainty remains. Do not create variants for atomic primitives such as an ordinary button unless the button's behavior is the decision.
4. List the user goal, entry point, primary path, relevant edge states, and requirements that the prototype must satisfy.
5. Select the exploration depth:
   - **Focused:** One prototype for a minor, low-uncertainty adjustment.
   - **Comparative:** Two viable alternatives for a meaningful UX decision.
   - **Broad:** Two or three structurally different options for a complex or high-impact flow.

If the user-facing design is already fully determined and a prototype would not answer a real question, explain the reason and ask whether to skip. Do not silently skip the phase.

**Gate:** The prototype's purpose and the decision it should help resolve are explicit.

## Step 2: Build Useful Alternatives and States

For each substantive UI unit:

1. Create only the number of alternatives justified in Step 1. Keep them lightweight, self-contained, and focused on the decision.
2. Make options structurally different where appropriate (for example, a direct unified card/inline flow vs. a modal/drawer/step-by-step guided flow vs. a compact/expandable consolidated view).
3. **Interactive State-Toggle Bar:** Include a sticky top control bar inside each option HTML file with minimal JS to toggle between the relevant interactive states (`Populated`, `Empty`, `Loading`, `Error`, `Edge / Modal`, or feature-specific states). Each state should demonstrate a requirement, risk, or design choice—not merely fill a template.
4. **Self-Contained HTML:** Embed `<style>` and the minimal JS state switcher directly inside each option HTML file (no shared external CSS files that break standalone viewing).
5. Use realistic sample content and labels so the information hierarchy can be judged. Do not use real customer secrets or production credentials.
6. Keep each HTML file comfortably maintainable (`<350` lines guide); a line-count guide is not a reason to remove useful state behavior or split a tiny prototype unnecessarily.
7. Add flow diagrams when the workflow has meaningful branching, approval, state transitions, retries, or cross-screen dependencies. Omit diagrams that merely restate an obvious one-step interaction.

Expected directory pattern when multiple prototypes are useful:

```text
lifecycle/
├── 02-prototype.html
└── prototype/
    └── <unit>/
        ├── option-1.html
        └── option-2.html
```

An `option-3.html` may be added when it contributes a real alternative. For a focused prototype, a single file is acceptable; adapt the hub accordingly.

**Gate:** The prototype helps compare the intended behavior and the relevant states without unnecessary UI variants.

## Step 3: Assemble the Prototype Hub

1. Use [Prototype Hub Template](../lifecycle/templates/02-prototype.html) as the starting point when a hub is useful. Fill its `Needs your decision` banner with the choice being asked.
2. Ensure every visible option control points to the correct existing file; remove unused placeholder buttons and frames.
3. Add concise descriptions of the actual trade-offs between options.
4. Add modular Mermaid diagrams only for non-trivial flows (`5–10` nodes max per sub-flow). Keep each diagram small enough to read and split a complex process into meaningful subflows. Mermaid loads from a CDN; offline, the hub shows the diagram source as text, so keep node labels readable as plain text.
5. Open or otherwise validate the generated HTML where the environment supports it. Report if browser verification is unavailable rather than claiming the prototype was tested.

**Gate:** The hub opens, links to valid prototype files, and displays the intended alternatives/diagrams.

## Step 4: Discoveries and Requirements Sync

1. Compare the prototype with `01-requirements.md` and the relevant `REQ`, `AC`, and `BR` IDs.
2. If the prototype reveals a missing requirement, unclear state, conflicting flow, or important simplification, update the relevant requirement in place (`Section 1`, `Section 2`, `Section 3`). Preserve stable IDs when meaning remains the same; retire superseded behavior explicitly.
3. Mark a discovered but unresolved material decision as `Needs User Decision`; do not infer user approval from a prototype being available.
4. Keep `01-requirements.md` as the authoritative behavior/specification and the prototype as a visual reference. Do not duplicate full requirement text in the HTML hub.
5. Log meaningful workflow friction in `04-refine.md`.

**Gate:** The requirements and prototype agree; unresolved decisions are visible.

## Step 5: User Review and Handoff

1. Set Prototype to `In Review` and update the Resume Checkpoint in `00-status.md`.
2. Present the Approval Request block (Section 4 of [`lifecycle/SKILL.md`](../lifecycle/SKILL.md)), linking `lifecycle/02-prototype.html`, in plain bullets (no chat tables or raw Mermaid):
   - **What I did:** The decision the prototype is meant to resolve and the options built.
   - **What to check:** The meaningful trade-off of each option and any state, risk, or question that needs feedback.
   - **What I need from you:** Select an option, combine elements, request a simpler approach, or reject all options.
3. Keep the `Needs your decision` line in `01-requirements.md` pointing at this choice until it is answered.
4. Stop and wait for the user's choice where approval is required.
5. After selection, record the chosen design under `## 4. Selected UI/UX Specification` in `01-requirements.md`, replace any outdated behavior in Section 1 and Section 2 in place, verify consistency, mark Prototype `Done` in `00-status.md`, update the Resume Checkpoint, read [`lifecycle-roadmap/SKILL.md`](../lifecycle-roadmap/SKILL.md), and auto-advance to Roadmap.

Do not treat a prototype choice as permission for new unrelated scope or an unapproved business rule.
