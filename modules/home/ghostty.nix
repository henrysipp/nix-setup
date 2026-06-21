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
      "font-size" = 5.5;
      "async-backend" = "epoll";
    };
  };
}
