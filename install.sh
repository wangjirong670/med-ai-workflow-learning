#!/usr/bin/env bash
# med-study-knead — generic SKILL.md installer
# Any agent that loads <root>/<name>/SKILL.md.
#
# Local:  ./install.sh
# Remote: curl -fsSL https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/v0.1.0/install.sh | bash
# Custom: ./install.sh ~/.config/myagent/skills
#         ALL=1 ./install.sh
set -euo pipefail

SKILL_NAME="med-study-knead"
REPO_URL="https://github.com/wangjirong670/med-ai-workflow-learning"
ZIP_URL="$REPO_URL/archive/refs/tags/v0.1.0.zip"
TARGET="${1:-}"
ALL="${ALL:-0}"

log() { echo "[install] $*"; }
ok()  { echo "[install] OK  $*"; }
skip(){ echo "[install] --  $*"; }

find_local_repo() {
  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || pwd)"
  if [[ -f "$dir/skills/$SKILL_NAME/SKILL.md" ]]; then echo "$dir"; return; fi
  dir="$(pwd)"
  for _ in 1 2 3 4 5 6 7 8; do
    if [[ -f "$dir/skills/$SKILL_NAME/SKILL.md" ]]; then echo "$dir"; return; fi
    dir="$(dirname "$dir")"
  done
}

get_src() {
  local repo
  repo="$(find_local_repo || true)"
  if [[ -n "$repo" ]]; then
    log "using local package $repo/skills/$SKILL_NAME"
    echo "$repo/skills/$SKILL_NAME"
    return
  fi
  log "no local package; downloading $ZIP_URL"
  local tmp
  tmp="$(mktemp -d)"
  curl -fsSL "$ZIP_URL" -o "$tmp/src.zip"
  unzip -q "$tmp/src.zip" -d "$tmp"
  local found
  found="$(find "$tmp" -type d -name "$SKILL_NAME" | head -1)"
  if [[ -z "$found" || ! -f "$found/SKILL.md" ]]; then
    echo "zip has no skills/$SKILL_NAME" >&2
    exit 1
  fi
  echo "$found"
}

install_to() {
  local root="$1" src="$2"
  local dest="$root/$SKILL_NAME"
  local src_abs dest_abs
  src_abs="$(cd "$src" && pwd)"
  if [[ -e "$dest" ]]; then
    dest_abs="$(cd "$dest" && pwd)"
    if [[ "$dest_abs" == "$src_abs" ]]; then
      skip "skip (same as source): $dest"
      return
    fi
  fi
  if [[ "$(cd "$root" 2>/dev/null && pwd)" == "$(dirname "$src_abs")" ]]; then
    skip "skip (source tree): $root"
    return
  fi
  mkdir -p "$root"
  rm -rf "$dest"
  cp -R "$src" "$dest"
  ok "installed -> $dest"
}

SRC="$(get_src)"
log "skill source: $SRC"
log "format: SKILL.md skill folder (agent-agnostic)"

targets=()
if [[ -n "$TARGET" ]]; then
  targets+=("$TARGET")
else
  H="${HOME}"
  CWD="$(pwd)"
  candidates=(
    "$H/.skills"
    "$H/.local/share/agent-skills"
    "$H/.config/agent-skills"
    "$CWD/.mimocode/skills"
    "$CWD/.claude/skills"
    "$CWD/.cursor/skills"
    "$CWD/.agents/skills"
    "$H/.config/mimocode/skills"
    "$H/.claude/skills"
    "$H/.cursor/skills"
    "$H/.codex/skills"
    "$H/.gemini/skills"
    "$H/.agents/skills"
    "$H/.config/skills"
  )
  for r in "${candidates[@]}"; do
    if [[ "$r" == "$H/.skills" || "$r" == *agent-skills* || -d "$r" || "$ALL" == "1" ]]; then
      targets+=("$r")
    else
      skip "skip (absent, use TARGET or ALL=1): $r"
    fi
  done
fi

for t in "${targets[@]}"; do
  [[ -n "$t" ]] || continue
  install_to "$t" "$SRC"
done

echo
ok "done. Package is standard: <dir>/$SKILL_NAME/SKILL.md"
echo "Point any SKILL.md-capable agent at one of those folders (or symlink it)."
echo "New session, then e.g.:  帮我揉一下这页药理课业笔记"
echo "Docs: $REPO_URL/blob/v0.1.0/skills/README.md"
