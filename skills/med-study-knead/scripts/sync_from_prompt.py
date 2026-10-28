#!/usr/bin/env python3
"""Generate release snapshots and LICENSE; --check is strictly read-only.

Run from the repository checkout, not from an MCP temporary script.
Requires Python 3.10+. No external dependencies.
"""
from __future__ import annotations

import argparse
import json
import os
import sys
import tempfile
from datetime import datetime, timezone
from pathlib import Path

# --check must not create even an import cache in a read-only package.
sys.dont_write_bytecode = True
from check_resolve import HEADER, SOURCES, digest, normalized_bytes, resolve_mode

def atomic_write(path: Path, raw: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    handle, temporary = tempfile.mkstemp(dir=path.parent, prefix=".snapshot-")
    try:
        with os.fdopen(handle, "wb") as stream:
            stream.write(raw)
        os.replace(temporary, path)
    finally:
        if os.path.exists(temporary):
            os.unlink(temporary)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", type=Path, help="repository root")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    repo = args.repo.resolve() if args.repo else Path(__file__).resolve().parents[3]
    skill_dir = Path(__file__).resolve().parents[1]
    if args.check:
        mode, detail = resolve_mode(repo, skill_dir)
        license_ok = ((repo / "LICENSE").is_file() and (skill_dir / "LICENSE").is_file()
                      and normalized_bytes(repo / "LICENSE") == normalized_bytes(skill_dir / "LICENSE"))
        print(json.dumps({**detail, "license_ok": license_ok}, ensure_ascii=False, indent=2))
        return int(mode != "dev" or not detail["snapshot_ok"] or not license_ok)

    # Read every input before writing anything. Manifest is replaced last.
    inputs = [(source_id, source_path, snapshot_path, normalized_bytes(repo / source_path))
              for source_id, (source_path, snapshot_path) in SOURCES.items()]
    license_raw = normalized_bytes(repo / "LICENSE")
    generated_at = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    entries = []
    for source_id, source_path, snapshot_path, raw in inputs:
        sha256 = digest(raw)
        header = HEADER.format(source_id=source_id, source_path=source_path,
                               sha256=sha256, generated_at=generated_at)
        atomic_write(skill_dir / snapshot_path, header.encode("utf-8") + raw)
        entries.append({"id": source_id, "source_relpath": source_path,
                        "source_sha256": sha256, "snapshot_relpath": snapshot_path,
                        "bytes": len(raw)})
    atomic_write(skill_dir / "LICENSE", license_raw)
    manifest = {"generated_at": generated_at,
                "generator": "skills/med-study-knead/scripts/sync_from_prompt.py",
                "version_policy": "git history + source sha256; hashes detect drift, not publisher identity",
                "sources": entries}
    atomic_write(skill_dir / "references/snapshot/MANIFEST.json",
                 (json.dumps(manifest, ensure_ascii=False, indent=2) + "\n").encode("utf-8"))
    print(f"Synced {len(entries)} snapshots and LICENSE")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
