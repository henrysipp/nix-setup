{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
  wallpaperPath = "${config.home.homeDirectory}/Pictures/Wallpapers/F01_Mac.png";
in {
  services.hyprpaper = lib.mkIf cfg.enable {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = wallpaperPath;
          fit_mode = "cover";
        }
      ];
    };
  };
}
