# Resolved desktop theme for home-manager modules.
{
  config,
  osConfig,
  lib,
  ...
}: let
  stylixLib = import ../../lib/stylix.nix {inherit lib;};
in {
  options.hokum.theme = lib.mkOption {
    type = lib.types.attrs;
    internal = true;
    description = "Resolved desktop theme (catalog entry, Stylix colors, wallpaper).";
  };

  config.hokum.theme = {
    id = stylixLib.theme;
    scheme = stylixLib.scheme;
    polarity = stylixLib.polarity;
    isDark = stylixLib.polarity == "dark";
    colors = config.lib.stylix.colors;
    wallpaper = stylixLib.wallpaper;
  };
}
