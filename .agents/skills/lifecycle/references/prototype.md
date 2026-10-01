# Prototype

Resolve important uncertainty that discussion alone cannot settle; prototype for learning.

## Work

1. Load approved Idea. State each uncertainty before creating anything.
2. Choose the cheapest representation: UI variant, Mermaid flow/state/sequence, executable logic, contract/sandbox experiment, or focused spike/measurement.
3. Create only enough to answer it. Exercise realistic normal and edge scenarios, discuss observations, and refine while meaningful uncertainty remains.
4. Capture question, verdict, supporting artifact, and Prototype-owned conclusions immediately in `02-prototype.md`.

Read [Decision Discovery](questioning.md) when consequential choices remain. Link Idea-owned decisions; changed upstream decisions follow [Return to the owner](framework.md#return-to-the-owner).

## Runnable prototypes

Mark executable artifacts temporary. Follow project placement/routing; keep assets under the cycle's `prototype/` when useful, or link an in-app location when that context answers the question better. Provide simple open/run instructions and visible state after actions. Use fake/in-memory or isolated development data unless persistence is the question; protect real data and production systems. Reset scenarios for comparisons and avoid polish unrelated to the question.

Prototype code proves the experiment only. Production behavior is implemented through approved Plan/Build. Retain useful decisions/evidence for Finalize cleanup.

## Complete when

Every important uncertainty needing concrete evidence is resolved enough for Plan. If no prototype adds value, record `Not needed — <reason>`. Both outcomes require the [phase handoff](framework.md#phase-handoff) and approval before Plan.
