{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
in {
  programs.ghostty = lib.mkIf cfg.enable {
    enable = true;
    settings = {
      "font-family" = "Berkeley Mono";
      "font-style" = "Regular";
      # Hyprland monitor scale (2x) is applied again by Ghostty's GTK font scaling,
      # so configured size should be roughly half the desired point size.
      "font-size" = 14;
      "window-padding-x" = 8;
      "window-padding-y" = 8;
      "async-backend" = "epoll";
      # Hyprland remaps SUPER+C/V/X to CTRL+C/V/X (see hyprland/binds.nix).
      # Ghostty defaults to ctrl+shift+c/v on Linux, so wire up the remapped keys.
      keybind = [
        "ctrl+c=copy_to_clipboard"
        "performable:ctrl+v=paste_from_clipboard"
      ];
    };
  };
}
