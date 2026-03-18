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
