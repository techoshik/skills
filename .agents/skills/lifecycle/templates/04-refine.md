# Refine: <Feature or Module Name>


## 1. Full-Branch Code Review & Diff Audit

- [ ] **Diff Hygiene:** Inspected `git diff` against base branch — no leftover debug logs (`print`, `console.log`), no commented-out code, no unintended edits.
- [ ] **Architecture Consistency:** Audited all touched files against `.agents/guidelines/` for consistent conventions and patterns across all checkpoints.
- [ ] **Success Criteria Re-check:** Verified that all Success Criteria from `01-define.md` are fully met by the integrated code.

## 2. Global Verification & Infrastructure

- [ ] **Static Analysis:** `<linter command>` reports 0 errors across all affected packages.
- [ ] **Test Suites:** `<test command>` passes 100% across all affected test suites.
- [ ] **Database & Security:** Composite indexes, schema migrations, and security rules are verified (or "N/A").

## 3. Documentation & Pull Request

- **Permanent Documentation:** <Project documentation/README updated, or "None needed">
- **PR Title:** `<type>(<scope>): <short summary matching List of Changes>`
- **PR Description:**
  ```markdown
  ### Summary
  - <Bullet 1 describing high-level capability>
  - <Bullet 2 describing high-level capability>

  ### Key Changes
  - <Area 1>: <Key change>
  - <Area 2>: <Key change>

  ### Verification
  - <How this was tested and verified>
  ```

## 4. Friction & Lessons Learned

<!-- 
Append unexpected roadblocks, ambiguities, or bugs encountered during Define, Outline, or Execute.
Use DOER principles: Expected vs Actual, Root Cause, and what permanent rule to update.
-->

### <Issue Title>
- **Phase:** <Define | Outline | Execute — Checkpoint X.X>
- **Expected vs Actual:** <What was expected vs what happened>
- **Root Cause:** <Why it occurred>
- **Resolution:** <How it was handled locally>
- **Guideline Update:** <File in .agents/guidelines/ or SKILL.md permanently updated>
