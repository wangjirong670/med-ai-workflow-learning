#!/usr/bin/env bash
# med-study-knead one-shot installer (macOS / Linux)
# Local:  ./install.sh
# Remote: curl -fsSL https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/main/install.sh | bash
set -euo pipefail

SKILL_NAME="med-study-knead"
REPO_URL="https://github.com/wangjirong670/med-ai-workflow-learning"
ZIP_URL="$REPO_URL/archive/refs/heads/main.zip"
TARGET="${1:-}"
ALL="${ALL:-0}"

log() { echo "[install] $*"; }
ok()  { echo "[install] OK  $*"; }
skip(){ echo "[install] --  $*"; }

find_local_repo() {
  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
  if [[ -f "$dir/skills/$SKILL_NAME/SKILL.md" ]]; then echo "$dir"; return; fi
  dir="$(pwd)"
  for _ in 1 2 3 4 5 6; do
    if [[ -f "$dir/skills/$SKILL_NAME/SKILL.md" ]]; then echo "$dir"; return; fi
    dir="$(dirname "$dir")"
  done
}

get_src() {
  local repo
  repo="$(find_local_repo || true)"
  if [[ -n "$repo" ]]; then
    log "using local skill from $repo/skills/$SKILL_NAME"
    echo "$repo/skills/$SKILL_NAME"
    return
  fi
  log "local repo not found; downloading $ZIP_URL"
  local tmp
  tmp="$(mktemp -d)"
  curl -fsSL "$ZIP_URL" -o "$tmp/src.zip"
  unzip -q "$tmp/src.zip" -d "$tmp"
  local found
  found="$(find "$tmp" -type d -name "$SKILL_NAME" | head -1)"
  if [[ -z "$found" || ! -f "$found/SKILL.md" ]]; then
    echo "downloaded zip has no skills/$SKILL_NAME" >&2
    exit 1
  fi
  echo "$found"
}

install_to() {
  local root="$1" src="$2"
  local dest="$root/$SKILL_NAME"
  mkdir -p "$root"
  rm -rf "$dest"
  cp -R "$src" "$dest"
  ok "installed -> $dest"
}

SRC="$(get_src)"
log "skill source: $SRC"

targets=()
if [[ -n "$TARGET" ]]; then
  targets+=("$TARGET")
else
  HOME_DIR="${HOME:-$USERPROFILE}"
  candidates=(
    "$HOME_DIR/.config/mimocode/skills"
    "$HOME_DIR/.claude/skills"
    "$HOME_DIR/.cursor/skills"
    "$(pwd)/.mimocode/skills"
  )
  for r in "${candidates[@]}"; do
    if [[ "$r" == *mimocode* || "$ALL" == "1" || -d "$r" ]]; then
      targets+=("$r")
    else
      skip "skip (missing): $r"
    fi
  done
fi

for t in "${targets[@]}"; do
  [[ -n "$t" ]] || continue
  install_to "$t" "$SRC"
done

echo
ok "done. New session, then try:"
echo "  帮我揉一下这页骨伤课业笔记（药学/医学材料）"
echo "Docs: $REPO_URL/blob/main/skills/README.md"
