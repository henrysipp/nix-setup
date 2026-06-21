{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
in {
  imports = lib.optionals cfg.enable [
    ../ghostty.nix
    ../quickshell
    ./autostart.nix
    ./binds.nix
    ./cursor.nix
    ./input.nix
    ./looknfeel.nix
    ./polkit.nix
    ./vars.nix
    ./wallpaper.nix
    ./windows.nix
  ];

  wayland.windowManager.hyprland = lib.mkIf cfg.enable {
    enable = true;
    configType = "lua";
  };
}
