{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
in {
  home.pointerCursor = lib.mkIf cfg.enable {
    package = pkgs.adwaita-hyprcursor;
    name = "Adwaita";
    size = 24;

    gtk.enable = true;
    hyprcursor.enable = true;
  };
}
