{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
in {
  services.hyprpolkitagent = lib.mkIf cfg.enable {
    enable = true;
  };
}
