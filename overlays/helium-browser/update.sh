#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl jq coreutils nix
# shellcheck shell=bash
set -euo pipefail

cd -- "$(dirname "${BASH_SOURCE[0]}")"

META=$(curl -fsSL "https://api.github.com/repos/imputnet/helium-linux/releases/latest")
VERSION=$(jq -r '.tag_name' <<< "$META")
CURRENT=$(jq -r '.version' sources.json)

[[ "$VERSION" == "$CURRENT" ]] && {
  echo "Helium Browser already up to date ($VERSION)"
  exit 0
}

asset_url() {
  local suffix="$1"
  jq -r --arg suffix "$suffix" '
    .assets[]
    | select(.name | endswith($suffix))
    | .browser_download_url
  ' <<< "$META" | head -1
}

prefetch() {
  local url="$1"
  { read -r hash; read -r _path; } < <(nix-prefetch-url --print-path "$url")
  nix-hash --type sha256 --to-sri "$hash"
}

declare -A SYSTEMS=(
  ["x86_64-linux"]="-x86_64.AppImage"
  ["aarch64-linux"]="-arm64.AppImage"
)

sources="{}"
for system in "${!SYSTEMS[@]}"; do
  url=$(asset_url "${SYSTEMS[$system]}")
  [[ -z "$url" || "$url" == "null" ]] && {
    echo "No AppImage asset found for $system"
    exit 1
  }
  hash=$(prefetch "$url")
  sources=$(jq -n --arg sys "$system" --arg url "$url" --arg hash "$hash" --argjson src "$sources" \
    '$src + {($sys): {url: $url, hash: $hash}}')
done

jq -n --arg version "$VERSION" --argjson sources "$sources" \
  '{version: $version, sources: $sources}' > sources.json

echo "Updated Helium Browser to $VERSION"
