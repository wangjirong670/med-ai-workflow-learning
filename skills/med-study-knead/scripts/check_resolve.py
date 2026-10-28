#!/usr/bin/env python3
"""Check local dependency integrity (Python 3.10+).

dev: source files match the manifest; release: intact snapshots are used instead.
missing: neither verified source nor intact snapshot is available. Exit 1.
Hashes detect drift/corruption; they do not authenticate the publisher.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
from pathlib import Path

SOURCES = {
    "quickstart": ("prompts/quickstart.zh.md", "references/snapshot/quickstart.snapshot.md"),
    "method": ("docs/method.zh.md", "references/snapshot/method.snapshot.md"),
    "long-material": ("docs/long-material.zh.md", "references/snapshot/long-material.snapshot.md"),
}
MANIFEST = "references/snapshot/MANIFEST.json"

HEADER = """<!-- GENERATED FILE — do not hand-edit. -->
<!--
source_id: {source_id}
source_relpath: {source_path}
source_sha256: {sha256}
generated_at: {generated_at}
generator: skills/med-study-knead/scripts/sync_from_prompt.py
-->
> **快照说明**：来自 `{source_path}`，供独立 Skill / MCP 加载；不是仓内实时源文件。
> 维护者在完整仓库中运行 `scripts/sync_from_prompt.py` 更新；使用者不需要运行同步脚本。

"""


def normalized_bytes(path: Path) -> bytes:
    return path.read_bytes().replace(b"\r\n", b"\n")


def digest(raw: bytes) -> str:
    return hashlib.sha256(raw).hexdigest()


def load_entries(skill_dir: Path) -> tuple[dict, dict]:
    manifest = json.loads((skill_dir / MANIFEST).read_text(encoding="utf-8"))
    timestamp = manifest["generated_at"]
    if not isinstance(timestamp, str) or not re.fullmatch(r"\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z", timestamp):
        raise ValueError("invalid generation timestamp")
    entries = manifest["sources"]
    if not isinstance(entries, list) or len(entries) != len(SOURCES):
        raise ValueError("manifest must contain exactly the expected sources")
    result = {}
    for entry in entries:
        source_id = entry["id"]
        if source_id not in SOURCES or source_id in result:
            raise ValueError("unknown or duplicate source id")
        source_path, snapshot_path = SOURCES[source_id]
        if (entry["source_relpath"], entry["snapshot_relpath"]) != (source_path, snapshot_path):
            raise ValueError("unexpected manifest path")
        if not isinstance(entry["source_sha256"], str) or not re.fullmatch(r"[0-9a-f]{64}", entry["source_sha256"]):
            raise ValueError("invalid source hash")
        if type(entry["bytes"]) is not int or entry["bytes"] < 0:
            raise ValueError("invalid source byte count")
        result[source_id] = entry
    return manifest, result


def snapshot_matches(skill_dir: Path, source_id: str, entry: dict, generated_at: str) -> bool:
    raw = normalized_bytes(skill_dir / entry["snapshot_relpath"])
    header = HEADER.format(source_id=source_id, source_path=entry["source_relpath"],
                           sha256=entry["source_sha256"], generated_at=generated_at).encode("utf-8")
    if not raw.startswith(header):
        return False
    body = raw[len(header):]
    return (digest(body) == entry["source_sha256"]
            and len(body) == entry["bytes"])


def resolve_mode(root: Path, skill_dir: Path) -> tuple[str, dict]:
    detail = {"mode": "missing", "source_ok": False, "snapshot_ok": False, "errors": []}
    try:
        manifest, entries = load_entries(skill_dir)
    except (OSError, ValueError, KeyError, TypeError) as exc:
        detail["errors"].append(f"manifest: {exc}")
        return "missing", detail
    source_ok = snapshot_ok = True
    for source_id, entry in entries.items():
        try:
            raw = normalized_bytes(root / entry["source_relpath"])
            if digest(raw) != entry["source_sha256"] or len(raw) != entry["bytes"]:
                raise ValueError("source differs from manifest")
        except (OSError, ValueError) as exc:
            source_ok = False
            detail["errors"].append(f"{source_id} source: {exc}")
        try:
            if not snapshot_matches(skill_dir, source_id, entry, manifest["generated_at"]):
                raise ValueError("snapshot body/header differs from manifest")
        except (OSError, ValueError) as exc:
            snapshot_ok = False
            detail["errors"].append(f"{source_id} snapshot: {exc}")
    mode = "dev" if source_ok else "release" if snapshot_ok else "missing"
    detail.update(mode=mode, source_ok=source_ok, snapshot_ok=snapshot_ok)
    return mode, detail


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, required=True, help="candidate repository root")
    parser.add_argument("--skill-dir", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--require-release", action="store_true", help="require a complete standalone runtime package")
    args = parser.parse_args()
    mode, detail = resolve_mode(args.root.resolve(), args.skill_dir.resolve())
    if args.require_release:
        required = ("SKILL.md", "LICENSE", "scripts/check_resolve.py")
        detail["runtime_files_ok"] = all((args.skill_dir / name).is_file() and (args.skill_dir / name).stat().st_size > 0 for name in required)
    print(json.dumps(detail, ensure_ascii=False, indent=2))
    return int(not (detail["snapshot_ok"] and detail["runtime_files_ok"]) if args.require_release else mode == "missing")


if __name__ == "__main__":
    raise SystemExit(main())
