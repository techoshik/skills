# Required Companion Skills

- The Lifecycle system can use the companion skills in [mattpocock/skills](https://github.com/mattpocock/skills).
- Codex-installed skills, such as `~/.agents/skills`, and repository-local `.agents/skills/` skills both count.
- Install missing skills before using a phase that requires them:

```bash
npx skills@latest add mattpocock/skills
```

- Select the referenced skills, including `setup-matt-pocock-skills`.
- Run `/setup-matt-pocock-skills` once per project.
- These skills provide techniques and setup; they never replace Lifecycle outputs or exit gates.

## Recommended Mapping

| Phase | Companion skills and purpose |
| --- | --- |
| **Define** | **grill-with-docs** for every non-trivial change; **wayfinder** for a large or foggy decision tree |
| **Context** | **research** for external or technical questions; **domain-modeling** for unclear terminology or concepts |
| **Shape** | **prototype** for risky experience/state/logic assumptions; **domain-modeling** for domain rules; **codebase-design** for material module seams or interfaces |
| **Plan** | **wayfinder** for large decision trees; **to-tickets** when external execution tracking is useful |
| **Build** | **tdd** for meaningful behaviour; **diagnosing-bugs** for non-obvious failures; **code-review** for standards/spec review |
| **Verify** | **code-review** for independent standards/spec review; **diagnosing-bugs** for hard verification failures |
| **Refine** | **improve-codebase-architecture** for design opportunities; **code-review** after code changes; **writing-for-agents** for instruction/pointer problems |

- Use `grill-with-docs` to resolve requirements, terminology, constraints, decisions, and concrete scenarios.
- Use `wayfinder` to name the destination, explore the frontier breadth-first, and return decisions to lifecycle artifacts.
- Discovery may be broad, but store findings in the correct lifecycle artifact. A third-party-generated spec must not become a competing source of truth.

## Conflict Rule

- If a specialist skill conflicts with any of these:
  - Approved lifecycle artifacts.
  - This lifecycle framework.
  - Project Engineering Guidelines under `docs/guidelines/`.
- The lifecycle/project rule wins.

- Example: if an external TDD skill uses a different refactoring cadence, the current Lifecycle — Build instructions control the work.
