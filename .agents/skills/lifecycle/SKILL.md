---
name: lifecycle
description: Run the project's Idea → Prototype → Plan → Build → Finalize development lifecycle.
disable-model-invocation: true
---

# Lifecycle

## Required entry

Read [Framework](references/framework.md) and [Artifact Writing](references/artifacts.md). Resume from `docs/lifecycle/<change-name>/00-lifecycle.md` and verify approval state before choosing a phase.

## Route

| State | Read next |
| --- | --- |
| No approved Idea | [Idea skill](../lifecycle-idea/SKILL.md) |
| Idea approved; Prototype unresolved | [Prototype skill](../lifecycle-prototype/SKILL.md) |
| Prototype approved, including Not needed; Plan incomplete | [Plan skill](../lifecycle-plan/SKILL.md) |
| Plan approved; Build not approved complete | [Build skill](../lifecycle-build/SKILL.md) |
| Build approved; cycle open | [Finalize skill](../lifecycle-finalize/SKILL.md) |

Infer state from approved artifacts/history only when the index is absent. Awaiting approval means present/resume the current result, not advance. Load one active procedure and every reference its conditions require; other phases stay unloaded. Reuse unchanged material already read in this session.

## Workspace

Create artifacts as needed from `templates/`: index, phase artifacts, Cycle Log, optional prototype assets. Active artifacts normally stay committed for continuity; solo developers may choose to ignore them. Project-owned permanent sources remain authoritative. Follow the framework handoff and approval gates after each responsibility.

For every document created or edited, apply the [required format and compactness pass](references/artifacts.md#required-format) before presentation or handoff.
