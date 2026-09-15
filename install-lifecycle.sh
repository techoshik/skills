#!/usr/bin/env bash
set -euo pipefail

# Install the reusable Lifecycle system into an existing project.
# Usage: ./install-lifecycle.sh [/path/to/project]

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_PATH="${1:-$PWD}"

if [[ ! -d "$PROJECT_PATH" ]]; then
  echo "Project directory does not exist: $PROJECT_PATH" >&2
  exit 1
fi

PROJECT_ROOT="$(cd -- "$PROJECT_PATH" && pwd)"

if [[ -d "$SCRIPT_DIR/skills" ]]; then
  SOURCE_SKILLS="$SCRIPT_DIR/skills"
elif [[ -d "$SCRIPT_DIR/.agents/skills" ]]; then
  # Backward-compatible with this repository's current layout.
  SOURCE_SKILLS="$SCRIPT_DIR/.agents/skills"
else
  echo "Could not find the Lifecycle skills directory." >&2
  exit 1
fi

TARGET_SKILLS="$PROJECT_ROOT/.agents/skills"
AGENTS_FILE="$PROJECT_ROOT/AGENTS.md"
BLOCK_FILE="$SCRIPT_DIR/templates/AGENTS.lifecycle.md"

if [[ ! -f "$BLOCK_FILE" ]]; then
  echo "Missing managed AGENTS.md block: $BLOCK_FILE" >&2
  exit 1
fi

mkdir -p "$TARGET_SKILLS" \
  "$PROJECT_ROOT/docs/lifecycle" \
  "$PROJECT_ROOT/docs/guidelines" \
  "$PROJECT_ROOT/docs/modules" \
  "$PROJECT_ROOT/docs/backlog"

same_skills_directory=0
if [[ "$SOURCE_SKILLS" == "$TARGET_SKILLS" ]]; then
  same_skills_directory=1
fi

installed=0
for skill_dir in "$SOURCE_SKILLS"/lifecycle*/; do
  [[ -d "$skill_dir" ]] || continue
  [[ -f "$skill_dir/SKILL.md" ]] || continue

  skill_name="$(basename "$skill_dir")"
  target_dir="$TARGET_SKILLS/$skill_name"
  if [[ "$same_skills_directory" -eq 0 ]]; then
    mkdir -p "$target_dir"

    if command -v rsync >/dev/null 2>&1; then
      rsync -a "$skill_dir/" "$target_dir/"
    else
      cp -R "$skill_dir/." "$target_dir/"
    fi
  fi

  installed=$((installed + 1))
done

if [[ "$installed" -eq 0 ]]; then
  echo "No Lifecycle skills were found in $SOURCE_SKILLS" >&2
  exit 1
fi

update_agents_file() {
  local temporary_file
  temporary_file="$(mktemp "$PROJECT_ROOT/.AGENTS.md.lifecycle.XXXXXX")"

  if [[ ! -f "$AGENTS_FILE" ]]; then
    cp "$BLOCK_FILE" "$AGENTS_FILE"
    rm -f "$temporary_file"
    return
  fi

  local start_count end_count
  start_count="$(grep -cF '<!-- lifecycle:start -->' "$AGENTS_FILE" || true)"
  end_count="$(grep -cF '<!-- lifecycle:end -->' "$AGENTS_FILE" || true)"
  if [[ "$start_count" -ne "$end_count" ]]; then
    rm -f "$temporary_file"
    echo "AGENTS.md has an incomplete managed Lifecycle block; refusing to modify it." >&2
    return 1
  fi

  awk -v block_file="$BLOCK_FILE" '
    BEGIN {
      block_count = 0
      while ((getline line < block_file) > 0) {
        block[++block_count] = line
      }
      close(block_file)
    }

    /<!-- lifecycle:start -->/ {
      if (!replaced) {
        for (line_number = 1; line_number <= block_count; line_number++) print block[line_number]
        replaced = 1
      }
      inside_lifecycle_block = 1
      next
    }

    /<!-- lifecycle:end -->/ {
      inside_lifecycle_block = 0
      next
    }

    !inside_lifecycle_block { print }

    END {
      if (!replaced) {
        print ""
        for (line_number = 1; line_number <= block_count; line_number++) print block[line_number]
      }
    }
  ' "$AGENTS_FILE" > "$temporary_file"

  mv "$temporary_file" "$AGENTS_FILE"
}

update_agents_file

echo "Installed $installed Lifecycle skill(s) into $TARGET_SKILLS"
echo "Ensured docs/lifecycle, docs/guidelines, docs/modules, and docs/backlog exist"
echo "Updated the managed Lifecycle section in $AGENTS_FILE"
