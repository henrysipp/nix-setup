{lib, ...}: let
  h = import ../../../lib/hyprland.nix {inherit lib;};
in {
  # Home Manager turns hyphenated keys like exec-once into invalid Lua
  # (hl.exec-once is parsed as subtraction). Use event hooks instead.
  wayland.windowManager.hyprland.settings.on = [
    (h.onExec "hyprland.start" "systemctl --user start hyprpolkitagent")
  ];
}
