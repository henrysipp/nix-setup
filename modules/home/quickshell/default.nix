{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
in {
  programs.quickshell = lib.mkIf cfg.enable {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."quickshell/shell.qml" = lib.mkIf cfg.enable {
    source = ./shell.qml;
  };

  xdg.configFile."quickshell/widgets" = lib.mkIf cfg.enable {
    source = ./widgets;
    recursive = true;
  };

  # HM updates the store symlink but quickshell won't hot-reload that swap.
  home.activation.restartQuickshell = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD systemctl --user try-restart quickshell.service 2>/dev/null || true
  '';
}
