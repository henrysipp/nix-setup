# TODO

## Open

- Debug GNOME Settings fingerprint panel missing on FW13 (check gnome-control-center fprint support, device enumeration, and required packages like usbutils/binutils).
- Decide when to migrate remaining legacy `profiles/` modules fully into `modules/nixos/` instead of keeping them as transitional sources.

## Updates

- <date>: <update>
- 2026-03-17: Added gnome-control-center libfprint overlay; need to confirm GNOME Users fingerprint section appears after rebuild/reboot.
- 2026-03-17: Stock `/run/current-system/sw/bin/gnome-control-center` has no `libfprint` references after reverting the overlay; `fprintd` still runs normally.
- 2026-03-17: Added `services.desktopManager.gnome.sessionPath = [ pkgs.gdm ];` to test a reported GNOME fingerprint UI fix; `input` group was already present for `henrysipp`.
