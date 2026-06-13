#!/usr/bin/env python3
"""Install the make-figure skill into Codex."""

from __future__ import annotations

import argparse
import os
import shutil
import sys
from pathlib import Path


SKILL_NAME = "make-figure"


def repo_root() -> Path:
    return Path(__file__).resolve().parents[1]


def default_destination() -> Path:
    codex_home = os.environ.get("CODEX_HOME")
    base = Path(codex_home).expanduser() if codex_home else Path.home() / ".codex"
    return base / "skills" / SKILL_NAME


def package_source() -> Path:
    return repo_root() / ".codex" / "skills" / SKILL_NAME


def validate_source(src: Path) -> list[str]:
    required = [
        src / "SKILL.md",
        src / "references" / "figure_house_style_guidelines.md",
        src / "references" / "core-colour-guidelines.md",
        src / "references" / "checking-function.md",
        src / "assets" / "bad-examples",
        src / "scripts" / "check_r_setup.R",
        src / "scripts" / "install_r_dependencies.R",
    ]
    missing = [str(path) for path in required if not path.exists()]
    return missing


def copy_skill(src: Path, dest: Path, *, dry_run: bool, force: bool) -> None:
    if dry_run:
        print(f"Would install Codex skill from {src} to {dest}")
        return

    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.exists():
        if not force:
            raise FileExistsError(
                f"Destination already exists: {dest}\n"
                "Rerun with --force to replace it."
            )
        if dest.is_dir():
            shutil.rmtree(dest)
        else:
            dest.unlink()

    shutil.copytree(src, dest)
    print(f"Installed Codex skill to {dest}")
    print("Restart Codex to pick up the new skill.")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--target", type=Path, default=None, help="Destination skill folder.")
    parser.add_argument("--dry-run", action="store_true", help="Print what would happen.")
    parser.add_argument("--validate-only", action="store_true", help="Validate package files and exit.")
    parser.add_argument("--force", action="store_true", help="Replace an existing destination.")
    args = parser.parse_args()

    src = package_source()
    missing = validate_source(src)
    if missing:
        print("Codex package is incomplete. Missing:", file=sys.stderr)
        for path in missing:
            print(f"- {path}", file=sys.stderr)
        return 1

    dest = args.target.expanduser() if args.target else default_destination()

    if args.validate_only:
        print(f"Codex package is valid: {src}")
        print(f"Default destination: {dest}")
        return 0

    try:
        copy_skill(src, dest, dry_run=args.dry_run, force=args.force)
    except Exception as exc:
        print(str(exc), file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
