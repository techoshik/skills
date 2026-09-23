# Companion Skills

- Companion skills provide techniques.
- They never replace lifecycle outputs, ownership, or gates.
- Repository-local and installed agent skills both count when available.

## Mapping

| Phase | Companion skills |
| --- | --- |
| **Define** | `grill-with-docs` for non-trivial discovery; `wayfinder` for large/foggy decision trees |
| **Context** | `research` for external/technical facts; `domain-modeling` for unclear terminology/concepts |
| **Shape** | `prototype` for material UX/state uncertainty; `domain-modeling` for domain rules; `codebase-design` for material seams/interfaces |
| **Plan** | `wayfinder` for dependency-heavy planning; `to-tickets` only when external tracking helps |
| **Build** | `tdd` for meaningful behaviour; `diagnosing-bugs` for hard failures; `code-review` as an aid to conformance review |
| **Verify** | `code-review` for independent final review; `diagnosing-bugs` for difficult failures |
| **Refine** | `improve-codebase-architecture`, `code-review`, `writing-for-agents` when evidence calls for them |

## `grill-with-docs`

- Default home: Define.
- Later phases use it only when a genuinely new requirement/domain decision appears.
- Do not repeat general requirement discovery in every phase.

## Conflict Rule

If a companion skill conflicts with:

- approved lifecycle artifacts;
- this framework;
- project Engineering Guidelines;

the lifecycle/project rule wins.
