#!/usr/bin/env python3
"""Sync skill release snapshot from the authoritative L1 prompt.

Reads repo files and writes generated copies under references/snapshot/.
Never hand-edit the snapshot — re-run this script after prompt changes.

Usage:
  python sync_from_prompt.py [--repo <med-ai-workflow-root>]

Exit 0 on success. Prints the manifest path.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

SOURCES = (
    {
        "id": "quickstart",
        "relpath": "prompts/quickstart.zh.md",
        "out_name": "quickstart.snapshot.md",
        "role": "权威 L1 学习向 prompt（红线/证据档位/输出/坏输出）",
    },
    {
        "id": "method",
        "relpath": "docs/method.zh.md",
        "out_name": "method.snapshot.md",
        "role": "双轨纪律（循环/证据纪律/范围切割/勘误）",
    },
)

HEADER_TMPL = """<!-- GENERATED FILE — do not hand-edit. -->
<!--
source_id: {id}
source_relpath: {relpath}
source_sha256: {sha256}
generated_at: {generated_at}
generator: skills/med-study-knead/scripts/sync_from_prompt.py
-->
> **快照说明**：本文件由脚本从 `{relpath}` 生成，供 Skill 在无法解析仓内权威路径时回退使用。
> 权威源仍是仓内 `{relpath}`；冲突以权威源为准。运行 `scripts/sync_from_prompt.py` 可重新生成。

"""


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def find_repo_root(explicit: str | None) -> Path:
    if explicit:
        root = Path(explicit).resolve()
        if not (root / "prompts" / "quickstart.zh.md").is_file():
            raise SystemExit(f"repo root missing prompts/quickstart.zh.md: {root}")
        return root
    # scripts/ -> med-study-knead/ -> skills/ -> repo root
    here = Path(__file__).resolve()
    candidate = here.parents[3]
    if (candidate / "prompts" / "quickstart.zh.md").is_file():
        return candidate
    raise SystemExit("cannot locate repo root; pass --repo")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--repo", help="path to med-ai-workflow repo root")
    args = ap.parse_args()

    repo = find_repo_root(args.repo)
    skill_dir = Path(__file__).resolve().parents[1]
    snap_dir = skill_dir / "references" / "snapshot"
    snap_dir.mkdir(parents=True, exist_ok=True)

    generated_at = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    entries = []

    for src in SOURCES:
        src_path = repo / src["relpath"]
        if not src_path.is_file():
            raise SystemExit(f"missing source: {src_path}")
        raw = src_path.read_bytes()
        text = raw.decode("utf-8")
        digest = sha256_bytes(raw)
        header = HEADER_TMPL.format(
            id=src["id"],
            relpath=src["relpath"],
            sha256=digest,
            generated_at=generated_at,
        )
        out_path = snap_dir / src["out_name"]
        out_path.write_text(header + text, encoding="utf-8", newline="\n")
        entries.append(
            {
                "id": src["id"],
                "source_relpath": src["relpath"],
                "source_sha256": digest,
                "snapshot_relpath": f"references/snapshot/{src['out_name']}",
                "role": src["role"],
                "bytes": len(raw),
            }
        )
        print(f"wrote {out_path} sha256={digest[:12]}…")

    # Detect prompt version from quickstart title line
    qtext = (repo / "prompts" / "quickstart.zh.md").read_text(encoding="utf-8")
    prompt_version = "unknown"
    for line in qtext.splitlines()[:5]:
        if "v3" in line or "一键试用" in line:
            prompt_version = line.strip().lstrip("# ").strip()
            break

    manifest = {
        "generated_at": generated_at,
        "generator": "skills/med-study-knead/scripts/sync_from_prompt.py",
        "prompt_version": prompt_version,
        "sources": entries,
        "note": "Snapshot is generated. Authority remains prompts/quickstart.zh.md. Re-run script after prompt edits.",
    }
    man_path = snap_dir / "MANIFEST.json"
    man_path.write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    print(f"wrote {man_path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
