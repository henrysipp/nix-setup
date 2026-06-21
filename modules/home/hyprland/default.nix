{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
in {
  imports = lib.optionals cfg.enable [
    ./autostart.nix
    ./binds.nix
    ./cursor.nix
    ./media-binds.nix
    ./ghostty.nix
    ./looknfeel.nix
    ./vars.nix
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = lib.mkIf cfg.enable {
    enable = true;
    configType = "lua";
  };
}
