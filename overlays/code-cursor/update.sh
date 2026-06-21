#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl jq coreutils nix _7zz
# shellcheck shell=bash
set -euo pipefail

cd -- "$(dirname "${BASH_SOURCE[0]}")"

SYSTEM="x86_64-linux"
PLATFORM="linux-x64"

META=$(curl -fsSL "https://api2.cursor.sh/updates/api/download/stable/$PLATFORM/cursor")
VERSION=$(jq -r '.version' <<< "$META")
CURRENT=$(jq -r '.version' sources.json)

[[ "$VERSION" == "$CURRENT" ]] && { echo "Already up to date ($VERSION)"; exit 0; }

URL=$(jq -r '.downloadUrl' <<< "$META")
{ read -r HASH; read -r STORE_PATH; } < <(nix-prefetch-url --print-path "$URL")
SRI=$(nix-hash --type sha256 --to-sri "$HASH")
VSCODE=$(7zz x -so "$STORE_PATH" "usr/share/cursor/resources/app/product.json" 2>/dev/null | jq -r '.vscodeVersion')

jq -n --arg v "$VERSION" --arg vs "$VSCODE" --arg sys "$SYSTEM" --arg url "$URL" --arg hash "$SRI" \
  '{version: $v, vscodeVersion: $vs, sources: {($sys): {url: $url, hash: $hash}}}' > sources.json
