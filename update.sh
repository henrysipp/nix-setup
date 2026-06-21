#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname "${BASH_SOURCE[0]}")"

./overlays/code-cursor/update.sh
./overlays/codex/update.sh
