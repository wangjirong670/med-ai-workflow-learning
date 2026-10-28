#!/usr/bin/env python3
"""Sync only dialogue bodies into the share-pack shells; --check never writes."""
import argparse
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def blocks(root: Path):
    for suffix in ("full", "lite"):
        source = root / "prompts" / ("quickstart.zh.md" if suffix == "full" else "quickstart-lite.zh.md")
        text = source.read_text(encoding="utf-8")
        if suffix == "full":
            start = "## 【对话块】从这里复制\n\n"
            end = "\n## 【结束对话块】"
            if text.count(start) != 1 or text.count(end) != 1:
                raise ValueError("Full dialogue requires unique start/end markers")
            body, boundary = text.split(start, 1)[1].split(end, 1)
            if not body.endswith("\n---\n"):
                raise ValueError("Full dialogue end separator missing")
            body = body[:-len("\n---\n")].rstrip()
        else:
            body = "你是" + text.split("你是", 1)[1].rstrip()
        share = root / "prompts" / f"share-pack-{suffix}.zh.md"
        shell = share.read_text(encoding="utf-8")
        heading = "## 【对话块】从这里复制到「从这里结束」\n\n"
        if shell.count(heading) != 1 or shell.count("【从这里结束】") != 1:
            raise ValueError("Share pack requires unique start/end markers")
        prefix, rest = shell.split(heading, 1)
        _, tail = rest.split("【从这里结束】", 1)
        # Full pack has a rule separator; Lite has none.
        separator = "\n\n---\n\n" if suffix == "full" else "\n\n"
        yield share, shell, prefix + heading + body + separator + "【从这里结束】" + tail


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    drift = False
    for path, before, after in blocks(ROOT):
        changed = before != after
        print(f"{path.name}: {'DRIFT' if changed else 'OK'}")
        drift |= changed
        if changed and not args.check:
            path.write_text(after, encoding="utf-8")
    return int(args.check and drift)


if __name__ == "__main__":
    raise SystemExit(main())
