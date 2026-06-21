{lib, ...}: let
  h = import ../../../lib/hyprland.nix {inherit lib;};
in {
  wayland.windowManager.hyprland.settings = h.vars {
    browser = "firefox";
    fileManager = "dolphin";
    passwordManager = "1password";
  };
}
