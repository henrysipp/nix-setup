{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
  typography = import ../../../lib/quickshell-typography.nix lib;
  restartQuickshell = pkgs.writeShellScript "restart-quickshell" ''
    export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    ${pkgs.systemd}/bin/systemctl --user restart quickshell.service 2>/dev/null || true
  '';
in {
  home.packages = lib.mkIf cfg.enable [pkgs.inter];

  programs.quickshell = lib.mkIf cfg.enable {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."quickshell/widgets/theme/Typography.qml" = lib.mkIf cfg.enable {
    text = typography.qml;
    onChange = "${restartQuickshell}";
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
    $DRY_RUN_CMD ${restartQuickshell}
  '';
}
