#!/usr/bin/env bash
set -euo pipefail

# Install the reusable Lifecycle system into one or more existing projects.
# Usage: ./install-lifecycle.sh
#        ./install-lifecycle.sh /path/to/project
#        ./install-lifecycle.sh --projects-file /path/to/projects-file

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_PROJECTS_FILE="$SCRIPT_DIR/.lifecycle-projects"
PROJECT_PATH=""
PROJECTS_FILE=""

usage() {
  sed -n '1,8p' "$0"
}

while (($# > 0)); do
  case "$1" in
    --projects-file)
      if [[ -n "$PROJECT_PATH" || -n "$PROJECTS_FILE" || $# -lt 2 ]]; then
        echo "Usage: $0 --projects-file /path/to/projects-file" >&2
        exit 1
      fi
      PROJECTS_FILE="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
    *)
      if [[ -n "$PROJECT_PATH" || -n "$PROJECTS_FILE" ]]; then
        echo "Choose one project path or one projects-file option." >&2
        exit 1
      fi
      PROJECT_PATH="$1"
      shift
      ;;
  esac
done

if [[ -z "$PROJECT_PATH" ]]; then
  PROJECTS_FILE="${PROJECTS_FILE:-$DEFAULT_PROJECTS_FILE}"
fi

if [[ -n "$PROJECTS_FILE" ]]; then
  if [[ "$PROJECTS_FILE" != /* ]]; then
    PROJECTS_FILE="$PWD/$PROJECTS_FILE"
  fi
  PROJECTS_FILE="$(cd -- "$(dirname -- "$PROJECTS_FILE")" && pwd)/$(basename -- "$PROJECTS_FILE")"
  if [[ ! -f "$PROJECTS_FILE" ]]; then
    echo "Projects file does not exist: $PROJECTS_FILE" >&2
    echo "Provide a project path or create .lifecycle-projects at the installer root." >&2
    exit 1
  fi

  PROJECTS_FILE_DIR="$(dirname -- "$PROJECTS_FILE")"
  project_paths=()
  while IFS= read -r project_path || [[ -n "$project_path" ]]; do
    project_path="${project_path#"${project_path%%[![:space:]]*}"}"
    project_path="${project_path%"${project_path##*[![:space:]]}"}"
    [[ -z "$project_path" || "${project_path:0:1}" == "#" ]] && continue
    if [[ "$project_path" != /* ]]; then
      project_path="$PROJECTS_FILE_DIR/$project_path"
    fi
    project_paths+=("$project_path")
  done < "$PROJECTS_FILE"

  if [[ "${#project_paths[@]}" -eq 0 ]]; then
    echo "Projects file contains no project paths: $PROJECTS_FILE" >&2
    exit 1
  fi
else
  project_paths=("$PROJECT_PATH")
fi

if [[ -d "$SCRIPT_DIR/skills" ]]; then
  SOURCE_SKILLS="$SCRIPT_DIR/skills"
elif [[ -d "$SCRIPT_DIR/.agents/skills" ]]; then
  # Backward-compatible with this repository's current layout.
  SOURCE_SKILLS="$SCRIPT_DIR/.agents/skills"
else
  echo "Could not find the Lifecycle skills directory." >&2
  exit 1
fi

BLOCK_FILE="$SCRIPT_DIR/templates/AGENTS.lifecycle.md"

if [[ ! -f "$BLOCK_FILE" ]]; then
  echo "Missing managed AGENTS.md block: $BLOCK_FILE" >&2
  exit 1
fi

existing_project_paths=()
for project_path in "${project_paths[@]}"; do
  if [[ ! -d "$project_path" ]]; then
    echo "Skipping missing project directory: $project_path" >&2
    continue
  fi
  existing_project_paths+=("$project_path")
done

if [[ "${#existing_project_paths[@]}" -eq 0 ]]; then
  echo "No existing project directories were found in the project list." >&2
  exit 1
fi

project_paths=("${existing_project_paths[@]}")

update_agents_file() {
  local agents_file="$1"
  local temporary_file
  temporary_file="$(mktemp "$(dirname -- "$agents_file")/.AGENTS.md.lifecycle.XXXXXX")"

  if [[ ! -f "$agents_file" ]]; then
    cp "$BLOCK_FILE" "$agents_file"
    rm -f "$temporary_file"
    return
  fi

  local start_count end_count
  start_count="$(grep -cF '<!-- lifecycle:start -->' "$agents_file" || true)"
  end_count="$(grep -cF '<!-- lifecycle:end -->' "$agents_file" || true)"
  if [[ "$start_count" -ne "$end_count" ]]; then
    rm -f "$temporary_file"
    echo "AGENTS.md has an incomplete managed Lifecycle block; refusing to modify it: $agents_file" >&2
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
  ' "$agents_file" > "$temporary_file"

  mv "$temporary_file" "$agents_file"
}

install_project() {
  local project_path="$1"
  local project_root
  project_root="$(cd -- "$project_path" && pwd)"
  local target_skills="$project_root/.agents/skills"
  local agents_file="$project_root/AGENTS.md"
  mkdir -p "$target_skills" \
    "$project_root/docs/lifecycle" \
    "$project_root/docs/guidelines" \
    "$project_root/docs/modules" \
    "$project_root/docs/backlog"

  local same_skills_directory=0
  if [[ "$SOURCE_SKILLS" == "$target_skills" ]]; then
    same_skills_directory=1
  fi

  local installed=0
  local skill_dir skill_name target_dir
  for skill_dir in "$SOURCE_SKILLS"/lifecycle*/; do
    [[ -d "$skill_dir" ]] || continue
    [[ -f "$skill_dir/SKILL.md" ]] || continue

    skill_name="$(basename "$skill_dir")"
    target_dir="$target_skills/$skill_name"
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
    return 1
  fi

  update_agents_file "$agents_file"
  echo "Installed $installed Lifecycle skill(s) into $target_skills"
  echo "Ensured docs/lifecycle, docs/guidelines, docs/modules, and docs/backlog exist"
  echo "Updated the managed Lifecycle section in $agents_file"
}

for project_path in "${project_paths[@]}"; do
  install_project "$project_path"
done

if [[ -n "$PROJECTS_FILE" ]]; then
  echo "Processed ${#project_paths[@]} project(s) from $PROJECTS_FILE"
fi
