#!/usr/bin/env python3
"""Diagnose skill dependency-resolution mode (dev / release / missing).

Modes:
  dev     — authoritative prompt files are resolvable
  release — prompt absent, but references/snapshot/ present
  missing — neither prompt nor snapshot (caller must stop and explain)

Usage:
  python check_resolve.py [--root <dir>] [--skill-dir <dir>]
  python check_resolve.py --self-test

Exit codes: 0 ok (mode printed), 1 missing mode, 2 usage/error.
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

PROMPT_REL = Path("prompts/quickstart.zh.md")
METHOD_REL = Path("docs/method.zh.md")
SNAP_Q = Path("references/snapshot/quickstart.snapshot.md")
SNAP_M = Path("references/snapshot/method.snapshot.md")
MANIFEST = Path("references/snapshot/MANIFEST.json")

REQUIRED_SKILL_MARKERS = (
    "权威源与依赖解析",
    "references/snapshot/",
    "禁止",
    "缺",
)


def resolve_mode(root: Path, skill_dir: Path) -> tuple[str, dict]:
    prompt_ok = (root / PROMPT_REL).is_file() and (root / METHOD_REL).is_file()
    snap_ok = (skill_dir / SNAP_Q).is_file() and (skill_dir / SNAP_M).is_file()
    if prompt_ok:
        mode = "dev"
    elif snap_ok:
        mode = "release"
    else:
        mode = "missing"
    detail = {
        "mode": mode,
        "prompt_ok": prompt_ok,
        "snapshot_ok": snap_ok,
        "prompt_path": str(root / PROMPT_REL) if prompt_ok else None,
        "snapshot_dir": str(skill_dir / "references/snapshot") if snap_ok else None,
    }
    return mode, detail


def skill_has_missing_rule(skill_dir: Path) -> bool:
    text = (skill_dir / "SKILL.md").read_text(encoding="utf-8")
    return all(m in text for m in REQUIRED_SKILL_MARKERS)


def self_test(skill_dir: Path) -> int:
    import shutil
    import tempfile

    failures = []
    with tempfile.TemporaryDirectory() as td:
        tdp = Path(td)

        # 1) dev: fake root with prompt files
        r1 = tdp / "dev_root"
        (r1 / "prompts").mkdir(parents=True)
        (r1 / "docs").mkdir(parents=True)
        (r1 / "prompts" / "quickstart.zh.md").write_text("# q\n", encoding="utf-8")
        (r1 / "docs" / "method.zh.md").write_text("# m\n", encoding="utf-8")
        mode, _ = resolve_mode(r1, skill_dir)
        if mode != "dev":
            failures.append(f"expected dev, got {mode}")

        # 2) release: empty root, skill has snapshot
        mode, d = resolve_mode(tdp / "empty", skill_dir)
        if mode != "release":
            failures.append(f"expected release, got {mode} {d}")
        elif not d["snapshot_ok"]:
            failures.append("release but snapshot_ok False")

        # 3) missing: skill copy without snapshot, no prompt
        bare = tdp / "bare_skill"
        bare.mkdir()
        (bare / "SKILL.md").write_text(
            (skill_dir / "SKILL.md").read_text(encoding="utf-8"), encoding="utf-8"
        )
        mode, _ = resolve_mode(tdp / "empty2", bare)
        if mode != "missing":
            failures.append(f"expected missing, got {mode}")

        # 4) SKILL.md instructs stop-and-explain on missing
        if not skill_has_missing_rule(skill_dir):
            failures.append("SKILL.md missing stop-and-explain markers")

        # 5) missing mode must NOT look like dev/release
        if mode != "missing":
            failures.append("mode leak")

    if failures:
        print("SELF-TEST FAIL")
        for f in failures:
            print(" -", f)
        return 1
    print("SELF-TEST PASS  modes=dev/release/missing  skill_missing_rule=yes")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--root", help="directory that may contain prompts/")
    ap.add_argument("--skill-dir", help="skill folder (contains SKILL.md)")
    ap.add_argument("--self-test", action="store_true")
    args = ap.parse_args()

    here = Path(__file__).resolve().parents[1]
    skill_dir = Path(args.skill_dir).resolve() if args.skill_dir else here

    if args.self_test:
        return self_test(skill_dir)

    if not args.root:
        print("need --root or --self-test", file=sys.stderr)
        return 2
    root = Path(args.root).resolve()
    mode, detail = resolve_mode(root, skill_dir)
    detail["skill_missing_rule"] = skill_has_missing_rule(skill_dir)
    print(json.dumps(detail, ensure_ascii=False, indent=2))
    return 0 if mode != "missing" else 1


if __name__ == "__main__":
    sys.exit(main())
