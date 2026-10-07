# Prototype

Resolve important uncertainty that discussion alone cannot settle; prototype for learning.

## Work

1. Load approved Idea. State each uncertainty before creating anything.
2. Determine the required prototype type based on the Idea:
   - **Mandatory UI Prototypes:** Whenever an approved Idea involves user interfaces or user flows, you MUST create a standalone, interactive HTML/Tailwind/JS prototype in the `prototype/` directory. The goal of this throwaway prototype is to visually expose gaps, missing states, and edge cases before the Plan phase.
   - For non-UI tasks, choose the cheapest representation: Mermaid flow/state/sequence, executable logic, contract/sandbox experiment, or focused spike/measurement.
3. For UI Prototypes, adhere to these strict requirements:
   - **Multiple Variants:** Include at least 3 distinct design or layout variants within the same HTML file, with a clear control panel/buttons at the top to toggle between them.
   - **Data States:** Implement toggles to simulate different states (e.g., Empty State, Loading State, Error/Validation State, Data-Heavy State).
   - **Realistic Mock Data:** Use realistic, domain-specific data (avoid *Lorem Ipsum*) to reveal spacing and layout realities.
   - **Basic Interactivity:** Include basic DOM manipulation (via JS) to demonstrate complex flows like modals, dropdowns, or step-by-step forms.
4. Create only enough to answer the uncertainties. Exercise realistic normal and edge scenarios, discuss observations, and refine while meaningful uncertainty remains.
5. Capture question, verdict, supporting artifact, and Prototype-owned conclusions immediately in `02-prototype.md`. Link the interactive HTML file in the artifact with clear instructions for the user to open and click through.

Read [Decision Discovery](../../rules/questioning.md) when consequential choices remain. Link Idea-owned decisions; changed upstream decisions follow [Return to the owner](../../rules/framework.md#return-to-the-owner).

## Runnable prototypes

Use your file-writing tools to generate the interactive HTML prototypes and keep assets under the cycle's `prototype/` directory. For non-UI executable artifacts, mark them temporary and follow project placement/routing.

Provide simple open/run instructions and visible state after actions. Use fake/in-memory or isolated development data unless persistence is the question; protect real data and production systems. Reset scenarios for comparisons and avoid polish unrelated to the question (unless evaluating design variants).

Prototype code proves the experiment only. Production behavior is implemented through approved Plan/Build. Retain useful decisions/evidence for Finalize cleanup.

## Complete when

Every important uncertainty needing concrete evidence is resolved enough for Plan. If no prototype adds value, record `Not needed — <reason>`. Both outcomes require the [phase handoff](../../rules/framework.md#phase-handoff) and approval before Plan.
