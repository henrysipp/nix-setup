# Mistakes

## Entry Template

## YYYY-MM-DD HH:mm

Context: <task or feature>
Type: mistake
Event: <what happened>
Action: <what changed / fix applied>
Rule: <one-line future behavior>
Root cause: <why it happened>
Fix applied: <what was changed>
Prevention rule: <how to avoid recurrence>

## 2026-03-17 00:00
Context: Codex overlay packaging
Type: mistake
Event: Used a license identifier not present in the pinned nixpkgs set, causing evaluation failure.
Action: Switched to `licenses.asl20` in the Codex overlay metadata.
Rule: Use widely available license identifiers (e.g., `licenses.asl20`) to avoid nixpkgs-version mismatches.
Root cause: Assumed `licenses.apache2` existed in the pinned nixpkgs without verifying.
Fix applied: Updated `overlays/default.nix` to use `licenses.asl20`.
Prevention rule: Prefer stable license names and check nixpkgs license set when unsure.

## 2026-03-18 17:28
Context: Berkeley Mono activation
Type: mistake
Event: Wired the entire `modules/system` bundle into the active NixOS graph when only the Berkeley Mono font needed to be enabled.
Action: Changed the import to include only `../system/berkeley-mono` from `modules/nixos/default.nix`.
Rule: Keep standalone assets like fonts imported separately from opinionated desktop stacks such as Omarchy.
Root cause: Reused the existing `modules/system/default.nix` bundle without accounting for the Omarchy dependency it also activates.
Fix applied: Replaced the bundle import with a direct Berkeley Mono module import and kept Omarchy inactive.
Prevention rule: Inspect bundle modules before wiring them into the main host assembly, especially when they mix packaging with desktop environment configuration.
