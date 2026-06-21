{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  stylixLib = import ../../lib/stylix.nix {inherit lib;};
  cfg = config.hokum.desktop.hyprland;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = false;
      base16Scheme = stylixLib.schemePath pkgs;
      polarity = stylixLib.polarity;
      image = lib.mkIf (stylixLib.wallpaper != null) stylixLib.wallpaper.path;

      targets = {
        gtk.enable = true;
        qt.enable = true;
      };
    };
  };
}
