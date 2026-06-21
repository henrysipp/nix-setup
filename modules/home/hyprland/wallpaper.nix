{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
  stylixLib = import ../../../lib/stylix.nix {inherit lib;};
  wallpaper = stylixLib.wallpaper;
  wallpaperPath = "${config.home.homeDirectory}/Pictures/Wallpapers/${stylixLib.theme}/${wallpaper.name}";
in {
  services.hyprpaper = lib.mkIf (cfg.enable && wallpaper != null) {
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
