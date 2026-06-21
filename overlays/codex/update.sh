#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl jq coreutils nix
# shellcheck shell=bash
set -euo pipefail

cd -- "$(dirname "${BASH_SOURCE[0]}")"

BINARY="codex-x86_64-unknown-linux-musl"
META=$(curl -fsSL "https://api.github.com/repos/openai/codex/releases/latest")
TAG=$(jq -r '.tag_name' <<< "$META")
VERSION=${TAG#rust-v}
CURRENT=$(jq -r '.version' sources.json)

[[ "$VERSION" == "$CURRENT" ]] && { echo "Codex already up to date ($VERSION)"; exit 0; }

URL="https://github.com/openai/codex/releases/download/${TAG}/${BINARY}.tar.gz"
{ read -r hash; read -r _path; } < <(nix-prefetch-url --print-path "$URL")
SRI=$(nix-hash --type sha256 --to-sri "$hash")

jq -n --arg version "$VERSION" --arg binary "$BINARY" --arg url "$URL" --arg hash "$SRI" \
  '{version: $version, binary: $binary, url: $url, hash: $hash}' > sources.json

echo "Updated Codex to $VERSION"
