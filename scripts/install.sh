#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Install the make-figure skill.

Usage:
  bash scripts/install.sh [--codex|--claude|--all] [--dry-run] [--validate-only] [--force]

Options:
  --codex          Install only the Codex package.
  --claude         Install only the Claude Code package.
  --all            Install both packages.
  --dry-run        Print actions without copying files.
  --validate-only  Validate package files without installing.
  --force          Replace an existing installed skill.
  -h, --help       Show this help.
EOF
}

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PYTHON_BIN="${PYTHON:-python3}"

INSTALL_CODEX=0
INSTALL_CLAUDE=0
EXPLICIT_TARGET=0
PASSTHROUGH=()

detect_targets() {
  if [[ -n "${CODEX_HOME:-}" || -d "$HOME/.codex" ]]; then
    INSTALL_CODEX=1
  fi
  if [[ -n "${CLAUDE_HOME:-}" || -d "$HOME/.claude" ]]; then
    INSTALL_CLAUDE=1
  fi
  if [[ "$INSTALL_CODEX" -eq 0 && "$INSTALL_CLAUDE" -eq 0 ]]; then
    INSTALL_CODEX=1
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --codex)
      INSTALL_CODEX=1
      EXPLICIT_TARGET=1
      ;;
    --claude)
      INSTALL_CLAUDE=1
      EXPLICIT_TARGET=1
      ;;
    --all)
      INSTALL_CODEX=1
      INSTALL_CLAUDE=1
      EXPLICIT_TARGET=1
      ;;
    --dry-run|--validate-only|--force)
      PASSTHROUGH+=("$1")
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

if [[ "$EXPLICIT_TARGET" -eq 0 ]]; then
  detect_targets
fi

if [[ "$INSTALL_CODEX" -eq 1 ]]; then
  "$PYTHON_BIN" "$ROOT_DIR/scripts/install_codex_skill.py" "${PASSTHROUGH[@]}"
fi

if [[ "$INSTALL_CLAUDE" -eq 1 ]]; then
  "$PYTHON_BIN" "$ROOT_DIR/scripts/install_claude_skill.py" "${PASSTHROUGH[@]}"
fi

