#!/usr/bin/env bash
set -euo pipefail

# Only install if missing
if command -v starship >/dev/null 2>&1; then
  exit 0
fi

mkdir -p "$HOME/.local/bin"
curl -sS https://starship.rs/install.sh | sh -s -- -b "$HOME/.local/bin"
