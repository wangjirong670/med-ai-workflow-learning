#!/usr/bin/env bash
# Install from a reviewed checkout: bash ./install.sh <your-skills-dir>
# Default: ~/.skills (portable copy; configure your agent to load it).
# ALL=1 explicitly opts into the candidate directories below.
set -euo pipefail
SKILL_NAME="med-study-knead"
TARGET="${1:-}"
ALL="${ALL:-0}"
log() { echo "[install] $*" >&2; }

find_local_repo() {
  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  if [[ -f "$dir/skills/$SKILL_NAME/SKILL.md" ]]; then echo "$dir"; return; fi
  dir="$(pwd -P)"
  for _ in 1 2 3 4 5 6 7 8; do
    if [[ -f "$dir/skills/$SKILL_NAME/SKILL.md" ]]; then echo "$dir"; return; fi
    dir="$(dirname "$dir")"
  done
  return 1
}

get_src() {
  local repo
  repo="$(find_local_repo)" || {
    log "No checkout found. Clone the repository, review this script, then run bash ./install.sh <skills-dir>."
    return 1
  }
  log "using local package $repo/skills/$SKILL_NAME"
  echo "$repo/skills/$SKILL_NAME"
}

install_to() {
  local root="$1" src="$2" dest stage backup=""
  src="$(cd "$src" && pwd -P)"
  mkdir -p "$root"
  root="$(cd "$root" && pwd -P)"
  dest="$root/$SKILL_NAME"
  if [[ -L "$dest" ]]; then log "Refusing to replace symlink: $dest"; return 1; fi
  if [[ -d "$dest" && "$(cd "$dest" && pwd -P)" == "$src" ]]; then
    log "skip (same as source): $dest"; return
  fi
  if [[ "$root/" == "$src/"* || "$src/" == "$dest/"* ]]; then
    log "Refusing overlapping source and destination: $dest"; return 1
  fi
  stage="$(mktemp -d "$root/.${SKILL_NAME}.stage.XXXXXX")"
  if ! cp -R "$src/." "$stage/"; then
    rm -rf -- "$stage"; log "Copy failed; existing installation unchanged"; return 1
  fi
  local python="" candidate
  for candidate in python3 python; do
    if command -v "$candidate" >/dev/null && "$candidate" -c 'import sys; sys.exit(0 if sys.version_info >= (3,10) else 1)' 2>/dev/null; then
      python="$candidate"; break
    fi
  done
  if [[ -z "$python" ]] || ! "$python" "$src/scripts/check_resolve.py" --root "$stage" --skill-dir "$stage" --require-release >/dev/null; then
    rm -rf -- "$stage"; log "Staged package failed standalone integrity verification; previous installation unchanged"; return 1
  fi
  if [[ -e "$dest" ]]; then
    backup="$(mktemp -d "$root/.${SKILL_NAME}.backup.XXXXXX")"
    rmdir "$backup"
    if ! mv -- "$dest" "$backup"; then rm -rf -- "$stage"; return 1; fi
  fi
  if ! mv -- "$stage" "$dest"; then
    if [[ -n "$backup" ]]; then
      mv -- "$backup" "$dest" || log "Restore failed; previous installation retained at $backup"
    fi
    rm -rf -- "$stage"; return 1
  fi
  if [[ -n "$backup" ]]; then rm -rf -- "$backup"; fi
  log "installed -> $dest"
}

SRC="$(get_src)"
[[ -f "$SRC/LICENSE" && -f "$SRC/references/snapshot/MANIFEST.json" ]] || {
  log "Incomplete package: LICENSE or snapshot manifest missing"; exit 1
}
targets=()
if [[ -n "$TARGET" ]]; then
  targets+=("$TARGET")
elif [[ "$ALL" == "1" ]]; then
  targets+=("$HOME/.skills" "$HOME/.local/share/agent-skills" "$HOME/.config/agent-skills"
    "$PWD/.mimocode/skills" "$PWD/.claude/skills" "$PWD/.cursor/skills" "$PWD/.agents/skills"
    "$HOME/.config/mimocode/skills" "$HOME/.claude/skills" "$HOME/.cursor/skills"
    "$HOME/.codex/skills" "$HOME/.gemini/skills" "$HOME/.agents/skills" "$HOME/.config/skills")
else
  targets+=("$HOME/.skills")
fi
for target in "${targets[@]}"; do install_to "$target" "$SRC"; done
log "Done. Configure your agent to load <target>/$SKILL_NAME/SKILL.md; discovery depends on the agent."
